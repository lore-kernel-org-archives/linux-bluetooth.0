Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E49C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 08:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC3E222B6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 08:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgLOIg6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 03:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbgLOIdb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 03:33:31 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE695C061282
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 00:32:19 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id c1so8261439pjo.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 00:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LGuTdPl7jT3kD82xsaoUNdwlBJXSyR0jMlkcfAoaWS8=;
        b=jAXSkuID0My2vF8+FcV2Nff/jj8fDirnnoPiMKeZhWMDhlbttFow1uzwwQuQy0vZ/o
         Mw046eJiafUIMlMAnSlGd6iTnL8lp7BBk87EwSEE9MHApieVRbaqvbA8zeXyVskQlu6I
         i+P2W3YHLiKVXgAThSua3NJiiJi+Y14MtpTt0gVsQ2JO4T2l/lfW4ByLWOpRQOs0xGDq
         5dV0qd/sgec7P/wW2cI8w33D6Aqb+Z2KrdD3tuhOxzVv9Yk4oyAWJAY7VevI03tpnyeT
         xBHkqkogUdemgwE3SzsWcEbAmEIbbppN2beHbmTJRyU32TQVkuk8Dzbcwp8JnzG2XsXu
         SAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LGuTdPl7jT3kD82xsaoUNdwlBJXSyR0jMlkcfAoaWS8=;
        b=Yz8UaJgAysu9xlDS/hMVt+dZff85H+aeySbKZGgkntyW0WfnjEfwxZKo/+kBrZvBOt
         3wev8VnVqJk6B2S7tlK0Rq+4RptW8q6D6djHn+sGGKV67fL1VsAskmmM1ClOqFDoO5hw
         jovVwNPoT7q52Izwwsmc8MTt6wfSXzqCltqTL/s75Idv1lW2oI7HuWGtxcfp8g0PC+Hh
         OQSYEzSXikHpnbzmS1kdXWisRWsnKO18XIvs8DduDY+CYdGEv8f5O1bt6hXdIGbW+bdT
         qT/MVoM+kG4itBJz5re9ZBXSrFPr3pVE3Hs5AEoJ8YAlmJ5F83IMQyymBwl4B+imvgir
         hFIQ==
X-Gm-Message-State: AOAM531u4Trxby6XEoTGfc7cFMJoXzhef1vfk1QLHRG72za24TZa30IZ
        nZ4tysepQTqtbCFCPEYbVd2mof6iPfO8HAG9MFCdBGNCxSoEGdXzQTGJFZG147C64hHWQKmNI2Y
        aEqza+SKwCKXwwAHx605hL5vtfv35zj833j6CbP9AlOkNLN5QU+qeM6isMTeHVF4jc/HEDQnNRY
        OB
X-Google-Smtp-Source: ABdhPJw4R17hupk6kF3q4WSNQnieYAorHHnBneTgm0+3K8cncICcj5+DjA3AuwcmGfho4/An0uCsjL262Mjb
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:902:7144:b029:da:7268:d730 with SMTP
 id u4-20020a1709027144b02900da7268d730mr1602520plm.20.1608021139066; Tue, 15
 Dec 2020 00:32:19 -0800 (PST)
Date:   Tue, 15 Dec 2020 16:31:57 +0800
In-Reply-To: <20201215083201.1343692-1-apusaka@google.com>
Message-Id: <20201215163106.v2.1.I92d2e2a87419730d60136680cbe27636baf94b15@changeid>
Mime-Version: 1.0
References: <20201215083201.1343692-1-apusaka@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v2 1/5] Bluetooth: advmon offload MSFT add rssi support
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

MSFT needs rssi parameter for monitoring advertisement packet,
therefore we should supply them from mgmt. This adds a new opcode
to add advertisement monitor with rssi parameters.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@google.com>

---

Changes in v2:
* Add a new opcode instead of modifying an existing one

 include/net/bluetooth/hci_core.h |  9 +++
 include/net/bluetooth/mgmt.h     | 16 ++++++
 net/bluetooth/mgmt.c             | 99 ++++++++++++++++++++++++--------
 3 files changed, 101 insertions(+), 23 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 677a8c50b2ad..8b7cf3620938 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -250,8 +250,17 @@ struct adv_pattern {
 	__u8 value[HCI_MAX_AD_LENGTH];
 };
 
