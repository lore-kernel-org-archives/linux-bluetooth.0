Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F5FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 19:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245101AbhLATxe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 14:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245428AbhLATxW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 14:53:22 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6432C061758
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 11:49:54 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id n85so25595959pfd.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 11:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQBD9mjHcTrab0zT3sCdbHie9kdpyOuDTnCarJeGotc=;
        b=N966FHG4zlXeHP5aY5vbaEvz+76E+m9oNW/iINh62jriA2DssofpqTosdpWvEi0sY8
         fYqZpYiSehlRgj/NS/6nGjFrt4KvsY0DoXL/X7oFptOuHlgBiS622n6LMg4SPVH4iUpQ
         qoSCUYbg29kJDZzqVPFJoaIHQjbI5dXG9K4DeviXvSDVbMrv/IG+8e6KSYGH5w+LfY5Z
         EO+tDweFaSwHr1IoE61dAUcZz/6/7My3j7GCzKt8wX6s+JuOIucPOb8ygEkzd3oOwOak
         DzBBEclNzAA4FUczSZYKFhX/RDlMQxu7a1Go5pD9PVk1WvNvBfYh6BKKTbAwc4oupcn/
         uIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQBD9mjHcTrab0zT3sCdbHie9kdpyOuDTnCarJeGotc=;
        b=4hp7sVBVKFtcgsjke6rBpU2Ovf27a8HdlI6lDVpGxy5TbsvjY3tNz1/b93Dhk3AtY6
         qG0eI20EiBwfuG+Ej2uoLTBRYcbNBI0DIBC0RnhkZ4GmXT0ZuftpLv8HAtIoxFuGfmTk
         dVnMKDrQWgq4g25+w5S+GDMYZZOBJWDUC0SkjonnAyMVjh7Z849E+2b5GuB+H9Rn7g65
         AOXu9r1+tQICMZ+e73LIgXEtjcdZTZV0XPXuxOjG8GSfKnpth+53cB354JSqM9QI7kZv
         y0LNNuIC+mS4iCUwJQoJ0LxbYa00KGOHEcGKQ8rR8MwCOnpvDC3UsVwPw4/avCtC8HLd
         RdtA==
X-Gm-Message-State: AOAM530Z76UR6TOmtAvHpLvlCPPA4yD5tjbGgi9xMmH8QwF4NM5GueoA
        HCAp6wRc2EwHZInPE0DjA1Et5q0uUPw=
X-Google-Smtp-Source: ABdhPJzVMbtTAqBGoz02GJoMlJhyfCLWOFK12OipjyIaZFlJXoALcCnnBu8X7rVlVcPJtGUZCWIxow==
X-Received: by 2002:a63:1cd:: with SMTP id 196mr6059044pgb.417.1638388193981;
        Wed, 01 Dec 2021 11:49:53 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ip6sm122208pjb.42.2021.12.01.11.49.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 11:49:53 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/4] Bluetooth: MGMT: Use hci_dev_test_and_{set,clear}_flag
Date:   Wed,  1 Dec 2021 11:49:49 -0800
Message-Id: <20211201194952.1537811-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make use of hci_dev_test_and_{set,clear}_flag instead of doing 2
operations in a row.

Fixes: cbbdfa6f33198 ("Bluetooth: Enable controller RPA resolution using Experimental feature")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Fix marking Device Privacy Flag even when adapter is not capable of
handling Set Privacy Mode.
v3: Add patch for using hci_dev_test_and_{set,clear}_flag and split
changes reworking how HCI_CONN_FLAG_REMOTE_WAKEUP is set and make use of
bitmap to store the supported flags.
v4: Add Fixes to 1/4, address comments of 2/4 removing changes to
hci_dev_*_flags and moving privacy_mode_capable to 3/4 which makes use of it.

 net/bluetooth/mgmt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bf989ae03f9f..ff6d7c9333be 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4041,10 +4041,10 @@ static int set_zero_key_func(struct sock *sk, struct hci_dev *hdev,
 #endif
 
 	if (hdev && use_ll_privacy(hdev) && !hdev_is_powered(hdev)) {
-		bool changed = hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY);
-
-		hci_dev_clear_flag(hdev, HCI_ENABLE_LL_PRIVACY);
+		bool changed;
 
+		changed = hci_dev_test_and_clear_flag(hdev,
+						      HCI_ENABLE_LL_PRIVACY);
 		if (changed)
 			exp_ll_privacy_feature_changed(false, hdev, sk);
 	}
@@ -4139,15 +4139,15 @@ static int set_rpa_resolution_func(struct sock *sk, struct hci_dev *hdev,
 	val = !!cp->param[0];
 
 	if (val) {
-		changed = !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY);
-		hci_dev_set_flag(hdev, HCI_ENABLE_LL_PRIVACY);
+		changed = !hci_dev_test_and_set_flag(hdev,
+						     HCI_ENABLE_LL_PRIVACY);
 		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
 
 		/* Enable LL privacy + supported settings changed */
 		flags = BIT(0) | BIT(1);
 	} else {
-		changed = hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY);
-		hci_dev_clear_flag(hdev, HCI_ENABLE_LL_PRIVACY);
+		changed = hci_dev_test_and_clear_flag(hdev,
+						      HCI_ENABLE_LL_PRIVACY);
 
 		/* Disable LL privacy + supported settings changed */
 		flags = BIT(1);
-- 
2.33.1

