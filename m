Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C9032142D
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186135; cv=none; b=JuEQL2updsCblBhsd+ZUSuXuUUhzYpheyWgYPmLphnftrCKAfp+LB1H2sE0Ej2dqNrHU5ROcdZU2q2cYBbPvPCN6E7tlrbJGZS+z5RWpfHzBOqKR4vJ6rcuW+Xw8kq7TX86AjUtOYi1DzuCRW3pjjOFUa8Fz7v2DGtoOshM1kMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186135; c=relaxed/simple;
	bh=7QS0zy6P6KE8wsZqEh42z4mB2bb8WjKS5jm+x9BVM+c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=k6IfSa8GhfRafMl7v30ariPig708OUXDWzt1s3Y7Uj2o00FzCvD50MFzXdWJu95dPklQ4KDn3+Z7arqVs2VPCfnRrE5JM9M0cNABB0RUkag4F5FPpoJ5EuZRJQ69WTPWhYMKyn3ojCqzGfKVlMeoO/i90gxYikJWRWeMVcwRc1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6VKFNG6; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6VKFNG6"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-89018065338so819078241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755186130; x=1755790930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AmVQNzJsDusT9sEYsx4I00zyg+pWYoEDYPMld1C8cts=;
        b=H6VKFNG6xr1rtwE22Bf0SCHJQuI5pm4l13TXYtIm8+g+4KhN4vVajh9Cy3r4poq0zJ
         OiQl+fwvYZvwRbWwJvvu3p+qNIcqE2jkFbGCk2GCoR+PqaTaEzfF0810QjBbxuXqY0kZ
         ejhzU/uQ1kj7W+N+/tJa3bFNIwGRUOhov+FlFD2qzI2u+vpn2y29U2dUMnHi0VAL44Yj
         el9It4P+t2i9iHYtWSyYz8wjNfg/GO/fh29oWccOrGM8ahwv48jWOU3WDiKW2Xzbuee6
         qeR+OB92RO7IAbLBUxjXphmddZ8B+iUEWBnnIuIE+paoYYMTt1BtEf3uUTTkmHbRbItv
         fCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186130; x=1755790930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AmVQNzJsDusT9sEYsx4I00zyg+pWYoEDYPMld1C8cts=;
        b=ZsUYvQPUODLUYKGGym/DsJsTGGA4wMnRHBTb8G7Ui57ive0gUigqDitSyYC1U0EFFc
         JfBVfwvBkqNRWHqsdbpDcou4koYjckVTHuYak9W/wPZ+/yjH5j544xXjsUNYm9xAIBKl
         bP7wiFznKbUJQjjk2vF12lZsSj0kzRdLem6Zp7AcpyTefzqNbrXrQwjFyo8ZlzCARSPS
         7M96UUfqUM32qV/EF0V9+hU5zJczDx4LqZy/ir8Svbg+cPWnlH99s/yCUHj//tek6wZq
         R7XlLvTAv5kjEkU/uQyB1rAWugDRGUXPDFPBdxEQ1KfcWXDdlY0vHDpvULeKbZ4AF9by
         MjwQ==
X-Gm-Message-State: AOJu0YyfaudFWruiUFjEO6Ap3qvRIYmsATt/Egni9+EE+qNOjO35kEpX
	1XV8J1Dxpxq32CDXAaPk0NheuT61fvcJVqxm+8veQ7M3Dw9U8djXQ89xdC1bjSZ/
X-Gm-Gg: ASbGncuLLwjbXixs0yyQN6n1T124X41lIUMukgtYn2diwU/CcuGiKe3WjvjG3M26zfQ
	Q6B0280nyMMig29leZNm9aaECJAKDjF5cV4uG1tteXFMU1AtQu2fkjExecuBTP+hRDR0LySTqaf
	mqay+yLEhHtDM+ROyEcD+xxA4C6gK184qLCFn6R6w+C9n/jpTwlOn2zhJMQCPAzzWWXazWsr0Mw
	taSzu5A8mkWGJqxaDnN1FVW63Tku6d4wG/lNOzJZMmEh1QwJH4vzEgjpobwLywFdug++fCyQ2Dt
	Mi1ZiNwxt003QDd/jULiMR4ee4lrtDwUnFsmJCherzYO3hUW2PiGXZ9uHs9V0Ees+1hySiDJGOw
	psuOrTgHAd+W+crxttqZ0cgh1P+Oxs2YvUH02lBM9jHJL1JUVOD0K1muQU3XMhJ+U
X-Google-Smtp-Source: AGHT+IGRY46rkv+6s++khjHZDgRPIzp0RkgbC+QN3/F48U/Sz+g+TocsfC5WUyHcd2VtpuSekM0Gbg==
X-Received: by 2002:a05:6102:41a3:b0:4e2:a235:24d1 with SMTP id ada2fe7eead31-510590a3d63mr1484376137.4.1755186129596;
        Thu, 14 Aug 2025 08:42:09 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-509aee2556asm2163350137.22.2025.08.14.08.42.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:42:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor: Print unacked frame when releasing them
Date: Thu, 14 Aug 2025 11:41:56 -0400
Message-ID: <20250814154156.8221-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to print the frame number of frames considered unacked
(missing NOCP):

> HCI Event: Disconnect Complete (0x05) plen 4
        Status: Success (0x00)
        Handle: 2304 Address: XX:XX:XX:XX:XX:XX
        Reason: Connection Terminated By Local Host (0x16)
        [0]#102132 unacked
        [1]#102137 unacked
        [2]#102139 unacked
        [3]#102141 unacked
        [4]#102143 unacked
        [5]#102145 unacked
        [6]#102147 unacked
        [7]#102150 unacked
---
 monitor/packet.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index d259bf9e9a25..ca7eaea21138 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -240,6 +240,14 @@ static struct index_buf_pool *get_pool(uint16_t index, uint8_t type)
 	return NULL;
 }
 
+static void print_unacked_frame(void *data, void *user_data)
+{
+	struct packet_frame *frame = data;
+	int *i = user_data;
+
+	print_field("[%d]#%zu unacked", (*i)++, frame->num);
+}
+
 static struct packet_conn_data *release_handle(uint16_t handle)
 {
 	int i;
@@ -254,8 +262,13 @@ static struct packet_conn_data *release_handle(uint16_t handle)
 				conn->destroy(conn, conn->data);
 
 			pool = get_pool(conn->index, conn->type);
-			if (pool)
+			if (pool) {
+				int i = 0;
+
+				queue_foreach(conn->tx_q, print_unacked_frame,
+						&i);
 				pool->tx -= queue_length(conn->tx_q);
+			}
 
 			queue_destroy(conn->tx_q, free);
 			queue_destroy(conn->chan_q, free);
-- 
2.50.1

