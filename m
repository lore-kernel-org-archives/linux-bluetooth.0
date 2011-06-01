Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH] Adjust parameters in obexd.service.in
Date: Wed,  1 Jun 2011 15:05:29 +0200
Message-Id: <1306933529-4270-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adjusts obexd.service.in to changes introduced in commit
e7792642accead1de0016bd7f78c74d9b6cad38a, retaining original behaviour.
---
 src/obexd.service.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/obexd.service.in b/src/obexd.service.in
index 24571bd..5c6ba0f 100644
--- a/src/obexd.service.in
+++ b/src/obexd.service.in
@@ -1,3 +1,3 @@
 [D-BUS Service]
 Name=org.openobex
-Exec=@libexecdir@/obexd --nodaemon --opp --ftp
+Exec=@libexecdir@/obexd --nodaemon --plugin=bluetooth:usb:opp:ftp
-- 
1.7.4.1

