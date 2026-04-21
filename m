Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85693D7D66
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779813; cv=none; b=fRO9R3HD28zR0CdAiWpVMyoNUzQrK1Luja5HQSvd6bvE23FtoE/GWFYXOo5ryhXIaXVT5AAhqxgcLLbZacfYmz2sb+Tgcr/nvI/YVijqLPmu4kFIp7jdzUy1A+NjfVIC6WeP8i2doyC7vv9I6XOL+d3w/R1f3bIxwDIBUoUjsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779813; c=relaxed/simple;
	bh=vwLoDl/01Ero/HX80bWSxcdPpZ6rMTqaORYvlV9p+wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ko3n50FEHlfz553e4VvXn05RSYQPeuWHVv2h93ayDSdVZls+MuBCDjmFWO3FPel47KkazAGwGNFFiEfcpaojSrieetKVBH4xm3P8gKib96N1VVofQWWCyuJrsjADPewTd4VWD2ZEqwhItsD14soSCmtfnRqSHIDi13mUCzDWWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDcg4gB2; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDcg4gB2"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8ee7ffd738dso65711885a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779811; x=1777384611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggRf3YpZg1vH3MTEtXV+Gjte52f6naKFyzHWanBYOiU=;
        b=cDcg4gB2BRrI/uyLLe9dICAwR62owflM4f5OGxqf2gLzPhRIWPl/4geYxLtOX0mwYD
         Hl1p1FGRnhB2nXmqv6cnu6/OyGkOmUyvxltd+6vkMvnKmEixD4+kCS3+jQgm/ZM/5crO
         Q2OFaNtbJAsBos32VW4CRO/NrVTfjKN7Tl/VxoFeetlbp0gnsVGcxN5iW89OWv7S8Jgy
         ET1GoPvb6PIbfEHnVyBp+wat+zswBAQDh6Sqb87Z1NzvihEjtX1cqpLlU0+PtqZSMZBY
         vhphacQBQHSyGBrG8JV3f26GwPgE55H4A/lTepSjOvnGJgqlndgdek5HybRqpGkp+7CG
         Dt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779811; x=1777384611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ggRf3YpZg1vH3MTEtXV+Gjte52f6naKFyzHWanBYOiU=;
        b=KBzVJcnpbjyxSafWqmdPpZmiPVeRBx4SsdaRnYnOcP+L3k1AQNiA+r3V2FR7Y5m8Y/
         xS0Jtnmm/lHBKmyOnsengyXQMJtWxXDqoo4xvpGkBfSyo35lbB9vFntXdS/digdRwBuC
         yWzx0LN2idYYWz9B1uACzX97cmn3gkyqw02SBWsA7Tg3sqAn52Q9Odj6D0u4vmG8kyIe
         TEMUa4c/kTN5SJgb9KwA6bbnUqUdByAD7wpGxnEy1qKd3tc+2smTqbP49UC9nnu0319u
         0ATQhj+UupOR2D6DDP3JPoSsNy8e4lS+uFhAhcQXIAysPFE01G9woQdY380TY4xfx2Z5
         35Dw==
X-Forwarded-Encrypted: i=1; AFNElJ+kv4RIQLClJxCdJqz/2PnQ3W4p2AEalaZN+uepKqt7SmufpEfwVAs9ff+Ci9/LYGD7/D8y0ycqlDRdlW34L+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuTUL1Xec5Zd/7LxmPf0w50O4yFFXBUfWNlvHppDdR3alxqPqd
	MPISMlnMHy8EppG2ce22TYItCXxlX4GUSm6MBNIxuG9raRWLbhe+vYjBsafdiOVj
X-Gm-Gg: AeBDievO5DUTy8SDwU9HWbaH8XESS4o71yySjl/cNO2icv+KEf/u1qvT0q923y0ebLZ
	oY45VFiV+cDvsjDfoqu8srDJvfXdeEIC+1VDthYelQhxdArhGlBgu2cRSfPoFVysMhTC7gImYoG
	2l/YpeGnuHesULA/S13VJyK0x4vKi83MW9c1M1ovvO5yxbXN0l/mOs6j+0GIxxeaJacH3KOaPvL
	2ZpaOf+DbUoYNuK5icWnhOCKQj94+RNgnhkVkkvAJPh1lw39xZoO0t6SNZMrVw5ZV3eyjC24oG3
	u8NgyR8fago0kxkKAtM+JMA7pHxcqVHnQ2DNyP1NDkWcoIecQePUv6+5GPVVnRZ5yqwcTJ3WmP0
	fm5HL8/ZcnYAjlzCZjwgILU7D7hEH2K3aZUCXyJ54z6n/J2PaR7CdMfcahF2mhNkO71uz9KzFpC
	fdW7NkGXJKvBODED5x4Xhiin3CIaSIuvCehydYldMkF1T+4fRHza0fExRqQf0zhCt3hENgCN/+e
	Pe59f+zxEVzTYwRKWMLVtmhwPsmJOE=
X-Received: by 2002:a05:620a:1a21:b0:8cd:8e8a:3584 with SMTP id af79cd13be357-8e78a335c8dmr2054535385a.11.1776779810366;
        Tue, 21 Apr 2026 06:56:50 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69ad48asm1033231385a.19.2026.04.21.06.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:56:49 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mat Martineau <martineau@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: L2CAP: skip ERTM re-init on repeated CONFIG_RSP
Date: Tue, 21 Apr 2026 09:56:39 -0400
Message-ID: <20260421135639.3185653-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
References: <20260417221628.1674866-1-michael.bommarito@gmail.com> <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 25f420a0d4cf ("Bluetooth: L2CAP: Fix ERTM re-init and zero
pdu_len infinite loop") taught l2cap_config_req() not to call
l2cap_ertm_init() again once the channel is already in BT_CONNECTED.

l2cap_config_rsp() still lacks the same guard. After the initial ERTM
setup, any extra successful CONFIG_RSP re-enters l2cap_ertm_init(),
reinitializes tx_q and srej_q, and allocates fresh sequence lists over
the existing channel state.

Mirror the existing BT_CONNECTED check in l2cap_config_rsp() so response
parsing can still update negotiated parameters without reinitializing
ERTM state or leaking the old resources.

Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
Changes in v2:
- split out of the original zero-txwin patch so the repeated
  `CONFIG_RSP` ERTM re-init bug is reviewed as a distinct issue
- mirror the existing `BT_CONNECTED` guard already present on the
  `CONFIG_REQ` side after commit 25f420a0d4cf

 net/bluetooth/l2cap_core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7ffafd117817..fe98f4821a90 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4480,14 +4480,16 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (test_bit(CONF_OUTPUT_DONE, &chan->conf_state)) {
 		set_default_fcs(chan);
 
-		if (chan->mode == L2CAP_MODE_ERTM ||
-		    chan->mode == L2CAP_MODE_STREAMING)
-			err = l2cap_ertm_init(chan);
+		if (chan->state != BT_CONNECTED) {
+			if (chan->mode == L2CAP_MODE_ERTM ||
+			    chan->mode == L2CAP_MODE_STREAMING)
+				err = l2cap_ertm_init(chan);
 
-		if (err < 0)
-			l2cap_send_disconn_req(chan, -err);
-		else
-			l2cap_chan_ready(chan);
+			if (err < 0)
+				l2cap_send_disconn_req(chan, -err);
+			else
+				l2cap_chan_ready(chan);
+		}
 	}
 
 done:
-- 
2.53.0
