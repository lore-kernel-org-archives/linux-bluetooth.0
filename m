Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA517C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 909C720849
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5kmOdBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgESUDu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 May 2020 16:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbgESUDu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 May 2020 16:03:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDDBC08C5C0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:03:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q9so156481pjm.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zy3uJZB5XsJzztjORyRIanJypmSXB+lz2legdKKnj/A=;
        b=T5kmOdBvKJdlquQDk4QJiXFzQ66l4U4TUzHo7hgylFqLobn+RomJ7Ejj9Rgh2H+JZD
         ViE99NBvPRWtBeWd8qQUeiiDBXREBIS90yXGNtWgG9/u4/d91eQ9wDp9LDWcoN97GZI5
         PpPzwi2NCSKS4PYaKNK4BbZWmYXriotgDDNRd/NXTHO8TZlDVdGfcsB4vyP1d0Clo60U
         p2jE6MITKkUJFu98wD/SoRY+A1d5zabBbS6ZOgih45DPBEiGWkUHHig2w1yqrzcDSZ08
         iruqvE+QouD56HMJwNkKn+Cgz+9XThEIN/csuxwrZJyhmWBOfWSd1KP8eY5buRE0n9Lh
         Pz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zy3uJZB5XsJzztjORyRIanJypmSXB+lz2legdKKnj/A=;
        b=ZWGke3V1fEV1L6ligczi+pBTcbeXs4+Dnv7qS0RBY6KWtfn009lzIXprE0s6PmRYmC
         TjTmwS8IFyO1/nTelaH1vrm9Ss4Zit/wUjLRgcKXCGpdFQYQwsjk+JGIe7JMIgTSwyZp
         Xi2Z13mywwS3I3cT607sYHKGsN+RkCXLsPpl5XMyj/0igZbaiCOwkakxHm6/9oyydQDa
         n8q8rng/eCaxXWFWKbtpb1W8UEp/ZJCB9gNI0AWk58nSTEXq8TL9hB2ifQpY3nYdFWEU
         frLBI/P1b5nbEcylbrhDGKQ9pkLQhZiAWpJ7KElrRiezQj8KqHROh4nYdQDYq5ZEG1ea
         tDpA==
X-Gm-Message-State: AOAM533lb79uUgaxW1AtWX9ZbSha110i5aLZNzSUjdQCHeNy/nEFZESu
        nyQOnrkTbVqRcCwPRVRjI1gRcBHx
X-Google-Smtp-Source: ABdhPJwO25ZX/K2n8e8lWPQBCWYphQHoLF3MvgXpa3moZni4YCFy+TpFLtRfcy4+nVO+NbHq4WkveQ==
X-Received: by 2002:a17:90b:30c5:: with SMTP id hi5mr1255532pjb.110.1589918629145;
        Tue, 19 May 2020 13:03:49 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i98sm302003pje.37.2020.05.19.13.03.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 13:03:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/4] doc/media-api: Add documentation for DelayReporting
Date:   Tue, 19 May 2020 13:03:43 -0700
Message-Id: <20200519200345.217345-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200519200345.217345-1-luiz.dentz@gmail.com>
References: <20200519200345.217345-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The code was expecting the endpoint to expose
MediaEndpoint.DelayReporting property in order to expose
MediaTransport.Delay property.
---
 doc/media-api.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 07f7ac3e0..dabc69936 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -580,6 +580,10 @@ Properties	string UUID [readonly, optional]:
 
 			Device object which the endpoint is belongs to.
 
+		bool DelayReporting [readonly, optional]:
+
+			Indicates if endpoint supports Delay Reporting.
+
 MediaTransport1 hierarchy
 =========================
 
-- 
2.25.3

