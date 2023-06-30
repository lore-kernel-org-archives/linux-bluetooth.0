Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734C0EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 21:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjF3Vk6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 17:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjF3Vkv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 17:40:51 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334DF3A87
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 14:40:50 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1b078b34df5so2187091fac.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 14:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688161249; x=1690753249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Cg9zB1fXkpk+7GpB/Svxkl6enKDK8Dwoq2y9kTCjIA=;
        b=oFavwefyLR9wVs3hmLyB5TX6tYYx6yw96aWF5BCuMXqpto5h1lLwIe1nty1LMcFyYW
         2R0z9JLTeXyR6sb0i3kCQ77dHdcvLctI14pOhwvH5vKxwf0yEeay55z5MfhdIMf36/8I
         B1mhF+5WUXgVZebJTYgGdGTWGS8+sxqtHgCOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688161249; x=1690753249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Cg9zB1fXkpk+7GpB/Svxkl6enKDK8Dwoq2y9kTCjIA=;
        b=THrwiz8wHMhEG6X8w3lcg+DnYJHTuFbvtjarcqdPzULywIIhdUcljXqyFEEN10w4s0
         VZ8HcuVFHDyfdKAHC4HgWc8iEAO0amgAlVNcnfbY0iX3vMzuOFq+yPVNhtLrDriPqNuw
         YW1f42hMEPGO5Q4jmh3TJmQgimfQpnNbYL2DAKDj9vmyN2bWgBxZR12dsOftANGXNFkF
         P05a8coqEPud4Q1hntLz33z8+hLbj3WrdUHHSdM8WMm1TgfYR4p3JQ20zR4pxh3HXSUU
         WBLbfS+RAMgFbMWeW1QshfZWk/kU7ZV05ZJvsQKkM5P7hAjcxhDx/UxpDmJ2ryKBvOll
         ro0A==
X-Gm-Message-State: ABy/qLZlGx4djZBBaHMRimwKWEnplSgoRfBzxGhoklkFr0/D9cr8sNZE
        b60zkwHT/NPeAVkKRnf5WzPBOxAhnnevBFrixyTYvw==
X-Google-Smtp-Source: APBJJlF3SvyUtB2tw/r4m4aYJeI4euVTVv7JJZjPCQf/HM3JvAr3m5HYb5mc4twRuvR20OvL67x7aw==
X-Received: by 2002:a05:6871:822:b0:1a3:1cb3:37e9 with SMTP id q34-20020a056871082200b001a31cb337e9mr5354026oap.4.1688161249516;
        Fri, 30 Jun 2023 14:40:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e9c4:8375:7234:e6c2])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090ad58800b00256a4d59bfasm12916841pju.23.2023.06.30.14.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 14:40:48 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@google.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()
Date:   Fri, 30 Jun 2023 14:31:27 -0700
Message-ID: <20230630143125.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

KASAN reports that there's a use-after-free in
hci_remove_adv_monitor(). Trawling through the disassembly, you can
see that the complaint is from the access in bt_dev_dbg() under the
HCI_ADV_MONITOR_EXT_MSFT case. The problem case happens because
msft_remove_monitor() can end up freeing the monitor
structure. Specifically:
  hci_remove_adv_monitor() ->
  msft_remove_monitor() ->
  msft_remove_monitor_sync() ->
  msft_le_cancel_monitor_advertisement_cb() ->
  hci_free_adv_monitor()

Let's fix the problem by just stashing the relevant data when it's
still valid.

Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 net/bluetooth/hci_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 48917c68358d..dbb2043a9112 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1972,6 +1972,7 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 				  struct adv_monitor *monitor)
 {
 	int status = 0;
+	int handle;
 
 	switch (hci_get_adv_monitor_offload_ext(hdev)) {
 	case HCI_ADV_MONITOR_EXT_NONE: /* also goes here when powered off */
@@ -1980,9 +1981,10 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 		goto free_monitor;
 
 	case HCI_ADV_MONITOR_EXT_MSFT:
+		handle = monitor->handle;
 		status = msft_remove_monitor(hdev, monitor);
 		bt_dev_dbg(hdev, "%s remove monitor %d msft status %d",
-			   hdev->name, monitor->handle, status);
+			   hdev->name, handle, status);
 		break;
 	}
 
-- 
2.41.0.255.g8b1d071c50-goog

