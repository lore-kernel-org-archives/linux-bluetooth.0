Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Docs: printk-formats: add description for %pMR
Date: Wed, 20 Jun 2012 13:44:49 +0300
Message-Id: <1340189089-20257-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1338210316-12299-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1338210316-12299-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add information about new specifier %pMR for Bluetooth addresses.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 Documentation/printk-formats.txt |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/printk-formats.txt b/Documentation/printk-formats.txt
index 5df176e..d8d168f 100644
--- a/Documentation/printk-formats.txt
+++ b/Documentation/printk-formats.txt
@@ -56,6 +56,7 @@ Struct Resources:
 MAC/FDDI addresses:
 
 	%pM	00:01:02:03:04:05
+	%pMR	05:04:03:02:01:00
 	%pMF	00-01-02-03-04-05
 	%pm	000102030405
 
@@ -67,6 +68,10 @@ MAC/FDDI addresses:
 	the 'M' specifier to use dash ('-') separators instead of the default
 	separator.
 
+	For Bluetooth addresses the 'R' specifier shall be used after the 'M'
+	specifier to use reversed byte order suitable for visual interpretation
+	of Bluetooth addresses which are in the little endian order.
+
 IPv4 addresses:
 
 	%pI4	1.2.3.4
-- 
1.7.9.5

