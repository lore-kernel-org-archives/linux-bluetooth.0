Return-Path: <cyrus@holtmann.org>
Message-ID: <89b6ba3a0810190855g2aa8bd00v9fe2c782fe5efb3e@mail.gmail.com>
Date: Sun, 19 Oct 2008 17:55:53 +0200
From: "Patryk Zawadzki" <patrys@pld-linux.org>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>,
	"BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <48FA49A4.9040908@powercraft.nl>
MIME-Version: 1.0
References: <mailman.81198.1224358186.3608.bluez-users@lists.sourceforge.net>
	<89b6ba3a0810181248u29129a09v50c7befde6741e5b@mail.gmail.com>
	<48FA49A4.9040908@powercraft.nl>
Subject: Re: [Bluez-devel] [Bluez-users] Motorola S9 and BlueZ 4.14
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

After some digging in the current GIT head:

bluetoothd[20589]: AVCTP: connected to 00:0D:FD:15:F0:3E
bluetoothd[20589]: AVRCP: uinput initialized for 00:0D:FD:15:F0:3E
bluetoothd[20589]: AVDTP: incoming connect from 00:0D:FD:15:F0:3E
DEBUG: trying to change from OPEN to OPEN
bluetoothd[20589]: stream state change failed: Input/output error

So for me it tries to change the stream state top OPEN twice.

Another debugging effort with pulseaudio bluetooth init:

bluetoothd[20589]: Received SET_CONFIGURATION_CMD
DEBUG: initializing stream sock to -1
[...]
bluetoothd[20851]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[20851]: config a2dp - device = 00:0D:FD:15:F0:3E access_mode = 2
bluetoothd[20851]: codec sbc - frequency = 2 channel_mode = 1
allocation = 1 subbands = 1 blocks = 1 bitpool = 44
bluetoothd[20851]: a2dp_source_config: selected SEP 0xb851c630
bluetoothd[20851]: avdtp_ref(0xb8521398): ref=4
bluetoothd[20851]: setup_ref(0xb8519490): ref=1
bluetoothd[20851]: setup_ref(0xb8519490): ref=2
bluetoothd[20851]: SEP 0xb851c630 locked
DEBUG: stream sock is -1
bluetoothd[20851]: Unable to get stream transport
bluetoothd[20851]: config failed

The stream socket does not seem to be set anywhere else along the way
(added debug prints to all stream socket changes in bluez code).
That's why get_transport returns FALSE. Still not sure if the bug is
in pulseaudio or in bluez.

Also sending this to bluez-devel, please don't shoot me for crossposting.

-- 
Patryk Zawadzki

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
