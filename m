Return-Path: <SRS0=aWoj=CD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6748EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Aug 2020 23:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B022075E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Aug 2020 23:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="OF4V+BTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHYXcQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgHYXcL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Aug 2020 19:32:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6831C061756
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2020 16:32:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w17so345907ybl.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2020 16:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NtMj2bcsf5T/oy70A+QWn2i5VysKtCM7HUSW6c9Q/F8=;
        b=OF4V+BTAnjuhDpqLAN3ENPlRr166XM4CkXsvkYoyGn409D3rDgpiebFFLDw3Nb3Sxj
         BL4V0wcGv2ATKHvLcee8AHM0nUKWjzsZbBj+ieulmIkxuwpuoBtqwNegR45YD34zu7aC
         9tFk5w88uXhMfV7TRO1pi9MuE3bMy003AifqjPEfhTk39BZVIfI18OtrDorwPG5KYpvb
         ERmyQ5x4uP/FIWisIJEHWGLlwJXhCKFP3ObP0its4rrZwGSatjaXpqixLyPksut9mBC4
         O2gjlb6++NyKz2/y/kiuddgVOJbTFe3KPqKaqrWlAGxd+akzqOmCD/b/jeSp4HiPh8cH
         MgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NtMj2bcsf5T/oy70A+QWn2i5VysKtCM7HUSW6c9Q/F8=;
        b=Dk/U42gdAOGO/NmR/gqQpiXsBWW5D2vr3RCJ4/Dc4aif3tP2rcX0V8RQz9Lj3twMEB
         +FsoisIBGJL0HQxRp8bxfmWCnURMatf9NRAo4qrgfRkuWoSmEzSrNPiLMdMCikG4+qGS
         aV/FUzsjXgHZaQOZiTDs4OaSRydB0FxOFyF+VmOp0LNifW5amItlFeB/RIPBiK0swBST
         WTvghvnagDZC44ixmyczNthmTuSRG4UH29MWs7SFxCuZarIQ3XLfrXzbQaQCFVfCzzJd
         mrFvwRgmQ11HI0bu74UyzKE2Gaz8uPVF/3sLu8N+cXWXXakzGaSVsoyU/LunDxbi9itJ
         vweg==
X-Gm-Message-State: AOAM530KMRFLsFHsp4yfZCqUZbA4OOZAm11gCOl5jLQ8buYVutaKbsoJ
        BgPnpECXLmttERz13E5As09VbqaEc+sxeKq6PgN0ah6AIXrDIBOPtGRq3ix7NLIKztrVQtmQP+z
        FrNo5DBimu2wvRbL/AakKR4t6XpLHycXgZ0uLxxUk18kIjizEZA7kSTrvPoWCXAEIGdJIFMifJt
        55ASjEJKpqtt0WZtPS
X-Google-Smtp-Source: ABdhPJyYcNHSnzxlABPklRA+Q1XOh563ginyu6oORioyUTcYQOT0k/q9zvtSpJqy2O7Bu2rS8xH9F5r60KnWDXBAYgzF
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:428a:: with SMTP id
 p132mr17184715yba.453.1598398329019; Tue, 25 Aug 2020 16:32:09 -0700 (PDT)
Date:   Tue, 25 Aug 2020 16:31:51 -0700
In-Reply-To: <20200825233151.1580920-1-danielwinkler@google.com>
Message-Id: <20200825163120.2.I569943db89c40c4007ef7290d145c9f3d023932f@changeid>
Mime-Version: 1.0
References: <20200825233151.1580920-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 2/2] bluetooth: Add MGMT capability flags for tx power and ext advertising
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For new advertising features, it will be important for userspace to
know the capabilities of the controller and kernel. If the controller
and kernel support extended advertising, we include flags indicating
hardware offloading support and support for setting tx power of adv
instances.

In the future, vendor-specific commands may allow the setting of tx
power in advertising instances, but for now this feature is only
marked available if extended advertising is supported.

This change is manually verified in userspace by ensuring the
advertising manager's supported_flags field is updated with new flags on
hatch chromebook (ext advertising supported).

Signed-off-by: Daniel Winkler <danielwinkler@google.com>
---

 include/net/bluetooth/mgmt.h | 2 ++
 net/bluetooth/mgmt.c         | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index beae5c3980f03b..9ad505b9e694e4 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -572,6 +572,8 @@ struct mgmt_rp_add_advertising {
 #define MGMT_ADV_FLAG_SEC_1M 		BIT(7)
 #define MGMT_ADV_FLAG_SEC_2M 		BIT(8)
 #define MGMT_ADV_FLAG_SEC_CODED 	BIT(9)
+#define MGMT_ADV_FLAG_CAN_SET_TX_POWER	BIT(10)
+#define MGMT_ADV_FLAG_HW_OFFLOAD	BIT(11)
 
 #define MGMT_ADV_FLAG_SEC_MASK	(MGMT_ADV_FLAG_SEC_1M | MGMT_ADV_FLAG_SEC_2M | \
 				 MGMT_ADV_FLAG_SEC_CODED)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8041c9cebd5cf6..c5d128f331c6dc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7202,6 +7202,8 @@ static u32 get_supported_adv_flags(struct hci_dev *hdev)
 
 	if (ext_adv_capable(hdev)) {
 		flags |= MGMT_ADV_FLAG_SEC_1M;
+		flags |= MGMT_ADV_FLAG_HW_OFFLOAD;
+		flags |= MGMT_ADV_FLAG_CAN_SET_TX_POWER;
 
 		if (hdev->le_features[1] & HCI_LE_PHY_2M)
 			flags |= MGMT_ADV_FLAG_SEC_2M;
-- 
2.28.0.297.g1956fa8f8d-goog

