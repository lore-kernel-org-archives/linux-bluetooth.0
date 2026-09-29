Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EDF3CAE99
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664905; cv=none; b=GK8MmAoJGK4s0Lq8voRSo2PFloQ+Z8idjy4B2DZepC4xKgu8qLtSgpR9mstMWW+HynKik21h9IryXFvin1cfy28tnJSC+NtM64x8iuWpKbJ8OQpr/x2AtsiBwIwBBrVWb0b/ajLRcR7LJFig9qBEEvIJlG/Gw7PopfxBsm9V1dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664905; c=relaxed/simple;
	bh=x61S9bRZn5ofHsbSeBsFQGPEkeBHpU4wudfJfuERoBE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gbBJ0bH85P2accbOtfm7PShfqPRIYz3RSuSj4DVfqmQ2SNO3jfrqt7U62XsHJ4I5YIcgx7z+6ZtdGrBaIxLXANi1EzyV5SEm1mlFuvXeh2uxmIQlEwi7T+OKThojiWzZu3DDlW4XG7Sdas/XUMuXjWFDQhqeI4vovaKqZUZUYL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfdFAXnW; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfdFAXnW"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-4940ae3ff4dso1274778fac.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790664903; x=1791269703; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JpAgAgx4Di5d8YPX5ooJJcz7CXez3fpL73YE9EkfIHw=;
        b=HfdFAXnWXGY1RJLkFUbfqgfPHaO+D09uJeNXhY3sLSFQc5BGjOm3Gt9Mu3VccC1+tF
         g4B4D8DrRbm0ylcATxwuLbRLGcUkC8vJgSlcRidTbvNhg57FLznT8dkvrXrJCO3GSpb6
         oE0uE5OTe27/GSCqPXZuyx2VcF2TfSNSAAvVCRpanbMecy8BgxdnVccZIpjvIVrrfAp6
         bvhP42pHc8o0rbpduCVjYSryq4eeAD6VRMalC4VPXYCQUsuNLu7ZlGAhBX1xH81zOsfg
         tx8TZhDDI4QkbgJdnVGrT3W6jzTdBjv7CXVwFQUNNBos+VaKzgCGGmuvAuYGkVaZkkPC
         ubSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790664903; x=1791269703;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JpAgAgx4Di5d8YPX5ooJJcz7CXez3fpL73YE9EkfIHw=;
        b=CG2KtRNgndovwZNFgCKgEdl7+Sj1R6VEwulV0h3RhM+VqpeW+qLAbrrDmslGnjpUiR
         cXmz5PKDzCcGYVvzJIeqX9wc2ClCxXxrBao2fmjx7+GuFcJDGTcwCO7obeLhebTJQ8Fu
         rwKv0cq44kiiF+gx5zWiavLpkpJkbh871p0I34eKbZeO345HhjfuPR9sn1G7oVdc3zrw
         0/M6ME8aI1DnX6/Ff6sNwbSqaXwWuarufxJLBu2asKdoah4gOR4rXwkuikCfYp3HXWpM
         rJ5Xc1ecRXmh5uteBXjKdKomn87Skg1fAODtlL/0YCltPKzFoRc/HNdMAL9+9eNQI5ws
         FC2g==
X-Gm-Message-State: AFuF++n4lj46qYwH2krNqVG+1OZYyC1QxFlZ85G4FtrYAG2f7I1j/rug
	0d6QrvdhLK6RfbAjJSa2W5ocI4e+exdsPt2JinFkO3jIGSofFjwDKLV6hL/BYDqQ
X-Gm-Gg: AYBFou3soGCtI8O6NHjYdCH2QPHPvBc3Paoqz9UwWJEiXcmxEU5FhhfxDDowH1SQ8p9
	8DpqIM4JY5qoGlbt2Hw8KdlWHhN4Zxqvv4FkBjyLfuJ0/yUZma+vPYoEViRlC89LsS5vtS3i/bR
	zsjG3Phw/Ugoso7pvmcLfIVZSR0b85RAZZHhyK7rSIWHWCZTTDI+dqsYlw0vU0hNRa4ezxqNody
	btsmQXhTTkn4F08/pOkSFYuSHay6Cu4bkZwSZUmPQMcmjicoHGh44YVRKJ8EIFtOLMxeABJk5Wx
	QRMIc1+T0awmNJg+okGvolan5l5YU383nljawXkcDW8qOqjEMrqOVDdvVFkQWxTcDyPAUpZYggT
	hTCoXqqH1VLdelQmQPGN3gEI+Zwixv3ZQa+95ZfiEflcb9UwL5KZ1pUFNK1+WEe/AgzNlX//fmC
	LyotnkANegnGvRFeBSkSGmbrYsXAXZY2g7DJ7bCzkpzydHj9ejqspGB0Pv9smgtZpCMDS2QvH7b
	mEjGg==
X-Received: by 2002:a05:6808:3c48:b0:4d6:92c3:868 with SMTP id 5614622812f47-4d72f151f71mr13936870b6e.65.1790664902976;
        Mon, 28 Sep 2026 23:55:02 -0700 (PDT)
Received: from [172.17.0.2] ([52.242.217.85])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ebbc9a66bdsm4036163b6e.14.2026.09.28.23.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 23:55:02 -0700 (PDT)
Message-ID: <6abb60c6.321a4155.2c061d.402a@mx.google.com>
Date: Mon, 28 Sep 2026 23:55:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3205429962256896612=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Add shared HW reset for clean start
In-Reply-To: <20260929045449.200096-1-aluvala.sai.teja@intel.com>
References: <20260929045449.200096-1-aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3205429962256896612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1175765/

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      23.73 seconds
CheckAllWarning               PASS      27.24 seconds
CheckSparse                   PASS      29.37 seconds
BuildKernel32                 PASS      23.83 seconds
CheckKernelLLVM               PASS      24.90 seconds
TestRunnerSetup               PASS      596.05 seconds
IncrementalBuild              PASS      24.51 seconds



https://github.com/bluez/bluetooth-next/pull/836

---
Regards,
Linux Bluetooth


--===============3205429962256896612==--
