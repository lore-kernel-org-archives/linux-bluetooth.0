Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 0/6] Fix state callbacks register/unregister in audio code
Date: Tue, 5 Mar 2013 15:59:49 +0100
Message-ID: <1362495595-17492-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

V2 fixes issues pointed by Luiz:
 - callback registartion functions now takes device as first argument
 - fixed typo in commit message
 - fixed bogus return instead of continue in source_set_state

Szymon Janc (6):
  avdtp: Register state callback for specified audio device
  avdtp: Remove user data from avdtp_session_state_cb
  avctp: Allow to register state callback for specified audio device
  avctp: Remove user data from avctp_session_state_cb
  sink: Register state callback for specified audio device
  source: Register state callback for specified audio device

 profiles/audio/avctp.c     | 12 ++++++++----
 profiles/audio/avctp.h     |  5 ++---
 profiles/audio/avdtp.c     | 13 +++++++++----
 profiles/audio/avdtp.h     |  6 +++---
 profiles/audio/avrcp.c     |  4 ++--
 profiles/audio/control.c   | 10 +++++-----
 profiles/audio/device.c    | 33 ++++++++++++++++-----------------
 profiles/audio/sink.c      | 26 ++++++++++++++------------
 profiles/audio/sink.h      |  3 ++-
 profiles/audio/source.c    | 27 +++++++++++++++------------
 profiles/audio/source.h    |  3 ++-
 profiles/audio/transport.c | 10 ++--------
 12 files changed, 80 insertions(+), 72 deletions(-)

-- 
1.8.1.5

