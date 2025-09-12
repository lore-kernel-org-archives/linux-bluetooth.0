Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E4C1B87E8
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757643569; cv=none; b=pg0IN4e7R6rsJbs3lpui9CY7iQjVh30dKnh5Wl5twjYJAiWQ2zd8/NG2pF4XeJNETWmYX9RFxxSiJp/hhmWTjZXi9h23E6U2p0UyX8tJoQqV2Aan/yQjhv/SJ1oo4Q85TjPZIanLQWef1rFKFnOe4TMqgdjiU19/uon+m3yfioQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757643569; c=relaxed/simple;
	bh=J5SAQwYNN7zv4JXbLOC0v2vBGgwsJ2z8e+0MRl9s4GE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=A2lOqP2Ixbke6OBR3vhyxqpXuooytjf23AyQVa7iWlh1SGgN1k0CUuZ88U+TRLDP+HkYsg/0GUiESfJbUYsG94MnVwJG2Oy6Wa5Qj9LppxkNjDLucJZFwhT2QMDb4vwjbYMpDvfrW2OEQdbSkDxoM5yhRz7YiJYG0QNwHTvSAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLLMHKwI; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLLMHKwI"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7222f8f2b44so12352956d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 19:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757643566; x=1758248366; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5m/YkxfUZiMvBQwdfDZgVMYVoCll73i1FzT5NjgGmSA=;
        b=mLLMHKwIU173tHxjc8xXGC0era9dHgnJs/2nsjua9CAUpm+IKsKmm6KOvPJz8i3N+t
         tSwJMgxLB4iTYEXPA6LxxsCMNEJMeZHUenD3JywfBKOl6rjLoHcYDcJj59hxaXQsr5L7
         tGG4qhaV5Q+temeeMvlWeGkBnGFDfmvQ7JiLP8CMx3FS16r8OdX16b3d6W3cUE2FoxhI
         W6M929orkAtJOPVVOQ3ew04iCBt70fhmy3yyQDdHw2l2ntnCMj53w7P3GKWVXE/U98W9
         3CleCBHYbva6G7axiYQ/UJ+IIkJQzkFNou+MiQlNLqp+gs2zPiS8AMwAQ52qr6NUZ6pL
         NxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757643566; x=1758248366;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5m/YkxfUZiMvBQwdfDZgVMYVoCll73i1FzT5NjgGmSA=;
        b=AA0z1Giu+ATIMVd50LZ34GOJFjHjKYvzOMqvmU3vlUsXGf0q0LtsvKyZ8umkLbxd5j
         9KBiMke47kzMLIV4rVOvZps4/pAPuHuO5YzVU8g5DwiNhcPqvSiVr3isOU2cIIPCA0wr
         gioXNHPMS7gHcfoL2FVEvCdd6ROHX9Vdoel1NobAupUSdI91r1q88fN+vLbqYpxcM/fd
         Z0wzNd3jrY09xEaHlC5SkpH//3rO+PyCw+ME36EpO0i43w0sl5ipNb1alhKYciUc/oAC
         u+Y2Haxbz7IAX1MOWLSshk5trv+BQ+JM2wgRBKwtbRmglzUjVWmykDpMuLVmN47JipKK
         54UA==
X-Gm-Message-State: AOJu0Ywy0/48PwIvRNZIEn9OOYe0BgKNxCpYtV2EZfMwL/+6JP6afIZs
	tYI7cQn5CZs4sPzdM4yC2aXnb5NGw6P6g3rkLqXAQF7KKFWtUgMJojdVnusTUH7O
X-Gm-Gg: ASbGnctUXjLBvX87m7C9dxGxA4fe34MQTG6F6GjKJQehxO0lZ37EsYRX1phofSAnyzu
	5zpcy4jhFBX3QvA6vZ37ylIwPtVandrqAo62Arkk3ZB4YoAlAUA2cUg726M9Y8/9WRh3JIlhOLp
	wfZc5sqGgL39TNpv/O9t5bJMldICS7j8D9+woRH3VSepZl4pR8MAwJRforLzl4gVxKhCDkyBL1i
	VwKaFeNICPEfP8YR12Mdaf/lZjYGSUFPpDam2WUbdu3lB8gAifkvt1Z0ogRpRyL+o0YVkZza7XW
	wFAABaQ2Fqgv1jMkMaqJDbr3RoiYPlt3iXCbJzwllEx+4ySbpUs9CReKl5X9X/WhYy65UWuy26/
	6oc8luTwL5K2kgKFaFjpgifBz3UsYxA==
X-Google-Smtp-Source: AGHT+IEDlg5yzD5MCMRfctrkqpUh9mX1CcbCjOZ5kS/+LbdGDYD+1yGmVEBgcqEn5hLpgafyyvrkfg==
X-Received: by 2002:a05:6214:250b:b0:726:a561:87cc with SMTP id 6a1803df08f44-767c3d33132mr18938346d6.58.1757643566359;
        Thu, 11 Sep 2025 19:19:26 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.237.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763bf3424a8sm19435766d6.55.2025.09.11.19.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:19:25 -0700 (PDT)
Message-ID: <68c3832d.050a0220.3b3a62.65c8@mx.google.com>
Date: Thu, 11 Sep 2025 19:19:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7071031750299797698=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] transport: Fix build with A2DP support disabled
In-Reply-To: <20250912003233.931520-1-hadess@hadess.net>
References: <20250912003233.931520-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7071031750299797698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1001555

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.01 seconds
BluezMake                     PASS      2523.90 seconds
MakeCheck                     PASS      19.96 seconds
MakeDistcheck                 PASS      185.95 seconds
CheckValgrind                 PASS      235.61 seconds
CheckSmatch                   PASS      305.31 seconds
bluezmakeextell               PASS      127.97 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      911.05 seconds

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


--===============7071031750299797698==--
