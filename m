Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1AC1DACB1;
	Mon,  7 Oct 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317441; cv=none; b=NJegndy0Co/zLnwcYMlz4OItP09ZYFz5A4DCjqKiK8BmAea4b4tcr8SJ967vDvLQ2J6Jvupp5JhRKLNHlL1v2XEMrK+08EoPV6cw/NsIy2FtWXu02fxSd2uI7TolPxZDUu/aMHdDwEuRNxsEqv2aEjCFx6SGIA/KqTIpJWZ8A5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317441; c=relaxed/simple;
	bh=jqRT0MjhW0c1pKptumvD649vDfjSK9aiy+1Zje0BPXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=R/qNMoKem1otp5SntoMjnlNiTM8Fx107aEeLIdNvDl5R3gmq4P1pbVaAz5VpRihzJzo1vze/fKQP2Lik3vsyVI8hD8tbEbGesDO9AHAZzcQzutS0rdWi5DZDN5WEw5TK4WXgUd3wHTv4FkWo11DadFsyGo3T3aKXzxAZSEYJE9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLO8zqh9; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLO8zqh9"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5398a26b64fso4508342e87.3;
        Mon, 07 Oct 2024 09:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728317437; x=1728922237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U+K3PbfBoTX2wUcgEjnsa25KYTHTRS2wMyxC1zcOfsA=;
        b=PLO8zqh9ww8mlhY320i6XF4DHZIL2BHNWeABr9sZ7VNj4Qq974oLIo5ClWfJiLbBYy
         j7TdbjcZYVXeGFKwauyJC5eW5SSZr1NVhYp/4qzWdUrugqGs3el+pnrVadH45XpSOr58
         rPVQV65hr4shms09NY6r/ykg6SFa1yO4OulB7seYkWU/xdLwg8PEKBS3QigmsN/aQjhK
         Kbi4KbAOZtN9KOn04vw5/X4x3UNcm4J3yrTJfLkVfFFhDzw4P81bfbX8YNGyHM44W7jJ
         EqoiI9DMXtByQfFiRgia2mjw6pw8tiKm0xr0PCSEKrlEAc6s+VJhjun+yxXRsOXogmJR
         P9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728317437; x=1728922237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+K3PbfBoTX2wUcgEjnsa25KYTHTRS2wMyxC1zcOfsA=;
        b=li/zJ4sGwd3XyqDxHIAWtF47dT4qXVVBeacejoMbtetKsfjMa+lrFmJye6OLpqAso6
         ofjAemancjD2KF1wPjbYsgPMOZYgAsR/ld9FKrWbWAD6wqEj4+lxbGi0bt7hcG5r32dp
         X50BP60eAAJSolFcYmhFUM89tyaqw/9QPF58uuv4hZ9uQpLkh/+/SH9Grw6tQJAB4/cx
         RblqzFWGhY1vqj5/BFy8lINyKbtv4bajn9snXEGinIi8oaZsQfHLLuV8YDHWAtYNQet+
         QsqzRZ5rdhW7yRJ1Y4ziejPKfAiNr4b/bv/BOtXI3LrGIpIvruIwQ6q/Ekp+SBcXTmJq
         iKbw==
X-Forwarded-Encrypted: i=1; AJvYcCW0Iy29RYAUIewdP5VereImso4KBjhqgqRIG/icFUFYTJPbdLo/hdaNlEiuCuC3ZJ8pffW28F2b9yPgbR8FEk8=@vger.kernel.org, AJvYcCXPitS/o7C8J6FKT48fyM06LZRlWf8eOcQQAZ1LA2T+CC/sRzW4UEG8mHMc2iof1GGQ7xUxx5F+tOL33azY@vger.kernel.org
X-Gm-Message-State: AOJu0YzbKuFbWhszm5ofI5fT+boGgNKVj6o0I+u8hEHIZrhcMQptaCWA
	baTzPydwqjgJ4bcaNndF3XS2EBczMf0QHsi1muQFhmDAz65h54uCLw2N1OA0
X-Google-Smtp-Source: AGHT+IGf71nXO98tJClwTu407FAo31ybbmp3IefuTZUSDLHa7CsU2vG9zB3l0sIBPhjKy7TELrwLWA==
X-Received: by 2002:a05:6512:3052:b0:539:a039:9bb6 with SMTP id 2adb3069b0e04-539ab9f0fbcmr5846466e87.56.1728317436528;
        Mon, 07 Oct 2024 09:10:36 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9950c46a7fsm185087366b.68.2024.10.07.09.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 09:10:36 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] Bluetooth: btintel_pcie: remove redundant assignment to variable ret
Date: Mon,  7 Oct 2024 17:10:35 +0100
Message-Id: <20241007161035.1205516-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable ret is being assigned -ENOMEM however this is never
read and it is being re-assigned a new value when the code jumps
to label resubmit. The assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/bluetooth/btintel_pcie.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 5252125b003f..2c5d1edf1919 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -516,10 +516,8 @@ static int btintel_pcie_submit_rx_work(struct btintel_pcie_data *data, u8 status
 	buf += sizeof(*rfh_hdr);
 
 	skb = alloc_skb(len, GFP_ATOMIC);
-	if (!skb) {
-		ret = -ENOMEM;
+	if (!skb)
 		goto resubmit;
-	}
 
 	skb_put_data(skb, buf, len);
 	skb_queue_tail(&data->rx_skb_q, skb);
-- 
2.39.5

