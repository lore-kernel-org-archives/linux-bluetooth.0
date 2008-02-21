Return-Path: <cyrus@holtmann.org>
Message-ID: <47BD711B.4010903@wurmsdobler.org>
Date: Thu, 21 Feb 2008 12:39:55 +0000
From: Peter Wurmsdobler <peter@wurmsdobler.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------000001030101020709070501"
Subject: [Bluez-users] PCM transmission works
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000001030101020709070501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

If you have a few minutes, I would like to give a short account on my 
experience in streaming PCM to/from a bluetooth headset. I would 
appreciate any feedback.

The setup is a little bit peculiar, but allows to test PCM transmission 
over bluetooth. The Linux host, an mx27 ADS board runs kernel 2.6.19.2 
and connects over RS232 to a apm6628 bluetooth module containing a CSR 
BC4-ROM. The apm6628's PCM lines (CLK, SYNC, IN, OUT) are not connected 
to the SSI of the mx27 Linux host, but to a local PCM codec on the apm 
module. As a result, audio is sampled on the apm board and transmitted 
through bluetooth without involvement of ALSA on the mx27 host, good for 
isolating the test.

Having connected a cabled headset on one ear to the phone/mic jacks on 
the apm module, and putting the BT headset on my other ear, I could 
witness that it works. The only problem was that the BT headset's output 
(coming from the wired mic) had a strong humm and the signal level was 
very low. In contrast, the signal from the BT mic was perfectly 
transmitted and audible on the wired headphone. Mayby somebody has an 
idea where this humm could come from?

Regards,
peter
--
For the records, on my development Linux PC, I run ltib, configured with 
standard components, and in addition:

   - dbus 1.0.2
   - bluez-libs 3.26
   - bluez-utils 3.26

Since they are not part of the ltib distribution we use (ltib-200705022) 
these packages have been added manually and are compiled with 
prefix="/usr". Cross-compiling with prefix=/ did not work. Therefore all 
config files end up in /usr/etc, i.e. /usr/etc/dbus-1/ and 
/usr/etc/bluetooth/ .

As a small change to the default configuration files, I have set the 
Autostart=true in /usr/etc/bluetooth/audio.conf and Autostart=false in 
/usr/etc/bluetooth/input.conf . In addition, I have copied 
daemons/passkey-agent into the target's /usr/bin/.

Starting System message bus using:
      /usr/bin/dbus-daemon --system

Starting Bluetooth subsystem in two steps.

First, use hciatach twice to configure the BC4-ROM:
     /usr/sbin/hciattach /dev/ttymxc2 bcsp 57600 flow
     /usr/sbin/hciconfig hci0 up
     /usr/sbin/bccmd -t hci psload -r /usr/etc/bluetooth/apm6628BT-UART.psr
     killall hciattach
     /usr/sbin/hciattach /dev/ttymxc2 bcsp 115200 flow
     /usr/sbin/hciconfig hci0 up

It looks strange at the first glance to launch hciattach, kill it and 
launch it again, but bccmd only works over hci, because "bccmd -t bcsp" 
contains a race condition somewhere and locks up. The startup sequence 
should rather be
     /usr/sbin/bccmd -t bcsp psload -r /usr/etc/bluetooth/apm6628BT-UART.psr
     /usr/sbin/hciattach /dev/ttymxc2 bcsp 115200 flow
     /usr/sbin/hciconfig hci0 up

Second, starting the hcid
     /usr/sbin/hcid -s -d -f /usr/etc/bluetooth/hcid.conf

Maybe the -f option would not be required, sinced hcid was compiled with 
prefix="/usr".

Since a hci0 device is now in place, provided by hciattach, I could 
start the bonding procedure. I had wiped the /usr/var/lib/bluetooth 
before to be sure that bluez does not know any devices I used before. I 
hope this is the only place where bluez stores associations to devices.

In one shell I start:

mx27# BTADDR="00:16:8F:EB:6E:53"
mx27# PASSKEY="0000"
mx27# passkey-agent $PASSKEY $BTADDR
Jan  1 00:10:55 freescale daemon.debug hcid[1865]: /org/bluez/hci0: 
org.bluez.Security.RegisterPasskeyAgent()
Jan  1 00:10:55 freescale daemon.debug hcid[1865]: name_listener_add(:1.2)

In a second shell I launch:

mx27# BTADDR="00:16:8F:EB:6E:53"
mx27# PASSKEY="0000"
mx27# dbus-send --system --type=method_call --print-reply --dest=org.bluez \
	/org/bluez/hci0 org.bluez.Adapter.CreateBonding string:$BTADDR
