Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DCDDDCD
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469584; cv=none; b=T31lUzaYDCy7mdjB5cCsIgQ9rmkoCqfMsMY7/z0Un0+Y8efi3vNiSwyQ2OveZJhEVJtU2ObAA4Hu6CpPWVjEGU3bin4uywt9U0DG5P9KCZfHUFDLdLCVkbsk4irflMD/nNTEhtL9bJpzmkDhmDshDeX/z6RxyNyHwsozu5fVs38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469584; c=relaxed/simple;
	bh=+aUUtjFvxz7xpPCtv2O3kdO4rNkMhW0Np5dZIimUhCY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RggOxizSdWeRBj+aO/VqddF3LCepiNxLlvczUaZgnQKX7sBGfnk6A6I4ITBg3Ozsv6/bd74Ya4G68zusEldCbErHKcv0vby/qmiMOOC7JgXxVTzpbShaz2GnGYwJ2XhDH/T5NRUph9EDLGCk92x9i3umfKVP2mOH6k9puVHevMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCDqqVGn; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCDqqVGn"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d7653db148so132740a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 13:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774469582; x=1775074382; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HbcYmZTYUVQCmTOU0XwdJApnREBTC+IfGYYb0BZAAb8=;
        b=GCDqqVGnsW3FCNCDnlpUihTV1xguv659167SuT7Mz71E1MHreX9Fui1maXP6cKpcK1
         jv5vjplNSgIkwG64gYTkkGcAbQM2+pTf2aBmp5bajActzj/ufc5lIRwT6yWBSJ3QSj3i
         ziSJEL7yMWjuUBb93LtkRhqfOFxE0Qzrl4PuKn1H0Ems/fxcGqHFq3/HVnKQl5KOCUAu
         6zmVkHp9zNSTiBuJAA1uxm/D+X9xq07FSWIxC+IYBmTepgb7WKR6qvnVV1nAwZnhll+h
         NX4ST73sqZy1Q1WTFtsMQJ0hbHJ3vD+GKibT4d8m55JBsFJm7KZBXssKYx+ZMSdyu30R
         m7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469582; x=1775074382;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbcYmZTYUVQCmTOU0XwdJApnREBTC+IfGYYb0BZAAb8=;
        b=qhCGfoGBcSv03DLbb//eeVWfjlY1oeoqdPtIjm9Qv+Bqj11O7Gwk5VmZQcbspFPUlZ
         vwdMQ9d7MrkYVRZHIieyTlmd7xZYloIggr7CJFpQeDoBWHkTRw1wgAIAxmjmENErYEik
         u6xS0uDpUACzh8HcrqjU826k+YezOR9YE2+/G9BAGem8xwYufVpWTtwHpdSA0fJTJQpu
         WQlPIugaLvEYZ+gMrYKzgA7J1sMpunUu4xsxX1AWcIrEYTXLZJKCDOBJG/k0uio7WaEw
         OM7lDRayy6KgRjKHEfrN1Jm4bKsiEq5meoXS3mu/cGVmnj/sBz1yUq2c6wIPFgeVTn04
         ktPw==
X-Gm-Message-State: AOJu0YxsnJeTGiAh0fzsodhUGsjWIgkJGntAoGsrVphM5pyJjcOoX0KA
	v/8qje/g/ojpPwNEiE8rET1nQzSZdjV69wVOkAy3LaIa2P+zB4yBoCPyAwMYsQ==
X-Gm-Gg: ATEYQzwLbhQaGonUhfSPeHWJDeudGLBiz7hRsVOJGqNS4VeSuds13Ke/h1ZlS4kZCSy
	lWFrdc2om3KbXEiQgMY3WxsROh5a23Lq1nrkNYF/tk5fL/oxoziD4GvUQLvI+fUHY5lYn26/vLk
	jhZ8Ce5QNLuE/TJGsisR9AijtUL8Dmg9J0CMv+I4Kvg7Ls4KBlLoIhq3lUxLzQooShofDBKEf1b
	IxK9BSCuRT3AFngq44ZitS113IVUtzrt2lp7o97aPPF1vB65GQy+zMR33VzTqY/I3+LGwOmTXO5
	8PLF6iQ6pLx+ZyVbAZpmCMUA+FaFPRHuskFVn+8P+OjJMkme6WM1UMXyQPkWm8vSN2Oa8LzwmBU
	ej1MOLIy1HHGAmwq5v1Hm3+3nZtCeEmGFtT0TLwdevTXav2pyih/1Z38EylFxDxXkE6u0BLBoBA
	O4K++Cn2837g2m5XCfjIcAznz98fMJ
X-Received: by 2002:a05:6830:913:b0:7d7:dcbb:27b9 with SMTP id 46e09a7af769-7d9d6854bbemr2284999a34.23.1774469582058;
        Wed, 25 Mar 2026 13:13:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.12.182.167])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9e6fff04dsm516566a34.10.2026.03.25.13.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:13:01 -0700 (PDT)
Message-ID: <69c441cd.9d0a0220.3d7440.4520@mx.google.com>
Date: Wed, 25 Mar 2026 13:13:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6797951828926381642=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/9] doc/btmon: Split Advertising and Scanning into btmon-advertising.rst
In-Reply-To: <20260325185406.568078-1-luiz.dentz@gmail.com>
References: <20260325185406.568078-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6797951828926381642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1072496

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      18.66 seconds
BluezMake                     PASS      682.00 seconds
MakeCheck                     PASS      18.01 seconds
MakeDistcheck                 PASS      228.23 seconds
CheckValgrind                 PASS      280.54 seconds
CheckSmatch                   PASS      316.84 seconds
bluezmakeextell               PASS      170.57 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      948.66 seconds

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



https://github.com/bluez/bluez/pull/1987/checks

---
Regards,
Linux Bluetooth


--===============6797951828926381642==--
