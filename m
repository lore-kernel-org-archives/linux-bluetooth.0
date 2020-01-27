Return-Path: <SRS0=tmcz=3Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812EBC2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jan 2020 19:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4601122527
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jan 2020 19:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIGRykOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgA0TLg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:11:36 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39690 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0TLf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jan 2020 14:11:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id q10so5338736pfs.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2020 11:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IM2WtSqqz/KMDu+9TVSSDuHmSUPx9MgnPUHazGbx/J0=;
        b=iIGRykOaOQGiepKpzv6XwtFJ9M3VWeyYMM1xsGaE01Bmw4DxzCKAKE+p+uzPBhcuxN
         mt+N5za01+f2LeldknrHnl6GLUAby/xfDXgmdYMofimY+pFSGvinaL0Mo/2k3ZjmU3DI
         TsoblaOgM1C31/GbVfA+50cawrxs1Qgb0+XUBu6LQpo0dpO7sTZxjWrcL001O7OYE2ld
         XDhIJl+/uX1Z14yKcBKGIzFtW0aVoPEHI/vW+pbhPuzKgxmS56ghKS3VxlbT7n/4DpWJ
         eY0I9yaTpDbvXsy8lmzwPeAwq1BK1Q5p9qk06bBue9R9YWgsKw4M4W9ujvrrKgNGxT/4
         WKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IM2WtSqqz/KMDu+9TVSSDuHmSUPx9MgnPUHazGbx/J0=;
        b=K5LQ3Joag4RyTmQ17TAsIBt1nHqa16ynTJHm5Kh7f+NaqeH3b+L+pZHgoCWeqx7u2S
         JOqaq0URWKsTOEliyLKM3TL4DINPb/DGTE6k0Px4ChSuGd4kC/XG90xephLNfbf5va0o
         jAtsR3KWZOrDSxKQGLeuNkTs5jR071MBlQK4NSg5qiJgdcD4AW22O/eS7YlZ+oiqSkcW
         ECK0foJUpHoD9OFzfv9kfhgwyBHZy4WEw2Vp3sq3XzT83i2b5oC+bxH2A6aODbXCr6Bj
         Ni4Kll9SoNT8SVhjdykT/RRugjFZDN8/J4LcaDJteUmbcIlvF4hqWxeK6gn8Ro2vAIHJ
         xZaQ==
X-Gm-Message-State: APjAAAWafWXt82mAgkhIavbBxxKqMs16MMLS0f11GaXAXr9ABz5ZhNGN
        nVW7OQPRdc7fD7mnPwSdqL+19zcK1kk=
X-Google-Smtp-Source: APXvYqzpp/3UxdjeEtZjXqLTnrbpOZSlX75FAj15mrFtWNpT1I7Sr7rB6fcxAld+g5CZ4se4Tn1dnA==
X-Received: by 2002:a63:d705:: with SMTP id d5mr20742163pgg.24.1580152294960;
        Mon, 27 Jan 2020 11:11:34 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id o11sm6447292pjs.6.2020.01.27.11.11.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 11:11:34 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix inconsistent returns 'hdev->lock'
Date:   Mon, 27 Jan 2020 11:11:33 -0800
Message-Id: <20200127191133.5144-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If Set CIG Parameters fails the hdev->lock was left locked.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c40ae10e7b9a..bea39d5f6936 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3168,7 +3168,7 @@ static void hci_cc_le_set_cig_params(struct hci_dev *hdev, struct sk_buff *skb)
 			conn->state = BT_CLOSED;
 			hci_connect_cfm(conn, rp->status);
 			hci_conn_del(conn);
-			return;
+			goto unlock;
 		}
 
 		conn->handle = __le16_to_cpu(rp->handle[i++]);
@@ -3183,6 +3183,7 @@ static void hci_cc_le_set_cig_params(struct hci_dev *hdev, struct sk_buff *skb)
 			break;
 	}
 
+unlock:
 	rcu_read_unlock();
 
 	hci_dev_unlock(hdev);
-- 
2.21.0

