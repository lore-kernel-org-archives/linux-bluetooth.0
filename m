Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/5] Add fast connectable to hciops
Date: Tue, 17 Aug 2010 17:05:31 +0300
Message-Id: <1282053934-19445-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1282053934-19445-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1282053934-19445-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fast connectable switches between two sets of parameters to enable
or disable fast page scan mode. Page scan interval and page scan
type are changed to speed up connectabily when needed. When
disabled it sets default values. List of btd_adapter_ops is updated
respectively.
---
 plugins/hciops.c |   34 ++++++++++++++++++++++++++++++++++
 src/adapter.h    |    1 +
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 9c97c5a..652830a 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -716,6 +716,39 @@ static int hciops_cancel_resolve_name(int index, bdaddr_t *bdaddr)
 	return err;
 }
 
+static int hciops_fast_connectable(int index, gboolean enable)
+{
+	int dd, err = 0;
+	write_page_activity_cp cp;
+	uint8_t type;
+
+	if (enable) {
+		type = PAGE_SCAN_TYPE_INTERLACED;
+		cp.interval = 0x0024;	/* 22.5 msec page scan interval */
+	} else {
+		type = PAGE_SCAN_TYPE_STANDARD;	/* default */
+		cp.interval = 0x0800;	/* default 1.28 sec page scan */
+	}
+
+	cp.window = 0x0012;	/* default 11.25 msec page scan window */
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	if ( hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_PAGE_ACTIVITY,
+				WRITE_PAGE_ACTIVITY_CP_SIZE, &cp) < 0 ) {
+		err = -errno;
+	} else if ( hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_PAGE_SCAN_TYPE,
+							1, &type) < 0 ) {
+		err = -errno;
+	}
+
+	hci_close_dev(dd);
+
+	return err;
+}
+
 static struct btd_adapter_ops hci_ops = {
 	.setup = hciops_setup,
 	.cleanup = hciops_cleanup,
@@ -732,6 +765,7 @@ static struct btd_adapter_ops hci_ops = {
 	.set_name = hciops_set_name,
 	.read_name = hciops_read_name,
 	.set_class = hciops_set_class,
+	.set_fast_connectable = hciops_fast_connectable,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.h b/src/adapter.h
index 58853ac..657e035 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -183,6 +183,7 @@ struct btd_adapter_ops {
 	int (*set_name) (int index, const char *name);
 	int (*read_name) (int index);
 	int (*set_class) (int index, uint32_t class);
+	int (*set_fast_connectable) (int index, gboolean enable);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
-- 
1.7.0.4

