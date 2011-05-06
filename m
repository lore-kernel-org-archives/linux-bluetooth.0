Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC][PATCH 0/4] Allow hexadecimal encoded pins
From: Bastien Nocera <hadess@hadess.net>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Daniele Forsi <dforsi@gmail.com>, linux-bluetooth@vger.kernel.org,
	johan.hedberg@gmail.com
Date: Fri, 06 May 2011 02:37:27 +0100
In-Reply-To: <BANLkTingDa5rTU3YAQStB15CFFeiWNMXhQ@mail.gmail.com>
References: <1302455477-27664-1-git-send-email-dh.herrmann@googlemail.com>
	 <1304379171.13362.41.camel@novo.hadess.net>
	 <BANLkTimkpKpGTuTmFdYyjm4Ok_+pwho-aA@mail.gmail.com>
	 <BANLkTinarShNUkchPANmFfF7j54Sw_-FCQ@mail.gmail.com>
	 <BANLkTingDa5rTU3YAQStB15CFFeiWNMXhQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1304645853.16101.31.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2011-05-03 at 20:28 +0200, David Herrmann wrote:
> On Tue, May 3, 2011 at 2:27 PM, Daniele Forsi <dforsi@gmail.com> wrote:
> > one issue when using the 1+2 way is that the Wiimote will forget the
> > pairing when it is turned off while the PC will remember it, so the
> > Wiimote won't be shown in the list of found devices and you need to
> > delete it before you can pair again
> 
> I don't get this. If the wiimote is listed as paired, why would you
> want to see it in the list of found devices? The wiimote is already
> listed as paired so simply reestablish the pairing by connecting to
> the wiimote via DBus bluez.Input api.

If the Wiimote is already paired, it won't appear in the "discoverable
and not already setup" devices list in the wizard.

But your point is correct.

> >>> Is there any way to detect which "type" of pairing is made with the
> >>> Wiimote, eg. you say that button 1+2 will only work for temporary
> >>> connections. Can we detect this? Would pairing anyway work?
> >>
> >> I guess you mean that you wanna predict which PIN to use? No, I
> >> currently know no way to detect this. However, one may try the first
> >> pin and if that fails the second pin.
> >
> > I think this is what the Wii does when in the "home" screen where you
> > are supposed to press 1+2 because it will find the remote also when
> > pressing the sync button (I have a Wiimote that I need to pair from
> > the home screen pressing sync because it doesn't wake up with 1+2)
> 
> With 1+2 buttons only the dest-address works as PIN (I checked this). However,
> with "sync" button both addresses may work. I will check this later...
> Anyway, this would simplify the wiimote handling significantly.

Either way, I think I'd do the work so that the "proper" pairing can be
done, and add a warning at the end of a failed pairing process for a
Wiimote if pairing failed, mentioning which way you should press the
buttons to have it always paired.

I'll get on that as soon as your patches make it into bluez master
proper.

Cheers

