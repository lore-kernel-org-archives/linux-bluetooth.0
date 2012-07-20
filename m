Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v14 00/14] Add org.bluez.Telephony interface
Date: Fri, 20 Jul 2012 10:57:23 +0200
Message-Id: <1342774657-29392-1-git-send-email-frederic.danis@linux.intel.com>
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

PS: Since latest Patch set:
- Patch 2:
  - fix #include order
  - rename slc to tel_dev in struct headset_slc
  - use real types instead of void *
  - check return value of telephony_agent_by_uuid() call in
    headset_connect_cb(), it can be NULL if device has been
    disconnected
  - remove un-needed function telephony_device_connected and
    telephony_device_disconnected
  - protect asynchronous calls (i.e. sdp record retrieval
    and NewConnection method call)
  - add usage of btd_adapter_ref/unref and btd_device_ref/unref
- Patch 3:
  - remove properties Connected and Playing from org.bluez.Headset
    and org.bluez.HandsfreeGateway
- Patch 10:
  - fix #include order
  - rename slc to tel_dev in struct gateway
  - check return value of telephony_agent_by_uuid() call in
    gateway_connect_cb(), it can be NULL if device has been
    disconnected
  - protect asynchronous NewConnection method call
  - remove unused (#if 0) sdp record create function for HSP HS
- Patch 12:
  - uses void * instead of struct audio_device * in tel_device
    structure and telephony_device_connecting() to be able to
    accept audio_device or tel_client_device
  - protect asynchronous NewConnection method call
- Patch 14:
  - add usage of btd_adapter_ref/unref

Frédéric Danis (14):
  doc: Add telephony interface documents
  audio: Move telephony drivers to D-Bus interface
  audio: Simplify org.bluez.Headset
  audio: Remove dummy telephony driver
  audio: Remove maemo5 telephony driver
  audio: Remove maemo6 telephony driver
  audio: Remove oFono telephony driver
  audio: Move HFP/HSP AG servers to telephony.c
  audio: Send transport path to telephony agent
  audio: Move HFP HF server to telephony.c
  audio: Replace headset and gateway by telephony
  audio: Add DUN GW to org.bluez.Telephony
  audio: Add SAP GW to org.bluez.Telephony
  audio: Add fast connectable to telephony interface

 Makefile.am                    |   19 +-
 audio/audio.conf               |   15 +-
 audio/device.h                 |    1 +
 audio/gateway.c                |  408 ++------
 audio/gateway.h                |    8 +
 audio/headset.c                | 1827 ++++-----------------------------
 audio/headset.h                |   16 +-
 audio/manager.c                |  716 +------------
 audio/manager.h                |    8 +-
 audio/media.c                  |   34 +
 audio/telephony-dummy.c        |  447 --------
 audio/telephony-maemo5.c       | 2105 --------------------------------------
 audio/telephony-maemo6.c       | 2200 ----------------------------------------
 audio/telephony-ofono.c        | 1637 ------------------------------
 audio/telephony.c              | 1574 ++++++++++++++++++++++++++++
 audio/telephony.h              |  205 +---
 audio/transport.c              |  117 ++-
 doc/assigned-numbers.txt       |    2 +
 doc/audio-api.txt              |  235 ++---
 doc/audio-telephony-design.txt |  106 ++
 doc/hfp-api.txt                |   46 -
 doc/media-api.txt              |   19 +-
 22 files changed, 2278 insertions(+), 9467 deletions(-)
 delete mode 100644 audio/telephony-dummy.c
 delete mode 100644 audio/telephony-maemo5.c
 delete mode 100644 audio/telephony-maemo6.c
 delete mode 100644 audio/telephony-ofono.c
 create mode 100644 audio/telephony.c
 create mode 100644 doc/audio-telephony-design.txt

-- 
1.7.9.5

