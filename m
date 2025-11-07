Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A8B18E1F
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546730; cv=none; b=taLtf3csuuxKEgKvjGPE+DFOeC+wiG7bsc2dHgTaOrQsBkBKcTzwwY81er7yCl8R/o/Tj4C9raRSh3oi9RWCBZ0pkxMj+/mdCoaPA0cMmIAXk2yUQSdWI42BhjwtglhQ7RqaG3w9W5/SqFepDatDB6NoCA8ufsWIB+LAE9m85B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546730; c=relaxed/simple;
	bh=O0F/FNrZmNnpMe5IFdxZbNg6K5fAuO3e19jqCuOByVA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HL0jwU9KHi0Dpo9fJX+l3mo4S422xsFhqbcytXyp1KnvwilZ8qw0ZA853csC89GERRWXbBwNSYWKalg1DpI1KkesCEwXAokuCVsw5wwiFqjl8glr2KtQcGLOYGRMa0uUIgT6XFEeJ+bZDZq7ha4r0iNQDVo5xcLoByatVoDY1os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhbjdgUs; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhbjdgUs"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5598942c187so645464e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Nov 2025 12:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762546727; x=1763151527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6W7PZac9Mfe1GzHxJm4zeI9is9sMdlnZRZRkdeiq860=;
        b=jhbjdgUsGpTlHYdwn+StMzaXDyi8FpNK8ImYGsMZ4apILTv38YuoncXNhWfM6i4ew9
         oayEz5WssqQbKkWQpzItgHZu/xGjJ4kyW+6ASnqrd6ng+pMnOVYXexFDRpFfEvaaX+pp
         4rDb6Goa/w7VeMHVyrCM95+wlFQa1hwi5NWxXndqiwTQGdeX9N2t/DqOJdamumh172zG
         YhYhleZ3nSt/zzpXbheFOJg/znJ8tgeqzEhr5gXeqt8fZhPM1XWk+QjungNuFpUGgupQ
         Ix8pXGABaoyf7QmYCb7wdkf6pwRqpxMd2yO/RLqRnG+wSwdelHGRl3GDf3UKZCmthxNL
         +O+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546727; x=1763151527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6W7PZac9Mfe1GzHxJm4zeI9is9sMdlnZRZRkdeiq860=;
        b=fYRJWpK6/RzsZVZT0lgihx+qrWgenR2yvPbiV8IAwGVBYNngd4wnTxEWOIcucLh2nZ
         Y50VffSKloF5V4NTgCSMT8/NHr19vwC5tRkkY0aNAqTzMKK/z22ik/JxOvVMZOePwsgj
         csgWqaIpxXMqDek96WW9FsWz8VHqKuuZTCncc4Pgh9NXcsReu5Gbs7XGqnS6uUseqks2
         FK7IfeWjdhr77DW6/uUYW+VZyxKpPFIVnJvSFfcfyDQqopGeM9suRA3ebyjo7hd4FhgA
         9b6xaTVvXOlkwf8hPvht2GbYum2kHW3GtoZwAHnyxXsd1qU+r13iFb6bR7MqOmD/ww2l
         Zoug==
X-Gm-Message-State: AOJu0YxENnEmPrAPKqKznBESoU9ULigfrjN74D5i586BtuK7zIT+bb2V
	rhHjVgh53oj6lNhQ9SM3QP0QRZ43l8nUd0YzreQqbhc4Z90mMDpXa6AtwaqXFQ==
X-Gm-Gg: ASbGnctKC70FckekhpWPXYhEu+Wu/8sS4xMJs+IaRiz8yVGZFRakAGbDbC4Jj3JkTob
	ZTqc9fVB64z48EcdGSSRwgLvqE7+mdnUsLwVuYOaITeK0G0xKNnyyKR66BE+hGu33sDlv7NbBkB
	UgdhEVl8STp4UUqZJGxJ5wY0tVZea160FDw8/T1e8C96kXL+EhAi3QgRIilYFHwgscmx95C4TNH
	Kz6CcGiT/gl8lXHf7/1GMxwwJYnRvQWz0EgV88buzj1zpdAUPjey7s7NYzbaqBrLtxab3a3h1MO
	7SZxIYeGy3W1dok22DkmG1hd2TYrtYxktZtsVEYzcawlcNS3wlqLJku++NguuhHVxtUVBHDVZ7T
	Uh/YDSjwfCarF2uu9adEf59CUUwPFW1/CLbNE6NbR4inpf/HF/3yYZwJBSrPCy7OYUj/fKY7BW/
	3m/HPPGB93XCXPdg==
X-Google-Smtp-Source: AGHT+IGMb9EzPKpGPE1LXQtmEw0IwoKO9hmWhJoSUm5eWIX+KsUPEeBJ/NDMXNpo5bSJfjjU3ItUlg==
X-Received: by 2002:a05:6122:8498:b0:54a:a2a3:b16b with SMTP id 71dfb90a1353d-559aaf804b1mr871475e0c.3.1762546726837;
        Fri, 07 Nov 2025 12:18:46 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5599582860asm3562921e0c.16.2025.11.07.12.18.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:18:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/5] btio: Fix endless loop if accept return -EBADFD
Date: Fri,  7 Nov 2025 15:18:27 -0500
Message-ID: <20251107201827.1235953-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107201827.1235953-1-luiz.dentz@gmail.com>
References: <20251107201827.1235953-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In certain cases, e.g. ISO Broadcast Listen, the listening socket may
get into an invalid state (CONNECTED) if the PA Sync is terminated
causing an endless loop of accept syscall.
---
 btio/btio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/btio/btio.c b/btio/btio.c
index 1a34927b2353..cfaa9392de12 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -253,8 +253,11 @@ static gboolean server_cb(GIOChannel *io, GIOCondition cond,
 	srv_sock = g_io_channel_unix_get_fd(io);
 
 	cli_sock = accept(srv_sock, NULL, NULL);
-	if (cli_sock < 0)
+	if (cli_sock < 0) {
+		if (errno == EBADFD)
+			return FALSE;
 		return TRUE;
+	}
 
 	cli_io = g_io_channel_unix_new(cli_sock);
 
-- 
2.51.1

