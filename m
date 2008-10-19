Return-Path: <cyrus@holtmann.org>
Message-ID: <89b6ba3a0810190909l69688cb9n13c8000ca272767@mail.gmail.com>
Date: Sun, 19 Oct 2008 18:09:58 +0200
From: "Patryk Zawadzki" <patrys@pld-linux.org>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>,
	"BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <89b6ba3a0810190855g2aa8bd00v9fe2c782fe5efb3e@mail.gmail.com>
MIME-Version: 1.0
References: <mailman.81198.1224358186.3608.bluez-users@lists.sourceforge.net>
	<89b6ba3a0810181248u29129a09v50c7befde6741e5b@mail.gmail.com>
	<48FA49A4.9040908@powercraft.nl>
	<89b6ba3a0810190855g2aa8bd00v9fe2c782fe5efb3e@mail.gmail.com>
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

And here's a full instrumented run:

bluetoothd[22394]: link_key_request (sba=00:1D:60:69:91:18,
dba=00:0D:FD:15:F0:3E)
bluetoothd[22394]: kernel auth requirements = 0x00
bluetoothd[22394]: stored link key type = 0x00
bluetoothd[22394]: adapter_get_device(00:0D:FD:15:F0:3E)
bluetoothd[22394]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[22394]: adapter_get_device(00:0D:FD:15:F0:3E)
bluetoothd[22394]: hcid_dbus_bonding_process_complete: no pending auth request
bluetoothd[22394]: AVDTP: incoming connect from 00:0D:FD:15:F0:3E
bluetoothd[22394]: session_cb
bluetoothd[22394]: Received DISCOVER_CMD
bluetoothd[22394]: session_cb
bluetoothd[22394]: Received  GET_CAPABILITIES_CMD
bluetoothd[22394]: Source 0xb9232388: Get_Capability_Ind
bluetoothd[22394]: session_cb
bluetoothd[22394]: Received SET_CONFIGURATION_CMD
DEBUG: setting stream sock to -1
bluetoothd[22394]: Source 0xb9232388: Set_Configuration_Ind
bluetoothd[22394]: avdtp_ref(0xb92374d8): ref=2
bluetoothd[22394]: stream state changed: IDLE -> CONFIGURED
bluetoothd[22394]: session_cb
bluetoothd[22394]: Received OPEN_CMD
bluetoothd[22394]: Source 0xb9232388: Open_Ind
bluetoothd[22394]: stream state changed: CONFIGURED -> OPEN
bluetoothd[22394]: Accepted new client connection on unix socket (fd=24)
bluetoothd[22394]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[22394]: avdtp_ref(0xb92374d8): ref=3
bluetoothd[22394]: AVCTP: connected to 00:0D:FD:15:F0:3E
bluetoothd[22394]: AVRCP: uinput initialized for 00:0D:FD:15:F0:3E
bluetoothd[22394]: session_cb
bluetoothd[22394]: DISCOVER request succeeded
bluetoothd[22394]: seid 1 type 1 media 0 in use 1
bluetoothd[22394]: seid 2 type 1 media 0 in use 1
bluetoothd[22394]: session_cb
bluetoothd[22394]: GET_CAPABILITIES request succeeded
bluetoothd[22394]: seid 1 type 1 media 0
bluetoothd[22394]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[22394]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[22394]: config a2dp - device = 00:0D:FD:15:F0:3E access_mode = 2
bluetoothd[22394]: codec sbc - frequency = 2 channel_mode = 1
allocation = 1 subbands = 1 blocks = 1 bitpool = 44
bluetoothd[22394]: a2dp_source_config: selected SEP 0xb9232388
bluetoothd[22394]: avdtp_ref(0xb92374d8): ref=4
bluetoothd[22394]: setup_ref(0xb9234250): ref=1
bluetoothd[22394]: setup_ref(0xb9234250): ref=2
bluetoothd[22394]: SEP 0xb9232388 locked
DEBUG: stream sock is -1
bluetoothd[22394]: Unable to get stream transport
bluetoothd[22394]: config failed
bluetoothd[22394]: SEP 0xb9232388 unlocked
bluetoothd[22394]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[22394]: avdtp_unref(0xb92374d8): ref=3
bluetoothd[22394]: setup_unref(0xb9234250): ref=1
bluetoothd[22394]: setup_unref(0xb9234250): ref=0
bluetoothd[22394]: setup_free(0xb9234250)
bluetoothd[22394]: avdtp_unref(0xb92374d8): ref=2
bluetoothd[22394]: Unix client disconnected (fd=24)
bluetoothd[22394]: AVDTP: incoming connect from 00:0D:FD:15:F0:3E
DEBUG: setting stream sock to 24
DEBUG: trying to change stream state from 2 to 2
bluetoothd[22394]: stream state change failed: Input/output error
bluetoothd[22394]: session_cb
bluetoothd[22394]: Received START_CMD
bluetoothd[22394]: Source 0xb9232388: Start_Ind
bluetoothd[22394]: avdtp_ref(0xb92374d8): ref=3
bluetoothd[22394]: stream state changed: OPEN -> STREAMING
bluetoothd[22394]: avdtp_unref(0xb92374d8): ref=2
bluetoothd[22394]: session_cb
bluetoothd[22394]: SUSPEND request succeeded
bluetoothd[22394]: stream state changed: STREAMING -> OPEN
bluetoothd[22394]: Source 0xb9232388: Suspend_Cfm
bluetoothd[22394]: session_cb
bluetoothd[22394]: CLOSE request succeeded
bluetoothd[22394]: stream state changed: OPEN -> CLOSING
DEBUG: setting stream sock to -1
bluetoothd[22394]: Source 0xb9232388: Close_Cfm
bluetoothd[22394]: stream state changed: CLOSING -> IDLE
bluetoothd[22394]: avdtp_unref(0xb92374d8): ref=1
bluetoothd[22394]: Disconnected from 00:0D:FD:15:F0:3E
bluetoothd[22394]: avdtp_unref(0xb92374d8): ref=0
bluetoothd[22394]: avdtp_unref(0xb92374d8): freeing session and
removing from list

What's interesting is the "connected to X"/"incoming connect from X"
pair that seems to cause double stream state change to OPEN. Also
there seems to be a race condition between bluez and pulseaudio's
bluetooth-discovery agent (notice where it tries to get stream
properties long before setting the connection socket).

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
