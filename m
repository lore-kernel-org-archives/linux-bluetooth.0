Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC6F2BE056
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509185; cv=none; b=GYzH2XUS9LQ4iwEmRoh8SGZwjUovcamtNM9hI77ZwDhCoh86qNHDOBbEoWB7TQw+omUd4MxWnkTPU8gZTjmQsiKITEhoqiG4zqUXH168Em+CBNPmhTX0J7dvNtLZtbLLflTT5CwEYtt/pXW31hFnegWX0yQSGGvj3HUIkpkGF5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509185; c=relaxed/simple;
	bh=aCsjnF31gHEEYUVbPa9qaGTzthdzGJ3PiBNDyDpdaG8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a68GY12agMXfjDwEvTb4mbKWNb+PV0qIyZ4IqosptpLiN8GSN8U22JYA6D6jmYYv4g56umdLjMCwxkV8UY3GYZB2gzA8ok6FqkEh1JaGgTLikhAbR7UuV9v99kTJRE9pkAIPl9dFvnn80sjZGV2hRVst3AqVgY0vrrW/O/ByzgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWWbGafc; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWWbGafc"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8ee63e91acfso273083885a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 07:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778509183; x=1779113983; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O87nKx4hm2jamjr4kdOG1ju2/Gh7JIi1ti54dDJetho=;
        b=VWWbGafc95FzvKTYzlkkRyr5okb5OAVpTli1bu0a68KB01/U2w8u3cb4BKTAhGd9wG
         QniwmFtNbMv4eYsL5lyVEZP/BU0zLqH2bs4C6ynQlgUxT8LuN4xNCc8jl1dsWHCeCRwd
         Iyg9c2FaoyfshIAzQkTKqzjeURDX4euPmNPI1y+nRAVU4eulAPugbTx82ne+Qhq++ciY
         0g/w8gvPUqEKKg2I6uHUertWiSKTZmfruZHaBZJYc8gnd7YEc28NkyMAEo7GVnZGJsUT
         UTcQMevb5tlAKHyR4O87ubw96myi/YKql0VuTVi/VZNGh6V/NYxpXMuOC3+t1Sv0mljE
         ZiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778509183; x=1779113983;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O87nKx4hm2jamjr4kdOG1ju2/Gh7JIi1ti54dDJetho=;
        b=RT5t4FsjXlWxvCwGAp6uCf0bIIhkjdKe5Gz/zcmudSgq1Y5z0xs4HxG2vQ0QYgTjq9
         7TVAENClG/2P4RtKwQiyHTFXvPUD/L8NiJd5hmNVB+XU4zcVbSbCJfhnpzMVcW/vegnp
         aWyYAR1EOGnwpjQc3DfppUou66uy1tHM5qtn/2R58/bfWBVVLOXwOgGWrDVD0dVGQW99
         o48wVxU0QlB0MX/VJCO8cegt7SrCiFv06nxMs2eRpgHI8N4HUINcmtNKWxIuxVhLechP
         jRrQVneUPJImW5FcbcTpwR5IsdWQmsyndwg9laembB/gwBgYM9vF+2lbgDm+dos0kEME
         Xy/A==
X-Gm-Message-State: AOJu0Ywf9S9txS34XFDih00BPh19EKf8AFfo0JAfzu/bAsQpbJxJj5qW
	Jclv6JWED1EWKyr3kxGkrjSN6uCrN0i8ORdDCjCug04Deixz+mGECjwk+jqJtA==
X-Gm-Gg: Acq92OEmSpaKF++yb813vvltszGVQFWNEBUbphBFz6yx/qvajqiMJmElOp6ZwKjkmpK
	pQE13Omw/6zbzoJbdif7VRbsI7pdvdYgeJYKUWBtzFOP7ARJ5nU9cePFCmRz2TjwT3HG84XYHsn
	7R86/rOYZa/rcro5vskbFwTZdXj8llqisAQBVwwCB/wp3M1ncra6K5Dve1un3+qaa+tXykuR0lX
	MaixTsoDY4wJ7NSeh1mY0y6hBy5K3a6Ki2Ia4c0jE2dKeJY+xYaHaAwQi9dNt0/aOpWXi1uWvJx
	SurJE20nVBUJmTHhiX4faUlqAbZj1x0bYnoVr4MlQ6tctCvrWcqZGjmk73QDAYZuC/bCj6yH8Nj
	8ZAu6zF5BRsEttE2jdlN4EnyhqSARYHYm4/ZMFHt5EQT6xsonEoauBvADlVjUhYmHZhBBJUVEqc
	wyXwYggdVIALBPjdYtxY+L73N9+GlU
X-Received: by 2002:a05:620a:1995:b0:8cf:df8b:1e5e with SMTP id af79cd13be357-904d3db6417mr3521928785a.5.1778509182998;
        Mon, 11 May 2026 07:19:42 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.169.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b966ee91sm1077075085a.10.2026.05.11.07.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:19:42 -0700 (PDT)
Message-ID: <6a01e57e.050a0220.321be4.b27b@mx.google.com>
Date: Mon, 11 May 2026 07:19:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3170172086896244349=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Reset controller before configuring MSI-X
In-Reply-To: <20260511132711.1216139-1-kiran.k@intel.com>
References: <20260511132711.1216139-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3170172086896244349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092796

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      1.58 seconds
BuildKernel                   PASS      26.84 seconds
CheckAllWarning               PASS      29.54 seconds
CheckSparse                   PASS      28.25 seconds
BuildKernel32                 PASS      26.49 seconds
TestRunnerSetup               PASS      576.72 seconds
IncrementalBuild              PASS      25.73 seconds



https://github.com/bluez/bluetooth-next/pull/166

---
Regards,
Linux Bluetooth


--===============3170172086896244349==--
