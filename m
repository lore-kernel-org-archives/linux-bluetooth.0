Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A9AEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 22:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjF3Wds (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 18:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjF3Wdq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 18:33:46 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980773C01
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:33:45 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1b03ec2015fso2107256fac.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688164425; x=1690756425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nq1QcjMnGfIZ/W8d+xE8ssqtAAponfz0QGs18ghKecs=;
        b=ePmdCCgl438/fHKG9lmQLCDSCX0oTeNziNiyk4EgYgOQHYihUa9mQvSiGhIgLkH12I
         eBRWE1x2Ip5ar6Y6JvgY4D1KTJZQd+yBAdpbYu/Rhf7isIn2Jw5qwjf3VTExUuBWbwhC
         P08HSNG4mlMeeAQE9D9MRInFCXzBXHyGCT+SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688164425; x=1690756425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nq1QcjMnGfIZ/W8d+xE8ssqtAAponfz0QGs18ghKecs=;
        b=O+pSDbTH4YHnIW7ZPkFRjKlx1x6nAoTSbp0PgNoIcx/JpcoQvjQdspZUqLsBccWg91
         JzmFdl47O/1NImJ19E7nivdJdt1eGhvh8Rf3AbLE3WS2IlL5LR/R6QiZTw+/9+jaE4OT
         MN3dlWvE7UBdgBAYPiHZ3XOiVmc+Mc2rVEHc8FDStDtOftgVTlekWRxxLOVeuAd4oQrW
         0HL85izmW+HTWT+oVRtjSnpe8pg3X6IAoVk3QSFEPB9iYwzMkFEhi1ECexJ7PvULf7jS
         7aZdh0BRP5DEbpxC+ehFD5B9lRkCGHNy2GvV+QZ4KBi4yBbhVSeGWiwpXqfVNwpHBWgp
         hv/Q==
X-Gm-Message-State: ABy/qLbjQJsqVOaLgANrLypf67cx5B1HsyqscN7WVJlvvfWpkXGs++IB
        DsaFGDDirC82Pzqx0AnYiFuv5Q==
X-Google-Smtp-Source: APBJJlESTNjx5bHPxXJIAoycu0gyCWstYxfyBqmj5Yr6Xm5BspBzp5icngkNcTaSbfg30RdoDvRg0g==
X-Received: by 2002:a05:6870:e92:b0:1a2:8ebd:7d46 with SMTP id mm18-20020a0568700e9200b001a28ebd7d46mr5013095oab.21.1688164424896;
        Fri, 30 Jun 2023 15:33:44 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e9c4:8375:7234:e6c2])
        by smtp.gmail.com with ESMTPSA id em23-20020a17090b015700b0026356c056cbsm3105864pjb.34.2023.06.30.15.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 15:33:44 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@google.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()
Date:   Fri, 30 Jun 2023 15:33:14 -0700
Message-ID: <20230630153315.v3.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
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

Changes in v3:
- Back to v1 where we stash the handle in a local.

Changes in v2:
- Move the print, don't stash handle in a local.

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