+struct adv_rssi_thresholds {
+	__s8 low_threshold;
+	__s8 high_threshold;
+	__u16 low_threshold_timeout;
+	__u16 high_threshold_timeout;
+	__u8 sampling_period;
+};
+
 struct adv_monitor {
 	struct list_head patterns;
+	struct adv_rssi_thresholds rssi;
 	bool		active;
 	__u16		handle;
 };
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index f9a6638e20b3..f3b1460b463d 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -821,6 +821,22 @@ struct mgmt_rp_add_ext_adv_data {
 	__u8	instance;
 } __packed;
 
+struct mgmt_adv_rssi_thresholds {
+	__s8 high_threshold;
+	__le16 high_threshold_timeout;
+	__s8 low_threshold;
+	__le16 low_threshold_timeout;
+	__u8 sampling_period;
+} __packed;
+
+#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI	0x0056
+struct mgmt_cp_add_adv_patterns_monitor_rssi {
+	__u8 pattern_count;
+	struct mgmt_adv_rssi_thresholds rssi;
+	struct mgmt_adv_pattern patterns[];
+} __packed;
+#define MGMT_ADD_ADV_PATTERNS_MONITOR_RSSI_SIZE	8
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fa0f7a4a1d2f..cd574054aa39 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -124,6 +124,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_REMOVE_ADV_MONITOR,
 	MGMT_OP_ADD_EXT_ADV_PARAMS,
 	MGMT_OP_ADD_EXT_ADV_DATA,