Jan  1 00:11:14 freescale daemon.debug hcid[1865]: /org/bluez/hci0: 
org.bluez.Adapter.CreateBonding()
Jan  1 00:11:14 freescale daemon.debug hcid[1865]: name_listener_add(:1.3)
Jan  1 00:11:18 freescale daemon.info hcid[1865]: link_key_request 
(sba=00:02:5B:00:A5:A5, dba=00:16:8F:EB:6E:53)
Jan  1 00:11:18 freescale daemon.info hcid[1865]: pin_code_request 
(sba=00:02:5B:00:A5:A5, dba=00:16:8F:EB:6E:53)
Jan  1 00:11:18 freescale daemon.debug hcid[1865]: Calling 
PasskeyAgent.Request: name=:1.2, path=/org/bluez/passkey_agent_1884
Jan  1 00:11:18 freescale daemon.debug hcid[1865]: Releasing agent :1.2, 
/org/bluez/passkey_agent_1884
Jan  1 00:11:18 freescale daemon.debug hcid[1865]: 
name_listener_remove(:1.2)
Jan  1 00:11:18 freescale daemon.err hcid[1865]: Got NameOwnerChanged 
signal for :1.2 which has no listeners
Jan  1 00:11:19 freescale daemon.info hcid[1865]: link_key_notify 
(sba=00:02:5B:00:A5:A5, dba=00:16:8F:EB:6E:53)
Jan  1 00:11:19 freescale daemon.debug hcid[1865]: 
name_listener_remove(:1.3)
Jan  1 00:11:19 freescale daemon.err hcid[1865]: Got NameOwnerChanged 
signal for :1.3 which has no listeners

Miraculously, pairing worked. I also tried to remove the pairing calling 
org.bluez.Adapter.RemoveBonding, but to my surprise, the related files 
and entries in /usr/var/lib/bluetooth remain.

The next steps would probably be performed by an audio player if the 
output device was set to pcm.bluetooth. ALSA would take care that the 
PCM data are then routed to the SSI connected to the bluetooth chip 
rather than the audio chip. In my test case, as mentioned before, the 
PCM codec on the apm board is connected. What has to be done though is 
to set up the connection over HCI such that the BC4 knows he has to take 
the PCM data and shove it into the ether on an SCO channel negotiated 
with the headset.

The following commands are also contained in a -quick&dirty- shell 
script attached.

dbus-send --system --type=method_call --print-reply --dest=org.bluez \
             /org/bluez org.bluez.Manager.ActivateService string:audio > 
answer
DESTINATION=`grep string answer | sed -e "s/string//g" -e "s/\ //g" -e 
"s/\"//g"`
echo "DESTINATION=$DESTINATION"
DESTINATION=:1.1

Jan  1 00:16:26 freescale daemon.debug hcid[1865]: /org/bluez: 
org.bluez.Manager.ActivateService()

dbus-send --system --type=method_call --print-reply --dest="$DESTINATION" \
	/org/bluez/audio org.bluez.audio.Manager.CreateHeadset string:$BTADDR > 
answer
DEVICEPATH=`grep string answer | sed -e "s/string//g" -e "s/\ //g" -e 
"s/\"//g"`
echo "DEVICEPATH=$DEVICEPATH"
DEVICEPATH=/org/bluez/audio/device0

Jan  1 00:19:07 freescale daemon.debug audio[1875]: /org/bluez/audio: 
org.bluez.audio.Manager.CreateHeadset()
Jan  1 00:19:07 freescale daemon.debug hcid[1865]: /org/bluez: 
org.bluez.Manager.FindAdapter()
Jan  1 00:19:07 freescale daemon.debug audio[1875]: Got path 
/org/bluez/hci0 for adapter with address 00:02:5B:00:A5:A5
Jan  1 00:19:07 freescale daemon.debug hcid[1865]: /org/bluez/hci0: 
org.bluez.Adapter.GetRemoteName()
Jan  1 00:19:07 freescale daemon.debug hcid[1865]: /org/bluez/hci0: 
org.bluez.Adapter.GetRemoteServiceHandles()
Jan  1 00:19:07 freescale daemon.debug hcid[1865]: no matching session 
found. creating a new one
Jan  1 00:19:10 freescale daemon.debug hcid[1865]: sdp session added to 
cache
Jan  1 00:19:10 freescale daemon.debug hcid[1865]: /org/bluez/hci0: 
org.bluez.Adapter.GetRemoteServiceHandles()
Jan  1 00:19:10 freescale daemon.debug hcid[1865]: found matching 
session, removing from list
Jan  1 00:19:11 freescale daemon.debug hcid[1865]: sdp session added to 
cache
Jan  1 00:19:11 freescale daemon.debug hcid[1865]: /org/bluez/hci0: 
org.bluez.Adapter.GetRemoteServiceHandles()
Jan  1 00:19:11 freescale daemon.debug hcid[1865]: found matching 
session, removing from list
Jan  1 00:19:11 freescale daemon.debug hcid[1865]: sdp session added to 
cache
Jan  1 00:19:11 freescale daemon.debug hcid[1865]: /org/bluez/hci0: 
org.bluez.Adapter.GetRemoteServiceRecord()
Jan  1 00:19:11 freescale daemon.debug hcid[1865]: found matching 
session, removing from list
Jan  1 00:19:11 freescale daemon.debug hcid[1865]: sdp session added to 
cache
Jan  1 00:19:11 freescale daemon.debug hcid[1865]: /org/bluez/hci0: 
org.bluez.Adapter.GetRemoteServiceRecord()
Jan  1 00:19:11 freescale daemon.debug hcid[1865]: found matching 
session, removing from list
Jan  1 00:19:11 freescale daemon.debug hcid[1865]: sdp session added to 
cache
Jan  1 00:19:11 freescale daemon.debug audio[1875]: Audio service 
discovery completed with success
Jan  1 00:19:11 freescale daemon.debug hcid[1865]: /org/bluez/hci0: 
org.bluez.Adapter.FinishRemoteServiceTransaction()
Jan  1 00:19:11 freescale daemon.debug hcid[1865]: found matching 
session, removing from list
Jan  1 00:19:11 freescale daemon.debug audio[1875]: Found Headset record
Jan  1 00:19:11 freescale daemon.debug audio[1875]: Discovered Headset 
service on RFCOMM channel 2
Jan  1 00:19:11 freescale daemon.debug audio[1875]: Selecting default device


