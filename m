Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org, frederic.danis@linux.intel.com
Subject: [RFC v2 0/4] Add org.bluez.Telephony interface
Date: Thu,  1 Dec 2011 15:16:26 +0100
Message-Id: <1322748990-14347-1-git-send-email-frederic.danis@linux.intel.com>
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

Second patch remove the telephony drivers (dummy, maemo5, maemo6
and ofono), functions used by telephony drivers and no more needed
methods of org.bluez.Headset interface.

Third patch move the HS/HF AG rfcomm servers from audio/manager.c to
audio/telephony.c.
Rfcomm server for a specific profile is only started (and the related
sdp records advertised) when an agent register for it.

Fourth patch passes MediaTransport path to the agent during
NewConnection mehod call. So, telephony agent will be able to set NREC
and ringtone, which can in turn notify Pulse Audio of property changed.

What I would like to do to continue is:
  - add org.bluez.HeadsetGataway, which will replace
  org.bluez.HandsfreeGateway (audio/gateway.c)


Any comments appreciated

Regards

Fred
Frédéric Danis (4):
  audio: Move tel drivers to DBus interface
  audio: Remove tel drivers
  audio: Move HFP/HSP AG servers to telephony.c
  audio: Send transport path to telephony agent

 Makefile.am              |   17 +-
 audio/headset.c          | 1561 ++-------------------------------
 audio/headset.h          |   14 +-
 audio/manager.c          |  390 +--------
 audio/media.c            |    9 +-
 audio/telephony-dummy.c  |  433 ---------
 audio/telephony-maemo5.c | 2104 --------------------------------------------
 audio/telephony-maemo6.c | 2201 ----------------------------------------------
 audio/telephony-ofono.c  | 1638 ----------------------------------
 audio/telephony.c        |  960 ++++++++++++++++++++
 audio/telephony.h        |  198 +----
 audio/transport.c        |   10 +
 audio/unix.c             |    2 +
 doc/assigned-numbers.txt |    1 +
 doc/audio-api.txt        |   91 ++
 15 files changed, 1148 insertions(+), 8481 deletions(-)
 delete mode 100644 audio/telephony-dummy.c
 delete mode 100644 audio/telephony-maemo5.c
 delete mode 100644 audio/telephony-maemo6.c
 delete mode 100644 audio/telephony-ofono.c
 create mode 100644 audio/telephony.c

