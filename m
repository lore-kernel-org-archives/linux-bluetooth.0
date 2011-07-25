Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 5/5] Check if attrib server is enabled for Proximity
Date: Mon, 25 Jul 2011 17:15:55 -0300
Message-Id: <1311624955-22360-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1311624955-22360-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1311624955-22360-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

Before registering Proximity services(Link Loss, Immediate alert and
TX Power), "AttributeServer" option value needs to be verified.
---
 proximity/reporter.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/proximity/reporter.c b/proximity/reporter.c
index fe18442..77a7dcd 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -31,6 +31,7 @@
 
 #include "log.h"
 
+#include "hcid.h"
 #include "att.h"
 #include "gattrib.h"
 #include "attrib-server.h"
@@ -170,10 +171,10 @@ static void register_immediate_alert(void)
 
 int reporter_init(void)
 {
-	/*
-	 * TODO: Create/Update Proximity Reporter Characteristics
-	 * for Path Loss and Immediate Alert Services.
-	 */
+	if (!main_opts.attrib_server) {
+		DBG("Attribute server is disabled");
+		return -1;
+	}
 
 	DBG("Proximity Reporter");
 
-- 
1.7.0.4

