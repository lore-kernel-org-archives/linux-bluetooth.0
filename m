Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45DAC336.1080806@wershofen.de>
Date: Tue, 20 Feb 2007 10:45:26 +0100
From: Wolfgang Wershofen <wolfgang@wershofen.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] plugz: snd_pcm_hw_params_set_rate(8287) failed:
	Invalid argument
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

Hi,

I'm rather new to using bluetooth devices but I successfully managed to
get my headset running using plugz. I use it for telephony purposes with
twinkle (http://www.twinklephone.com).

I am able to hear people and talk to them during the phone call without
problems, but I can't hear the ringtone created by twinkle on my
headset. In the log files, I find the following error message:

snd_pcm_hw_params_set_rate(8287) failed: Invalid argument

After that message, twinkle stops generation of the ringtone and I am
left in silence until the phone line is established.
In most cases, I will miss the first words from the other side, because
the headset daemon returned to idle state while I was waiting and has to
get back to streaming mode upon call reception.

I'm running on 64-bit OpenSuSE 10.2 with kernel 2.6.18 (SCO-patch
applied). bluez-libs and bluez-utils is at 3.7, alsa at 1.0.13.
I got bluetooth-alsa from CVS on Feb, 6th and installed it as described.
My Dongle is a Level-One MDU-0005 (CSR chipset) and I have to different
headsets, a JABRA BT-200 and a B-Speech Vitac. The Problem occurs with
both of them.

I don't know, if this is a plugz issue or a twinkle issue and I didn't
find anything related on the net.

Any hints on this?

thx
Wolfgang

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFF2sM1gUafbxFH+p8RAp+1AKDaRylwPpiQR2mlGSUt3ZiT91bXGgCghV48
5lzHLc20qtgfpyVfwPmrGjw=
=SJbk
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
