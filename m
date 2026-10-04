Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAEF2772D
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Oct 2026 00:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791072158; cv=none; b=HB9PNNsTQ6b6Xxy2b2/+HG/vbsg/sAD0WN+sKeCq5hY6IUH9kwwKYXyCkIMmjMv+Tx1w0YkejF+kNGhNPOVRQ4Iol32u7M2NlLYviQNt+iazww30VMON3gp2ikMw2vmgiJlXKEpOhvKqReIzWV4Dvmhm/i4BzsYmkJvIDsnPHp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791072158; c=relaxed/simple;
	bh=CJ/XdKPBmVhGtI9pvyjg5/9B0BjWlEmWXvVWawwUpwI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BSAMknqSq4QmV2ooWTo7KSGS18Z/6e3uX1BMX9XsSR43HutdqdOfOr//Ap4rLrqz8i4F2Gs+PEWaMAB1qMqCsf2xvc4nsTPw0wN7qC5xxCS2HkMhLUmF+CEGuF7wm5c3gOD3K0H9mJoP31o8WbLKozwcn4kuOSPVtKYvxTLIY2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZJ6NpdD; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZJ6NpdD"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53440816851so8426321cf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Oct 2026 17:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791072156; x=1791676956; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j8yy8dUDKbPXVUHMPVYqCkQ7s2Rox46g7b4nN9n+HaI=;
        b=TZJ6NpdDvxgK9oLs6hOY95wxSyIV5CS3aPX7V2y+4niUgdojgqb5EGvE18ZsxfAiPQ
         rP4aQ5XSbJ6rAIn+g4avt4QO0dVij2ZymmF3kKqSXT2CTZ52PIcJoX/RGsJ0iB+aVZM/
         08jigRZwbkYRSlHdHhQJ/DCzpaU1o5LL+f6AHbN7JdlohRaLOpKiUWCap7E5mqRdQ/P3
         iPmW9YTW7aT9lgKwwoczGpc2R95cMAWOKM1AwXKlbvda84LZ47/WKOBJN/T1yir9e0k/
         nIo83srboOlVKPXLsNB17mvYkTvT2dc8gH/RTpD4IvWvNu6ECrZKmyNeY7RrNaWK42IW
         yjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791072156; x=1791676956;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j8yy8dUDKbPXVUHMPVYqCkQ7s2Rox46g7b4nN9n+HaI=;
        b=ecMpljHoqUyTV+UddD0sIICqrwSlJusDnP3Hkl9piuxGSa08c/cUqTWn01YRE7R5Cy
         Z5uRPa718B5/wDc0q0dc13zGdHkMqgaT3BFYIZ1cqaMB0RO/+MwLhCA1A4GXmzWPt+2k
         EFUwrKg44UZn3YF4y15F7afvLExQByu6uxc5f8pr6FdBOhHFLGif8rEFKRl1Q0Yj80A4
         wDTfZA5wLDk4fusB4osM3mBFPavi4CG62ga/NUx8155UL1/ITuy3xHzrLNG3UHmVN3kz
         aSB8WUqQA0NKJ/BZi30603w4XYC9efE2TDvLRW2pLb2BQLO9FtSnHuX0m5Bdu8KJ2w66
         HmxQ==
X-Gm-Message-State: AFuF++kdTIZ64bUAOabLpIZbrXRSwp7FvYIqsXfEA9VtafGSG/lQ2phn
	/J2/DwZDcO4VaQGJiMeRrysnutrauod2sTXt9lXVYHtAusScZcd8h9zQT0UCMn1o
X-Gm-Gg: AYBFou2zl65Xic7X+oB7v5eTWuKkVJKV0P4mKPQsOTpoGpjXiS/1l6WXBd5Ko4qFwgH
	4aQVKA0cw5q9vi5K6GNmlRzdKIi8O2wYTxzrw1O7cuoKfu433YOUAI+8yn0YHL6SnRmmF7fkqZq
	BuGCD/ED1+9geBWJ8C5BCVzBe9kfN7PuyoIzGlsfKr9gXW7b+1rk2K1wWFhlV8fzWmgf+OpVwSn
	xRyOiL1HBwynevdDga3ZJ5FoNYiPwx/PiYP74un1/sty/dJdWfEb90dN0T6O9HJCqFDS7EOoXEn
	kps+UJ4Uo77vyOjyveOaW+rD5XXNFQjBwNyehy0LjfSDumvMIeR8zc7HV6ytV4S1zjIYonVzDiH
	g94DANlVcuMDCLZ0xwD0rEVsH6xbOJapK7AElNKGa7+CFZYkzMC44RZAeYE8/yRxtmL1ri1yy5t
	Xq0eUbDFKMPzkqEy+U/8nQiM2wMfTFp1oDe3tb+lnrcQAOMUUYiPE2xiP8lR2+j9q4qxm+mmS3j
	SAO9A==
X-Received: by 2002:ac8:5d05:0:b0:533:972e:1f with SMTP id d75a77b69052e-53511b4f052mr64530051cf.4.1791072155836;
        Sat, 03 Oct 2026 17:02:35 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.25.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398bdd010sm63331821cf.19.2026.10.03.17.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 17:02:35 -0700 (PDT)
Message-ID: <6ac1979b.2d0a4cdb.13dd3d.ea0b@mx.google.com>
Date: Sat, 03 Oct 2026 17:02:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5492784762670700397=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, derektern@proton.me
Subject: RE: [BlueZ,1/3] transport: Preserve Release on late BAP ready
In-Reply-To: <5yh1Rc6x2sD0mB4Zq0o-3_jmYYKB43NbYyd-ZXGrHGZRN61HyoWYmLVVTTHE2-SyPhNj8g2ktGAB0Zy_Jnq-Htnc1JspqPSHvIsZDC3KFlM=@proton.me>
References: <5yh1Rc6x2sD0mB4Zq0o-3_jmYYKB43NbYyd-ZXGrHGZRN61HyoWYmLVVTTHE2-SyPhNj8g2ktGAB0Zy_Jnq-Htnc1JspqPSHvIsZDC3KFlM=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5492784762670700397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,1/3] transport: Preserve Release on late BAP ready
   Pull Request: https://github.com/bluez/bluez/pull/2550
   Created:      2026-09-18 22:25:01+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============5492784762670700397==--
