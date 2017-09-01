Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 1/2] doc/btsnoop: Add nop opcode
Date: Fri,  1 Sep 2017 10:07:43 +0200
Message-Id: <20170901080744.11544-1-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds 'no operation' opcode for the cases where we do not want to
include any particular payload, just the header is valid.

For example, when some packets are dropped over TTY implementation can
pass this information only in some other packet and this won't happen
until there's actually something to send. With this addition it can
just send nop after some time to indicate there were packets dropped.
---
 doc/btsnoop.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/btsnoop.txt b/doc/btsnoop.txt
index 975a53f6d..865b81554 100644
--- a/doc/btsnoop.txt
+++ b/doc/btsnoop.txt
@@ -115,6 +115,13 @@ User Logging
 
 	User logging information.
 
+NOP
+-----------
+
+	Code:        0xffff
+
+	No operation.
+
 
 TTY-based protocol
 ==================
-- 
2.14.1

