Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0130E5FEF7
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845069; cv=none; b=Gf3eNYE4yl3weLoGtFPlBMYLRmruI41i56XWvaR23X63yqZ6RaSzvn8TlyIVCzcV6y9K4Lu3l2JjuLmm5KE71kmup4d4fvgd+A1K4pDzeU6mBFxANNwZVQJ3oS6gD46UVfIuqSf+10lHrwjIvP08cMY55kgSBSO0ukVXBXQzYvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845069; c=relaxed/simple;
	bh=dAcS//bN5EUl0rmpd6MTRSeVq9WzyY8e6NY4x+P70zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/deynDU4gpxZ9sin5mpkPm70BgAOQF3f4NBxqeF7SJJeH5QuGp9KDwfEDNiU5lKaUu/ySMozLGe3I98njGxKrlVEBL+Syx0l2GC/2DVtaGHBOhJtPFM26dpcgJcJk/haHmo4ure6WqckhurGNiAYU6136+IxNmMpxuqbc2FY8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jSyTHznY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jSyTHznY"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e104a8e3f7so283714b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 09:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707845066; x=1708449866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8XLUuSB3OMz4OtDEw/wq9wIqlJoGF0PKwvDRzd4XmEc=;
        b=jSyTHznYTizsJJLkDBNnEn1tFnEEfimEe8x37UwmjW5wso19x10HZZY61wY78EdTrW
         9DyOEA5wzzD5R34w2VihyXRZklBwkrVUFT593Rfr1S3C2wxXn9aiFM5ujSdmB6503qjx
         q59YdCMVaSulr24jKgyFXy9WDopCwJdtmwL04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707845066; x=1708449866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XLUuSB3OMz4OtDEw/wq9wIqlJoGF0PKwvDRzd4XmEc=;
        b=B2XBcg13SJ4hRK1fQCeYgXtpaUstwarTikFJ/S5sQGVJ0eSZ4GTXdiblROtB3ozpeD
         0CYAIXtx5DZqS16ioHsjR4/CLpQdqYdteMwKOEpqSvAoAbkobJT35VLzto53xDpENEcM
         wvcbCjd1+00AfyBCnnyrX6OdG8/SxUEPkOmewpp5DN186vgH+4des6zAj8/s6HswtzGi
         BNvvfv70ifgSkh/mT06NdZupmpeWDT7AIb9YPm3JF5Ejp1vyoe4IqdpPpJMpLM/ilEBL
         5q6B5rc5e8HwAJG49nWWSTit/sI6lRQSmLW161yNCt77VLNq1/2/vZLuU2vHkJfdVIkL
         pL9g==
X-Gm-Message-State: AOJu0Yx39hcicKn1O6jzBiz8c8jfWn5DJRfdZ9kwaHAboBrSRfDLCNdH
	MAD0clKquedXMXHICsSmne3x+iLzYr3agSbdWfuz7UepyuAbp2y2G+9+oOajgI52yWfMtdh3P8p
	f9A==
X-Google-Smtp-Source: AGHT+IFdmIO9hfCRggCQg8+KevN9Tmla+FFn050mODC8Y8KpOKXoFLl2B6fcd42BXxVy7VjHKSh6ww==
X-Received: by 2002:a05:6a21:3115:b0:19e:a270:e766 with SMTP id yz21-20020a056a21311500b0019ea270e766mr335577pzb.5.1707845066416;
        Tue, 13 Feb 2024 09:24:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3gdAZrMiwHKmpifH8I6waLmgmEwpS3trwB7VFLzXrxjOa5uNlGnMgRca14Hzd+QYpdvWYn5n9Liwb5rPRx6lgYUkHDUn2+cbT1jg1pJ5Q0cr3NA51wno716+wCz+1Ky7mnxQeNPx+XU919MMCJJL8nnt5gANYBIT/TVmz9WT2lovM+AK+ftEDGREWJSau0qCrGqe62uHuDdpTb6Nd+c96QUpwVeMd
Received: from localhost (253.78.80.34.bc.googleusercontent.com. [34.80.78.253])
        by smtp.gmail.com with UTF8SMTPSA id o21-20020a637e55000000b005c2420fb198sm2672177pgn.37.2024.02.13.09.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 09:24:26 -0800 (PST)
From: Hsin-chen Chuang <chharry@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: chromeos-bluetooth-upstreaming@chromium.org,
	Hsin-chen Chuang <chharry@chromium.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org
Subject: [BlueZ PATCH] Bluetooth: hci_core: Skip hci_cmd_work if hci_request is pending
Date: Wed, 14 Feb 2024 01:23:29 +0800
Message-ID: <20240214012328.BlueZ.1.I10eda6f375bc8dfedf4eef3a8cf6572c65803afc@changeid>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_cmd_work overwrites the hdev->sent_cmd which contains the required
info for a hci_request to work. In the real world, it's observed that
a request from hci_le_ext_create_conn_sync could be interrupted by
the authentication (hci_conn_auth) caused by rfcomm_sock_connect. When
it happends, hci_le_ext_create_conn_sync hangs until timeout; If the
LE connection is triggered by MGMT, it freezes the whole MGMT interface.

Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

 net/bluetooth/hci_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 34c8dca2069f..e3706889976d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4213,8 +4213,11 @@ static void hci_cmd_work(struct work_struct *work)
 	BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
 	       atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
 
-	/* Send queued commands */
-	if (atomic_read(&hdev->cmd_cnt)) {
+	/* Send queued commands. Don't send the command when there is a pending
+	 * hci_request because the request callbacks would be overwritten.
+	 */
+	if (atomic_read(&hdev->cmd_cnt) &&
+	    !hci_dev_test_flag(hdev, HCI_CMD_PENDING)) {
 		skb = skb_dequeue(&hdev->cmd_q);
 		if (!skb)
 			return;
-- 
2.43.0.687.g38aa6559b0-goog

