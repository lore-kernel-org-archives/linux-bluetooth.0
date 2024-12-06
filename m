Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4081D4340
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Dec 2024 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510239; cv=none; b=EK3dNX39N5grv2zXIAa37dV+BlKwbTgXNhHEkOaUOWyZ7O3vfCg8VwiI4nFFQHzs0vP7aFd0vu+v0TAzfBJfOsL4mIBPwzKlQIdBWgrEQ46sc+K5Vt7G7xW86VuZvTvxAy465zbUjKKhWAsZLZ74BVgW9cPKeMcyEjR74LbdkLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510239; c=relaxed/simple;
	bh=tl0SMy/Gse9v2fC2oMv6UPcO97l6R5lj0TgjjHOoHbw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nSejohdvWrvUy+kfb/F5TJcyqZwTtCDwNwMPHDz0nRF4/z/kEWjG1ZNnE+sbAHscpN9wLGgm0cnX86cTmOpyQxT/auTQFr56wpQgkxFhbIP4a/OcqmdVXK83QgJcKkdmx84BdmozHUwyrtXa6I9HE8Eja33EVVWxqKwixGDUUfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZIIFDrS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZIIFDrS"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so661732a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Dec 2024 10:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733510236; x=1734115036; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6yAij/DFWSvmryUAIFpWr6xUKlcxHbn16dVZkmKmmeI=;
        b=hZIIFDrS98MsMMl/pfh6FXpPiQkKddih/zVxFLDcrl4nXZsfA/ljWbdGeDmxxOF8iC
         VCLyK87u7YsruYa1mi8NyqCuIBCKBB1zV96311h3jgfRoCahJLHZGG+XH9FcGOEdO3pZ
         37AJAPWzq2Up/ABS4U+lTEBclI+0OKoSvsseUZHH9jF6ToopJKhvl0aN9a27Fs0xuEPY
         ncCmu6dbnk2QDerYAUrAJkLjU4q6lt1sbBLZwwPrvCL+bB2B5OtEorGapRpUsBhkqKj7
         y+2G2dX/L6Bb0o7iURkxpxmv2p0WgK2I7TOYwbGb7OLrvQUX2IUtw6ACNhzc9pgtzwES
         jP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733510236; x=1734115036;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yAij/DFWSvmryUAIFpWr6xUKlcxHbn16dVZkmKmmeI=;
        b=MJOXlYCz9a6tRnTDwCaiYIOqblYhGHZgkBD117AQ/AhXYGR0GDQEVQnbxbbxIK7X4V
         xaaXqpHlHc961ajgXSBUmfXjLuZSFffI4zK4EvNOuWzU4rqepCb8SFow/8XHGUuZC7/7
         T7G977yZCVle4bs9RyNE2KoykHZZc2HStfYHav96xRFJvl2CYloXUy1Bs+Ib7Mk77V/W
         +FNd/v4et056Bwfa58YvgOEMn/ADwcuP8yfrqNhvquRyBJv/FmTitZ2Q8GWHgrehh+TT
         CaO2+Em33yj/SS+TnKUCIUPrlsITApkz8H5MInjXgM9+POFwjpPLMQ3qWFRDf3JKEh+F
         XZ9A==
X-Gm-Message-State: AOJu0Yxl1a6fPT0pVCI5AsjNYxr1OvRZPGnkBnXck0g3dmc/riNbxrL7
	uaAK75pPgA2Ik62SDWGSc/DSPqgvShth8kcb52dRu/tXFwhOJ3jqbHNevg==
X-Gm-Gg: ASbGncvl1W8lhoIECZJRVIrWijzf8YQjYP7e8L/kYbnqaSRn7AfpIxbGyMSjMtJRp1e
	/AUPuF/AwmZv+CTrEujtR8ZRsg7Km84HrdWcPwPtQqeXz6aPOu/e0kFV7OlpaIdTKP7XfXzne3N
	cX7OSgbUt768WdJagUvOkD7DjHuP2H+UwDt2jAgrj8wdtAzTCprgznWdNuY9qv+lNXxYk7ps4KP
	CyU+zvkYdMpDXk01Za5tvXuOMUDXR1GLQRgfq8pWcRzl5ttf1ByNG69
X-Google-Smtp-Source: AGHT+IEC6TFlqMAbN+YWqVu8TyGK7sxVM5TOflHvOTxMJ5W9JeTDUWGfiCvNu1fPswI5CY21fttmrQ==
X-Received: by 2002:a17:90b:5384:b0:2ee:dcf6:1c8f with SMTP id 98e67ed59e1d1-2ef69f0b7f8mr5699036a91.16.1733510236391;
        Fri, 06 Dec 2024 10:37:16 -0800 (PST)
Received: from [172.17.0.2] ([52.159.142.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45fa64e0sm3477521a91.26.2024.12.06.10.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 10:37:15 -0800 (PST)
Message-ID: <6753445b.170a0220.36869e.a7ff@mx.google.com>
Date: Fri, 06 Dec 2024 10:37:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1679765861988364687=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4] Bluetooth: SCO: Add support for 16 bits transparent voice setting
In-Reply-To: <20241206181727.928963-1-luiz.dentz@gmail.com>
References: <20241206181727.928963-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1679765861988364687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=915442

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.24 seconds
CheckAllWarning               PASS      27.14 seconds
CheckSparse                   WARNING   30.69 seconds
BuildKernel32                 PASS      24.68 seconds
TestRunnerSetup               PASS      436.03 seconds
TestRunner_l2cap-tester       PASS      20.55 seconds
TestRunner_iso-tester         FAIL      35.84 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        PASS      118.94 seconds
TestRunner_rfcomm-tester      PASS      7.67 seconds
TestRunner_sco-tester         PASS      9.43 seconds
TestRunner_ioctl-tester       PASS      8.14 seconds
TestRunner_mesh-tester        FAIL      6.22 seconds
TestRunner_smp-tester         PASS      8.64 seconds
TestRunner_userchan-tester    PASS      5.09 seconds
IncrementalBuild              PENDING   0.68 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 125, Passed: 121 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.111 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1679765861988364687==--
