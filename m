Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 06/16] Change DiscoverSchedulerInterval default value
Date: Fri, 29 Apr 2011 21:27:22 -0300
Message-Id: <1304123252-14464-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes the default value of "DiscoverSchedulerInterval"
from 0 to 30 seconds.

Since Periodic Inquiry is not supported anymore, the option
"DiscoverSchedulerInterval" in main.conf must be updated. As
a first attempt, it was chosen a 30 seconds interval.
---
 src/main.conf |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/main.conf b/src/main.conf
index c03f135..8cd132f 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -27,8 +27,8 @@ PairableTimeout = 0
 PageTimeout = 8192
 
 # Discover scheduler interval used in Adapter.DiscoverDevices
-# The value is in seconds. Defaults is 0 to use controller scheduler.
-DiscoverSchedulerInterval = 0
+# The value is in seconds. Defaults is 30.
+DiscoverSchedulerInterval = 30
 
 # What value should be assumed for the adapter Powered property when
 # SetProperty(Powered, ...) hasn't been called yet. Defaults to true
-- 
1.7.1

