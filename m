Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2280206296
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026314; cv=none; b=XETA84/n7RWkg6EmYrjSHI9YLmrNrXUvnHJioKv+O0mKBFeG9kU8gy0RKlSCp/c1dZ95WrXy32DlKNZSTQ5JpjQofpGpf7CtXWiakFbinVVOwLOgNiQN+YAJjFq5PfQoYsXwmHKLu+f+sDE68sc00Slxdh4xkdOp3MKHyW1H9Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026314; c=relaxed/simple;
	bh=L+s1Kj65y1/dl9T2aLX5MBzBbb+Of8HM+dhvrlbKC7k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hwpH7PHGJoJJb7ugYsbH4/Ce736XWynfNFKoxOKwCVK31xEWcc4HsD/B6aBXMKmeZCk+tuHkPnB/R1wxH4TFHaCx5fPhzw2aUW6LjgrZBelbUqiiGEUBz+dD/pfT1n0P6cyCpPLf6hrfZFL/1bkPX90iA2LcvcgcGXJPaSkLYcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HG/9rhZd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG/9rhZd"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-728e81257bfso766327b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 09:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734026312; x=1734631112; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J5JPUbDvl7WycN/TwpEKqFFBRhvqqPt6A+0JR8QYBh0=;
        b=HG/9rhZd396RdXFDIBnVgHqrgaWfKiQ4GzPkKtI50c0oE6881ngSdGfG6CeovAFkik
         GJkJXmNBPGJTXV1ITOpkmMA3hvhmdLzvv858Lq2boLC6PqFfec4KXvWltudz10ZDl4Zf
         3CgxEciMC2ua/MVeroepQ6ZsLm44j3eYioVVi7g/tJGxICLG7/xFNrf5EHQM/jn9YJy+
         5quzqYcxBsza6rrZxeGZKhXamGImwlk/Apr71Us6ZANhXzCTyQkHFN/IM4YOnNcsZJxM
         myk1fvoVzSKgrSczzi/o7Wj5ruMdubTFHQe3/Y3Vu2VeZea4o48ZfgaLkdnrs9qqREyJ
         IVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026312; x=1734631112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5JPUbDvl7WycN/TwpEKqFFBRhvqqPt6A+0JR8QYBh0=;
        b=oy2BQfiZw/aoupg1muIKSwjfsT/nQfdLdNx/+vTxFkLzSjUOETETuFZ2OCdUTXVes1
         +QssNrVeDyXayveDyqf/n77bJTYwV82xL2HdWFVosEuFCQt6UD198eDvaBvPP9d6w8UV
         pUmMR3TCKbTojRc9AWz7xM6XxWUSciKz9z6tu8W1b3lDQEHM401XuQ0reqlBfs7B9vJa
         QDF/3lkyOdBDwPjEgKGcB1ZbComn8DqYlzbK85ZyXhpQVYYnTcBY5t21lPZLtElj4OnX
         blJ2BTSIhVpbDKlBCYAO1PfAqRF2v4IQTWvJIvYs+8GbSdMeE/U7UYw4FQuV7x7vTQq2
         uE0w==
X-Gm-Message-State: AOJu0YztP+pGqfzpFfWbVHX6IeA/hoMNlOz7pbgmUcLyPbkd283xu7uU
	wQF/YxKFy/xCzH+tWrP33kYh2Ocp407zSDfn+jc+sJEy3KuCyWxmC0fmyQ==
X-Gm-Gg: ASbGncsGwXaDgQQ4mFVRrBa4eB5UPmrTnYOo2MvecKRJVCkaiy07PhzbWSxNzFKYrgY
	WA/Kx7JAi9jk1KhJQdz3sL3U9QtEOwtiCvgodLygpdYylEj9bMIogCmz6c3Ufmk5uMcdwH5Dnfq
	zw3E4bg/9yvv1wtr9MjxixnC5L3/WWVQCZaU7wI9sDHFw+Tz3D0pi9/W7VajLw68Ew10YCwaaxH
	ljOKV3jktvdy3XzbSYPC9w5PgRV96d++F816MziHUcSgTk4G0XGPjitmhntLyo=
X-Google-Smtp-Source: AGHT+IFGsX1QT7Slg81z8DRu341LfDemb72bjF6vmxLL7N98DYQx7oDsYdM1fDFjuGnI8Yf9EDCqrw==
X-Received: by 2002:a05:6a00:ab04:b0:728:e52b:1cc9 with SMTP id d2e1a72fcca58-72906a3ac3cmr1570194b3a.18.1734026311654;
        Thu, 12 Dec 2024 09:58:31 -0800 (PST)
Received: from [172.17.0.2] ([20.171.122.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-726b9301a48sm6619466b3a.30.2024.12.12.09.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 09:58:31 -0800 (PST)
Message-ID: <675b2447.050a0220.39ecd6.af42@mx.google.com>
Date: Thu, 12 Dec 2024 09:58:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7232281560177274639=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: Bluetooth: btusb: add sysfs attribute to control USB alt setting
In-Reply-To: <20241212173551.192925-1-yinghsu@chromium.org>
References: <20241212173551.192925-1-yinghsu@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7232281560177274639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=917321

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.76 seconds
CheckAllWarning               PASS      27.05 seconds
CheckSparse                   PASS      30.79 seconds
BuildKernel32                 PASS      24.46 seconds
TestRunnerSetup               PASS      434.06 seconds
TestRunner_l2cap-tester       PASS      20.47 seconds
TestRunner_iso-tester         PASS      31.71 seconds
TestRunner_bnep-tester        PASS      4.88 seconds
TestRunner_mgmt-tester        PASS      121.82 seconds
TestRunner_rfcomm-tester      PASS      7.60 seconds
TestRunner_sco-tester         PASS      9.38 seconds
TestRunner_ioctl-tester       PASS      8.27 seconds
TestRunner_mesh-tester        PASS      6.07 seconds
TestRunner_smp-tester         PASS      7.03 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7232281560177274639==--
