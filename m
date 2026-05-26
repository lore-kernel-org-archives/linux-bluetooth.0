Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916262C326F
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791698; cv=none; b=oLEFLDhY5YtYwX21cqPPLx5a9BHPc1tb/IXKjJbxZGLxHfwboFzKD49xI50QQBopCbTrbgQbKlv/9GERwOokwaHveq8obL5j1XHDsf/0pkYbWCIFPMUgNHaCrfpq24EH9MGrgGby8YB6ktwycUfBGxxGhKBOGBc4Z/Dxs0/P4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791698; c=relaxed/simple;
	bh=qxgJ+dW28XzzRBAVpcCJuH+RNNnTYgSlxLKdicXGkVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PZECjsJEHXT52DcMbNxecc1TP0BpuiRvDeMenn1+/8Fb7qMOOCumwDmx0XAYE6T45M/2T7mgiGJFJzIeuhyJa5IHzSdd3/mX1hT9ayeO0891gJ/07mgDjuEtGpIcMNo9cenGcwFQzpHzKHYRbAS+FMXqDiQTGaaD+CdlfrjUAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ene+drFf; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ene+drFf"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c796163fac5so8242051a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779791697; x=1780396497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DgMaTqw1Z6+SL7IbSP0ZtbDSeZHxtr40iJ5WJXi5934=;
        b=Ene+drFfXLXy7dxkN8OgJP/zqgTd0kKgGxPwkD6EZvV/9TSv4DVzXbFcvLTrVUriX0
         PYTfmKijtpVCHFME04zKlx5YfwDLegPcF6BhpFI2QBowjtKcrODgekN3iqkC1+X6xD+r
         ByhXx0ayd/Q8bQeClloEhjEP1TeO3LShe/N3/qdOPqvxbgDJq0HeTrVweNxcGhZEun7M
         tetRcORj6iz5zegJ4GDSApwvr/BdQXnz0KqNARCoCGzMV6AouDe2A3dORjHmkAZdP+h6
         MVZ9L1Cwsj4j6ynUNVAOz06Pqh5VjQ73Yue/2sKtDlVyxBWlpSYnxR6nz495XUUY0Lz9
         tUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779791697; x=1780396497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgMaTqw1Z6+SL7IbSP0ZtbDSeZHxtr40iJ5WJXi5934=;
        b=c/4Gu7ZKogGNTBT6+tHre/cNDO1WkbrB7+5vIMCZdPPMvco/9S+r2LGGNUqBqwIZyw
         QI/zKXvjLEKEZ4rLoyf3IY2cApWz+nA6CR7kY/+ozj3FcqEmZX2zaEhOgaOuFDv5zS7v
         irz6g9Mlo6He44Indj3/A+D8Wh+JBy4vuZ+Ufx7boEqCo1Vyd5EadGsjrsgNnpJmHqu2
         BbtSjevMXW8niRtcH2nl1/1j8L9NYqpFkZHVj+b7B60+Tq0qnAicIjgoHDt4RoZYd7zK
         0IVGGBmZpaXkpMLtQwX2c/HUkNJK6Cbdn+FwpO1s8+7cKyn+MVRN/1vfvwpuEtvpV8md
         9ljw==
X-Gm-Message-State: AOJu0YzbZxvN5MetlJPY9q62dd12dx7F14fLDrCQj9WdcSfOsUhnM0fM
	3PsXgIEk9LdaDLyX0pcPcoVDKN53KLDOPiXTr25GwE8PtqSzmVqdoE9I
X-Gm-Gg: Acq92OErooq+sBbNersZ3PWHS+ZcWE6nTdu9qUzSjje4ckuaXnp7RBk6jBqYxpXYeCk
	OI6lJtNU5SqYpC29/VhW8ex8Svj8yBsby+mBpch7DAe2aH4hyEFJDCRVUcug2u5icF6RHjKTPbU
	/TRjGAH9hYT1t/8x6TwtTZ64wnSGJajTXJkfXW2+BynRtNHelxyiFTYExs2bRPGuofeTjIE9Xe4
	RZE/3v/NbTMRYqr2vZTK6AYYXCZVmyzheS/HMaHNfl56Rk13RMUwMQROw91Y1kH/zXt1zAjzZwq
	URal3J5qrp0VzuLEUKAV8+xm74QOc/VJx0lY9px9andWKgT+1evXj0QJLSrWzi9+5+eV7cAdFz7
	flJRuiL8Jz+m3+K5HKmeNPS2iWHHo97R6YEaDC10oVnr5LvXpGhXybIqXTZjQfYgm6MOB9BmPY6
	cnVDZFHu2g2KAX0jKhN9zOTl8CDp3d8lE0zaJjbhB5MexH8lRGU2XRg/MfNu27
X-Received: by 2002:a05:6a20:a108:b0:39f:a42:9247 with SMTP id adf61e73a8af0-3b328f56208mr18612092637.37.1779791696981;
        Tue, 26 May 2026 03:34:56 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202b946dsm10176488a12.13.2026.05.26.03.34.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 03:34:55 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH bluetooth-next] Bluetooth: L2CAP: fix list corruption in l2cap_ecred_conn_rsp
Date: Tue, 26 May 2026 18:34:41 +0800
Message-ID: <20260526103441.73180-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The duplicate DCID handling in l2cap_ecred_conn_rsp() calls
l2cap_chan_del() on the channel found by __l2cap_get_chan_by_dcid(),
which may be the 'tmp' pointer of the enclosing
list_for_each_entry_safe loop. list_del() poisons tmp->list.next with
LIST_POISON1, and the next iteration dereferences it:

  KASAN: wild-memory-access in range [0xdead000000000100-0xdead000000000107]
  pc : l2cap_recv_frame+0x3b7c/0x7360

Break out of the loop after the duplicate handling to avoid iterating
with the corrupted pointer. Remaining pending channels for the same
ident are not processed; they will time out via the standard L2CAP
channel timeout since the response indicates a misbehaving peer. Add a
NULL check on the second __l2cap_get_chan_by_dcid() call for robustness.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 net/bluetooth/l2cap_core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7701528f1167..3456d741fb1c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5292,10 +5292,12 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 			l2cap_chan_del(chan, ECONNREFUSED);
 			l2cap_chan_unlock(chan);
 			chan = __l2cap_get_chan_by_dcid(conn, dcid);
-			l2cap_chan_lock(chan);
-			l2cap_chan_del(chan, ECONNRESET);
-			l2cap_chan_unlock(chan);
-			continue;
+			if (chan) {
+				l2cap_chan_lock(chan);
+				l2cap_chan_del(chan, ECONNRESET);
+				l2cap_chan_unlock(chan);
+			}
+			break;
 		}
 
 		switch (result) {
-- 
2.50.1 (Apple Git-155)

