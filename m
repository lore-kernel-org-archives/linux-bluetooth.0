Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9823BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 20:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhLUUuZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Dec 2021 15:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhLUUuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Dec 2021 15:50:24 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827C9C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 12:50:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x1-20020a17090a2b0100b001b103e48cfaso2757753pjc.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 12:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y1ismcWgDnFFXISLA/l57y2B3Rq2xdUkaw18gPCSGm0=;
        b=VVixS75Im7AU6TSyn4M5NPbuJGTpke17jfBlWzRZT9uin4xLu1wWlovzDfFWmm7Wos
         3r38kz7frvZg8CrSKy52vyx3XSH3xS26BSVX3clwx4f4r+w8LlN+EoxJx/B3OSRPA6fD
         91yzZgBD+YcsqK6Ur2Iy+624Ds4L41guNOoW76vXfZqFsz5sZ5Syb/v6VkXX3VveM2JZ
         fgFpDtfpNb5jnGTKkbxDmTMiAwMoSyvqaIpmi1Z4gS9hhCgURlAdf5f8V2CEksnp+1Zy
         lqxZyuF0+0BqeMNH2cj5y7oFLu4UtK/DWVKgzfMbJ73/ad9mMMkYzgIPSAQk8CyFWjhU
         aTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y1ismcWgDnFFXISLA/l57y2B3Rq2xdUkaw18gPCSGm0=;
        b=Wx8E1npHfcav1UrBwwERLZIk3nWb57RMTqXoDEJ3CR0cOVlq8PteQY7S6ZSytIdHXu
         j/vHdIEhgg41blcENxhRcybZtXR/PNOAqznk8ojoYwuFI02oyy7LPOiT1grQY84Ua1cH
         lAoyap8wgRV9825fBlDKHuiVORoSTUfJZxYqfI1afxxqzVBz5bFk6J2e77zITzYlktyQ
         dD0AXBB2LLPx9BcSi/H2Iy6uyhFdByG1mVQcFuUnCpI3facKniGsZE9BbAJOlxJlDSus
         HAK/GnNlcbj5PAXZRSNQDQbJ33sV85Fo8qfBzJ9+EZhD1xx92jOqdYGVkS0+rq4v2XFE
         8OWA==
X-Gm-Message-State: AOAM532zuBMi1FfN295WxOMC446r0GzfzBvRA64Dwj9jpIL1ROYEr/te
        ajSYdgLav1yK7wn7I2Ms+v0mK+5GDUs=
X-Google-Smtp-Source: ABdhPJxpW23+tMeViNNJdNDxnNHBn/N6N1dZtq1zj/2puWfovJ+jo4/66tnXJo06NZxj3NSJmOExoA==
X-Received: by 2002:a17:90b:1297:: with SMTP id fw23mr51672pjb.97.1640119823803;
        Tue, 21 Dec 2021 12:50:23 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 72sm3973pfu.70.2021.12.21.12.50.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 12:50:23 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/4] bootstrap-configure: Enable sanitizer options
Date:   Tue, 21 Dec 2021 12:50:18 -0800
Message-Id: <20211221205019.654432-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211221205019.654432-1-luiz.dentz@gmail.com>
References: <20211221205019.654432-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bootstrap-configure enables all sanitizers.
---
 bootstrap-configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bootstrap-configure b/bootstrap-configure
index a34be8320..8172840d5 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -28,6 +28,9 @@ fi
 		--enable-btpclient \
 		--enable-logger \
 		--enable-pie \
+		--enable-asan \
+		--enable-lsan \
+		--enable-ubsan \
 		--enable-cups \
 		--enable-library \
 		--enable-admin \
-- 
2.33.1

