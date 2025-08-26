Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC5A2BEC23
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204135; cv=none; b=SmozARVajz1IzzCQ5KGnDKMlNIiNt4/2LiZe64mdLjpLWKsdhW6+YsrpBTTf0PFwF6+dVtvtn7KeyFDlo/YpiXJjlpb5LdJQZzqpjoP79sPVWlKJQMPotNszLK3XRrDppGBBpT7092GbmsvpMEBTWQ56YrJq9PAvH6amn4ynzds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204135; c=relaxed/simple;
	bh=dZOIYNvOvPU0Eas89bGhO/sAKy0yEVHSL/EfDcZWXNo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=b4lsFnP3XWPhJaWiHvykq3tWKqLDTbFpJ5+Z3iCoTSE8lCA/A2U0hzvz8tnDqIS4Kl1AYJU/NF5YeCTJAShyNaYEPVTmTz8QTbvfVviMgL12wEDwXCeQQnAllu1F5MpNUtKE05Vlnr6CsxbtmlAYFCnpTPxvH0dTh4rbBuArGcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ulq/1L9T; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ulq/1L9T"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-88432ccadeaso455803239f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 03:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756204132; x=1756808932; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k5Ayo91P6n4Oow1qLHUcxB4KBiKfr9im0syA8QzMGZY=;
        b=Ulq/1L9TFXS2kmEflnQKAVR0NVBVruHXG90OpF4r6pYrpYzpkJeknU07WR5EaB0Q2k
         o0+svvlHn9vekWYP9GAozCa5o1fymD6np0faMKvPvW0pc7HwhmdTdniQPsBRW+c3UN5a
         lhzCOeoyJwYPHNA09xGMEpzhuAiSEgzbD4T1WitxS55r0PfUh1J8/kegvnUJUnRrkkg8
         HwX6il4++BdVdhlnfU4vEIDjKI5erep8b2b17iEf8M5LGaTrBktglCvoMrwwtdJkm5DC
         hp7GH7TG3YYFNXND0kCpQcb5k+AU/C5g+M3j+QaysAfLE1GEzDgUoVK0dflWG7yIfpcf
         wDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756204132; x=1756808932;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5Ayo91P6n4Oow1qLHUcxB4KBiKfr9im0syA8QzMGZY=;
        b=TU7hSmpk1XKCVmvtocwoyJNVJyzRexvFR9En2xsPC7tBkVsQ+apInEl8B93gzBH9Xv
         QPSNopFEf0akTem/CyrH1/rTDyM+q+EP2gzUZFDWQYhBvOEFOONgfKv4usy/FaXIgpVu
         Ed7HTxdWavTNf0zSF9OlQTe27Whp/F6EbaEvL/i90g2UTmPaYyQJkiD/eqNJwmLouin8
         1qCQhejQn1AZ08SGv8bNQ1YVL0pYjqejD2AZStFTKv3qxpdfeqnOm/C2xU/5lh9N9E/B
         WyYclfy/BOUB/egte4z90j8N9Q2uJXgjvQbEgIHbB8fSHnUBbwtIfkJ0KW4hkJawSdVF
         yHaw==
X-Gm-Message-State: AOJu0YwX7o0n/z78H1XObhOR5jUOh/DyJx6ruQFKoFhvdff44/+vG2bu
	TSFvlLEjBJzJshmOEEOsi4pY84S3lVyb7iGiyBRZQdUNHZjTUMkvnyy2CrjzaA==
X-Gm-Gg: ASbGncuudN0YkUpCHjnDstUtJzHIqPNNnof/uNtU8UYP7lB2w+3OV2jAqT3hCug/3hu
	2emKJd7lIYGQJHGYnuRH9DoR7o0LueSqSXGhHVa8pdam6+jSFBlogQuxpH/xNHbmiV4c5UGJoA9
	CXE/J8ShRtceDzE8iYB7fLFvCxQyvY82p28bmbWMM2qRA10PkDOCTJeV16jzIU4VpUrB4L83VPE
	kome0Z++AU+UzXkgBaVgDzlH7qh61JgJCpAVr5vABbmhgbi+tAO2CkaJF0qypdQWcBUb9jElGxy
	Tl/5I8/eRkAhmQFhNtWe2ZsDOjk3FmV+uVwJGC6xdFMopK4CperqMQO6cnEpl6IiXnlywTy9KTU
	stL6T+zmGc7XjCekrSDonU7szEhVc
X-Google-Smtp-Source: AGHT+IHE2q19G/LFmA2dVal1+w59TjSKDfUpYU40o2iMFc2DSyttdieUVkUOv5zrMUS3w6rurPwCQg==
X-Received: by 2002:a05:6602:1584:b0:881:802b:8859 with SMTP id ca18e2360f4ac-886bd0f5f64mr2200498339f.3.1756204132547;
        Tue, 26 Aug 2025 03:28:52 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.108.17])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886dca274f3sm359157039f.0.2025.08.26.03.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 03:28:52 -0700 (PDT)
Message-ID: <68ad8c64.050a0220.362f74.6f90@mx.google.com>
Date: Tue, 26 Aug 2025 03:28:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2098809651663210040=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] obexd: client: Fix connect RX MTU
In-Reply-To: <20250826090543.122484-1-frederic.danis@collabora.com>
References: <20250826090543.122484-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2098809651663210040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=995586

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.06 seconds
BluezMake                     PASS      2614.40 seconds
MakeCheck                     PASS      19.93 seconds
MakeDistcheck                 PASS      182.12 seconds
CheckValgrind                 PASS      233.99 seconds
CheckSmatch                   PASS      304.90 seconds
bluezmakeextell               PASS      126.83 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      898.83 seconds

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


--===============2098809651663210040==--
