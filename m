Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE41BC4742C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 23:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825A6214F1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 23:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKFkdBr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgJ2XGu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 19:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgJ2XGt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 19:06:49 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E47C0613D2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 16:06:48 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id r16so3027729pls.19
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 16:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iWeiI3PZKNM3ytVVwyt4UkTp4eBynwSbJGDIwrznYV4=;
        b=jKFkdBr3ZIQYpsDYVpP4jgBhV2Mn8bTJGZP82UDaiH9JODl7Eoa3yMVviEsM6n3Vpw
         DgKSYxhwN9Rt7/RiT9vCJP+Bb9mPQqweuo4TbORNEQpxn0zaTvp1w/mZmT6T0kK0Hk5H
         cDYZ2a7jVcv8jUJAHy5+YEYZ0fuYFXKCe3Qrv3YFD0fOY6z/qTLb/pRUaKYypnScaJXK
         I4+nNaBhJPOrzI2KNIh9ePo752qqEQgt5sdf53XrbgXuPBlN3KfQNUCzCO58+gGoyTVv
         cqe4b6gtkE/Eguv6QZPPc6geJfVcBcXVxkAqqh/lbnJZghRshBrsLJdvls5UnRuPFzg4
         eEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iWeiI3PZKNM3ytVVwyt4UkTp4eBynwSbJGDIwrznYV4=;
        b=klZYrbr/9Eli9RHP0R0CUStVCrwtqKDsH9K/BORLXWTFJCxZiyskRuQlYufkQKncCn
         2GyZJ6UEYswYYwFeRr/WakI7Q85DXK9mxHIqYkBEzqJYC1DNkiGgyeKNYcOgW+pPBz0V
         iNno73ejVH2ggNpNqE/eJyx9W7gzx84WVokIEttiU+yxLIVlSesTzI6dLsXtq0EwTK3Z
         9U2y8Zhn/O0R6Rzih3RW2H1lVI4EUwA48hGMqf107i3hu/ojH3l01j9H0o3rT6djiuWL
         K15sRWX7Eh8sQrF5dniUd+aVur+CB0UdElfTG4WLhkd88IEP2hGWR1Squ8JxHRrZm16K
         v5MA==
X-Gm-Message-State: AOAM5326YvDf6BF7VdRbE31r6oIzbQvLvItuTkgJ7VqMDkFCzaP8D6Jg
        ddoGs9aYXoIJLSqK1ejt3PrWoL1PjD88fIdmRx7C
X-Google-Smtp-Source: ABdhPJw2LtNdI+YrgWl+iMx1BoTyBB+HoRFk+Li0sPAD8Ir5427Jd9+zLx9fNKAo42E0VRL2nJUuGVARC6JOhCY1/ZsZ
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a62:7a8f:0:b029:163:d0b3:ac18 with
 SMTP id v137-20020a627a8f0000b0290163d0b3ac18mr7107078pfc.9.1604012808348;
 Thu, 29 Oct 2020 16:06:48 -0700 (PDT)
Date:   Thu, 29 Oct 2020 16:06:21 -0700
In-Reply-To: <20201029230623.3630069-1-danielwinkler@google.com>
Message-Id: <20201029160317.Bluez.v6.9.Ic9eec7749b769aa5bf73a0d8e9a31be83f232f1c@changeid>
Mime-Version: 1.0
References: <20201029230623.3630069-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v6 09/10] client: Add SupportedCapabilities to bluetoothctl
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the new "SupportedCapabilities" property to the
bluetoothctl "show" view.

The change is tested by verifying bluetoothctl shows the desired
properties.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 60f1eb86e..9403f1af6 100644
--- a/client/main.c
+++ b/client/main.c
@@ -941,6 +941,7 @@ static void cmd_show(int argc, char *argv[])
 		print_property(adapter->ad_proxy, "SupportedInstances");
 		print_property(adapter->ad_proxy, "SupportedIncludes");
 		print_property(adapter->ad_proxy, "SupportedSecondaryChannels");
+		print_property(adapter->ad_proxy, "SupportedCapabilities");
 	}
 
 	if (adapter->adv_monitor_proxy) {
-- 
2.29.1.341.ge80a0c044ae-goog

