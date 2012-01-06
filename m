Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v7 0/8] Add org.bluez.Telephony interface
Date: Fri,  6 Jan 2012 16:07:47 +0100
Message-Id: <1325862475-11607-1-git-send-email-frederic.danis@linux.intel.com>
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
Patch 1:
  - NewConnection API: fix MediaTransport properties type and name
  - add audio telephony design doc
  - fix temporary headset_connect_cb() version
  - free telephony structure in telephony_device_disconnect() instead of
    headset_close_rfcomm
  - add telephony_adapter_init and telephony_adapter_exit
  - separate telephony tel_agent and tel_device structures so telephony
    agent can be removed easily
  - link tel_agent to btd_adapter it was registered for
Patch 2:
  - fix SpeakerGain and MicrophoneGain properties emission
Patch 7:
  - fix headset.c get_records to correctly find the right AG profile to
    try to connect to, depending on agents registered and bluetoothd
    configuration
  - remove HF ready tests, as if an agent for AHF AG exists, it is ready
  - fix features value in sdp record for HFP
Patch 8:
  - fix type and name form NewConnection call

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

 Makefile.am                    |   17 +-
 audio/headset.c                | 1645 ++----------------------------
 audio/headset.h                |   17 +-
 audio/manager.c                |  398 +-------
 audio/media.c                  |    9 +-
 audio/telephony-dummy.c        |  433 --------
 audio/telephony-maemo5.c       | 2104 --------------------------------------
 audio/telephony-maemo6.c       | 2201 ----------------------------------------
 audio/telephony-ofono.c        | 1638 ------------------------------
 audio/telephony.c              | 1016 ++++++++++++++++++
 audio/telephony.h              |  195 +----
 audio/transport.c              |  101 ++-
 audio/unix.c                   |    2 +
 doc/assigned-numbers.txt       |    1 +
 doc/audio-api.txt              |  166 ++--
 doc/audio-telephony-design.txt |   91 ++
 doc/media-api.txt              |   15 +-
 17 files changed, 1389 insertions(+), 8660 deletions(-)
 delete mode 100644 audio/telephony-dummy.c
 delete mode 100644 audio/telephony-maemo5.c
 delete mode 100644 audio/telephony-maemo6.c
 delete mode 100644 audio/telephony-ofono.c
 create mode 100644 audio/telephony.c
 create mode 100644 doc/audio-telephony-design.txt

