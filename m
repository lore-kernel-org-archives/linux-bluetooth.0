Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCE32BEC5E
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787411198; cv=none; b=Hl7zYW6rMRKTgkDSzCLa7VTh1rYULZ4EZenIkgS+zqUnIY8xPJOd3VwozWdb0Pr26sIBgib/QAMyIMzuisImCie3MdCDQTyET8cQ24h8Cy58N3t2dyS3ViuUUbjWq59SSauOpellxDHTNCglFT1winz69XySQZWjfUtnYHywnTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787411198; c=relaxed/simple;
	bh=E2rcnygBGLQMU35xmqHIb/1ttJ6wFKWjkzZt/LwA7O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aIjVY+Tbk3/dZdimL5o2147u0BUzItI5L2jeRamcMGVZjedX3UftQ8I1heOrgnufN/2EFkMxOT6bH3ZE8R3SVv7SCWpKnOZNVoiRoco75DBJwNWo7I7oW4v9PSYEJaLdeqF3eUEx/KwBfh9+CH3wDwstBUDiWgkxzNOqaE+jd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kL6NXqWC; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL6NXqWC"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66c70effc23so229928d50.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 08:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787411196; x=1788015996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rKgGlVcx92xJ7O+3f3QvGBGuWZWQmGRABTn/2Re+yLY=;
        b=kL6NXqWCz08lC0NqH5iu2eHD3sfR5oqGRnSTTZ/NYYglUvuqkgiu1teN1IIOScfbkE
         Jage4eGvykuX+hM59ujtJ3SxjOXRxJM7WmUg7WQUUORRUOA1Re5h6p8vvdommlsmC9bv
         WlR9r/p4SltTsYyfOaYL+5tuT771uJ54DdTTP9z1O711LwOeB9l0uJr5JaSj+bmbSjWV
         BXPjpe7ruOP6rXchVgbMfkKLh+3Zt3BgwjFlPY1BuozyZv/IwpDLRvaHklOcz2npZDXf
         +xRNOPgXmSMv19SutXrczXXm8ZDNsVzJPSAcmVVoNgHvq4KhsfXelQJlBG96MAl2HPNo
         4Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787411196; x=1788015996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rKgGlVcx92xJ7O+3f3QvGBGuWZWQmGRABTn/2Re+yLY=;
        b=MVuAmnhpJGU1/mXVuPGN8mriaotDIRSeC6Kc8yC9ypfYv3A2/0CA2c3hOrPvymMMYD
         UAgseIddyPzqK7DAIGqEf3eKPscVcGmJarwDvHSwiA9zUYAAgIpGZ9GGTLEPcpGZx6se
         krWE0C9sdANOGXCIo3xcSuBvhfn7y97uJU9X3Fn7glaDPzosniWr+N/LPad9kbbWOb0Y
         l2dqGl/zFTbjJr7VhFMH27YClzRcGw5bDiqO7MdGbyBgNCN1YkXDr3P+bhvMwx0RvFQn
         sGDShBzMNGhJ/0LPnST18dq2UpL55dBf1bPoub0Wd+zu3Qc0rQ3d2bPmN6Vf32n4BSml
         7jLw==
X-Gm-Message-State: AFuF++kPw50LCi4m9hJ6/pQzCE39jVDgfhNhQhxV6eDFwCj72rMnQKeq
	TLFhC3dA6vq+71Vnc0cUSeBuYTkjTdh0c4HnBkK81kp3T09WkolJmlRh
X-Gm-Gg: AR+sD1227FeXAwGpi/bIezvFLiXLUK4++Fo0qpimYdM1VjW60TssRgqMHunPgSiwpuf
	oF4Oczbz0nKEmziY8deTlIH+O9EUufQSP56yAl28dSoWe2yHqEVDy0eiP/Yf6JBMfBAvJuBy9vA
	Mt6DHf7oiOFnJFe9Ta8v8MKN+qm5LXC1JuCjpvAxyE3oHSVlazMSeXgNHA7YgFOdqzEY8b13r58
	jrSBg/kNAtxEF9sdpf9GeSqySTZRLq1QV0ZtRvk2imkybg9ZNGHJgzI2ZnKG2FrPZzrIrumggLg
	HX2VOAu7SwCleQhkWH2RD7thORteEjRbVcCkf4Hd7wec4e2QFYQmtGkQoIZJ2vwGsYT7sA1W3yc
	PE6dfPOo9P4binLvxlDRgzrqj8dCKkW/Yns6bhP6gXKQXH5bU2vwrDNcuD5IFE9Uks+5xBl/c9F
	jZ38wEB/ZEIVr4cRruL3q/Xpt16OOl+23DLKNLrjoCiQkNRc2yzJ0Lz2RwZ6UhzCXVuvGV52xqj
	s8Oh/Qj9i5rYZXj8TDi3Gy0cQWdv9shEMCJd+grBuzVNlHWClvujjI=
