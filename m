Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D884EC2BB84
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 20:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF9920936
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 20:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eA0nBtfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgIPUTM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbgIPUQq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 16:16:46 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16875C061355
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 13:16:19 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id g10so7156968qto.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 13:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=a60adGDxqttpuFcY7jkALjROpt4E168K4TU36LymXcQ=;
        b=eA0nBtfTtG7rvNCSw/DDYVnI09PSqUgQFZkOgBxrmPPULPry28kBQ0zp0YUbhQRjOY
         X/E8NDeG2osSs/7lD3gCsOLOu6QL8awcC5TyO4wVvGV1l4WEs3zzPorZGkf+tG0Ri2c8
         j/KmtiLW/tqXu9JkGdHN2Ul/PEKR3PGhKDj8Y56rE96mQ5a4BD1wPiIY9/IcPJHyLeFS
         iHodk/vtswNP5kuPqaFTYFghWdGKDEh6aPduQ6vJLD5OsSPO1fMQXHjQ1TxAOR1+lU6P
         J/WzPQC5hevNpKvZmCd5aQ8LADPabI+kYKMJuoI+pPQhlN8YDxjFM4IfqB3WMIsxuGR2
         uVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a60adGDxqttpuFcY7jkALjROpt4E168K4TU36LymXcQ=;
        b=A12CVnNGMYm4j6oEXIyMEVnQXxIpl8eglxa72TAlXD4E/V8oyypTAlalmXVkptoULF
         VadGJzEDw4+gqRAhLPICuDcLI/L9vD/ZWGkz9Mt2FlDGOlF/ZSXal5Ny7R6T8fJ74vRl
         IB70udsNlxglyq3t+V9MuTDqKye389e0dYMHTu9ZYmvlXw7bXrx+gOvZq4/mBVoFetDu
         cXEowIoTVCMFgvQspGYggZvUrLzwiGPjOKZwfhjr3J8KN6mnbsdxlQHx0Xlj5DPpyn0u
         NpmGTk5X4N6xpVnrKPzN7uJhHIZ+6rzvofuqYfwlgIESsqUanP6i8lgy9m2w2Z0fplb2
         YY5g==
X-Gm-Message-State: AOAM531ljk5bju/2s7VeRERJEjaEaG1CgbkXGJ7Hg9NVBxAIeaXdS8ge
        tJwJlFhErr5G4DMEUGgVwcUfz0fxpe4DzrDLHaeLJzXGu+2FsZzgQhNe8EZRTpW6PE74Ex+blAz
        3Jdgni0OkIT2Q+BDY0Lx7d7j8qT+Ijcr39oWv1ziSUQME0ZGKP44EQNmB+hSj9CNMSBwKtE94Qj
        vTZKyJTo5UnhngZLDe
X-Google-Smtp-Source: ABdhPJzfBMACV3i9Ag2je48WjOHXDjCnBloIo08bMmmfrF6UQkcJ9p9JN/Tx9z7Yh/AB7BqsJ+OmUXhXeqT6/JFDXhz1
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:ad4:5653:: with SMTP id
 bl19mr24887200qvb.7.1600287378198; Wed, 16 Sep 2020 13:16:18 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:16:00 -0700
In-Reply-To: <20200916201602.1223002-1-danielwinkler@google.com>
Message-Id: <20200916131430.4.I34169001276125c476e86ece0b4802c36aa08bca@changeid>
Mime-Version: 1.0
References: <20200916201602.1223002-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH 4/6] Bluetooth: Emit tx power chosen on ext adv params completion
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Our hci call to set extended advertising parameters returns the actual
tx power selected by the controller. This patch signals a new
TX_POWER_SELECTED mgmt event to alert the caller of the actual tx power
that is being used. This is important because the power selected will
not necessarily match the power requested by the user.

This patch is manually verified by ensuring the tx power selected event
is signalled and caught by bluetoothd.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Signed-off-by: Daniel Winkler <danielwinkler@google.com>
---

 include/net/bluetooth/hci_core.h |  2 ++
 include/net/bluetooth/mgmt.h     |  6 ++++++
 net/bluetooth/hci_event.c        |  4 ++++
 net/bluetooth/mgmt.c             | 11 +++++++++++
 4 files changed, 23 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ab168f46b6d909..667b9d37099dec 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1781,6 +1781,8 @@ void mgmt_advertising_added(struct sock *sk, struct hci_dev *hdev,
 			    u8 instance);
 void mgmt_advertising_removed(struct sock *sk, struct hci_dev *hdev,
 			      u8 instance);
+void mgmt_adv_tx_power_selected(struct hci_dev *hdev, u8 instance,
+				s8 tx_power);
 int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *skip);
 
 u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 859f0d3cd6ea38..db64cf4747554c 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -1079,3 +1079,9 @@ struct mgmt_ev_controller_resume {
 #define MGMT_WAKE_REASON_NON_BT_WAKE		0x0
 #define MGMT_WAKE_REASON_UNEXPECTED		0x1
 #define MGMT_WAKE_REASON_REMOTE_WAKE		0x2
+
+#define MGMT_EV_ADV_TX_POWER_SELECTED	0x002f
+struct mgmt_ev_adv_tx_power_selected {
+	__u8	instance;
+	__s8	tx_power;
+}  __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bd306ba3ade545..9a24fd99d9e08e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1749,6 +1749,10 @@ static void hci_cc_set_ext_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 	/* Update adv data as tx power is known now */
 	hci_req_update_adv_data(hdev, hdev->cur_adv_instance);
+
+	if (cp->handle)
+		mgmt_adv_tx_power_selected(hdev, cp->handle, rp->tx_power);
+
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 717c97affb1554..b9347ff1a1e961 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -167,6 +167,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_DEVICE_FLAGS_CHANGED,
 	MGMT_EV_CONTROLLER_SUSPEND,
 	MGMT_EV_CONTROLLER_RESUME,
+	MGMT_EV_ADV_TX_POWER_SELECTED,
 };
 
 static const u16 mgmt_untrusted_commands[] = {
@@ -1152,6 +1153,16 @@ void mgmt_advertising_removed(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_ADVERTISING_REMOVED, hdev, &ev, sizeof(ev), sk);
 }
 
+void mgmt_adv_tx_power_selected(struct hci_dev *hdev, u8 instance, s8 tx_power)
+{
+	struct mgmt_ev_adv_tx_power_selected ev;
+
+	ev.instance = instance;
+	ev.tx_power = tx_power;
+
+	mgmt_event(MGMT_EV_ADV_TX_POWER_SELECTED, hdev, &ev, sizeof(ev), NULL);
+}
+
 static void cancel_adv_timeout(struct hci_dev *hdev)
 {
 	if (hdev->adv_instance_timeout) {
-- 
2.28.0.618.gf4bc123cb7-goog

