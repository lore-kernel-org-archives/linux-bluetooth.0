Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5549343D9E
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626314; cv=none; b=rkGUftKiBNbOjw0+IfNNPnlA6IA4q3jmv+arV7KxPyBKA/W2Evx6G0VUD+q886cmWagEMVjTwvTRzoFiE1D+IMsA5pO5gmDm/kVQooCPOduWDE7WE6HRrx0GPg/C2fRoIJGSF6WaWnsa7iWoeiNjPlB0xg2h0fVmo8Q8PEntIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626314; c=relaxed/simple;
	bh=27lb8WmQsy8ywoqCPK2JuNJ2uz0Z5bKb0jW1VbvKPRg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=USQAyyJDobqdtBDF2KKAMbXiYTIHECQ2eeiLKAvqy/eLqGerXdp3oxXTqd+6MpDQ46lkX+DNF2ux6vQlYfXBsYo/59BLyHArURswysq/hmoRPjWk/tWVf6TaHgGyH9W220j8WDhAKXiuoeaKNe5s858yPfeR/XKm9Bds59FLNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgI1gW6a; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgI1gW6a"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-430b45ba0e4so3789605ab.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760626306; x=1761231106; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3U0H5UcVZnetrDcBh7HfNeQO2UuphEsUkY1WdOgj1QI=;
        b=dgI1gW6aoGWwgOFaNe5/ZGBokLQAqalXH2IXAT0lOmQkfH2VrPEqMYcSttIHg/a+pe
         FOWj7sopk3iyNuWDp9EtDRlqACAZry1Wdz08MizZwhUbkGA1NqyHcG7/IoMWbKaTs0cw
         rRylSvUVYRVh4JTtLO2CGkTo363Bcf1VCKtnSSZkYa5TLSwgMajHtpn0CNKnIlN0n0Gd
         YlrUEZI3UTgJOn6hX94qFlwU6+OGd+7umfhNlsEOVYO9N4EfR7dxnk0wIekxTtu2RpAr
         NaBUIJLJQl7iOx9eYJxt72fA5U/zyVahrhxY1NQ0mRVZSCKMbf/bcNW5M0XRDuJ+y5l2
         UJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626306; x=1761231106;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3U0H5UcVZnetrDcBh7HfNeQO2UuphEsUkY1WdOgj1QI=;
        b=SPlYKrBiYx2pUk+2+fKQGD2AeR1oPFtJTIG8+tFT1G882llxO/DVyVAtYxrn3urZb4
         XIVcvfiBAXX9wUD0YRiXpj45+g/nQ/lo0xd/xdlUI5OmYdgze61qI42Ta7p1b+5fExsV
         Lmm4xHHDAM01F0ffqxhLgg398nA221I62bn/0dFeT1Hy7dcLImFf2wLtBomwnNS9bWF9
         7ht22XSxSgMsNgq6CeanXlp8ZQS3UhG5yj0QKt1oR2n3ls4xWaa2cAf8lwgITS88y4IH
         wG1mQyv7kvCXjnkHSYw/mzJ1vD+VjHlhHTo0IjMa5U+hIrO0zIgWP4Q2BZrR0uwnx7yR
         wrcw==
X-Gm-Message-State: AOJu0Yx/WvWYPL1WebfTRsYQQLOpGE0n1v2nnhCnWyVTkIvgDwM8eAAn
	Ta92LSfvT17nzCLJ85KBRP6iDsyT07VDUlDBHi/0gH4ARYh9fzRLROSqCvmIfA==
X-Gm-Gg: ASbGncuVpa1n9mldvo//y7T6bCiEXkCItrBw70t/6tJQHSo0TbPrjea7v/1PA0yOEgE
	62fexnCl5mMWqkm/ujZN9hL+XUt48yJZah+pYIPlYUUohBBuiYbjKiyadDNfq859V7a2DQZDg0l
	Nh3+fUI8Uep13GZ3M/3E4HrzoDYN5+PcytNVxR1wKX1Syw9a7eK8XE23aAYIOydm5xsh9GCaTN1
	I29cXnQie4dORDgAv0C12829UaBKb/ad/m6eaG9og88GrnHMpauwXoxmLWx4+3Kitzuwvn7ZO41
	NDL8PvZ7Cj2ZsHNNLl+SMG4TEpZElDS//Hcn3r6mTMrwo5ldzxK6VWidIHkwQT/AGsidsZNN1/T
	Wy7FarF9jRtdM7cn0Oj9FhK169Y5TKG3qKfBaiisWNt/R5RCNoPFSfnxyKovuLqHbjGzhJRTrjT
	ymnmVer8Y=
X-Google-Smtp-Source: AGHT+IHyKXnKc61r9emzy8qosnCdsmU2XUJcmjwbVVsCvoXpPJROMR0h6ZzqZh8x7tAVbzDiyHt4sg==
X-Received: by 2002:a05:6e02:3c04:b0:42e:d74:7260 with SMTP id e9e14a558f8ab-430c529edaamr7254415ab.29.1760626306095;
        Thu, 16 Oct 2025 07:51:46 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.80.134])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6d42a495sm6864573173.26.2025.10.16.07.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:51:45 -0700 (PDT)
Message-ID: <68f10681.050a0220.3203da.aff4@mx.google.com>
Date: Thu, 16 Oct 2025 07:51:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5543372434558435041=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] mgmt-tester: Fix handle value
In-Reply-To: <20251016131514.92485-1-luiz.dentz@gmail.com>
References: <20251016131514.92485-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5543372434558435041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1012365

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.42 seconds
BuildEll                      PASS      20.08 seconds
BluezMake                     PASS      2602.17 seconds
MakeCheck                     PASS      20.29 seconds
MakeDistcheck                 PASS      183.72 seconds
CheckValgrind                 PASS      236.77 seconds
CheckSmatch                   PASS      309.29 seconds
bluezmakeextell               PASS      128.61 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      917.50 seconds

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



---
Regards,
Linux Bluetooth


--===============5543372434558435041==--
