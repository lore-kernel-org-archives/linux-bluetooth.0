Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 06/13] android/handsfree: Add SDP record for AG
Date: Wed, 05 Feb 2014 10:10:47 +0100
Message-ID: <5438901.ZCZpRK0Ve0@uw000953>
In-Reply-To: <20140203075616.GB2930@aemeltch-MOBL1>
References: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com> <1391375364-27106-7-git-send-email-szymon.janc@tieto.com> <20140203075616.GB2930@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Monday 03 of February 2014 09:56:18 Andrei Emeltchenko wrote:
> Hi Szymon,
> 
> On Sun, Feb 02, 2014 at 10:09:17PM +0100, Szymon Janc wrote:
> > Service Name: Hands-Free Audio GatewayService RecHandle: 0x10001
> > Service Class ID List:
> >   "Handsfree Audio Gateway" (0x111f)
> >   "Generic Audio" (0x1203)
> > Protocol Descriptor List:
> >   "L2CAP" (0x0100)
> >   "RFCOMM" (0x0003)
> >     Channel: 13
> > Profile Descriptor List:
> >   "Handsfree" (0x111e)
> >     Version: 0x0106
> > ---
> >  android/handsfree.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> > 
> > diff --git a/android/handsfree.c b/android/handsfree.c
> > index 3c0d52b..d2dc543 100644
> > --- a/android/handsfree.c
> > +++ b/android/handsfree.c
> > @@ -29,12 +29,19 @@
> >  #include <glib.h>
> >  
> >  #include "lib/bluetooth.h"
> > +#include "lib/sdp.h"
> > +#include "lib/sdp_lib.h"
> >  #include "handsfree.h"
> > +#include "bluetooth.h"
> >  #include "src/log.h"
> >  #include "hal-msg.h"
> >  #include "ipc.h"
> >  
> > +#define HFP_AG_CHANNEL 13
> > +#define HFP_AG_FEATURES 0
> > +
> >  static bdaddr_t adapter_addr;
> > +static uint32_t record_id = 0;
> >  
> >  static void handle_connect(const void *buf, uint16_t len)
> >  {
> > @@ -189,12 +196,99 @@ static const struct ipc_handler cmd_handlers[] = {
> >  			sizeof(struct hal_cmd_handsfree_phone_state_change)},
> >  };
> >  
> > +static sdp_record_t *handsfree_ag_record(void)
> > +{
> > +	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> > +	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
> > +	uuid_t l2cap_uuid, rfcomm_uuid;
> > +	sdp_profile_desc_t profile;
> > +	sdp_list_t *aproto, *proto[2];
> > +	sdp_record_t *record;
> > +	sdp_data_t *channel, *features;
> > +	uint8_t netid = 0x01;
> > +	uint16_t sdpfeat;
> > +	sdp_data_t *network;
> > +	uint8_t ch = HFP_AG_CHANNEL;
> > +
> > +	record = sdp_record_alloc();
> > +	if (!record)
> > +		return NULL;
> > +
> > +	network = sdp_data_alloc(SDP_UINT8, &netid);
> > +	if (!network) {
> > +		sdp_record_free(record);
> > +		return NULL;
> > +	}
> > +
> > +	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> > +	root = sdp_list_append(0, &root_uuid);
> > +	sdp_set_browse_groups(record, root);
> > +
> > +	sdp_uuid16_create(&svclass_uuid, HANDSFREE_AGW_SVCLASS_ID);
> > +	svclass_id = sdp_list_append(0, &svclass_uuid);
> > +	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
> > +	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
> > +	sdp_set_service_classes(record, svclass_id);
> > +
> > +	sdp_uuid16_create(&profile.uuid, HANDSFREE_PROFILE_ID);
> > +	profile.version = 0x0106;
> > +	pfseq = sdp_list_append(0, &profile);
> > +	sdp_set_profile_descs(record, pfseq);
> > +
> > +	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
> > +	proto[0] = sdp_list_append(0, &l2cap_uuid);
> > +	apseq = sdp_list_append(0, proto[0]);
> > +
> > +	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
> > +	proto[1] = sdp_list_append(0, &rfcomm_uuid);
> > +	channel = sdp_data_alloc(SDP_UINT8, &ch);
> > +	proto[1] = sdp_list_append(proto[1], channel);
> > +	apseq = sdp_list_append(apseq, proto[1]);
> > +
> > +	sdpfeat = HFP_AG_FEATURES;
> > +	features = sdp_data_alloc(SDP_UINT16, &sdpfeat);
> > +	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
> > +
> > +	aproto = sdp_list_append(0, apseq);
> > +	sdp_set_access_protos(record, aproto);
> > +
> > +	sdp_set_info_attr(record, "Hands-Free Audio Gateway", 0, 0);
> > +
> > +	sdp_attr_add(record, SDP_ATTR_EXTERNAL_NETWORK, network);
> > +
> > +	sdp_data_free(channel);
> > +	sdp_list_free(proto[0], 0);
> 
> We have agreed to use NULL for zero pointers.

I've miss that comment, but this is now fixed by follow-up patch. 

-- 
Best regards, 
Szymon Janc
