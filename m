Return-Path: <cyrus@holtmann.org>
From: Alok Barsode <alokbarsode@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 2/8] exporting device_event().
Date: Mon, 27 Apr 2009 19:45:39 +0530
Message-Id: <1240841745-11006-2-git-send-email-alok.barsode@gmail.com>
In-Reply-To: <1240841745-11006-1-git-send-email-alok.barsode@gmail.com>
References: <1240841745-11006-1-git-send-email-alok.barsode@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/hcid.h |    1 +
 src/main.c |   28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/src/hcid.h b/src/hcid.h
index 6c26157..236449d 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -68,6 +68,7 @@ struct main_opts {
 
 extern struct main_opts main_opts;
 
+void device_event(int event, int dev_id);
 void hci_req_queue_remove(int dev_id, bdaddr_t *dba);
 
 void start_security_manager(int hdev);
diff --git a/src/main.c b/src/main.c
index f39fc11..02b4ebf 100644
--- a/src/main.c
+++ b/src/main.c
@@ -556,30 +556,28 @@ static void init_defaults(void)
 		strcpy(main_opts.host_name, "noname");
 }
 
-static inline void device_event(GIOChannel *chan, evt_stack_internal *si)
+void device_event(int event, int dev_id)
 {
-	evt_si_device *sd = (void *) &si->data;
-
-	switch (sd->event) {
+	switch (event) {
 	case HCI_DEV_REG:
-		info("HCI dev %d registered", sd->dev_id);
-		device_devreg_setup(sd->dev_id, FALSE);
+		info("HCI dev %d registered", dev_id);
+		device_devreg_setup(dev_id, FALSE);
 		break;
 
 	case HCI_DEV_UNREG:
-		info("HCI dev %d unregistered", sd->dev_id);
-		manager_unregister_adapter(sd->dev_id);
+		info("HCI dev %d unregistered", dev_id);
+		manager_unregister_adapter(dev_id);
 		break;
 
 	case HCI_DEV_UP:
-		info("HCI dev %d up", sd->dev_id);
-		device_devup_setup(sd->dev_id);
+		info("HCI dev %d up", dev_id);
+		device_devup_setup(dev_id);
 		break;
 
 	case HCI_DEV_DOWN:
-		info("HCI dev %d down", sd->dev_id);
-		manager_stop_adapter(sd->dev_id);
-		stop_security_manager(sd->dev_id);
+		info("HCI dev %d down", dev_id);
+		manager_stop_adapter(dev_id);
+		stop_security_manager(dev_id);
 		break;
 	}
 }
@@ -589,6 +587,7 @@ static gboolean io_stack_event(GIOChannel *chan, GIOCondition cond,
 {
 	unsigned char buf[HCI_MAX_FRAME_SIZE], *ptr;
 	evt_stack_internal *si;
+	evt_si_device *sd;
 	hci_event_hdr *eh;
 	int type;
 	size_t len;
@@ -620,7 +619,8 @@ static gboolean io_stack_event(GIOChannel *chan, GIOCondition cond,
 	si = (evt_stack_internal *) ptr;
 	switch (si->type) {
 	case EVT_SI_DEVICE:
-		device_event(chan, si);
+		sd = (void *) &si->data;
+		device_event(sd->event, sd->dev_id);
 		break;
 	}
 
-- 
1.5.6.3
