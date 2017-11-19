Return-Path: <johan.hedberg@gmail.com>
Date: Sun, 19 Nov 2017 22:43:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh+dt@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	linux-serial@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
	linux-sunxi@googlegroups.com, linux-amlogic@lists.infradead.org,
	Larry.Finger@lwfinger.net
Subject: Re: [RFC v1 7/8] Bluetooth: hci_serdev: remove the
 HCI_UART_INIT_PENDING check
Message-ID: <20171119204325.GA24345@x1c.home>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
 <20171117223543.32429-8-martin.blumenstingl@googlemail.com>
 <56889A64-AFB2-454C-9889-FAA4C051168A@holtmann.org>
 <CAFBinCC_G845v4cZW9hvwYEDQhTCLW1iG_JWzAz9Gu42rM4_Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFBinCC_G845v4cZW9hvwYEDQhTCLW1iG_JWzAz9Gu42rM4_Zg@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Sun, Nov 19, 2017, Martin Blumenstingl wrote:
> >> @@ -333,9 +333,6 @@ int hci_uart_register_device(struct hci_uart *hu,
> >>       else
> >>               hdev->dev_type = HCI_PRIMARY;
> >>
> >> -     if (test_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
> >> -             return 0;
> >> -
> >
> > then lets also remove the flag definition itself. Or if that is
> > still needed for some legacy operation, then describe this. For
> > example I also see it used in hci_serdev.c and main question would
> > be if it is used there as well or some legacy cruft.
> 
> this flag is still used in hci_ldisc.c (if that's what you mean
> instead of hci_serdev.c):
> as far as I understand the code it's used to postpone the
> hci_register_dev() call until the sync response is received
> 
> Johan Hedberg added this code in 9f2aee848fe6 ("Bluetooth: Add delayed
> init sequence support for UART controllers") - it would be great if he
> could comment on this (he is CC'ed on this mail)

That patch is over five years old, so don't count on me remembering the
details ;)  That said, your analysis of its use sounds correct. It's
possible however that we've since then given HCI drivers other
capabilities that would make the INIT_PENDING flag redundant. E.g. the
setup callback didn't exist at the time that I wrote the patch.

Johan
