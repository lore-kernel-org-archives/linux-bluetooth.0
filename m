Return-Path: <johan.hedberg@gmail.com>
Date: Mon, 30 Nov 2015 12:51:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fran=E7ois?= Beaufort <beaufort.francois@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Szymon Janc <szymon.janc@codecoup.pl>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Unknown Connection Identifier
Message-ID: <20151130105141.GA12764@t440s.lan>
References: <CAEZxfGPTxwUZzU+3XSV-uiN+DMz+hyOKiiZfgF+oD6pp=-XiOA@mail.gmail.com>
 <AAC95ACC-36E4-4618-8F49-53F78AE93AA6@holtmann.org>
 <2045332.GytFuFKTvp@ix>
 <CAEZxfGOdyZat1evKm0Jfwg=knuigGdfK_wVqS8NG=zFAY3aRXg@mail.gmail.com>
 <2DBBB005-93A7-47ED-8E88-1D6B92ACCC07@holtmann.org>
 <CAEZxfGOJK00YMX+_Kpde9kv38XB9q+EvXYoEF4ic94VWZEhZKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAEZxfGOJK00YMX+_Kpde9kv38XB9q+EvXYoEF4ic94VWZEhZKg@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi François,

On Mon, Nov 30, 2015, François Beaufort wrote:
> >> < HCI Command: LE Create Connection (0x08|0x000d) plen 25
> >>               [hci0] 15.669171
> >>        Scan interval: 60.000 msec (0x0060)
> >>        Scan window: 30.000 msec (0x0030)
> >
> > we might should have the LE Create Connection scan with a full duty
> > cycle here. So it does not miss any advertising PDUs.
> 
> Is this something the Linux Bluetooth team is going to address?

I think this alone might fix the issue you're seeing. Could you please
try the patch I just sent and see if it solves the issue for you:

  Bluetooth: Use continuous scanning when creating LE connections

Johan
