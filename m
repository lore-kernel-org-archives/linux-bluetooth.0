Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Headset with snd-bt-sco
Message-ID: <20040513103339.GB4449@gmx.net>
References: <40A2888C.5040805@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40A2888C.5040805@gmx.de>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 13 May 2004 12:33:39 +0200

On  0, Lasse Jansen <l.jansen@gmx.de> wrote:
> Hi all,
> I have some problems with making my BT headset work. Bluetooth works, I
> can e.g. exchange files with my T610. For the Headset I downloaded the
> snd-bt-sco driver (http://www.dcs.gla.ac.uk/~jp/snd-bt-sco/),
> kernel-2.6.4 and alsa-1.0.3 as said in the README. Everything went fine,
> when I run
> | btsco-0.2/btsco 00:0D:FD:00:7B:CC 1
> I hear a little background noise. When I increase/decrease the volume at
> the headset, it will be printed on the screen, so there is a connection.
> 
> But when I try to play a sound file, nothing happens. E.g.
> | aplay -D plughw:Headset /usr/kde/3.2/share/sounds/KDE_Logout_new.wav
> hangs in a loop. Xmms says "couldn't open audio".
> I have deactivated the "loopback" option in the mixer settings.
> 
> Any ideas?

You should contact the maintainer of this module.

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
