Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8292517AA
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 17:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107877; cv=none; b=e1wh9pwXi8CKZfIGhsc5SlZRPPeInfjX19CCxrXKsae39yfmYq2o5dRZeR8K2WQ4Mlbz4NtuvYsFIdz9A79zNj/tqqOHqKLekFH1JXLlCkLlYKC4csFYRksalAEUDPOZd99Pu3S1F7HQIfF6uuQrnfC5IsgEJyhupGJdj2+uUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107877; c=relaxed/simple;
	bh=PSqNm7qi0/JpO97zHu1EljT7AGiVBSCA/QFgNRnPg/4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jSam07lRC7DdLrdgL4Ses+hPIn2TgbxPQt0q67Uucw0QGGeMfQDXPx3L3fcVGamhc20GoESU5gKMB3TMtxHprL5wEQ1DVOz2y4xsElXnT252eOSg2s1hu2L6HvpKNe0r9FeIlgk10EL8s5kXqxirkt5PpScsU/2juNOGUtuJwMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iChwaTwa; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iChwaTwa"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47509ac80cbso1271071cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Mar 2025 09:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741107874; x=1741712674; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kc3FVrx8ya6mWcbx5DkG3c8Rp+48Gw1/Y8i4lxUTdzk=;
        b=iChwaTwaWjmgLQxAiatAkuUIilBxBpnqREfJ4MlUjEYzprD9PIcC9JtXUPb6tXZhfA
         k0skTtm3MN/0mrWh6mE8LJWV/PgTOaKvAPKlmfokinBCjb8yNl8sk51WehoZaNm/fzXN
         gt/eRl5JyxfVPh2QKxEFF5cGJxx/PKsSubZDmZEELepBsGy0vr8eN8SYCqsHxHld6rUD
         b7qtSv7gzPlzOxpm3aMPFsSpr68xRmHaJbrtV8zhWxTJh06Fnfd9wbuwT9WAkv8XI9Sr
         TGTdSboQtCQX2XGvgNXyhV0mJIax6QYH61o/TF7gObHl3LT+x6N7BWRsrZAu46ZFzAXU
         /8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107874; x=1741712674;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kc3FVrx8ya6mWcbx5DkG3c8Rp+48Gw1/Y8i4lxUTdzk=;
        b=pYF9Aav/Its1nqJ3WLpeGy5PXWN38XuxXFKw+ESv/Mocj6M3IhvfJK+UwlwW/BGiwm
         k5x5dZgEt1i0mji7VYVTpc+5q6lw+NjYfxiBZXGpds+0zn4qd8GoJsL933KPPwiGfA69
         jtyXB5IupL7W0y4GeDZwZQzUQSN8ykALNglprQYv3OoDAYwdz+wGbyndXNahmxi207U3
         gCZAoliYSZ4UFMTqnn+/Z6NUEPlDJXpZyJuFTzDCASxjaXe2x9qUODrEvkPOtpQHP+1T
         GiQ0coTqo7tWWKCH8S2+tK4JyHANCUn0UW/rwC6B7w8SUaG2119tLQnSEUhZqq3acm2l
         grSw==
X-Gm-Message-State: AOJu0YyqEKeTJxliTVZoQrWe3tCe8PI1kGAClFbDeKDIlK0o+Ym5YhI4
	sbhNfssZNq29H58JsHFo/C3LdntzXsCVzWT5ltmAq1+b3E5lwl+iz0dJlQ==
X-Gm-Gg: ASbGncuxy0qw2qEoIp+KXfa5kspK5n4M4LpS5kHDKabY78yrm/UvMhP7BQVYSC2rjhH
	SmuNFo841VLbUG+y9nrz2zChp+VK+C9C5Kz0qACXOFeMj8+iZ8OPYztLP4QWDZYQSLg0G5zHb4X
	xxsEykZ1daFP/MzXWrpoS5qNulh3wEPgN34TW75ecFIpPKQqd5B3jgNsL17VX6pbNwTdEMuottA
	LApyLRgnnHOupHWRAAO9kWtTkWADBUgYxoDQqzAIndp/Wlwbf0HS0EfEhutfmLger9+7yg1A4wl
	jucAqhR71jw+8hHNDlsfiq6uxkni/I5IzlSq/gUZUkpVkgXI2xXD
X-Google-Smtp-Source: AGHT+IE6tvPxcobWxPFupm1MnJvQa0xupA9QAZGbrvXlklcsd5aTGNF8H5eGQ7vJC2BceGz8ziwQZg==
X-Received: by 2002:ac8:5813:0:b0:475:42d:ea07 with SMTP id d75a77b69052e-475042deb6cmr27643191cf.49.1741107873970;
        Tue, 04 Mar 2025 09:04:33 -0800 (PST)
Received: from [172.17.0.2] ([172.183.221.48])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474ec0587f9sm28652561cf.46.2025.03.04.09.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:04:33 -0800 (PST)
Message-ID: <67c732a1.c80a0220.11dd06.93ed@mx.google.com>
Date: Tue, 04 Mar 2025 09:04:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0153627660727648135=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Trigger device coredump on hardware exception
In-Reply-To: <20250304162135.254530-1-kiran.k@intel.com>
References: <20250304162135.254530-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0153627660727648135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=940159

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.05 seconds
CheckAllWarning               PASS      27.66 seconds
CheckSparse                   PASS      30.73 seconds
BuildKernel32                 PASS      24.91 seconds
TestRunnerSetup               PASS      435.45 seconds
TestRunner_l2cap-tester       PASS      21.36 seconds
TestRunner_iso-tester         PASS      31.99 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        PASS      122.68 seconds
TestRunner_rfcomm-tester      PASS      10.31 seconds
TestRunner_sco-tester         PASS      12.72 seconds
TestRunner_ioctl-tester       PASS      8.95 seconds
TestRunner_mesh-tester        FAIL      6.39 seconds
TestRunner_smp-tester         PASS      7.32 seconds
TestRunner_userchan-tester    PASS      5.09 seconds
IncrementalBuild              PENDING   0.93 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.117 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0153627660727648135==--
