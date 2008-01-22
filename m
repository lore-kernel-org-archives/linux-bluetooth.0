Return-Path: <cyrus@holtmann.org>
Message-ID: <4795D6EB.2080209@naustech.com>
Date: Tue, 22 Jan 2008 12:43:39 +0100
From: "Ing. Gabriele Oberhammer" <gabriele@naustech.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Headset half working using Bluez's ALSA plugin
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

My problem is similar to that outlined in this post:

http://thread.gmane.org/gmane.linux.bluez.user/13352

I wish to use my new Phoenix BTK-03 (PCB300) bluetooth headset with VOIP 
applications.
Audio playback works well with mplayer (mplayer -ao 
alsa:device=bluetooth test.mp3) and aplay (aplay -D bluetooth test.wav) 
but I can't get capture working.

Test command:
$ arecord -D bluetooth -f S16_LE | aplay -D bluetooth -f S16_LE

executes without errors and:
$ arecord -D bluetooth -f S16_LE /tmp/rec_test.wav

produces always files with lenght=44 bytes (the files seems to contain 
only the wav format headers but no sound).
I'm sure the headset starts capturing because I hear a beep and some 
noise in the speaker.

I've tried with 'options hci_usb force_scofix=1' but the results are the 
same.
I've also successfully compiled bluez-utils from the yesterday cvs but I 
think I screwed up something when installing because the services in the 
'Service' tab in bluetooth applet preferences became uncheckable.

What information can I post to help solving this problem?
Can someone point me to an howto or README with best practices for 
installing from cvs?

This is my configuration:

PC:
	Dell Latitude D820

software versions:
	bluetooth		3.24-0ubuntu1
	bluez-gnome		0.14-0ubuntu2
	bluez-hcidump		1.39-1
	bluez-utils		3.24-0ubuntu1
	gnome-bluetooth		0.9.1-0ubuntu1
	libbluetooth-dev	3.24-0ubuntu1
	libbluetooth2		3.24-0ubuntu1
	python-bluez		0.9.1-1

.asoundrc:
	pcm.bluetooth {
        	 	type bluetooth
         	device 00:07:B0:0F:49:B7
	        profile voice
	}

hci0:   Type: USB
         BD Address: 00:1A:6B:11:52:5A ACL MTU: 384:8 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:6430 acl:57 sco:0 events:181 errors:0
         TX bytes:1739 acl:52 sco:0 commands:82 errors:0
         Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'BlueZ (0)'
         Class: 0x08210c
         Service Classes: Capturing
         Device Class: Computer, Laptop
         HCI Ver: 2.0 (0x3) HCI Rev: 0x976 LMP Ver: 2.0 (0x3)
	LMP Subver:0x976 Manufacturer: Cambridge Silicon Radio (10)

headset:
BD Address:  00:07:B0:0F:49:B7
         Device Name: PBC300
         LMP Version: 2.0 (0x3) LMP Subversion: 0xbf9
         Manufacturer: Cambridge Silicon Radio (10)
         Features: 0xfc 0xfe 0x0f 0x00 0x08 0x08 0x00 0x00
                 <encryption><slot offset><timing accuracy><roleswitch>
                 <hold mode><sniff mode><RSSI><channel quality><SCO link>
                 <HV2 packets><HV3 packets><u-law log><A-law log><CVSD>
                 <paging scheme><power control><transparent SCO>
		<AFH cap. slave><AFH cap. master>


Best regard, Gabriele

PS: The PC was shipped with Vista, but I've installed winXp and 
downgraded the firmware with the Dell utlity. Th headset works both for 
playing and capturing under winXP.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
