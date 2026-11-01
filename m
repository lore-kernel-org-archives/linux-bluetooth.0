Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793541213;
	b=LkleMWVKdYnTLE/Dp57l5Zl8vZSxUVJkuJSB+y0mwjfu/j9+E2R6GYnpn+MtcZIfAjWh
	 C/a5CCFJjwRmI1cBCNIfVgDt1FIjopmQK8UsQml2DHsZH5ZriLnnPCs0MkbqhOqeMm391
	 evD6xnuyDeO/WWF0dgoQ0B3O7cEBXVBkY0e87oYp/CF8nKKiAeOLKcX7EQGdZxk6M+lI8
	 fgl3PfQMPHBmMofguoTlszet9SYzY0e/ZfheMArxEZDdPcTyKq73EN8ajsiap7uhtQr8F
	 xYVRkygDoKqiFyuSwyf5CwNukcPyfnQhwcaYANAuIY/DVRUmeMTmOi2lZPc+QNyMXEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793541213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ob9tiRoLzrD8MH3HJ+lkSzfmmvOaWtBTkgx8ANuE3JI=;
	b=n4wHfq5Hjku4sxTIi1O6M2/XXahFugY+bQ9G15Sl8AoD05zX8t7aD24HQvNQW0yuPO3v
	 SKf88CJz2kRxEd7h9MLXYlj9l1aoJdk4IWLo2/g58YGjknbvrnzvFO26HMe9p8ejKyTua
	 PmuYeuNh6AEvw08e+orRkOuheLymBspuO6FUc1RtiW16j5pyiOgX/X1xAfQFZmUS1ANSZ
	 Ax2m7Aqt7uuD26lh5Ccf9iAzJB9xGce3z2O2AyNBtd7W3q3J/ccI4etbc76CLdZZznw28
	 kTX5XB4TX1nJ8lG06hraAzhC4E66kEHqSucFJBitNquBu4F6Ie9LdzTKpu3ioSqYFfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=korea.ac.kr;
	spf=pass smtp.mailfrom=korea.ac.kr;
	dkim=pass header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=google header.b=iYQOPLGt;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D21D606A325
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Nov 2026 13:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D21D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=google header.b=iYQOPLGt
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8871ada1a26so15426837b3.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Nov 2026 05:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=korea.ac.kr; s=google; t=1793541210; x=1794146010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ob9tiRoLzrD8MH3HJ+lkSzfmmvOaWtBTkgx8ANuE3JI=;
        b=iYQOPLGtYwzVZnyj1j23lYqTPxmQHbYy60ll8geKmCKn/Hoqd4q2XlhcoWxWU4ZolX
         yx09r1t72DeBJI31edAdrMsdui10kyHITWbGUihd0+DIMQtUrvMTLSmrBi85/nV8TTHV
         YVLX2OuycFLflfLpNCnna7aRyGjXmLQPUZ/eSxOILp3DMHEShgh5qiOSb1V7zR4civ/d
         CAn8DkodHzzmlvKzEG2V6R6jnooi1UUVudQ4k/hzjQoUFvGpIWbgIkmWCjXmkt+6YSO6
         C91EnzeVvEDyLgw6A7kBnYSfpw5QZ7BydV7vNYH0QQVOoQE7QMMtHNtZRxxOa2SUS6lm
         7MJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793541210; x=1794146010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ob9tiRoLzrD8MH3HJ+lkSzfmmvOaWtBTkgx8ANuE3JI=;
        b=uM8jHTPnf/HznBH/LRcKaQaljoJLBpTl5ndjpJQtXEKnehdVccNkYNEypaonDaQoxN
         0kv7GJ3UqpYxWk7aDSzN2YEXkLcdIxHS4Yl5cpbOaAzpRaVDdA8ftzNreo9+uBaY8Y21
         oTJwFsTdpoXtvVSpapWBSq0CElCcya7UPR7erwWoyuyHGxUxaXcsBC4iEKASN+kem6Hj
         T4+ZpiTyjSCBD/yJYGfiXjWYOpLdExKVzTuJtuCYxzU28Yoh3elf9vAcexatZG7+8Yss
         279NWcQfDtj/maEHoNFgXLP0OlSLW4wYjZdBc0mvm5Hs+EaxvlM5oMj/ccwStfF5rZvl
         Y1tg==
