Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45F08496.8000806@wershofen.de>
Date: Thu, 08 Mar 2007 22:48:06 +0100
From: Wolfgang Wershofen <wolfgang@wershofen.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>,
        twinklephone@yahoogroups.com
Subject: [Bluez-users] headsetd(plugz) vs. btsco - My experiences with BT
	telephony
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

I'm using a bluetooth headset for telephony since about one month now
and like to share my experiences with those interested.

As I said, I use the headset purely for telephony and I managed to
completely replace my "normal" phone with my PC but it has been a long way.

I'm running on 64-bit OpenSuSE 10.2 with kernel 2.6.18. bluez-libs and
bluez-utils is at 3.7, alsa at 1.0.13.
I got bluetooth-alsa from CVS on Feb, 6th and installed it as described.
My Dongle is a Level-One MDU-0005 (CSR chipset) and the headset is a
JABRA BT-200. I also previously used a B-Speech Vitac Headset/Dongle
bundle and a Belkin dongle but none of them was working 100% with bluez.
So it seems still to be true, that one should look out for CSR-chipset
equiped hardware to run bluetooth under Linux.

My telephony setup is based on Asterisk running on the same machine
connected via a Fritzcard ISDN PCI card to the public network and I'm
using twinkle as softphone. This setup works perfect when using cabled
earphones and micro on the interal (Intel) soundcard, but I'd like to
keep my desktop free from cables - the mess on it is yet enough without
them ;-)

The first few days after I managed to get bluetooth basically working, I
decided to use the headsetd daemon instead of btsco because I
experienced serious delays with the latter.

With headsetd, I was able to hear and speak without problems on most
phone calls, but I also received complaints about a deafening loud white
noise on the far end of the line after the call was established. I
managed to reproduce this once or twice with another phone in my house,
but I have no clue what is causing this noise. It's absolutely
unpredictable and occurs randomly. Has anyone encountered this problem,
too? If so, I'd like to know about it and what may be done to prevent
this. Any idea?

As I didn't want to bother my colleagues and friends with loud white
noise, I soon switched to btsco and the kernel module snd_bt_sco. With
this, you have two options to choose from: Either use the OSS device
/dev/dsp1 or the corresponding ALSA device (in my case: plughw:1,0 BT
headset (BT SCO PCM))
With both of them, there are issues with access rights at least with
opensuse. To use /dev/dsp1, I have to chmod it to 666, but then I still
can't run btsco as normal user. To achieve this, I also have to 666 the
newly created devices in /dev/snd after loading snd_bt_sco.

As mentioned earlier, I encountered delays when using btsco. When I
receive a call, then my voice is heard noticably later than I talk and
this leads to some confusion. The effect is unbearable when using
/dev/dsp1 (delay well over one second) and almost gone when using the
ALSA-device. On outgoing calls, I never had any delay - one this I still
don't understand...

So, using the kernel module snd_bt_sco with btsco and the corresponding
ALSA device for me is the configuration, that works. I never encountered
that loud white noise anymore since I switched to btsco and the delay
with the ALSA-device is absolutely tolerable. In addition, btsco allows
me to use the headset buttons to receive and end a call.

I still have to write some startup scripts to get everything working
without manual intervention, but basically all is working well. Maybe a
wrapper script for btsco would be neccessary to check, if btsco is up
and running and restart it, if not. Sometimes, btsco looses the channel
and then silently dies. twinkle doesn't recognize a missing connection
to the headset and I then get a connected phone call without being able
to hear or talk to the other end. :-(

So far for my experiences. I hope this will be helpful for others. I'd
be glad to receive some feedback and/or hints for improvements. Thx for
your time.


cu
Wolfgang



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFF8ISWgUafbxFH+p8RAmlbAJ4mDnQXpI7cbsRgLxBOL9im9EI1mQCdFHHm
B4wjHgFXX4jdAjdwpoZyXt4=
=Xdlf
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
