Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300804271244y437c69l62591120552209a7@mail.gmail.com>
Date: Sun, 27 Apr 2008 13:44:13 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <782ce16c0804270751g3007607fy127ed8b207fc56ba@mail.gmail.com>
MIME-Version: 1.0
References: <782ce16c0804270751g3007607fy127ed8b207fc56ba@mail.gmail.com>
Subject: Re: [Bluez-devel] GSoC Project - Integration of Bluetooth Audio
	with PulseAudio
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Jo=E3o

I'm really excited to have you helping on this. It'll be a great
project for your gsoc experience.

>  I'm not pretty sure about how the integration is going to happen. One
>  idea is to implement two modules in PA, a BT sink (playback) and
>  source (record). Also, there will be a need to something on PA to
>  detect BT devices, similar to the module-detect-hal of PA.

My impression looking at the existing modules is there would be one
main file to deal with enumeration, switching, etc. The modules tend
to be broken out for the different protocols when they are
implementation details. So it might look something like

module-bt.c
module-bt-protocol-sco.c
module-bt-protocol-a2dp.c

A good start is setting up a main pulse module and getting d-bus calls
to the bluez services working to see audio device lists in pulse.

Anyway, a lot of the tricky details will be pulse things, so the
mailing list for pulse is useful too.

-- =

Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
