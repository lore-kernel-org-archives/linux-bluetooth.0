Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Antonio Ospite <ao2@ao2.it>
Cc: Szymon Janc <szymon.janc@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Veseli Veseljko <veseljko75@gmail.com>
Subject: Re: [RFC 2/2] profiles/input: Add support for SDP fallback for DualShock 3 clones
Date: Mon, 09 Mar 2015 14:37:03 +0100
Message-ID: <1644418.QPL4BBNlRG@uw000953>
In-Reply-To: <20150309122108.1dac140bf6ecff692e3ca165@ao2.it>
References: <1425830910-9549-1-git-send-email-szymon.janc@gmail.com> <1425830910-9549-3-git-send-email-szymon.janc@gmail.com> <20150309122108.1dac140bf6ecff692e3ca165@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Monday 09 of March 2015 12:21:08 Antonio Ospite wrote:
> On Sun,  8 Mar 2015 17:08:30 +0100
> Szymon Janc <szymon.janc@gmail.com> wrote:
> 
> > Some DualShock 3 clones were reported to not provide any SDP record.
> > In such case provide fallback SDP record (based on genuine DS3 record)
> > and retry setting input device channels before disconnecting.
> 
> Hi Szymon,
> 
> I guess this can't be done in the sixaxis plugin, right?

Unfortunately not. There would have to be some sort of callbacks from input
to handle this from plugin. But if you come up with some nice solution I'd
review it gladly :)

Maybe we could modify code to always provide those on USB plug and then never do
reverse SDP when sixaxis device is detected... I'd have to think about that :)

> I have a question, below.
> 
> > ---
> >  profiles/input/server.c | 191 ++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 184 insertions(+), 7 deletions(-)
> > 
> > diff --git a/profiles/input/server.c b/profiles/input/server.c
> > index eb3fcf8..4b7b1e1 100644
> > --- a/profiles/input/server.c
> > +++ b/profiles/input/server.c
> > @@ -35,6 +35,7 @@
> >  #include "lib/bluetooth.h"
> >  #include "lib/sdp.h"
> >  #include "lib/uuid.h"
> > +#include "lib/sdp_lib.h"
> >  
> >  #include "src/log.h"
> >  #include "src/uuid-helper.h"
> > @@ -72,29 +73,205 @@ struct sixaxis_data {
> >  	uint16_t psm;
> >  };
> >  
> > +static sdp_record_t *get_sixaxis_record(struct btd_device *device)
> > +{
> [...]
> > +	uint8_t hid_spec[] = {
> > +		0x05, 0x01, 0x09, 0x04, 0xa1, 0x01, 0xa1, 0x02, 0x85, 0x01,
> > +		0x75, 0x08, 0x95, 0x01, 0x15, 0x00, 0x26, 0xff, 0x00, 0x81,
> > +		0x03, 0x75, 0x01, 0x95, 0x13, 0x15, 0x00, 0x25, 0x01, 0x35,
> > +		0x00, 0x45, 0x01, 0x05, 0x09, 0x19, 0x01, 0x29, 0x13, 0x81,
> > +		0x02, 0x75, 0x01, 0x95, 0x0d, 0x06, 0x00, 0xff, 0x81, 0x03,
> > +		0x15, 0x00, 0x26, 0xff, 0x00, 0x05, 0x01, 0x09, 0x01, 0xa1,
> > +		0x00, 0x75, 0x08, 0x95, 0x04, 0x35, 0x00, 0x46, 0xff, 0x00,
> > +		0x09, 0x30, 0x09, 0x31, 0x09, 0x32, 0x09, 0x35, 0x81, 0x02,
> > +		0xc0, 0x05, 0x01, 0x75, 0x08, 0x95, 0x27, 0x09, 0x01, 0x81,
> > +		0x02, 0x75, 0x08, 0x95, 0x30, 0x09, 0x01, 0x91, 0x02, 0x75,
> > +		0x08, 0x95, 0x30, 0x09, 0x01, 0xb1, 0x02, 0xc0, 0xa1, 0x02,
> > +		0x85, 0x02, 0x75, 0x08, 0x95, 0x30, 0x09, 0x01, 0xb1, 0x02,
> > +		0xc0, 0xa1, 0x02, 0x85, 0xee, 0x75, 0x08, 0x95, 0x30, 0x09,
> > +		0x01, 0xb1, 0x02, 0xc0, 0xa1, 0x02, 0x85, 0xef, 0x75, 0x08,
> > +		0x95, 0x30, 0x09, 0x01, 0xb1, 0x02, 0xc0, 0xc0, 0x00
> > +	};
> 
> As you may know, the kernel overrides the HID report descriptor in the
> hid-sony driver.
> 
> Is the descriptor above only to be considered as the _default_ HID
> report description?
> 
> I ask to confirm that this would not need to be changed in case the
> overriding HID descriptor in hid-sony changed once again.

Those are just copied from genuine DualShock3 SDP record.

> Thanks,
>    Antonio
> 
> 

-- 
Best regards, 
Szymon Janc
