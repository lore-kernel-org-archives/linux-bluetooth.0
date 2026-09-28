Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E077E3C0624
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581157; cv=none; b=MO8vuC3RADUITRlaFK1cCelXgZQxrfyOIPri2SxaJ73DldTp+62tmJ61RBhAdhycPrSmU6TD5aGRAmTaj1/BsjLE/VYXyKdsOg1b917sZ0qa0HPZbyIDE6CHiCzYCDovbq5N68Ng5mPRd7OtSHIFeC7zBpkkKeJfFMD2WoAcY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581157; c=relaxed/simple;
	bh=nHo9RN/3aG3x+KM80n+Kq6NczEJV5yB802UAYq0iygs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J8y5ENK/DRQiJpET/gnP82PwEcHN0pAMmD8pgrPcpjUgeHAq9XhBCBUVFVK5GJwaOf6cWblnYt8Ek233TVI1i8pRVupnt7ZwKiQ1xQJmXQpjFxKMtduYV+I4PPxxx387n6HKXVaooZXITO2Hpvda40caGgfsV7C9AXf51B+ea9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g56f47TJ; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g56f47TJ"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-144f79153f5so1428107c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 00:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790581155; x=1791185955; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QaW7FXzfP2yTAMIibuP1mitMLaYkoY3gwWnPRoitiJ8=;
        b=g56f47TJw25s0fbjfTBmWDqmR/yMRnK4rHn39Olk/rbgUKGFDC7z/VPphwgQ86o3tD
         60QZowHFisqoqewFg4oXRPN67Lhi70P1leSA+vduBeYsMi7sPzv1DHIvILg4AGJtZElU
         U8cmdf+St32fhwfhozvh46blKtkp1SWE9m4hcvnvbKr3Vzm9LXiotI0O/ag0f3OtGRcJ
         xPiZyNQ9vpnv1S/9w+AqT0LBzy+d92YIKkJ/9/4mtuWadsqeOEYs2aoRwtpD9EsK3bdT
         Ohlx02T5ktaDX3mZrTB2MXYJU6r0aCXjXQVbtWvYBDHvWazHrEXnf+pvibxzT9cZ9I9r
         ZJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581155; x=1791185955;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QaW7FXzfP2yTAMIibuP1mitMLaYkoY3gwWnPRoitiJ8=;
        b=pKJNa/Z+IviNRXunNg2Ytp03KjpsFU4emGiW5JsRChcmnY2ynrW3b6s37ZsQ5c8GXG
         XPb2sXIJtnHs7bGP3Hq7x5b9rsAiParR/wgfhz6qef70C35i1nQky2RZgmrO0F0ypA6r
         b0pWlcDTzuA1EjOvqGgHAyYBT20+p4WeTi1i1Iz/BJI2mcYsuQw1BXJ4THhYeKaxaXN9
         ToE+k9QrhBPe2B/bcBnd1mgBDU7vA5OxwQwBVHf7NdtyYqHLjz7higAg9jsDAWUjXpzj
         nPOd+qneEHdNgr9zVryttA9g5tjUBrFO3gR118Kq3GDIkzMS3x2BCO5n9scfVdgRTiNS
         ii5w==
X-Gm-Message-State: AFuF++nw57HveoqbH7LwRZixtLHGtMPCH7TPeNsUvYl2W1FP9E7vIpux
	rTp3ymkgyLIRB6THPYvVQId248HjhNMaqLpLjkwa69EepuQW2fb5ENTcS40KTQ==
X-Gm-Gg: AYBFou0wGyyw7tZ7J6y1QhHWYNnIgNJkfqX07MbCKwtBL4RGOFJLGPHZN2p4iXaQ+RW
	O+WPeK+Y1pq5bCniew4k4vZn4EuHPeXBKz7TjY2kU+EvlnuGuDt9oHktWuPDtP+LX22JdaJ/DFG
	uvq2jJS2yXIDy3xJb+Mv7R6cyZWFCFZw3sjK/XSROU6P99n2ZQDx3BedOuRBjirQsmrXZKBeX9d
	Wodf5L9Gg9ye7atms+QTc0yDhNc6HaFPoxgKzK4VlDJWNsdJDM9dPWdbhSVsCRNoRLN0ETbsMhL
	Vtv5u8Dn4bXeY1xHPaTCBlGM9hZSau6l5PIOxK+vgoy9ACPKfw5U+l+K8GjhABJVk62XMRWgP6Y
	UhYQ08w1lFdFxry0r+Nze2QzwI0XoWEXF8XZMygXNQlFg8EfxNwUErGDoo/PtgOaCnbGtwPHKQk
	cp9k3nKlNFZ6r0afQQm/XmNt9Y4RVDGO3V/RNgKoc3ES2OeiLyfZkd5GpXJRYTsaojmMx0p9f0s
	wZYdg==
X-Received: by 2002:a05:701b:4555:10b0:149:f2b3:efcb with SMTP id a92af1059eb24-149f2b3f5c4mr1526873c88.14.1790581154408;
        Mon, 28 Sep 2026 00:39:14 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.45.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acc47ab8sm26714276c88.6.2026.09.28.00.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 00:39:13 -0700 (PDT)
Message-ID: <6aba19a1.48d69adf.1ece77.806d@mx.google.com>
Date: Mon, 28 Sep 2026 00:39:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5928734565543401728=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: Bluetooth: btintel_pcie: fix D-state transition and PM flows
In-Reply-To: <20260928050344.2893790-2-ravindra@intel.com>
References: <20260928050344.2893790-2-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5928734565543401728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1174933/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.96 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      1.06 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      29.05 seconds
CheckAllWarning               PASS      32.86 seconds
CheckSparse                   PASS      35.64 seconds
BuildKernel32                 PASS      28.71 seconds
CheckKernelLLVM               PASS      40.18 seconds
TestRunnerSetup               PASS      791.92 seconds
IncrementalBuild              PASS      31.38 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v5,1/4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#90: 
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 0

total: 0 errors, 1 warnings, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14851174.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5,1/4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check

9: B1 Line exceeds max length (82>80): "  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 0"
10: B1 Line exceeds max length (82>80): "  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 1"
11: B1 Line exceeds max length (82>80): "  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 2"
12: B1 Line exceeds max length (98>80): "  btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend [btintel_pcie] returns -16"


https://github.com/bluez/bluetooth-next/pull/831

---
Regards,
Linux Bluetooth


--===============5928734565543401728==--
