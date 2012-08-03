Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] mgmt: Add LE scanning callback
Date: Fri,  3 Aug 2012 13:18:37 -0300
Message-Id: <1344010717-4529-1-git-send-email-jprvita@openbossa.org>
In-Reply-To: <CAJdJm_PyZa_0K-5nZOo_D796x5cwiZ6GKMb7-Jey48CYPys88Q@mail.gmail.com>
References: <CAJdJm_PyZa_0K-5nZOo_D796x5cwiZ6GKMb7-Jey48CYPys88Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch adds a new callback to allow the adapter to control LE
scanning. The current approach uses the active scanning with default
windows and intervals defined by the core spec without any filtering.
---
 src/mgmt.c | 32 ++++++++++++++++++++++++++++++++
 src/mgmt.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/src/mgmt.c b/src/mgmt.c
index 8ae86d3..5ceeaa8 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1999,6 +1999,38 @@ int mgmt_start_discovery(int index)
 	return 0;
 }
 
+int mgmt_start_scanning(int index)
+{
+	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_start_discovery)];
+	struct mgmt_hdr *hdr = (void *) buf;
+	struct mgmt_cp_start_discovery *cp = (void *) &buf[sizeof(*hdr)];
+	struct controller_info *info = &controllers[index];
+
+	DBG("index %d", index);
+
+	info->discov_type = 0;
+
+	if (mgmt_low_energy(info->current_settings)) {
+		hci_set_bit(BDADDR_LE_PUBLIC, &info->discov_type);
+		hci_set_bit(BDADDR_LE_RANDOM, &info->discov_type);
+	}
+
+	memset(buf, 0, sizeof(buf));
+	hdr->opcode = htobs(MGMT_OP_START_DISCOVERY);
+	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
+
+	cp->type = info->discov_type;
+
+	if (write(mgmt_sock, buf, sizeof(buf)) < 0) {
+		int err = -errno;
+		error("failed to write to MGMT socket: %s", strerror(-err));
+		return err;
+	}
+
+	return 0;
+}
+
 int mgmt_stop_discovery(int index)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_start_discovery)];
diff --git a/src/mgmt.h b/src/mgmt.h
index 0658198..ed47b40 100644
--- a/src/mgmt.h
+++ b/src/mgmt.h
@@ -33,6 +33,7 @@ int mgmt_set_dev_class(int index, uint8_t major, uint8_t minor);
 int mgmt_set_fast_connectable(int index, gboolean enable);
 
 int mgmt_start_discovery(int index);
+int mgmt_start_scanning(int index);
 int mgmt_stop_discovery(int index);
 
 int mgmt_read_clock(int index, bdaddr_t *bdaddr, int which, int timeout,
-- 
1.7.11.2

