Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF45EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 00:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48D723A53
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 00:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbhAVAOc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jan 2021 19:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAVAOV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jan 2021 19:14:21 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37A3C0613D6
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jan 2021 16:13:40 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g3so2258746plp.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jan 2021 16:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3nnF+bkgtjz25uaf0FNhzS1otuiCUw75IC3zjjwwTtA=;
        b=bpWQKD+UXxBwSgv3lf2TKYmhZF9IHnWZI4BVzjS7M6V0umMcNcee0I+XPoKQnRS0KD
         D+UH1gOMCV7XPEbeSr3FfYP+qYhLiwP4zKSXiFxPqWzzxmYBzNUo4XDoI1Vp/BcwJbwr
         zG7lbjQclOEreobob8o0ntIYlsjVPX7Strd+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3nnF+bkgtjz25uaf0FNhzS1otuiCUw75IC3zjjwwTtA=;
        b=DFVsIX2Us50pRGSBEBBnq+ADxMyLacjsKPtUlghDiSwQzJ1fBX+xrLUqrJpk/RM3LA
         0xnZydbXJ2Inwe8VCvxugdmHGRiECOT/Iwit9PQyu8VANsPucJjyApnhJHpz01MXvjKf
         At3WcuKvElxkLr0N5hjIHB9fRvQFD8CmHlT6Abr9HIQpru2lHtw44IZsNYCfMCcn1GPO
         yy076HRu7+c0lKx0n5mUgEGrtHwrVMuatDUiMVjnYdO2kIE9BAbucblZu1S7BulPLRfs
         Bn1v0H13pAWAubC9RuKMTBiMuB1XRdGvkSNkdIibovsJ2T/C9JQhsJcG9e9Kc+Ur9cJY
         nIzw==
X-Gm-Message-State: AOAM532ZBAelyNp/EJvajNe+ABtcJQdYyTWsIvjOlIEwDP3DkHnry+I6
        HXh4BZxwSwPh6aMQiL46bu3eYS/xz0VBzw==
X-Google-Smtp-Source: ABdhPJwOLecPTgoWzp4+RsorSQVE8vUorN3Be1pHAJBN9cXSpy9YSU7Eq7eii9tThnH+kb7BqNDxvg==
X-Received: by 2002:a17:90a:4314:: with SMTP id q20mr2209139pjg.87.1611274420230;
        Thu, 21 Jan 2021 16:13:40 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id b13sm6941900pfi.162.2021.01.21.16.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 16:13:39 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ v2 1/2] input/hog: Fix double registering report value callbacks
Date:   Thu, 21 Jan 2021 16:13:25 -0800
Message-Id: <20210122001326.14263-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In commit 23b69ab3e484 ("input/hog: Cache the HID report map"), we
optimized HOG reconnection by registering report value callbacks early,
but there was a bug where we also re-register the same report value
callbacks after at CCC write callback. We should handle this case by
avoiding the second callback register if we know we have done it
earlier.

---
 profiles/input/hog-lib.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 1f132aa4c..089f42826 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -80,6 +80,7 @@ struct bt_hog {
 	struct bt_uhid		*uhid;
 	int			uhid_fd;
 	bool			uhid_created;
+	bool			report_value_cb_registered;
 	gboolean		has_report_id;
 	uint16_t		bcdhid;
 	uint8_t			bcountrycode;
@@ -336,6 +337,13 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 		return;
 	}
 
+	/* If we already had the report map cache, we must have registered UHID
+	 * and the report value callbacks. In that case, don't re-register the
+	 * report value callbacks here.
+	 */
+	if (hog->report_value_cb_registered)
+		return;
+
 	report->notifyid = g_attrib_register(hog->attrib,
 					ATT_OP_HANDLE_NOTIFY,
 					report->value_handle,
@@ -1703,6 +1711,8 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 					report_value_cb, r, NULL);
 	}
 
+	hog->report_value_cb_registered = true;
+
 	return true;
 }
 
@@ -1753,6 +1763,8 @@ void bt_hog_detach(struct bt_hog *hog)
 		}
 	}
 
+	hog->report_value_cb_registered = false;
+
 	if (hog->scpp)
 		bt_scpp_detach(hog->scpp);
 
-- 
2.29.2

