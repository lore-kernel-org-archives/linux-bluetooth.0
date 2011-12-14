Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v5 0/8] Add org.bluez.Telephony interface
Date: Wed, 14 Dec 2011 10:05:02 +0100
Message-Id: <1323853510-5195-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

This set of patches replaces telephony drivers for HeadSet/HandsFree
Profiles by a new DBus interface (org.bluez.Telephony).

This will simplify BlueZ code by focusing on Bluetooth communication
part and by letting external application (i.e. oFono) take in charge
the Telephony tasks (AT parsing and modem specific code, which can be
removed from BlueZ code). So, it becomes simpler, easier to maintain
and debug.

External applications, which should implement AT parsing and telephony
part of HeadSet or HandsFree Profiles, will have to register a telephony
agent using this new interface.

Any comments appreciated.

Regards

Fred



Frédéric Danis (8):
  audio: Move tel drivers to DBus interface
  audio: Simplify org.bluez.Headset
  audio: Remove dummy tel driver
  audio: Remove maemo5 tel driver
  audio: Remove maemo6 tel driver
  audio: Remove oFono tel driver
  audio: Move HFP/HSP AG servers to telephony.c
  audio: Send transport path to telephony agent

 Makefile.am              |   17 +-
 audio/headset.c          | 1583 ++--------------------------------
 audio/headset.h          |   14 +-
 audio/manager.c          |  390 +--------
 audio/media.c            |    9 +-
 audio/telephony-dummy.c  |  433 ---------
 audio/telephony-maemo5.c | 2104 --------------------------------------------
 audio/telephony-maemo6.c | 2201 ----------------------------------------------
 audio/telephony-ofono.c  | 1638 ----------------------------------
 audio/telephony.c        |  968 ++++++++++++++++++++
 audio/telephony.h        |  198 +----
 audio/transport.c        |   10 +
 audio/unix.c             |    2 +
 doc/assigned-numbers.txt |    1 +
 doc/audio-api.txt        |  166 ++--
 15 files changed, 1155 insertions(+), 8579 deletions(-)
 delete mode 100644 audio/telephony-dummy.c
 delete mode 100644 audio/telephony-maemo5.c
 delete mode 100644 audio/telephony-maemo6.c
 delete mode 100644 audio/telephony-ofono.c
 create mode 100644 audio/telephony.c

