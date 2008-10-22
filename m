Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Oct 2008 21:28:16 +0200
From: Andre Roth <lynx@netlabs.org>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20081022212816.042575e4@netlabs.org>
Mime-Version: 1.0
Subject: [Bluez-devel] Sony Ericsson HBH-610a and bluez git
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Hello, =


I had a bit of success trying to get something out of my headset :)
I'm using bluez from git, and a bluetooth kernel from git as well.

using arecord, I still get:

$ arecord -D headset -f S16_LE test.wav
ALSA lib pcm_bluetooth.c:1619:(bluetooth_init) BT_GETCAPABILITIES failed : =
Input/output error(5)
arecord: main:564: audio open error: Input/output error

but I found the hstest tool, which connects successfully to my headset
(I hear it ring) and the records audio:

$ ./hstest record test.raw 00:12:EE:A6:FC:1E 2
Voice setting: 0x0060
RFCOMM channel connected
SCO audio channel connected (handle 45, mtu 64)
AT+BRSF=3D29
AT+CIND=3D?
AT+CIND?
AT+CMER=3D3,0,0,1
AT+VGS=3D6
AT*SEAUDIO=3D4,4014
AT+CLIP=3D1
AT+CSCS=3D"UTF-8"
AT*SEAM=3D"HBH-610a",13
AT+CLAN?
^C

but only when I use the channel 2. channel 1 fails to create the rfcomm
connection.

the test.raw file contains audio, but it's very distorted. I think maybe
there are samples missing...
Is it really S16_LE 8 kHz ?

playing the test.raw to the headset didn't show an error, but it didn't
do something...

bouetoothd shows the following when pairing the device
with ./simple-agent hci0 00:12:EE:A6:FC:1E :

bluetoothd[8461]: bonding_request_new(00:12:EE:A6:FC:1E) =

bluetoothd[8461]: adapter_get_device(00:12:EE:A6:FC:1E)
bluetoothd[8461]: Temporary agent registered for hci0/00:12:EE:A6:FC:1E at =
:1.13:/test/agent
bluetoothd[8461]: adapter_get_device(00:12:EE:A6:FC:1E)
bluetoothd[8461]: link_key_request (sba=3D00:02:C7:83:76:CC, dba=3D00:12:EE=
:A6:FC:1E)
bluetoothd[8461]: kernel auth requirements =3D 0x04
bluetoothd[8461]: pin_code_request (sba=3D00:02:C7:83:76:CC, dba=3D00:12:EE=
:A6:FC:1E)
bluetoothd[8461]: hcid_dbus_new_auth_request
bluetoothd[8461]: link_key_notify (sba=3D00:02:C7:83:76:CC, dba=3D00:12:EE:=
A6:FC:1E)
bluetoothd[8461]: hcid_dbus_bonding_process_complete: status=3D00
bluetoothd[8461]: adapter_get_device(00:12:EE:A6:FC:1E)
bluetoothd[8461]: Releasing agent :1.13, /test/agent
bluetoothd[8461]: /org/bluez/hci0/dev_00_12_EE_A6_FC_1E: No service update
bluetoothd[8461]: Accepted new client connection on unix socket (fd=3D22)
bluetoothd[8461]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[8461]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[8461]: Unix client disconnected (fd=3D22)

does the "No service update" mean something bad ?

when terminating hstest, bluetoothd shows:

bluetoothd[8988]: link_key_request (sba=3D00:02:C7:83:76:CC, dba=3D00:12:EE=
:A6:FC:1E)
bluetoothd[8988]: kernel auth requirements =3D 0x04
bluetoothd[8988]: stored link key type =3D 0x00
bluetoothd[8988]: No matching connection for handle 45

Is there something I can help debugging/coding ?

regards

 andr=E9

here the output of the bluetoothd file in /var/lib:

/var/lib/bluetooth/00:02:C7:83:76:CC# more *
::::::::::::::
config
::::::::::::::
class 0x0a010c
::::::::::::::
features
::::::::::::::
00:12:EE:A6:FC:1E FFFD297818180080
::::::::::::::
lastused
::::::::::::::
00:12:EE:A6:FC:1E 2008-10-21 21:33:51 GMT
::::::::::::::
linkkeys
::::::::::::::
00:12:EE:A6:FC:1E 9E6C908BA0FDE751C9C31F25E421D96C 0 4
::::::::::::::
manufacturers
::::::::::::::
00:12:EE:A6:FC:1E 13 3 3611
::::::::::::::
names
::::::::::::::
00:12:EE:A6:FC:1E HBH-610a
::::::::::::::
profiles
::::::::::::::
00:12:EE:A6:FC:1E 8e771301-0000-1000-8000-00805f9b34fb
::::::::::::::
sdp
::::::::::::::
00:12:EE:A6:FC:1E#00010501 35470900000A0001050109000135051A8E77130109000435=
0F350619010009F0F935051A8E7703000900053503191002
090009350735051A8E771302090100250853454D4320484C41
::::::::::::::
trusts
::::::::::::::
00:12:EE:A6:FC:1E [all]


-- =

Andre Roth   | <lynx@netlabs.org>
GPG: FADF988E| 0959 4D7C F8ED DF4B 90A6  CF71 9EDF 52D1 FADF 988E

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
