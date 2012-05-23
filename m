Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 00/12] Redundant D-Bus error init, remove unwanted code,
 g_free missmatch etc
Date: Wed, 23 May 2012 21:27:20 +0530
Message-id: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series of patches resolves:
Memory leak, free - g_free mismatch, redundant D-Bus error initilization
and remove unwanted code.

Syam Sidhardhan (12):
  monitor: Fix memory leak
  storage: Use g_free() instead of free()
  media: Remove redundant D-Bus error initilization
  telephony-maemo5: Remove redundant D-Bus error initilizations
  telephony-maemo6: Remove redundant D-Bus error initilization
  telephony-ofono: Remove redundant D-Bus error initilization
  agent: Remove redundant D-Bus error initilizations
  Remove redundant D-Bus error initilization in maemo6 plugin
  avctp: Fix NULL check after dereference
  adapter: Remove unwanted if check and code
  audio: Remove unwanted code from manager
  input: Remove unwanted codes from device

 audio/avctp.c            |    3 ++-
 audio/manager.c          |    2 --
 audio/media.c            |    1 -
 audio/telephony-maemo5.c |    5 -----
 audio/telephony-maemo6.c |    1 -
 audio/telephony-ofono.c  |    1 -
 input/device.c           |    5 -----
 monitor/hcidump.c        |    3 ++-
 plugins/maemo6.c         |    1 -
 src/adapter.c            |    3 ---
 src/agent.c              |    5 -----
 src/storage.c            |    6 +++---
 12 files changed, 7 insertions(+), 29 deletions(-)

-- 
1.7.4.1

