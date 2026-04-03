Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1692A36167E
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196762; cv=none; b=LifXP/g3tuE1dPKA+YXxwttd50oe6+W5oamf1CMd4bNeofWtjm/wuIvIsOdurgSoXsDzbir6FpvY+9Ottu5X+t2mZZIbjakvbPG1O4VqstAccAoDJhjJPXsRHGSes0kDRAARl88SvgQ/m+iRrTjC2oT2gW3w49y4I2qFYu6M75Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196762; c=relaxed/simple;
	bh=CqCP1Ey+iY5b9wVSc/KagduBS0bvuKqZww0JEJ+BxKo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gUdY5EWbiRSDoSNHla+Xjgiqr20ttGQiWHeXnQxxl3sSueEtzT6ILLvk5MzQ8aPnasVIIM/dLXMkTB225nIN/znio+EDYft5O7++Lew/RHZMIZDdfYM57I9lz451cYn2dsWzdXavxjnSkjaoDTfjZ8aKjiAdk1a0uGTCjLLZaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nyH7wOf5; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyH7wOf5"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb38e86cf2so164507085a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 23:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775196753; x=1775801553; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pH8pmInvn8z3rqBaIXoqQbVZRlR6tvpPtOSsNR/0XXA=;
        b=nyH7wOf5gUn7t1DhwMrWkxeHkfrU1A8VCCtiesLiw8+gZXHu0tUwZvNt+2ak8KZvnD
         besf8kn7cGryNPZicHa+mI36jIEjOKEenFYMBcEyQNxJSoyis6HiCAvGhtgIvVQQ8uyc
         x4KJzoT6JkSExaz65ni+AFA77HWq35Ga1abI02tkcTEvR9dNjJh/fJQcdggYW+AEJTHS
         2hryd9geJAfgjTRmA0NJJfreul/NaRuoPxaZpd+QYg0ulIfYkUgtoV4yveX5FpkCEljy
         HMb718O9GR/tW6MZTf5S8juIx4q7mix7+HdR1gItVy/rV2yaTFgs9PIFFpORPvvgF+qC
         r7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775196753; x=1775801553;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pH8pmInvn8z3rqBaIXoqQbVZRlR6tvpPtOSsNR/0XXA=;
        b=MzPYdrxmAJpeNyg/QBQZne23SOkdKwiX7NRQwcnWZMeCi89hVZFxHYzzLd42TBRxGI
         6XL2zem6ZkUzFDlEtLkUV1GADjCWYwchotCZgIYZmCsPkyUH2Gj9jCHfutAGe85jgO6A
         FkCuyzdrn1p3/gx34u1Ur3FV6KC+JODwvfsXEDwsyGfBmdVf0xJKdQMUsLTeAl2A6HK4
         Yl/LjpgaqGldt8wuhHp97wS/fDaone060+QL0Il11z8L7iFc1HK79jP4ghv6IFZFrXk7
         d0lNQRsPUQ4hnCf/Hp8mg6qPdeI2GcS8V3Vg9M9Ng6zi7e20NI0DjkHmgCP2F+j4pCWm
         yuZw==
X-Gm-Message-State: AOJu0Yw2l93U/GbPaoUhAUYduWobPLV/j8/NOqc+yLzuq1dpnRsPuE/Q
	ix0Vp0avAdYL74EvuztMnsphfzkiySyjcq8iRJYioys0MtNV6jeFUxTMaScV7A==
X-Gm-Gg: ATEYQzztI4LHGj2BU4AxdTuhpSBrC6n9CNHqkUWyeRrzgZBwRl8YeOYwnie2rT6Smxa
	8l7sDNAJGk5fAQNyH7eZVoQmOuk5uU9Bsf7r/oFCi9wb2BLz36yy0+2j5FIyOVAdQI7GsMCNcRA
	WRCoxuECZ66uid2pR7w2n1OgnzSeydPh1URMYkqFIlWNwqD+dN0PrL0RV7c6Sy80ZTJ4y6mFkTb
	EfoS1pD0ROzRZMjUZUtiH2geuNyUEYtxlPqK+6Rj+Ndy8FAy3vtBOYmiEnIXeHiuTpssnTJQ5zd
	X318ql5KjvUM56LKAP0PCAPPXoswuKxxm9H9hML5WJKDPqSgwGYj0npudAXHvF9WSUR2C3bMcXx
	HqlEpZD7GHwhepfb6oTSnYFOoSiCpjXRgRxiQ++1YTZrW2CqIhPTKk81BA2O4xBsyOlWeJg4U39
	I2cOnv+iNOPNntwqvv86gG+Bx5Gkxe27g=
X-Received: by 2002:a05:620a:690d:b0:8c7:c25:9e69 with SMTP id af79cd13be357-8d41edff42fmr295651885a.66.1775196752812;
        Thu, 02 Apr 2026 23:12:32 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.200.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8a30f9asm428168985a.40.2026.04.02.23.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 23:12:32 -0700 (PDT)
Message-ID: <69cf5a50.050a0220.2c5c57.ff18@mx.google.com>
Date: Thu, 02 Apr 2026 23:12:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6379193766474990418=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 294305068@qq.com
Subject: RE: [BlueZ] src/log.h: Add line number information to log output.
In-Reply-To: <tencent_B48D92FA1FDAD2A12B772500611B6FE3AD05@qq.com>
References: <tencent_B48D92FA1FDAD2A12B772500611B6FE3AD05@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6379193766474990418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1076781

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      19.82 seconds
BluezMake                     PASS      631.60 seconds
MakeCheck                     PASS      18.21 seconds
MakeDistcheck                 PASS      242.16 seconds
CheckValgrind                 PASS      287.18 seconds
CheckSmatch                   PASS      342.69 seconds
bluezmakeextell               PASS      185.03 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      991.52 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/2006/checks

---
Regards,
Linux Bluetooth


--===============6379193766474990418==--
