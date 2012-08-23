Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v18 00/16] Add org.bluez.Telephony interface
Date: Thu, 23 Aug 2012 16:38:49 +0200
Message-Id: <1345732745-28706-1-git-send-email-frederic.danis@linux.intel.com>
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
part of Headset or Handsfree Profiles, will have to register a telephony
agent using this new interface.

Any comments appreciated.

Regards

PS: Since latest Patch set:
- Split patch 1 between telephony interface design and update of
  audio-api.txt
- Update design to remove reference of MediaTransport in telephony
  agent.
  This is replaced by a new TelephonyConnection interface which should
  be implemented by telephony agent and returned on NewConnection
  method call.
- Move all patches removing telephony drivers and code related to them
  in headset.c at beginning of patch set (patches 4 to 8), this should
  simplify code review.

Frédéric Danis (16):
  doc: Add telephony interface design document
  doc: Add telephony interface to audio-api.txt
  doc: Add HSP HS channel to assigned numbers
  audio: Remove telephony driver from headset.c
  audio: Remove dummy telephony driver
  audio: Remove maemo5 telephony driver
  audio: Remove maemo6 telephony driver
  audio: Remove oFono telephony driver
  audio: Add org.bluez.Telephony interface
  audio: Add headset audio properties to MediaTransport
  audio: Move HFP/HSP AG servers to telephony.c
  audio: Move HFP HF server to telephony.c
  audio: Add DUN GW to org.bluez.Telephony
  audio: Add SAP GW to org.bluez.Telephony
  adapter: Add API to get fast connectable mode
  audio: Add fast connectable to telephony interface

 .gitignore                     |    1 -
 Makefile.am                    |   19 +-
 audio/audio.conf               |    7 -
 audio/device.h                 |    1 +
 audio/gateway.c                |  487 ++++-----
 audio/gateway.h                |    7 +
 audio/headset.c                | 1976 ++++++++----------------------------
 audio/headset.h                |   28 +-
 audio/manager.c                |  628 +-----------
 audio/manager.h                |    4 -
 audio/telephony-dummy.c        |  447 --------
 audio/telephony-maemo5.c       | 2105 --------------------------------------
 audio/telephony-maemo6.c       | 2200 ----------------------------------------
 audio/telephony-ofono.c        | 1637 ------------------------------
 audio/telephony.c              | 1705 +++++++++++++++++++++++++++++++
 audio/telephony.h              |  202 +---
 audio/transport.c              |   94 +-
 doc/assigned-numbers.txt       |    2 +
 doc/audio-api.txt              |  296 +++---
 doc/audio-telephony-design.txt |  318 ++++++
 doc/hfp-api.txt                |   46 -
 doc/media-api.txt              |   12 +
 src/adapter.c                  |   15 +-
 src/adapter.h                  |    1 +
 24 files changed, 3001 insertions(+), 9237 deletions(-)
 delete mode 100644 audio/telephony-dummy.c
 delete mode 100644 audio/telephony-maemo5.c
 delete mode 100644 audio/telephony-maemo6.c
 delete mode 100644 audio/telephony-ofono.c
 create mode 100644 audio/telephony.c
 create mode 100644 doc/audio-telephony-design.txt

-- 
1.7.9.5

