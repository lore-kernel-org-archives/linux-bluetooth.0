Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v16 00/14] Add org.bluez.Telephony interface
Date: Wed,  1 Aug 2012 11:08:36 +0200
Message-Id: <1343812131-19395-1-git-send-email-frederic.danis@linux.intel.com>
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
- patch 1 and 2: remove UUID property from NewConnection method of TelephonyAgent
- patch 2:
  - rename headset_slc_complete() to headset_profile_connection_complete()
  - rename telephony_get_ready_state() to telephony_is_ready()
  - change return type of parse_properties() to gboolean
  - ref/unref GIOChannel used in telephony_device structure
  - fix parameter type of hs_dev_disconnect_cb()
  - manage dbus error first in hs_newconnection_reply()
  - use sdp_uuid_cmp() instead of sdp_uuid16_cmp() in get_record_cb()
  - if sdp service search is in progress, cancel it in telephony_device_disconnect()
  - merge register_interface() into telephony_adapter_init()
  - merge unregister_interface() into telephony_adapter_exit()
  - set connecting_uuid to NULL when going to disconnected state in headset_set_state()
- patch 3: remove rfcomm in headset structure as it is now managed in telephony.c
    this imply to unref tmp_rfcomm after call of telephony_device_connecting()
- patch 9:
  - rename connecting_path to connecting_transport_path in headset structure
  - set connecting_transport_path to NULL when going to disconnected state in
    headset_set_state()
- patch 10:
  - rename rfcomm to tmp_rfcomm in gateway structure as it is now managed
    in telephony.c
    this imply to unref tmp_rfcomm after call of telephony_device_connecting()
  - rename connecting_path to connecting_transport_path in gateway structure
  - set connecting_uuid and connecting_transport_path to NULL when going to
    disconnected state in gateway_close()
  - fix parameter type of ag_dev_disconnect_cb()
  - manage dbus error first in ag_newconnection_reply()
- patch 11:
  - rename rfcomm to tmp_rfcomm in connecting_device structure
    this tmp_rfcomm should be unrefed after call of telephony_device_connecting()
  - fix parameter type of client_dev_disconnect_cb()
  - manage dbus error first in client_newconnection_reply()

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
 audio/gateway.c                |  436 +++-----
 audio/gateway.h                |    8 +
 audio/headset.c                | 1844 ++++-----------------------------
 audio/headset.h                |   16 +-
 audio/manager.c                |  628 +-----------
 audio/manager.h                |    4 -
 audio/media.c                  |   34 +
 audio/telephony-dummy.c        |  447 --------
 audio/telephony-maemo5.c       | 2105 --------------------------------------
 audio/telephony-maemo6.c       | 2200 ----------------------------------------
 audio/telephony-ofono.c        | 1637 ------------------------------
 audio/telephony.c              | 1634 +++++++++++++++++++++++++++++
 audio/telephony.h              |  205 +---
 audio/transport.c              |  117 ++-
 doc/assigned-numbers.txt       |    2 +
 doc/audio-api.txt              |  232 ++---
 doc/audio-telephony-design.txt |  106 ++
 doc/hfp-api.txt                |   46 -
 doc/media-api.txt              |   19 +-
 src/adapter.c                  |   15 +-
 src/adapter.h                  |    1 +
 24 files changed, 2349 insertions(+), 9414 deletions(-)
 delete mode 100644 audio/telephony-dummy.c
 delete mode 100644 audio/telephony-maemo5.c
 delete mode 100644 audio/telephony-maemo6.c
 delete mode 100644 audio/telephony-ofono.c
 create mode 100644 audio/telephony.c
 create mode 100644 doc/audio-telephony-design.txt

-- 
1.7.9.5

