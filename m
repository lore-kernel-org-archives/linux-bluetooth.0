Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] profile: Add missing browse group to MAS, MNS and SYNC records
Date: Tue, 19 Nov 2013 10:46:31 +0100
Message-Id: <1384854391-13274-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix not updating UUIDs when those services are registered.
---
 src/profile.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index d8cbe6a..baadd99 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -417,6 +417,11 @@
 				</sequence>				\
 			</sequence>					\
 		</attribute>						\
+		<attribute id=\"0x0005\">				\
+			<sequence>					\
+				<uuid value=\"0x1002\" />		\
+			</sequence>					\
+		</attribute>						\
 		<attribute id=\"0x0009\">				\
 			<sequence>					\
 				<sequence>				\
@@ -458,6 +463,11 @@
 				</sequence>				\
 			</sequence>					\
 		</attribute>						\
+		<attribute id=\"0x0005\">				\
+			<sequence>					\
+				<uuid value=\"0x1002\" />		\
+			</sequence>					\
+		</attribute>						\
 		<attribute id=\"0x0009\">				\
 			<sequence>					\
 				<sequence>				\
@@ -496,6 +506,11 @@
 				</sequence>				\
 			</sequence>					\
 		</attribute>						\
+		<attribute id=\"0x0005\">				\
+			<sequence>					\
+				<uuid value=\"0x1002\" />		\
+			</sequence>					\
+		</attribute>						\
 		<attribute id=\"0x0009\">				\
 			<sequence>					\
 				<sequence>				\
-- 
1.8.4.3

