Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17F01AED53
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434247; cv=none; b=O1W4F+ZwqG39/rXKZGuWmFj52+ZJl477tab73JuyNxLC7h//whU4avBq7ozQVShrc1sys0fz6BvC1c4ZPihEg1DnPW3mNt7Nd+rw2JH0ydj0sqZA6AYGxsZaOHtDxjkDTixGUhDFP7+ss43TQ4hDa4HelIm9Lrt2tTeui2uP3qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434247; c=relaxed/simple;
	bh=o9h6rsB6ftlMwOh3AU0PLDUXJw3KUnf8i+QIUM3JGPk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3NeHLDF8ReMoPh/FU9hzn3u/IRwPu+Ex0EbvFqtu0yCqELFtwUMcEyJNYMUNW5Ti5J+j9m4Oq06sm02EAzOSCATHKTV/07fgERY1eZRFkQurF7dGvYD0VQGN2LvpYfxmNYfhS3+YqKL9OguF0jLuVzRuGeHN1v4J2c4zhaeS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EL6c/7WF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL6c/7WF"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7ac449a0e6so468459066b.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 06:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722434243; x=1723039043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0ifOWpXPDm976yezlya2rMJUdCbb/i5qM7P0W7RaAQ=;
        b=EL6c/7WFYORXTParNVRAhyWmaSoWPUQidB39+KpFPq8mjQ++cV5pQS6S2vCcdbexsV
         As7/FHYkOlnlSdlAfEnxedPuX7GrfcHbCG/Bbd2rO5Srm1ccyNcm6d4qWTtUj2/fSOO7
         1Vgh/8kLVeNCN+BfXW37vVX0JZG79B4/1Z0A2E3eN8OSa/sLBwFJo+lAl/E9qh12w+Wj
         bVFo4grkfh7EuPkTkcP+6UC2C7l05aDEsyRHEEOhSnKggGj/4L7Dow1ucCaVu3dmaDyT
         QkhoVnot+bAfqWy1A8k3yeDIEk3P2sgxXu7pqbDb2VZzBLe3uahuA1SQGCgQx/k6XAlu
         9A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722434243; x=1723039043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0ifOWpXPDm976yezlya2rMJUdCbb/i5qM7P0W7RaAQ=;
        b=PcinfnyI4HxXlN5r610crko3hDG0Kqi+upWeroA6u5k65pJRJzSduwAekiHGZ4tBdV
         j1bmLSKXoAHd580NO2N2GpS6ZybkM+xAs5I5g5WyqgGO8RljLhWuWO1zrZH/LRlIieaD
         qMrRl7OqiPNF/JTS/UpRKOHUTiI3QIA/793++FkmPV6VEL036xWtigySsbJsx8abQGgr
         ql3j78LHJl9nw5+owNBkgDwBkskSTivAh9ghFva0L8oBKDYsTLRfe5418cvGLTfu9WfC
         ftjTcNojCw+jYmzThAnvKcn8UOWr9MlsZgHF7+YL6xX/VZHhSxzEmTpe/wMGh38lfoQh
         YomA==
X-Gm-Message-State: AOJu0YxP2CbXkkjyzkirimCqLhJh9jvBeCgfwRYBR0H9/0evuFSimmsv
	GZVXKeZbRgOx1vSjV+GsOCb12r90ZSda3aXhNjk2WMR6bs4P7ak4ckODeFaa
X-Google-Smtp-Source: AGHT+IHvL+tr30XPCHAjidjtWbrNnOuOMAKVkdYukfXGbQaCPSyariodtx/U8WYdDU2gY8gbvhxFIg==
X-Received: by 2002:a17:907:2cc6:b0:a7d:4dc4:3d8 with SMTP id a640c23a62f3a-a7d4dc40564mr914847966b.54.1722434242842;
        Wed, 31 Jul 2024 06:57:22 -0700 (PDT)
Received: from lvondent-mobl3.wlan.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad91041sm779143666b.174.2024.07.31.06.57.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:57:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/4] monitor: Fix crash parsing notification
Date: Wed, 31 Jul 2024 14:57:16 +0100
Message-ID: <20240731135718.429604-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240731135718.429604-1-luiz.dentz@gmail.com>
References: <20240731135718.429604-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following crash caused by notify callback being NULL:

Jump to the invalid address stated on the next line
   at 0x0: ???
   by 0x1E8375: print_notify (att.c:5420)
   by 0x1E9464: att_multiple_vl_rsp (att.c:5463)
   by 0x20D39E: att_packet (att.c:5637)
   by 0x1B2054: l2cap_frame (l2cap.c:2567)
   by 0x1B4A4D: l2cap_packet (l2cap.c:2708)
   by 0x19AD43: packet_hci_acldata (packet.c:12522)
   by 0x19CF07: packet_monitor (packet.c:4249)
   by 0x152405: data_callback (control.c:973)
   by 0x2204F6: mainloop_run (mainloop.c:106)
   by 0x221017: mainloop_run_with_signal (mainloop-notify.c:189)
   by 0x14F387: main (main.c:298)
 Address 0x0 is not stack'd, malloc'd or (recently) free'd
---
 monitor/att.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/att.c b/monitor/att.c
index a23347ef7..73a616584 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -4646,7 +4646,8 @@ static void print_notify(const struct l2cap_frame *frame, uint16_t handle,
 		frame = &clone;
 	}
 
-	handler->notify(frame);
+	if (handler->notify)
+		handler->notify(frame);
 }
 
 static void att_handle_value_notify(const struct l2cap_frame *frame)
-- 
2.45.0

