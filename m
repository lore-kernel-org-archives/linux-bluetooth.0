Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 2/2] Small fix in Health API documentation
Date: Wed,  3 Nov 2010 12:06:28 -0200
Message-Id: <1288793188-11514-2-git-send-email-epx@signove.com>
In-Reply-To: <1288793188-11514-1-git-send-email-epx@signove.com>
References: <1288793188-11514-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Channel path skeleton is fixed in documentation, in order to
reflect atual implementation.
---
 doc/health-api.txt |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/doc/health-api.txt b/doc/health-api.txt
index 3034666..a0a1685 100644
--- a/doc/health-api.txt
+++ b/doc/health-api.txt
@@ -119,8 +119,7 @@ Properties:
 
 Service		org.bluez
 Interface	org.bluez.HealthChannel
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/
-							hdp_YYYY/channel_ZZ
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/chanZZZ
 
 Only the process that created the data channel or the creator of the
 HealthApplication that received it will be able to call this methods.
-- 
1.7.0.4

