Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/2] fakehid: Remove define not referenced
Date: Thu,  5 Apr 2012 19:54:38 -0300
Message-Id: <1333666478-9744-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1333666478-9744-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1333666478-9744-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/fakehid.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/input/fakehid.c b/input/fakehid.c
index f56eb2b..3181538 100644
--- a/input/fakehid.c
+++ b/input/fakehid.c
@@ -44,8 +44,6 @@
 #include "fakehid.h"
 #include "uinput.h"
 
-#define PS3_FLAGS_MASK 0xFFFFFF00
-
 enum ps3remote_special_keys {
 	PS3R_BIT_PS = 0,
 	PS3R_BIT_ENTER = 3,
-- 
1.7.8.5

