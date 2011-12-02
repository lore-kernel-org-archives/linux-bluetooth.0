Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/5] hdp_types: Fix unappropiated field type for dbus watcher id
Date: Fri,  2 Dec 2011 11:56:33 +0100
Message-Id: <1322823396-5941-3-git-send-email-sancane@gmail.com>
In-Reply-To: <1322823396-5941-2-git-send-email-sancane@gmail.com>
References: <1322823396-5941-1-git-send-email-sancane@gmail.com>
 <1322823396-5941-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This value is provided by g_dbus_add_disconnect_watch wich provides
an unsigned type, not an integer one.
---
 health/hdp_types.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/health/hdp_types.h b/health/hdp_types.h
index eecc138..9a6776f 100644
--- a/health/hdp_types.h
+++ b/health/hdp_types.h
@@ -81,7 +81,7 @@ struct hdp_application {
 	char			*description;	/* Options description for SDP record */
 	uint8_t			id;		/* The identification is also the mdepid */
 	char			*oname;		/* Name of the owner application */
-	int			dbus_watcher;	/* Watch for clients disconnection */
+	guint			dbus_watcher;	/* Watch for clients disconnection */
 	gint			ref;		/* Reference counter */
 };
 
-- 
1.7.7.4

