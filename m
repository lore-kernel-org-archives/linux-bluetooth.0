Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1 0/3] Fix memory issues and trivial code cleaup
Date: Tue, 27 Jan 2015 14:23:17 +0530
Message-id: <1422348800-5668-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In gatt-client and gatt-helpers, the variables are accessed
even after it is freed. Making the unref at appropriate
places solved the issues.

In tools, removed dead code warnings.

*v1: Rebased.

Gowtham Anandha Babu (3):
  shared/gatt-helpers: Fix usage of freed memory
  shared/gatt-client: Fix usage of freed memory
  tools/hciattach_ath3k: Remove dead code warnings

 src/shared/gatt-client.c  | 16 +++++++++-------
 src/shared/gatt-helpers.c | 25 ++++++++++++++++---------
 tools/hciattach_ath3k.c   | 11 +----------
 3 files changed, 26 insertions(+), 26 deletions(-)

-- 
1.9.1

