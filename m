Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ECAC43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Nov 2022 00:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiKOAax (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Nov 2022 19:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiKOAaw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Nov 2022 19:30:52 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2612A1758B
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 16:30:51 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id io19so11650889plb.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 16:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiyFT+n+qVI/WESmarfkamwzmvVYckxgQ1AedNoQGr8=;
        b=GGtmP5Umreh6wnFVD1F9g7836/E2eBRk9rCv5stHJtA5kHx/0NBBOAUhM1BxVsIZ/j
         3vPz9pgWJhQKd4cFCszNk0/thkLRe0T6PEAYZZ3zS1Hh7kT0JfXP1A2awfBN3hKwiNal
         seEKd6Tu2jV5ymGsv47BygifnAWDKQ+9od3zVxkDGYTNW+FkC9oHmCBJs7Blgz7JpydC
         3QVoCjRMRfc2KCubrS+9t9cEtyQqNdnvOltXPDj/6I+fue9A57s/fwr4/hmBZJ8W/xZ2
         1kbV+S2EQl+EQ4hoEs6uhfF+Pp82loel4X/M1EHE0McOobGiaK+Fa66VBL6syi5XsdMv
         ld2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiyFT+n+qVI/WESmarfkamwzmvVYckxgQ1AedNoQGr8=;
        b=irPBlRtOXPP/pxKAJvkkyTknKjocJKsNdrxdtfwmFVfyk3NCHf2y/3k4hWJCVbS2T1
         sx55USN4/ftmfw3TYOUvUWzvLKxq3FeJ1u5eztS07sjVEwXAYhRBTKehtMPWDJ+Uq5hr
         L/UIyCdLwjP1mZ9Ee8sMdTiUoNNOMrnaUzH4JZBKYKrVRaA2gC9kGX7WqWtr8pXoZhB6
         kMnuP/z7IOAADdIV4Wpnb/wLDDzdPCgjaoQdywD4P57gD/mZa1QIALuLV/lE3UQfI4qj
         94hrb2D2D6fplbfALzEkAdCAcQWndmsryLvv7NO8AMAFVDYazUUXi/yfRLWmjYB8fj+o
         ltlw==
X-Gm-Message-State: ANoB5pm9bs1JxF5M8Lg1DewKECs0UYUBizQwIumDmXbEh/76iM2Ekgtm
        rOUo78O0S82pxhZP4i8GpxHdLS8eAcw=
X-Google-Smtp-Source: AA0mqf6/m9t+JfbY1tLJf5QDOhE/eAXL8ZyFKCHuHtBockXXI9y+uQ+ddKG8CXRizrnifgFgdZtvbQ==
X-Received: by 2002:a17:90b:d95:b0:20d:23ee:c041 with SMTP id bg21-20020a17090b0d9500b0020d23eec041mr15662592pjb.140.1668472250150;
        Mon, 14 Nov 2022 16:30:50 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h3-20020a17090a3d0300b0020a28156e11sm10307888pjc.26.2022.11.14.16.30.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 16:30:49 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] shared/bap: Fix crash when canceling requests
Date:   Mon, 14 Nov 2022 16:30:37 -0800
Message-Id: <20221115003038.2134340-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221115003038.2134340-1-luiz.dentz@gmail.com>
References: <20221115003038.2134340-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If bt_bap_unref/bap_free is called while there is an ongoing pending
request it may endup calling into bap_notify_ready which will try to
notify ready callbacks while holding a reference, but in case the
reference is already 0 that means it would switch to 1 and back 0
causing a double free.

To prevent that bap_notify_ready now checks that the reference is not 0
with use of bt_bap_ref_safe.
---
 src/shared/bap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 25369e619051..21aa8aa6c5ca 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2638,6 +2638,14 @@ struct bt_bap *bt_bap_ref(struct bt_bap *bap)
 	return bap;
 }
 
+static struct bt_bap *bt_bap_ref_safe(struct bt_bap *bap)
+{
+	if (!bap || !bap->ref_count)
+		return NULL;
+
+	return bt_bap_ref(bap);
+}
+
 void bt_bap_unref(struct bt_bap *bap)
 {
 	if (!bap)
@@ -2656,7 +2664,8 @@ static void bap_notify_ready(struct bt_bap *bap)
 	if (!queue_isempty(bap->pending))
 		return;
 
-	bt_bap_ref(bap);
+	if (!bt_bap_ref_safe(bap))
+		return;
 
 	for (entry = queue_get_entries(bap->ready_cbs); entry;
 							entry = entry->next) {
-- 
2.37.3

