Return-Path: <cyrus@holtmann.org>
From: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
Subject: [PATCH 1/5] network: Keep track of session's interface name in server
Date: Tue, 21 Aug 2012 13:45:51 +0300
Message-Id: <1345545955-13144-2-git-send-email-tomasz.bursztyka@linux.intel.com>
In-Reply-To: <1345545955-13144-1-git-send-email-tomasz.bursztyka@linux.intel.com>
References: <1345545955-13144-1-git-send-email-tomasz.bursztyka@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/network/server.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index 8ae608c..1703f38 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -57,6 +57,7 @@
 /* Pending Authorization */
 struct network_session {
 	bdaddr_t	dst;		/* Remote Bluetooth Address */
+	char		dev[16];	/* Interface name */
 	GIOChannel	*io;		/* Pending connect channel */
 	guint		watch;		/* BNEP socket watch */
 };
@@ -272,6 +273,8 @@ static int server_connadd(struct network_server *ns,
 
 	bnep_if_up(devname);
 
+	strncpy(session->dev, devname, sizeof(devname));
+
 	ns->sessions = g_slist_append(ns->sessions, session);
 
 	return 0;
-- 
1.7.8.6

