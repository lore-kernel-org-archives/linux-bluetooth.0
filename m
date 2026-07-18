Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3592135C5
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784397794; cv=none; b=S4JKGu/YdULhpKLTi9M7nlhLFaexLEfciDVVJd4A6LQ4t/wuNPrRgFeqd0CvQcUhgfo3/HGngzzVzmYxTbceH5tTy66b+kQFOpJk0w8jlISiBX7hIYdhOGuQBxJTB3qMIZrPb23jEfM5UpYilBujN5W3Pq+7t7L0wy844JkCf3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784397794; c=relaxed/simple;
	bh=i8CxMnl/RyFmUUVhpsurmcvUO3y4wec4Htf/wN7c4ng=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C95dkCShHEFGrowSUzIgRiawafAFgbzsISXgDJaoauTnyvPAeS9dGX2q3Gc1xMJsAyrjjDteTOAhx7CyFcwcioaRFQlNKC3VDBMz1mi4pMSQ22eB8yx7d/ZRam8GP6VbCmYUtVedCzwT1dw0S8UNplgamQDsBbsXDEe5c2GvD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkXrgsOD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkXrgsOD"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caea3f742bso108183805ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 11:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784397793; x=1785002593; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0sH6RTFUq8LQtnnzL4jgpbTIU6KmF/EzHCc0tjHshgI=;
        b=QkXrgsODVkq/ExVyW8Cif1YWYspPE6pONC8w8cmP2dZErk4L1QAmBJtwoEkiZBzyzP
         pPcQGhB5bXb6yOI7EzLfPt1igqqLiEysld8H+O3ii2n6Y4/B3gWx6iCijTQJpbEhUbTm
         ME+A4NnPtvIS9bzFkB2wqnXUeSWO/tbkv4zAl/J7JKunu/PQXu3hV+2ZtWxpFcLMoRVU
         yDIGAeVMSMSNR4hOp9ozfHe04/ufKmgnO9+ACgHHZTrNZsCVv/Bopsjp3a31UUPVNlvk
         aB8oZRQlyjWavRR2EQTt0bAyMzAG3KAex+fhgwRPzYc05D/ZilDJ0hDnss5CVwJD8prv
         qb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784397793; x=1785002593;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0sH6RTFUq8LQtnnzL4jgpbTIU6KmF/EzHCc0tjHshgI=;
        b=tGq+oca1HFa5Go6Z2aqm4iG7qB5fgcoENZ9RH/aodhBhGjxt7Jz6c1591E+XUdfEPF
         chTI9DpGEjWlu5D2n/vHTcMJErlAWzAdV/5VAR3ETZH99YkWSjGYGk8scmC8npuTB1WW
         bktwn86kbYnzzQqA+BLIu6q6O/oPPeN7Q1uItqNQq9B8Z6HoPKUd5Ac3OohYqgteZP5O
         u0iveD1B2mU/QK5jTPT5fI2fSVBgUIHSO+nav31XmK3zaW9BMDZftbyh9rFmf7ZgBK4d
         Bv8hMke1ALLnnWcJfUw3iKmgz4ungSh6COYNNNkK+j8bcXiiyaSB8s+pFNTbYopvhft0
         rq/A==
X-Gm-Message-State: AOJu0YxSpafVsIJ0MhiW4Yzuu0ep0bfyowGdGyetUAdq/GB4l6Kf6C/i
	qmdIzKeqcz8uDeX3ohTE07M2mnM62rYaq+X4zkRnoXE7If4Ua/9hfEt4J1e31g==
X-Gm-Gg: AfdE7cku2/QKNZGOVbLWDyyDX5OuZCDze5up/Hl+VK+dH30hya6HmUvKPmihzp/hp1C
	/oZecAovmYH+KXe/KA3BFoB6u/xvlt/CJklvmneT3kMWi20zm2HW1Kkv3Y6Astum7XQ7Ae0l79A
	YQOMuCJpib2sH4cYqasxJ9ouq8Xl6uRF4sVa4woKHTXm5qHHToa8j89wMkBlx/ccdquHgenIu+H
	h1Oy8w07kK0KJeUz/W0Ca2Eu/kTFAM8xxp0oNBHax3PTkF81X8WL0CoDVZmfxBOvqi6DMJ6frm0
	Kg64c0bha3Rw6pv2iPuWthet/Arz6WpEEFVx4/IpY5RIpzUkoLyDBAHsdHQ+EnEovEkOG80jBKZ
	kBsXTqC0J+QhniRcf9vWWxT4HqWLSeeZdcKdcjFEPpZAnt/7HmKTg1fBbvZN3kPpL+rnSiiEhhH
	62mGgCgw==
X-Received: by 2002:a17:90b:57c5:b0:38d:3ca9:434 with SMTP id 98e67ed59e1d1-38e4b522df2mr8462864a91.28.1784397792582;
        Sat, 18 Jul 2026 11:03:12 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.4.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1ddeb6sm22767696eec.20.2026.07.18.11.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 11:03:12 -0700 (PDT)
Message-ID: <6a5bbfe0.3cce8983.3cf542.f6be@mx.google.com>
Date: Sat, 18 Jul 2026 11:03:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6501281744160921400=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, u.kleine-koenig@baylibre.com
Subject: RE: [RESEND] Bluetooth: hci_bcm4377: Use named initializers for pci_device_id array
In-Reply-To: <20260718172513.986134-2-u.kleine-koenig@baylibre.com>
References: <20260718172513.986134-2-u.kleine-koenig@baylibre.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6501281744160921400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1130117

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.19 seconds
CheckAllWarning               PASS      27.46 seconds
CheckSparse                   PASS      33.51 seconds
BuildKernel32                 PASS      24.60 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      442.54 seconds
IncrementalBuild              PASS      23.86 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RESEND] Bluetooth: hci_bcm4377: Use named initializers for pci_device_id array

20: B2 Line has trailing whitespace: "or "
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/455

---
Regards,
Linux Bluetooth


--===============6501281744160921400==--
