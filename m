Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v15 00/14] Add org.bluez.Telephony interface
Date: Thu, 26 Jul 2012 10:45:10 +0200
Message-Id: <1343292324-959-1-git-send-email-frederic.danis@linux.intel.com>
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
- Add new patch to add btd_adapter_get_fast_connectable() API
- remove patch replacing Headset and Gateway services by Telephony service
- rename structure tel_device to telephony_device and add comments
- rename structure tel_agent to telephony_agent and add comments
- rename structure default_agent to profile_config and add comments
- remove void pointers
- replace telephony_agent_by_uuid() by telephony_is_uuid_supported()
- use uuid instead of agent pointer in telephony_device_connecting()
- remove DBUS_TYPE_UNIX_FD check
- Patch 12:
  - Free RFCOMM channel on disconnection or error

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
  audio: Add DUN GW to org.bluez.Telephony
  audio: Add SAP GW to org.bluez.Telephony
  adapter: Add API to get fast connectable mode
  audio: Add fast connectable to telephony interface

 Makefile.am                    |   19 +-
 audio/audio.conf               |    7 -
 audio/device.h                 |    1 +
 audio/gateway.c                |  406 ++------
 audio/gateway.h                |    8 +
 audio/headset.c                | 1825 ++++-----------------------------
 audio/headset.h                |   16 +-
 audio/manager.c                |  628 +-----------
 audio/manager.h                |    4 -
 audio/media.c                  |   34 +
 audio/telephony-dummy.c        |  447 --------
 audio/telephony-maemo5.c       | 2105 --------------------------------------
 audio/telephony-maemo6.c       | 2200 ----------------------------------------
 audio/telephony-ofono.c        | 1637 ------------------------------
 audio/telephony.c              | 1632 +++++++++++++++++++++++++++++
 audio/telephony.h              |  205 +---
 audio/transport.c              |  117 ++-
 doc/assigned-numbers.txt       |    2 +
 doc/audio-api.txt              |  235 ++---
 doc/audio-telephony-design.txt |  106 ++
 doc/hfp-api.txt                |   46 -
 doc/media-api.txt              |   19 +-
 src/adapter.c                  |   15 +-
 src/adapter.h                  |    1 +
 24 files changed, 2324 insertions(+), 9391 deletions(-)
 delete mode 100644 audio/telephony-dummy.c
 delete mode 100644 audio/telephony-maemo5.c
 delete mode 100644 audio/telephony-maemo6.c
 delete mode 100644 audio/telephony-ofono.c
 create mode 100644 audio/telephony.c
 create mode 100644 doc/audio-telephony-design.txt

-- 
1.7.9.5

