Return-Path: <cyrus@holtmann.org>
Message-ID: <89b6ba3a0810181248u29129a09v50c7befde6741e5b@mail.gmail.com>
Date: Sat, 18 Oct 2008 21:48:24 +0200
From: "Patryk Zawadzki" <patrys@pld-linux.org>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <mailman.81198.1224358186.3608.bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
References: <mailman.81198.1224358186.3608.bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Motorola S9 and BlueZ 4.14
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
Errors-To: bluez-users-bounces@lists.sourceforge.net

Starting the bluetoothd daemon and pressing the headset power button I
get the following (the headset is paired but it does not make a
difference):

bluetoothd[21459]: link_key_request (sba=00:1D:60:69:91:18,
dba=00:0D:FD:15:F0:3E)
bluetoothd[21459]: kernel auth requirements = 0x00
bluetoothd[21459]: stored link key type = 0x00
bluetoothd[21459]: adapter_get_device(00:0D:FD:15:F0:3E)
bluetoothd[21459]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[21459]: adapter_get_device(00:0D:FD:15:F0:3E)
bluetoothd[21459]: hcid_dbus_bonding_process_complete: no pending auth request
bluetoothd[21459]: AVDTP: incoming connect from 00:0D:FD:15:F0:3E
bluetoothd[21459]: session_cb
bluetoothd[21459]: Received DISCOVER_CMD
bluetoothd[21459]: session_cb
bluetoothd[21459]: Received  GET_CAPABILITIES_CMD
bluetoothd[21459]: Source 0xb8ecb960: Get_Capability_Ind
bluetoothd[21459]: session_cb
bluetoothd[21459]: Received SET_CONFIGURATION_CMD
bluetoothd[21459]: Source 0xb8ecb960: Set_Configuration_Ind
bluetoothd[21459]: avdtp_ref(0xb8ec83f0): ref=2
bluetoothd[21459]: stream state changed: IDLE -> CONFIGURED
bluetoothd[21459]: session_cb
bluetoothd[21459]: Received OPEN_CMD
bluetoothd[21459]: Source 0xb8ecb960: Open_Ind
bluetoothd[21459]: stream state changed: CONFIGURED -> OPEN
bluetoothd[21459]: AVCTP: connected to 00:0D:FD:15:F0:3E
bluetoothd[21459]: AVRCP: uinput initialized for 00:0D:FD:15:F0:3E
bluetoothd[21459]: AVDTP: incoming connect from 00:0D:FD:15:F0:3E
bluetoothd[21459]: stream state change failed: Input/output error
bluetoothd[21459]: session_cb
bluetoothd[21459]: Received START_CMD
bluetoothd[21459]: Source 0xb8ecb960: Start_Ind
bluetoothd[21459]: avdtp_ref(0xb8ec83f0): ref=3
bluetoothd[21459]: stream state changed: OPEN -> STREAMING
bluetoothd[21459]: avdtp_unref(0xb8ec83f0): ref=2
bluetoothd[21459]: session_cb
bluetoothd[21459]: SUSPEND request succeeded
bluetoothd[21459]: stream state changed: STREAMING -> OPEN
bluetoothd[21459]: Source 0xb8ecb960: Suspend_Cfm
bluetoothd[21459]: session_cb
bluetoothd[21459]: CLOSE request succeeded
bluetoothd[21459]: stream state changed: OPEN -> CLOSING
bluetoothd[21459]: Source 0xb8ecb960: Close_Cfm
bluetoothd[21459]: stream state changed: CLOSING -> IDLE
bluetoothd[21459]: avdtp_unref(0xb8ec83f0): ref=1
bluetoothd[21459]: Disconnected from 00:0D:FD:15:F0:3E
bluetoothd[21459]: avdtp_unref(0xb8ec83f0): ref=0
bluetoothd[21459]: avdtp_unref(0xb8ec83f0): freeing session and
removing from list

Any ideas of possible causes of the "stream state change failed:
Input/output error"?

-- 
Patryk Zawadzki

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
