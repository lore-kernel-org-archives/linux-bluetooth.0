Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/5] Fixes for memory leaks
Date: Fri,  7 Feb 2014 19:28:40 -0300
Message-Id: <1391812125-19594-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch set fixes some memory leaks reported by clang static analyzer.
There is no relation between patches of this set so they can be applied
independently.

BR,

Andre


Andre Guedes (5):
  hcitool: Fix memory leak in cmd_info
  hcidump: Fix memory leak
  cltest: Fix memory leak
  amptest: Fix memory leak
  rctest: Fix memory leak

 tools/amptest.c | 12 ++++++++----
 tools/cltest.c  |  5 +++--
 tools/hcidump.c |  9 +++++++--
 tools/hcitool.c |  3 +++
 tools/rctest.c  |  5 ++++-
 5 files changed, 25 insertions(+), 9 deletions(-)

-- 
1.8.5.3

