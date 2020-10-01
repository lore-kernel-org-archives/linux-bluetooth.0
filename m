Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5FDC4727E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D7120796
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZS5amP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbgJAXE0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 19:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387468AbgJAXEU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 19:04:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA523C0613E2
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2020 16:04:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z40so545819ybi.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2020 16:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gzdgjx4eVJh7Xb7eAH+TAn3vgdcp4FzjfRPQGrQVIYM=;
        b=iZS5amP9Lf4HCo6AGVGN9M02oAOt//S+fbR9GM1fnxY7vJx3Ehhn32VbpvdNERuDIL
         9UjRbSbidGMMT3hEoUqs1sg9UzQa7vj4S0JB8LN6ATC3pMfDmfd+P5gh/B4IBO7YCBTv
         dsGaSzXGuNmpP+qenL8Ty/nVbEqtLr5PL3FkMJdSxAJfori9M1YgkG3GG1DeDVGupAAy
         5U/vJhkQDr54llmMPN/Eo5X9tO+osR9C0fgo+fKlLTIASel0FE82Bfkka5oako3Nk3vS
         y/y/FfIQJ6AcAVVlWQYsgErxkl+IkFUYBFlCj9XJy1/zS3XRose281Vsx0WYunZtvTQJ
         jpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gzdgjx4eVJh7Xb7eAH+TAn3vgdcp4FzjfRPQGrQVIYM=;
        b=U+HPO+fMT0CWCAN72M2jvAeBUBHpNrHC7rpuxj5cqrwdf0drI67KE1hzVMevoB1U4l
         e1weqDbkm4XQt7yb55zRGEUn/xXv3NP6hIJuXOaCA0CZtFzOZWLEwDfk5qef9HQIyw21
         UXPfD7a7Bm6xRpU5cDod02WsPInVrYkpAeYZWHpTbPeeAdjdSby0PQo4UPUiUb+yIyU7
         360KxU7psX+CTLyVJONbtz4ZxG9McuaHsMHYPonVdsj86Y9meLZfh5pC0ThgNXNYYN2M
         nUMtesYI3x3SoUN6jsTlYDzVwc6FS70HDwNqxZEizd76f4N1MMEvDi6qnT0N48zU3FEx
         AMWQ==
X-Gm-Message-State: AOAM531PkzcVXHLrhSLq0ivqdvru/vcUXAvxZecIcUArWIwUcrT7sbMk
        ianwy7TWWiV1gm8PiyRmjiibwa97bvbiqvqhzRUB
X-Google-Smtp-Source: ABdhPJy+UASECqoWVlksJQpDXRpNIVWb3viFYi+3OiFH8zyTG9r3lde/IpQ+gpHCZkk8NtdrPrWoZsQWzx5JHYZJoI/K
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:c549:: with SMTP id
 v70mr13905718ybe.516.1601593458903; Thu, 01 Oct 2020 16:04:18 -0700 (PDT)
Date:   Thu,  1 Oct 2020 16:04:03 -0700
In-Reply-To: <20201001230403.2445035-1-danielwinkler@google.com>
Message-Id: <20201001160305.v4.5.I5068c01cae3cea674a96e103a0cf4d8c81425a4f@changeid>
Mime-Version: 1.0
References: <20201001230403.2445035-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 5/5] Bluetooth: Change MGMT security info CMD to be more generic
From:   Daniel Winkler <danielwinkler@google.com>
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For advertising, we wish to know the LE tx power capabilities of the
controller in userspace, so this patch edits the Security Info MGMT
command to be more generic, such that other various controller
capabilities can be included in the EIR data. This change also includes
the LE min and max tx power into this newly-named command.

The change was tested by manually verifying that the MGMT command
returns the tx power range as expected in userspace.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Signed-off-by: Daniel Winkler <danielwinkler@google.com>
---

Changes in v4:
- Combine LE tx range into a single EIR field for MGMT capabilities cmd

Changes in v3:
- Re-using security info MGMT command to carry controller capabilities

