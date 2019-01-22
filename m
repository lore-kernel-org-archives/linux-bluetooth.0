Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4200FC282C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 13:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110A420879
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 13:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ5fKPhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfAVNpi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:45:38 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:46124 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfAVNpi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 08:45:38 -0500
Received: by mail-ed1-f46.google.com with SMTP id o10so19293056edt.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jan 2019 05:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=NRmMcQTyCPGDFPiIwwvQcbTId6WBr1vJLCM1OYszSog=;
        b=jJ5fKPhhY5J10SKv4kiMmDFGx0DhYM/RLG1KRdBsuT5NmFLM+LzZvowMx50wQEAYB/
         jJU9HCbSFYedN5/O0/b+DRlfhNhLUxnFdm8D2i+kMl0GDewr0CqKDZT0g0quxmNYzHdJ
         aWzC7fvWhFODBMHGVDX8BtiVPuuGci7XFhmn2uPASvU/gqsL8hSQAN+wIh9GyJIwVY7D
         XUP3mC1+RV7L7VVCWcrlzCbmeYWH3seFXXj0QHUJ0RknRtmMIuCnIgtrnb+VQZYXq7G3
         NY76Adr28Iyc0JFbJXDIKedsMgRGDFAb0V9C8+FivpgoWtPCdfNIL4jL0IoHy7trPdzx
         4VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=NRmMcQTyCPGDFPiIwwvQcbTId6WBr1vJLCM1OYszSog=;
        b=nN17iEjK0FByKy8C6PG7XDVCf+Ka5rR462bWSx51gnHFCvWEsrEyIt0bX1ZMGFSsjx
         vJFxAsilKTDgqJ0mtqDt9cifj192oFnBGmgQAwQUtnYqmGf5hw12bwLH/0ezeRxclLac
         lQcicu4i91TQMUtVTI9UcvwtgEC5xCXkVebE+ojHs2yqK3wd5UxLFHjQfmNiNJtnt0GW
         odPFx2y+qHey0+R8dFv1lsIV5A0ftXhy7uqKA7WSJrdUb0toAUTOUpCa1/RuaywERKD/
         UJsWpc4XsRbDJrYhFTNvk5PvjzKIj0rtUvfdMdtugYJItRTnEntpe9Cfsifo6jzSpSM7
         voyA==
X-Gm-Message-State: AJcUukey0hNs88XwZJurysF8kUrhfQPPWdbHAeAmq6284//rxXZjMglx
        wlVw/WBmCVFqW5poxXSTVgFdj4Ld
X-Google-Smtp-Source: ALg8bN71+4wdEoOTc9nDD1UrpBD7//pyEJFyPMh/yxEuwoOtpWcmA7pNo+NM6RENWCC+NHb/YHFKSw==
X-Received: by 2002:a17:906:5e46:: with SMTP id b6-v6mr22308422eju.44.1548164736268;
        Tue, 22 Jan 2019 05:45:36 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id dc5-v6sm5319153ejb.53.2019.01.22.05.45.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 05:45:35 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 7/9] doc/media-api: Add Device property to MediaEndpoint
Date:   Tue, 22 Jan 2019 15:45:22 +0200
Message-Id: <20190122134524.20509-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190122134524.20509-1-luiz.dentz@gmail.com>
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Device property which indicates which device the endpoint
belongs to.
---
 doc/media-api.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 292e9034c..bca8c9563 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -556,6 +556,10 @@ Properties	string UUID [readonly, optional]:
 			Capabilities blob, it is used as it is so the size and
 			byte order must match.
 
+		object Device [readonly, optional]:
+
+			Device object which the endpoint is belongs to.
+
 MediaTransport1 hierarchy
 =========================
 
-- 
2.17.2

