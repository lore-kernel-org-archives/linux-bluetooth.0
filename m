Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB17369D7A
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065884; cv=none; b=C+0Kyb868hDRH8atTjW0mSi+JSsFo26KB+fH25b3u5LhheMYgyrcAGUwWAC0ChGM2mS9BrVUE1Q7uSc0wemHTJo5OXJh9ub3zCMqQ9vppOIELdz7iZv//7oaC9QO8uHmpSyhmkh17Jz6R/8w5U1LX3a91JVAB/yaJfDWHT1RPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065884; c=relaxed/simple;
	bh=kqnqQvNLJBEd031V7013pYVrxxAMk00Ah56uz7A3wQw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Bhna3/x2bNers7jwtFBzI0OfKxaIJd840ipy3Bw4JDsk6/jZhPgr4gpDZ746mi0vEpIwXvjwqIbFb9PYKx2WjyB+QoE/hJ8YIb3vNOBHyPcXQ8eGzOE2Hp7g/QL2XhALYwl9P2w+8zb43gy2Vj9zlp9YaKieZVrbbuGU20hTVJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+p891iP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+p891iP"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d560775ca2so53245845ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065883; x=1789670683; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A29EB82jaVWNQm5wVHRAMrYWpFphz8zeSobnCPOjfMw=;
        b=D+p891iPSVi+8HTgjyhzx9EY8zwB7AJLboPc4mW9ddMZHuLbKhOeJc4v/H+9sPxCHB
         gQZhZZcHV94xtcf4y0vHnozDlhub4C3TpfLpvOy6VFtT4aIYpVT6KD4lGO3K+6uJ1MdN
         T/Aw65x0n7iJtRLny2+qDoMFPB81g5Z3ZrPTxzQyVVieTRLSsRXfZJFYT1CgRA48vVm0
         UAE8wH4buMPrvmvl0nrVhYMCNAPx1hma9Sjrd0pQmTjjYpNt3UhYeg8U+qKKq1M8Rme2
         GeRuMIv6htkckjLR665eHAqMiztevVaawm8h3n23SnV/C8lBKZ7CJ53NdtNF02t6urwq
         sQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065883; x=1789670683;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A29EB82jaVWNQm5wVHRAMrYWpFphz8zeSobnCPOjfMw=;
        b=GP1GlYNkZS9I1rtC3WhVO7spyUZOY2jUvHSnyNa5Adxp2ixd5ssudgW0cWOwnEdMry
         k/tCTdT/GL1Re77gmjuxPzUNjANiT/GzSnvW/wKDRSrubiYrNnWdK9tX+h1Q93VtWsbH
         T/UWA5I97pEngR92MT8ZcA9jZXSmrue48ZX/BWXp89774dRzafMcsbw7zu3lufXMjPA9
         zDqN0x0xkPxuobyRI9yeuwjd0jSEJ+rx7x5GtLRZcEpNKO0V1tjI3G/vqRCb4kRcXk35
         Bf5Ey8bP62VKU7nTI0yD8R5R3opqTekSl3G8+HuxUax0h2u4XmYcjaBt3H+5uJwYPPLT
         suZw==
X-Gm-Message-State: AFuF++lzshs6A5segr/tIeWdEyQWjDN7cdUmm9aQIYmwjNSeIIULbrB0
	fvh3DRhCX9NGVOGgc3Hgy4W1tbM7VDuJ0SnRS0mQG/D35fUO9RbO02WR+jPpeA==
X-Gm-Gg: AYBFou22ELGtuRLmKIVLW/+MiXJGaTOoRBAXFNzstFCHj9znqwUFtsghjl83g7+unM6
	yiPxG3/f2fJL89vm2wmuu9c186iUWJKPJWgyfDWKwrgcp1oNfyee5J2R2lprW1YqyIfvX63CZHe
	U145XnmJNwS7DiNpqmLdg/4LMhvZnO0ABFo9VX1+k6rr8KIGL5s+Vm7ffpZsZZTkSgVZdlG2B1s
	r22NRdwlUBZgkHqckTXiAA3R/0JuwkD1OQCKsYudCKSGV7FqWgx+t1t+ujh+AYzXoPrC1c0dZuw
	uEbnX1BDXDphEgp5Rwdol0aAs6yWrysFzS5Ztde4wAl7N7Xqf4wsjz0PoYL8nRzVw9tIRNn3z1b
	G7DNzmhGlAL/b156ggXxShdT1cbyq1GQx2FQeRxrEUld2QzW1Ppl42NRCHUOVOY4jaWJC2O4LfL
	wOFT5KKjzsoEGBLjxeYLZ+cUcEc7TR3z63aw0DrgC7eRcSHaZOvYeVg39TQwbArdrj9VWFzRrhh
	Wd1uQ==
X-Received: by 2002:a17:902:db01:b0:2d5:3f5f:e645 with SMTP id d9443c01a7336-2dd2a33d425mr12925485ad.12.1789065882669;
        Thu, 10 Sep 2026 11:44:42 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.235.215])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e5193dsm1094eec.10.2026.09.10.11.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:44:41 -0700 (PDT)
Message-ID: <6aa2fa99.21256627.57fe3.03e9@mx.google.com>
Date: Thu, 10 Sep 2026 11:44:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2341787107327790890=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 13875017792@163.com
Subject: RE: Bluetooth: btmtksdio: Do not fail probe on wakeup init failure
In-Reply-To: <20260825084321.3544900-1-13875017792@163.com>
References: <20260825084321.3544900-1-13875017792@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2341787107327790890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1151352/

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      28.77 seconds
CheckAllWarning               PASS      33.50 seconds
CheckSparse                   PASS      39.65 seconds
BuildKernel32                 PASS      30.61 seconds
CheckKernelLLVM               PASS      35.37 seconds
TestRunnerSetup               PASS      779.21 seconds
IncrementalBuild              PASS      27.44 seconds



https://github.com/bluez/bluetooth-next/pull/745

---
Regards,
Linux Bluetooth


--===============2341787107327790890==--
