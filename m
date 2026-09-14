Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8B937F339
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789412616; cv=none; b=iVpkJhwuTcTwKBglAxlk5EIwF2wCkueMC0/wA3KYPW9Er8eUS9TQlhmqgxudNt2w8t8LvewO9VTZz80NI4y7/i9nSvwiJX3bIUYskNGkOjVwqJ0ky8xy7boaZpRNkU6OTcbDgntqwWaKmuyd/jYOAYS7YKyiLtKlgd3lGZVaQlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789412616; c=relaxed/simple;
	bh=Z9l3Zipg+W64/JSEOWnD+varsa4ADEItwvzx2MzsPyI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Fm6XWZxPQ2XDuVNaqvjWGrJxHwNA/SNUTGNaSlbif6+SbOB3H+QHw4I4Sli8D7VMWWGRy9W+0tHlRa0VVuLMYXyLuBMC9/u6BISezBuBV6vGlW+8iMAWODfutYcgTsYdi5D3CwXfWq8J0Bq64V25b5FmwjUF+khw9iQrqBJEQ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLALlx11; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLALlx11"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9121fe38733so24039286d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 12:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789412611; x=1790017411; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z9l3Zipg+W64/JSEOWnD+varsa4ADEItwvzx2MzsPyI=;
        b=kLALlx11vSjPyYKtf4TRUo4Sc0TRSHVTOAyYiag7Gbic6FSptvpQLkkgu/5FvrimEB
         f7Zpx3l4dQsYL47Hr+04ZK/zpyRms8PFYTAJxdfrA9aLaIGee/8W59imJMX9c43zgZkB
         5dTie12A3K1dlpZ1oFrbT6TQrBMeGlT7Pe4WW/nRO6iGkVHl8LqdSCCi3asNFR9KudWA
         BZVRVX3N8oMvAEH2u0ZCDAdyT3S8UmxlMXJaxUGMXzjt1yxNBKqITopE4mDSz43NFYFi
         tZGpzOrikZOBMTqNiDEe6Mg2Ptq7MWdUvDCfvXWYaBmx/A206aPGjN/+4Wrs1kKC5WDu
         wpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789412611; x=1790017411;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z9l3Zipg+W64/JSEOWnD+varsa4ADEItwvzx2MzsPyI=;
        b=pT83mn+3aVhuXXiHOsqfNBr1o+rCn8CWbxJvqynu0akH3Yzg91VvQfcF9XqbY0u6vP
         7Kx8Ra0HMCd1UxpdI0gQP/35dY5Y5/N9no8FQAGgDE8XWlUDZ0djR8a/LG2a4aQC3yGs
         jKvZA5aJ0iV6+UHY79ksh8ZVyxEhrNEAkRJ2ExHTi+oZSur+2407Kd78KyWavHHTsqrx
         dlP8a+yW+GnIuDP0SaKhIVnnVypjuZwueKMmmdPkNJzn2J+eJsBtFt2VsNceZlxFmiOk
         2iHsh4WROcDjVSG5JsrqOe4Sb4kQRpaHYmsM+BHaEJkFoR65f9KyuuEackfzMnMDu+BH
         k/Lg==
X-Gm-Message-State: AFuF++l4X57Gbfsmy8tEra5U8lYcmPbgg5hd2Kw3OeWUmeDlFNLQFAh5
	E8SGqkLru7syfiDPehcdXF+nbQ7oV+V7Owr/HAcJGyUuxUVfu2VDOJMcKaLrtg==
X-Gm-Gg: AYBFou14IwotQxOKt1B+XZWiru/LIZ/wpI8bmI8/yPuyKLT/WR5/e2OKezMKRmwAWtH
	YJ7NYLF7NSLH25rYLTi14+lCH7Pk9PI8R+VCJhzfhTr18pKBAIwFXX0RozvXEhp6xTwaShRNANX
	FuS1IJWiNKNmyA6fC7H0ThhsJ6l6JIiqSU7PYkwYlaLQ5xkb4G1L3gKr1Ao85hSzSEb9GcywN6L
	7uOZkWIW4SMGSzvb+njcISVw/Eu4eQY5JluOcNvkIdk8gxXjI24Rky4oThP2MjjYAf3GVBNnFte
	19Z0m3h6Jb+Vi3LS/X7S/Sa8Hr+46Xs+10o9rJYZsAt4ljOv9jBXM+xPiw1HsdZ8LeN4aDJjboF
	ZSVoNvpZ39YPGMgGBLGjjrkQVoHdLMBxoQ1ZPA4Q+XksJdNN2JrHEb5K0KM7RbyVLSqf4g1AHIV
	mBdMVbcZgwfpNtMqEVStJ63OWJvwem+lf9Xwo6SYmdQ3tK1XTOh4npNUbLo8AFd0StFhQ9uln8p
	j2aPg==
X-Received: by 2002:a05:6214:5084:b0:910:346f:1027 with SMTP id 6a1803df08f44-9122e680745mr61742876d6.37.1789412610614;
        Mon, 14 Sep 2026 12:03:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f5e880csm100856296d6.49.2026.09.14.12.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 12:03:30 -0700 (PDT)
Message-ID: <6aa84502.8bd82347.209d6f.4739@mx.google.com>
Date: Mon, 14 Sep 2026 12:03:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1843061340240365292=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] doc: test-runner: document the virtual machine architecture
In-Reply-To: <20260914175136.613532-1-luiz.dentz@gmail.com>
References: <20260914175136.613532-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1843061340240365292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: doc/test-runner.rst:25
error: doc/test-runner.rst: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1843061340240365292==--
