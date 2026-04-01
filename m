Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150C3D6CA4
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775059337; cv=none; b=HDUG2PEvzLV+dQZFUJLTiXyh7kKdkrAY8jA6rrDWGkymaX3FuKre6E4WDXndoZ0vNZ6BvScr4/mL9kb40L20+ykmU0K2Otizo9udiA8lmDw3MPM9leLtOfAFFiKllKvkKWLRryBtEgFW3PuvAWWIySRI7Ovw1yg4P5MEcqSsTwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775059337; c=relaxed/simple;
	bh=Sy5tEmdpKLgoxdOi0ZzZNznmnXirNagWtuFAra7Vd10=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqDdes8NHKMWVoynRSEr7/7nJnopyy0mZnUicFxdY5vnxPDmZtnM6Ru5SVHlFZKLjF50VZV4VzZ+gqN2Loti3B60ZMBY1bSbOEdDSG1db/LYLWLA9q91h4xVNc4liuEX/ruWf405KkIClIFAx+5pFIbQsA4i5NBBDfJaf8NIRbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PW1EBkaB; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW1EBkaB"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56b7043c97eso2799465e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775059335; x=1775664135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUVenZRQeTZWry+ZVGxbZwykybo67QWwgUNweI0aaFk=;
        b=PW1EBkaBMUeOU8856ry3c9PXLfVSiqZGVUnggVG/uoTxF5oqGcEJ2ELdrmLjaySZIi
         kRZSY9Un2fF39oQhnpv4upEZTY2FvQQTVJFOKDQGnmpJZ0fLd0DtrUJ9Xoyxhpxb081u
         6urshP3D/Cy0tDQmgn5/UuxN6oVMOHHxw2k8f1/YYc48JfnMYS58TK9BGyO8+Mb4kWOv
         U371MoJ8mLa9b/sVDmFOqp8KJZI+GJJn5NF/AW/fUZOVTjEzrmetN4ATXOX9uu4BKNHs
         CBeeN8o8l7/+pWNmyr+xBSy4JrIz1AZWg5/HKVhDjk2MnUwcOJYCAk2iXJaip32o79xN
         1Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775059335; x=1775664135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xUVenZRQeTZWry+ZVGxbZwykybo67QWwgUNweI0aaFk=;
        b=Gc0ITnim2tV+memwEP+za7y9VBeNF/nbWj3RTH9yHZG1Cdd/btkjHKO2P3ssK6Ctx8
         CMfDuarnDLrY31Uxa9sly7osUNcGjMhDbHSVLAUQDR9PoAXs1HogitcOJc4yaARvinQE
         fn38PpAxpzIHJmLSiCpZDRji7lzew91LqCgIzS5CQRurWTIWEvaCLJJMJRoea5fY1s4r
         qJv+P3EKk5QTPTo+wdTe5LIknWRKh+shewi27sFKi2NKGZGQ4rK2Ush2b0L47yy3Adx1
         g8It/ST7/saS85u7WJUXK5vtBQL1wq+TdEwOG3ICRvBrVwXybAAN6dPy+5N9GFICZ1i2
         i92g==
X-Gm-Message-State: AOJu0YwUpDhve2jaNMl9OXRMoTlcDKnpfbm0N0uKJhD3JrTDd1lD0C4h
	TdYtKna2YKYc9ZTIdm9nFs4NXEP+PeZdqlgt9j6XewXXFl/VahI4uCYJL5YtiztcbOk=
X-Gm-Gg: ATEYQzwxHDSiUhNCYo24YLz80bVUlFx0ewQBFAn0Gewa9WqIaKJY5eOUh16f7XQy75F
	wAhI5go0jBWNMiOyyw+9ZtTToo4014PCgDRmvk8B17wOBccZ5CDYLOk0qGuELq4mnWGvLnHe0PF
	fxYz37DRag03EW5qDOY7/R+LHVilBhPqLyk8i70MzsSuhbdMCk6T/Waq4gyQ5sDF0GxOkS9EsMl
	hdxI+cnzDXwj5jY1ji+x1rI7X3EibO3NCzcVhXO+Z8fu3uXwSpjgsWVwfv7be71rIMjk3XAChEG
	CziLGlMyxxDT3+bPyxqtE5VYdhBBpIlvKZshlDA7KPXVrno4iK/wKpFXNzg0r3S2KDlmq1Dsog6
	VGcgjKVcehq53zqYGUTOKdspAPOK7Wq1DXLYc4qj1rOklY+HOmVpW4JeeqFntguTf+xN30RpsJk
	6way+Gk1YO4q1VYyCx0bOBaOsNMRDV2GR1vtUnoMDs0C9q2tB7Ixr4cZMReDIr6a6bp4FxGawQ6
	JHPLd93RomvSt8TMQ==
X-Received: by 2002:a05:6122:1da7:b0:56c:d623:8967 with SMTP id 71dfb90a1353d-56d8aac6a83mr1742624e0c.15.1775059325334;
        Wed, 01 Apr 2026 09:02:05 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58893d37sm17907391e0c.3.2026.04.01.09.02.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:02:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 3/3] Bluetooth: L2CAP: Fix allowing to change security multiple times
Date: Wed,  1 Apr 2026 12:01:53 -0400
Message-ID: <20260401160153.1980387-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401160153.1980387-1-luiz.dentz@gmail.com>
References: <20260401160153.1980387-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If FLAG_PENDING_SECURITY is already set it means SMP pairing process
is in progress and hcon->pending_sec_level shouldn't be changed since it
may require to change pairing requirements (MITM), which may not be
supported depending on stage of the pairing procedure, and
may result in a security level that don't match with the pairing keys
authentication (e.g. upgrading to BT_SECURITY_HIGH without setting
MITM requirements).

To fix tis problem the code will now return -EINPROGRESS if a process
call setsockopt(BT_SECURITY) and set FLAG_PENDING_SECURITY it needs to
await the socket to resume and clear the flag before it can update the
security level again.

Fixes: bbb69b37be15 ("Bluetooth: Add return check for L2CAP security level set")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v5: New patch to address comments on:
https://sashiko.dev/#/patchset/bt-smp-v4-ea63d24bfcd1416f9da279190fab15fc%401seal.org?patch=14763

 net/bluetooth/l2cap_sock.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 71e8c1b45bce..786ca7c6e272 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -929,6 +929,15 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		/* change security for LE channels */
 		if (chan->scid == L2CAP_CID_ATT) {
+			/* If security already pending, return error to avoid
+			 * changing the pending_sec_level while the pairing
+			 * procedure is still ongoing.
+			 */
+			if (test_bit(FLAG_PENDING_SECURITY, &chan->flags)) {
+				err = -EINPROGRESS;
+				break;
+			}
+
 			if (smp_conn_security(conn->hcon, sec.level)) {
 				err = -EINVAL;
 				break;
-- 
2.53.0

