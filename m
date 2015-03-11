Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Fix collision in AVCTP connection
Date: Wed, 11 Mar 2015 19:10:59 +0100
Message-Id: <1426097463-5288-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set corresponds to previous RFC with the same subject.
Now reconnection logic is moved to policy. Avrcp and avctp
modules are responsible for passing correct error to higher
layer, policy detects collision and set random timer for reconnection.
Comments are welcome

Marcin Kraglak (4):
  audio/avctp: Pass error argument to avctp_state_changed callback
  audio/avrcp: Pass error to session_destroy()
  audio/avctp: Cancel outgoing connection in case of conflict
  plugins/policy: Try reconnect Control/Target services

 plugins/policy.c         | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/avctp.c   | 45 ++++++++++++++++-----------
 profiles/audio/avctp.h   |  2 +-
 profiles/audio/avrcp.c   | 11 ++++---
 profiles/audio/control.c |  3 +-
 5 files changed, 116 insertions(+), 25 deletions(-)

-- 
2.1.0