X-Gm-Message-State: APuU4Z9+7aLLnaflQcDy0lE/F0K+Eq/uRSJbLCdqQ2AgNeDzjabfzQo/
	PctTvUmXsLO0JEo+7R4Ov/oXeMzg/MNpO3UuzV3dv9f7niojzRP5o7gDO1RhWtPMnQ==
X-Gm-Gg: AYBFou3ZwiPaAvU7QDji2jnYd4xlKsejhgEjYETML1fgmWPNdtccgffymJ7z7oYLLCu
	aAUncKjNHgxVmFJ5y7c+idupQPFyfxF0PyQGxKoq+zRw1LES4+BKi9NgZuVRgxakrxbp04/PedW
	ONuXMuu2cRQWmoPDMiH399hAKD7Af9f/EuJ7IDqN98l8D8/o5oS8gASPPLDNYOI+1cdrFYSu5Cs
	078G5gdAPUvrfYnhqqCQeELOdzWD37QT7s5Q4h5v06jJNw0ukbnGVtL3B/oIJxMelL8+WJrgZRJ
	pIJXMRz4cGmQRAk0MsOqScjAOIeuiVLWc3BhSSU7JP+T5qGDj1pFavB0yP9Bjm8OplxS+4UOEfP
	m0DJiXMRXa3Gs65a2Ql5HZjIcF//nEIynTpjtniwvsNPGNlJebGWloNCf2OqxPY9oqo1NTlVQ32
	24OxRPowj3dncT+Qq94uNSk0Pdc0yQOTOBFjwqDhnOQhLeQ5lSAQ4yLjmw36DLccVDBFi9koeHa
	+1rECMJhr5gb0K9x+8bZIzFoNl0580X43LKFOT9zgjJlFTM1V1XFFZch1j5J9ZLpBJMwxo=
X-Received: by 2002:a05:690c:f8f:b0:8a7:1943:17cb with SMTP id 00721157ae682-8b2b67c1d1dmr42944947b3.90.1793541210292;
        Sun, 01 Nov 2026 05:53:30 -0800 (PST)
Received: from s2lab05.. ([163.152.163.130])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b71657besm36833807b3.30.2026.11.01.05.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 05:53:29 -0800 (PST)
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ingyu Jang <ingyujang25@korea.ac.kr>
Subject: [PATCH RESEND] Bluetooth: btintel: Drop dead !skb check in btintel_read_version()
Date: Sun,  1 Nov 2026 22:53:24 +0900
Message-Id: <20261101135324.2192752-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
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

__hci_cmd_sync() returns either an ERR_PTR or a valid non-NULL skb;
its internal NULL cases are converted to ERR_PTR(-ENODATA) before
return (net/bluetooth/hci_sync.c). After the preceding IS_ERR(skb)
filter, skb is guaranteed to be a valid non-NULL pointer, so the
!skb disjunct in the subsequent length check never triggers.

Drop the dead !skb subexpression; the skb->len size mismatch check
remains the real guard.

Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
---
Resending, as there has been no response since 2026-07-11.
Rebased onto current mainline; no other changes.

 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0709fb3212f96..4aff00e41d43e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -471,7 +471,7 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 		return PTR_ERR(skb);
 	}
 
-	if (!skb || skb->len != sizeof(*ver)) {
+	if (skb->len != sizeof(*ver)) {
 		bt_dev_err(hdev, "Intel version event size mismatch");
 		kfree_skb(skb);
 		return -EILSEQ;
-- 
2.34.1

