Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 0/2] core: device: GATT fixes
Date: Fri, 16 Jan 2015 19:26:29 -0800
Message-Id: <1421465191-1494-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the following:

  1. Bugs in GATT service browsing code-path that caused GAttrib-based
  profiles to not work and caused D-Bus calls to "Pair" and/or "Connect"
  to hang.

  2. Reintroduced invalid service removal. This patch is the similar as
  the one I submitted previously: it splits the UUID list into SDP and
  GATT based lists and introduces new storage entries, except this patch
  also includes a very simple migration mechanism from the existing
  storage format to the new one.

  The migration works by loading the UUIDs from the "Services" field and
  delaying profile probing until connection establishment. Once a
  connection is established and service discovery is performed, we
  simply store the UUIDs in their new grouping and probe the profiles
  and remove the previous entries. The legacy entries act as temporary
  data that's fed into the Device1.UUIDs property but everything else
  acts as if no services were discovered until connection.

Arman Uguray (2):
  core: device: Fix bug in device_browse_gatt
  core: device: Fix broken GATT UUID management

 plugins/sixaxis.c |   2 +-
 src/adapter.c     |   8 +-
 src/device.c      | 410 +++++++++++++++++++++++++++++++++++++++---------------
 src/device.h      |   6 +-
 4 files changed, 307 insertions(+), 119 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

