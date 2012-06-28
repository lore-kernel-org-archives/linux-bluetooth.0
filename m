Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v11 00/12] Add org.bluez.Telephony interface
Date: Thu, 28 Jun 2012 18:15:43 +0200
Message-Id: <1340900155-26311-1-git-send-email-frederic.danis@linux.intel.com>
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
- Remove line at end of audio-telephony-design.txt
- use same connection code for DUN and SAP support

Frédéric Danis (12):
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
 audio/telephony.c              | 1519 +++++++++++++++++++++++++++
 audio/telephony.h              |  196 +---
 audio/transport.c              |  117 ++-
 audio/unix.c                   |    2 +
 doc/assigned-numbers.txt       |    2 +
 doc/audio-api.txt              |  244 ++---
 doc/audio-telephony-design.txt |  107 ++
 doc/hfp-api.txt                |   46 -
 doc/media-api.txt              |   19 +-
 23 files changed, 2210 insertions(+), 9592 deletions(-)
 delete mode 100644 audio/telephony-dummy.c
 delete mode 100644 audio/telephony-maemo5.c
 delete mode 100644 audio/telephony-maemo6.c
 delete mode 100644 audio/telephony-ofono.c
 create mode 100644 audio/telephony.c
 create mode 100644 doc/audio-telephony-design.txt

-- 
1.7.9.5

