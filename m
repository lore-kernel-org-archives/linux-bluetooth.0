Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A66C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 07:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66E32076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 07:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mYcGRXqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgIPHRW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 03:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgIPHRP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 03:17:15 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D5C061788
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 00:17:15 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id i196so1156129pgc.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 00:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/616tPVzI5drLVga8v2z0esoWN1KtNkrALjdF3/yzcs=;
        b=mYcGRXqib4+CZhdWggECEZywwDwXvzm0oXykEa2nbGDBPpfVPAXq0qGO2OvgTtqbaP
         GT95PHs/sBRaPZDy9qEm1uxfpvW9OE9UeT+0CPO0fnL1c1erb7xsMPaUDib/pWn4m/Sh
         VQ9//0W9OeaW0COezLyWapGW3XKk3YJGDqVPCrBZ5K5SZNu06kg1VFKsbzvXOrf5d/nL
         LeVfu+zgobavmjem176REed1F95s4yEZuzZrefiGExABWUlmqWIGknBl+9Wrle4TSjAA
         +eiFRW7etGRFj+X7nHZJoEHSfmkJNypPmYdpqNj41NCFl1rZGNsdNEhUc3cBGcUTWwsZ
         QNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/616tPVzI5drLVga8v2z0esoWN1KtNkrALjdF3/yzcs=;
        b=OADmBOPKv1wINQDO247yS4vwQ5FCeiCVa02SEBZSZc662QwmuSKSe8UdEZJj2evo3u
         qoDOajojU9hENfpPbZRIqyH8s7AuC8a2K4U2M8nbkN3oGWToee6iI7rnmJJpygcC4OpG
         +EbadDWc6gd7MoqFRzjVAFNZeG5hv7GIxqvLqPx1WKvZYFEphzJNFl0fLWcWPm7o6nxO
         Q2WV8aTdXYeGpUEOvw0Iw5wqikKGSp+vuPEJ8tRJDUEKFgckas4uIdhYNPJkQBEEv1au
         taVj6NnIZd0Of6qWW/TAJKk7XDfXQ5kRvSf0y4X6WKAvMBIblQN11IjEsQqpDPYcsR5D
         NYPw==
X-Gm-Message-State: AOAM531gVH99F49jL0f4C7s1IJubrnQevfnyW6lVXGWJV7TF2qNUMmlC
        6Qugh+4MmHbzCklYO3LWw8Z2m+tdRW7HAaMSM6rxp3Gl+4YZpXk5R0QuSUSJuy3TrjV2e9WxO5r
        Zgk/hymxhZfgdcs0wElHA0y0DBJ2lkqiVaxfCYM8pKOwutCa8u0xZBPWcv4BmOru0TUms3UHs0t
        OAzponEaAVeSo=
X-Google-Smtp-Source: ABdhPJw/o1x3aNHEkNFEfrNyiZeKO3ygZO3KZYnijBB8bR+9RY77lZseYqzaK4wYiwoK2oJjOmdWotWyslAXHj1Ubg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:902:c14b:b029:d1:ec9a:aaae with
 SMTP id 11-20020a170902c14bb02900d1ec9aaaaemr2115689plj.62.1600240633333;
 Wed, 16 Sep 2020 00:17:13 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:16:52 +0800
In-Reply-To: <20200916151617.BlueZ.v5.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
Message-Id: <20200916151617.BlueZ.v5.4.Ieffbe3452565ace2af46a63501c767c8798fd88c@changeid>
Mime-Version: 1.0
References: <20200916151617.BlueZ.v5.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v5 4/4] core: Add AdvertisementMonitor to bluetooth.conf
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, mmandlik@chromium.org,
        mcchou@chromium.org, alainm@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

AdvertisementMonitor must be included in bluetooth.conf in order to
be able to call Release

Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v4)

Changes in v4:
- Remove PRE-UPSTREAM in commit title
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

 src/bluetooth.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 8a1e25801..b6c614908 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -10,6 +10,7 @@
   <policy user="root">
     <allow own="org.bluez"/>
     <allow send_destination="org.bluez"/>
+    <allow send_interface="org.bluez.AdvertisementMonitor1"/>
     <allow send_interface="org.bluez.Agent1"/>
     <allow send_interface="org.bluez.MediaEndpoint1"/>
     <allow send_interface="org.bluez.MediaPlayer1"/>
-- 
2.28.0.618.gf4bc123cb7-goog

