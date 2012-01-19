Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v8 0/9] Add org.bluez.Telephony interface
Date: Thu, 19 Jan 2012 15:24:31 +0100
Message-Id: <1326983080-10927-1-git-send-email-frederic.danis@linux.intel.com>
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

PS: Since latest RFC :
  - update telephony.c to support multiple roles (headset.c and gateway.c)
Patch 1:
  - remove experimental flag for org.bluez.Telephony interface
  - fix Device property type of TelephonyAgent and send it upon connection
  - remove HS roles, will be integrated in patch 9
  - add watcher on agent disconnection in telephony.c
Patch 2:
  - remove deprecated APIs (IsConnected, IsPlaying and Play) of org.bluez.Headset interface
  - remove useless methods from org.bluez.HeadsetGateway
New patch 9:
  - move HFP HF server from audio/manager.c to audio/telephony.c
  - update audio/gateway.c to reflect this change and use new interface

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
 audio/manager.c                |  534 +----------
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
 doc/audio-telephony-design.txt |   91 ++
 doc/hfp-api.txt                |   48 -
 doc/media-api.txt              |   15 +-
 21 files changed, 1690 insertions(+), 9296 deletions(-)
 delete mode 100644 audio/telephony-dummy.c
 delete mode 100644 audio/telephony-maemo5.c
 delete mode 100644 audio/telephony-maemo6.c
 delete mode 100644 audio/telephony-ofono.c
 create mode 100644 audio/telephony.c
 create mode 100644 doc/audio-telephony-design.txt

