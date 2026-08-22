Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB992DB79F
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787419030; cv=none; b=NBMrbmECmGN9Ybz2X4uQ0T+Xxl87A1pIwR0+kaBJvbO6vKA9bfuGr4kY1Vc4kfQPCSeLKn6FQ37uhtAmd4ta7hRisvLKrTHUH+fU0geONSlisttlSfetDrZICjL/ItDd6FIU7tQ3prp0SaVB61dvylYP1IyX6/jdWq6PzGE7m6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787419030; c=relaxed/simple;
	bh=zJfy0z4GVsfSq4cL0INU13aVPqcPy8BpCCXwAEh58yk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mM7KAeUlCBYnJeTwlo+pqiJgN1tW1BPnOFqkk6ytihgcbLwxzrbAHN4OnUBcRyBm3ttVAN9c3ZKSkSOKUjpr06TEX4gh7gbSp+fa+qHZIlINrtDajugRizNRY+HWxYwadfagVxWxBtexIbcAWXF0Km0aC0QoWdF4U4bCR9rW0SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf1gfZQQ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf1gfZQQ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51bfa429aa6so18117441cf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787419028; x=1788023828; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7NJuGsrLP03ojklU5lwL9OVJcBYqjtPZ2MGUcXrpvd4=;
        b=gf1gfZQQgoZp2mVxG2OowWzfZeqCfz2La/rKBELDylDV/LBGNjX5zd/vyTkd3MMt5K
         9JOOvzEo5sa+AHK31pJHSr+vctDZ/IhhyJ3QNAEeLvmER8LpbZHg5iwLh1umsbrMU3wh
         dTQJczfkE8EryXmfgSz0Wy9v9YYeXi2MS0guth/aSt62baG1zeNuIvQ2cLFHZ8OuhFYV
         37ux1jNGGU/v3IDxIZUNO3sLrAFFMYCkhYiKtNteW7IHp4VPIDLDznnWXaRFoQqh2B8b
         W7LvFfnugu764su2lEqY0RYTBY9As/V2nHRANGlOb0/C/YIBBhnVqwhPgLOyEfTgKeba
         Kzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787419028; x=1788023828;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7NJuGsrLP03ojklU5lwL9OVJcBYqjtPZ2MGUcXrpvd4=;
        b=T06dEsRgQCZ2iCe8lWG6aHxdOTJfxdDJJuq50CJDcOptEJ0hzbCt5dT7nczqAsgkod
         WDWt2PP794wmy5sC8TlRC/FkLEJX0/uZIL+r2oCnYKdTmd6MSUFimPZ8vhtsa+HYQWki
         KttjbTDl7Bu6rumynFIxC3AFQyKofH/GEXxwElZxv5zRziM1mKh6LSSG1kDAhajHb8r9
         xz1TdwVTPNKQDJAMphtVkIipqCxkZJy3JDvq60JVvWc8l4jQwysbWH2h2o3hLqTz9iNO
         UO3DAtA7letozXPjiDf3CyZGVnG8tOrwREBfL/fVvfyY5gCraIoI02onAMLUOcansG4N
         temQ==
X-Gm-Message-State: AFuF++laBBZ/tIoGR1PmSjex+4ZmL3Mxcu9IIqh5qpHoJhLWB1zOEq9L
	4l3pUNgotQVZuy0xMNe+LTVqAMgyytnauYBjyH6cEd+lIpLHA9hU4FeO/ICW1Q==
X-Gm-Gg: AR+sD12qpKz/q6hxc8zefoqqBa/mVvJHF3v0sTd+AyFIS9GnurKgxznQYd2Dl5RZkUd
	/ApFv4ZaCUYps+CEBYxXr0oHysXk+XOCtABgHS2OpTR544qWoGKCLLvSXK89IjPIANpWJEDrBys
	ios5JeJV17uCsEf71DXfUGpmYdYM7rlVQUlT3abcK6piSDlixXzsFu+8u3aqFnLOmK18+zhU7D+
	ITzQH/OYUlHYO99kkQ0YyTHplHTra0uuNnmYx4gvEXSpdg4s4eBxG1ooTS9fP1Zmhpx/ujaVmU7
	MXH1OIlNyGKOcqKPqYFyzGowAUHNwB+T6mjzvuINAaSKePvf4FNP6+5LSMNXsIeUMKEHokFzE3b
	qaxVuYOMjQlx7WP83q0nGdPH2rP/z8SkoUNJ19G0z1UmXkKRqHKlNCkpvAzlezpyF0PYcjoFdta
	m7xV+GzN+sVWqbYFn2rtabsRaRHheq7IJmQdRwrE1PlzkOHtbOg7R5OLsNMijp97Hjujfq0sOks
	vkFyyE=
X-Received: by 2002:ac8:5fc6:0:b0:527:69ad:fceb with SMTP id d75a77b69052e-52df6193ecemr124167111cf.0.1787419027717;
        Sat, 22 Aug 2026 10:17:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.182.196])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e099ad287sm16668641cf.10.2026.08.22.10.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 10:17:07 -0700 (PDT)
Message-ID: <6a89d993.403c09ca.e46cc.cb1d@mx.google.com>
Date: Sat, 22 Aug 2026 10:17:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4787328385365597553=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: RFCOMM: serialize security confirmation handling
In-Reply-To: <20260822164341.3750491-1-nicoyip.dev@gmail.com>
References: <20260822164341.3750491-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4787328385365597553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1150221

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.58 seconds
CheckAllWarning               PASS      30.26 seconds
CheckSparse                   PASS      28.62 seconds
BuildKernel32                 PASS      26.36 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      501.85 seconds
TestRunner_rfcomm-tester      PASS      25.15 seconds
IncrementalBuild              PASS      25.32 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/636

---
Regards,
Linux Bluetooth


--===============4787328385365597553==--
