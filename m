Received: from sonic306-1.consmr.mail.bf2.yahoo.com (sonic306-1.consmr.mail.bf2.yahoo.com [74.6.132.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B0D10E5
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738154728; cv=none; b=cF31IRcNlGGgQG/u24nJldV5+5lAa8IULaNrj+4gngmYPvOt/WAdmRqlpwM/mcju9H0Ho58u7m2os/+iH74mjjR7V7yf4EqaUvT3tk/KeQ7x04nyO3Xll4peNnvlFIx2CZoDqzV9GgNvU2UUvHwpBXAULY2M4btpGjjVHQbheZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738154728; c=relaxed/simple;
	bh=nZO1wYye7LlBVRlHKDF1aPDPsYxWawpZC+Vw8ihpqek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=ESDzR/U5Vx2d2Sqn+pYi4hQb8oylnX7le/tMDD9NORV7JB5enBXxXLvDJASz9HEDEyMpfWUmn8EpHUX0nUs/5k8kPU+Xzdsznjxn3X5ujFRpKbVgOiYyYtc2L8VwmKQcvIPpK57cw4ToIwrutdjey+U/d0riGKdugUPpZK9Xzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Vd8ljhL3; arc=none smtp.client-ip=74.6.132.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Vd8ljhL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738154719; bh=Jj3o2NnuV+nc0k8BMVD9R5sl0D3ymPcnehOXjzM1RjE=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Vd8ljhL3T6whR8efu8UrLVDHBCrxDLy58lij0EMzfoMt0DLL4Nv8UZJpEldnAN93bu191NOz1jj7V8UDCSdcB8yauPWSO8v3P8LY/E4nLd38lLpjxhFx8jpW9bSphhI67bMEXcg8+iYqip84/5xiWpfoZLnSLdG08LKCExGRi1d3F3smJWTLxUSyVJQvXMBngMKqTa6aSKdVsvXeXXhaUBlGu+/eeSzelzm2NOJwiaNL/MW1t+qrcfpnxURIFdT+O+jemLujMdMti+H7LTs/0UlI8AxVIRnzHwMweMalJEk/wgry9xqxe53Px3jwY+Dp55Vm1AramkQYUehnj1T9Xw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738154719; bh=EGAAR/wJMRFRgH3ur73XtmQzknnZGyXyOP9V6zQPpPe=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=H/paht5CcX4Q/+U0oPwvLs8FnFGlEy+e4Pw9KJ4Zd4enW/pNTHrJ93iwrS88FXi9BV78VNY88ez7ZPGcqyHURJ8oCDaZlHhiUPYCHajuE0sd0OHmlHuqbo79BrG7jmHgg9C267XAarjc+oaWRnJXqXS5JVKh9TPGdTSogZLUWb44GZoVxsu2J0KAnLJMXkrpIc/xNRRKK43o9z2zlO89B24LHq0HFyAHp6L9+DC2J258ymYCVvCGceLiqOppW+cqYcm3HwF24xbM44O2U8aJbBkx8X31wN8wjUzsLxshv0NQknotEQ2cCifDCJVtffeojeEz8c+43yAXU+P0KoMorA==
X-YMail-OSG: MW8UFikVM1lEEfjHNMyRW6rfMy6iuxR8sod5DZTRlflYN2NKQ2xrwhoil_ztpkr
 GxGrEsmo9XOBTii_567VeqK_tZ3gaw65idjdmxbGzW9OQS2mZoAFQ2QaHGtoLAeIFyP_F254DjA9
 ztKXQ.JdZxX.Yh18LJZiyeJNI7iRNQd7vvZ2lkspUycOeg3UaZS5eUYrhJuRkG5Cb_EzJVFyXqgJ
 u__61wYBGyWgsiJfDhCI1hU4ntLY3H.rPZEyhPnFY1szlNGFMnFNxj36Xi2l_D7RCFRy_kWPfORI
 80.3M7.CqGjfJpxhK3KvoYNXtzeB5EU..UwQADQfArBZESCSDhEld_ShQXiChvcjX4yHpc9F4vqy
 _o6wMChkAYgDqN.UWVgy4qo5EUClGkfV_nQQQFqxwkwwzQx8vCi1DiJpIPIuGNitQEr8hPW8NzQl
 jNi2ImD9Lv0K9bhIWoRdL7QPk.vTF_VSgc8qqvJyp4J17jEukL_BiZzI9Wx6t7GgRbXwx1I3wd6r
 82Ot3AsSEGlJggSfoXTtgQqEObgBnaFW1HpRFjY9GZvE0aqWwz0YwmxTqTPTJG0ms48lSOr_g4oF
 mM5xyqsCrO3.Wb1uuN5Re3rgqVGBli_8mY_812AlVI5CZOL_54ffSrUsy5OZ3QOG2ZorvJoXwKzX
 nHld0pLPKedeX_.0zow8dzVeRLafXmhqTFFmQbLulpM7VL638odXXdDgNAWCqrN9IN0yQb0fuAPA
 kv4draRYi_SFv2l0h22_MLmJ8mSwAD4YNy6KTCQ4T8wkHT5A9nVTjriBjV7ECtiGJDYWX6GHC4y9
 yKUMtuMkIty.WYoDu6xSsG7SqJRcxvN974wVHYmbFVvWHchwakQ_wG6rP0gqRQTTUFq9QP2xjCYs
 PCMnAGoDfs.dLkbefhHbfhz7RsGkKfEWJSR9cd7RxnaTXpc_BYDZ4s4rcewl_Kmzce30NKDYCKWP
 Q5U_Z.DDGnDvut.7fgN._e9jVWPSGapEVNYXmTIr8.ESnzl_jsuhn4YQyOXkaQY0FlIfTqOrCZy0
 7TJH8BDaxonKEY9FxLk8ztqoRLYtU4680wujAkc2q.DLlvPuhVvx9S9QYwZnu8CkOacA3bedn2qH
 dUz5W7pnmzpxJHbgHla65rFQSEwHhYyK7eWjHlsvpazJewfqg96DXGbFJbh9h.i4fMd6yTz_YdTY
 HKD.S9NrK5g4M1nVfJ0e4UPnjgnZIcjp8JbVFfoLlZy67p93kYl1N4ZDJ1UGgQ2TWF9ACUZ730rE
 BfUlXmlHINLBpf2RBZtU.QvdP5s78jopBDpp4magG.CJbBeTVXyf0SwNWbMpRRnhgzPFkffEbN1u
 6c4Se1Iz9MLBmaMe9.0pa6Uco9IDqoayozCvpeptwesDFxZRwLyJARxE0yjppzM2_3l5nPvsPTLV
 m25xKvmNmMY2gMZAgSYycpMkXPs8ST5etPAIvPvHK0DlG9s5Qy.gYiins117bxAXKIa5qlwO27XQ
 oC5xS7IkmRQaHVKnwBChDx_zgTAxtiTgqNXKinOKG4EZjjGLQeyKmH6BGbcyXaalHxgBhNq7xu73
 0RkFoOTaScPm9ir1Kqg4aqfW5MmobzS3rM_Tm2n2SqPzO62WY4440VaxJAkMg3uBRq.4QQxZ3RKU
 7lM9Mq27fWz5yedvVV2hEA6wN4rCMvu1w0vQ1bNyjU7C3r7TUrZx43YevXKKjdr5SgNd1YzLjg3h
 Rmqi8fdKmvS3rlwRVbeseM79vwUfyvEGLfMswgAa9TOwiLHWC1t1rCWlz5M9AjjyhR0geOgAyETE
 cDYW.XxXoitSGAsufM2CcbpvErTpiBvuW7kWoiHBUCq1DTgXz_G8h1_WnmSnIDQabkDQL.UU1PvW
 lU1wAs0PMAJ3qENa9WcREFYwWruoOy6RJMpiI17FF4bJFP082hMotEAWn84tYfhNWXW3xGYpgV4G
 MGfWL5IDv_RB6AxwZ.SsZ9VXxNFWtoViN38UNvvcJbRS75R3pzEefX5Dvo0XQxp5rivSJvUQSfQm
 MFCrzwtoYMrSCyjP0gEwp92TDP9DaIn2M.U26CqlRzRlo6e3SlXJDBtMcczkKQe_HhRd5Pwg.Hrn
 LHwFx3bP6qMlhkQUy5maY3qVVpLTCH81MGAAH_QLYU_ulojCa8AKTc3g7H4ldZhI0z4NNZqEcnWw
 5OoQ88PLUDmkACMe1X_0zW_6T7fNXOetw_PhJdGhbbV5axJ9OTdfgOOKFvd0VCqn367EZlu3_xiM
 Ti6OoTyGHle.FVx7uXnSbSOXGv5DJO6PjaA--
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: 6e0891a3-ecc6-4064-889b-597186bf5776
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Wed, 29 Jan 2025 12:45:19 +0000
Received: by hermes--production-ir2-c694d79d9-fn2jw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9e4b96c7d03ad5fa13685a6b7c128c9e;
          Wed, 29 Jan 2025 12:35:11 +0000 (UTC)
From: deaner92@yahoo.com
To: luiz.dentz@gmail.com
Cc: deaner92@yahoo.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	markus.elfring@web.de
Subject: [PATCH] Bluetooth: Fix code style warning
Date: Wed, 29 Jan 2025 13:33:30 +0100
Message-ID: <20250129123330.391567-2-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250129123330.391567-2-deaner92.ref@yahoo.com>

From: Jeremy Clifton <deaner92@yahoo.com>

Output of checkpatch shows warning:
drivers/bluetooth/bfusb.c:368: WARNING: braces {} are not necessary
for single statement blocks

Remove braces for single line statement.

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

