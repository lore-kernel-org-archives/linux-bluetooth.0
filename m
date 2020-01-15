Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CC5C33CB3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5508C2187F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNXy5ib9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgAOGgo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:36:44 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55668 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbgAOGgo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:36:44 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so7011040pjz.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EGe4H6YZx4HGcWjUhBG9tFRR0Cqf/n0gDFJdojZvusY=;
        b=aNXy5ib9bqiULTkOZs0WEblOc4HQxSibz8s2TRd/G3So6saKCKafYRNOPXmNxkD0Zn
         EYUwJ2HbZLDwRZmwTnIqugwTe2R+LkOH+0NJQZ2Ze6UH304Y74locFCF9fdvYRrec/hQ
         3pQlKo5rf/47JpFwx5CeEk6PRPS9aIp8/hkoIV3auDTNsRJ9EoFbt3SZm4XcGS16gnsA
         +bPNyZ5Z1TvvxpQE6QzaubThE/atT+Asim48icgWyJqV+rdNeO16yToWjgUEHdmKKVOC
         GgIybAJADPzw11O41MolmcrjPnPykusy0RUhpckFkhQorNNMxnnR6gMeFxUnQxVPwoEA
         KGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGe4H6YZx4HGcWjUhBG9tFRR0Cqf/n0gDFJdojZvusY=;
        b=OGDNU0RbrcvH0cn6lw3rqsNzX6ZiA9uxjgJ7QNQTEImuNATvA1IT5tEFBmxT5hbUrT
         0AFzCQF3CltUqd0hCxo5ctScMFB6wloo+ZrusquBc41rkPzUtGeaWNhSOEM0hSMmhmnO
         YBmF3D+l2xWRUUTiOEgzoTFf5lpILLlwRDjT29NaFLzL13QiZO14X4NTV3vtO0VzOddC
         zLoxWACBNNgdtxoEW95GXxPswf4kPzFriKDTQ6kUJuLuFoTDOl0WEFqn/hz0ou02yxlN
         c2QYTmGTOoTfTfkjXGYKrLJumzYXKv3PzD9LfntqS1HTfZOXDlwJF7yH83bdD0DsnxbB
         3+3Q==
X-Gm-Message-State: APjAAAUVTP1S1Hj91Er7oS3PNzGOfSIjs3wX6bvwKlO0u3tR2iT0RTDW
        sTTAtNBNoRqqnZ+4qYgTwGlqtBozE5w=
X-Google-Smtp-Source: APXvYqzwXE4tvk9lRtxsGabH5fKXADu1y8a58ayaRukNSCwGdcxuKLbdXhR0HER0QboobaXv7jUiyw==
X-Received: by 2002:a17:90a:8c05:: with SMTP id a5mr34723035pjo.86.1579070203224;
        Tue, 14 Jan 2020 22:36:43 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id z19sm19725594pfn.49.2020.01.14.22.36.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:36:42 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 08/11] Bluetooth: Make use of __check_timeout on hci_sched_le
Date:   Tue, 14 Jan 2020 22:36:30 -0800
Message-Id: <20200115063633.32441-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115063633.32441-1-luiz.dentz@gmail.com>
References: <20200115063633.32441-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reuse __check_timeout on hci_sched_le following the same logic
used hci_sched_acl.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cc78fcc3672c..2fc367f30b6d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4298,15 +4298,10 @@ static void hci_sched_le(struct hci_dev *hdev)
 	if (!hci_conn_num(hdev, LE_LINK))
 		return;
 
-	if (!hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
-		/* LE tx timeout must be longer than maximum
-		 * link supervision timeout (40.9 seconds) */
-		if (!hdev->le_cnt && hdev->le_pkts &&
-		    time_after(jiffies, hdev->le_last_tx + HZ * 45))
-			hci_link_tx_to(hdev, LE_LINK);
-	}
-
 	cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
+
+	__check_timeout(hdev, cnt);
+
 	tmp = cnt;
 	while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
-- 
2.21.0

