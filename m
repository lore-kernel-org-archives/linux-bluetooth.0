Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 12/33] mgmt: Add set controller data command
Date: Mon, 27 Aug 2012 13:03:04 -0400
Message-Id: <1346087005-24693-13-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Implement new Set Controller Data command in MGMT API. The maximum size
accept for new data is HCI_MAX_EIR_LENGTH (240 bytes). The data sent
using this command will be stored in internal list and they will be set
in adapter after receiving a Set Broadcaster with TRUE.
---
 src/mgmt.c |   32 ++++++++++++++++++++++++++++++++
 src/mgmt.h |    3 +++
 2 files changed, 35 insertions(+)

diff --git a/src/mgmt.c b/src/mgmt.c
index 3d3a8f7..a011b3d 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -2497,3 +2497,35 @@ int mgmt_ssp_enabled(int index)
 
 	return mgmt_ssp(info->current_settings);
 }
+
+int mgmt_set_controller_data(int index, uint8_t flags, uint8_t data_type,
+					uint8_t *data, uint8_t data_length)
+{
+	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_set_controller_data) +
+							HCI_MAX_EIR_LENGTH];
+	struct mgmt_hdr *hdr = (void *) buf;
+	struct mgmt_cp_set_controller_data *cp = (void *) &buf[sizeof(*hdr)];
+	uint16_t cp_size;
+	int err = 0;
+
+	DBG("hci%d flags %d data_type 0x%hhx data_length %d", index, flags,
+							data_type, data_length);
+
+	memset(buf, 0, sizeof(buf));
+
+	cp_size = sizeof(*cp) + data_length;
+
+	hdr->opcode = htobs(MGMT_OP_SET_CONTROLLER_DATA);
+	hdr->index = htobs(index);
+	hdr->len = htobs(cp_size);
+
+	cp->flags = flags;
+	cp->data_type = data_type;
+	cp->data_length = data_length;
+	memcpy(cp->data, data, data_length);
+
+	if (write(mgmt_sock, buf, sizeof(*hdr) + cp_size) < 0)
+		err = -errno;
+
+	return err;
+}
diff --git a/src/mgmt.h b/src/mgmt.h
index e77a804..18f3544 100644
--- a/src/mgmt.h
+++ b/src/mgmt.h
@@ -82,3 +82,6 @@ int mgmt_confirm_name(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							gboolean name_known);
 
 int mgmt_ssp_enabled(int index);
+
+int mgmt_set_controller_data(int index, uint8_t flags, uint8_t data_type,
+					uint8_t *data, uint8_t data_length);
-- 
1.7.9.5

