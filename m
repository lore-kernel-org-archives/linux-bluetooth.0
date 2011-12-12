Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v4 0/6] Add org.bluez.Telephony interface
Date: Mon, 12 Dec 2011 11:49:08 +0100
Message-Id: <1323686954-11899-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

This set of patches replaces telephony drivers for HeadSet/HandsFree
Profiles by a new DBus interface (org.bluez.Telephony).
External applications, which should implement AT parsing and telephony
part of HeadSet or HandsFree Profiles, will have to register a telephony
agent using this new interface.


First patch add the new org.bluez.Telephony interface and remove
functions related to AT parsing from audio/headset.c.

Second, third and fourth patches remove the telephony drivers (dummy,
maemo5, maemo6 and ofono), functions used by telephony drivers and no
more needed methods of org.bluez.Headset interface.

Fifth patch move the HS/HF AG rfcomm servers from audio/manager.c to
audio/telephony.c.
Rfcomm server for a specific profile is only started (and the related
sdp records advertised) when an agent register for it.

Sixth patch passes MediaTransport path to the agent during
NewConnection mehod call. So, telephony agent will be able to set NREC
and ringtone, which can in turn notify Pulse Audio of property changed.


Any comments appreciated

Regards

Fred

Frédéric Danis (6):
  audio: Move tel drivers to DBus interface
  audio: Remove tel drivers
  audio: Remove maemo5 tel driver
  audio: Remove maemo6 tel driver
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