+	MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI,
 };
 
 static const u16 mgmt_events[] = {
@@ -4225,22 +4226,40 @@ static int read_adv_mon_features(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
-				    void *data, u16 len)
+static int __add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
+				      void *data, u16 len, u16 op)
 {
-	struct mgmt_cp_add_adv_patterns_monitor *cp = data;
+	struct mgmt_cp_add_adv_patterns_monitor *cp = NULL;
+	struct mgmt_cp_add_adv_patterns_monitor_rssi *cp_rssi = NULL;
 	struct mgmt_rp_add_adv_patterns_monitor rp;
+	struct mgmt_adv_rssi_thresholds *rssi = NULL;
+	struct mgmt_adv_pattern *patterns = NULL;
 	struct adv_monitor *m = NULL;
 	struct adv_pattern *p = NULL;
 	unsigned int mp_cnt = 0, prev_adv_monitors_cnt;
 	__u8 cp_ofst = 0, cp_len = 0;
 	int err, i;
+	u8 pattern_count;
+	u16 expected_len;
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (len <= sizeof(*cp) || cp->pattern_count == 0) {
-		err = mgmt_cmd_status(sk, hdev->id,
-				      MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+	if (op == MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI) {
+		cp_rssi = data;
+		pattern_count = cp_rssi->pattern_count;
+		rssi = &cp_rssi->rssi;
+		patterns = cp_rssi->patterns;
+		expected_len = sizeof(*cp_rssi) +
+			       pattern_count * sizeof(*patterns);
+	} else {
+		cp = data;
+		pattern_count = cp->pattern_count;
+		patterns = cp->patterns;
+		expected_len = sizeof(*cp) + pattern_count * sizeof(*patterns);
+	}
+
+	if (len != expected_len || pattern_count == 0) {
+		err = mgmt_cmd_status(sk, hdev->id, op,
 				      MGMT_STATUS_INVALID_PARAMS);
 		goto failed;
 	}
@@ -4254,21 +4273,40 @@ static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 	INIT_LIST_HEAD(&m->patterns);
 	m->active = false;
 
-	for (i = 0; i < cp->pattern_count; i++) {
+	if (rssi) {
+		m->rssi.low_threshold = rssi->low_threshold;
+		m->rssi.low_threshold_timeout =
+		    __le16_to_cpu(rssi->low_threshold_timeout);
+		m->rssi.high_threshold = rssi->high_threshold;
+		m->rssi.high_threshold_timeout =
+		    __le16_to_cpu(rssi->high_threshold_timeout);
+		m->rssi.sampling_period = rssi->sampling_period;
+	} else {
+		/* Default values. These numbers are the least constricting
+		 * parameters for MSFT API to work, so it behaves as if there
+		 * are no rssi parameter to consider. May need to be changed
+		 * if other API are to be supported.
+		 */
+		m->rssi.low_threshold = -127;
+		m->rssi.low_threshold_timeout = 60;
+		m->rssi.high_threshold = -127;
+		m->rssi.high_threshold_timeout = 0;
+		m->rssi.sampling_period = 0;
+	}
+
+	for (i = 0; i < pattern_count; i++) {
 		if (++mp_cnt > HCI_MAX_ADV_MONITOR_NUM_PATTERNS) {
-			err = mgmt_cmd_status(sk, hdev->id,
-					      MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+			err = mgmt_cmd_status(sk, hdev->id, op,
 					      MGMT_STATUS_INVALID_PARAMS);
 			goto failed;
 		}
 
-		cp_ofst = cp->patterns[i].offset;
-		cp_len = cp->patterns[i].length;
+		cp_ofst = patterns[i].offset;
+		cp_len = patterns[i].length;
 		if (cp_ofst >= HCI_MAX_AD_LENGTH ||
 		    cp_len > HCI_MAX_AD_LENGTH ||
 		    (cp_ofst + cp_len) > HCI_MAX_AD_LENGTH) {
-			err = mgmt_cmd_status(sk, hdev->id,
-					      MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+			err = mgmt_cmd_status(sk, hdev->id, op,
 					      MGMT_STATUS_INVALID_PARAMS);
 			goto failed;
 		}
@@ -4279,18 +4317,17 @@ static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 			goto failed;
 		}
 
-		p->ad_type = cp->patterns[i].ad_type;
-		p->offset = cp->patterns[i].offset;
-		p->length = cp->patterns[i].length;
-		memcpy(p->value, cp->patterns[i].value, p->length);
+		p->ad_type = patterns[i].ad_type;
+		p->offset = patterns[i].offset;
+		p->length = patterns[i].length;
+		memcpy(p->value, patterns[i].value, p->length);
 
 		INIT_LIST_HEAD(&p->list);
 		list_add(&p->list, &m->patterns);
 	}
 
-	if (mp_cnt != cp->pattern_count) {
-		err = mgmt_cmd_status(sk, hdev->id,
-				      MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+	if (mp_cnt != pattern_count) {
+		err = mgmt_cmd_status(sk, hdev->id, op,
 				      MGMT_STATUS_INVALID_PARAMS);
 		goto failed;
 	}
@@ -4302,8 +4339,7 @@ static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 	err = hci_add_adv_monitor(hdev, m);
 	if (err) {
 		if (err == -ENOSPC) {
-			mgmt_cmd_status(sk, hdev->id,
-					MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+			mgmt_cmd_status(sk, hdev->id, op,
 					MGMT_STATUS_NO_RESOURCES);
 		}
 		goto unlock;
@@ -4316,7 +4352,7 @@ static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 
 	rp.monitor_handle = cpu_to_le16(m->handle);
 
-	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+	return mgmt_cmd_complete(sk, hdev->id, op,
 				 MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
 
 unlock:
@@ -4327,6 +4363,20 @@ static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
+				    void *data, u16 len)
+{
+	return __add_adv_patterns_monitor(sk, hdev, data, len,
+					  MGMT_OP_ADD_ADV_PATTERNS_MONITOR);
+}
+
+static int add_adv_patterns_monitor_rssi(struct sock *sk, struct hci_dev *hdev,
+					 void *data, u16 len)
+{
+	return __add_adv_patterns_monitor(sk, hdev, data, len,
+					 MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI);
+}
+
 static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 			      void *data, u16 len)
 {
@@ -8234,6 +8284,9 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 						HCI_MGMT_VAR_LEN },
 	{ add_ext_adv_data,        MGMT_ADD_EXT_ADV_DATA_SIZE,
 						HCI_MGMT_VAR_LEN },
+	{ add_adv_patterns_monitor_rssi,
+				   MGMT_ADD_ADV_PATTERNS_MONITOR_RSSI_SIZE,
+						HCI_MGMT_VAR_LEN },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.29.2.684.gfbc64c5ab5-goog

