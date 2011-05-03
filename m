Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTimkpKpGTuTmFdYyjm4Ok_+pwho-aA@mail.gmail.com>
References: <1302455477-27664-1-git-send-email-dh.herrmann@googlemail.com>
	<1304379171.13362.41.camel@novo.hadess.net>
	<BANLkTimkpKpGTuTmFdYyjm4Ok_+pwho-aA@mail.gmail.com>
Date: Tue, 3 May 2011 14:27:38 +0200
Message-ID: <BANLkTinarShNUkchPANmFfF7j54Sw_-FCQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] Allow hexadecimal encoded pins
From: Daniele Forsi <dforsi@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Bastien Nocera <hadess@hadess.net>,
	linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2011/5/3 David Herrmann:
> On Tue, May 3, 2011 at 1:32 AM, Bastien Nocera wrote:
>> What are the necessary changes to be made in gnome-bluetooth?
>>
>> I'm guessing that we should add a "WIIMOTE" type of special casing in
>> the pin database, and pass the adapter address as per the above when a
>> PIN is requested.
>
> Exactly. If I click on PIN-type in gnome-bluetooth applet, then there
> are already several choices I can make. I'd recommend adding a new one
> with "use source address as PIN" and one with "use destination address
> as PIN".

yeah, automatically shown only when the selected device is a Wiimote

one issue when using the 1+2 way is that the Wiimote will forget the
pairing when it is turned off while the PC will remember it, so the
Wiimote won't be shown in the list of found devices and you need to
delete it before you can pair again

>> Is there any way to detect which "type" of pairing is made with the
>> Wiimote, eg. you say that button 1+2 will only work for temporary
>> connections. Can we detect this? Would pairing anyway work?
>
> I guess you mean that you wanna predict which PIN to use? No, I
> currently know no way to detect this. However, one may try the first
> pin and if that fails the second pin.

I think this is what the Wii does when in the "home" screen where you
are supposed to press 1+2 because it will find the remote also when
pressing the sync button (I have a Wiimote that I need to pair from
the home screen pressing sync because it doesn't wake up with 1+2)

-- 
Daniele Forsi
