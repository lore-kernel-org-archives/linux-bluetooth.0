Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D34326949
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538050; cv=none; b=DVRt5LXNF0djmwov82M+REryXDSjW+gXZ4q0xHPQnQybuEfsj2xazAVqqWXhFlnboeeLI6iZmoibhH5VVWNcYnE7WwaE6FLm2WlNliKRQfJ0R7lcFRkSuFHH7xVLGbRG76hTbI/IT+eyKPlOnqYImTx/8H2CBq8nmFC2DxsSBlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538050; c=relaxed/simple;
	bh=J/cRaorS0g9/Ubk0raSJ8jiH1ztbUqBbl0cpgard+B4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rOfJexW9/JuhSLYfOsBWkZhDftQk6BWSGHH721rAS/mumEurHjSRajQxx3dd/jdJjVYaDDbUdAykD9mAXJIBPWyT6ipGH6b/zoYukW4AwikM1pYqgkWpL77SHk+wI8qzsYO3MML4a05is5SheVfmlKpQkgSvpP+teKJxDViGhrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PD1jShQr; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PD1jShQr"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-88a288811a4so85224096d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769538048; x=1770142848; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j8gtLxGPKtJHtuOCq8CTXFZRtm2oyiCFRpmMT3wBGPc=;
        b=PD1jShQr4hDyF7swEdS174HasJAZeNVsxrg4RGadJ70S+rIFIK71jUgZ14mNfD+9df
         8i0DH4uEn73JMPU/U3EO9BgZolNOvTfZ2FeU31qijDJUgs+loMUXHvH0tCAmOpCEW5Sg
         PgPgZ9laMbi42MYhmva7LRWl0ji5d4/ju+fBmKYyfF2+wpHnQFegVMcLgZI0H3m03rVA
         D56wbkOXw8c++X6ubZovGbI+mNgOHpA+up0THgNjxtPBHlrn/ueyg/+CHlOMzedC6Mi+
         UcVwrfOE5EhXFOrsRWqOJp05oCBSPnPcgWrwXE7G9wkEOtnf8OF1+bYH5vf//ECDQtcI
         s+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769538048; x=1770142848;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8gtLxGPKtJHtuOCq8CTXFZRtm2oyiCFRpmMT3wBGPc=;
        b=HPmhyYbTfOMKZcRbl8sjnD0M+yKf6wY5myKirFPLU7OwkoRpvFfyna5cPtXvVS2lqC
         58+qO4mpsydngNoIA+dXHU2t60Kq272tUQlmDjV79BJllANLcqnqe8W47Wpo8cEXipHz
         0K6OQQxZaex4tFZZy7Ajs1u+x6tZCC5mFVe4XHKE4NBUzBrZE2LqZC6wgY+NjoZhbmgN
         LDvkKaPYlnket4jIugdzwK0xyiHl0OhRWzVlIIj5dTTxcs4+R/Kl4fXUTay3sZQKf/eO
         vM2phTiePwizWbn1nihmPheHAwO35oTGCUFo0eQmZq1F3NU/SA4W0ZwTRsEVjwBlA+5R
         RBuw==
X-Gm-Message-State: AOJu0YwDLNByZDphYcebkf9/wpZNtAI/NuGD1N/OplPmYo5H5nbZJWDE
	FCJ6wbQvs+yCqw9bRC/sH4Ytt8IfWElhyEcqOEMTzNVqP/sSix6y/xXVaGuN783n
X-Gm-Gg: AZuq6aKyzL4XGF0DSnl+VFWKtRo63V4r1UHFyEkKEwO6vvbHOrFwxoMTO3JtkdFiWIw
	u0nQzVSR0kqNi4ysIOM33vM8iYeX1K3N2lLh63OnjRtmy62hIpLh9YMhRiSjfXXYWn+QJAv2jmF
	VKoIVbPnyMIVS/9eVVAlYcaQz6NfvsySeq9TgjzL8DPnhueeK3sUhR9+S0UnGHSapNX8WPXZ4iY
	LDXk6E4rXDSAgQ8cuhT8c4Liu+bJGM2otO1pfq29TPuS071fKIkEVNERyjtUUJ85UdkicXMtp9w
	8s+yRnzZbQsF14BS6S4WVnmkSMMHeTpT6P9jJbVEj9OD7zCg63Mw+DZgEeyqLpPt9IV8uBffZPf
	mh2IQQhnMtYqDXDzriq+KIenyz4bzx6RySGZKsjcVO3OQ1BqayvtMJL0mBHWhxVxziHNyleNL0F
	iz412brYfZMfzckW9d
X-Received: by 2002:a05:6214:1d24:b0:894:6534:1942 with SMTP id 6a1803df08f44-894cc7b9e11mr41623656d6.7.1769538047833;
        Tue, 27 Jan 2026 10:20:47 -0800 (PST)
Received: from [172.17.0.2] ([20.161.67.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d48940sm22284285a.44.2026.01.27.10.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:20:47 -0800 (PST)
Message-ID: <697901ff.050a0220.11b753.17d0@mx.google.com>
Date: Tue, 27 Jan 2026 10:20:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1394048435942339360=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] doc/qualification: Add PICS and howto for the SDP qualification
In-Reply-To: <20260127171433.151442-1-frederic.danis@collabora.com>
References: <20260127171433.151442-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1394048435942339360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1047698

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      19.85 seconds
BluezMake                     PASS      630.91 seconds
MakeCheck                     PASS      20.44 seconds
MakeDistcheck                 PASS      239.18 seconds
CheckValgrind                 PASS      293.39 seconds
CheckSmatch                   PASS      351.27 seconds
bluezmakeextell               PASS      184.68 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      1012.00 seconds

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


--===============1394048435942339360==--
