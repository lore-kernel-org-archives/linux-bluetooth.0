Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0B3EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 22:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjF3WKW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 18:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjF3WKV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 18:10:21 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6881A3C29
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:10:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso1321008a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688163019; x=1690755019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJ7kxnAKg6Cu8Pu7Voq9nKWydDnN6Tk0Ch2JNhThoso=;
        b=aGkPwnLnHayzjcvlPC0S/w8My+uR91LuCAWSxVO4ashAxJ1pmhX/Ebg1wreE5baRh9
         ipTQHJK80q1LmoGv4y1dxVHl+x0VkLHjPDlqiD2UnPcXgDWjMXGVQB0KbU1+rBZEHA66
         NtBF7MwzFRdjHIb4vortgyayAbaOd2zEvjC9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688163019; x=1690755019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJ7kxnAKg6Cu8Pu7Voq9nKWydDnN6Tk0Ch2JNhThoso=;
        b=mD+5z/w0yV/QA6hi4t/aN56Hh51YUBSQpQPiTYYwFD9wLRZUbp2nPPtxkCPHTVGJ6K
         RkukqvTTG/ePUfOaEWhPLk1Jx+FMybscJdpw4IiIdqZ7ooyKkKdmEwyIdWX2/LzV1TRQ
         pmXibqfDGrTSsGt+h8ZjMCRJMru9rhlXB5rp9XlSOb//i/fTKR1HzqOLqj9RFKanlRBr
         SpHlGnoPG1imBlm/v1QKj1+a/+dqSCJrt27vtSqqR9nOCGSZyDQfrLJlpH3BNHP5lf63
         VbcVs2EwdqDnaVUR6oTRL5qd47JqEg97fm/ojeaEfWYMC0ygODiVlxAKL961CWX0R+ev
         dvCw==
X-Gm-Message-State: AC+VfDwL72nTBYhxqlTno4ZU3plQEV3/KeojCu8HHinN50gVdxNUQitV
        sSkswJ+2yiriiZCs2BTtsrO21g==
X-Google-Smtp-Source: ACHHUZ5vRSB70zXnWQz1lLVzwVB4LIsI55bIhO5OlwOkZSSgqWm+WZvjUNS+IX5K9D+iEprZUhwVcQ==
X-Received: by 2002:a05:6a20:b711:b0:12c:7528:d981 with SMTP id fg17-20020a056a20b71100b0012c7528d981mr2972407pzb.18.1688163018835;
        Fri, 30 Jun 2023 15:10:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e9c4:8375:7234:e6c2])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001ac897026cesm11238797plh.102.2023.06.30.15.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 15:10:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@google.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()
Date:   Fri, 30 Jun 2023 15:09:06 -0700
Message-ID: <20230630150906.v2.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
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

Moving the printout to before the memory is freed.

Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Move the print, don't stash handle in a local.

 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 48917c68358d..7e2ecf8a55d8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1980,9 +1980,9 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 		goto free_monitor;
 
 	case HCI_ADV_MONITOR_EXT_MSFT:
-		status = msft_remove_monitor(hdev, monitor);
 		bt_dev_dbg(hdev, "%s remove monitor %d msft status %d",
 			   hdev->name, monitor->handle, status);
+		status = msft_remove_monitor(hdev, monitor);
 		break;
 	}
 
-- 
2.41.0.255.g8b1d071c50-goog

