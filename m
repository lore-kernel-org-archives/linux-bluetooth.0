Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3014F209
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jan 2024 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYy1vbn6"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59612e4a21eso1565426eaf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jan 2024 12:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704919656; x=1705524456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zj++l+mf3FDa72zdeI87pU80V590WTDaa275VKlcuWo=;
        b=bYy1vbn6JgCV1LLIl7bNhBKq26caQpi53faHXPdEJGBo00L6U4TPjBU3bNEpRbvYjD
         q7vDsr/09DtCH92prbMHbUdOp2bWR9f/DJE6FsF9D2t3ICpwhquFBvw/gQAIJ06AAEqD
         PqK3mwlhX1N7BQu/3shAxi5C1tJm8iJ5gfwlRLK3VtTyYsGZIVBzkKIUJeE0Jm54UpCU
         qrbtCZGtYj16ytDh3J2dK31ILJt8ZiZm6SIDXpHgOS+giGGpNA1lDZHZagp6UN4AwJ/g
         e8t2eOA/R8X5cige+PrG1yIg2hfQCLNnKfxUa0yeolTxGpJ4rFw+hFmCzmfNK58f2hmI
         1Ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704919656; x=1705524456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zj++l+mf3FDa72zdeI87pU80V590WTDaa275VKlcuWo=;
        b=kcQRKLZ9uv9Pv5EFRfQ/MoPul9v6+hnBE3E7hrX5L6G/zvRVvks1t2/PleF1KYmeux
         HZ3kNovky1hkz0JQ1cUfj6P00i+UlCNnVmcGGSpm6Ddw57yM4F6AwIVu3qPMc9YGn1fS
         761MWrelIbclRzsVC9TqAurOHrJLxZySxP72gQmjJRSxzRC9D3zYmgOXZR7gBEdZH+ON
         jv/TRBF5bITtytmOe1vwknYxNmPznz4UK+b4AAtUoFBaBQYnKpaHLlnLY1l4AjI4ELQy
         h6Pts6efDa3bTOQEYNsNE1E+v+OBdC9XQjlxt8BeVFZ61oHBhAx+Cq8otq01zWjNcIHq
         Abzg==
X-Gm-Message-State: AOJu0Yy0HYU1jI72laIGHpTAb5/XJXyqjcAiGw/8bY1OEhCb02mNLdaO
	vYGEtWC4KVOOtAAEanWPxpEpfrxBR9o=
X-Google-Smtp-Source: AGHT+IEw1baCPatdNdpgfZndXo10zB8U/VOxsefmSHkBtd2lJu7ruNBzxNuBTW8ksbSne9B83WxJzw==
X-Received: by 2002:a05:6820:22a0:b0:594:6f:f6d6 with SMTP id ck32-20020a05682022a000b00594006ff6d6mr205603oob.8.1704919655802;
        Wed, 10 Jan 2024 12:47:35 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id e12-20020a4ae0cc000000b00591cdc0f2f3sm913732oot.19.2024.01.10.12.47.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 12:47:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_core: Cancel request on command timeout
Date: Wed, 10 Jan 2024 15:47:33 -0500
Message-ID: <20240110204733.685963-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If command has timed out call __hci_cmd_sync_cancel to notify the
hci_req since it will inevitably cause a timeout.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e5cb618fa6d3..af82f903163e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1523,10 +1523,11 @@ static void hci_cmd_timeout(struct work_struct *work)
 					    cmd_timer.work);
 
 	if (hdev->sent_cmd) {
-		struct hci_command_hdr *sent = (void *) hdev->sent_cmd->data;
-		u16 opcode = __le16_to_cpu(sent->opcode);
+		u16 opcode = hci_skb_opcode(hdev->sent_cmd);
 
 		bt_dev_err(hdev, "command 0x%4.4x tx timeout", opcode);
+
+		__hci_cmd_sync_cancel(hdev, -ETIMEDOUT);
 	} else {
 		bt_dev_err(hdev, "command tx timeout");
 	}
-- 
2.43.0

