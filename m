Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 05/11] Write Immediate Alert after discovering handle
Date: Mon,  8 Aug 2011 15:46:44 -0300
Message-Id: <1312829210-6781-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Write the Immediate Alert level characteristic if there is a pending
alert value to be written after discovering the characteristic handle.
---
 proximity/monitor.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 2d405be..95e0f8e 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -273,6 +273,9 @@ static void immediate_handle_cb(GSList *characteristics, guint8 status,
 	monitor->immediatehandle = chr->value_handle;
 
 	DBG("Immediate Alert handle: 0x%04x", monitor->immediatehandle);
+
+	if (monitor->fallbacklevel)
+		write_immediate_alert(monitor);
 }
 
 static void discover_immediate_handle(struct monitor *monitor)
-- 
1.7.6

