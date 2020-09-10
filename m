Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC6EC43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 10:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F042145D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 10:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qUhGnMCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgIJKe7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbgIJKeW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 06:34:22 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F05DC061795
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 03:34:19 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id i23so3333146pju.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 03:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Mz2x8H2u+dcISQMEODChynSBMMwhzWBKqD5b3CthGT4=;
        b=qUhGnMCQKFD46o0jnL3hhbDCU1tGBAzXBpowlUBYQVGWU0gnGDGIehZudVn+W1SAzi
         PvQmMGl6OlNrE1pCeC+Q+4DJ7ojRyvby5q6qi4jHHDCREzOGM4f28H5az4uYg/xZtiRY
         ueZeH2Mue0UlY762ddqCHanOXErpMjBC39g1D+Mf9qCjhSPE8ggTsta+czW53LT153Ne
         Km++8a52NHJVcftlTDj7V9fGiBg/0TshPd5oiHTrLsWyY8XQzO99IlGrqsFukcRUDtMX
         BT/XStT9x7eic/XYUIbGa8A9TBo+qvfgsX+kdMEVe9G31GdGUbyP1EEulZLjjkz3Vpmw
         b7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Mz2x8H2u+dcISQMEODChynSBMMwhzWBKqD5b3CthGT4=;
        b=FUHN1lG7AafY2MIzIQ7V3P5ducDDqEVBBviG8P1INaxMGf6M8y58RgeeIfkH2z/OMo
         Yn8OG50PDdCYNGzc9YyV3ga+WRo+VjoPUhZwZSvI968v1pWRN3UeKbA7Fg8gXQGPayt5
         4U+cTlFpn0xzIwzBIr/ARHATHrXa242x5Mm8ySrOfg0YSUH5EoBrYDrwhxAUrDS1vxBn
         I0bkM6snNc1QOGtejTwNqHu5cJnf+19CWEYemNrWTMLIpjuPsWNvCIfr9fgLSUOBgiLx
         5pXAhHD1C7/LluhpaXjlJ/njWkymJXrknaW9iUim462kqqZi98h97mCiiB/wRPhLfO59
         3HjQ==
X-Gm-Message-State: AOAM532plbZi1zOcFEGouZ/yAxn4exgJ6zFsmxhqBUhlJQpBR+bOyrl+
        srbeU2UnVqIodSOYAV/g4T0HF40wjeafqy+WKfRpIGeR0Ze6m9iWDn4k4lxUHfuivRxym67uSOw
        vPXJUJcMGov5mdyXMAAjGUH4+9ZE5lH+AcUdFQnYL/Gt3hUI8qCcS2dWVYrIRa/he/chfeq6Nek
        nilL8rvPNQ2TE=
X-Google-Smtp-Source: ABdhPJwjGjw9TjJ20kbaO9rR8ecmccjeWVqky0iCLkQP1ZHcbC2vhz5HuSFfv47Xn2sBXJK3ri0V+EEh2Z3F3fM/qQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:902:8306:b029:d0:cbe1:e7aa with
 SMTP id bd6-20020a1709028306b02900d0cbe1e7aamr5041899plb.27.1599734058598;
 Thu, 10 Sep 2020 03:34:18 -0700 (PDT)
Date:   Thu, 10 Sep 2020 18:34:02 +0800
In-Reply-To: <20200910183329.BlueZ.v2.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
Message-Id: <20200910183329.BlueZ.v2.4.Ieffbe3452565ace2af46a63501c767c8798fd88c@changeid>
Mime-Version: 1.0
References: <20200910183329.BlueZ.v2.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [BlueZ PATCH v2 4/4] PRE-UPSTREAM: core: Add AdvertisementMonitor to bluetooth.conf
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, mcchou@chromium.org,
        mmandlik@chromium.org, alainm@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

AdvertisementMonitor must be included in bluetooth.conf in order to
be able to call Release

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v1)

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
2.28.0.526.ge36021eeef-goog

