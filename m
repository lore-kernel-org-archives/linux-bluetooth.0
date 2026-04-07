Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0263C278156
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775600390; cv=none; b=mRZ/uY5S8XCEn53K5WlqtBnrAYFfJSDBgzouCkw8Nl65TpKFo8jhaZ1iXp9LhUhMLUK29g9Zk6hbR0+Bmt4k+i2XV6M6ZemuOxpa6GZj01RW+yXArEn5zNPs2ryuN79KLfSjubCv9WzQ30dfOM+X7Mo7cnRKvwjciZcOBpcm9iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775600390; c=relaxed/simple;
	bh=TozuIud1KJsR7G7rniOSDguUeI6lTC+3O5PzzCZ5hLo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bFq9waZ/FDfn0ncKNdzJdgpU8vr7Nz4ITaw2R8PO7HjD1wIp4VGhR6xu39XEWa9nbNfYy1kE0bi1IvjF43UPHSap+6E4Wu/ezTKwMpfMmlX21vlmLJdhTwjFPAEN8XRKHmPIDLvujLqMxPt+ZOpBcY5Gk870WWKmANfHnAIObZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7eyGv4S; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7eyGv4S"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba895adfeaso6038971eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 15:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775600388; x=1776205188; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jJYtjCBYXVsmFTQ+8KGDUwS1Cp0PWW6byM3fQmTHsp4=;
        b=S7eyGv4SDtZiwHkrnpnhN77gTroOraLQG+GbQAw2Sgzdsuwy23bEtVgEJmy9aRA+t8
         5M0VlOocW6y878jGU0wDlvKhWzQ+KollW8jMeW9GZALgE43u8o385kz3wScXZfogbp5g
         ZZTsIJcBt5dsq7NUXe+Vkj5cbYT3RZH+xtCa35qWIZKZtoMAIRL+bcEw9tprEGvE5UIU
         MFuH8PhfumrB1rE7AomaxKVCBzj57Lpb+HVatpXjyHdkH+PIwsC71HABjdXEZ3WN4QaX
         dIo9BW/UCkmEagGgDuoo4VupB5GffkyGGmhtOvS2LYof6L/JE2l4RbaEgnNWzcGqD4z5
         UczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775600388; x=1776205188;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJYtjCBYXVsmFTQ+8KGDUwS1Cp0PWW6byM3fQmTHsp4=;
        b=ZZLCsCVsEmIHkiRRz0FPcY4ii1r9aIeJPm2LqnuykEfUE+RhPTVprf6YMLHHuf5tvT
         33tnYYF0KHIZa875WeJ9yaN4BC8RnqlPllk/E5LcdyL8V7OEknCiQm28qY9BUSDEf6jK
         90xShPfsXt7qxN0ELgf6W69SNQwprt2EFRiYM+3bjEJJb483QyYbIWhqqZz5VtN3Sg/a
         klksLBg0VVkbDOA1dDkd2HvLjB3OelJAjJI7OIlPKr0i1m/9kfMrXRrCWrsBrZcYcHQh
         YzRRWVxiorM+TrYOhW2Ub8QaZZyv8M7qVLIds8CfzXiFEns4DRadKS2bP7gNcldHpl17
         9e8Q==
X-Gm-Message-State: AOJu0YwPTaHxoUZj37GIRp7nZTHL0QBEO+1ySo/cCghXHSvRV5ELRi5z
	mzN62B4d270hCUu4l4EqJv+V9RZQr8bdk4zUTuHHvldRBrjpeHbQd9GhHEhZlw==
X-Gm-Gg: AeBDieuR0x9Xcy0f+czjw6LeNt2MjfYtP9xJgcdrkp6xLHVCBBjSK99Pbjv2qvBghuW
	LfuqRcYhfT5kQy6XX8kuFPBQ2svjE1grrO0EowwYpOMzzeIuOGVBHOAS6W2RaKErdNKzDxLd2e6
	APWk4e5Ix7lHcbNxS/030gI2ufbpruLCNLKR5Imcq7oomfMRPpw/Xy9Otv7gMFtY3fG8O6l5IoR
	X+ClmdE3D8x29lJ3U/4WJ19Z9y81wKSdZwkv+Qdoneu35hJDfu6DsKamlA1CX0sJyF4PQ/ex+XK
	7gIHKufQOhMR4D3KlKHP0c54tlGGBfV0jfsvXDbDtXgY7eL1Z6iNh+0pX57FaqNSsBoxAvElbV3
	52SblKJPShDQixgaPNeXN1T/j91pOXapg+TuA5YBAtsYUwRKS/MADJSVCkupqMmLGZNKuPwThKq
	edzsXA8DiUgzbawFUv3Cx0j5NXDHa6/PM=
X-Received: by 2002:a05:7300:214d:b0:2c4:c4ef:48f7 with SMTP id 5a478bee46e88-2cbf9afd2e8mr10069162eec.11.1775600387663;
        Tue, 07 Apr 2026 15:19:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.126.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cee97ff4e8sm9955181eec.25.2026.04.07.15.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 15:19:47 -0700 (PDT)
Message-ID: <69d58303.050a0220.e6bae.dc19@mx.google.com>
Date: Tue, 07 Apr 2026 15:19:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6206466609750828110=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] device: Fix btd_device_connect_services not discovering
In-Reply-To: <20260407211229.61232-1-luiz.dentz@gmail.com>
References: <20260407211229.61232-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6206466609750828110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078371

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.48 seconds
BuildEll                      PASS      20.04 seconds
BluezMake                     PASS      633.51 seconds
MakeCheck                     PASS      18.28 seconds
MakeDistcheck                 PASS      242.67 seconds
CheckValgrind                 PASS      291.12 seconds
CheckSmatch                   PASS      345.76 seconds
bluezmakeextell               PASS      180.75 seconds
IncrementalBuild              PENDING   0.43 seconds
ScanBuild                     PASS      1014.54 seconds

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



https://github.com/bluez/bluez/pull/2023/checks

---
Regards,
Linux Bluetooth


--===============6206466609750828110==--
