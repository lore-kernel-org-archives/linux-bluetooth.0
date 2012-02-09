Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Feb 2012 16:25:09 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix device reset
Message-ID: <20120209142508.GB22374@aemeltch-MOBL1>
References: <1328536743-8343-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120206152113.GA12729@x220>
 <1328554926.2062.84.camel@aeonflux>
 <CAMXE1-rSmSVvYyRjLo2pZWLfFF+QWh-1pTz--+uNstLHR367aQ@mail.gmail.com>
 <1328557131.2062.85.camel@aeonflux>
 <20120207092337.GA5683@aemeltch-MOBL1>
 <1328795471.28848.19.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328795471.28848.19.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Feb 09, 2012 at 02:51:11PM +0100, Marcel Holtmann wrote:
> > > > > > >     if (!test_bit(HCI_RAW, &hdev->flags) &&
> > > > > > > -                           test_bit(HCI_QUIRK_NO_RESET,
> > > > &hdev->quirks)) {
> > > > > > > +                   !test_bit(HCI_QUIRK_NO_RESET,
> > > > &hdev->quirks)) {
> > > > > > Nack. The NO_RESET quirk is supposed to prevent reset during the
> > > > device
> > > > > > init sequence. The purpose of the test in hci_dev_do_close() is to
> > > > let
> > > > > > the reset be done there instead.
> > > > >
> > > > > we might wanna rename this into HCI_QUIRK_RESET_ON_CLOSE. Otherwise
> > > > > people keep in getting confused.
> > > > >
> > > > 
> > > > Moreover without my patch my USB dongle gets stuck after reset.
> > > 
> > > please send hcidump traces for this. And you mean hciconfig hci0 reset?
> > 
> > In the trace there is only one line:
> > 
> > < HCI Command: Reset (0x03|0x0003) plen 0
> > 
> > Then chip stuck (I am testing this inside virtual machine).
> > 
> > I have A-Link BCM USB dongle.
> 
> the patch in general is correct, but it seems that it has some side
> effects on some dongles. Can you try doing hciconfig hci0 reset versus a
> hciconfig hci0 down + hciconfig hci0 up and if it makes any difference.

I was testing for some time and I think now with Johan's patch reverted it
only a little bit better. I was testing with hciconfig hci0 down +
hciconfig hci0 up and with hciconfig hci0 reset and at some point dongle
gets stuck in my virtualbox either way. This is very unstable and probably
related to timing.

Has anybody else experienced the same problem?

Best regards 
Andrei Emeltchenko 
