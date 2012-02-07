Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Feb 2012 11:23:43 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix device reset
Message-ID: <20120207092337.GA5683@aemeltch-MOBL1>
References: <1328536743-8343-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120206152113.GA12729@x220>
 <1328554926.2062.84.camel@aeonflux>
 <CAMXE1-rSmSVvYyRjLo2pZWLfFF+QWh-1pTz--+uNstLHR367aQ@mail.gmail.com>
 <1328557131.2062.85.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328557131.2062.85.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Feb 06, 2012 at 11:38:51AM -0800, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > > > > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > > >
> > > > >
> > > > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > > > ---
> > > > >  net/bluetooth/hci_core.c |    2 +-
> > > > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > > >
> > > > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > > > index e77cc79..3f30714 100644
> > > > > --- a/net/bluetooth/hci_core.c
> > > > > +++ b/net/bluetooth/hci_core.c
> > > > > @@ -822,7 +822,7 @@ static int hci_dev_do_close(struct hci_dev
> > *hdev)
> > > > >     skb_queue_purge(&hdev->cmd_q);
> > > > >     atomic_set(&hdev->cmd_cnt, 1);
> > > > >     if (!test_bit(HCI_RAW, &hdev->flags) &&
> > > > > -                           test_bit(HCI_QUIRK_NO_RESET,
> > &hdev->quirks)) {
> > > > > +                   !test_bit(HCI_QUIRK_NO_RESET,
> > &hdev->quirks)) {
> > > > >             set_bit(HCI_INIT, &hdev->flags);
> > > > >             __hci_request(hdev, hci_reset_req, 0,
> > > > >                                     msecs_to_jiffies(250));
> > > >
> > > > Nack. The NO_RESET quirk is supposed to prevent reset during the
> > device
> > > > init sequence. The purpose of the test in hci_dev_do_close() is to
> > let
> > > > the reset be done there instead.
> > >
> > > we might wanna rename this into HCI_QUIRK_RESET_ON_CLOSE. Otherwise
> > > people keep in getting confused.
> > >
> > 
> > Moreover without my patch my USB dongle gets stuck after reset.
> 
> please send hcidump traces for this. And you mean hciconfig hci0 reset?

In the trace there is only one line:

< HCI Command: Reset (0x03|0x0003) plen 0

Then chip stuck (I am testing this inside virtual machine).

I have A-Link BCM USB dongle.

Best regards 
Andrei Emeltchenko 
> 
