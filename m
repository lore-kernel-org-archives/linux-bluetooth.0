Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v1 0/2] Add org.bluez.Telephony interface
Date: Tue, 22 Nov 2011 17:21:27 +0100
Message-Id: <1321978889-20418-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am working on this set of patches.

Replace telephony drivers for HeadSet/HandsFree Profiles by a new DBus
interface (org.bluez.Telephony).
External applications, which should implement AT parsing and telephony
part of HeadSet or HandsFree Profiles, will have to register a telephony
agent using this new interface.


First patch add the new org.bluez.Telephony interface and remove
functions related to AT parsing from audio/headset.c.

Second patch remove the telephony drivers (dummy, maemo5, maemo6
and ofono), functions used by telephony drivers and no more needed
methods of org.bluez.Headset interface.


What I would like to do to continue is:
  - move rfcomm servers from audio/manager.c to audio/telephony.c, so
  servers are started only when a telephony agent is registered. This
  should also replace audio/gateway.c.

  - pass MediaTransport object in NewConnection method so telephony
  agent will be able to set NREC and ringtone, which can in turn notify
  Pulse Audio of property changed.


Any comments appreciated

Regards

Fred

Frédéric Danis (2):
  audio: Move tel drivers to DBus interface
  audio: Remove tel drivers

 Makefile.am              |   17 +-
 audio/headset.c          | 1517 +-------------------------------
 audio/headset.h          |    7 +-
 audio/manager.c          |    4 +-
 audio/telephony-dummy.c  |  433 ---------
 audio/telephony-maemo5.c | 2104 --------------------------------------------
 audio/telephony-maemo6.c | 2201 ----------------------------------------------
 audio/telephony-ofono.c  | 1638 ----------------------------------
 audio/telephony.c        |  494 +++++++++++
 audio/telephony.h        |  196 +----
 audio/transport.c        |   10 +
 audio/unix.c             |    2 +
 doc/audio-api.txt        |   91 ++
 13 files changed, 623 insertions(+), 8091 deletions(-)
 delete mode 100644 audio/telephony-dummy.c
 delete mode 100644 audio/telephony-maemo5.c
 delete mode 100644 audio/telephony-maemo6.c
 delete mode 100644 audio/telephony-ofono.c
 create mode 100644 audio/telephony.c

