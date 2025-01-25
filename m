Received: from sonic308-2.consmr.mail.bf2.yahoo.com (sonic308-2.consmr.mail.bf2.yahoo.com [74.6.130.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821A043172
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jan 2025 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737826730; cv=none; b=Mcx4L4DsojfI7svSUFbY5+TKAZhb3X/BV5jFcpklMrrR8EC3PguILLqxklpoLUdKv6LSaDpPaI02hceqfD4u0iw9JoILFAP9ndR2v3kgUsAhrXB1KIhU2FD5jYcoENdseDiwKy8ZsJhasGkSKb6DuSXMqZ/A1LQGTlE0sSAiPus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737826730; c=relaxed/simple;
	bh=+mGt21xKgA/AbPYIBFBdQkN+CekZ4uEEYPDkYbsebgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=M2kaNed3E6AX/fyUSAPUOjbEy0dBocx/hAz85TXT2BZ2dQ5RwDpZp5IOtCBnVod7nx1PO92zKUI+gP0dQWwMXxIigzI5vvqjvx2NSdKZqBGl6uLwfoYgbwufjaZMQoTzesXpAtIkEOrTO/x8liFfW0AQ3sZKGXVBkRAPpE1t6iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=LfyJE6Q5; arc=none smtp.client-ip=74.6.130.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LfyJE6Q5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737826727; bh=3vbq/VcoG34d06AHZPQTCFW34TWTfaPtNJ26zRCMNDo=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=LfyJE6Q5NUo6UpM+Ftq4bDpZh59FF61ZFYtiSLyiLx8QeSYfSiwD3hXCnoe4a15ouiuyhtla1POG2R0uqoPHdE1gFoJR3bSv1boyroPulJVjxtZHvVuk5Tm3FnOz0AMKHxjZbOHpZwmEDK2V6Pz1oyYK2d4J9lMIRlaJ6Of2ASc1vkNu8ZlZumH2f90vD+fj5LP59WUtzKZI0nSJ3j30cd2h6h22cAxqF2AVzmxM5xjKbvlgQl/dTGF2INXEDAgtANuO8Ducr8pIXjrjh+aF3xhnHzFAusLlufpxoO4Q87JAxLZCJ9yk7OOICZvAzXtueCTlrvdJzO0hTNoMyEFh9w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737826727; bh=+2/d6X8PaHsC5rWc9/s4cyCF4d6TGHYAPTkwzuBAcZB=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=W8XgA35X5IvITh3q2l3O6T3TRHp8iOYvCTQcQm+QOpeIjn78d2wxO17wISo+26E2220DFFXKzp/8T40WzDjGzSr6L9e3gSul1ZMm+S+WwsjYniUxoz+FBLxmYCDvwroW5AQeV6fIIL7zaf0Fcwntkh22bi/mrKvs/EFNzLrYWJ+C6zkYLH2fAdklJzFqqcuPIZ8AhEKsUgkJ5ONL35pwfOzTGNe/AXwpo5un+cEmaK2UOmlNKv7cJPI9gLnCbbgLdQcXq553bT1veCJENMnbmYeDtXlulq6fuhEmOm1WICxIjg9i738L4Hj23MkrOM8sE0iy1P819pYwWCfnn/ZQdw==
X-YMail-OSG: JU.65wAVM1mCjkDBGHbWiN9sva7xlMk3VDiMz6sS82sVZMYpdiCu_p10XL8Qkvy
 p6QGbufqWSHlEP3CiIXHTYfzvnH59fF16V31OrcvRjOeVfPls11b0XkdEgx0jEITKDIp_KPe9QAi
 QgBNTtOCkqx0gj0LYQNdmYFs4C3BPg9hZPeqM7a_tOkfSxpGY5XWrZ1jFkjc99qK6sT.olG2WnvR
 s1PNx4yjgL88Zoajx4mUuvgAkoHkk0_LrSuifSfug5NwVPaip63NMypQI7uxi._C9rSzCdxylDsR
 ouKOCo9nv2PWCImxBjGEUmsSy7RasKeEF0yMxWkyjiVOIDflPjuqwcDaL07pGxxT8D30XmsFkz2g
 M8WqGauH0D_tzioaJXB2lb.noOS.QoG872WI7OUTmU4ZKc7kGQnqf3At2EHEnrhKpf4yfCKq7bm9
 nTtHN03KMjVWirI_VlTuuV1q7qmvD84Vwon9YT9jkFmMiTjpo.JIDDQm3rEfp_3SXDpO5K8RLApr
 KaAjsVaWOtMCyLXXdZBmd1T9BanILd4sufwCHP_XytdUTW7XFvgaxpTmDFMY2Tsj3BvMmOKJmzuS
 mk.aYFvRyWJnph2PKVUuSh6WdvA3qJI7Iv2beGdgPh2H__U0ppBkQ0uTz4GehaJHRIJtUk1vFPqm
 z9QkZD2y9DM0DZdfF4zGjowbQiny6tAzud3Pgatzame.uOmd8Fm7kdF56.693n5WxxMjJpvuq055
 Mh41S48Fb3zrOvkwrNhTm.YAma90klx97DganeQKvpkNukWSxZDKdY25xlA.mFHvI3S8rkkfIaWX
 HT8lfWyFC7YCLHBWpERroU9GAjZY4GChPS3Lsk2AuyZR13W5qNAcLnC4_FNmQ9rlkG_TLAqI58Vo
 cv4VLbLaPLa7vwH.Pxgmh5.jxG1d9QKN.0nm4tJzaY9AYncflUgihi.mVwFMjSKV_uu6A6CtwKwR
 ifK425w9STalnojMHHpqpB.jzOVGfOdhLG9SH4pT8vxpSFxdgEhtqycZ5b5gUtZCL2nBSQ2wHTN4
 4Pla3iGNKuaRDc0VLsCWkux7tbdVL.yOuAkCsE6J1eWoTdx1m6omr2i6zkk_G9IKqhPPfvKc7rsf
 uNJvRTo5kAHakNRaIXGrnzUI2CJXaAO7F9pew8HHkveZ5l4MSEjDRZW_O1Ng7IrIJlmOxv1KYHLz
 c7xSjXD1TVizkkWFlPM2EjbVsuViRU2vKYqegQGz6EobsKB9p4bp3HGKIsu3owTxZraQ7xQoIpup
 saWyoxB5uh0C9_dwVOtpNnAZNBZDNQXfxdUiBgWEzUng.2foRRtspMg1SbpdY5JC19H3_PlU0xaQ
 i8VRVL80qAwvJvuzDWliE.b9BF97KmHNi9emeaGZ.tRQgtxYLycJPA212wSqI9PJV9n.o2WOmIH4
 CgrDBBKxWmroEnTtgST_9P6AEWSxLlz7nXjhfxJoRFLkjMPxp0h.OiIM2WAd5vDPZE8eUgaqKSh.
 ovDXyhbRdm7xqF8n_p01WXJ6zuJiOhQ0m3bWhO1TU75BddcRvREJEynO9XHaqfbjJdIoxH9.H360
 rPbvoBdnPI5sIlj8JFDmqj8Ij7U_F38oKlbs3Xyy2wwH9J9ihT9mC02UDxq_cnBDSGVsIJgcFAgc
 h_S3fs3wxkZ_4bF5HR.3YL_NfD0vpr3CuISOjCwA0qW0LIi6ifc0UIm8rEOsrIJl1Dtsi1gjROGa
 xEslU95J6Sc6pWHQ_0k29OQZwbrlHkNqvZEVhp_p3y9BCptH9xBbPEWjaxmJtqZXCMGH6IlhpX34
 DINlbbfdCedxg55Ngr_SRwQldYeWrwM2T8rfBF3M57dcchQZLnKg.WhK3zmKkdOZ_eyucmkVGmKk
 NJ06Hpmx9ro72Chn_4NhpDpYmnIlrmBIG6ZePHc_P1eoe7fnp7ZeM39FTcCdQAB9c.vplLYOSDSm
 OLV3IFHCChznyZwGqN61QvNOFKHNTj8Am51GxA8ROLUDldxXl28BJC.5AM.sxyZInF8zlfyo7C2Z
 bxoeyCSLABXzoDnEHBDUL_Y24TvSmtx7.OwplHhCnFVICGfCCKTMawTkmmYUpGZUMFG5Y_9Nd7XA
 Fd9tApiyieqr.U7qQMwJ41t0iDWGpddIj_9o8fd4toLjq0pqkkHHqUpJ2FtATtnlXAKep5pk.Iie
 .LhhCmVq40yZec5DityLTGUtdg7sWQZpNAKbNVejAJ2ZVe00MPAwJW0wLrYTmVOqHPFaa6Ls9lYs
 AEUTaYHoxuHQZrqtFPvx90iMB8PbXkch9jK7nE.81osFNAAY-
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: a2443f0e-771a-4b30-852f-a580f4c0d1eb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Sat, 25 Jan 2025 17:38:47 +0000
Received: by hermes--production-ir2-c694d79d9-mr45v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6801542b8adb9651ca86d5c6ff7510a2;
          Sat, 25 Jan 2025 16:58:15 +0000 (UTC)
From: deaner92@yahoo.com
To: 
Cc: deaner92@yahoo.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Unnecessary braces around single line statment.
Date: Sat, 25 Jan 2025 17:58:02 +0100
Message-ID: <20250125165804.11486-1-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250125165804.11486-1-deaner92.ref@yahoo.com>

From: Jeremy Clifton <deaner92@yahoo.com>

Warning found with checkpatch.pl script. Removed unnecessary braces.

Signed-off-by: Jeremy Clifton <deaner92@yahoo.com>
---
 drivers/bluetooth/bfusb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index cab93935cc7f..0d6ad50da046 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -365,9 +365,8 @@ static void bfusb_rx_complete(struct urb *urb)
 			buf   += 3;
 		}
 
-		if (count < len) {
+		if (count < len)
 			bt_dev_err(data->hdev, "block extends over URB buffer ranges");
-		}
 
 		if ((hdr & 0xe1) == 0xc1)
 			bfusb_recv_block(data, hdr, buf, len);
-- 
2.43.0

