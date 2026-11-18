Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029092;
	b=wXLOsoyuPyt5fpWZg58JCyYika4lx0BT1a5ZvwhhFJ5YDUHHnaQ38TbHW0R5HNBZwTms
	 2ZtW9OvWktcO9w4tImiCWaaXX1vD925dk37nYi2r9hbzE+41K4Dx1F0r7todAMlOeBPv/
	 ONrbIOw0LO4fA0aFoX59Th2rSCst6Yl0yqYaRL5ct0j18B4mDOZm3dDamumi5MdwltYlq
	 /ly/7p39SkBDU08mtBiZ1gWH3gasCeFmUAwlB0Tgs72XkZeLO5adpOf313Mg4hYldiJH1
	 GTXhx60/L8Ez7AcWrkZYOxZ18Ug3ig13WqKn26kpkC+tv/A7NwkzBmckDmIbCwI5ceQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t+JeSLhbAjJ4UKH69xAf4pF1rbRDYbY69wlecPbzVlY=;
	b=VD1+QWB9fsyXQOw9ZUFJNbsj/aYUyjkMhTjvDKgIm9/YrTGsZ9xWLj2pLH0OurDsPRTl
	 MZOpnb0JkSbuNc2a57+qcDS4i2p/NwUXo+Od2onefzlzMSlYxQRmirH7QEMkuBzFsab8E
	 UcvRQLjAgHIQfyf8eKfFIrS518kwbpP7nAxTyyPPecYyDKVcd1/0QmtnlAjsws089NcFl
	 KIiICyMNiyw0wxcT3d+RbjZlzmA9de1+j1+Ekdf68uVA7baIscfFb9nFIGeR4OKHx0c22
	 oCjd/q+J0UWSO++8NMMwgR5CAy1sRBx4jI0CVlvyVxzpUfxUUmlrje0dK9GUAicqkoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CQcr7m0C;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9C4606A332
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD9C4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CQcr7m0C
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5ea969fafeeso442881e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029091; x=1795633891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t+JeSLhbAjJ4UKH69xAf4pF1rbRDYbY69wlecPbzVlY=;
        b=CQcr7m0CidGjYaC68OEo7vyOtVCykLKQgCf4Ath4unnw52D3kkVXYpCtRUipfM5WiY
         XbI+rLENZoQN4bWbQVu4r3TAQy1xXqiy9Sxe2G8PoJ6x4xmkZkV+4qcnKfspOtcTXVSP
         26Cj4ikNBfQweUMTJWKk81FreVns/o10h31/VctngXpGR+KC73aPTWuhNHIsMhPXr4Zt
         bHk3iSgRIKAQtvm7agevkAy+Gho1IvtT7LcnRnSuce5186k+wd3N7fKMt7iXZYJNX/ae
         P+XttX49jjTFuu2js9g0uZ8cxyy1ODHm7VdU0eOi/0vpMejYC8E/K5HVlJXv5Xo4yljH
         17FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029091; x=1795633891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=t+JeSLhbAjJ4UKH69xAf4pF1rbRDYbY69wlecPbzVlY=;
        b=JFC/0miwsUFMnvPmOzFtANm/iPBIag9RKHUNyVg7bVu3mMbY5/0SIHnTFTTnuVX4Er
         yfffGTrN4PGGHqF5/43V3rJPB5LK4afBY/9hQqJg7Ma7zel9DNOeLWoH7hvAMO2pan2k
         Y7XyFLpTSlvl2PcZFFk20lOlrKNQVMM5XpzPK+NH2lJXDBCUe59Kf6u+VJfiRbOSohH9
         FlfVxnYQFiNeBsmGpPdw726ocS/zigvlZKIXJIs+mbZViCfNRKsTfqQwRhyJSvKmzb8H
         dXtu8RNc+kscx8r5d2H6YBoPabHTqbs1yKMykKQzmVp2jd7DHgJHDTXzWjNdCmBkgw17
         Desw==
