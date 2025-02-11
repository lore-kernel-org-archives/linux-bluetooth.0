Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6323433BE
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739255834; cv=none; b=Ip/ESDB2E1ifi0qw7Ou8hTRIlTqqQbAOwqRzmUmSXlN6AGIIRU0+9lpup8XBdv8TsP+JXQkCwbzmO7tHTVI/P8CliTuffqKCdRtxyWZ9c6pdrZ/Yl5ecALGhx6qHazfALAC2ojEG1vwbPfC9flFQpA/NmdaJRYD3eZacqdvkqmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739255834; c=relaxed/simple;
	bh=mYVtUESwhLxNCKkwziYrV4KpF/iXc9LUYkZBeSCW8DM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lmvYVq5K1H/78LFfBJGNOqLpsv8EchPg1cUWfwD5QmVwcytin4NHOcuqFBP/cMyZ3bEZpXVihucHZ/qC4yrNUfNc6uMiOSgwirvW6Msrskc/uDtbyUvINgpMDOeHPnb2gGeISKfJShreviWlHMDPq2wtzJU6lf6qhkpAKRP+jow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UN1RJftW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN1RJftW"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fa21145217so8158451a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2025 22:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739255832; x=1739860632; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LUxQOoIjdDRS2EsrcqEIEgLdwI4PgjQ7aKHAfrr4c4s=;
        b=UN1RJftWsK83xqmRfgeKE5EsyFev0Ok9Dz9k+1ONEBajn47+1mK/RP3K3pt4iJrt5k
         CLwkZUH4ILmGOtksVo/9E0zDYFOClUkTqRVbhAwXO//53SijHtzjcZhjGkDBDIPxCohG
         KkMn3bb9Jl30irGb84b8LYygMOWweXixiSEtQdcsuyGHEM7yOVLr9DrUYv+UdTmWmYpT
         c/ykqoITFogybL/O9h9m2h5vJwijf0EfULBfJa5zr/TTLjvdXweukOC7jUzzJd552S76
         rN9Xr9nBEuQZqAWChs4J3HKW8hL/ORlWoV7b37wzxa/cbuWMFFUH0c3/1VlyVYfZ2/1L
         +z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739255832; x=1739860632;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUxQOoIjdDRS2EsrcqEIEgLdwI4PgjQ7aKHAfrr4c4s=;
        b=BfedUeVWQT7Tle4etzi311tpA2iOR+2ftcON/KQbJkMEF9d9sZ4uGF3t9mBAJOno1D
         GK5ALwEq88NvECYYi71FWwy7amqEIFGBjeNhwZK2Ewxbj5TIjOWDeTLIJCgU15HVOtf+
         vzTZF33xAOq4FtoFhvNC+4GQ3Go9AlM2oJSPBOPdVNoYubFkbQ8u2bLAhj9sOHPDlrjY
         TDG9dpGBBHKGBird9I1QF9540yM0c74S/JUWdywRuCgbExam9g3HYUX+6XkAhYqRdvgo
         K+3TXYzYNws+kvTVix+Ld0nsqDNM/+aDzIb+F5BqtvHzuU/4u5YsdB3gAUxzMNG00U07
         6hEg==
X-Gm-Message-State: AOJu0YzLrsFnKsxu8v8KKMOQzUcpTZiq6w14QGHFbKCTqBaD6RNszfcS
	gMuosBIUYru3CDaXVcub2qF0zqUIRnX9L0AcBqbpjmTpw+vzHneBiLRvcw==
X-Gm-Gg: ASbGncu88YM51Eq/ApL+wA7QI/b7CxaLpmTYCeBbR3zZiNrvMdDJsI1XaYSVVzKS3sQ
	AQL3V4Zrty+U0nSsZulP3ScxNzNMwF2JxDvgIsP0whYLy1VswwdmQPRcEmmv9iIq6rzPGE2GDgB
	FSNIXbypWBCkWSEoGjK66oFv4xsQR1hrWYjrHNS3d+/z+9q8tGvDU0f3y0pe1JUPwpzK2dF48ny
	7IWU+g7DDIszKL1M+gquzJsgh+F907JqRrDoEyFRouGSM848kzNF9wZc+CBSPF/imI3ObhJsHap
	CbYzfvTSzkDhPe+PCzJ1WA==
X-Google-Smtp-Source: AGHT+IEbJo/sssdYuqQKLAidFYZ6IFHXHxTiapvjRlOUquIXWQq6Kzu216gsXUoV6etWuKfrqGyKbw==
X-Received: by 2002:a17:90a:d443:b0:2f6:f32e:90ac with SMTP id 98e67ed59e1d1-2fa24066820mr25739523a91.11.1739255831620;
        Mon, 10 Feb 2025 22:37:11 -0800 (PST)
Received: from [172.17.0.2] ([52.234.47.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2faa30a356csm758922a91.7.2025.02.10.22.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 22:37:11 -0800 (PST)
Message-ID: <67aaf017.170a0220.1019e1.2769@mx.google.com>
Date: Mon, 10 Feb 2025 22:37:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3387373067708316010=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v1] Support BT remote wake.
In-Reply-To: <20250211112619.1901277-1-chandrashekar.devegowda@intel.com>
References: <20250211112619.1901277-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3387373067708316010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=932514

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 FAIL      0.30 seconds
BuildKernel                   PASS      24.89 seconds
CheckAllWarning               PASS      27.04 seconds
CheckSparse                   PASS      30.47 seconds
BuildKernel32                 PASS      24.27 seconds
TestRunnerSetup               PASS      432.79 seconds
TestRunner_l2cap-tester       PASS      20.37 seconds
TestRunner_iso-tester         PASS      31.75 seconds
TestRunner_bnep-tester        PASS      10.22 seconds
TestRunner_mgmt-tester        PASS      121.61 seconds
TestRunner_rfcomm-tester      PASS      7.34 seconds
TestRunner_sco-tester         PASS      9.15 seconds
TestRunner_ioctl-tester       PASS      8.06 seconds
TestRunner_mesh-tester        PASS      5.92 seconds
TestRunner_smp-tester         PASS      6.83 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PENDING   0.92 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3387373067708316010==--
