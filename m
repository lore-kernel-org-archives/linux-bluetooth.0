Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 May 2008 21:01:54 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <DB4454DF-1BB6-48C6-9868-53EF65E3271E@holtmann.org>
Message-ID: <alpine.LNX.1.00.0805302047260.7625@nge2.ngu.pk>
References: <alpine.LNX.1.00.0805280355410.22621@nge2.ngu.pk>
	<DB4454DF-1BB6-48C6-9868-53EF65E3271E@holtmann.org>
MIME-Version: 1.0
Subject: Re: [Bluez-users] bluez-utils-3.32: something broke?
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


On Thu, 29 May 2008, Marcel Holtmann wrote:

-> > ALSA lib pcm_bluetooth.c:1521:(audioservice_expect) Bogus message
-> > BT_SETCONFIGURATION_REQ received while BT_SETCONFIGURATION_RSP was expected
-> > sox soxio: Can't open output file `pcm.bluetooth': cannot set parameters
-> > 
-> > hcid segfaulted on the first test. The bluetooth USB dongle "hangs",
-> > flashing
-> > endlessly. The sco counts stay at zero.
-> 
-> can you get us the backtrace of it. Sounds like a real bug.


I'll have to put 3.32 back on a machine and try to reproduce.

-> > 2008-05-28T03:50:07.678634-04:00 vdrl hcid[3348]: Bluetooth HCI daemon
-> > 2008-05-28T03:50:07.686778-04:00 vdrl hcid[3348]: Parsing
-> > /etc/bluetooth/main.conf failed: No such file or directory
-> > 
-> > main.conf? Never saw that before. What are the service-*.xml files for?
-> > Where
-> > to install?
-> 
-> Don't worry. If not present it will use proper defaults. That is not an
-> issue.

OK, just trying to keep on top of things.


-> > 2008-05-28T03:50:12.747879-04:00 vdrl hcid[3348]: Default authorization
-> > /agent (:1.10, /org/bluez/auth_agent_3352) registered
-> > 2008-05-28T03:50:34.813665-04:00 vdrl hcid[3348]: Default passkey agent
-> > /(:1.11, /org/bluez/passkey_agent_3355) registered
-> > 2008-05-28T03:51:00.171619-04:00 vdrl hcid[3348]: Audio API: received
-> > /BT_GETCAPABILITIES_REQ
-> > 2008-05-28T03:51:00.171649-04:00 vdrl hcid[3348]: Audio API: sending
-> > /BT_GETCAPABILITIES_RSP
-> > 2008-05-28T03:51:00.173225-04:00 vdrl hcid[3348]: Audio API: received
-> > /BT_SETCONFIGURATION_REQ
-> > 2008-05-28T03:51:00.173300-04:00 vdrl hcid[3348]: config sco - device =
-> > /00:1A:45:01:F9:42 access_mode = 2
-> > 2008-05-28T03:51:03.900979-04:00 vdrl hcid[3348]: link_key_request
-> > /(sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
-> > 2008-05-28T03:51:06.571723-04:00 vdrl hcid[3348]: connect: Socket operation
-> > /on non-socket (88)
-> > 2008-05-28T03:51:07.762096-04:00 vdrl hcid[3348]: Badly formated or
-> > /unrecognized command: AT+BTRH?
-> > 
-> > Very similar to the errors I got before patching the kernel to support SCO.
-> 
-> That is weird. Have either Luiz or Johan look into that. You can ping them on
-> IRC.

Looks like whatever it is, it's stopping the audio from working.


-> > 2008-05-28T03:51:58.718581-04:00 vdrl hcid[3348]: Audio API: received
-> > /BT_GETCAPABILITIES_REQ
-> > 2008-05-28T03:51:58.718607-04:00 vdrl hcid[3348]: Audio API: sending
-> > /BT_GETCAPABILITIES_RSP
-> > 2008-05-28T03:51:58.720113-04:00 vdrl hcid[3348]: Audio API: received
-> > /BT_SETCONFIGURATION_REQ
-> > 2008-05-28T03:51:58.720155-04:00 vdrl hcid[3348]: config sco - device =
-> > /00:1A:45:01:F9:42 access_mode = 2
-> > 2008-05-28T03:52:02.251505-04:00 vdrl hcid[3348]: link_key_request
-> > /(sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
-> > 2008-05-28T03:52:04.914254-04:00 vdrl hcid[3348]: connect: Invalid argument
-> > /(22)
-> > 2008-05-28T03:52:06.341660-04:00 vdrl hcid[3348]: Badly formated or
-> > /unrecognized command: AT+BTRH?
-> > 
-> > As nothing I tried worked, I put back bluez-utils-3.31 and the problems
-> > disappeared. bluez-libs-3.32 appears OK, but bluez-utils-3.32 has some
-> > serious
-> > issues.
-> > 2.6.25.3 w/sco patch built with gcc-4.3.0, x86.
-> 
-> The SCO patch should not be needed at all.

2.6.25.x is supporting SCO headsets straight out-of-the-box now? This will be 
good. The patch applied cleanly, so I figured nothing had been changed in the 
code. Actually, I'm now on 2.6.25.4 since last night. It will be easy to 
reverse.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