dbus-send --system --type=method_call --print-reply --dest="$DESTINATION" \
	"$DEVICEPATH" org.bluez.audio.Headset.Connect

Jan  1 00:21:36 freescale daemon.debug audio[1875]: 
/org/bluez/audio/device0: org.bluez.audio.Headset.Connect()
Jan  1 00:21:36 freescale daemon.debug audio[1875]: State changed 
/org/bluez/audio/device0: HEADSET_STATE_DISCONNECTED -> 
HEADSET_STATE_CONNECT_IN_PROGRESS
Jan  1 00:21:36 freescale daemon.debug hcid[1865]: /org/bluez/hci0: 
org.bluez.Adapter.GetRemoteServiceHandles()
Jan  1 00:21:36 freescale daemon.debug hcid[1865]: no matching session 
found. creating a new one
Jan  1 00:21:39 freescale daemon.debug hcid[1865]: sdp session added to 
cache
Jan  1 00:21:39 freescale daemon.debug hcid[1865]: /org/bluez/hci0: 
org.bluez.Adapter.GetRemoteServiceRecord()
Jan  1 00:21:39 freescale daemon.debug hcid[1865]: found matching 
session, removing from list
Jan  1 00:21:39 freescale daemon.debug hcid[1865]: sdp session added to 
cache
Jan  1 00:21:39 freescale daemon.debug audio[1875]: 
/org/bluez/audio/device0: Connecting to 00:16:8F:EB:6E:53 channel 2
Jan  1 00:21:39 freescale daemon.debug hcid[1865]: /org/bluez/hci0: 
org.bluez.Adapter.FinishRemoteServiceTransaction()
Jan  1 00:21:39 freescale daemon.debug hcid[1865]: found matching 
session, removing from list
Jan  1 00:21:39 freescale daemon.info hcid[1865]: link_key_request 
(sba=00:02:5B:00:A5:A5, dba=00:16:8F:EB:6E:53)
Jan  1 00:21:40 freescale daemon.debug audio[1875]: State changed 
/org/bluez/audio/device0: HEADSET_STATE_CONNECT_IN_PROGRESS -> 
HEADSET_STATE_CONNECTED
Jan  1 00:21:40 freescale daemon.debug audio[1875]: 
/org/bluez/audio/device0: Connected to 00:16:8F:EB:6E:53


dbus-send --system --type=method_call --print-reply --dest="$DESTINATION" \
             "$DEVICEPATH" org.bluez.audio.Headset.Play

Jan  1 00:22:31 freescale daemon.debug audio[1875]: 
/org/bluez/audio/device0: org.bluez.audio.Headset.Play()
Jan  1 00:22:31 freescale user.info kernel: Bluetooth: SCO (Voice Link) 
ver 0.5
Jan  1 00:22:31 freescale user.info kernel: Bluetooth: SCO socket layer 
initialized
Jan  1 00:22:31 freescale daemon.debug audio[1875]: State changed 
/org/bluez/audio/device0: HEADSET_STATE_CONNECTED -> 
HEADSET_STATE_PLAY_IN_PROGRESS
Jan  1 00:22:33 freescale daemon.debug audio[1875]: SCO socket opened 
for headset /org/bluez/audio/device0
Jan  1 00:22:33 freescale daemon.info audio[1875]: SCO fd=10
Jan  1 00:22:33 freescale daemon.debug audio[1875]: State changed 
/org/bluez/audio/device0: HEADSET_STATE_PLAY_IN_PROGRESS -> 
HEADSET_STATE_PLAYING


