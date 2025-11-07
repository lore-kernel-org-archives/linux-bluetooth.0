Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7B633B968
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541692; cv=none; b=ION0Ij9Yr541FCQA4U6Snsqblxy4CBlHDaFxYUV9/FFDJMFSnZlbzvz2zTKYdQV62YKxOVPzM8GTdimSy1BHJZusiuiM/UKbAuFYncYcIMLdWJktXU7/Ae/vgoZigsrx2Ay+VR776SFWByCZAXjgRIeUJfK8wderO1EjjRrMync=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541692; c=relaxed/simple;
	bh=O0F/FNrZmNnpMe5IFdxZbNg6K5fAuO3e19jqCuOByVA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9rBUpnc6FLJlJPRy+3XeHtlVyKpubRJ10e+FZCX4Hir3DaPTS1utATpjq2MrX22mYUyXtUzfcOGXvqB9VkrdD5bSewAVoY7MVi5pav8m4OcCPqEWiq14FxVnGa9AQ9avTaLU6kG/HdS/KJOdWzrk6Y9iT2wYfwcblJsoHUOsdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiPHthAP; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiPHthAP"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dbcd54d2d8so889739137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Nov 2025 10:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541689; x=1763146489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6W7PZac9Mfe1GzHxJm4zeI9is9sMdlnZRZRkdeiq860=;
        b=iiPHthAPfCOYFhy1RDlrd6Fa+9BFzRHnUYEMEVbMSugXTBbU8/W9dhILaQvidzZ+MB
         HBPZ+tiSV3QERPp0+j9RLhL1H8dkP2+h/WZbcWlyQqR43EeiPtKgIWeBibEhK9Z1VNNY
         wmR84y93iCBhul+sfuqXoMkNVsU6fAK5PgD1cqvcq5uq1i8coF9WSU6m0ZZosQuc0Vt4
         tJcMsYN/+4TqAuPyKADDuwA9sbXlelIf4dXmVqzOfyDzTF/7r//0Uia/CJbj6LlpK6LY
         Cg+wI/Vlle8zTtaWWsgPF9+ZCLE9fYs8i+H75Wa0LCeRuXWnjQMObJznxywCBcYo2ylo
         +jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541689; x=1763146489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6W7PZac9Mfe1GzHxJm4zeI9is9sMdlnZRZRkdeiq860=;
        b=gZDabGVwLqosD2r5jtEA17pg9LP0Wsn7HKZl+n1CtT1h8VVTLyJyhy1HqOWwcd0Qxe
         GGZSDg2XLWIufF2K9mxWLaYyaUdQ3LjwwgwgRbijUNrpKRE+MMSuud+cfo/zDGS8upB1
         33yzQVJh9wKQP3VILyUIEoz98KAk2nAFjnZF9Do3Yzyp1K9g7kLV/KIt4nKBmLBpovN+
         57H8dIeO/7xfIfP/E8FKagITf9ICca3+yJnBlTZb6esHfZV4meJ9yn9cXlkJ89+1rGhQ
         MxCyQyqpRgCst2ydGEDKKzJ67/hy+LB/m3WII4lhd4sjARTjK4oj0UkeMW1nXax2YZtW
         75hg==
X-Gm-Message-State: AOJu0YzqjBiSzUfMqlPm4T2svdQkqa2lsy466euzW1U+ng6njUG09zDI
	9biBFU9c/2iw1pI20U6K8o34OOynAdm+P7XW22bAJMbrqZQBCfDPNBHWdrCURA==
X-Gm-Gg: ASbGnctaK6ZjY1eH08PCf5c0fvkgS6BHcEI2qtHjEt/tZeKYFe3G8MstbyR22p7Gzn3
	BqhwWupvv4tbyj95C8vJBnVs2cER8I/nnJUfXuw/I082Zib7Bo9A545h/8oonubtqVYtXeBoXSH
	eVMo5gvzbmLkjImjE6Rv7CsiRwTfpEYzyK9SX8mIgtTyyIcdDBSXKiCJxWLbq0s43RaJJ3JgTDg
	O0l+d7b0JiEgkjbbA/ngGd4nOypSx8Dy0ff7Oau+1BgiZcMHAq6RtSzOLevuWdHSyd3KXXXw6p8
	7BWL2/eFAxrbqQQuXxHsU/ym7QqHNPsRVVHjL8xZe6oUHPKiblepK78dqu9hByQ/C+flsLW1JO7
	c/FFRf9zVg569aVR7EJVBPR+DePbxyodPXJO/ja5vsnw+c0TmGrgKoh6dMDwwUilLjcajLKNCJ3
	m6swU=
X-Google-Smtp-Source: AGHT+IEra/l5ZlBgr3yeDfUXDVFLyd1vDq42aticE7M8BwDC7FThNIM3xkiu8xqtJa+nQ4vVnsdKHw==
X-Received: by 2002:a05:6102:f08:b0:5db:ceaa:1dbe with SMTP id ada2fe7eead31-5ddc477eb2emr249104137.29.1762541688979;
        Fri, 07 Nov 2025 10:54:48 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93708522abcsm2738698241.0.2025.11.07.10.54.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:54:48 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/5] btio: Fix endless loop if accept return -EBADFD
Date: Fri,  7 Nov 2025 13:54:28 -0500
Message-ID: <20251107185428.1161318-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107185428.1161318-1-luiz.dentz@gmail.com>
References: <20251107185428.1161318-1-luiz.dentz@gmail.com>
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