X-Received: by 2002:a05:690c:b96:b0:81f:45f0:21b7 with SMTP id 00721157ae682-849ea4f7f47mr64125317b3.0.1787411195669;
        Sat, 22 Aug 2026 08:06:35 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cacac521asm11239257b3.48.2026.08.22.08.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 08:06:35 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Jiale Yao <yaojiale02@163.com>,
	SeungJu Cheon <suunj1331@gmail.com>,
	Ali Ahmet Memis <ali@iusegentoo.com>,
	Tim Bird <tim.bird@sony.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2] Bluetooth: RFCOMM: serialize session teardown
Date: Sat, 22 Aug 2026 23:06:19 +0800
Message-ID: <20260822150619.3684599-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_kill_listener() walks session_list and deletes every session
without holding rfcomm_mutex, unlike the normal session processing and
connect error paths.

Under normal operation, an open RFCOMM socket pins rfcomm.ko, so
rfcomm_kill_listener() does not run concurrently with rfcomm_dlc_open().
However, forced module unload via delete_module(O_TRUNC) can stop
krfcommd while a failed connect is still unwinding.

  connect task                    forced unload / krfcommd
  ------------                    ------------------------
  rfcomm_lock()
  rfcomm_session_add()
                                  delete_module("rfcomm", O_TRUNC)
                                  rfcomm_kill_listener()
                                    fetch session from session_list
  kernel_connect() fails
  rfcomm_session_del()
    remove and free session
                                  rfcomm_session_del(session)

The final call then reads the freed session and may corrupt the list.

KASAN reported with mdelay() to enlarge critical window:

  BUG: KASAN: slab-use-after-free in rfcomm_run+0x3802/0x3f00 [rfcomm]
  Read of size 8 at addr ffff888111058d40 by task krfcommd/79
  Tainted: [R]=FORCED_RMMOD
  Allocated by task 86:
   rfcomm_session_add+0xa1/0x300 [rfcomm]
   rfcomm_dlc_open+0x8b2/0xf30 [rfcomm]
   rfcomm_sock_connect+0x34c/0x530 [rfcomm]
  Freed by task 86:
   kfree+0x121/0x3c0
   rfcomm_dlc_open+0xab7/0xf30 [rfcomm]
   rfcomm_sock_connect+0x34c/0x530 [rfcomm]

Hold rfcomm_mutex across the teardown traversal so every reachable
session_list walk uses the same serialization.

Reviewed-by: Ali Ahmet Memis <ali@iusegentoo.com>
Tested-by: Ali Ahmet Memis <ali@iusegentoo.com>
Reviewed-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v2:
- Rewrite the changelog to describe make clear trigger: forced module
  unload with delete_module(O_TRUNC) and temporary delay widening.
- Drop the Fixes tag.
- Drop Cc: stable.
- Add Ali Ahmet Memis's Reviewed-by and Tested-by tags.
- Add Pauli Virtanen's Reviewed-by tag.

Link: https://lkml.iu.edu/2608.2/10891.html [v1]

 net/bluetooth/rfcomm/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 9cdfea666a2c..5fe2758e8c47 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2178,8 +2178,10 @@ static void rfcomm_kill_listener(void)
 
 	BT_DBG("");
 
+	rfcomm_lock();
 	list_for_each_entry_safe(s, n, &session_list, list)
 		rfcomm_session_del(s);
+	rfcomm_unlock();
 }
 
 static int rfcomm_run(void *unused)
-- 
2.43.0
