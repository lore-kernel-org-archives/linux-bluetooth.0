Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F0FE84.8030401@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Again: Problems with Dongle, Headset or btsco
References: <41F0EB0A.1020302@webstuhl.net>
In-Reply-To: <41F0EB0A.1020302@webstuhl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 21 Jan 2005 14:07:16 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

maybe this is redundant information, but the correct use of btsco is this:

1. start btsco <addr>

when it is ready connection to the headset (no more output), press the
headset "connect" button - some output like "open hwdep, connected sco
channel" should show up

keep btsco running! do not quit it!

2. use any audio app including aplay to play/record audio while the
headset is connected

3. disconnect the headset by pressing the "connect" button of the
headset again. Audio stops working until you "connect" again with the
button.

******

If you did everything like this, it should work like described. If it
does not, you might need another dongle :)

I'm using a epox bt-dg03 and it works fine for me, that is, for my
logitech mx900 bt mouse and my sony ericsson hbh-35 headset. I don't
know if this is the "best" dongle.

I was also able to use the headset with the "dongle" that came with the
MX900, but I never made much tests there (the headset is only used with
the epox dongle because I keep my IM programs running on that PC)

best regards,
~  Lars


Ben Pezzei wrote:
| Hi
|
| I still try to use my Anycom 240 USB Dongle with the Plantronics 2500
| Headset.  As Marcel stated in a previous Thread, this dongle looks
| like to have an RSSI inquiry bug.
|
| to make it short: shall I buy another dongle? And which one is known
| to work without problems?
|
| Here is the List what I did:
|
| compile 2.6.10 Kernel (without patch-2.6.10-mh1.gz). In
| previous trys I used the bluez libs and tools (compiled
| them outside the kernel).
|
| compile the latest btsco csv
|
| btsco <addr> connects to the headset and i can change
| the volume via the headset-button.
|
| So i guess the rfcomm Communication is ok
|
| But aplay -D plughw:Headset soundfile doesnt work.
| either arecord ...
| (btw: Should aplay ... be executed while btsco is connected
| to the HS?)
|
| weird thing: when using the hstest prog in bluez-utils i am
| able to record _something_ but it's more or less static
| (although the noises appear to be the spoken text - with
| wrong frequency/speed).
|
| Any Hints?
|
| friendly regards
| ben
|
|
|
|
|
| -------------------------------------------------------
| This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
| Tool for open source databases. Create drag-&-drop reports. Save time
| by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
| Download a FREE copy at http://www.intelliview.com/go/osdn_nl
| _______________________________________________
| Bluez-devel mailing list
| Bluez-devel@lists.sourceforge.net
| https://lists.sourceforge.net/lists/listinfo/bluez-devel
|


- --
Lars Grunewaldt
* software development
* multimedia design
skills: C/C++/Java/PHP/(X)HTML/Flash/audio/video
web: http://www.dark-reality.de
mail: lgw@dark-reality.de
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8P6DQWC6DTWkDAoRAgmVAJ958WwHgmm39/qLwikw/+fxjfcRfQCdFYxW
5cxxgzhyPe3uyV92DZ9nc8k=
=WGAL
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
