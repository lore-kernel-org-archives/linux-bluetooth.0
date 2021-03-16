Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE0FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 22:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23BBE64F2B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 22:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCPWum (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 18:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhCPWuO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 18:50:14 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE90C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 15:50:14 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id o70so27862087qke.16
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 15:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jP5/GqQySj/7tefgUzwMUKuAlEsEQXX4qzDDqoIAFnw=;
        b=MsNCSmEyuLpNwnMMAE1Tnewae+Bk47tLY3mHe037zJcyuORuW7cdmR2Qsyxlu2KMEW
         NzAEsWgZiJ2w+VaE9raT6biwHS9zF9E7WnrauxFJIcJnaqldcx7y3b3UhKW5A8R/52Ux
         mF6+buKYOXeSQzGVgKCw1ZzhDzmPQmAIryhyvvEI50qt8Y9UvCpqP/CTaHHRon9H02CU
         9A9e/ic9tMhQ957dnWGva080GJNjzhvfEkiPuKTy7NqaemgR33/lDn2eyIexQqg51kNv
         w2sZOZVqPzEfcGm6SKJ7td2hebX6ogMyueF0Wd3v13sVIG+LZogbueosgAvJcW7Wk3U4
         nh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jP5/GqQySj/7tefgUzwMUKuAlEsEQXX4qzDDqoIAFnw=;
        b=FBBQYDDYlVZJbVzKqO6LwtoMQRo3LEFqORB6O2qZyNzad7KYbnW+ch5wM17BhXr8/Z
         On9YWDLpMHYjRJqPbJOl/booKfw/pO9WKbiEYW0oQ+Po0CqlLmbYfYWUhRB1T778gJLW
         aBhW1wPs3wNs9Fzn3la2y4F9e3p1l2jSKeqaAW7vsG0NKm4j0BLFmALMUY63rrJppWy2
         o6iRnqwfYZsOLzwCy5QUPd6Nu5tFpgtZ/LeioACdsQMTJtb7R2uYjvGbnpvfHz+moarZ
         a5FPRp3Z8m4PRLUBLijw0YnMw4/9oadQEZEhnJuCuZNg+8j4KbkDVQD24sq4sWkoSfM6
         8L2w==
X-Gm-Message-State: AOAM533ygGDkPoUBmTUyOZKr6sFaQNGSY8CDend4Z0lsQd1KDhtxlk3B
        7iFGrYspR47vtNhwWMafsCwp6xl3Z1ra75B1r7YbCtotwJYWB9/bg/0r3soSYRPnInnxhPpfhQN
        Hp16d0Tx2yppWU3IMXB4M6kqreYzhgWSAZgfUMZ38Z4fgPWMCS/oWlTLLTJWSptLB03bbBBTIaq
        VooaGMb5HPZRLns+5T
X-Google-Smtp-Source: ABdhPJwp0yOaxoYS/tjrIVqx0mfbJ/zONABAmID57QB4qSbMo6jiGYm9ZD+eQSmdKmA605lMVy4VbGd8F96g5INhzI/t
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:8543:90a8:2e5c:1402])
 (user=danielwinkler job=sendgmr) by 2002:a05:6214:1051:: with SMTP id
 l17mr2277037qvr.49.1615935013547; Tue, 16 Mar 2021 15:50:13 -0700 (PDT)
Date:   Tue, 16 Mar 2021 15:49:57 -0700
In-Reply-To: <20210316224957.3294962-1-danielwinkler@google.com>
Message-Id: <20210316154901.Bluez.v3.2.I87c7524ba1da470e9ff6ebdf9eef9ef715a9616d@changeid>
Mime-Version: 1.0
References: <20210316224957.3294962-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [Bluez PATCH v3 2/2] doc/mgmt-api: Update documentation for scan_rsp
 param flag
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the new scannable flag to the Add Extended Advertising
Parameters MGMT API documentation.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>

---

Changes in v3: None
Changes in v2: None

 doc/mgmt-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 1736ef009..cab1fffc5 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3632,6 +3632,7 @@ Add Extended Advertising Parameters Command
 		13	The Timeout parameter should be used
 		14	The Interval parameters should be used
 		15	The Tx Power parameter should be used
+		16	The advertisement will contain a scan response
 
 	When the connectable flag is set, then the controller will use
 	undirected connectable advertising. The value of the connectable
@@ -3708,6 +3709,10 @@ Add Extended Advertising Parameters Command
 	chosen by the controller. If the requested Tx Power is outside
 	the valid range, the registration will fail.
 
+	When flag bit 16 is enabled, it indicates that the subsequent request
+	to set advertising data will contain a scan response, and that the
+	parameters should set a PDU type that is scannable.
+
 	Re-adding an already existing instance (i.e. issuing the Add Extended
 	Advertising Parameters command with an Instance identifier of an
 	existing instance) will update that instance's configuration. In this
-- 
2.31.0.rc2.261.g7f71774620-goog

