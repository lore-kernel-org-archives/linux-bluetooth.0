Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] Remove sdp headers include from Generic Attribute
Date: Wed, 21 Dec 2011 18:06:17 -0300
Message-Id: <1324501577-3541-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index bfe5877..1b22139 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -32,8 +32,6 @@
 #include <glib.h>
 
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
 #include <bluetooth/uuid.h>
 
 #include "glib-compat.h"
-- 
1.7.8

