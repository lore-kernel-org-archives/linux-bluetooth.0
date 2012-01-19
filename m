Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] mgmt-api: Add information about endianness
Date: Thu, 19 Jan 2012 10:52:30 +0100
Message-ID: <1326966750-1528-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Management interface use little-endian byte order and this should be
clearly stated in documentation.
---
 doc/mgmt-api.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 8fe7c94..9627f25 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -23,6 +23,8 @@ Packet Structures
 	+-------------------+-------------------+-------------------+
 	|                                                           |
 
+All fields are in little-endian byte order (least significant byte first).
+
 Controller Index can have a special value <non-controller> to indicate that
 command or event is not related to any controller. Possible values:
 
-- 
on behalf of ST-Ericsson

