Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35C3C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 17:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651DF206F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 17:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ao6f1ATJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390838AbgKXRbp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 12:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbgKXRbo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 12:31:44 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964F2C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 09:31:44 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id v1so15900536qvf.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 09:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=CtJlsECF7hlnZKh4tQpi//WHbo1gcLjc/PRC8d23KA8=;
        b=ao6f1ATJMZ9AHQrlrgczK2fr3/ys54G+URcRiMD94H9Q+d1Px8ETiWtqNFifwIOP6S
         E1hP84lxcN2KpyI/Z//JFCfA04HaOchLdsTcCcFRj6b6uUcqWwVjVegiIVIPQdLUWlDq
         sJ9MhLsoy+UxXQp/tu18Cg+qYkD1iXqe8nQtQplm3HueIwR9qYtVHOwJEscPfaUY8+Qz
         sPIXrctI8alXUAqorRijwZUMDDLATh3COF00m+Wm8L2gDuebrx+vxyHIE1+Exa0Zovar
         hx3jIMgV1U+wJo3WUy4505Jnd2PJAxKfteecutA5PgVA09ILzTPIhn19QocemH/NUqUB
         tP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=CtJlsECF7hlnZKh4tQpi//WHbo1gcLjc/PRC8d23KA8=;
        b=tLq9Q/rBemVckb0WljcqbDj1lAM4YvwRUp0CrIneHtIRJsbi6fxZOizEJK8NWe7og/
         Yh0goIQOer6YSJLv3enf4EBySM0mRLKz9yQmb+k2WHAdZlpGpW/URzr23jJi6wzMujt1
         c+9nCgiBy47Q8tO1ra2qk2+3zPxmXV3yNVypb6K4BdouEKhEMqzwSRRaJG0I3P3HyHWB
         CFVIodOA4rAwRs02v6B8FcxVcBVorQ1zBD6NvpBWJTJJHK12dxTYP25altqvkpZRV7ik
         TSMalTgvXLr21d6lYd3ijZU7CvcBv0Uzdh7JfxeX8pJ1E7PloBNOFvoUdaIAIgsncAvz
         +TTw==
X-Gm-Message-State: AOAM5336X4666ZaCBDfaKteICSBDrIkyIlAnNOUUxV9EVpMSTYujzOBB
        LwaLjohUQE2Y3o9kFz9z/EoGiK7EYCygq1OHe33O
X-Google-Smtp-Source: ABdhPJxSt0dFfpmdLeefI32SmNOOFgmtv2OlOU6MJQqj/E8wLBRJ7yXumje+lAsB7URlQNPdxTYhS1Kxkco/9/VpkutL
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:d18c:: with SMTP id
 i134mr7752518ybg.448.1606239103777; Tue, 24 Nov 2020 09:31:43 -0800 (PST)
Date:   Tue, 24 Nov 2020 09:31:21 -0800
Message-Id: <20201124173123.1272892-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [Bluez PATCH 0/2] Add mgmt-tester coverage for new advertising MGMT APIs
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Maintainers,

This patch adds a collection of 10 new mgmt-tester test cases to provide
coverage for the new MGMT APIs as part of the extended advertising work.
I split the tests into two patches, one for the new Read Controller
Capabilities MGMT command, and the other for the new Extended Params and
Extended Data commands. I hope this coverage will be satisfactory to
land the extended advertising features in kernel.

The new tests have been verified running Ubuntu and a kernel with the
proposed advertising changes.

Best regards,
Daniel Winkler



Daniel Winkler (2):
  tools/mgmt-tester: Add mgmt-tester coverage for controller
    capabilities
  tools/mgmt-tester: Add tests for individual ext adv MGMT commands

 tools/mgmt-tester.c | 369 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 369 insertions(+)

-- 
2.29.2.454.gaff20da3a2-goog

