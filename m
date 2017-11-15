Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 15 Nov 2017 16:09:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: John Klug <ski.brimson@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Security block and Bluez 5.47
Message-ID: <20171115140910.GA19963@x1c.lan>
References: <CADU0VqyM081pHYtNWTxM+ajg-f2-jcs=F_5wCnV5L2_mOQ_TvQ@mail.gmail.com>
 <CABBYNZJKYniLeC3oGn7QgDyVN27VzjY2g=oeauHkQGSqAUfK+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZJKYniLeC3oGn7QgDyVN27VzjY2g=oeauHkQGSqAUfK+w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Nov 15, 2017, Luiz Augusto von Dentz wrote:
> > Frequently when I connect my Android phone to my bluez 5.47 device I
> > see (btmon):
> >
> >  > HCI Event: Number of Completed Packets (0x13) plen 5
> >
> >                                                             #36 [hci0]
> > 5.709020
> >          Num handles: 1
> >          Handle: 1
> >          Count: 1
> >  < ACL Data TX: Handle 1 flags 0x00 dlen 16
> >
> >                                                             #37 [hci0]
> > 5.714589
> >        L2CAP: Connection Response (0x03) ident 4 len 8
> >          Destination CID: 64
> >          Source CID: 81
> >          Result: Connection refused - security block (0x0003)
> >          Status: No further information available (0x0000)
> >
> > This is using connecting from Android 7 to Bluez 5.47.
> 
> I think this might be due to not having a default agent set which is
> needed if the devices is not trusted so it would require agent
> authorization.

It could also be the USB HCI race between ACL data and HCI events. It's
hard to say for sure though since the complete HCI log was not provided.

Johan
