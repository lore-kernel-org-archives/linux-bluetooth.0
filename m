Return-Path: <SRS0=dZ4y=CC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111B7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 18:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD7E2074D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 18:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="BrAKc9wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgHXSob (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHXSoa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Aug 2020 14:44:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6CDC061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2020 11:44:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l13so11628175ybf.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2020 11:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=AI14pQdq0aOMmQdlYGuL+wyNmjvIoSpo1r6eDtgq0BY=;
        b=BrAKc9wgQPIsqtq9ABfffhz3A+WZVNCl822n3zT7onw9ng6GvqGqQtsQg1J7RAXUHr
         8CL6ulmrGuBinD7KJMLkEZdd7STjWEqGZlXaicQVlxYIJ+wBgKsDSujTpAjgnQBbeS1A
         Je3jroYIkdKczCa6H+71gbOe4pxGh5WXw+v0eVxU8MctTBCjVnl6lInt6SHKWsjHwMT7
         AZFDHahRZihqcr4Pbbvb3MqvM7Chn8jQdAzZQXfiNuUHCk0Z1FST5vQuB3HZeRPFcwwM
         BrKGhaqCPjC+ntGwkez6Xqqd8kndBhBobq7yI8090GJK0AebDB4loZJUxPH823FII7ea
         qBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=AI14pQdq0aOMmQdlYGuL+wyNmjvIoSpo1r6eDtgq0BY=;
        b=tbhWbmw5Q2sxEdLP/F/1kvizjH6BqvGUnFO+o79+s0F1oGddh8xVp9CXYxpEyWKxjC
         tZ56NUc/JWpewVqZnCIlQ4zpTjZNtzOgRsMX7xu1I7pzknQ//ocgVadY8iIlpJxoAZ2e
         z//XC7Th34bZArF/IeqJHIY88zGxk9gwpgUde9DF3/o2mm051Nu9Kmz6ZOZO7uWP2VZE
         dBKiBrdJSh9hFS+Dv+cTbOmPryc2YrufbDGI8/h/A3Vb+1LDitx5AElLfdIFCk/HhSbe
         FjWtzerw23rRUvWu28DlHy/8bQ5Xi4DnjyHkgo88t4xtXOhrpAGHAgVvpTxlz10DpnPK
         cdXg==
X-Gm-Message-State: AOAM532V1jkmvFdkdKBW2tQOLkpbJVpop1xlp79GqiqDuItiu10KbbZO
        XWMgg+Ot9vHi/z7zKX+T5WU14wPv0Dn1ZGSYTmRE2uzkQInvLehnltEtNGVr9nmOn+kOQTiDebl
        pyPuEC4dQE8/V4gEk7HTmjLf/3KnL7sI/1XtyjwW/gSUhJqcuXK2FSVIl8g//jwoMdFP8sqdtT2
        Il
X-Google-Smtp-Source: ABdhPJy7KphBM67MMKRo7GK7QhJ2irSNrnrlKewxS6tgzActn9+nf2BgfvMRF4T3gZKIG59yBWbaImiDzW0g
X-Received: from yudiliu.mtv.corp.google.com ([2620:15c:202:201:8edc:d4ff:fe53:2823])
 (user=yudiliu job=sendgmr) by 2002:a25:bc52:: with SMTP id
 d18mr9531309ybk.144.1598294669778; Mon, 24 Aug 2020 11:44:29 -0700 (PDT)
Date:   Mon, 24 Aug 2020 11:44:26 -0700
Message-Id: <20200824114408.Bluez.v3.1.I21d21871d85db48b07ba847742c7cb933024307c@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [Bluez PATCH v3] adapter - Device needs to be in the temporary state
 after pairing failed
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Yu Liu <yudiliu@google.com>, sonnysasaka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This caused the device hanging around as a discovered device forever
even if it is turned off or not in present.

Reviewed-by: sonnysasaka@chromium.org

---

Changes in v3:
- Fix comment format
- Don't set temporary for trusted device

Changes in v2:
- Fix title length and format issue

Changes in v1:
- Initial change

 src/device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/device.c b/src/device.c
index bb8e07e8f..103b5df27 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6008,6 +6008,14 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 
 	if (status) {
 		device_cancel_authentication(device, TRUE);
+
+		/* Put the device back to the temporary state so that it will be
+		 * treated as a newly discovered device.
+		 */
+		if (!device_is_paired(device, bdaddr_type) &&
+				!device_is_trusted(device))
+			btd_device_set_temporary(device, true);
+
 		device_bonding_failed(device, status);
 		return;
 	}
-- 
2.28.0.297.g1956fa8f8d-goog

