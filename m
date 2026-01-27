Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC2246BC6
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539072; cv=none; b=eKnKQjlQO4wwc+DtlsKuiyn8qzISX/giqn7VzAbdUEiEYjwP7NzwgikFEZi4x6T9ZL3gXKFn5hN8AhK4ftCe1gjIv//GX80Xna1qldBu1JzWmLJpfnenoZNshGQcG7iw5crbbf76mo0qnvlAJ+fMv+RHH23lCwDql7edgaF4SnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539072; c=relaxed/simple;
	bh=exNjp/FtGe79dGzj0LkuiaMtlS/j5x01OtA07vc9reI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=grHFy1ZR2dzO7X5ImhBXMINWNqBitvqLr1mL3ikj8TNqluaS+8NCxFikqzSxVxgzszYR2W6slL4KmuxtwsfHASNG5RkQXfXEPe9jpXzYIBtkWrLx8bVBSHtn9OcZOPMoMQegaKTZawT4QgRU21h4bi2FY49ZKI0DVZ5/m1NReS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igHaDkPI; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igHaDkPI"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7cfd9b898cdso2085759a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769539070; x=1770143870; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KOJhbmOJUkArADod9kLuAu3IA06sXPVpUqxGW0uqO78=;
        b=igHaDkPI7YzF3AO+ZvFA29yuRDAcK6PtxRetKt25g1erl+6rQ80tZ2pkCymrQcP0rx
         pNRid94aMtp3M/lAGCBCm+B+yWCQUtvUV8/HewlEZBsS6lhed/H2N+6Lo2eUqx2tVSKg
         wWWYH7Dt/1N8z/+9D2YL+hushI7zh81yMtHWvSyj9yOSM9yvQGO4JkJwlKrveDsw9vPk
         aBcGXOmIH2E0h41FjkG9m/KMIiaXBtXitPR2Ur4QkSvzIBEyi7yiicJgjlF54NHJqOo8
         OHqfcO6glmoMFrEpTpwcC/tTLs0pa8cajPXhrC4iGwip0MRG1PNax+3q1wswU71ildvJ
         KFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539070; x=1770143870;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOJhbmOJUkArADod9kLuAu3IA06sXPVpUqxGW0uqO78=;
        b=EnZxIAUmR8/sohu6KcfGy7/TYMqjkLMj7atMUY66CPN3RZRqneJSjmBTfCU8HYLxUt
         Wlp1YuAeNqkwyG9IyxnlLmTy3qgIOiFodUDnLh9UcRzawrwOBlYNtqnYw/ckzJ8ixMgo
         oJyuCHZloTblTK9WAJ8n8EgMGEmEK6Y3SLNH7LKb05O2yftyNtw9XF3B4n3HojRH62IX
         B0ClI2UMK3fdtvDaU3mjKS/rvvxYOL5OWD6AIveQkHVhX+TJuPRGM6MNggBCmuCMdiUT
         HEm8xJHHXupvXbFEz9IujVktPLCnD+nRWRpCV0eFnUuwbp8LKmiPPvyS759pKmSgWhsS
         UaOw==
X-Gm-Message-State: AOJu0YziqL/0Lq8egK2uaoIeeiuhEuJ5FWUfPBExlIJYU3BVzU4H+3wn
	P+0i3VAk4LJgwgQW9MD23v2rYWg2hWNUFO5mJRcc7/64gIbaS0/fo3GZ/B2GbsJJ
X-Gm-Gg: AZuq6aLJhietpOCpC0n5KB86zK8LDGEXlXC/h71RdLr5C5WafFlB+F6iX6+Rtxfp17w
	GeoN9xQlwZu6PDkZS/TnDHLcPYkLfU5JsYIgPminwLUtiLJOHvC3QzoDtE2dKzIXRpVtH+862FH
	e9kJj8d9iVxaZnTiKmkFcY/bMiQOYEZchCcifr44Ak6cx9pHYy2Xq03MORgYGy1lmW7FjqsHz/m
	HRruQXgZ4Ll6qeEeUrAlwo4aPlxZZa6JkmGIbDzdnGZmXOalBjciarDHQhQfdd9UcAqRkeL67hp
	KrMqNSXRVgHl+wx4zZmjEetTz1WDMY0zBuBI0cTqONLtXxHIKn63H2WJyLCRjSHZotbOJecxy2F
	8/UFHq9o/+EGu/IvD2O95I/g2eNHuetmupXYb2JzKUBRjMR/tUVeOAU8wcbl2uOWNHM1BQ0cbWX
	zKPKfsTZN0mQC/kIVKpA==
X-Received: by 2002:a05:6830:4992:b0:7c6:9d7b:b033 with SMTP id 46e09a7af769-7d1850db5a3mr1637784a34.22.1769539070047;
        Tue, 27 Jan 2026 10:37:50 -0800 (PST)
Received: from [172.17.0.2] ([52.165.251.243])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c8016fdsm290243a34.25.2026.01.27.10.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:37:49 -0800 (PST)
Message-ID: <697905fd.050a0220.7b0a4.18f3@mx.google.com>
Date: Tue, 27 Jan 2026 10:37:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8541575062851401428=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2,01/13] doc/qualification: Add PICS and howto for the A2DP qualification
In-Reply-To: <20260127173841.153747-1-frederic.danis@collabora.com>
References: <20260127173841.153747-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8541575062851401428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1047711

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      19.72 seconds
BluezMake                     PASS      634.00 seconds
MakeCheck                     PASS      18.80 seconds
MakeDistcheck                 PASS      239.67 seconds
CheckValgrind                 PASS      290.96 seconds
CheckSmatch                   PASS      349.43 seconds
bluezmakeextell               PASS      183.19 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      1074.77 seconds

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


--===============8541575062851401428==--
