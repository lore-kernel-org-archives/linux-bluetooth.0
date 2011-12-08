Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Dec 2011 10:32:02 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Process Read Local AMP Info in hciemu
Message-ID: <20111208083200.GB28028@aemeltch-MOBL1>
References: <1323263005-20552-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1323331911.1965.6.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323331911.1965.6.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Dec 08, 2011 at 10:11:51AM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Add processing of Read Local AMP Info in hciemu, the values returned are
> > used to emulate AMP HCI.
> > ---
> >  test/hciemu.c |   34 ++++++++++++++++++++++++++++++++++
> >  1 files changed, 34 insertions(+), 0 deletions(-)
> > 
> > diff --git a/test/hciemu.c b/test/hciemu.c
> > index 38918f5..1022eb5 100644
> > --- a/test/hciemu.c
> > +++ b/test/hciemu.c
> > @@ -44,6 +44,7 @@
> >  #include <bluetooth/bluetooth.h>
> >  #include <bluetooth/hci.h>
> >  #include <bluetooth/hci_lib.h>
> > +#include <bluetooth/l2cap.h>
> >  
> >  #define VHCI_DEV		"/dev/vhci"
> >  
> > @@ -777,6 +778,35 @@ static void hci_info_param(uint16_t ocf, int plen, uint8_t *data)
> >  		break;
> >  	}
> >  }
> > +static void hci_status_param(uint16_t ocf, int plen, uint8_t *data)
> > +{
> > +	read_local_amp_info_rp ai;
> > +	uint8_t status;
> > +
> > +	const uint16_t ogf = OGF_STATUS_PARAM;
> > +
> > +	switch (ocf) {
> > +		case OCF_READ_LOCAL_AMP_INFO:
> 
> one too many indentation here.

will fix this. BTW: What do you think about current approach that in this
test tool I always reply for this AMP-specific command. Shall we have
command-line parameter for controller type?

Best regards 
Andrei Emeltchenko 
