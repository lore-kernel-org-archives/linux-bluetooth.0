Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B777733ADB9
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 03:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752430; cv=none; b=QD4z97JFPB79sCE7z3Rb4ZVs2Y08sgGVZ8lHBPFGH7JzR34nqtXZuGEcIvg12WvPs7kse2CEPSPhwKBODF/pIuXhu3wMYbSJOfuJ1xfAVsEQkvym04canseFJ43cYahotlQaTKyKN/TVGu98Aea6gmd5wbNJ3UM6owgdGYMfAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752430; c=relaxed/simple;
	bh=hEpLBSJWmIi2BGdQk8PNEPlr0dXVKHYKZdVMrSbYtOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grlWDVPiNehVWefgIbwOh1V1AzEa0GUUXNTy5/iIvSRZZXc8taU0U5erwaXrQXgI+wfN6JO/ERG0eS3hNmONPYjdJUQsPbLr3d4Xqn+rB2OiuCcaJ8SYNHUQh3zHvNZLTn7HtH4GIWqdTan1uV6TKQzxNamicHicrZR++HJOVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I8vX9Oni; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I8vX9Oni"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c88d4606ec8so234228a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 20:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781752429; x=1782357229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnAPP6DMQ7GwEGmMlCW71qkXAHg6fFaZ5ldwM/JO2oA=;
        b=I8vX9Oniwslzw2VTxdJixxaxQYNl+kc4oJFcXD7Q5O/oh7eRZTTfA8mfgRL/JFeAhX
         VdNFa60CdkjOq6MRoNpV43TOdn8QDNSOWpfMnOU0GTyrCKQv/OkCo7XBE74HjlIQU8R0
         7Z19u88h4VOrj7fPCydGsTnVQJ8vrLyVdoL7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752429; x=1782357229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RnAPP6DMQ7GwEGmMlCW71qkXAHg6fFaZ5ldwM/JO2oA=;
        b=PlMpCqbuCEzLk8kGkVA6Q+JDxC0GN5O+09GZRwy8X2u5N8pR9CXTMMjAr6wuMIdwhi
         kXV/B/mDQh17eErJkRAwc7t+E4jZntRr9mkUJT5qNe79hwFQwJCHH2FduVKg2avBrrPB
         w5fL3/KA+opWu3aNPbOGW9SChbW5a2/kT2KKPOfkWLk7X2l4U2GzeMT+recUdM4f4yu1
         MW6FWTFQDg8q04OLNyWhEOW7forvtBigTycJc2sd3GG5shnJ4i2zVnjuk0Eg47s5FFmC
         LoSc+2ShLNjAsz5iXo/aREbfnDp3WbXWKN3bqgDj27VFNQzuDPl8UfOMiVPLYFjvy0rf
         ep2A==
X-Forwarded-Encrypted: i=1; AFNElJ+GyTrut7c1Rbrl+7gH7uUIEg7Sg5TAzHh0QsSlShIPIEIlk1i8CVf7Pw5FwK2eCTlYBwtovoG9pR4FaIyWIn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPEYancYxeXfJuKganMEK0btQqkPqn+DMqfrDrTca1G2eS8zRF
	F9S54GEqd8VY/VSkItdHL0viCQkeyrKzleGmx+oHO9x8YjzqoV8R4vVI7FZA/xHL1g==
X-Gm-Gg: AfdE7cm6609vloUQ9c7O/5Q4N8PoPWTbdc3ZIhcese57wY+3KxnOf6vklEa2YfV1Te2
	lElC0DehRs1NTKNG/VKGfsfOP+GQh4Ph1BKZrAUH/mpgGdg8Ytatb1DsKw/nXCLcw7wKxmqtSUk
	SLnO0N9lWg+4n9sTjWnJMcxwJCYI5mUTG8apD49MhaOZ/8Dh0h8HxMOzCtiO/E4qMFYZ1FpCamX
	xGrIllBEzIIjw115CMCrIUN/9Spw9tWIrlWp3Xp/j1ASjvX3d4rlmKrpsijMt6k4DFxv9Bcj/x1
	6mXtA3dhOxZgF6oUXZMpER8VSryknc/cQzn7AouiFkkgHyt9zVYgkq7KJeKQQWVW9OamzCkpDlQ
	p4LfVjBV0pfbiHcFzUZG13CbVKxJpCMypL4Li7mW53KzcOVKFN5V2tLBI9PPnvuIwbxW4Ctpaw5
	8qStrQK26AHp/J5+XVIwK+9MdPIbBOG43UMVNJyaOjv9unb6CJkyccs3Ze4wjnl5DJ/j9ghlQ54
	L8=
X-Received: by 2002:a05:6a00:1896:b0:842:6a3b:60c9 with SMTP id d2e1a72fcca58-8453b214f5emr1655665b3a.24.1781752429085;
        Wed, 17 Jun 2026 20:13:49 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:20ef:efdb:f2c9:836f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b046911sm17548232b3a.53.2026.06.17.20.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:13:48 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: Tomasz Figa <tfiga@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] Bluetooth: btmtksdio: test for BUS IO errors in btmtksdio_txrx_work()
Date: Thu, 18 Jun 2026 12:13:21 +0900
Message-ID: <20260618031338.1011410-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
In-Reply-To: <20260618031338.1011410-1-senozhatsky@chromium.org>
References: <20260618031338.1011410-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btmtksdio_txrx_work() loop termination condition checks for
int_status being non-zero, however, this evaluates to true
even when sdio_readl() encounters BUS I/O error (in which
case int_status is 0xffffffff).  Break out of the loop if
sdio_readl() errors out.

Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt service to work")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/bluetooth/btmtksdio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index c6f80c419e90..d8c8d2857527 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -574,7 +574,9 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 	txrx_timeout = jiffies + 5 * HZ;
 
 	do {
-		int_status = sdio_readl(bdev->func, MTK_REG_CHISR, NULL);
+		int_status = sdio_readl(bdev->func, MTK_REG_CHISR, &err);
+		if (err < 0 || int_status == 0xffffffff)
+			break;
 
 		/* Ack an interrupt as soon as possible before any operation on
 		 * hardware.
-- 
2.54.0.1189.g8c84645362-goog

