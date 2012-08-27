Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 13/33] mgmt: Add unset controller data command
Date: Mon, 27 Aug 2012 13:03:05 -0400
Message-Id: <1346087005-24693-14-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Implement Unset Controller Data command in MGMT API.  This operation
will remove all data from specific type that was set previously with Set
Controller Data operation.
---
 src/mgmt.c |   22 ++++++++++++++++++++++
 src/mgmt.h |    1 +
 2 files changed, 23 insertions(+)

diff --git a/src/mgmt.c b/src/mgmt.c
index a011b3d..0f7b8ed 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -2529,3 +2529,25 @@ int mgmt_set_controller_data(int index, uint8_t flags, uint8_t data_type,
 
 	return err;
 }
+
+int mgmt_unset_controller_data(int index, uint8_t data_type)
+{
+	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_unset_controller_data)];
+	struct mgmt_hdr *hdr = (void *) buf;
+	struct mgmt_cp_unset_controller_data *cp = (void *) &buf[sizeof(*hdr)];
+
+	DBG("hci%d data_type 0x%hhx", index, data_type);
+
+	memset(buf, 0, sizeof(buf));
+
+	hdr->opcode = htobs(MGMT_OP_UNSET_CONTROLLER_DATA);
+	hdr->index = htobs(index);
+	hdr->len = htobs(sizeof(*cp));
+
+	cp->data_type = data_type;
+
+	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
+		return -errno;
+
+	return 0;
+}
diff --git a/src/mgmt.h b/src/mgmt.h
index 18f3544..c442231 100644
--- a/src/mgmt.h
+++ b/src/mgmt.h
@@ -85,3 +85,4 @@ int mgmt_ssp_enabled(int index);
 
 int mgmt_set_controller_data(int index, uint8_t flags, uint8_t data_type,
 					uint8_t *data, uint8_t data_length);
+int mgmt_unset_controller_data(int index, uint8_t data_type);
-- 
1.7.9.5

