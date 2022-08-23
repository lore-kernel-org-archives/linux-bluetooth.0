Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237D9C32774
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 04:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiHWEjb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Aug 2022 00:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbiHWEja (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Aug 2022 00:39:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFA952813
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 21:39:29 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3345ad926f2so222030717b3.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 21:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=eCx7HCyYhMVr1Cnt8cn0N8ALL0nL9w7hY17tTHbimY4=;
        b=jrnCAzZ8mUui4idMn39tH4y6Hp+N0XhYghte0f+EXUBENFnuTJtssjk83zBHZO8tBM
         juElvdV++c0aVazJQdJqkTHu6n4jPwo9ZSr+XUmZr44YblGyK2Jj+AxOBl/eiCSMEfxf
         fYR1ewqUaNjWXP4izPlufq9DPAx8V7QVm1MBDH9sthYlvugzZ/gPdoE3d7F9YwS0MDFl
         Mp0tdXCt2GjFwrtLBOWvWtaJiY9CtQ0QjtBmwwMSpYWZmusRitLQQgoWqYJX5GmDUabQ
         UUlxV2ZWWUWLBTntSeYTxvRrODg8VhgTipUx/ujbaXrKXQVgcCp7jjEPkEnhD/w6rWTz
         6EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=eCx7HCyYhMVr1Cnt8cn0N8ALL0nL9w7hY17tTHbimY4=;
        b=Vo2QX2t9KIzbvDe4p6S85j1zW2d2B5x9z1U1g8sqFfDKI/qkiI7RO9gWKh6tWNP17i
         TBtyTWzwP/P9fU/eRiBW2vO0sOCqo4MOZwgFZggsXHKAATyK26L8lFkhKomNIkc2Y1my
         TK0x5YYfah+GiWW1nr4YciyGyf2UmupsXWh8E6Jh3Q++lL1XZ7Wcdxd2RoQItNeb8pcO
         RfymGrxOllgCEPh3at2sdiltpGVbD/swwyfi1VO716WK5O6iwa+Iv95nvTAd9vogFMbh
         rXBGops/CW2YE786LsVp7wSbnZiwOB8U1T2ghuchnm9kLwfdq42SvGSxeF37Pt4HcYRh
         G16w==
X-Gm-Message-State: ACgBeo3b1vBVX8hbdqEomKQoRVa3r2BVJSKtL5RDfXVACO9MxF02Vjbo
        n5awTyysw4s0pXr0ofgAHPQd9Za1+kKt+9whkJeXEwzwFReODyyrD85TbU8ZZ7NUCwbpJXicYdc
        4vdL7TzZX9yQLA87ZtkLpQFb8QNCG7PNu9G4GTF2kKT2avbnPYSM49h2242lYqN6DgAdPvJn9aa
        GS
X-Google-Smtp-Source: AA6agR4HX6Jqo6bJiJyo5zbZUVUEossBVoWuqPVT3688Mpy7XFWNdELwqQdKxOMxR2a6v+aQyaTHhwNEuJ11
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:aa4:997c:9497:366e])
 (user=apusaka job=sendgmr) by 2002:a25:b986:0:b0:671:a73:1ea6 with SMTP id
 r6-20020a25b986000000b006710a731ea6mr21903490ybg.405.1661229568686; Mon, 22
 Aug 2022 21:39:28 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:39:22 +0800
Message-Id: <20220823123850.1.I0cb00facc6a47efc8cee54d5d4a02fadb388e5a5@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] Bluetooth: hci_event: Fix checking conn for le_conn_complete_evt
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Soenke Huster <soenke.huster@eknoes.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

To prevent multiple conn complete events, we shouldn't look up the
conn with hci_lookup_le_connect, since it requires the state to be
BT_CONNECT. By the time the duplicate event is processed, the state
might have changed, so we end up processing the new event anyway.

Change the lookup function to hci_conn_hash_lookup_ba.

Fixes: d5ebaa7c5f6f6 ("Bluetooth: hci_event: Ignore multiple conn complete events")
Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>

---

 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 938abe6352bf..1906822a061b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5801,7 +5801,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	 */
 	hci_dev_clear_flag(hdev, HCI_LE_ADV);
 
-	conn = hci_lookup_le_connect(hdev);
+	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, bdaddr);
 	if (!conn) {
 		/* In case of error status and there is no connection pending
 		 * just unlock as there is nothing to cleanup.
-- 
2.37.1.595.g718a3a8f04-goog