X-Gm-Message-State: APuU4Z9Eic1EurkkJTi8Sr3c0vxyPhaWisGXh7VOWtQFWjWqPt/Y5g7f
	zXZ8OPaRuwvJ1VE7eOQDXhBzlS6/bDpzzVKwDyecWp5CD2haWJxW8ZhEjRyzjK/R
X-Gm-Gg: AZFdTZenKSgBtdRe6XiLoqYlpOzhyQMMum9s+iNjpzQa1JqERcTlltT8ujQwI/t7udK
	xhmxznRd/zkNh/Hz8ZQ6YNNlwLzOrk5Okrd10d138an7SxhcPtDjN2dxwCt0dVCsKaFUh2QGgrO
	8LgTuXIjxlJaHlJJd2CYptyPQDW1GHZbDptftz7v+2Htne6hIj9+R6xu71EoVlFxPmmbL6MRQj2
	kOuqMa+ISyBBWM0+8DFZSmahWQGyyscY/GyRmwVe2wggJmY7qMDYprHaNC4Kd30nxnRZ4NMgTB0
	GpolXu/9VCKf7VZS8nVMMGXPK7RlJRhFXfyYEgCoOHs6DeU0Rzlzt8rwINm+xnAlR9HLecxJANU
	79egaquRbP/BWISRBxI8URL92lmEy35zBB6jGSRp7jrrUqiW7gEmb9Aki9EonYervv7AN8kKTmX
	AL4uQQDogNv5Dd1ICQcYI63ED4/3Mo5RpY9AAWEkKlUZnXwii+MeHzECXstX7pVNRijhWhwLcn+
	b8J74EQlphcGLR88tnTg75C9GlAQyVqWAN5jVAUMEcGtzD95JnzQyBcHCWlyC67A4AYSfXHZnrQ
	z29fod1J3CidSIWLr9Mazof3+WpYRtx0LlbfAm9hNwSyDoO/Yr9pc6FTR5AnN5cJLbkDiDwp7m+
	bCCQaQ1OkzMt/DaxmC6qre9XkxncyDloS9gArCiAZUdVSW8SVvn4Dj7pYDj3YXJNqdoEHQ7iHft
	PNxR0=
X-Received: by 2002:a05:6122:e443:b0:5ee:3fae:39a0 with SMTP id 71dfb90a1353d-5ee64cafa20mr1572431e0c.20.1795029090745;
        Wed, 18 Nov 2026 11:11:30 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 10/17] Bluetooth: L2CAP: Don't use uninitialized EFS in l2cap_parse_conf_rsp()
Date: Wed, 18 Nov 2026 14:11:11 -0500
Message-ID: <20261118191118.318779-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118191118.318779-1-luiz.dentz@gmail.com>
References: <20261118191118.318779-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The local EFS values were copied from an on-stack struct even when the
response carried no EFS option. Track whether it was received.

Reported-by: sashiko.dev (linux-089f015e-6251-4fea-85ef-7d6761e8c457)
Fixes: 66af7aaf9edf ("Bluetooth: EFS: parse L2CAP config response")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 977b41229a7f..6780af1fd4e9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3892,6 +3892,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 	unsigned long val;
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	struct l2cap_conf_efs efs;
+	bool remote_efs = false;
 
 	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
 
@@ -3947,6 +3948,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 			if (olen != sizeof(efs))
 				break;
 			memcpy(&efs, (void *)val, olen);
+			remote_efs = true;
 			if (chan->local_stype != L2CAP_SERV_NOTRAFIC &&
 			    efs.stype != L2CAP_SERV_NOTRAFIC &&
 			    efs.stype != chan->local_stype)
@@ -3985,7 +3987,8 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 				chan->ack_win = min_t(u16, chan->ack_win,
 						      rfc.txwin_size);
 
-			if (test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
+			if (remote_efs &&
+			    test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
 				chan->local_msdu = le16_to_cpu(efs.msdu);
 				chan->local_sdu_itime =
 					le32_to_cpu(efs.sdu_itime);
-- 
2.56.0

