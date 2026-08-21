Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1930376BDE
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787334340; cv=none; b=HtCKQdX1Mbpggazq77azh33SNcZ/NrOn2vpG6XxoRg7+Zp+fGuLC7w68Mz4F9rSwy+NRKR+1WFTPawqbtWPaJNcKOav2JgXEdvwnUxYgC/UtxZvmNCRhvToTayv+F+CJUfe5b3+xSXLzNAw2qyFEIZHMqs2U4IJ1HD212FDDQts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787334340; c=relaxed/simple;
	bh=YrVJFMdX8MrXFmMgpegL+4Roa/MAxP3vv2Uu0rJmzfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WAQidB6bJlQBhNeJj/nePbEeIM4INGTtZQDMm7+FuhHfSrFKiWJzQ29Awv9MIpupqc+E0J/ByD17UO60/jlw3EKhWzZD0I4b1qEjQOrH6w/YXfOHLkiISrag4tWVk8KjIJCB3m4RAkvY0flFl4k3j/664nbaf2xol7LBJg5ammc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BejvRPqo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BejvRPqo"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ccdce28edeso1731755ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787334337; x=1787939137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=51LCH1dFImHI7IDGxG8+NIuNisCwMvociROcN35k4CE=;
        b=BejvRPqol8X5QIxgToKsLIX/Hruuf1h7ZCRh+orrZVhLv6SqKq2G4UDwk41camaw9M
         JZPbjhveSPRPJM3/Iapge+sv+bA5s9Zq7hhjIF/vdZZCW0xlnZ6KEd/6yPEhxw0OE/k9
         9A86e2xuKPO/xAEVYpWIV4EMs2CJkv2h4hamS2JfVjOBqtz8KS6p3yQgwYG5LXkvvl0v
         CBzVQp2Htht2roP87BIg2KqrccNN8WW+m6PlXL+4hpumlh+LFPkR3qlOCjYcLPLsB8Pf
         rtbTTVQaGtwtnCxWXmS+kl+XPRgVg8z8oUhkQCAekTcGU+QJLrH9Az5rBkptE5D7OJcb
         g/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787334337; x=1787939137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=51LCH1dFImHI7IDGxG8+NIuNisCwMvociROcN35k4CE=;
        b=XECPxccLuqy5QTuFTRKCTBoUXjb+CwEGrsTkouuw1Hru16sQR9SLBKoIWMTpXiw8Q2
         f9YMU/9NDtTsOyZCUvheUsZBLiVvpbIdeCG5Qzcak7i3ehZ0bwT9pPQGMD6OxXzsU+eB
         rgpaRF9Sswf/NV1Ugy4CGp+pyOOsvt6xFFv4YEqqVQi81a1RN8x1AdZ0DEjobcVBBP2f
         bvfG2jplgSuTRE4xQ1rNvEylNW+9ScNsHZmkZuGXodRqFzvrY8rdUsCohASKorvf3gUh
         NAwwj3jG+3XBxG+TFwnlJhihMG8DzejdpoAQbEZ6gJ4JXBzo69bauYCEA3otwzBf1LqN
         cs0g==
X-Gm-Message-State: AFuF++mKeIQRPF6+r8JZK/YUAgHWuPKZM/66HnCXnl5zw143LgfwKA5k
	vXegT1iBcQCn1O5CIZRAcsFWEGgOD3yNBTii0FSGGXKD6ES0imGobekT
X-Gm-Gg: AR+sD112SAvVZI/ykXHG2AgTxS+YbLSqVKrEYBJxaCf7SRsCNykV1lPwEce51SFr0/n
	cQ3UNBvq2T15ZDBvQlyhjW5lTk16lPGhK4QphlrbIo089qTcRLvjhn6qOArq71049E99apNvJxt
	b5/VUbA8N5hqvdWQsadYX7ReaN0d7G+KzalOyedmRDiQc4K2uFg/rDTDzFkNayMO76q4+7R85jQ
	Kot7v/PRpWcZW47nKHUJx/tGuiEXR3usZBY2+/MhJgsU27uUGPTvUqeYJOGOOTrOenqOAUMn8Ai
	BOD5CxWP976seAnu8yWYsPzsjVcxbG28I9R+N530F8CP/06BtoGtI7/DTsIjYIoJgJ9an2Psjp/
	9Tf/gMCwLuU2ipR2ePfawlPGRkuP4hmiBNKr2QPM+kQdrv4JFQnJBnH3QOf9Ct6DF4q3vv2+0SB
	cFb0K+qWlRwAETG3becbLqpiUw+Ycs9GtV293n/Sm0gSxHtQGJ6BggQF5wQ+MVgu0Dn8qGr78mB
	Un6pkNA+7Kegycm9v6g7+Fup45Cb9l7L/oGuR98TtAYM8TYZSsvMnY=
X-Received: by 2002:a17:902:fc4e:b0:2d3:aecd:51f7 with SMTP id d9443c01a7336-2d64ae3a7c7mr74505665ad.1.1787334336545;
        Fri, 21 Aug 2026 10:45:36 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae89189sm27832330c88.14.2026.08.21.10.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 10:45:35 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: RFCOMM: serialize session teardown
Date: Sat, 22 Aug 2026 01:45:14 +0800
Message-ID: <20260821174514.3034851-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_kill_listener() walks session_list and deletes every session
without holding rfcomm_mutex.  A connect task holds that mutex while
rfcomm_session_create() adds a session and while its error path deletes
the session, but the unlocked teardown can still observe the object
between those operations.

The race can proceed as follows:

  connect task                    krfcommd
  ------------                    --------
  rfcomm_lock()
  rfcomm_session_add()
                                  fetch session from session_list
  kernel_connect() fails
  rfcomm_session_del()
    remove and free session
                                  rfcomm_session_del(session)

The final call then reads the freed session and may corrupt the list.

KASAN reported:

  BUG: KASAN: slab-use-after-free in rfcomm_session_del+0x15f/0x170
  Read of size 8 at addr ffff8881019e9b40 by task krfcommd/87
  Call Trace:
   rfcomm_session_del+0x15f/0x170
   rfcomm_run+0x16d5/0x3de0
   kthread+0x2c6/0x3b0
   ret_from_fork+0x36e/0x5a0
  Allocated by task 96:
   rfcomm_session_add+0x9e/0x300
   rfcomm_dlc_open+0x8b1/0xdf0
   rfcomm_sock_connect+0x34c/0x530
  Freed by task 96:
   kfree+0x131/0x3c0
   rfcomm_session_del+0x109/0x170
   rfcomm_dlc_open+0x9eb/0xdf0
   rfcomm_sock_connect+0x34c/0x530

Hold rfcomm_mutex across the teardown traversal, matching the locking
used by normal session processing and connect error cleanup.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
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

