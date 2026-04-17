Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BED3859EB
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776428835; cv=none; b=H3BJyq0qlAYzhctZ3UOnldQUo8aCBhLNf2ek+dNxMR3XBghkzWfB7CHkGBvfk6Uvn98Cu1FuBd4Lrrhuj50Mf8JioD6Ri2g4MXnrnZqINx3PTdhPj71/4QJpRfb1hWjYo8ePasYMANR0XKd3pDbSvb25gE5y7b5eqhNEfKBaMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776428835; c=relaxed/simple;
	bh=DKkHfYFwIFAcfflDQ9eDmDJQFrot+oDKIlCp8rBMGL8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=k9XAi0wv/cTS3kLqp46R/vRAqQIBpjJrIO5tUXaWh+j0Ewyb542PgXdo3ioHLpfX6Slda9sPf2CzEYfZm9FuLJ/+ZQBQuGja0gbs6jeb616z5WVGpKNobOyNm+o+J0cYQV+TJukxpJKrsvmfTLP3Mmy+bITzX0nazNqAs53je8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3oKniir; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3oKniir"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2d891442388so1086685eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 05:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776428833; x=1777033633; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4CV+rJh7Z8zn2ly3gtFjq25yTfZPmOtTI+iRN0tqwSA=;
        b=J3oKniiruTUVcgfIuYFO6OLQv96MoNoPLE88ukA6xp3IUuNHOL+mVijeb/d0fOBsLo
         RrPCiMFUvnr+c5qaAzBaGEms59X2O6Rybsk/GtVWw5AmbliI26xG5TDIZcJewgUbPTQu
         fyE+qvxyaAmMEzQPo/OC40yb6oBhMHYHZ71GduzuCP5Mfgcn/f2AGdMoS55NqB4qYWbH
         nxVqaPGYk/1fvsxNw3pHM6NG2etSVSv0/Tg7kW+rtPdVG7PdNdLzJnfcaJ8ze6DbWPk8
         3NLXarHWYHBTG+1jdplQEtoPS4/e6COfLJgIkq1bRPQccSW31P8s0DeVTVb400rK97HF
         YggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776428833; x=1777033633;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CV+rJh7Z8zn2ly3gtFjq25yTfZPmOtTI+iRN0tqwSA=;
        b=Zj/Q7ZZYo6uMkzCG/TN2CcMnuTdyEkbXctvkgb/c4zlia79z76l+CC2X8Sul2cilc8
         kGh1uabqUxbveq6H4hG3x/YwgZKTmxhPSiGpsvZMed+jbph6YQ/kuZeFv+1x/SArBOF4
         mAMLpcscuiDYLt30N7lepEfQ5gC+ojlV20ly5PXqTLnUuQ94vOoKPzyAYhRMAPEcEh0C
         RLGzsNUFOVl7sGJsRreot3Kb+Gt0TyQXSE3JBTh8OUM/CDdKRnOOG4w7bmSyMfkH3Qot
         usCYa/I8A/7VOZimmFxmwwgMHD8fvdOXtloQFyfB/y737m+oU7mmMPhwJl/c+PlMZy+S
         D1Dg==
X-Gm-Message-State: AOJu0Yypi7ZgkiwsqzmK6s5YNmt29hyXnO64ONkQDk/Sl6bjM/q98VHM
	pG6Uit8tE7oSCtKdLZlio8mldZng+LhE+Qd/RsGDg6KYDi9IBVYD+d0761ps/g==
X-Gm-Gg: AeBDieshAWkCQGBQI8yafa9k3wqw7aK+0ZgUZblbNvmtQFrl3gtqo64HlrK8EuBTbDM
	nFXCJQw++pUw7NflCc98g1XBd9RSnhjZNeTlzoYNc+sPDO8KS0okWH92fDh+Jy2IXfXqp59jrZ3
	dwCNGRf7gMfAyxJBLgkaarjmjbq6CjzRBxNW/tdjlySEpCfWfAC/LsHQPRKqXpk2hF+suVBwqmX
	kLdUyotKAFfgiUsYboCKQP7fFI+NXoPjpwJwkgv/DZo/IgF2xKMdAbYCz8tnnMbo1cmW4lPXOAE
	uY6/m4WrU+oNMgeGI6nQkQH+o2REP4bUT6MdzY5qzwrEQc3PfcdFY6WRZf9yVko5+6ZaCbgbX/d
	V5kNPhhEmpFBNsy3xCQECnbeELWD+uWMx8PSO797Fh+1e6/8E9J3LU+id9A2V9dPhh+bZQS3c7o
	u7O9OF6HxSWKBSOUUectrtl2bLfxgKyBPM5cTterqi
X-Received: by 2002:a05:7300:2392:b0:2c1:6676:5ebd with SMTP id 5a478bee46e88-2e46557c7f0mr1203800eec.10.1776428832469;
        Fri, 17 Apr 2026 05:27:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.75.200])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53dcb487bsm1871805eec.31.2026.04.17.05.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 05:27:11 -0700 (PDT)
Message-ID: <69e2271f.050a0220.94ee0.6c54@mx.google.com>
Date: Fri, 17 Apr 2026 05:27:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1076308237621088877=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michal.dzik@streamunlimited.com
Subject: RE: BAP broadcast fixes
In-Reply-To: <20260417112914.3752605-2-michal.dzik@streamunlimited.com>
References: <20260417112914.3752605-2-michal.dzik@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1076308237621088877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082491

---Test result---

Test Summary:
CheckPatch                    PASS      1.23 seconds
GitLint                       PASS      0.86 seconds
BuildEll                      PASS      17.39 seconds
BluezMake                     PASS      598.33 seconds
MakeCheck                     PASS      18.56 seconds
MakeDistcheck                 PASS      216.71 seconds
CheckValgrind                 PASS      272.46 seconds
CheckSmatch                   WARNING   305.10 seconds
bluezmakeextell               PASS      163.38 seconds
IncrementalBuild              PASS      621.83 seconds
ScanBuild                     PASS      901.92 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2052

---
Regards,
Linux Bluetooth


--===============1076308237621088877==--
