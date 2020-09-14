Return-Path: <SRS0=Sobe=CX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F380C433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 03:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2059E208E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 03:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VVOgBM6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgINDXA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Sep 2020 23:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgINDW5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Sep 2020 23:22:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D529C06174A
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2020 20:22:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k3so4863883ybk.16
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2020 20:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hgJmWEI4GT2qEDxyV07Ti/eWso4JqJxp8nq9KEqgHMo=;
        b=VVOgBM6ncyldlSn5vj4zzSng5QsdAnTeutiVU+6LKtRgzWANfpnmdvyzNRk/FBF9yW
         8pMqXC+wTDdTI73QgJJKVCs0uUuS/8P80hwGqaNY9UPOSUAUW9Th0BWvgOFzzTOxVMwh
         POSePJeXcRCsjIUCPKa3Mkztsg7z/olS/vMHZBsfgbsAnOJrsg5r3veYquJbKkuk46yQ
         IAlOUPmzcirrhvylzgC7ewy1xcsl8vemC+c+h5uqiHAfNV7ighB9u7E+h+Vlxqrn1bxP
         DF3+aOVJUNihcLVbr3vCgabGPNdWCnNdNYyaRSIC4KP4KXegWHNhfmff6K0SN/fPl29g
         hYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hgJmWEI4GT2qEDxyV07Ti/eWso4JqJxp8nq9KEqgHMo=;
        b=HJlrIWjlx0U73mF+qhD5Nk5YVrQihkdJ2beyPsUihzX2xpoPRrnCTKz0p1XeT+jxKX
         t7z67csgIcsq3488rvpUA6EMGfrW80up7LMVTjVik7NXCfk+nmArusOzIgZWPZI6A1Ed
         3Ii2GLwliQs4gF0eu3bYoMQiY/A/xcxxvrfIa3rrYTq1Kd/nicklxRrcYkqrdmgtMrIJ
         0rd/icEov4HvjWLrGuS+1p0FjZz4MFoEwKEDPqNEZ27r/LMt049vTw6iuUMblhdxX2qH
         XBtAqgNBsNJsM8yIVkg+69hb+gVJun5DS8UIrSsL0TEF37j4YQrqwAPj9ngSdaMNY+Jy
         ljvA==
X-Gm-Message-State: AOAM533pe3MAcE36t7CIVR81W+xOl8aTwNg7W9NU8EYSgZ3SJwbhi+x7
        HTPWF0o6uD9Rcwvr8yuntTLb9HZEUU3xq8nt/CVUjeJ4VB1jFBnl3JhwmaBvoJt3dtmP69Mis/b
        o+RUbiFmlOauNerqPDQzvKWzuF887HrXmOo700Wj6S0tDKxezN3oIcRjztgG/uJH9URS2XEL16w
        3Lx0ATNbnBMNM=
X-Google-Smtp-Source: ABdhPJw9pEgPCnh4+MLBmUP68pMTnFHy6cgmcNEOZfPF3vl/Uj8k/uVvYSFgwPgEbn+2JHzX5XzX5MaLZHh7LRZyPw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:c2c7:: with SMTP id
 s190mr16699397ybf.161.1600053774769; Sun, 13 Sep 2020 20:22:54 -0700 (PDT)
Date:   Mon, 14 Sep 2020 11:22:33 +0800
In-Reply-To: <20200914112137.BlueZ.v4.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
Message-Id: <20200914112137.BlueZ.v4.4.Ieffbe3452565ace2af46a63501c767c8798fd88c@changeid>
Mime-Version: 1.0
References: <20200914112137.BlueZ.v4.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v4 4/4] core: Add AdvertisementMonitor to bluetooth.conf
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mcchou@chromium.org, luiz.von.dentz@intel.com,
        mmandlik@chromium.org, alainm@chromium.org,
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

