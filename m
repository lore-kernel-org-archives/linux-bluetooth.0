Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] deviceinfo: Remove redundant gattrib include
Date: Wed, 15 Aug 2012 11:19:38 -0300
Message-Id: <1345040379-17704-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/deviceinfo/deviceinfo.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index 4548553..ca849ad 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -32,7 +32,6 @@
 #include "gattrib.h"
 #include "attio.h"
 #include "att.h"
-#include "gattrib.h"
 #include "gatt.h"
 #include "log.h"
 #include "deviceinfo.h"
-- 
1.7.8.6

