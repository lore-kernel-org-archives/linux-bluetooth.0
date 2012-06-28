Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 00/12] Add org.bluez.Telephony interface
Date: Thu, 28 Jun 2012 10:03:24 +0200
Message-Id: <1340870617-13532-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

This set of patches replaces telephony drivers for HeadSet, HandsFree,
DUN and SAP Profiles by a new DBus interface (org.bluez.Telephony).

This will simplify BlueZ code by focusing on the Bluetooth
communication part and by letting the external application (i.e. oFono)
take charge of the Telephony tasks (AT parsing and modem specific code,
which can be removed from BlueZ code). So, it becomes simpler, easier
to maintain and debug.

External applications, which should implement AT parsing and telephony
part of HeadSet or HandsFree Profiles, will have to register a telephony
agent using this new interface.

Any comments appreciated.

Regards

PS: Since latest RFC:
- add btd_device entry to tel_device structure (allowing usage of
  audio-device entry only for specific profiles HS/HF)
- Patch 2:
  - changes volume management from SpeakerGain to OutputGain, and from
    MicrophoneGain to InputGain
- Patch 8:
  - media checks if set_configuration() has worked before calling
    headset_set_media_transport_path()
- Patch 9: 
  - media checks if set_configuration() has worked before calling
    gateway_set_media_transport_path()
  - Fix slc in gateway structure not freed
  - send right *_set_state (headset or gateway) if get_record_cb failed
- New patch 10: replace audio configuration options Headset and Gateway
  by Telephony option
- New patch 11: add DUN GW support in org.bluez.Telephony
- New patch 12: add SAP GW support in org.bluez.Telephony

Fred

Frédéric Danis (12):
  audio: Move tel drivers to DBus interface
  audio: Simplify org.bluez.Headset
  audio: Remove dummy tel driver
  audio: Remove maemo5 tel driver
  audio: Remove maemo6 tel driver
  audio: Remove oFono tel driver
  audio: Move HFP/HSP AG servers to telephony.c
  audio: Send transport path to telephony agent
  audio: Move HFP HF server to telephony.c
  audio: Replace headset and gateway by telephony
  audio: Add DUN GW to org.bluez.Telephony
  audio: Add SAP GW to org.bluez.Telephony

 Makefile.am                    |   17 +-
 audio/audio.conf               |    6 +-
 audio/device.h                 |    1 +
 audio/gateway.c                |  403 ++------
 audio/gateway.h                |    8 +
 audio/headset.c                | 1976 ++++--------------------------------
 audio/headset.h                |   16 +-
 audio/manager.c                |  696 +------------
 audio/manager.h                |    4 +-
 audio/media.c                  |   34 +
 audio/telephony-dummy.c        |  447 --------
 audio/telephony-maemo5.c       | 2105 --------------------------------------
 audio/telephony-maemo6.c       | 2200 ----------------------------------------
 audio/telephony-ofono.c        | 1637 ------------------------------
 audio/telephony.c              | 1675 ++++++++++++++++++++++++++++++
 audio/telephony.h              |  196 +---
 audio/transport.c              |  117 ++-
 audio/unix.c                   |    2 +
 doc/assigned-numbers.txt       |    1 +
 doc/audio-api.txt              |  244 ++---
 doc/audio-telephony-design.txt |  108 ++
 doc/hfp-api.txt                |   46 -
 doc/media-api.txt              |   19 +-
 23 files changed, 2366 insertions(+), 9592 deletions(-)
 delete mode 100644 audio/telephony-dummy.c
 delete mode 100644 audio/telephony-maemo5.c
 delete mode 100644 audio/telephony-maemo6.c
 delete mode 100644 audio/telephony-ofono.c
 create mode 100644 audio/telephony.c
 create mode 100644 doc/audio-telephony-design.txt

-- 
1.7.9.5

