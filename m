Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25E83CFF6F
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892470; cv=none; b=r/NH7Ie45kPmyqM/Ghy+hIrzhsr/clzDk6fHk53/geNGGyWChEXOCLrzo9pOa43WlXB5H0pa82QJuc5Zp+u3R/9gojUZMbsd3e36jvEtRicvRO/GXdHB9ICU2Xo/fo/H8DEwBk2nWowz7hCHIW2avnzmVj/mnFNjfO+JXMF1vSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892470; c=relaxed/simple;
	bh=f57x5hnMpoQMROAGkY9w4U6G9tjAVuS6wuKwiQrzpUI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bta83/GOUI1xTF6fkh+jtn8hi3Nq+qMGC/bfMuZSuVsyAaugWlFqASO78ghCaa7uFLTd10QSljQGqy33DoxH7pwELTI15x1sxl+WcUDtfzOPn1cL0Wn13WkmSmDhetMCXhm0zVAz4WSB+QIn7y8P/UaO2VIqAsyTd5sJ1o5goiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r2OctVRG; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2OctVRG"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91b63bd2030so36885026d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791892468; x=1792497268; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UY4/yUZNd136C+idks7BTTOEvToc4usYZhzMx0X2USI=;
        b=r2OctVRGYRDAhZXdv3hJkwEnmR02SMpoJm5DhyH/ng4WCRpbbWKVagxpOUcTtcYRvj
         NtUi9khNPEBp3/1sKDB6ma9VtuA6GiZUfhCmNXChgT0PWE1ZepSGyJI6DUK/Zdk/3d93
         KFAqGdecWtKhbz2mzB9xOXKJuqeocm1jb/a7jzf3LjOWnjRe6VeRQi2t4gYl5NIULH8C
         xkzCCkevbx1cRReROFJ5UReRsCxetuc/B37FNl4KmuuauEN6lZHfZlKxflc1L6UKI7ai
         Qa4uhvbFlQEnT74Cfm3y0El8v/QOVDUtJ2uslJjAzvLCJa4aKlf1dACKeqOjquGlbilG
         I+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791892468; x=1792497268;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UY4/yUZNd136C+idks7BTTOEvToc4usYZhzMx0X2USI=;
        b=08azjp/aDzEdl2rVj7VxyHzyGATpZPxLaFqWXMxY2TsAEy0y5Oop7GddSWjipMnQeG
         IECWAkEnvCse5D35+MTAEliNutCZJe76sbYvI25mBHbFbtoJ7po/WsuC7JFh1OdSSqgM
         ZjZ9/SXBWQWABlnp0GjODbTo/rPIpat5xDAcI6xKdu5m1yJ8BeDBWUJ4FGtvvaxAKg5H
         hMVyCWbYTdXq4cTPSCIhK3l9yTjaSJvhdV/bPyY5StAcTcPGROi2qm84aq1HmqQrHYAQ
         UmRFmgkLume4NwFCkZBjGy4em6VpQjNRIzz2DNjA+HlzeLulgySZx9YB72dg+QTwcMpg
         PNsA==
X-Gm-Message-State: AFq9FYLepmd/iMvL83rewyv322jV+wcLzyHlwftC2PiZqDa7ei1YE8Tp
	EwLE6ejUWS3oAVawlqc6SoJhCp3IS5xwHAQ7dWXkbFHLRwPf+2GP9CrYDLlvpw==
X-Gm-Gg: AYBFou2qodppNlBvchjD+qfF+z5/rpjtTCXe3ESGVJR6eIq7TKNx7ccmALyd0Zesr0P
	bFUIel74vc+AUwObzUEAQh3rvITAiUoEzrLK2U067/jj8l8721ZrXiNyF1XrO8BYaiU9dv9nyQg
	/Y98Js80mdPxSvrz6skZcBkgBrlNkAkOHZm4q3PfnRwQXG9xXCMcOd0NzEpmn52PPq99F/GX6AT
	77cGySjfre8yJsgAhW1C8BNxuKI3ILrOoDYlp1Xj367oKiKggmJZQw1SXwpBUMHkZp2af8Cq/DS
	CkR3ZHN4NoB89gL53B2gU9F2frUXqAkaNWgxosA4mSk6psof1j0DlSe8IDbwQdjSyabTqGcEKHI
	V/GCNH4IGayMSc7KEtbOtYSLNahzWCRaIG5tcDe0/lRdckUsEuCOeiGhM4598tmS7RfLpgEoGZz
	0GUs/7Fqv0n7wqxKLThH7VcZWroevf0EICEDYrflHjjHvGzsIIb2ssEa26TkwGze/05GCWSQdT0
	zk/
X-Received: by 2002:a05:620a:3711:b0:93e:9292:1bb0 with SMTP id af79cd13be357-93ebd0c08e9mr1934744685a.3.1791892467509;
        Tue, 13 Oct 2026 04:54:27 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.106.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef508205csm217707885a.35.2026.10.13.04.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:54:27 -0700 (PDT)
Message-ID: <6ace1bf3.db9f0efd.2ac457.4f04@mx.google.com>
Date: Tue, 13 Oct 2026 04:54:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4783763092721413807=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, catherine.l@intel.com
Subject: RE: [RESEND,v1] Bluetooth: btusb: annotate Intel Otter Peak 2 USB ID
In-Reply-To: <20261013092128.417705-1-catherine.l@intel.com>
References: <20261013092128.417705-1-catherine.l@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4783763092721413807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184559/

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.05 seconds
CheckAllWarning               PASS      35.03 seconds
CheckSparse                   PASS      37.02 seconds
BuildKernel32                 PASS      30.00 seconds
CheckKernelLLVM               PASS      35.67 seconds
TestRunnerSetup               PASS      708.27 seconds
IncrementalBuild              PASS      27.51 seconds



https://github.com/bluez/bluetooth-next/pull/914

---
Regards,
Linux Bluetooth


--===============4783763092721413807==--
