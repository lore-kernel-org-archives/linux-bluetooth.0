Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B728427A06
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516598; cv=none; b=TxZ5ht4zKkotjFx+cEgOB2KOJJUsirXgeLcyQ9QGn3tNJZ8ncNV7FzHuGCOKIXDzVFeaOXS6z9Ix2hE/bA7wGnct5qlJNtOHF0sZsDXwNoaSUCUmI+EW9AIiorsKrBCyQJNYijzI5rCZGTUh/HYXnfn6sf+L2GCya/2NyYVGDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516598; c=relaxed/simple;
	bh=FGzSzfWC9sz+oCltMa3ZGcp+SDV7JZRdQhYP3qsB/FQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RChsKpWo0q2ZGPnkS515zr1Usm04f5DSmkEw/ByKu3nOlhQwtORFR/G+Uwf2bove/s5n9DAAOKnFfKoKBoSLMz0umOPTVXj7XUIHcgRoDdL4Uyc12nDMuVrR2m2w3TsYfu+pz4ioWnWnMISP0QQ0vSzk1ULu/vZmw1i1ibtldHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Br2skM2P; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br2skM2P"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-57512a429d1so3094955e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516596; x=1779121396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yODhcNs8aLHG0+ZDqjLHJ6532FIe90ZRKHiFwxX89c0=;
        b=Br2skM2PcRjahuoR4BK0aePwAVeqZOnaZeW27EkKBQuMQKLWMXTXOCOTvbGOQiX8IG
         75UoaG/6177jOl7T4gPK0FBW1eSWqUdcnD9goR/9vAJpfzxfI4HVwdMukFdZnFXKeIl+
         M9edhVh9xLPUgHztKh9zMifdKPKSMLIAmefDrHcHBXj9WcEo7CdFB7qxJ7phzJZ4rx1S
         zRuUki/u7Tle4M2QEG7evFJ9lx5qNI1+1uGvhVz1mgQMFKNzm00j96yigCRGyDQKCv4s
         bp4QHZ4nYufv72Z19l5vYfr6+ijSP43eiA6NcDtegbilJMvg3ix5HdoB4IDgZr3NPoe9
         ZYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516596; x=1779121396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yODhcNs8aLHG0+ZDqjLHJ6532FIe90ZRKHiFwxX89c0=;
        b=RawYVjf33oe9RkGVo+fmpeZiYwNEofAA+0flohiIjdPlMV8CtGMzZr1Pr2vaQmTQqK
         fPMRtaNExc4+VPA9OE0YHCdxLKnzPlmQPaA0SEecqEU6yOQHw5/xOU/cSfsZFP/VGYGw
         SJXvntKMZCAKd7B+50f8zlxe8aWcI3OLVo5weiK+Soy30SOTMmUvv4magf8ozuC622Sg
         ea6JsQeCR9vYiJpHM8ReAOBf+FpOjw+LhD9pkPsb6/LZ1ABWo6ZXDFH9OwgCC93Vyu6M
         AXdoESZ/kTvK8LmMx0cZp0prW7ZuVxRY/eCWi8/zmDiyzi23juid4OJyb/XwX+zkAely
         nEzA==
X-Gm-Message-State: AOJu0YykSrGQ82K6snzW/3/yxG0wvKQSHCV7wHyza+NhSliHi1kjG+AJ
	Jg1W0TF2qHIjSsVQYebVNwKdcbnAMhT7+3FNEv21xysvr46OZFV/ohhOk9f5WQ==
X-Gm-Gg: Acq92OFGSNB7hHDQQR0iBqetW9Ut/OiyGz84/LmJfFvISp97tCqZKUUbLwYWJ72hk/J
	NZgct2gki03xohyX/aEbWdmWel+Rz94fTh20Sfl00ThRZ2nMrKRe/Q3oRyUVU10pp4Hb+LSx9ey
	qb23xjoY+jrSO0XCc434KGZO0f9ZAQj1BWg3QciH5xzPXuRZhkWTqvASzR+10P29SGcFOeq4rNu
	+gOV9t+si7ZkKsCVBNmG7/HgTJdS5Q9TeH9s0ifJIZJQaG1p9R1dLpufuaaEduzYryI3gWpCMqE
	Hsxb/IKQtk1hnp1/p+LrKHOX/p0TSU1UKNaXt5prmKtcFg5HHWlEfz4l8wiTHYnkzcwScZ00bnH
	dDJ5ix0zCG9ZrQmqLN3JarP+1iBAmmRk/AcPpsh1c/9MHKnmGI7hZvU0tD6R0vyYTsDD5KdJ7jX
	jzUf9Hat8LBsQPuTBWLbchKSG14Y/whY7/ADoSr0Kuq0ztaZtmSNc3r3QInQRqMREBGZAnbwdzC
	p4usD0tT3gcAyoBQw==
X-Received: by 2002:a05:6122:3d42:b0:56e:8afc:de8c with SMTP id 71dfb90a1353d-5755937cb24mr12803998e0c.3.1778516595797;
        Mon, 11 May 2026 09:23:15 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6ef15e0sm19218095e0c.17.2026.05.11.09.23.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:23:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
Date: Mon, 11 May 2026 12:23:06 -0400
Message-ID: <20260511162306.654747-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If dcid is received for an already-assigned destination CID the spec
requires that both channels to be discarded, but calling l2cap_chan_del
may invalidate the tmp cursor created by list_for_each_entry_safe and in
fact it is the wrong procedure as the chan->dcid may be assigned
previously it really needs to be disconnected using
l2cap_send_disconn_req otherwise the remote peer would have no idea that
it shall consider to be disconnected.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fdccd62ccca8..71846849e5b0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5293,7 +5293,11 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 			l2cap_chan_unlock(chan);
 			chan = __l2cap_get_chan_by_dcid(conn, dcid);
 			l2cap_chan_lock(chan);
-			l2cap_chan_del(chan, ECONNRESET);
+			/* Disconnect the original channel as it may be
+			 * considered connected since dcid has already been
+			 * assigned.
+			 */
+			l2cap_send_disconn_req(chan, ECONNRESET);
 			l2cap_chan_unlock(chan);
 			continue;
 		}
-- 
2.53.0

