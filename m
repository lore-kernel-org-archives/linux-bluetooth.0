Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <27251cb805011005263325ddce@mail.gmail.com>
From: ajpearce <ajpearceuk@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: rfcomm -> /dev/dsp? (phone as headset)
In-Reply-To: <crtlh0$lg8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <27251cb805010914064780a27a@mail.gmail.com>
	 <200501092323.50090.cijoml@volny.cz> <crtlh0$lg8$1@sea.gmane.org>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 10 Jan 2005 13:26:05 +0000

I can't see many people interested in exactly this, but it would be
useful to make a wireless phone call without buying a wireless phone
or buying expensive VoIP hardware.

Doing the same using a Bluetooth headset is more useful but less
people have these. More people have bluetooth phones than headsets I
believe - because Bluetooth headsets have only been marketed for use
with mobiles and not PCs, landlines, as walkie talkies or anything
else for some strange reason (the world is useless).

You shouldn't have to buy a headset for say, gaming communication with
say, a program like Teamspeak if you already have a bluetooth headset.

And seeing as I need a mic headset I'd like to be able to use the
bluetooth dongle I've already bought and kill 3 birds with one stone.

p.s. using the PC for audio interface is interesting though.


On Mon, 10 Jan 2005 11:30:13 +0100, soraberri <421246@posta.unizar.es> wrote:
> Michal Semler wrote:
> > Dne ne 9. ledna 2005 23:06 jago25_98 / ajpearce napsal(a):
> >
> >>How do I use my phone as a microphone input? It has the "Voice
> >>gateway" bluetooth profile on channel 1, which is bound to
> >>/dev/rfcomm1
> >>
> >>Maybe there's something in the kbluetoothd (KDE) that can help?
> >>
> >>hmm... I see there is the alsa-bluetooth project but I'm not sure how
> >>to use it, and not sure if it will work with my phone.
> >
> >
> > Project you are looking for is:
> >
> > http://www.crazygreek.co.uk/content/chan_bluetooth
> >
> > Michal
> >
> >
> 
> The project you mention is about 'Bluetooth HandsFreeProfile support for
> Asterisk'. Then, you can use the computer as a handsfree device: you
> carry the phone in your briefcase and the laptop in the desk, so you can
>  make/receive calls without speaking to the phone -you speak to the
> laptop.
> A different thing is to use the phone as audio input: in this case you
> want to speak to your phone, but you want the streaming audio to reach
> the computer via bluetooth in order to use VoIP there (for example). So
> you use the phone just like a headset, the difference is that you have
> to hold it by hand instead of hook it in the ear. This way, all you need
> in the Linux point is Bluez and btsco (bluetooth-alsa) in order to have
> AudioGateway support. The problem is what you need in the phone end: I
> think at least Symbian, and the possibility to "read/write" from/to the
> phone audio device and implement the headset profile.
> 
> Do you think is it possible? Has it been managed anywhere?
> I guess many people wouldn't like the idea at all...
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
