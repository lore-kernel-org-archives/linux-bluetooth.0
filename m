Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CA9C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 21:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC71D64DA1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 21:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhA0VSF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 16:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhA0VSC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 16:18:02 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F59AC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 13:17:21 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id bc11so1865119plb.17
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 13:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=0oj2Lh/zDremXrwwI5FBI0ohoN90BgSKE7ZLqFcSUF4=;
        b=hh86dEVbIIYbMi9j4kn0FexpX7hvM55T89bIePLy0iFZpmZEirZtKdnzaOdxT7hOM6
         FT8Wx14j9OvomngFQ7Ss1sceIxE5cu68/u/P/MFBAwk1VeSpfiWpovHRlcEQBAAUr3ot
         HomZAl1V1uW4NIPcP2iDTwor0U5DnHIMOIcp3uvwILmqUKpNCxKs1Fffmbp1RzT5hSvR
         rD19JRekbpHoIF/liEfaXpjPqJu3zrumgetqIAVeqeOkfPO7BAp0zk2XpjjMreQCDBUi
         yDIUlkxNyZIRxVJ+TmuuyTb8PpBSC7cah0f5r21dms7PAUzs3fUAuws1SJDohcNjwLhh
         dPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=0oj2Lh/zDremXrwwI5FBI0ohoN90BgSKE7ZLqFcSUF4=;
        b=EmomZ0j3lIreEVIvbsnO7fUqkKeAW+id4cKU2zMHIG6thgIvl62C/W25IlTCDMkSil
         BQXvJG8DY20/JMjQqNYZD8qk5BJgAO/S1djSLpbV6VXZPkqKW+chmL9V+/UK6DHRF1G8
         Pbs750hpTfrqjt8aRx0DBRwxLPJ4VAaiUWEFEr6JE7wEGwiKptnOToTNqWUqwksQkD1W
         sdbAj0CeDrCo07kyyNX2HsAt38jGLr52gnfj+KYeR5fOJ4uOzxfJ1MADSktfzW2bWqb5
         aihyNefvaqgZznRj3ezrm6qsdfyEgwmsoJ686BGCAky2gw8YXlp2/ukZMfdeeTM46Nmi
         NUWQ==
X-Gm-Message-State: AOAM530jrg9HJYIldqjDPkU8kc+NchV0UExBmuJbU5pnmWgqfvQRxTKD
        HBsgbi8hh8zRc2r5ErACIVRNh3tExbvoUWS0lAGIEH1PLuWSMvnL/lUchg56gSa1MbPLFrfWmzx
        UMPUFmjW823e4vgQNeYKUofdK6TwjhqBOafKeGAEc3lrFqHTyWUpMesJe2GCrjY3aZIQLBUpyCZ
        G7
X-Google-Smtp-Source: ABdhPJwuEhahaAAvizFQCWj7hHDsMSSZfufeAzu/03Yah/lU3sxfWwxemZL+RRLEBPWe09D+X1oYlXf/bFcJ
Sender: "yudiliu via sendgmr" <yudiliu@yudiliu.mtv.corp.google.com>
X-Received: from yudiliu.mtv.corp.google.com ([2620:15c:202:201:8edc:d4ff:fe53:2823])
 (user=yudiliu job=sendgmr) by 2002:a17:902:d64e:b029:df:e5b1:b7f7 with SMTP
 id y14-20020a170902d64eb02900dfe5b1b7f7mr12876987plh.10.1611782240354; Wed,
 27 Jan 2021 13:17:20 -0800 (PST)
Date:   Wed, 27 Jan 2021 13:17:16 -0800
Message-Id: <20210127131703.v1.1.I7d3819e3c406b20307a56fe96159e8f842f72d89@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v1] Bluetooth: Skip eSCO 2M params when not supported.
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org
Cc:     Yu Liu <yudiliu@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If a peer device doesn't support eSCO 2M we should skip the params that
use it when setting up sync connection since they will always fail.

