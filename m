Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 7 Jan 2010 19:42:48 +0900
Message-ID: <ca39c8ec1001070242j18769ba0p79c699cbf0a88c56@mail.gmail.com>
Subject: Bluez Stack stalls problem
From: Asutosh Das <das.asutosh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi
I have ported the bluez-3.36 stack on an arm based board. When I play
songs using mplayer, it plays like 10 songs continuously, but after
sometime the stack hangs. Please find the log pasted below.

Additional Info
- The bt chip uses a hci-uart interface
- Its a broadcom based chip bcm 4325

Please give me anything/any thought that you may have. I shall dig from there.

Appreciate your help.

==================================================================================================================================================
Playing EK PYAR KA NAGMA HAI.mp3.
called: process_queue
Audio file file format detected.
==========================================================================
Opening audio decoder: [mp3lib] MPEG layer-2, layer-3
AUDIO: 44100 Hz, 2 ch, s16le, 160.0 kbit/11.34% (ratio: 20000->176400)
Selected audio codec: [mp3] afm: mp3lib (mp3lib MPEG layer-2, layer-3)
==========================================================================
hcid[1016]: Audio API: received BT_GETCAPABILITIES_REQ
DEBUG: handle_getcapabilities_req Called
hcid[1016]: Audio API: sending BT_GETCAPABILITIES_RSP
hcid[1016]: Audio API: received BT_SETCONFIGURATION_REQ
DEBUG: handle_setconfiguration_req Called
hcid[1016]: config a2dp - device = 00:19:7F:6F:6E:83 access_mode = 2
hcid[1016]: codec sbc - frequency = 2 channel_mode = 1 allocation = 1
subbands = 1 blocks = 1 bitpool = 32
hcid[1016]: Audio API: sending BT_SETCONFIGURATION_RSP
hcid[1016]: Audio API: received BT_STREAMSTART_REQ
called: send_request
called: send_req
hcid[1016]: Audio API: sending BT_STREAMSTART_RSP
hcid[1016]: Audio API: sending BT_STREAMFD_IND
called: process_queue
AO: [alsa] 44100Hz 2ch s16le (2 bytes per sample)
Video: no video
Starting playback...
h4_recv: Unknown HCI packet type 050) 33.5%
h4_recv: Unknown HCI packet type 01
h4_recv: Unknown HCI packet type 0c
h4_recv: Unknown HCI packet type 00
A: 254.8 (04:14.7) of 254hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection 83:6E:6F:7F:19:00
.0 (04:14.0) 33.3%
called: send_request
called: send_req

Playing gazab_ka_hai_din.mp3.
Audio file file format detected.
Clip info:
 Title: Track 09
 Artist: artist
 Album: title
 Year:
 Comment:
 Track: 9
 Genre: Other
==========================================================================
Opening audio decoder: [mp3lib] MPEG layer-2, layer-3
AUDIO: 11025 Hz, 2 ch, s16le, 16.0 kbit/4.54% (ratio: 2000->44100)
Selected audio codec: [mp3] afm: mp3lib (mp3lib MPEG layer-2, layer-3)
==========================================================================
hcid[1016]: Audio API: received BT_GETCAPABILITIES_REQ
DEBUG: handle_getcapabilities_req Called
hcid[1016]: Audio API: sending BT_GETCAPABILITIES_RSP
hcid[1016]: Audio API: received BT_SETCONFIGURATION_REQ
DEBUG: handle_setconfiguration_req Called
hcid[1016]: config a2dp - device = 00:19:7F:6F:6E:83 access_mode = 2
hcid[1016]: codec sbc - frequency = 8 channel_mode = 1 allocation = 1
subbands = 1 blocks = 1 bitpool = 32
called: send_request
called: send_req
hcid[1016]: Suspend hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection 83:6E:6F:7F:19:00
hci_cmd_task: hci0 command tx timeout
request timed out
called: send_request
called: send_req
hcid[1016]: Abort requhci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection 83:6E:6F:7F:19:00
hci_cmd_task: hci0 command tx timeout
[/home/maverick/projects/bluetooth/bt-remote/bt_dev.c : btdev_release
: 99] Releasing all...
hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection 83:6E:6F:7F:19:00
hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection 83:6E:6F:7F:19:00
est timed out
hcid[1016]: connection_lost: ref count not 1 after all callbacks

=============================================================================================================================================================


--
Thank you,
Warm Regards,
Asutosh Das
