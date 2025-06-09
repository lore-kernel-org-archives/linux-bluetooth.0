Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E35038385
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479923; cv=none; b=r1JGaUWRHXgB1ry2B/epdaUieWMMF1e2RWodkBkhvChdLYwWnZC1kJBeV8x04F3rRNGb1O4PYzhjmqw2K1AiHiAvyeZp5cpsqio6DxNlG/9MDfsAwJnwQWyqKuGTfXMBUeeuo030wMkojlsKbs/qFMVs2HiqUeJJ0/4CCOmBRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479923; c=relaxed/simple;
	bh=MkTE3pdDFZyDIcj5hpkR43TYu5VoC+TcUgbuRMjuKx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHjGjKYmwpDvi1ZbEk/VoMlJ4L0m6Ug9s4FZxAe9y82zOH2KebWClOwPR831qugc+wk5Buk6XIzzIYjmAUI7GRj0BnAuLzXMiA2ZCPgnaDvFn4nwnJZC4Ti4datBNNzjPkFWhRVjLLwHCZ/V8v80jMQ7qwN3emra4bCbnnWY764=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgbKP4AP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgbKP4AP"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-addfe17ec0bso1003221866b.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 07:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749479919; x=1750084719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RxmAAAdiA+lyMQq48MGZOPPZS884cIpEO0SBqZO+/0=;
        b=HgbKP4APMBorJ2YR0/3v8eXGk0J1YukD4OBXh4riYMVB9ruEDcKngA06UL5s3xdmpq
         A/e5en8J8Ph3DfUhNENKuHFBmxeGzBzaV2SMLsEOYAaLsgkra5W9DlGL4VFD52X2fP3c
         4xIGfdx64IN/4+O4HrzgHsSXOcZTQn/C1nVVg7X5GnfR1fwatI4AAoXEYt7TnLA64W1+
         m+lXrU5xxUIlgII3HfcQLHGj5dGu8rqkNEJiemUv9QtwOMTmKGViLmj7k1OihnLtU8LB
         XsEm/k9qGaxXUq2GXuFCX9zqReKYcIRmpec+6kdiRVkiodh3KrXtxss8rxiGUXwQuRDh
         RWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749479919; x=1750084719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RxmAAAdiA+lyMQq48MGZOPPZS884cIpEO0SBqZO+/0=;
        b=G/ehnacm8VwaVxagAF2KGdaYCKjYMgMF+ojm8q86vj/eKEM677rDPk0UhCGuSeJkIY
         weo2huWX3lXOdEokCfNlHKzOziPHGy54wSTiPZoxpflc+x3aOTV8L1O8VP5+Pf2uD9Yo
         HZI5Fy7C97GLQuf4CyKYueuHf0DK+2fpQIh/RFksuhTkcaNqm6ZuLwQrcLZkPUIQzXYC
         6j79JAnQKXxmY2zw1ihCwU2Ch+NxGmH2W0wF0NXuua81yHSIGE3k1hSJuqvU9NU2bzeb
         iyWoyRDAxDAo0W0pv4Dpux0VHui1rxcGYT7fxFLL7DVuI0x0QnNu4kWlcFdXuUZeBijq
         S36w==
X-Gm-Message-State: AOJu0YwkgCq302MkTwcAa3E4LOrDcVHvmcPYAgL/vFcz8kPTODM3Qvz1
	7GHxTM6uB/3xn+uA4pyCTPbbz48DqkpwfE0PiqpdMkDz0zNz+pERoXLnd8HDFw==
X-Gm-Gg: ASbGnctsZ5jXYuoj+kZJ52BRe5HWBvVfAqZmZG6U05qo2vyYKuW8CmE8Wby+BaLDZ46
	ZjYSKbDdaIjs790ixOLl6IMN7lJ8FMrE0PxDOS+ebpRntVfRdQ68akPOqDPbZOJtLiL2ph16OkD
	prHTDXFIJmnuGKh0wq/q8+8q1NlGW4eQQfQhorQVYF7csxNrORD1MnpWJ27HQrx27FAz7VR9Umx
	/hh+tLXofRVLvzWRIVjEtI2nh2BmUqUGf0T0MDV5mTz1ABuCny46VFXVrEl2lLt5+F0UKbS1m5r
	GGE5vM4eyIudzVVjJksqLIYajDzI7KKjKoeei68z9XPoz8BpeJn71lXTpuYagyGhYdKQvuPHpaL
	X48A471lQnXN17RM+sv4=
X-Google-Smtp-Source: AGHT+IGqu1FA5zPtpWwSFV8ZwReVNlNgk5KXQzuteW63if5nkcFLNadSryEPtqCs+Y8bzYDz75nPQw==
X-Received: by 2002:a17:907:72ca:b0:ad8:9394:272a with SMTP id a640c23a62f3a-ade75ff350cmr13048666b.12.1749479919343;
        Mon, 09 Jun 2025 07:38:39 -0700 (PDT)
Received: from hyperion.tail59961f.ts.net (B-228.ahl.uni-linz.ac.at. [193.171.46.128])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade34ea5adesm452017866b.80.2025.06.09.07.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 07:38:39 -0700 (PDT)
From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Subject: [PATCH BlueZ 2/4] btdev: fix LE Remove ISO Data Path command
Date: Mon,  9 Jun 2025 16:38:09 +0200
Message-ID: <20250609143811.566331-3-d3dx12.xx@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609143811.566331-1-d3dx12.xx@gmail.com>
References: <20250609143811.566331-1-d3dx12.xx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix errors in BAP server
---
 emulator/btdev.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 4cf48a5af..551ccb6d7 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -6726,30 +6726,35 @@ done:
 static int cmd_remove_iso_path(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_remove_iso_path *cmd = data;
-	uint8_t status = BT_HCI_ERR_SUCCESS;
+	struct bt_hci_rsp_le_remove_iso_path rsp;
 	struct btdev_conn *conn;
 
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.handle = cmd->handle;
+
 	conn = queue_find(dev->conns, match_handle,
 				UINT_TO_PTR(cpu_to_le16(cmd->handle)));
 	if (!conn) {
-		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
 		goto done;
 	}
 
-	switch (cmd->direction) {
-	case 0x00:
+	if (cmd->direction > 0x3) {
+		rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	if (cmd->direction & 0x1) {
 		dev->le_iso_path[0] = 0x00;
-		break;
-	case 0x01:
+	}
+	if (cmd->direction & 0x2) {
 		dev->le_iso_path[1] = 0x00;
-		break;
-	default:
-		status = BT_HCI_ERR_INVALID_PARAMETERS;
 	}
 
 done:
-	cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_ISO_PATH, &status,
-							sizeof(status));
+	cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_ISO_PATH, &rsp,
+							sizeof(rsp));
 
 	return 0;
 }
-- 
2.49.0