Signed-off-by: Yu Liu <yudiliu@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v1:
- Initial change

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         | 39 +++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 239ab72f16c6e..71468a9ea798a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1237,6 +1237,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_le_capable(dev)        ((dev)->features[0][4] & LMP_LE)
 #define lmp_sniffsubr_capable(dev) ((dev)->features[0][5] & LMP_SNIFF_SUBR)
 #define lmp_pause_enc_capable(dev) ((dev)->features[0][5] & LMP_PAUSE_ENC)
+#define lmp_esco_2m_capable(dev)   ((dev)->features[0][5] & LMP_EDR_ESCO_2M)
 #define lmp_ext_inq_capable(dev)   ((dev)->features[0][6] & LMP_EXT_INQ)
 #define lmp_le_br_capable(dev)     (!!((dev)->features[0][6] & LMP_SIMUL_LE_BR))
 #define lmp_ssp_capable(dev)       ((dev)->features[0][6] & LMP_SIMPLE_PAIR)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 07c34c55fc508..18740af603963 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -39,24 +39,25 @@ struct sco_param {
 	u16 pkt_type;
 	u16 max_latency;
 	u8  retrans_effort;
+	bool cap_2m_reqd;
 };
 
 static const struct sco_param esco_param_cvsd[] = {
-	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a,	0x01 }, /* S3 */
-	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007,	0x01 }, /* S2 */
-	{ EDR_ESCO_MASK | ESCO_EV3,   0x0007,	0x01 }, /* S1 */
-	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0x01 }, /* D1 */
-	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0x01 }, /* D0 */
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a,	0x01,   true  }, /* S3 */
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007,	0x01,   true  }, /* S2 */
+	{ EDR_ESCO_MASK | ESCO_EV3,   0x0007,	0x01,   false }, /* S1 */
+	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0x01,   false }, /* D1 */
+	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0x01,   false }, /* D0 */
 };
 
 static const struct sco_param sco_param_cvsd[] = {
-	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0xff }, /* D1 */
-	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0xff }, /* D0 */
+	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0xff,   false }, /* D1 */
+	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0xff,   false }, /* D0 */
 };
 
 static const struct sco_param esco_param_msbc[] = {
-	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d,	0x02 }, /* T2 */
-	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008,	0x02 }, /* T1 */
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d,	0x02,   true  }, /* T2 */
+	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008,	0x02,   false }, /* T1 */
 };
 
 /* This function requires the caller holds hdev->lock */
@@ -278,6 +279,20 @@ static void hci_add_sco(struct hci_conn *conn, __u16 handle)
 	hci_send_cmd(hdev, HCI_OP_ADD_SCO, sizeof(cp), &cp);
 }
 
+static bool find_next_esco_param(struct hci_conn *conn,
+				 const struct sco_param *esco_param, int size)
+{
+	for (; conn->attempt <= size; conn->attempt++) {
+		if (lmp_esco_2m_capable(conn->link) ||
+		    !esco_param[conn->attempt - 1].cap_2m_reqd)
+			break;
+		BT_DBG("hcon %p skipped attempt %d, eSCO 2M not supported",
+		       conn, conn->attempt);
+	}
+
+	return conn->attempt <= size;
+}
+
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -299,13 +314,15 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 
 	switch (conn->setting & SCO_AIRMODE_MASK) {
 	case SCO_AIRMODE_TRANSP:
-		if (conn->attempt > ARRAY_SIZE(esco_param_msbc))
+		if (!find_next_esco_param(conn, esco_param_msbc,
+					  ARRAY_SIZE(esco_param_msbc)))
 			return false;
 		param = &esco_param_msbc[conn->attempt - 1];
 		break;
 	case SCO_AIRMODE_CVSD:
 		if (lmp_esco_capable(conn->link)) {
-			if (conn->attempt > ARRAY_SIZE(esco_param_cvsd))
+			if (!find_next_esco_param(conn, esco_param_cvsd,
+						  ARRAY_SIZE(esco_param_cvsd)))
 				return false;
 			param = &esco_param_cvsd[conn->attempt - 1];
 		} else {
-- 
2.30.0.280.ga3ce27912f-goog

