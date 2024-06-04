Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55526199A2;
	Tue,  4 Jun 2024 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541226; cv=none; b=pJcVy4BxPidpuNNSVN+mtO6jX21feCrGv7QABNp0wwf6f+WsoJcYFyBw+t1N+9ZvgTeQYH55jjdEwdf/wh1nskKORNFAnb8Wr9jyhGPpSzO/I+Ie9Ws+3JLIOYu7ietQ2sK4+uE3CIsO7UxagD+8vWF/ajpIwhShrH6sjY8RiT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541226; c=relaxed/simple;
	bh=TZ4KcGLIy6A5jyXPipp0Fsh2uTBfzi13vz2vHN00lrc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q8/x/xiPCZr2hcXNGBu5nfySwXapULcxLnkVjfqDCqlplw1ixr6trqssO9qG2DmhXIBFkjBicNBGMAwOhrLrvFO0xrQXc1yCHnlBZMM59EeI/Ro75/wGmPqJpqhp+ze2Nxg5lNec7LG9HCKXEm4E8hUsnd81I1WHf3XzyK7k0wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d1ffa160b8so138470b6e.1;
        Tue, 04 Jun 2024 15:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717541224; x=1718146024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiD4Ke2N9LU6SCkq4K5xtOszVjDU8myvBHd+iGq33v8=;
        b=E+5+ZDKfJWfi8EixfRkAI/StZO1LAd+gHU/oMhJmfmR1QjSzb0e3fmF3fhPdcR0hay
         olaqv2MKTfEIMfDV6lQEQJsDrfDd4wrQwWiB2w5NOsMbo2qI6cQ5tvyBxuCKnUpwsN+K
         ukqaRQNM9SIfKUbnTtLf/CL6cLcA9/WAYU7mRXaD9b1+qdhmnPOwGMN6P54r8oYugPJi
         lYXYgepFcexrvbqGEIS7rC9D7y9CMAUX1LLrb+/EUBW/FMMyb0iE64vqqQxf+y3WfsoN
         EVzrNUmhTs9eRJTc4EUy441GjJDQMGfItHfWPslRwxljiqM3OABdpN4xSSubQ1levUDG
         6mvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQUD7aR8eW5X5wIDx+NYMlcbtsNZWwwQbNEyN+eGZym3elCm9h+7+q8Xu7balGyJhuDo/M4rnlLgO/kcyL3aO6BwFsdJ00ysGLTmoz
X-Gm-Message-State: AOJu0Yzr2NZgbWXU0xyWCHcCAzpESCXI5c14MxpFy/wd0n2UwM6oaUAe
	UxMA98MHayTEiF9+Ej2YCdTuOWv/xvhl5b/Z/aUnoj+kcaDNyy6K
X-Google-Smtp-Source: AGHT+IHKyQa5YdQiiojcvxDO2Va94udiYdn5BFzckK2TCI7Gu6HfRStiK6xqb7kXnZv03ljFfKylyA==
X-Received: by 2002:a05:6830:20d4:b0:6f9:3eab:145e with SMTP id 46e09a7af769-6f94380cbfdmr902388a34.2.1717541224282;
        Tue, 04 Jun 2024 15:47:04 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f93b4a3e00sm478529a34.50.2024.06.04.15.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 15:47:03 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 1/2] Bluetooth: btusb: mediatek: remove the unnecessary goto tag
Date: Tue,  4 Jun 2024 15:46:59 -0700
Message-Id: <8f809ae0094c89ed99efb4074472edd119db8ec1.1717540338.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Remove the unnecessary goto tag whether there is an error or not, we have
to free the buffer at the end of the function.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btusb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 79aefdb3324d..fcdd660add19 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2953,12 +2953,9 @@ static int btusb_mtk_uhw_reg_write(struct btusb_data *data, u32 reg, u32 val)
 			      0x5E,
 			      reg >> 16, reg & 0xffff,
 			      buf, 4, USB_CTRL_SET_TIMEOUT);
-	if (err < 0) {
+	if (err < 0)
 		bt_dev_err(hdev, "Failed to write uhw reg(%d)", err);
-		goto err_free_buf;
-	}
 
-err_free_buf:
 	kfree(buf);
 
 	return err;
-- 
2.25.1

