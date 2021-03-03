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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647C8C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 00:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354BE64E46
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 00:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348088AbhCDAdz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387123AbhCCTQN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Mar 2021 14:16:13 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEB3C061762
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Mar 2021 11:15:33 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id k1so16879000qtp.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Mar 2021 11:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=N8PCfwZicPjsnptNF7G2E2FEEsEc1qJ+kpbU5CqawP4=;
        b=SiqOub67DbuT7DposIVvjRTO5q6bbjEYPp2lv1j+m1Fc+fdHLnq5h2pIQWBmODeHAa
         3wo7u5CoSmMLYGcT3oouHik8GTpdL+NM6YC5ZX6ulHa1QJhSWAEYqdqETmOBpWLe0/px
         FNGoIWcpECCqmMMpTApmatf2xo7Xs6b+t4/DSU4DJiBDbTYdDv1B8utLYMiWXFRXIeCi
         a0Aqi1vTY+P8QypncQG1WY0T7N3CFAZxQihnDTt54xOYiqXFaQFuKLQpbRjdKJFGXy9R
         Np1exSKW/If5gBbUoqqKhaViJNfq8ZWo4qcV5ZA3Q+qaj6HDhghLusZIeMNglzq+quo4
         27yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=N8PCfwZicPjsnptNF7G2E2FEEsEc1qJ+kpbU5CqawP4=;
        b=OIHJRaGnqGaSAWWxVphf4kBiEfmWzV52o6CbyQ6ZfoCAFDpeF4Xe7996YMSPmaj4Qj
         XvWMsM8oL7XoIJqr5u1sMfzjsF9WAitFv0cIVJevCru/1Ru95rPY9CZHZUuPxma+qUgq
         c+A/RGjBh3N6awYyl8/yZ893xkCPbkY0mS/q741zHUSRhppIuGgIb55xm3DtqPk1DR8H
         eVj4gn+jw0zrprL+1lpI4DSB8tKMJTd4vPtuJSo0g7wCsk4c3XXpvaVlXmxoAhLgGN6Z
         x6Zq6WbjMUUB+9EOf0NTj9GtFGD6J/6hr6X9i9KLIq8/P+kz/bpGjY6dECx9eoo/9ocu
         kAXA==
X-Gm-Message-State: AOAM530Xp8NnpZSK5UaSvxk9qsPzl/5KijuiQCVCVsj+CJG4aiiYZEnW
        u0mr9K8zSm51GekUs87doL7u4NCW9XGgMAuN2MKKrvsfY1EoU1wnciuNMYLbcjweOC39zx/JY9C
        u26nDkX93x7chbdcU4aaATJQ57pwnpeY21ickdKXn0gaHbDX/bz0MQww10bHXAiuUGuLnMVXrg9
        bhqigIiFJ52Og7i7He
X-Google-Smtp-Source: ABdhPJya3+Hh2v8LbImh80jXmV/JKUWZRYhKVapcRH3hx1xBKqafauSSyEeY9KojiIXO5EJvCzYXFPuyCDgQowuwMnSE
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:45cc:69de:aba1:a948])
 (user=danielwinkler job=sendgmr) by 2002:ad4:5b86:: with SMTP id
 6mr669445qvp.15.1614798932019; Wed, 03 Mar 2021 11:15:32 -0800 (PST)
Date:   Wed,  3 Mar 2021 11:15:23 -0800
Message-Id: <20210303111505.1.I3108b046a478cb4f1b85aeb84edb0f127cff81a8@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] Bluetooth: Allow scannable adv with extended MGMT APIs
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

An issue was found, where if a bluetooth client requests a broadcast
advertisement with scan response data, it will not be properly
registered with the controller. This is because at the time that the
hci_cp_le_set_scan_param structure is created, the scan response will
not yet have been received since it comes in a second MGMT call. With
empty scan response, the request defaults to a non-scannable PDU type.
On some controllers, the subsequent scan response request will fail due
to incorrect PDU type, and others will succeed and not use the scan
response.

This fix allows the advertising parameters MGMT call to include a flag
to let the kernel know whether a scan response will be coming, so that
the correct PDU type is used in the first place. A bluetoothd change is
also incoming to take advantage of it.

To test this, I created a broadcast advertisement with scan response
data and registered it on the hatch chromebook. Without this change, the
request fails, and with it will succeed.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Daniel Winkler <danielwinkler@google.com>
---

 include/net/bluetooth/mgmt.h | 1 +
 net/bluetooth/hci_request.c  | 3 ++-
 net/bluetooth/mgmt.c         | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 839a2028009ea1..a7cffb06956517 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -578,6 +578,7 @@ struct mgmt_rp_add_advertising {
 #define MGMT_ADV_PARAM_TIMEOUT		BIT(13)
 #define MGMT_ADV_PARAM_INTERVALS	BIT(14)
 #define MGMT_ADV_PARAM_TX_POWER		BIT(15)
+#define MGMT_ADV_PARAM_SCAN_RSP		BIT(16)
 
 #define MGMT_ADV_FLAG_SEC_MASK	(MGMT_ADV_FLAG_SEC_1M | MGMT_ADV_FLAG_SEC_2M | \
 				 MGMT_ADV_FLAG_SEC_CODED)
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 75a42178c82d9b..d7ee11ef70d3e1 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2180,7 +2180,8 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_CONN_IND);
 		else
 			cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_IND);
-	} else if (adv_instance_is_scannable(hdev, instance)) {
+	} else if (adv_instance_is_scannable(hdev, instance) ||
+		   (flags & MGMT_ADV_PARAM_SCAN_RSP)) {
 		if (secondary_adv)
 			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_SCAN_IND);
 		else
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 74971b4bd4570d..90334ac4a13589 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7432,6 +7432,7 @@ static u32 get_supported_adv_flags(struct hci_dev *hdev)
 	flags |= MGMT_ADV_PARAM_TIMEOUT;
 	flags |= MGMT_ADV_PARAM_INTERVALS;
 	flags |= MGMT_ADV_PARAM_TX_POWER;
+	flags |= MGMT_ADV_PARAM_SCAN_RSP;
 
 	/* In extended adv TX_POWER returned from Set Adv Param
 	 * will be always valid.
-- 
2.30.1.766.gb4fecdf3b7-goog

