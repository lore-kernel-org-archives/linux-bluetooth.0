Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 29 May 2006 08:21:29 +0200
Message-ID: <96B7A15232D6CF42836BFD428AD6B6034E5062@deexmb01.de.icap.com>
From: "Guido Reimer" <G.Reimer@de.icap.com>
To: <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth-alsa: a2recv stuttering sound from
	WM5.0 AKU2.0
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

Brad

I have testet the latest CVS version and run into massive trubble. The
pearing between the devices didn't work until i found out, that there
was a change in cvs, that makes the problems.

File: a2recv.c
Line: 484
Old: cap_resp.sbc_elements.channel_mode=15;
New: cap_resp.sbc_elements.channel_mode=9;

Have set the old value and pearing was not longer a problem. But it
takes many hours for me to find :`)

Have upgraded my kernel, alsa and bluez until i realized the real
problem.

After this change, i got the same stuttering sound as before. Hier is
the output of a2recv:

---------------------------------------------------------
Connected [imtu 672, omtu 672, flush_to 65535]
Connected
Sent Stream End Point Discovery Response

Sent the get capabilities responseadjustsound has been called!
Channels=2, speed=44100channel_mode = 2 allocation_method = 1 subbands =
1 block_length = 1 min_bitpool = 48 max_bitpool = 48

Sent a Set configurations response

Received an open stream command

Sent open stream confirm

Connected [imtu 672, omtu 672, flush_to 65535]
ConnectedGot stream fd

Sent start stream confirm
unsupported signalling command: 9
-----------------------------------------------------------

I have insertet some debug output to the adjust_sound() method and
realized, that it will never be called. The stream will be send in 2
channels mode and with a frequency of 44100 and does never change during
playback.

Guido



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications
in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=k&kid7521&bid$8729&dat1642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
