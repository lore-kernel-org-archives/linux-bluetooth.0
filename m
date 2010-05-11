Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 26/26] Fix typo errors
Date: Tue, 11 May 2010 10:22:03 +0200
Message-Id: <1273566123-2198-1-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-25-git-send-email-sancane@gmail.com>
References: <1273486527-7855-25-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap_internal.h |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/mcap/mcap_internal.h b/mcap/mcap_internal.h
index 1e9f521..2ebad29 100644
--- a/mcap/mcap_internal.h
+++ b/mcap/mcap_internal.h
@@ -56,13 +56,13 @@ typedef enum {
 } MDLState;
 
 struct mcap_mdl_cb {
-	mcap_mdl_event_cb 		mdl_connected;	/* Remote device has created a mdl */
-	mcap_mdl_event_cb 		mdl_closed;	/* Remote device has closed a mdl */
-	mcap_mdl_event_cb 		mdl_deleted;	/* Remote device deletion of a mdl */
+	mcap_mdl_event_cb 		mdl_connected;	/* Remote device has created a MDL */
+	mcap_mdl_event_cb 		mdl_closed;	/* Remote device has closed a MDL */
+	mcap_mdl_event_cb 		mdl_deleted;	/* Remote device requested deleting a MDL */
 	mcap_mdl_event_cb		mdl_aborted;	/* Remote device aborted the mdl creation */
-	mcap_remote_mdl_conn_req_cb	mdl_conn_req;	/* Remote deive requested a creation of a mdl */
-	mcap_remote_mdl_reconn_req_cb 	mdl_reconn_req;	/* Remote device requested reconnection of a mdl */
-	gpointer			user_data;	/* user data */
+	mcap_remote_mdl_conn_req_cb	mdl_conn_req;	/* Remote deive requested creating a MDL */
+	mcap_remote_mdl_reconn_req_cb 	mdl_reconn_req;	/* Remote device requested reconnecting a MDL */
+	gpointer			user_data;	/* User data */
 };
 
 struct mcap_session {
@@ -76,21 +76,21 @@ struct mcap_session {
 	mcap_mcl_event_cb		mcl_reconnected_cb;	/* Old MCL has been reconnected */
 	mcap_mcl_event_cb		mcl_disconnected_cb;	/* MCL disconnected */
 	mcap_mcl_event_cb		mcl_uncached_cb;	/* MCL has been removed from MCAP cache */
-	gpointer			user_data;		/* Data to be provided in a callbacks */
+	gpointer			user_data;		/* Data to be provided in callbacks */
 };
 
 struct mcap_mcl {
 	struct mcap_session	*ms;		/* MCAP session where this MCL belongs */
-	bdaddr_t		addr;		/* device address */
+	bdaddr_t		addr;		/* Device address */
 	GIOChannel		*cc;		/* MCAP Control Channel IO */
 	guint			wid;		/* MCL Watcher id */
 	GSList			*mdls;		/* List of Data Channels shorted by mdlid */
-	MCLState		state;		/* current MCL State */
-	MCLRole			role;		/* initiator or aceptor of this MCL*/
+	MCLState		state;		/* Current MCL State */
+	MCLRole			role;		/* Initiator or acceptor of this MCL */
 	MCAPCtrl		req;		/* Request control flag */
-	void			*priv_data;	/* Temporal data to manage responses */
+	void			*priv_data;	/* Temporal data to manage in responses */
 	struct mcap_mdl_cb	*cb;		/* MDL callbacks */
-	guint			tid;		/* Timer id for waiting for a resposne */
+	guint			tid;		/* Timer id for waiting for a response */
 	uint8_t			*lcmd;		/* Last command sent */
 	guint			ref;		/* References counter */
 	uint8_t			ctrl;		/* MCL control flag */
@@ -99,12 +99,12 @@ struct mcap_mcl {
 #define	MCAP_CTRL_CACHED	0x01	/* MCL is cached */
 #define	MCAP_CTRL_STD_OP	0x02	/* Support for standard op codes */
 #define	MCAP_CTRL_SYNC_OP	0x04	/* Support for synchronization commands */
-#define	MCAP_CTRL_CONN		0x08	/* MCL is in connectcting process */
+#define	MCAP_CTRL_CONN		0x08	/* MCL is in connecting process */
 #define	MCAP_CTRL_FREE		0x10	/* MCL is marked as releasable */
 #define	MCAP_CTRL_NOCACHE	0x20	/* MCL is marked as not cacheable */
 
 struct mcap_mdl {
-	struct mcap_mcl		*mcl;		/* MCAP mcl for this mdl */
+	struct mcap_mcl		*mcl;		/* MCL where this MDL belongs */
 	GIOChannel		*dc;		/* MCAP Data Channel IO */
 	guint			wid;		/* MDL Watcher id */
 	uint16_t		mdlid;		/* MDL id */
-- 
1.6.3.3

