Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D39C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 05:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2265C60FC4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 05:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhKCFgJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Nov 2021 01:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhKCFgF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Nov 2021 01:36:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FFCC06120B
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Nov 2021 22:33:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b15-20020a25ae8f000000b005c20f367790so2635383ybj.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Nov 2021 22:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4wxVF/UA81bHWpJF1BL34JMLRn0mSFTIFUNKVwG9QEw=;
        b=Ihx+IrzfR2aW4Ou0bbTr4U5Qrc6b3DU33j64hUzTZbKmXBZb7VIJtx0FIrIyhDWqlG
         IEw0ijFDvKCgKMHPtyc5DysiVhYAHqDkIE7Yf7QaC5fg2QCg4VkjYhYTFX7u7GvzM4Wd
         SM0KsvnTRNolYrWnmJ1EEGebyu9VcwzlZBWFcX4kF4590eGElny1s3tetr5boLe6BZvz
         5DnjaTYkYrnocu5f70QxcVG9Dus42cfuwz1975+U8t/DgQw/fQqxhghILBscIHLZlCQU
         eVfCS36EEKQZ0x0BjLjZsh+mUaDnvDEINbkOO4grMpATgEkSTBw7KmFUHfKkaIwQDN+3
         0sQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4wxVF/UA81bHWpJF1BL34JMLRn0mSFTIFUNKVwG9QEw=;
        b=s0S5iAqJTGuhulgAg3kl9g/WG51VLr/i6NSS2zVg2UB7wXrSOHk7fK6QtpLNvjtJv2
         YNBpq+DOPvwU6wR4okS0Vfg1+z+Jr99i7uKf1oKxJaU48BTHUrVKtJDX8x/7ouVo93ox
         U5s2qFOzmQy2uPT7dQfy7Fao/LkBlc4+yv37L8lNyCAbXD3DZcfpVKdj82ih5q9Q+iXP
         y3Y7gKzLC3bBE6bkC3fgJwELeIskIMJklDQLAklUFheqyYS8Id2muD6zJVz3/+5ollxe
         uQxEP45VOX5ituezTzCcU0QjD55mZnZUwRlMRCpnVfRYPZAtjcJVqYMdjIFMAJ8RcNj8
         XlLQ==
X-Gm-Message-State: AOAM5332XgewIr8XNm4x3dqBt8cPzTH16fWa2iTshuir3SU1Rje0jfb4
        b/UgmA6A4gpU0ZXZZ4CQw08NzSAht04DBA8AFfwFYDgyxEhSNO8NerL/x9TI//Jd5cfWFK1PMpG
        SHlbENrvNr3l6Gj0GbUgCwhBFQ6pgowG1pgznSaFBBqS7NA1KXrS2FxTezbX6OK/7V7nwcSsfPv
        68
X-Google-Smtp-Source: ABdhPJyxMd+VMAKgNb3yje1nfRoE5XJsNYWwKr2u4DrGOxfpm6OJpKMkQz3gmxEIkptTp0PoU/Yuud9UeefO
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:7af7:a937:5810:b542])
 (user=apusaka job=sendgmr) by 2002:a25:7146:: with SMTP id
 m67mr45521192ybc.353.1635917608988; Tue, 02 Nov 2021 22:33:28 -0700 (PDT)
Date:   Wed,  3 Nov 2021 13:33:15 +0800
In-Reply-To: <20211103133225.v2.1.I3ba1a76d72da5a813cf6e6f219838c9ef28c5eaa@changeid>
Message-Id: <20211103133225.v2.2.I4e34d9e5fdd7515aa15d0ee2ef94d57dcb48a927@changeid>
Mime-Version: 1.0
References: <20211103133225.v2.1.I3ba1a76d72da5a813cf6e6f219838c9ef28c5eaa@changeid>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v2 2/2] Bluetooth: Attempt to clear HCI_LE_ADV on adv set
 terminated error event
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

We should clear the flag if the adv instance removed due to receiving
this error status is the last one we have.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
---

(no changes since v1)

 net/bluetooth/hci_event.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7d875927c48b..d3478cdfd009 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5558,6 +5558,10 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_remove_adv_instance(hdev, ev->handle);
 		mgmt_advertising_removed(NULL, hdev, ev->handle);
 
+		/* If we are no longer advertising, clear HCI_LE_ADV */
+		if (list_empty(&hdev->adv_instances))
+			hci_dev_clear_flag(hdev, HCI_LE_ADV);
+
 		return;
 	}
 
-- 
2.33.1.1089.g2158813163f-goog

