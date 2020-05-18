Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52241C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 20:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2494520829
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 20:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tt8o8htN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgERU4l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 16:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERU4l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 16:56:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8F0C05BD09
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 13:56:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y198so3936767pfb.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 13:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zy3uJZB5XsJzztjORyRIanJypmSXB+lz2legdKKnj/A=;
        b=tt8o8htNfbhVVdJsV8BI0nj1NdnSxDmZQ4GzGOhCMkY/ogxMb6rNaV5vnmch+wzo+O
         Y3CqtQRs16lXxMJ0oBQp0zsrJvNLOq/z/R2Rc5A8Q2cR4R7JEsVXJUGGrdx2BtBqdJT4
         d5QpW02iPdoTecPLLpwT/dEuWSZPQxZTe24AfoEvfZcZe3Z33XyDznqPkeIyaeu/tABo
         kRPSMXoB7tWGEa7RmV5b2J5NlFrozg4+S9kQLdbFslLdc1jB/iT0GTpWj9FMgf8Bz7eW
         ZLZ/MLfuQTIzIktyYrNsUVp0PH2O3luXBi9CwC06//XRXX7rNHQgBWDb5+yn4rymXXHG
         b2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zy3uJZB5XsJzztjORyRIanJypmSXB+lz2legdKKnj/A=;
        b=kyczgtXpdC33/XI/F0s3clgTy71FoSE67NpiqrwHfQi9uAXoH3YFNPExB/WiU11D8P
         uK729YyOZx2bl8i9vX9z/NXHXbqV5hjTMoTYHJTDahv/3fHF5SOtjYwJgoQ4SYANb1yw
         gCp3Dmq6xh7mmIZJQBacK4cjsOk9IAmcPNKT+lSzQJNp21ge2TO3m/4DcWc7raYfeAV6
         uOvJtgydeV0azzfZRk/4bPcrVuURgU+L4mV99f2cFTAPD1Uh9VGlqNODsKcZJtAyOa1H
         G/2jYYn6n/dgZSzce85VGbssWrTnBP7vdUUOcW3gXRzsx6tWX0n0TB9sD2mJl3JRWKAI
         Rv8Q==
X-Gm-Message-State: AOAM532pHK+7jh3aR5DBWx3l6J1eJfIO81QKOnOH4QAGGyUocUrfqYOn
        N6Y7JyMnq5uLsvHofhWV5IkM7dv6
X-Google-Smtp-Source: ABdhPJzZcQiuuPNiqOQJCORzN1Pgs1B48mZcGJjQH2sX14fDrN0eLM3Kd9oB7iFZ6sFU+EdOZPNdgg==
X-Received: by 2002:aa7:9f8c:: with SMTP id z12mr15317624pfr.304.1589835399185;
        Mon, 18 May 2020 13:56:39 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q18sm8519808pgn.34.2020.05.18.13.56.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 13:56:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] doc/media-api: Add documentation for DelayReporting
Date:   Mon, 18 May 2020 13:56:34 -0700
Message-Id: <20200518205636.139184-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200518205636.139184-1-luiz.dentz@gmail.com>
References: <20200518205636.139184-1-luiz.dentz@gmail.com>
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

