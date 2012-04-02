Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v9 0/9] Add org.bluez.Telephony interface
Date: Mon,  2 Apr 2012 15:11:14 +0200
Message-Id: <1333372283-10487-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

This set of patches replaces telephony drivers for HeadSet/HandsFree
Profiles by a new DBus interface (org.bluez.Telephony).

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
Patch 1:
  - Fix +BSIR flowchart in doc/audio-telephony-design.txt
Patch 2:
  - Fix type of microphone and speaker gain in media transport struct
Patch 9:
  - Remove dead code related to gateway server

Fred

Frédéric Danis (9):
  audio: Move tel drivers to DBus interface
  audio: Simplify org.bluez.Headset
  audio: Remove dummy tel driver
  audio: Remove maemo5 tel driver
  audio: Remove maemo6 tel driver
  audio: Remove oFono tel driver
  audio: Move HFP/HSP AG servers to telephony.c
  audio: Send transport path to telephony agent
  audio: Move HFP HF server to telephony.c

 Makefile.am                    |   17 +-
 audio/device.h                 |    1 +
 audio/gateway.c                |  392 ++------
 audio/gateway.h                |    8 +
 audio/headset.c                | 1728 ++------------------------------
 audio/headset.h                |   16 +-
 audio/manager.c                |  608 +-----------
 audio/media.c                  |   18 +-
 audio/telephony-dummy.c        |  433 --------
 audio/telephony-maemo5.c       | 2104 --------------------------------------
 audio/telephony-maemo6.c       | 2201 ----------------------------------------
 audio/telephony-ofono.c        | 1638 ------------------------------
 audio/telephony.c              | 1185 +++++++++++++++++++++
 audio/telephony.h              |  196 +----
 audio/transport.c              |  114 ++-
 audio/unix.c                   |    2 +
 doc/assigned-numbers.txt       |    1 +
 doc/audio-api.txt              |  244 ++---
 doc/audio-telephony-design.txt |  108 ++
 doc/hfp-api.txt                |   48 -
 doc/media-api.txt              |   15 +-
 21 files changed, 1704 insertions(+), 9373 deletions(-)
 delete mode 100644 audio/telephony-dummy.c
 delete mode 100644 audio/telephony-maemo5.c
 delete mode 100644 audio/telephony-maemo6.c
 delete mode 100644 audio/telephony-ofono.c
 create mode 100644 audio/telephony.c
 create mode 100644 doc/audio-telephony-design.txt

