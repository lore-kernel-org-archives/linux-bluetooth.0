Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC482DFA20
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753709; cv=none; b=CNSq1hcxNO9hLnQHfib9dAq9XYJlhBD0xHLz4v9p+5qur3h/VIZbu+DfCbN7iqMB7c2YNQaL7TmGrov6yv0nBnutBfcri7FN18PLvuRBbzZDNLcsUD7st8G4fK/a4+OXboA8uEViAJ6t2KIFa5l/KJvahhXscbDLwlC0RkX8SKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753709; c=relaxed/simple;
	bh=Ep/VGdXyZEkyBZ8e1w235imF8eJuSSGF/xTIn+0YI+4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZxME6xyHBuoJz8JuttEEMrCiP90OMgU7MNCgUhjltZeUorNcr1vAVEW/4l06IKLVXOXvR4K3z3yiz0WBYihId2hQOyMxpxvlcnmt+eQwbGF1IzVu80DHiKT+jMfbBfQq5feH1Y3D2sVi3QCk46IDwwpJPcPZ2Vx5c1DA3q1MC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cfv3mtAW; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cfv3mtAW"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-525b44b7720so2409806e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 14:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744753706; x=1745358506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HHkuNI7c4qBw/LbC/Lfy2J5sSnqFM4eZks/GYTvigw=;
        b=Cfv3mtAWHPWrDtGbQvPqQGIjQxfzM7iE+wmy7oS63CnCzqvI6bFkMcHpXO0U4HHaRm
         hK4L0ZIBm96LKyybP3SbOy+0ArTOUKT/hxulVzJOryCwGQk8AmckywBexF0kEgqtezFX
         7mJk7+58/DFcA/dyGQW9d/HpUtJ+f/BHR/lqcAM0lHQV+Ob8R0gxoxE31slZx9NqYYqm
         EeYxy+/AacEaUc3t/Gv3TZ56bjJCoIXoM2kcH8ZnXxkRDwiJWVImiq42spETFrQzJmaA
         uiczCXJo4Jgzrn+mACV96+1BVpN2aNH1zRNgQXePWPHHKC1qRQ3nkd+lt83K8UnAr6kY
         16Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744753706; x=1745358506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HHkuNI7c4qBw/LbC/Lfy2J5sSnqFM4eZks/GYTvigw=;
        b=DyafCnUUmdCCuUPfebfAPF/zvnOGozYs2wwYRRO3aaALKFvMND90SLnaxpdtiuCQOU
         Z9cqBQ/3RMh+/VK4j3oxzTlOYkVs1ByHr815Xkesw4stjfF/KDhK6zRRztIFfRmA9qsH
         rPuF/kxKH+5tETnAb8TKq0eFyzo82sj5S8gI1nU1Hiy+o9EykEExHVnsDtHVI2K9pIm5
         uiNB6C1AXyLBUzzQLeP957ZZf0s6oIl9Yy5n+EHv/64Qpb50M1m9cByEOzHhEKW9cV6e
         dEigtsHu6jvop+3019yztZo4C0yVjmqTHms/e/PFoo0a17Pk54ya/u++BcOt2brnYj0P
         ff4w==
X-Gm-Message-State: AOJu0YwKdswqWiaTwvAbR0MhnCVYQzlbeByqAH+8uONrp7apavxoYAuu
	CSfDz6ImbGCKhX/PDXgQ6FyGdDUFo1zsQEokiAlSy2u/msx/cdCHrjJ+h3FWECQ=
X-Gm-Gg: ASbGnctO+hRLeOwrW7zHBUQCCaEfkEEVESOhN5oIRep2IK7eVsVuV63FsZ3UCIDsk/Z
	HGzTz6fw0a6HX1SAB/udypMf6UEnZz+9w0KRVLd3nf98XaIHDMAJhskiekag1rm9s1IiJuU7Dac
	PNCjeBC1KDc2JM4Cw6alN0IGt3lYqERMt9FR32+pw89UyAf/jx/uQrV/M2wOp8+xFrbR5aIu0Xq
	cn5PvaAd7anTwUn9mFC9JmzJf+szGwKCOkgHhcvxF0Vrc6VY4DqUWVUXl9bAWL0a+VcgINlIySM
	U2zePPcxR/k8g08X4lU3T5bQauNTgxxpx3wc37sQqsVhS0c8yyR5mYzFBR2OeV7Wg0EGsmFpup5
	rDaT91klZ0g==
X-Google-Smtp-Source: AGHT+IHAk2n9miHmNfqgO3/Sx7BjAm8aaGfcUssYFTmuhAsNMKk3DC0zER96xSHf2W3AeN6wp1cRzg==
X-Received: by 2002:a05:6122:1818:b0:526:1ddd:7603 with SMTP id 71dfb90a1353d-52908f8a491mr698042e0c.0.1744753706241;
        Tue, 15 Apr 2025 14:48:26 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abe8d740sm2844459e0c.33.2025.04.15.14.48.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 14:48:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 6/7] btio: Add support to BT_IO_OPT_ISO_BC_SID to bt_io_get
Date: Tue, 15 Apr 2025 17:48:09 -0400
Message-ID: <20250415214811.1677842-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415214811.1677842-1-luiz.dentz@gmail.com>
References: <20250415214811.1677842-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for reading BT_IO_OPT_ISO_BC_SID using bt_io_get
---
 btio/btio.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/btio/btio.c b/btio/btio.c
index 7ea17c7754e4..14f2b700e383 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1649,6 +1649,27 @@ static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list args)
 	return TRUE;
 }
 
+static bool get_bc_sid(int sock, uint8_t *sid, GError **err)
+{
+	struct {
+		struct sockaddr_iso iso;
+		struct sockaddr_iso_bc bc;
+	} addr;
+	socklen_t olen;
+
+	olen = sizeof(addr);
+	memset(&addr, 0, olen);
+	if (getpeername(sock, (void *)&addr, &olen) < 0 ||
+				olen != sizeof(addr)) {
+		ERROR_FAILED(err, "getpeername", errno);
+		return false;
+	}
+
+	*sid = addr.iso.iso_bc->bc_sid;
+
+	return true;
+}
+
 static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 {
 	BtIOOption opt = opt1;
@@ -1657,6 +1678,7 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 	struct bt_iso_base base;
 	socklen_t len;
 	uint32_t phy;
+	uint8_t bc_sid;
 
 	len = sizeof(qos);
 	memset(&qos, 0, len);
@@ -1721,6 +1743,12 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		case BT_IO_OPT_BASE:
 			*(va_arg(args, struct bt_iso_base *)) = base;
 			break;
+		case BT_IO_OPT_ISO_BC_SID:
+			if (!get_bc_sid(sock, &bc_sid, err))
+				return FALSE;
+
+			*(va_arg(args, uint8_t *)) = bc_sid;
+			break;
 		case BT_IO_OPT_HANDLE:
 		case BT_IO_OPT_CLASS:
 		case BT_IO_OPT_DEFER_TIMEOUT:
@@ -1736,7 +1764,6 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		case BT_IO_OPT_FLUSHABLE:
 		case BT_IO_OPT_PRIORITY:
 		case BT_IO_OPT_VOICE:
-		case BT_IO_OPT_ISO_BC_SID:
 		case BT_IO_OPT_ISO_BC_NUM_BIS:
 		case BT_IO_OPT_ISO_BC_BIS:
 		case BT_IO_OPT_INVALID:
-- 
2.49.0

