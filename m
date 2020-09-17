Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECE7C43464
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 22:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8124C208C3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 22:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ZH0qQn3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgIQWWm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgIQWWg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 18:22:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A49EC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:22:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d15so3592704ybk.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6KVYAtT8avJT6nGdwz/alAqsUTxpVl7DrmYqi+6Qdd8=;
        b=ZH0qQn3XVVbWQYzf0YQMBRIESHKTr2OukmgdWCO7WpgSghJMC5GBZgbU+O54fT590T
         eJ89xfjzBGJrWmmoaEn9a2UVFKV0pIgx0iT8sP9XfBjqnoozwvZ1y+AWHgLro7YkEUPB
         /O0KJ4TAhPmFnNalCuIctndomyQddXPjK9UwVLltnQukZkh1lx1df7mwHeAXwv3cp0Hs
         cehN093GPSs7uhvOasMD9SCBzbewXNAapHdl4uWY/UMFm4qBt0k4UCwVe8vdd0/SfFnp
         kZ+tk5yCrr1WDu4S1meI9P6KPsd4rW17FvpYpBT6KwzL8Nvhu8AS9YDFvsyNIx+TlWl5
         RI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6KVYAtT8avJT6nGdwz/alAqsUTxpVl7DrmYqi+6Qdd8=;
        b=TKw/H17VI03USqiW1LoQbM3tjzX5le9i2vmJ27xmeE/9X0KO0qyhtnf0BNkZuWEHuk
         yzMPPLmZW5IhGSLQBy6TvZ6e739FnvYddyasx/dC83ca5476hFDwOzvwXYZh2seCTzQ4
         V64VOrh5H/bWELZgiztDcmtLRp10FOITgNhv5Ls0MOX8dGsysIMaIJ38rzZ8/LN1SHdx
         z+lJD16C57Dq5Zwke/KvnyZQScB0shNM/swUHjNiFwW6QmCn909x1hbZOyeOr38adUsk
         e084XOeE4qSX3ZiL3hw7ltF3xTcbPY2wtnTsajBjdsgd/JCvj8EwIorxCux6p+hiDsEJ
         30sw==
X-Gm-Message-State: AOAM533BHsjqfl/8IugxqIWVEzPRc4wD+BBqUngeEnclExrGypVWXDy5
        wU+H5t4PHZ7KOeeVbmPj4Yp6hsF7O4Mo6F1NU8SW
X-Google-Smtp-Source: ABdhPJxC5/D/JnjQqVL5U6aZTf7ASRpfVuPf7sKnRKkHPapIb8ol4CGQKVQOcDJ5d2kUA1+KTfn8miyv1abmQCzMoMPo
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:c694:: with SMTP id
 k142mr18415607ybf.369.1600381355591; Thu, 17 Sep 2020 15:22:35 -0700 (PDT)
Date:   Thu, 17 Sep 2020 15:22:15 -0700
In-Reply-To: <20200917222217.2534502-1-danielwinkler@google.com>
Message-Id: <20200917152052.v2.4.I34169001276125c476e86ece0b4802c36aa08bca@changeid>
Mime-Version: 1.0
References: <20200917222217.2534502-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v2 4/6] Bluetooth: Emit tx power chosen on ext adv params completion
From:   Daniel Winkler <danielwinkler@google.com>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
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

Changes in v2: None

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
2.28.0.681.g6f77f65b4e-goog