Changes in v2:
- Fixed sparse error in Capabilities MGMT command

 include/net/bluetooth/mgmt.h | 15 +++++++++-----
 net/bluetooth/mgmt.c         | 39 +++++++++++++++++++++++-------------
 2 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 117578bb88743c..42c3ece9931936 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -686,11 +686,16 @@ struct mgmt_cp_set_blocked_keys {
 
 #define MGMT_OP_SET_WIDEBAND_SPEECH	0x0047
 
-#define MGMT_OP_READ_SECURITY_INFO	0x0048
-#define MGMT_READ_SECURITY_INFO_SIZE	0
-struct mgmt_rp_read_security_info {
-	__le16   sec_len;
-	__u8     sec[];
+#define MGMT_CAP_SEC_FLAGS		0x01
+#define MGMT_CAP_MAX_ENC_KEY_SIZE	0x02
+#define MGMT_CAP_SMP_MAX_ENC_KEY_SIZE	0x03
+#define MGMT_CAP_LE_TX_PWR		0x04
+
+#define MGMT_OP_READ_CONTROLLER_CAP	0x0048
+#define MGMT_READ_CONTROLLER_CAP_SIZE	0
+struct mgmt_rp_read_controller_cap {
+	__le16   cap_len;
+	__u8     cap[0];
 } __packed;
 
 #define MGMT_OP_READ_EXP_FEATURES_INFO	0x0049
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 092ac7fffb4124..3a35385017f568 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -110,7 +110,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_APPEARANCE,
 	MGMT_OP_SET_BLOCKED_KEYS,
 	MGMT_OP_SET_WIDEBAND_SPEECH,
-	MGMT_OP_READ_SECURITY_INFO,
+	MGMT_OP_READ_CONTROLLER_CAP,
 	MGMT_OP_READ_EXP_FEATURES_INFO,
 	MGMT_OP_SET_EXP_FEATURE,
 	MGMT_OP_READ_DEF_SYSTEM_CONFIG,
@@ -176,7 +176,7 @@ static const u16 mgmt_untrusted_commands[] = {
 	MGMT_OP_READ_CONFIG_INFO,
 	MGMT_OP_READ_EXT_INDEX_LIST,
 	MGMT_OP_READ_EXT_INFO,
-	MGMT_OP_READ_SECURITY_INFO,
+	MGMT_OP_READ_CONTROLLER_CAP,
 	MGMT_OP_READ_EXP_FEATURES_INFO,
 	MGMT_OP_READ_DEF_SYSTEM_CONFIG,
 	MGMT_OP_READ_DEF_RUNTIME_CONFIG,
@@ -3705,13 +3705,14 @@ static int set_wideband_speech(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static int read_security_info(struct sock *sk, struct hci_dev *hdev,
-			      void *data, u16 data_len)
+static int read_controller_cap(struct sock *sk, struct hci_dev *hdev,
+			       void *data, u16 data_len)
 {
-	char buf[16];
-	struct mgmt_rp_read_security_info *rp = (void *)buf;
-	u16 sec_len = 0;
+	char buf[20];
+	struct mgmt_rp_read_controller_cap *rp = (void *)buf;
+	u16 cap_len = 0;
 	u8 flags = 0;
+	u8 tx_power_range[2];
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
@@ -3735,23 +3736,33 @@ static int read_security_info(struct sock *sk, struct hci_dev *hdev,
 
 	flags |= 0x08;		/* Encryption key size enforcement (LE) */
 
-	sec_len = eir_append_data(rp->sec, sec_len, 0x01, &flags, 1);
+	cap_len = eir_append_data(rp->cap, cap_len, MGMT_CAP_SEC_FLAGS,
+				  &flags, 1);
 
 	/* When the Read Simple Pairing Options command is supported, then
 	 * also max encryption key size information is provided.
 	 */
 	if (hdev->commands[41] & 0x08)
-		sec_len = eir_append_le16(rp->sec, sec_len, 0x02,
+		cap_len = eir_append_le16(rp->cap, cap_len,
+					  MGMT_CAP_MAX_ENC_KEY_SIZE,
 					  hdev->max_enc_key_size);
 
-	sec_len = eir_append_le16(rp->sec, sec_len, 0x03, SMP_MAX_ENC_KEY_SIZE);
+	cap_len = eir_append_le16(rp->cap, cap_len,
+				  MGMT_CAP_SMP_MAX_ENC_KEY_SIZE,
+				  SMP_MAX_ENC_KEY_SIZE);
+
+	/* Append the min/max LE tx power parameters */
+	memcpy(&tx_power_range[0], &hdev->min_le_tx_power, 1);
+	memcpy(&tx_power_range[1], &hdev->max_le_tx_power, 1);
+	cap_len = eir_append_data(rp->cap, cap_len, MGMT_CAP_LE_TX_PWR,
+				  tx_power_range, 2);
 
-	rp->sec_len = cpu_to_le16(sec_len);
+	rp->cap_len = cpu_to_le16(cap_len);
 
 	hci_dev_unlock(hdev);
 
-	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_SECURITY_INFO, 0,
-				 rp, sizeof(*rp) + sec_len);
+	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_CONTROLLER_CAP, 0,
+				 rp, sizeof(*rp) + cap_len);
 }
 
 #ifdef CONFIG_BT_FEATURE_DEBUG
@@ -8186,7 +8197,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ set_blocked_keys,	   MGMT_OP_SET_BLOCKED_KEYS_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ set_wideband_speech,	   MGMT_SETTING_SIZE },
-	{ read_security_info,      MGMT_READ_SECURITY_INFO_SIZE,
+	{ read_controller_cap,     MGMT_READ_CONTROLLER_CAP_SIZE,
 						HCI_MGMT_UNTRUSTED },
 	{ read_exp_features_info,  MGMT_READ_EXP_FEATURES_INFO_SIZE,
 						HCI_MGMT_UNTRUSTED |
-- 
2.28.0.709.gb0816b6eb0-goog

