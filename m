Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9549270ECB
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516863; cv=none; b=h+HJA0i8YrVjLlYGyqLxTT18aBNYLFcVqHR7tgcnYvP+aJqZBer9ayWAKDVfgcpFn2m7TEEbQzZGJLkTt2kUzO5SDQfJeVWwYJQpBRtnWRnRlY1epwfzV8x/FXrrH81UFyXCXKkutoIw0CgKs2mpUhTdPQFCjiAq4mgNg4qiFHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516863; c=relaxed/simple;
	bh=s1k36tLoS+KzwimH7yorPRNc+syZCwfs2Pu5dHEM8zs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=r84Vl6J0NOEznsXzm7gLq/D7ojCZil+urZK8vcamBUrHh4/BQWOUbdaq7LHMMgB4q5X66Xw4aupEm92QPSM/uG1zSGY4EYGa0XwDKG6iU8INU/zjDwfNxSubbcChGB/bAlElZqLk6oGhSZb7/8rOdDeFtFmiIgrSIJXcV0801Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhS16EUu; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhS16EUu"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7dfff5327fbso406236385a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752516860; x=1753121660; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PenJw1uMd+gmWgPqpc3mW+INfD3qhKlyeJ4geZ28UEg=;
        b=jhS16EUuayuf01Fr/wxefR6EXkSPhalVb+NQjHS1FUPFeGZ/nFctHLwGf8Lzw1+tfQ
         8aNbNd4vXgqm5BI5t5oTfgATzmJjEuT0Ezs0tlOYzBPbqFrH4SgPG8PFGal1+q9YxjfT
         aqnHOD5cPqEfLtGWtCMmuCipPY+NIi3jphSmgUvEC6a7Vpu2byI6GPH+b5ew2jBCmTIf
         C1act+RAyd2ygigUkfn3usR2SJXGhT3zhh9yFWkuCNxfXrpjeb72RCg+SYlWHVLJwlNT
         bWgIYLYuzYtj7PNlWN9nvdj+8GicJyIvjYNRBpadNlR+8NXOeMNzLt4BgBhzXmch8Aw2
         /WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516860; x=1753121660;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PenJw1uMd+gmWgPqpc3mW+INfD3qhKlyeJ4geZ28UEg=;
        b=TmaN7MVRl+s5kIyVGp15sJKNmwVD1vsCrg0sgpeuWD2wgIXOp+OKPGYSHG2tnvUMX7
         CPIwRjSxW4iaxPfHF78MudRuO81U2h6gjnqLePZIG8T00EqA5SXFGxz6IGmnovi0Evpn
         WtqvvT2dFl7IEW0JS8z6b37cST0PYmA1Byl1HR15qtQG+ctnJJxI9BzfqDmNCIWkbFXg
         DvvdxRhJm+vqZYpCdebbA5JZD7n4gglKjOYk73mqBHuNfFJiThx/LYaxNB9GPQJsp5Tr
         YD7bUVtxBW9vmql0Ar8tnn8HRHXbLzxdg0/Xx9x26IKyya6H3jfBMO/Evu5G6p7lAvN5
         RYjw==
X-Gm-Message-State: AOJu0Yx3GdHgtZUs+zvfp8RMzl1CIJTciUtHIkBBCERn2ggwAgT3ipZk
	nQVTaUqqlnDx0ZdoK1k8z1CNFmrI2/cMiphKe9etHGfk9Dk1hvDCRn27o/Algg==
X-Gm-Gg: ASbGncvCtC1PNSeMh8cVWAm1R+jNVZp94T0pbgCi7rm4T7nnd7lIVexjruh+/bBhw+n
	Pc09VyBCUABLEKunMzOfV2chxZpvFgLEF3ktLTqKn3lKlLVzAPPLIBIxuER65p1vkxb95qKCeud
	9Lw6EccJ0gJu8bsp9v6TLsQhlghqIXcuATaeaW2iFECm//Xv+4siWS8JJYO2V/QvtPh5fmz4U/e
	vD7p/b+lGxrYqZn4Faxjxv79LK5gPyZ/SoZP5q5BMLSiSzhXJ+jPlrUp5ipxNtP7vWp/5dPSwy4
	tZ1dd0mLfp5+aNk3ZEiS8V1z2ZcQH+OEcqq8mpDXXwChJe/c6FRH8fop9eBcPuiLlQTqfB3qY0D
	I9ZmSXE6pJqWE68xBAAIhOd3xuFD8rd0=
X-Google-Smtp-Source: AGHT+IHyXN+Ti9bxCrpEco3y2e8wojY2Mo9cZmmTnxv2aenzmxFXwPfl7Z2SfLoOSs4OKqVASHSmWA==
X-Received: by 2002:a05:620a:171f:b0:7e3:3419:6176 with SMTP id af79cd13be357-7e334196b14mr282363485a.31.1752516860338;
        Mon, 14 Jul 2025 11:14:20 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.226.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7049799ed04sm49895156d6.6.2025.07.14.11.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:14:19 -0700 (PDT)
Message-ID: <687548fb.050a0220.2c7ec1.33d0@mx.google.com>
Date: Mon, 14 Jul 2025 11:14:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5860066956055114228=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2..,1/3] lib: tools: remove POLL_ERRQUEUE
In-Reply-To: <2ffec6539fe38318c713b48985aaddda9671f258.1752511478.git.pav@iki.fi>
References: <2ffec6539fe38318c713b48985aaddda9671f258.1752511478.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5860066956055114228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=982161

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.47 seconds
BluezMake                     PASS      2663.57 seconds
MakeCheck                     PASS      20.16 seconds
MakeDistcheck                 PASS      186.55 seconds
CheckValgrind                 PASS      235.33 seconds
CheckSmatch                   PASS      308.40 seconds
bluezmakeextell               PASS      129.17 seconds
IncrementalBuild              PENDING   0.22 seconds
ScanBuild                     PASS      932.27 seconds

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


--===============5860066956055114228==--
