Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAD132142B
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771596582; cv=none; b=rOr6+KZvG/3aUmBqD3cKUQ5uDK5tYXqJW3iTy5YdqGtlmHaHfhJKePYac3yfPsxOmftA2pcleqcWEOCVZ4Mrblp7OODaHitEBDnrImmRuctQkNauL71jq0e0egeaBBzHe87DVOzBGM5dbTK8GsMRJd79ijN+pytfHanVrHaLZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771596582; c=relaxed/simple;
	bh=joiDOVXpyVmOio2XeAgoYkDgV906iKdBijZs78blfDY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NCC7b/B5c/AGVq1vscTccH7vKdkTQPZEcOuGR07gaJSgah+/2ato2gni8re+6kv0cWOr6fa9ucTz19IaaJyQ0K/oH0Z1g/mZ7hRUyslNFY3j7M6dHdpf2U9mbSeiIwN/E7NYlrKIBtK2JJSN/Yu4WwEDz2ronKJkxGRZKkL10j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFo+KMo/; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFo+KMo/"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-948af5e704cso673811241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 06:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771596580; x=1772201380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGmDzTvJtYrLldcrBBe+r4j6aP+uXfRvmgMv6j4MdJA=;
        b=YFo+KMo/e2pPaLMJrkXtmcoZHB5hrHVwx8tGgigr633NlAZ4tzIRmmcUQWwuZhSMDu
         GFNnlSSD9HINEEbY6VGfnq9m+UJa13am1EtbvNonymisv1IapeZjsHI8PnvaYRE1He1T
         kNt4SHX1B1bHF6o2g7JZ4WUg6H5DHfW9IfcmEnAJmrGJJRCSuk2NJ6D2MCV4aD7GWQDc
         1gM6oTbuzWA7yYgiB3jXH9CCOFuI7ozCIIlo2EggNC0Y2ZYWVjxbKEIvpEygGpdO0mtB
         vM61OtNgbXyRX7INtBZEjbU/UIpBA0b1OjDiIa9ojpVDww/HxfFTFrw21hRWUgV/oe9v
         KNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771596580; x=1772201380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGmDzTvJtYrLldcrBBe+r4j6aP+uXfRvmgMv6j4MdJA=;
        b=LvszY8GAIiipxPMlpkiN4veof4q1Dp+DkZlQLed341BDBbK3p2GFn4NnoFeY08m3lc
         mTosaCI9hAHn/hPPG4PE+Jo7jcX1kLH3DiKCxrRvrtJxl7DmJL7QzBmLTbsc5GBKhofl
         Bhy0FULde/0B/t0aGlGZskrKudeQreuBP5t71Zn/GcdLVdW2exryRm3oebQ9wsED+TPp
         VoRN3Jet+MAdX6e1OjYzU+rYvy5fRc4IwAGBTv4xH3edUUwGJ6L8YxQAITLFviVwETqC
         1fLhSrcnV1PWUYgBoe0c04r54ioVrO+F8mib/oknjt7+BYoF9PrJLoMoMY7G0QHlwMVA
         T0tw==
X-Gm-Message-State: AOJu0YzzHVsC4vfJR0edtMWJTfpAEMwabvshwD58GbMMZ5QOP/l2nrZJ
	5QtSrZW/2hQ5VLJAqxTvUQ/Dvedtbuhi7+uupdGFXwblhfjPy1CwANZRMsva/g==
X-Gm-Gg: AZuq6aIMg1Knd9ZzcWsgsY7RLRMifLf2aQgyIeE89aIwWXPfeOFGqspwgGBQtiY2oNk
	2/o3vuHY4Nj8y2j44Xz1XleOoQ/zr82KT4jlTrAaur5DuzasslZXEByrcyP5aWhNfAajLF3gAQy
	RQeu5rTUVQe7AzlBs3HmQMBlf6R+QtLFK2vcX0cVMYua/lI9geuvj9C69rghc3HBHwQJgMaAhk3
	468gNSQNoIHFDqBCgzqqfMrQgUgieTAwtYWFEJrqfOo2UZ1rC1pJwvDTyYy9jihwr6SwU6dgTpL
	fdNc8iSz2QL78f4ck7AFIG9ZsyJMcW8qp8/+xW0OGMzNrV6PqNay76EVdO1xR2UeD9DmaXX6S/N
	mLYEZB4ytBf9zIxyTEKEnao6eRwjHvw6qx0AaKA9E8DgIVRGAWv+CgT5M301JWtnAqZ0S5aCEcD
	AghmQObb9gh61IPE8xbvDsuLFERb8nsB6X4G5Jj/RdnhDVoMen1+8U3KhfhalABfQYYOLg7J3nU
	p5mrj0HVnBB+NU9tYYCKkntKpec
X-Received: by 2002:a05:6122:3483:b0:55f:c6c9:e4ba with SMTP id 71dfb90a1353d-568ca1420c1mr2728691e0c.13.1771596579935;
        Fri, 20 Feb 2026 06:09:39 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674bfc973asm17678571e0c.2.2026.02.20.06.09.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 06:09:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Fix not checking output MTU is acceptable on L2CAP_ECRED_CONN_REQ
Date: Fri, 20 Feb 2026 09:09:30 -0500
Message-ID: <20260220140930.3367106-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In order for L2CAP_ECRED_CONN_REQ the given MTU shall be checked
against the suggested MTU of the listening socket as that is required
by the likes of PTS L2CAP/ECFC/BV-27-C test which expects
L2CAP_CR_LE_UNACCEPT_PARAMS if the MTU is lowers than socket omtu.

In order to be able to set chan->omtu the code now allows setting
setsockopt(BT_SNDMTU), but it is only allowed when connection has not
been stablished.

Link: https://github.com/bluez/bluez/issues/1895
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c |  8 ++++++++
 net/bluetooth/l2cap_sock.c | 15 +++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9452c6179acb..90676ca0e92b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5117,6 +5117,14 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
+	/* Check if the listening channel has set an output MTU then the
+	 * requested MTU shall be less than or equal to that value.
+	 */
+	if (pchan->omtu && mtu < pchan->omtu) {
+		result = L2CAP_CR_LE_UNACCEPT_PARAMS;
+		goto unlock;
+	}
+
 	result = L2CAP_CR_LE_SUCCESS;
 
 	for (i = 0; i < num_scid; i++) {
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 62ceda979f39..477b4d145459 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1029,10 +1029,17 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		/* Setting is not supported as it's the remote side that
-		 * decides this.
-		 */
-		err = -EPERM;
+		/* Only allow setting output MTU when not connected */
+		if (sk->sk_state == BT_CONNECTED) {
+			err = -EISCONN;
+			break;
+		}
+
+		err = copy_safe_from_sockptr(&mtu, sizeof(mtu), optval, optlen);
+		if (err)
+			break;
+
+		chan->omtu = mtu;
 		break;
 
 	case BT_RCVMTU:
-- 
2.52.0

