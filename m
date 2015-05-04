Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 0/4] Fix clang compile errors/warnings
Date: Mon,  4 May 2015 16:28:10 -0700
Message-Id: <1430782094-18396-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set fixes some clang compile errors and warnings. These do
not cover errors that are produced when BlueZ for Android is compiled
using clang (i.e. passing --disable-android to ./bootstrap-configure).

Arman Uguray (4):
  plugins/policy: Fix clang compile error
  tools/smp-tester: Remove unused variable.
  tools/mgmt-tester: Remove unused set_adv_data_2
  tools/gatt-service: Fix clang compile error

 plugins/policy.c     |  8 ++++----
 tools/gatt-service.c |  4 +---
 tools/mgmt-tester.c  | 46 +++++++++++++++++++---------------------------
 tools/smp-tester.c   |  9 ---------
 4 files changed, 24 insertions(+), 43 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

