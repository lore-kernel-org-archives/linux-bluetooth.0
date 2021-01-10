Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9578C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Jan 2021 00:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A671723998
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Jan 2021 00:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbhAJAbW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Jan 2021 19:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbhAJAbW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Jan 2021 19:31:22 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D589C061786
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Jan 2021 16:30:42 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id w2so830593pfc.13
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Jan 2021 16:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3nnF+bkgtjz25uaf0FNhzS1otuiCUw75IC3zjjwwTtA=;
        b=cPXcKf23RsXBEUQrHLhhCW2j9KvHV/yxsxc/89zLsF0opyf9cu6nEPZ4ZjcqJPwuF8
         fqE7SRTSXwjJ24WYAZXjNn5eEA3C81PQZ8i68BkMrKIjIJiGlOBP4UntEjpoMLR4Avte
         WCksCfUcriSCEykqLnvfEMPpOa25V3oAVMYrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3nnF+bkgtjz25uaf0FNhzS1otuiCUw75IC3zjjwwTtA=;
        b=hC9Wz4pjiP1KwFRBPE+jJDGPxVWgStJkVANhzyUtvaMtuxR9ikGtKwpWtuJRgf7Q4R
         8lFQEVy0v2nqyxdR7Hsk+ui5vAXOme1HZFBd6vroiSSYRHCFtdiYDJ0jhGCZFEDZO0Al
         VMFNVLOFgbarqJ31jW8x4/nOFnOM+u6SdiDl+FAilOW8i8bb33yQkFbvDAmO9PDEahN3
         RijX5kHjTvxG+5sec4jCQ5ErMYMtijbCKn6sceXRJ0Asv8h9NAO8SlFWw4PQqoF3sjfb
         9F9IxVMh5Rr95H/cdxCaHVFvrAp/3qXTXPw9hiKwZkYfrfJBHHBak68c2gXg1/wLl27H
         8qrg==
X-Gm-Message-State: AOAM530q/7Kkw0oGdv8Qx87oOfBZ39SCmnWdq0xEeN6ynKjvOcztq6oB
        1f3AH6mNyI9Gg3URbxJB2M0vV/MhUtW3Sg==
X-Google-Smtp-Source: ABdhPJyQMbl6nkFlnjeZBeHfyR+QTfniwFfy7Zoj5R+BS9vJEXCfCTm6RZqmWRcPkUoRyIeJ3IWzwA==
X-Received: by 2002:a63:2902:: with SMTP id p2mr13572692pgp.274.1610238641390;
        Sat, 09 Jan 2021 16:30:41 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id a19sm13041299pfi.130.2021.01.09.16.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jan 2021 16:30:40 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ] input/hog: Fix double registering report value callbacks
Date:   Sat,  9 Jan 2021 16:30:33 -0800
Message-Id: <20210110003033.2528-1-sonnysasaka@chromium.org>
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

