Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370351356F
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748065; cv=none; b=RkG1/NPYXYhFEZgWTJtcI0uKXmkWMsm6DFJRglFtiefXHOJXKZKL3IuadcclhyUHEBcf5UA7uA82CjCKZo8M2Ts/fgbs2GiBylJxvA/ZcvmrB5GTNTB9CgAtg5Y/N8c3BlE0/aC1yQ7hbUdvOV3ZeRhcbO2gPOlv5xR9iWW7Qrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748065; c=relaxed/simple;
	bh=T6PT8/hto4WUHgjxhQnxdA5b3hlGibBeBz2AGGyaJJ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcnsWRzRh+KXVZgQW31jfVqLnlVPS03VFlGZgZF9QxihKBwCEKztHWdklvfEKuSmXdm84i8IZoUD3Z50Biq6Vug4KVblEdVX6lOU+wQR16Xt5X/pLh4h92uwMPHk6JlliwwqXxuR5quPYoovzsTiUSfclafj/vF9rq3YyPrPnp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC49uYP+; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC49uYP+"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e96a8ba8cso557170241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 09:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789748062; x=1790352862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+DHGBi6O9SunASTpKetU3oAQaln620g02QEvfaXeEVU=;
        b=DC49uYP+HbAle2VKtk1TNdVKVORaPUOhqYTh+k0pDQT2EluzJ9FkrfJ1lW6WXlrmPa
         RwMrKqX+hXZrorOL2ZLePRYP7n+7jtJpZPHSxt7D2fiIbU/QAvsqdWK/EU4Hqym09HhI
         0BwyJbtp6II98VycRwx0ZqacmK4w8gpkQ6Pg5DN/AuEuBR14iDhQhKHCMgFPLQwT5yAY
         cCwoHoKWnxg63I9KGhnWH0q5U9gLHO/xF7vekRJmlUOF5iEcrRIPDZeuowphhlu0um9s
         N6Ya5ME5PPadywjWk9qDXhlRbGepU6+1g+v8V7VTuUPg1CcFvS9zN78NMiiA4Qb2jHQO
         8qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748062; x=1790352862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+DHGBi6O9SunASTpKetU3oAQaln620g02QEvfaXeEVU=;
        b=EDZdfptoTXk6qiJlHSC6D6SxPzJpKiDcbm7A/SXycpSa8qZ+fXQBI3ts8vJivU0aIe
         me2G66gnFa14/HKEutd3EfBMW32gMpWBCAA7nzlW6UjueNZ3IdrSYxC3M6uQe0byVeGJ
         LBYVQNj5n8++Yfv/1k7Cubm0GcbEa1+u4gZmRImPzcS/mmp8mqgbQOgW4ZNxLMqnwL/a
         Vbsmux2PEJxfu/wtA55CYn4fsauusu3ZVNxHRAWcXrLbzDudGfBmD5kwAHZFKKdWdX1b
         26O5FIs9SkTdbOBN52++w+17kLeTOIG/NoqB3FIZc2VjbFm7O4LPpcrU8PLG5ggcLWkt
         ZKjg==
X-Gm-Message-State: AFuF++mSQyhO5oCg/Lxv46NcgAEUMRCeVd8N7L8lWq2pOKhTlwYX2RDD
	AVS6+9OZDb1VIDhWum5FqeV8yIx4VAtXABxYXLw9xzRP+PAGJMuvkvU+V5ukUU2N
X-Gm-Gg: AYBFou3mW9UP5GBoZpWk017vnt7CdGF5Gv6tVwJfSpatrLEjvbUAlRJNAZfkQC/95SY
	TiyT8Nk5FjfSbnr6zp/6u4vwhiN4xnIIBoQmuA2I29Awrt5yTIqepr28V7FmY7hd+Q0EhcGWBlQ
	1dN6dzAkt+DkWlZnJrinXiwehn0C0JQRYV9RjG1Ed6YRsEmqhMswkehCK1o5zyWNWLuyuuWTmtO
	1EqS9P1DawS3cFWlyv2zHqm16xE0oBD+bCCzrT96ZJLG0ln0s5FsMcgaEICF3RAWmowAKmX+swt
	MnD/BLDNjCxwHc/l9ZkZrOdw/TkL0paV9mVB0nqUoz8+UGFo4wmetRLqMA6ZAUCrdacO5Ogy9tE
	nUVmE/3+7OE+4jFcQMEupf0mg76M9m/GlR4KJhxbee1+1gAa6H3lfvDfObpxVvS8OSDcY9PeXbF
	3OFdrsUmjxkGTu2QtxrsAv3YH+vSxw+gqcKVKV3aoNYd/kCOQss2V/7KZzDLTAT6MXtYUPidIoE
	gz5LrzJzx+wotgQnR5Wve83Db5z69bmZtkjq5bXUsXkl4bJo10t0hHjNSs9+788
X-Received: by 2002:a05:6102:8605:10b0:7a5:72f6:3a0b with SMTP id ada2fe7eead31-7a572f63b04mr864672137.14.1789748062207;
        Fri, 18 Sep 2026 09:14:22 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a59c569181sm2104078137.11.2026.09.18.09.14.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:14:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/9] monitor/analyze: Drop a trailing space before a newline
Date: Fri, 18 Sep 2026 12:14:02 -0400
Message-ID: <20260918161408.2464981-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918161408.2464981-1-luiz.dentz@gmail.com>
References: <20260918161408.2464981-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The count of control messages is printed with a space between the text
and the newline, which puts a stray character at the end of the line.

Assisted-by: opencode:claude-opus-5
---
 monitor/analyze.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 154303eb7330..8b11b64ace15 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -500,7 +500,7 @@ static void dev_destroy(void *data)
 	printf("  %lu vendor diagnostics\n", dev->vendor_diag);
 	printf("  %lu system notes\n", dev->system_note);
 	printf("  %lu user logs\n", dev->user_log);
-	printf("  %lu control messages \n", dev->ctrl_msg);
+	printf("  %lu control messages\n", dev->ctrl_msg);
 	printf("  %lu unknown opcodes\n", dev->unknown);
 
 	if (dev->num_cmd_rsp)
-- 
2.55.0

