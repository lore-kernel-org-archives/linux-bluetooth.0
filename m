Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2741F37B014
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 20:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012160; cv=none; b=lqp634lF/Jn6WijB70krdbY8e5nkMBSjDeSUfWEKDn/r15snQEWYkGUFVDbAVmPOKyoMfd2nMVp9jnv2VXFHxp2j69OCdWRMNLE9uok60g4BRHECtw/BN5XOxHqVtX4hHs/YDO9NUkRpH/Qxf/adDhFPzCeYjOS9FHuDI9F8ZEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012160; c=relaxed/simple;
	bh=qkbp607f6I/AUkFoFFtnoe61oXVD2gmWCRVku6FfD5w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XPHTKZTSk4xOECUtaNTg3UXfl0eXC3DqHpPpGyMikC+uP4CufHXY81Y+nDaXVfinNaOWi+I/Cv4jTcjyv67fI/mHEnJu4Zjxc1FyWSiyrgTe0yj3yhaq8Zo/kmK+rR3JzwhHXfI+wILZdiSXrRgchL/5r+DnCl4KE74MfyNHcZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJKM0jAT; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJKM0jAT"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56f6afbd205so163482e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2026 13:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778012158; x=1778616958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mcw4XNu8GBgcyVUw9NNkwmUDhUeLppeSocHPY3OEB5o=;
        b=LJKM0jAT8pVh/RkDFMB2fKHUSRedS5Vihm1SvBHLQlKxnKg6HqcWYOxggbaWJKYSc7
         1lAwlpEHvlJEUHxlbcgHCr4H3HWNTWGvcMNp1g9hgIIQnt4O1/g0xYetYfZyWTm1/a4e
         3nw/ABs111TIuvgbnPTuHbTRqY1gu/5ivtmj2jAg5O5l+88rDKPaDEGG+N2lc4NDa1OK
         cKxD6FDVeGTl1X2dqpU1/IJh5hix6NYkDQTRrGg1I3HywwXcjKUUs30YEdAiQUoAB83R
         b5oTPlftIYWQX7WNw2aPkz/m4gomoPIS14G9EatphYOB6T+CscDRZrAUecsgXHiy2M+/
         8ULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778012158; x=1778616958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcw4XNu8GBgcyVUw9NNkwmUDhUeLppeSocHPY3OEB5o=;
        b=ddbDJkUydQyxnFoXWTqBqgW+Xpr7IWR2WAltIs6+zk1Kr5Prx+dwwHSD8o8aH8gL6H
         b5qwdyanELhBWDHtd54VGFoukVgAuXoFup0Lsi8cq4BfV9zQ5LU0MMl55lciv2/yDln/
         QfhcrMaDDS79wsG9eKTn0ukAd75pj+oHjmFZr/n2OAfFdaNoisLkXDdQ3CWLFM9uo5ud
         EOp+qU+eka/27cqxNJlB5kamSXnqZBXmnEoOJRcD6hPTBk2ofkOzt6u4vITA19fhq0c3
         mzyf2rcCCXMSI5MbXWvbStC6gVJlk7+4uSciAuXljI6LF3CGMWcxo0gx5wb48zhRXSuh
         6kxQ==
X-Gm-Message-State: AOJu0YwCTI9W2b8+13pytAOzhiapIKCaz034o0Nij7993Z2PkBmA7bzf
	1dam0IC1gMgErD6tqnYBECKhF6clGuQGP0CKZzGzWSY9FsJfD/2DeUQAZhaTCwW0
X-Gm-Gg: AeBDieuKDeEU+9B3fbdoH1ymcqx8lhyz26YP8+2/Xxr8rx/u/lzE77CO+DVquetjeua
	3TIYsqNN7FR5znNGuoP8K/ccdUJ1zAuhh4jXg5BIXrwP7zkbezf+jhd2fzKPf5JYP1bozENtctM
	diD9sJ8+G4v7FnnpLkOVXQEJmp3Fa1oFt+BqDAqcERlUKDjU+v+dNfj+EYv8Go9/p/lag+zv/c3
	LmNaFJ0APSsb1J1rmnsvjJaY6BKMAf2b+gOqWoNQd/WwzVXHABMAbtyjERESYB0ghz3fLTlwJvU
	JyfiZOa+ZXdtSiy+jwYirzzYmuLkp6u5fdO05i32m8Ad66xB8pLJ62i+BRKsOiwRvBBynNi1Zoc
	GW5QCBOrQz1l4Ohq5Suo6X3plavq+W5gg04HT8eGznwFPhZi49vyyEBE26MwBBSQXcTlGL4B5zR
	CCg6gOIpegulFeUnnnhmi3ADNdqFug4/jGXJm101wcW/da+Sg8YR03/4pa2f16tmQ0deLsg6mkE
	dUaxWGHlbTNaotD4KUI/uGEiz+4
X-Received: by 2002:a05:6122:2a44:b0:56d:3451:4cc0 with SMTP id 71dfb90a1353d-575599f6ba6mr269254e0c.7.1778012157818;
        Tue, 05 May 2026 13:15:57 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5749f835632sm8706168e0c.5.2026.05.05.13.15.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 13:15:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] hciemu: Fix crash if hciemu_client_new return NULL
Date: Tue,  5 May 2026 16:15:48 -0400
Message-ID: <20260505201548.1328953-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The following crahs can be observed if hciemu_client_new fails:

 Invalid read of size 8
   at 0x12DA79: queue_get_entries (queue.c:356)
   by 0x118434: hciemu_get_client (hciemu.c:277)
   by 0x1184A3: hciemu_client_get_host (hciemu.c:301)
   by 0x11536B: setup_powered_common (l2cap-tester.c:1452)
   by 0x11568E: setup_powered_client (l2cap-tester.c:1491)
   by 0x1324C6: setup_callback (tester.c:500)
   by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
   by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
   by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
   by 0x133868: mainloop_run (mainloop-glib.c:65)
   by 0x133C9F: mainloop_run_with_signal (mainloop-notify.c:196)
   by 0x13325F: tester_run (tester.c:1085)
  Address 0x4c1e388 is 8 bytes inside a block of size 32 free'd
   at 0x483CA3F: free (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x1187BF: hciemu_new_num (hciemu.c:437)
---
 emulator/hciemu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 01a8e80b727e..bff92286ed45 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -435,7 +435,9 @@ struct hciemu *hciemu_new_num(enum hciemu_type type, uint8_t num)
 
 		if (!client) {
 			queue_destroy(hciemu->clients, hciemu_client_destroy);
-			break;
+			queue_destroy(hciemu->post_command_hooks, NULL);
+			free(hciemu);
+			return NULL;
 		}
 
 		queue_push_tail(hciemu->clients, client);
-- 
2.53.0

