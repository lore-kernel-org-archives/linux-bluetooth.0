Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F9DC43464
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 027FF21734
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pq8lYqFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIRWO0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgIRWO0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 18:14:26 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF64C0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:26 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 24so186757pgm.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hBa/AroYAfFXZZcTqpW4A2vXre//hNzr99oZmnbGxrQ=;
        b=Pq8lYqFqir3rF0IxPvYdhbXhwXyoi4bmjIJYCOaSP9wiKYgzP4Qx0ysoqAwhGYalQa
         gDTrhWwlB4hIcXR/pJAv4iL3nXk49vRBRFPdAHbGUVYgf+3q6SdyzoA4uq15jQf+rH9t
         D1aiHFDEGhfkZ1zDVZI+ow6GKplhsG5K4RMxxvsMjEFeZMR87GfXfSYhy31ZKxrxEDxx
         v8vbKy6OlFqyEvxa6Lvu2Aahe/EflL+LEFFxZsBdozOa0t+08qnM0jdxclaGaRwJa+Hq
         2HRAAKR5lds/Ccwk4gG+xr7Mm0mWCpkP4NHY8bXuHVVVtnx1iP8Q8y4PFyc5z91W03HJ
         K04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hBa/AroYAfFXZZcTqpW4A2vXre//hNzr99oZmnbGxrQ=;
        b=koQG4J0RZwhjRBy/YFWg7ZJiUShOxD8ulRxX9TiyS60fXrWmEzU2vf40u6J24m5TSZ
         wrSNEhLJIf2i1/TZ/qOOzyLop4/xHPTABUqzABZlJoMq3q6RsaIHE9ckMOXGQwmi/OKV
         uHf0jsyYHZfSynoeexPZr1vCiikgXw/i9Ve4LVxDgtnuAKqlNbVRiCv/Jyd1f59DlOsp
         +sHfSexbdvyD7iqfv2IegDvMNO6LlwlfH2jj5mPXlctYhN3b5piUpGtEuhhfFY9MxPA3
         uDMHccnhI9ut0ZnZCBqi/cVBsbzMYk8fwqsMSv5vVx9YRAYXIoy0Y3ZfDgU1mwWiUIt1
         Co1g==
X-Gm-Message-State: AOAM5331IRWYgReaiVnUunmAYZbkPnzYZK9mpRKbEr6tMgGvclAoOCxL
        fx3g4qaDiH9+6iPFxXI8eU0btmBCt4lL4QSE9qBY
X-Google-Smtp-Source: ABdhPJyzO3MizyV2jm3ejIn5Tdk/6NXv4+HhGlahhSSENSkSt6cc7dkPue0iRiX+NRQLuG/0Hwq9YnXzC7LCiyzeau3g
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:aa7:9f04:0:b029:13e:d13d:a08c with
 SMTP id g4-20020aa79f040000b029013ed13da08cmr33080360pfr.35.1600467265920;
 Fri, 18 Sep 2020 15:14:25 -0700 (PDT)
Date:   Fri, 18 Sep 2020 15:13:56 -0700
In-Reply-To: <20200918221357.3436905-1-danielwinkler@google.com>
Message-Id: <20200918151041.Bluez.v2.9.Ic9eec7749b769aa5bf73a0d8e9a31be83f232f1c@changeid>
Mime-Version: 1.0
References: <20200918221357.3436905-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [Bluez PATCH v2 09/10] client: Add SupportedCapabilities to bluetoothctl
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
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

Changes in v2: None

 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 2b0243308..cb8ef54ad 100644
--- a/client/main.c
+++ b/client/main.c
@@ -954,6 +954,7 @@ static void cmd_show(int argc, char *argv[])
 		print_property(adapter->ad_proxy, "SupportedInstances");
 		print_property(adapter->ad_proxy, "SupportedIncludes");
 		print_property(adapter->ad_proxy, "SupportedSecondaryChannels");
+		print_property(adapter->ad_proxy, "SupportedCapabilities");
 	}
 
 	if (adapter->adv_monitor_proxy) {
-- 
2.28.0.681.g6f77f65b4e-goog