<playing>


dbus-send --system --type=method_call --print-reply --dest="$DESTINATION" \
	"$DEVICEPATH" org.bluez.audio.Headset.Stop
Jan  1 00:28:06 freescale daemon.debug audio[1875]: 
/org/bluez/audio/device0: org.bluez.audio.Headset.Stop()
Jan  1 00:28:06 freescale daemon.debug audio[1875]: State changed 
/org/bluez/audio/device0: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED


dbus-send --system --type=method_call --print-reply --dest="$DESTINATION" \
	"$DEVICEPATH" org.bluez.audio.Headset.Disconnect

Jan  1 00:29:12 freescale daemon.debug audio[1875]: 
/org/bluez/audio/device0: org.bluez.audio.Headset.Disconnect()
Jan  1 00:29:12 freescale daemon.debug audio[1875]: State changed 
/org/bluez/audio/device0: HEADSET_STATE_CONNECTED -> 
HEADSET_STATE_DISCONNECTED
Jan  1 00:29:12 freescale daemon.info audio[1875]: Disconnected from 
00:16:8F:EB:6E:53, /org/bluez/audio/device0

dbus-send --system --type=method_call --print-reply --dest="$DESTINATION" \
	/org/bluez/audio org.bluez.audio.Manager.RemoveHeadset string:$DEVICEPATH

Jan  1 00:32:21 freescale daemon.debug audio[1875]: /org/bluez/audio: 
org.bluez.audio.Manager.RemoveHeadset()
Jan  1 00:32:21 freescale daemon.debug audio[1875]: Removing default device
Jan  1 00:32:21 freescale daemon.debug audio[1875]: Removing default headset
Jan  1 00:32:21 freescale daemon.info audio[1875]: Unregistered device 
path:/org/bluez/audio/device0


--------------000001030101020709070501
Content-Type: text/plain;
 name="pcmplay"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcmplay"

#!/bin/sh
#
# Start/stop routing PCM to headset
DESC="routing PCM to headset"
BTADDR="00:16:8F:EB:6E:53"
case "$1" in
    start)
        echo "Start $DESC:"

        echo "ActivateService string:audio"
        dbus-send --system --type=method_call --print-reply --dest=org.bluez \
            /org/bluez org.bluez.Manager.ActivateService string:audio > .answer
        DESTINATION=`grep string .answer | sed -e "s/string//g" -e "s/\ //g" -e "s/\"//g"`
	echo "DESTINATION=$DESTINATION"
	echo $DESTINATION > .destination

        echo "Manager.CreateHeadset"
        dbus-send --system --type=method_call --print-reply --dest="$DESTINATION" \
            /org/bluez/audio org.bluez.audio.Manager.CreateHeadset string:$BTADDR > .answer
        DEVICEPATH=`grep string .answer | sed -e "s/string//g" -e "s/\ //g" -e "s/\"//g"`
	echo "DEVICEPATH=$DEVICEPATH"
	echo $DEVICEPATH > .devicepath

        echo "Headset.Connect"
        dbus-send --system --type=method_call --print-reply --dest="$DESTINATION" \
            "$DEVICEPATH" org.bluez.audio.Headset.Connect

        echo "Headset.Play"
        dbus-send --system --type=method_call --print-reply --dest="$DESTINATION" \
            "$DEVICEPATH" org.bluez.audio.Headset.Play
        echo "Done."
        ;;
    stop)
        echo "Stop $DESC:"

        DESTINATION=`cat .destination`
	echo "DESTINATION=$DESTINATION"

        DEVICEPATH=`cat .devicepath`
	echo "DEVICEPATH=$DEVICEPATH"

        echo "Headset.Stop"
        dbus-send --system --type=method_call --print-reply --dest="$DESTINATION" \
            "$DEVICEPATH" org.bluez.audio.Headset.Stop

        echo "Headset.Disconnect"
        dbus-send --system --type=method_call --print-reply --dest="$DESTINATION" \
            "$DEVICEPATH" org.bluez.audio.Headset.Disconnect

        echo "Manager.RemoveHeadset"
        dbus-send --system --type=method_call --print-reply --dest="$DESTINATION" \
            /org/bluez/audio org.bluez.audio.Manager.RemoveHeadset string:$DEVICEPATH

        echo "Done."
        ;;
esac
exit 0

--------------000001030101020709070501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------000001030101020709070501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------000001030101020709070501--
