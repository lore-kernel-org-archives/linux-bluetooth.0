Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99463911CD
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237413; cv=none; b=A5wU9xmjGcifGDBk39OTNF/+4BQwnh5A/u6KdxKSHcjKc9HvXfN5eNW6V5yPdxVBSRcnbIH9WDhwLS+EdWAMl0bYwfJXYEgf6j++mpwRZCqqv8fLMyRFAUj/RzzISsqMThJ05hc80WCIuTvm0VmwJfgzsEtAW2yQnJ+Su2pH10w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237413; c=relaxed/simple;
	bh=Zyap3+1DY7IUVJrSN1zoHEETz8JZHrl3PP/SMtF8syw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CP/HIE6VDswdlgcwrdhfn6gvndM10VqMAxmHwAM6MS/srkpYWnBiOV3ZNmbADxjXbxOKmjbhBd+AHe6sCp7jBSRx29H6FEWkOwgiLOivRIwyDkKx/w50iK/lX687H2LlVxvzU4d34MKmDCi5UA8OD3HFSxD2tAVQLnHQz9+Uvo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9VoCYRF; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9VoCYRF"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-13810b63a1aso284275c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237411; x=1782842211; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8hhAC3+z3n8iA+lr0Vp8y8n4JhorV/w+3WCbi6TEZ+w=;
        b=l9VoCYRFIpD4vnUdSh4ls3JsvvtT5EgZVYk1rtNDK0bfsk+cgeZ/WbsX3JyVUL2XTR
         f9UJh14OoAYblzDzx4OC0f3kKsZorvoshzPL3nNiuuUcSPUHE1Ok9//1bCTK9g+koRbm
         91B+79RJEmOc30ENn0qjj6GOTKZyRW2WEBTk8x/BD6GNMyyDnSaes+iwHUtahLqWYDF9
         9f85nKzwmbwyBk/psK4Y+5WQfKF+ttsTi0ZqOOQ6e7jHjFLRT2M7i7JccoFkYiBhPctN
         l0umHv0f5JjULhhOdaDegKKNEFACiOwTrV2zV3cPLh3axWwF97ZnXnMCB40RrnLdjOss
         K7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237411; x=1782842211;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hhAC3+z3n8iA+lr0Vp8y8n4JhorV/w+3WCbi6TEZ+w=;
        b=s34T7A6uRHoLtmLUSEPDDEBgH9ezWh+PuN3SRQu0f2zkBO+u7IUU31/AjZUPImQ8wv
         iRCwFSZy/bA0lYdNmj0nYxPWuXfVubmwCOMzfSM1ra97oNFBmY5jd7vuVpp5GUEYVoZA
         UEwhu6IbF/Li/UXYeX4BixuDeImfhViV1DqffWqbMpT0rvx2noc68fCa/dc8o1TPVTi6
         lpaRSw5balqRwHguMdhxjz0aCYMn9XHXKpN0fa6gYuTJ/IxXd/Bi6YQrIvxAmzDOxDZ8
         OI/JhZu8CJQvSsReEelEU7O/AH9I6YyaNxVDw7r8uKK3uAgtzh7yy9c8FXMUmOdihcUd
         34aA==
X-Gm-Message-State: AOJu0YwELnDLpVRMIhe0HuP/tAw85n8ZUxABZiUfbCKoSFcwfIwrTmIq
	V7Q4KBzGexqSWUMCIJvGJ7Xt9UL/GHJNQMfks5Ts96VJh6mpFxb/GM/aFbnj1g==
X-Gm-Gg: AfdE7ckBw0ebhGtO9jt15AMEZtXza887EZPVMbpAwc1rIWHsSITi454dVc1EFjkKusU
	M+bevkXhbvb+1sTNFM9YDy4RkbVUjtOlGMx6V+25GzswrdVsJnU2vrBpmJl36WfCExBdeYzrq+t
	Qin7LObtdwbORn8hzmPgLlNXwD8RMKN+f9trIVNvNNP7g03DcB3a+zK7MC+ivAJf2VAX9sSOeAB
	5uyq1gVCwkIAPqchfRuM572bakyLP/hSpKWLZRB14DLjjyYR7IuATduyhGURk62uNYawB7rapHf
	kg08QiJYXfq3/74cOaVg7X9thAWZgYeUIfSnODI8Ixp6y2nMzHFBt7AlpVCO6NJthoZU8KPKZP2
	I4v+771URw7HQWShWZP6K9DiKP6jzM2BW+rt/49/ItnrrwqgkzOFuB2y56JL8NkYhqQoLJHtGct
	0nvwBO4PQFBYRDEyYQMazr
X-Received: by 2002:a05:7022:419e:b0:137:fc2b:1efe with SMTP id a92af1059eb24-139ad6968demr11389301c88.11.1782237410839;
        Tue, 23 Jun 2026 10:56:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.123.136])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adcc5f14sm15560720c88.6.2026.06.23.10.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:56:50 -0700 (PDT)
Message-ID: <6a3ac8e2.7d41f3a1.30d65b.1123@mx.google.com>
Date: Tue, 23 Jun 2026 10:56:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1214127820533152108=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: 6lowpan: avoid untracked enable work
In-Reply-To: <20260623161229.2174546-1-zzzccc427@gmail.com>
References: <20260623161229.2174546-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1214127820533152108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1115489

---Test result---

Test Summary:
CheckPatch                    PASS      1.09 seconds
VerifyFixes                   PASS      0.21 seconds
VerifySignedoff               PASS      0.20 seconds
GitLint                       PASS      0.55 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      25.67 seconds
CheckAllWarning               PASS      29.14 seconds
CheckSparse                   PASS      28.07 seconds
BuildKernel32                 PASS      25.73 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      540.18 seconds
TestRunner_6lowpan-tester     PASS      22.55 seconds
IncrementalBuild              PASS      24.29 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/340

---
Regards,
Linux Bluetooth


--===============1214127820533152108==--
