Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/2] Disable Path Loss service in configuration file
Date: Fri, 19 Aug 2011 11:11:59 -0300
Message-Id: <1313763119-8551-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1313763119-8551-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1313763119-8551-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Path Loss service requires kernel and userspace patches to work
properly. Keep it disabled while the implementation is not ready.
---
 proximity/proximity.conf |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/proximity/proximity.conf b/proximity/proximity.conf
index f4ef6f5..417610f 100644
--- a/proximity/proximity.conf
+++ b/proximity/proximity.conf
@@ -4,6 +4,6 @@
 # particular interface
 [General]
 
-# If we want to disable support for specific services
-# Defaults to supporting all implemented services
-#Disable=LinkLoss,PathLoss,FindMe
+# Configuration to allow disabling Proximity services
+# Allowed values: LinkLoss,PathLoss,FindMe
+Disable=PathLoss
-- 
1.7.6

