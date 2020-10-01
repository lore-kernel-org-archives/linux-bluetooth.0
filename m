Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1355AC4727E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC283207DE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uaU6TQ+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733304AbgJAXCR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 19:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733085AbgJAXCR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 19:02:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA76AC0613D0
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2020 16:02:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s128so497488ybc.21
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2020 16:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=r1AFoBxAPk7wKL3y1c0y6VCdbm5CNkRKbA4Ow9An79U=;
        b=uaU6TQ+lJCQpvIKSnnpYSB667UtrVWnY8D9nMAY07GOp4QFndex6ZPyiXuGVKafE25
         T6wy5bep1VnJlqOlhr0QLsQBRfCQuB1zoKOQsyt15BJAo318eDLD5eyXA7w4E7fdxX/n
         JvfWoLacFIT6/qeXxG55NsdhOu0h/Mog5hQ6bWAXUlRXM8mfMSqXNIyb7AwkAKwxrKl1
         N1HVfrm3/DtWVgG+3AiCa9qX2TGdCX/t/jsFB/2kBgailwG+VJMFP6JK5bcQ6Pcgy94K
         +sga2a6efIZ6Q7TiIEK2c7kDD7eWZrQcdCdM/c8iX13gT5SX8+gpAw3+3YrA+XvSIETJ
         eqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r1AFoBxAPk7wKL3y1c0y6VCdbm5CNkRKbA4Ow9An79U=;
        b=JC9cXMvk5yobMS6JgOLOY6uS4NqCnkJnGsS2KhjoMu3nYm6WC5zT46jHKcX+F0/WW+
         PQ3G/6lomNSUDtJLMGIbWUJo4JsImwMlb2UFR9nYO6Gmg2AoIzN1GEx8+9MjMT0XaCeI
         wvxlRoK31TnAgjBy0rfvnLOIbqCZ0Wqsj+nqObYVkR1tkOYczpe3uPLVwuC3GF6q7+Pu
         rU7nIu1sCRPM68lxO9werUfLHVO4TvSANIvb//6hjEIlJl811mZm2wspm31xnBhM5ajG
         0y7jxbU3R3dy6e4tVLfZopOuwC+0AEw05BN/k1PbqVT7jmwUT8l8nTOCe0/QTDUE7uhw
         RvPw==
X-Gm-Message-State: AOAM531u6NKybjHcXsq+ameOrjvwfQt/CKzR77zfrfrJAvMt7ffOC0L3
        oEW7O9DYAXwCasCXlxu/gJVEeLkL+GbIHZ5pYG9P
X-Google-Smtp-Source: ABdhPJwskWgBH3OJRWtOb9ObqgmHYOBy5E+VmAsKhQtYWD4IphdGe3PT++wQZwrDimAZF+1TW6G4eYRBeg9rh1kOA+Cp
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:558:: with SMTP id
 85mr13634575ybf.315.1601593336134; Thu, 01 Oct 2020 16:02:16 -0700 (PDT)
Date:   Thu,  1 Oct 2020 16:01:51 -0700
In-Reply-To: <20201001230152.2422908-1-danielwinkler@google.com>
Message-Id: <20201001155738.Bluez.v4.9.Ic9eec7749b769aa5bf73a0d8e9a31be83f232f1c@changeid>
Mime-Version: 1.0
References: <20201001230152.2422908-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v4 09/10] client: Add SupportedCapabilities to bluetoothctl
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
2.28.0.709.gb0816b6eb0-goog

