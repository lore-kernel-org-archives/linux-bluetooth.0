Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2924CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 09:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1637861101
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 09:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhKCJF6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Nov 2021 05:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbhKCJFy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Nov 2021 05:05:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC2DC061228
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Nov 2021 02:03:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g36-20020a25ae64000000b005c1f46f7ee6so3145586ybe.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Nov 2021 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qO4nWP74PgUYZ6ku/F35jiPU7Ia3HjCxnhp1F2jmYls=;
        b=JfNgJBf8+g6NhFNfAtdkHw9ACZfdgVKx8b+QcKTyxKchfDwFEqsEAefTMwF0b2Cpzq
         ybRDT9RH0fllh52jPENHmjjq4aArWzHfkON5xYA/pRrbJwDA4MoZxnVTOmUEhKrDMIOZ
         52/pIUs6C2bOdDdJayTK//RtL79vKHz2BzMaq4FoUP9s1tC3N92FNzE1bBb2KoJjLjpk
         30wkO2DPxgI7CBB563C69nLRhSleIAnVqO6GjRo+HEsHpsEbcf7XLKhSctHUcJV6Bm8o
         GHC7O8GS45L3M9KIjNpO5uVzeNBzGaqGdWTWi1xOuhMM8Fpd5NYea7YPheDmT5htrAAT
         n/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qO4nWP74PgUYZ6ku/F35jiPU7Ia3HjCxnhp1F2jmYls=;
        b=PwXWJBVasB8r7un9JXnU42X5DORieVbGAWRZZEU6DHX2pwm+L8Gs1UZTmyImyIUCDi
         OHdchfW1spklqQWq/MXtxGwmrkbOU0J0hU3hWEx/O9sT85SYe2Tid6SbI8BUzvvsDCeK
         l8/TawLYPXf/kF3vmANyX0+mt9kfpn4KRKjDF4e/4Sz40xlzGjCQBpiBZ0qKVu0jU2C1
         e2WUwPg6GykUu8jdGTQ7McfGqqvq6Y3fTSZuG2Vlpm7GA2NAYbE+gNnKuBecaMTQgvX2
         fQ0k12kU9tKsKYkEHWWxLD8avPBI7TR7KVFHcMT/l9RD1jwPTtYMXA6UmQt510q/tiQq
         HsQw==
X-Gm-Message-State: AOAM531IYW5lkWVvFRql+limUr8z02qCex47DMJ0vh0+YimQrR5BDS/X
        uicfStSq9GRXxPDkdrytV/hOzvltraQZwj4gU3xHcfdxAJRuqUg/TY+cvwjAQd32LWY7yrcficy
        C0ccnC9DNcUoDz0BUvpbxd20QaNxFBt8J+xADz7E7i4GFkMJUjzdBDuho5Drh3Z1flEHCGpwmRL
        5i
X-Google-Smtp-Source: ABdhPJwkfNjYZCpWboNtttkY2mOVvL3/1702/9cHQqtEPGKK8i+DLsrRWuD2BYrs4OqHs1uvN9ViimA5s4X8
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:7af7:a937:5810:b542])
 (user=apusaka job=sendgmr) by 2002:a05:6902:100b:: with SMTP id
 w11mr18971055ybt.64.1635930194158; Wed, 03 Nov 2021 02:03:14 -0700 (PDT)
Date:   Wed,  3 Nov 2021 17:02:55 +0800
In-Reply-To: <20211103170206.Bluez.v2.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
Message-Id: <20211103170206.Bluez.v2.3.Idb95ae18113225915b97a4f06983e1e41a7f7a2e@changeid>
Mime-Version: 1.0
References: <20211103170206.Bluez.v2.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [Bluez PATCH v2 3/3] adapter: Remove "Master" entry from LTK storage
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

The entry has been deprecated since 2014 and it's time to remove them
altogether.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
---


(no changes since v1)

 src/adapter.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 114ae84c10..508917e58d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3779,8 +3779,6 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
 					uint8_t peer_type, const char *group)
 {
 	struct smp_ltk_info *ltk = NULL;
-	GError *gerr = NULL;
-	bool central;
 	char *key;
 	char *rand = NULL;
 
@@ -3836,12 +3834,6 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
 									NULL);
 	ltk->ediv = g_key_file_get_integer(key_file, group, "EDiv", NULL);
 
-	central = g_key_file_get_boolean(key_file, group, "Master", &gerr);
-	if (gerr)
-		g_error_free(gerr);
-	else
-		ltk->central = central;
-
 	ltk->is_blocked = is_blocked_key(HCI_BLOCKED_KEY_TYPE_LTK,
 								ltk->val);
 
@@ -5907,7 +5899,6 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
 	g_free(str);
 
 	g_key_file_set_integer(key_file, "LongTermKey", "Authenticated", auth);
-	g_key_file_set_integer(key_file, "LongTermKey", "Master", central);
 	g_key_file_set_integer(key_file, "LongTermKey", "EncSize", enc_size);
 	g_key_file_set_integer(key_file, "LongTermKey", "EDiv", ediv);
 
@@ -8448,9 +8439,6 @@ static void store_ltk_group(struct btd_adapter *adapter, const bdaddr_t *peer,
 		g_error_free(gerr);
 	}
 
-	/* Old files may contain this so remove it in case it exists */
-	g_key_file_remove_key(key_file, "LongTermKey", "Master", NULL);
-
 	for (i = 0; i < 16; i++)
 		sprintf(key_str + (i * 2), "%2.2X", key[i]);
 
-- 
2.33.1.1089.g2158813163f-goog

