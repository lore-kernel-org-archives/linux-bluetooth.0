Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F2B35DA75
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593582; cv=none; b=dzrzRfXgLxNvzsQOLYLk8jvtXQ8Vhs9N7CV23SZzDdStEI+i3lxFyPAW6zsJ0+402a8adFKP+KqFhpuvzmTaCVbUWIUpNd6/xgEiMACykQXbxmSa8Gud0FLRtGuIul5uhdJ/7pAjvPzG8XHXdxlpie8EBxKacRpJF7tOjXMXk1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593582; c=relaxed/simple;
	bh=KuG/Vj65VFugpk37vr3vxo3s/LMfZ6lAl6qQhMXmhfI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nxs8SXNoCYjuj2K3IiE0OUcyZJFFDt0baXbvN+y1hbNcD6prs6/LJgFLIdOrCboCE5807szu/rMSJA717wv/sr1ELIwl3DcO/ejo/6zwfAKKZ08Vog4QK5f/XwWq4dMbZZ66jm5kAQ/KDow9wqXgaYJbS8gBlYaMYUC/KtYuPYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PC3+rNWk; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC3+rNWk"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-59e2b96e3d3so654993e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 10:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780593580; x=1781198380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fM3l9ELXgEWheLIphVzGFUj9pLih0oyDyYaII8IOtIA=;
        b=PC3+rNWkImpmZGD3JG8lC1xQP8LhoBzc173/wEh5Fe6Y377P21gEAmPtyoV880V0bj
         Nr1BKpOnUPtG0JqXfTrW+xvOTudMhNYNZAH7nPe2gUkfReKigcPE2+uvTuwb7oNpsnxv
         PY2Qsd+koSUAZJLowQVgFuRB2eL9lK8tjHlDQz0dwKIa+8KYOe+UVdkWz8vyOoHP4Oac
         n+b2JNs01i5S9Vs5s/yuHuKowFEpSIVpby/juVnGSsXmdsWfIDB0S/O9QY6oVvS/WTHK
         ysw+uhyo9Jj+j+A7YjrBSQzZqwB0V1PCkgLm+kyPq9U5/gKjrKo1i3dHFl9nEv6s11iI
         FS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593580; x=1781198380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fM3l9ELXgEWheLIphVzGFUj9pLih0oyDyYaII8IOtIA=;
        b=LzCaHLvXel/VAFJhDrpHGzG4WZJOrqwsLizA+G3OI9KG6TkL3aIceV+2YiVCc46R8q
         p9I1CG9QQb0Ota3yVaSo2ldXk1+5sDO3Yj3kPBjNz987KZP571m3GsbZZ57E2/Poq1Fh
         MDgJjGY+LM4neubULHRB3+9vp3AK42NgjcgU9+6O3/T1VVkBiFwAXiEwYJqekYUUUBjf
         FMQsio/GJMOEhUJp9kFcEoko/YtRvBoKVyaSpGXf2M8bKg7ykx3QtmgNt8ErFFkEugeK
         NvlOv9GNNwZPdMu6H7FVsI5ZvRLP7r0ofWDmckQdK4om1mAsvekWLOKJrCDLtzj7q3+y
         l20Q==
X-Gm-Message-State: AOJu0YyhpN7jU3LaOc/5tZAsd5xmAztdnW5gjCaeLy2iLF32RH9YZ15U
	P6HbVz2pSlTmDpgaITrfb5lJSaiPEqM1H1EqExfVIeZW94blmnnOTAI54/hNIz/u/sc=
X-Gm-Gg: Acq92OHRBIE7kEBTOiUJ204bCLia9u9kFz3ELhM+cuSgR84+kF/H01598M/Qgaw1ueq
	fp5NlREdY5AbhGzpSzrfkZSgh/fkJSMEaoMXueqQZyteXzel+S3VPXGnOjKSbdpW2bVjs8Vhaa4
	g584GxfA+97R6d4DPN+Z4SZm+wmEeWt5sKLBh2Gy4YBN3sqRf9+mWOGMePZu/zq+CKvFBLGcU6t
	Y+/nh2RETDwefothYML/ZfsxGBMZEzXT7nTRuWU75ZgUh1KjVHHigVHdUq8xKEvU83NorrLJP+2
	wgnijCYlk7JxChNT+T/zERnN5K8Sk+9jwPmZrN7b+fpbGfzuxUF4dqlB35x2TuIZXcfFFs+Qhuv
	xzffaqDvkt3B8YMpcXYyjsN4uHAP0iSI8zgnetTIEVO4t2z/cw/BpqLxbXXzAOU+7Vn+7QfXqVp
	4B0ZyKTTP6zV/vtmr+mp9rnUNa+vyTYc3Xyu6kWOha4iSwNheRgs5GzGO2tDlPZaWYD+p67kfqT
	1U7+GYXKUOdJJ7DO26EmRmh/1cX
X-Received: by 2002:a05:6122:3d0d:b0:59d:ac8d:e130 with SMTP id 71dfb90a1353d-5a6e814a73emr5665495e0c.9.1780593579925;
        Thu, 04 Jun 2026 10:19:39 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96413f5c578sm5389591241.1.2026.06.04.10.19.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:19:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] adapter: Fix using case sensitive strncmp for pattern match addresses
Date: Thu,  4 Jun 2026 13:19:33 -0400
Message-ID: <20260604171933.129638-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When matching discovery filter pattern with addresses shall be
considered case insensitive since its binary format that can be
printed using either upper or lower case for the range a-f/A-F.
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 755c53119e32..9298eda8f3e0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7316,7 +7316,7 @@ static bool device_is_discoverable(struct btd_adapter *adapter,
 			return true;
 		}
 
-		if (!strncmp(filter->pattern, addr, pattern_len)) {
+		if (!strncasecmp(filter->pattern, addr, pattern_len)) {
 			*auto_connect = filter->auto_connect;
 			return true;
 		}
-- 
2.54.0

