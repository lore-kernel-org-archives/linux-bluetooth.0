Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  0/3] Fix memory issue and trivial code cleaup
Date: Wed, 14 Jan 2015 15:27:35 +0530
Message-id: <1421229458-11207-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In gatt-client and gatt-helpers, the variables are accessed
even after it is freed. Making the unref at appropriate
places solved the issues.

In tools, removed dead code warnings.

Gowtham Anandha Babu (3):
  shared/gatt-helpers: Fix usage of freed memory
  shared/gatt-client: Fix usage of freed memory
  tools/hciattach_ath3k: Remove dead code warnings

 src/shared/gatt-client.c  | 23 +++++++++++------------
 src/shared/gatt-helpers.c | 25 ++++++++++++++++---------
 tools/hciattach_ath3k.c   | 11 +----------
 3 files changed, 28 insertions(+), 31 deletions(-)

-- 
1.9.1

