Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB6D339853
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775680256; cv=none; b=oxY7JklsWzn24+Nc+PEqRjD15AVC6V+maXSKqKnzeAP+3TbDAEuhOtIvuU1J90DV73e7JtAvEnDLpG+P8Jp9y4AlN9JZn4SHnRYvkwHGsPdOyr6MePR2a6StxhyA3B2uoDGj8/Pcq4GATrdQ7DvI7rb42qbY8EGehgCdBlwfU84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775680256; c=relaxed/simple;
	bh=HwqEZqyYZqSetD1sK9Vpv2zGZGWGt0agCdZf7FFso+I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VORXf3yqGjsA4EAZ1FDNq0mBQwmFEsuYxh0JLabZ8GVibptK9H3Nm11qAK3W/oRlW7lIkziO5o3lw09f2M1HM1/hyu1Bz7SyzbPcppaOg2U9p2QolZ/35tRZdl9WEZCWstEFbIjy3QynBMsn9rA4hABVnkaubzOAendo7r1q5Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/8iKM6E; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/8iKM6E"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d4f78fc9f6so22059085a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 13:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775680253; x=1776285053; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gz+oCf5wbYNWXKhptHcWRo9aX0KCy2f34ZLb2ZxTc/w=;
        b=S/8iKM6ELe+UGGSy/fCWeL0c6NJqhsEGXVR6LK1jm2baWGI56rOUFLYRadN18nT3oO
         /DezE1p9i4o6o8bGIq0SMO8HEA2xVyIljrm1MIXDxJGyGdv6rfbZfSUUkQMC9M7nJFT8
         nDZmMnVB0+jh/dJnLuiuMmcIOKZAfrgHzBiuSs2LpeA5HQfDvr247iO6vFJAuBZrw6Gc
         uKWYJvUFRuUlJ6Hu3Gbvoj7wH7hFIhzX5iwpVfBAkDguhfLQV9RP9Spx+Q8mMV1TKoiK
         QMaRS1DeR4pqRnjPCZ4e9KysFAL5jfsPoP6eiI6J77J8QB1jvxRXOsCA2ursq2eQA9CQ
         ZWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775680253; x=1776285053;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz+oCf5wbYNWXKhptHcWRo9aX0KCy2f34ZLb2ZxTc/w=;
        b=mUsAkSddOaOgbtgP2AzHFouN1asOnZ0nmbysrn/FFwGRf777IaMRL419MrcLuGAiFD
         7qJCfQurCgaQ58MPZ5wh7PPVkApqCeC+8/IGorg18XwOCtZRRncFSTOC6V+Xny4PC688
         uUw1YudixGnXjxyltNjv3jWZ/WVj+ofwHWUHHH80yR2x0bu2Mem2ZOq1pVLc7G0hPlnK
         wnbW7tzk7TneeXBeB9CCUddcAe0emOjX++GpwM6sQ+MY1g2rFfkqTm5afmN6og8QcYJs
         qZeYP4iGPuBSCuCR1sKhVOhJsFhb7NtyWGYm5mtEkkhMYOAQRRqLHubMyg/ddolEAi11
         7W/Q==
X-Gm-Message-State: AOJu0Ywz0IgySgY467PbVSNvBc6JnrzWCAx8Tt4sEnUVmvUXveidzawu
	/hPNLD252Uz/ox78fPPj1uErgUywNmgIPODdYngR6mGHs/gUAuwhzdlScXRaQQ==
X-Gm-Gg: AeBDieveH7tuzF3Wc3jOi6DVjCTmP/bew8uW263AtdsL+ieHYXfc75PRsZ5Hqs9Sb6V
	nn78iPb2l0DFfCrh4H3pBStgN0A/kHwjT/U5w3ICeIqOQmpicbYJwuYopcv1pkicd+PHHQAcJHM
	7qNpWEhMrZOVjm4UEknii4z3l0qetCZj+PJV2KUBsMiZ62ELOH+jfI7SC6do+6mRN6l3reRkWry
	O4eXt9nrPkz9QQ9ltsTcYm6cMU0/rSiDxVQLydSxQFBI/jIy3s0xrv5x9aL3Sz3KPleXsxdq8qF
	gihC1x/79JdpZJB3/j+/u88wfrWd3fqobUPyJF/JXAhhMMFFP0LQz5TQ1YT/p0qjBdKGaWzkg60
	RsIANOAgFDYrCt0zohjRFOJDmMbXRKgdbTV0Hc89zyBeI8xiBeBtzZQe5sehTcBnPKUWC/ysY2w
	x21g6UQ+t4rpGiIelP1MseiiLsI2vW
X-Received: by 2002:a05:620a:d85:b0:8cf:bcf7:fcf4 with SMTP id af79cd13be357-8dc3bbef705mr190803285a.22.1775680253065;
        Wed, 08 Apr 2026 13:30:53 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.79.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8067c73sm1536657085a.24.2026.04.08.13.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:30:52 -0700 (PDT)
Message-ID: <69d6bafc.050a0220.174754.bd77@mx.google.com>
Date: Wed, 08 Apr 2026 13:30:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4438394150544066534=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/3] device: Fix btd_device_connect_services not discovering
In-Reply-To: <20260408182223.295711-1-luiz.dentz@gmail.com>
References: <20260408182223.295711-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4438394150544066534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078829

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      20.33 seconds
BluezMake                     PASS      667.96 seconds
MakeCheck                     PASS      19.13 seconds
MakeDistcheck                 PASS      246.18 seconds
CheckValgrind                 PASS      293.08 seconds
CheckSmatch                   PASS      351.43 seconds
bluezmakeextell               PASS      182.70 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      1031.50 seconds

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



https://github.com/bluez/bluez/pull/2024/checks

---
Regards,
Linux Bluetooth


--===============4438394150544066534==--
