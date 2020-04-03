Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBDFC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 19:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA7D214D8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 19:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgDCToP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:44:15 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49144 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgDCToO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 15:44:14 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id DD3C4CED0D
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2020 21:53:46 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/10] Bluetooth: Add support for reading security information
Date:   Fri,  3 Apr 2020 21:44:05 +0200
Message-Id: <20200403194407.784943-9-marcel@holtmann.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To allow userspace to make correcty security policy decision, the kernel
needs to export a few details of the supported security features and
encryption key size information. This command exports this information
and also allows future extensions if needed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---
 include/net/bluetooth/mgmt.h |  7 +++++
 net/bluetooth/mgmt.c         | 53 ++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index f41cd87550dc..65dd6fd1fff3 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -674,6 +674,13 @@ struct mgmt_cp_set_blocked_keys {
 
 #define MGMT_OP_SET_WIDEBAND_SPEECH	0x0047
 
+#define MGMT_OP_READ_SECURITY_INFO	0x0048
+#define MGMT_READ_SECURITY_INFO_SIZE	0
+struct mgmt_rp_read_security_info {
+	__le16   sec_len;
+	__u8     sec[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6552003a170e..7b9eac339c87 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -108,6 +108,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_APPEARANCE,
 	MGMT_OP_SET_BLOCKED_KEYS,
 	MGMT_OP_SET_WIDEBAND_SPEECH,
+	MGMT_OP_READ_SECURITY_INFO,
 };
 
 static const u16 mgmt_events[] = {
@@ -155,6 +156,7 @@ static const u16 mgmt_untrusted_commands[] = {
 	MGMT_OP_READ_CONFIG_INFO,
 	MGMT_OP_READ_EXT_INDEX_LIST,
 	MGMT_OP_READ_EXT_INFO,
+	MGMT_OP_READ_SECURITY_INFO,
 };
 
 static const u16 mgmt_untrusted_events[] = {
@@ -3659,6 +3661,55 @@ static int set_wideband_speech(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int read_security_info(struct sock *sk, struct hci_dev *hdev,
+			      void *data, u16 data_len)
+{
+	char buf[16];
+	struct mgmt_rp_read_security_info *rp = (void *)buf;
+	u16 sec_len = 0;
+	u8 flags = 0;
+
+	bt_dev_dbg(hdev, "sock %p", sk);
+
+	memset(&buf, 0, sizeof(buf));
+
+	hci_dev_lock(hdev);
+
+	/* When the Read Simple Pairing Options command is supported, then
+	 * the remote public key validation is supported.
+	 */
+	if (hdev->commands[41] & 0x08)
+		flags |= 0x01;	/* Remote public key validation (BR/EDR) */
+
+	flags |= 0x02;		/* Remote public key validation (LE) */
+
+	/* When the Read Encryption Key Size command is supported, then the
+	 * encryption key size is enforced.
+	 */
+	if (hdev->commands[20] & 0x10)
+		flags |= 0x04;	/* Encryption key size enforcement (BR/EDR) */
+
+	flags |= 0x08;		/* Encryption key size enforcement (LE) */
+
+	sec_len = eir_append_data(rp->sec, sec_len, 0x01, &flags, 1);
+
+	/* When the Read Simple Pairing Options command is supported, then
+	 * also max encryption key size information is provided.
+	 */
+	if (hdev->commands[41] & 0x08)
+		sec_len = eir_append_le16(rp->sec, sec_len, 0x02,
+					  hdev->max_enc_key_size);
+
+	sec_len = eir_append_le16(rp->sec, sec_len, 0x03, SMP_MAX_ENC_KEY_SIZE);
+
+	rp->sec_len = cpu_to_le16(sec_len);
+
+	hci_dev_unlock(hdev);
+
+	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_SECURITY_INFO, 0,
+				 rp, sizeof(*rp) + sec_len);
+}
+
 static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
 				         u16 opcode, struct sk_buff *skb)
 {
@@ -7099,6 +7150,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ set_blocked_keys,	   MGMT_OP_SET_BLOCKED_KEYS_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ set_wideband_speech,	   MGMT_SETTING_SIZE },
+	{ read_security_info,      MGMT_READ_SECURITY_INFO_SIZE,
+						HCI_MGMT_UNTRUSTED },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.25.1

