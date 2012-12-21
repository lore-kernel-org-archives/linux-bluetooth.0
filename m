Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 09/25] mgmt: Add unset controller data command
Date: Fri, 21 Dec 2012 16:26:36 -0400
Message-Id: <1356121612-15172-10-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Implement Unset Controller Data command in MGMT API.  This operation
will remove all data from specific type that was set previously with Set
Controller Data operation.
---
 src/mgmt.c |   25 +++++++++++++++++++++++++
 src/mgmt.h |    1 +
 2 files changed, 26 insertions(+)

diff --git a/src/mgmt.c b/src/mgmt.c
index d1b5043..9a6affc 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1694,6 +1694,9 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 		DBG("set_controller_data complete");
 		set_controller_data_complete(sk, index, ev->data, len);
 		break;
+	case MGMT_OP_UNSET_CONTROLLER_DATA:
+		DBG("unset_controller_data complete");
+		break;
 	case MGMT_OP_SET_BROADCASTER:
 		DBG("set_broadcaster complete");
 		break;
@@ -2899,3 +2902,25 @@ int mgmt_set_controller_data(int index, uint8_t flags, uint8_t data_type,
 
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
+	cp->type = data_type;
+
+	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
+		return -errno;
+
+	return 0;
+}
diff --git a/src/mgmt.h b/src/mgmt.h
index 92b4757..187c971 100644
--- a/src/mgmt.h
+++ b/src/mgmt.h
@@ -87,3 +87,4 @@ int mgmt_ssp_enabled(int index);
 
 int mgmt_set_controller_data(int index, uint8_t flags, uint8_t data_type,
 					uint8_t *data, uint8_t data_length);
+int mgmt_unset_controller_data(int index, uint8_t data_type);
-- 
1.7.9.5

