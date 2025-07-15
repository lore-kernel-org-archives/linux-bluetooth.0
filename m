Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB7B14B08A
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 19:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752608914; cv=none; b=gZQ5oB9UvMrOl+5+1SbmHwZ7kZpcU1lB72fFD7BVdEXGb28/ExoQVH+ac1vBZozh9+mrmvU5XX2QF7CDOsjH0qLo2FVPKQGHkb/GCaTI2B1NP8kbN6N/3EPrQSdC622RYt4zJcq/ShihgY7STEyoy9Why2X3dlPmHfois5dUNDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752608914; c=relaxed/simple;
	bh=WjFqNqVCz2InbffnSafMt6BJEML1b+BK8jDFCDuX6RI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ys6QlbvidamzfBpd2P5JD+fwnGPMLVX/yM0yb+FYFZFp3xXW3Xzg9GgKgNzrtoHOz7B0hKVJI2afrsN2NO1YpwS+I1jaevksoFhg+ql/8UaSb1a9EAXeD8tBbs9Ne9HVdoiNTe/tZK5+vq/6Ln3iYFQyKwp6JlLLSvVyiXaPtwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kxf3+qKB; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kxf3+qKB"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d5d1feca18so606117985a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 12:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752608911; x=1753213711; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4F2cKZXY1BzgHSPfLIKnEct0xkmq3g+/O3Wg4kkYqy8=;
        b=Kxf3+qKBlKpj/W8S/gOsiBTgViyujAOmNxcxCPo9qYsKzuBmAQruNHSLnoLuWl6gT6
         2LcA1LZ1hi+Drg7tyzAcj4RSYtRXH1pDkSQOU3+jX/OJ+PaYZHvmwVrAUzaqHnPw5m+x
         tRL2AVX19Vu3TpWt6AW6rLJiGj0qSxX982HpY0SSPxwrUv8Sy8sEzruav4Xi2JaJyWCf
         dcyVm2tuOEezvxTE4EjOHUjYcFYHRw9bKvBkzTO2YDShXwPwXWP4ghxAba5TZIJ8x5F2
         NtRL0SzG+3IZAIDLTXzcJC/mfmP9y/xxylq/iW1A+3byCJhwpQboQgRxw/eqj1umGJ9z
         C7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752608911; x=1753213711;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4F2cKZXY1BzgHSPfLIKnEct0xkmq3g+/O3Wg4kkYqy8=;
        b=hSAvqma1/OnaKZD3vm7NUBUhmCpl844hpnxzSHApT5eyhUAiXWKEMI2FIhFsIKxx+F
         qL8MPJYXV6qGmHDOhW7IY3yld1e0fQk7zyFt+9j80vPNr1ilBqfNn6qR1WHcSh7kxZ2J
         mdh4xrcAicwRdaGCezSJpbjDQuC9j6zb6AK7q+UqsSaj8CU0vY+oV1udWk8gWKtTmZKG
         ZqhgFHJRPIsCtYbA8Ue4gI2JRtjJrgMBPfiVLqWte43oytggpog9VF+JjwO0oDsNt+MT
         /DJLX+HgO50aHuCtf7wV9cbQtAbXT5FqIlngiyM3QqR5kis6g9kVDfDS5AkWaCJOUQ2q
         ibsA==
X-Gm-Message-State: AOJu0YyHleduKuEKUws/+70o+CfYmdNKp14gCAn5Tv+Efnhc6W0582Bx
	cRulsg/BDxSo/KIn5jhYHznNcywhRncE3Y4E9HaKUllHcjddWUacqAuDB3zCNCwQ
X-Gm-Gg: ASbGncs7XN/dOkipCeFR1V89Isw+/48s8+6FuwUBqZ8pKB+CK/FK/up28JjI02uC+zJ
	rNnB74977wkLXInXIbY2NDksmMmNpL5xW+Ho9ERY4nkpiSJ7I5LbP0okapSsF8QlaRre+JDJ+YE
	4TcaxiH/IvUo0FFE6NqnYLKvmo/7cozN3YU4W7safxSoLdngd42Wbx+5k4W0kzdadRq3ks59+4g
	ow3d0KB2FddJH/y7Inxjzch3cPChs+F/77A4v+LNCp9KXgLuYQAZMpS3y0Obu6i8nnff7YfH+bh
	scDBlnOZeC11Sh/60GT0OHuVo/I1FjpadJC11YMN+P4FRom41D6Vz6UTDhBSuRO6NK9S7C1RYvD
	lZuBLiqTJOctjI2wexmyR3eLxYwou
X-Google-Smtp-Source: AGHT+IGnttxJ+8skQa99uvKQggHCJXDbHh0NxJqKMh4zy0H9jyrWxYWVqTbkwjz8XRe4OBHkGMsbgw==
X-Received: by 2002:a05:620a:408e:b0:7df:7315:cd0e with SMTP id af79cd13be357-7e343350dc8mr21269185a.4.1752608910920;
        Tue, 15 Jul 2025 12:48:30 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.191.132])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e1ce0175cdsm340144385a.29.2025.07.15.12.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 12:48:30 -0700 (PDT)
Message-ID: <6876b08e.050a0220.17752c.d764@mx.google.com>
Date: Tue, 15 Jul 2025 12:48:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4017240176548053626=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] doc: Add initial ISO(7) documentation
In-Reply-To: <20250715180747.670323-1-luiz.dentz@gmail.com>
References: <20250715180747.670323-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4017240176548053626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=982635

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.48 seconds
BuildEll                      PASS      20.10 seconds
BluezMake                     PASS      2966.96 seconds
MakeCheck                     PASS      20.47 seconds
MakeDistcheck                 PASS      193.24 seconds
CheckValgrind                 PASS      244.16 seconds
CheckSmatch                   PASS      316.42 seconds
bluezmakeextell               PASS      130.35 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      966.88 seconds

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


--===============4017240176548053626==--
