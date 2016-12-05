Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1480941313.14634.11.camel@hadess.net>
Subject: Re: "ChromeLinux" HCI name, and Alias
From: Bastien Nocera <hadess@hadess.net>
To: =?ISO-8859-1?Q?Fran=E7ois?= Beaufort <beaufort.francois@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Mon, 05 Dec 2016 13:35:13 +0100
In-Reply-To: <CAEZxfGOuROZyamCfqkbQFvPtfm3N8fBH0_+PcTs3_2i+KH2dxg@mail.gmail.com>
References: <1480695827.14634.1.camel@hadess.net>
         <CAEZxfGOuROZyamCfqkbQFvPtfm3N8fBH0_+PcTs3_2i+KH2dxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2016-12-05 at 13:25 +0100, François Beaufort wrote:
> I believe you use an "old" build of Chrome. If you update to recent
> version, this issue won't happen.
> As you can see at
> https://chromium.googlesource.com/chromium/src/+/c8901b4dbb6518940e94
> 0213c1f94774fc04d5aa,
> I've fixed this 8 months ago.

And it seems that the fix only became available a couple of days ago in
Google Chrome 55, which reached the stable channel.

> On Fri, Dec 2, 2016 at 5:23 PM, Bastien Nocera <hadess@hadess.net>
> wrote:
> > Hey,
> > 
> > Using bluez 5.43 on Fedora 25, I get:
> > 
> > $ hciconfig hci0 name | grep Name
> >         Name: 'ChromeLinux_900A'
> > 
> > When the PrettyHostname is:
> > $ grep PRETTY /etc/machine-info
> > PRETTY_HOSTNAME=classic
> > 
> > I grepped through a bunch of things, including the firmware, the
> > kernel
> > sources, and bluez, but couldn't find the source of this name.
> > 
> > I'm also fairly certain that the hostname plugin doesn't work, as
> > it's
> > trying to talk to services which wouldn't be started yet. Is there
> > any
> > reason why this code can't poke /etc/machine-info directly?
> > 
> > Cheers
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
