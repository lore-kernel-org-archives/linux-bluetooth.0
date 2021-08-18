Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5B5C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 23:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2607A610CD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 23:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhHRXHV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 19:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbhHRXHT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 19:07:19 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985A4C061764
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 16:06:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 18so3714624pfh.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BrZPmojaZBd8qImGu/C/y4Ujr4Txu0cUgwZfjlLn+g8=;
        b=Fdao8FJ6lxSovQEavfvnVOecANGGdSt3otNqP07oLbM5afa2Wv9XDwGGfm3gYPAq9j
         5aWoZhgZMCpSpS+f1DncDNmpdmO6YpbYG9kFIDCl+4DOQJB4Qfgv4IHt1wlVIAkkSMNc
         j70ueXXhJufD+KzuCO/Ph7lK/CrZ+ugB54Elu2pQQMspC7CZWIDC5SWZB6WRMBlu0PTd
         9HdHk0pFayCGjEeTqJ/W7YEKuAhxKJoQSEjBXggAviC5idtHC1p3NEzqKpT0cR4hVIWS
         RLf5nzyaW63SuRxxUE0ne7o9p0Hjbs459PafRzedEfxBxBnYDzQO80PX5LfJX0ELDaGk
         STTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BrZPmojaZBd8qImGu/C/y4Ujr4Txu0cUgwZfjlLn+g8=;
        b=db65SoJmf27uJZjhtIslr5JMQPtyBCYZjnMJARVHE5MccDtq6Px5Hj7S8yVX6WWepH
         dSVY89F0E/7IAoMLZG72z3NNhXP3zl9XQmyeqsbILCQisDIB4R4SaqdxU2u/581fxA6i
         5azVc3ny5tNiF2TLHACIBdiXHBkl71M2PIPxwUUOgBsaepx9HbFruyZWS89DO048FD23
         QSG29hl/Vf2B793yaoixuNgb4c1kkXtFzyj3XKP/I4ns3fAZwh9WsSubVriuf/kMO2/p
         DVyuiTPiLoqwBcp7vIMJRpsziDxOo77sTIIHwX1UnsbyAhQqA/eJdOTjgXwcbFvILNN9
         CetA==
X-Gm-Message-State: AOAM533CaQsbAU2ivOesraTJkj5LQOAIXCJ8KRkFbZIA/yFQI/P7EWNd
        DzCu4lbupBLMHanbx4710OTX28Q2vic=
X-Google-Smtp-Source: ABdhPJxVqG8JbA47x43cEJgj/7/+5BHYcxDUZErUVq9srNsnWMFGNJJsHPkBKy4lNB3iKrQ0N36uog==
X-Received: by 2002:a62:ed06:0:b029:32c:a800:ba47 with SMTP id u6-20020a62ed060000b029032ca800ba47mr11372636pfh.56.1629328003962;
        Wed, 18 Aug 2021 16:06:43 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b6sm842830pgs.94.2021.08.18.16.06.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:06:43 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 2/3] btdev: Fix order of BT_HCI_EVT_LE_ADV_SET_TERM
Date:   Wed, 18 Aug 2021 16:06:40 -0700
Message-Id: <20210818230641.168705-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818230641.168705-1-luiz.dentz@gmail.com>
References: <20210818230641.168705-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BT_HCI_EVT_LE_ADV_SET_TERM shall come after
BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE otherwise the host doesn't know
the connection handle.
---
 emulator/btdev.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index cd0cfa45f..7e9fa14c2 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5129,22 +5129,17 @@ static void le_ext_conn_complete(struct btdev *btdev,
 			struct le_ext_adv *ext_adv,
 			uint8_t status)
 {
+	struct btdev_conn *conn = NULL;
 	struct bt_hci_evt_le_enhanced_conn_complete ev;
 	struct bt_hci_le_ext_create_conn *lecc = (void *)cmd->data;
 
 	memset(&ev, 0, sizeof(ev));
 
 	if (!status) {
-		struct btdev_conn *conn;
-
 		conn = conn_add_acl(btdev, cmd->peer_addr, cmd->peer_addr_type);
 		if (!conn)
 			return;
 
-		/* Disable EXT ADV */
-		queue_foreach(btdev->le_ext_adv, ext_adv_term, conn);
-		queue_foreach(conn->link->dev->le_ext_adv, ext_adv_term, conn);
-
 		ev.status = status;
 		ev.peer_addr_type = btdev->le_scan_own_addr_type;
 		if (ev.peer_addr_type == 0x01)
@@ -5166,6 +5161,9 @@ static void le_ext_conn_complete(struct btdev *btdev,
 		le_meta_event(conn->link->dev,
 				BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &ev,
 				sizeof(ev));
+
+		/* Disable EXT ADV */
+		queue_foreach(conn->link->dev->le_ext_adv, ext_adv_term, conn);
 	}
 
 	ev.status = status;
@@ -5177,6 +5175,10 @@ static void le_ext_conn_complete(struct btdev *btdev,
 
 	le_meta_event(btdev, BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &ev,
 						sizeof(ev));
+
+	/* Disable EXT ADV */
+	if (conn)
+		queue_foreach(btdev->le_ext_adv, ext_adv_term, conn);
 }
 
 static int cmd_ext_create_conn_complete(struct btdev *dev, const void *data,
-- 
2.31.1

