Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE711A9F88
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780735685; cv=none; b=WNQD2gSuDe7+62kbRcMNGBQCO3TrtOk6vE6Kt1jZc020LxWvVd+FiPLX2FXtXi5ydrwkppto4nK6BBAS1ihZ5o8CFPLU+mc3SMnOxGk6eGfTwnwUpBSnXV17nG3DVwBkVDIOx/YlgTEp12DhAiCIG7/hJ3UdAnPKhtF4BGAem1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780735685; c=relaxed/simple;
	bh=p2eXFK96ry9UNAEH7g21AnPXzrZDN9Nt3P3AsGwRuQg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Abb1izbrglodDzLwcV4f9QJnTne2aUWgsJSobQOssrj0Bt9JBRI5TAa6BaaekKmnIempuknVwYNIfGifGW257A6GhC+ssOKZ7nl8BGjjdN6ipoMYVnRIK2erOxCBlTtQaJk1hrNSJ/yOeiEQdkozQE2kVWXfAcVBKd8i4gQjkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aog/F5WB; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aog/F5WB"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ce9df31130so41243266d6.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Jun 2026 01:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780735683; x=1781340483; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4dP7CVb/NDSwdbtYYs6YaDzfYgeKMD/sufHD0/E2Ub0=;
        b=Aog/F5WBxaqZ4FlVNVYVVm5l8yeFCX2xUEXEhIoqoM4+fnyQBmYZ0wiSerBCF0DYGn
         ywlL0++DngzKX53E/jeJxam4FSh+yaTlfrNwdMG/o5mslRoACJJZyAE6HFdyX9giHQNo
         MmcAr6Thqz8L/+HchNgpsUIZ9VVJ59nZq8FCX+LokEqQeQMiMER1iAGbf57dZs2+5vv1
         dXsSTmLN9SQdJt+qeqK/aVNFCWEh4a0M8c8wnUef+3PLycBPp9+ymabBjUhxUFWJ3H5Q
         nOtoBYbsE+D1O4/pjYUwS1P1DV97RNJX0+ncJZ9Qx5bFY1zLcd1LW2h2gT9HbCAlEync
         HrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780735683; x=1781340483;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dP7CVb/NDSwdbtYYs6YaDzfYgeKMD/sufHD0/E2Ub0=;
        b=GFbXpELCfgAVkPPkhxbEkAxkLMOWscEgC/yjvqNuyKLtJgGFNMDe2Dw1K2eGSFyhsg
         HqQCQvXKRMsamCswQP/bqeZoO0KeoghtdEn6OpLw0e+NycnegGFvUzZjZ7kfr0H7sIU5
         XRXFY8dQbOYfvV5De4CTL0fC+tzgpN8/08PHnpmqD/vmHL0ZbXUO9VTg2LvUScF3OhRx
         cks+q5rxRFOlfLvxYKN4MfxuXLRXawsyM5gwCpDkWmMmIVDyVAf6kpNgK+U5MU6pphcN
         6GG7oChKImcq2wAF2O2GP1+A3buwt5vKqDIaRLFm3LULzP0al5HrOec3QiWvcVzriNk6
         /fvQ==
X-Gm-Message-State: AOJu0YxUwi21yDc9KaykOWkP2IBjf6HNo9UQEt302jrLDz/Ryup+HGNl
	ErrtVFBlWKz7tgr4Zp89dhLWfRvf6+DYqkMnO8fzksZ7DDn/KZF9BB3X1cBIbA==
X-Gm-Gg: Acq92OFDJPmbYu9mLnpQsY1RGTJXwSnW3MCogeyx4/+I+yce+tc9LBuqba43joUAc77
	o7jEEYQw+VbMHZy5XWOzsfnu8R9TgC3acj49t6ShsdbKRCEmJQ1Znqa1vuGfFYQg1m4mVn5kvzT
	68qyclSA1LLHfKE4HxxVvKi65VVpLsERHXY7YRQKx3HgV4HT305Gk27wYCKAUyj3Ejcaag0rwo8
	0ESYX5vCIJp8F+kho8FbmQSlg6LU7juXmINxOS45WO4xtnFziWK1xgymrltKqfOrIrpgCf2da2/
	8/2upz0uGsahhU3wqYBKQw4QBkQJsBfaLJCn3itaFfeZUCGC8K8Lyqd+NLRakq0fEbPMiAA3/Tl
	VVtT8FJirkPTf5OA1Sox/1+e1HGgphsRhUIeW6FhMGNBqQsS43mnWuT5ldn5gWRsV3tE4Zv7OTZ
	GIOQgiewNxcG5YoN8/PnWdNh3P1b53sxoCDUKLWWTBFUpKsRaiH06o
X-Received: by 2002:a05:6214:94f:b0:8be:3201:ed03 with SMTP id 6a1803df08f44-8cee6134129mr90665336d6.28.1780735683468;
        Sat, 06 Jun 2026 01:48:03 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.198.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb94b5sm106085396d6.15.2026.06.06.01.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 01:48:03 -0700 (PDT)
Message-ID: <6a23dec3.f542fed9.1ef2a7.bc22@mx.google.com>
Date: Sat, 06 Jun 2026 01:48:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1406092071942941523=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michal.dzik@streamunlimited.com
Subject: RE: btio: handle error from broadcast ISO socket
In-Reply-To: <20260606060348.2240980-2-michal.dzik@streamunlimited.com>
References: <20260606060348.2240980-2-michal.dzik@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1406092071942941523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1106927

---Test result---

Test Summary:
CheckPatch                    PASS      0.96 seconds
GitLint                       PASS      0.66 seconds
BuildEll                      PASS      20.29 seconds
BluezMake                     PASS      604.91 seconds
MakeCheck                     PASS      18.76 seconds
MakeDistcheck                 PASS      232.77 seconds
CheckValgrind                 PASS      274.45 seconds
CheckSmatch                   PASS      323.78 seconds
bluezmakeextell               PASS      166.77 seconds
IncrementalBuild              PASS      609.87 seconds
ScanBuild                     PASS      923.71 seconds



https://github.com/bluez/bluez/pull/2182

---
Regards,
Linux Bluetooth


--===============1406092071942941523==--
