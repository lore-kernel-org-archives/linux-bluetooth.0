Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Remove device OOB data if it was discovered in band
Date: Mon, 19 Nov 2012 16:17:43 +0100
Message-ID: <2151735.anmcCOIMjp@uw000953>
In-Reply-To: <20121119150537.GA10702@x220>
References: <1353336407-10863-1-git-send-email-szymon.janc@tieto.com> <20121119150537.GA10702@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 19 of November 2012 17:05:37 Johan Hedberg wrote:
> Hi Szymon,

Hi Johan,

> 
> On Mon, Nov 19, 2012, Szymon Janc wrote:
> > OOB authentication mechanism should be used only if pairing process
> > has been activated by previous OOB information exchange (Core Spec
> > 4.0 , vol. 1, Part A, 5.1.4.3). Stored OOB data for specific device
> > should be removed if that device was discovered in band later on.
> > 
> > Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> > ---
> > 
> > This could also be done by userspace but would require calling remove remote
> > OOB data mgmt command for every device found. Userspace could also track for
> > which devices OOB data were added but this could be problematic as OOB data
> > persists userspace restart. Doing it in kernel seems better.
> > 
> > 
> >  net/bluetooth/hci_event.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 9f5c5f2..cda5bac 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -1946,6 +1946,8 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
> >  	for (; num_rsp; num_rsp--, info++) {
> >  		bool name_known, ssp;
> >  
> > +		hci_remove_remote_oob_data(hdev, &info->bdaddr);
> > +
> >  		bacpy(&data.bdaddr, &info->bdaddr);
> >  		data.pscan_rep_mode	= info->pscan_rep_mode;
> >  		data.pscan_period_mode	= info->pscan_period_mode;
> 
> Why would you do this only in hci_inquiry_result_evt? What about
> hci_extended_inquiry_result_evt and hci_inquiry_result_with_rssi_evt?
> Maybe hci_inquiry_cache_update would be a better function to put this
> into.

Yes, I guess hci_inquiry_cache_update will be the right place to put this.
Will send V2. 

Thx!

> Johan

-- 
BR
Szymon Janc
