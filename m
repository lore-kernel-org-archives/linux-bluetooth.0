Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 0/4] GATT server API fixes
Date: Wed,  4 Mar 2015 13:57:47 -0800
Message-Id: <1425506271-20775-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set includes some minor bug fixes for the GATT server D-Bus API and
adds the missing implementation for the GattManager1.UnregisterService method.

Arman Uguray (4):
  core/adapter: Deduplicate local service UUIDs
  core/gatt: Fix crash in gatt-database destructor
  core/gatt: Remove spammy log messages
  core/gatt: Add UnregisterService and track sender

 src/adapter.c       | 30 +++++++++++++++++--------
 src/gatt-database.c | 63 +++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 70 insertions(+), 23 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

