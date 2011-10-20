Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Add new dbus telephony driver
Date: Thu, 20 Oct 2011 15:52:14 +0200
Message-Id: <1319118738-20131-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add a new telephony driver allowing HSP/HFP to be managed
through an external DBus agent.
BlueZ takes care of SDP and RFComm parts while the upper layer is
processed by the agent.

Current AT parser and dbus code which are only needed by current
drivers (built-in drivers) are move to telephony-builtin.[ch].

Frédéric Danis (4):
  Audio: move at parsing code to telephony-builtin.[ch] files
  Audio: move dbus callbacks to telephony-builtin.c
  Audio: add adapter to telephony_init/_exit
  Audio: add dbus telephony driver

 Makefile.am               |    9 +-
 acinclude.m4              |    1 +
 audio/headset.c           | 1485 +++----------------------------------------
 audio/headset.h           |    4 +
 audio/manager.c           |    4 +-
 audio/telephony-builtin.c | 1570 +++++++++++++++++++++++++++++++++++++++++++++
 audio/telephony-builtin.h |  218 +++++++
 audio/telephony-dbus.c    |  554 ++++++++++++++++
 audio/telephony-dummy.c   |    5 +-
 audio/telephony-maemo5.c  |    5 +-
 audio/telephony-maemo6.c  |    5 +-
 audio/telephony-ofono.c   |    5 +-
 audio/telephony.h         |  225 +------
 doc/audio-api.txt         |   99 +++
 14 files changed, 2590 insertions(+), 1599 deletions(-)
 create mode 100644 audio/telephony-builtin.c
 create mode 100644 audio/telephony-builtin.h
 create mode 100644 audio/telephony-dbus.c

