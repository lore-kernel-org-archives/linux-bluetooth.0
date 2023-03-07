Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E02DC6FD1E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 22:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjCGWZ2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjCGWZJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 17:25:09 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF8E96603
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 14:24:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so251130pjh.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 14:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678227868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYyQX+0EeYSzuu9TE8HE0kzl55hbyMad+FvqeBkBoGw=;
        b=pUUsAISzCtO5/2EELpsd0yxFt2nDnEzA5udrrV79QAbcpvilmvaYEYoCdIYQW/d9zs
         gFSL1YIl6eFqN/8nq9kbExF6opAV64sNug5oPRqWqayXmLf/u58aLPwr3G7hYWeEYYAI
         fkTCD7pFaUq2whZalz18fMrgYIqsfphfs14zV2qi4TsU6g/dywM58wvYRKJREUOmlI56
         XfDYlEGWQ4TFjktCbuxJF+VTAlseWP1BdnhrkYgASiK1vzqwOKB9u3qfaVC4fLQMS1hP
         eIPVbz3uwMkydZ7wBhIMNrkPRJwhenxqQC1AJ8hYMvGsNZaujO0e2rkWWXogVutozIUN
         WbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678227868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYyQX+0EeYSzuu9TE8HE0kzl55hbyMad+FvqeBkBoGw=;
        b=I+KVlSD1rMKMF5jUR9Ifd8MfjWeLVw/z43AnwqAa650klU2+jWPxTiszj7kJPKOh5x
         6M4LCBl0EKuhkG9mgvHOuCJb1NDQdz5AqJL0ry+0FLHqh/bVctNQ56KvEuNEH3dhmtUg
         YecaJzoh4gCoZ+ix92ZjELezuAnSs07Ozju6mg5rBd6Xr8uVedzFcHD6pOPn0uoLmwUZ
         mOjHtMQjJps1M1a/LZhVqA/so5rbyCKaMsBn7Gvoi79V7v74rE5jzYwhcw2uQMt6M250
         pVGpc2lTHWi/Bg7NZpCVZTzWVmro1poku0SjCGxvbl/wXq5fEDg5MUcUn2x5LZovmnGv
         c24g==
X-Gm-Message-State: AO0yUKWVxrMDynLDRg58IDcA6zDqJ4GRT7kJwBQLGJ2kOqrhtYqRYiPV
        jeift9BUW268QCnMJmPpt667WX1AQgA=
X-Google-Smtp-Source: AK7set8euEc4jQ4QskJkpyVCz6Sq+AKquYtw8zbnHNhxIuYJjZwNnjbNN9Upkkzvw6HvFGDPUvtUFw==
X-Received: by 2002:a17:903:40c4:b0:19d:74c:78e5 with SMTP id t4-20020a17090340c400b0019d074c78e5mr15311201pld.50.1678227868012;
        Tue, 07 Mar 2023 14:24:28 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902729200b0019c901b35ecsm8814392pll.106.2023.03.07.14.24.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:24:27 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC v2 04/12] device-api: Add Set property
Date:   Tue,  7 Mar 2023 14:24:14 -0800
Message-Id: <20230307222422.2608483-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307222422.2608483-1-luiz.dentz@gmail.com>
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Set property so clients are able to identify when a device
belongs to a set.
---
 doc/device-api.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 628accb8a572..e4a8d3c5af33 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -281,3 +281,13 @@ Properties	string Address [readonly]
 			Example:
 				<Transport Discovery> <Organization Flags...>
 				0x26                   0x01         0x01...
+
+		array{object, dict} Sets [readonly, experimental]
+
+			The object paths of the sets the device belongs to
+			followed by a dictionary which can contain the
+			following:
+
+				byte Rank:
+
+					Rank of the device in the Set.
-- 
2.39.2

