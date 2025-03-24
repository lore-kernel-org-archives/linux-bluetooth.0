Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F0A43ABC
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742816242; cv=none; b=DXJ4WxwIbs7Lsrrr6d+Gwhd3mwWOACxVxttdLRoOB51+N7h4IJ1zbrOiuNOWuR+39ll7AQr24C3CuLgNTuJ8axgRMBrbSszEAA9jEh7FquplyZe+xLBBMXbfSwuS9MMs/6UXwp2TRMDR8SvZFYIh4sT8u/BkLYqkyhre/u0SUAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742816242; c=relaxed/simple;
	bh=vFfmE8R2IOCwAzLnXNy7JfOnPktkxudqQIt2Gl1uIEo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lznMFUu0B3d6Mv7miKZlRn7kUHyNo6JSPTmIRanvxpj9tT5elMKR+KJXER2B5CkdhSSUKiVhYxaELkcQK+k2wJPZiTAz7+vhv1BwgP1oSwTntD8mshgRrvNji7cUK4qN5ZNFq6Lk/XXQ+60PyUv/qNOX/MBQ3RKznAUO/IZCPac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dw62hhEz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dw62hhEz"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2260c915749so53187275ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 04:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742816240; x=1743421040; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YpMVk9UARhNGnGw+k7MYfQUkBpaU5ENdsYWvsuqSldc=;
        b=Dw62hhEzM8n1Gfjvcfjmpd0w8IP20FPUHRs4727LB0CZtMzBVLVE3rNWM59jPYMgsm
         cWB9d9CrgPP9Rt4vPIGk4YoZl8ZbllbFC14LPPNabDmHfKmeOYWTUha81Yz/DUID6R2p
         N4HG8zAiJouMM5ZGsyLAnZ+MzcZhHo8meaE52YYvaHARLFVkXiREVilAZyyC/dGmlF3B
         TvMA614DWrxncZyAPkOIXOOkHdiGcQMnt1whXhLjatM0QZxVlemnCSJRBRKze2rk4eNT
         jNgkwXau6K/UXmc1MbuVkD3AH2K6uVu5mlAN8RbV3JN17gOLbLqqeqBBUaCt/s8czru+
         JPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742816240; x=1743421040;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpMVk9UARhNGnGw+k7MYfQUkBpaU5ENdsYWvsuqSldc=;
        b=XhhXm8WEA/zVPeMdpFgKDG34cH/V6VKwxJjV7gL5uGvCUKPAe/ntFZH7MiiiuoOJQC
         6/dhAtlylOuicmO0UNJHBArGh3X9v6A+cvjTE0pIyZiU6+mkD8VtjcsfVSstW69p7zTB
         IIXnEWheXB1x0CgB88Gw3EuMzxCYb8q/kcWQXBwdzsmQKRyoV+y73r0vm6r82jemzSPx
         xN2AIdNTj3TtydFyH0ydHIJreStLqQ918+8uiUkLjy1Mb9KMR289PfM1z5zaBFPjmIVR
         2P9FQvxZtVQrHjscMYNtXfOQHCJ0GkBVYi7I9peFAhKkFh3zeQeIBxqZaXciwR7zJPjX
         59qw==
X-Gm-Message-State: AOJu0YzLzSFkXH5phdVG3x+QwBj+wGp7NiC/A9KC84HfbwmnU2cNt1N8
	z9hZsbXiZ/v0zkxrC8/9hg+/Y3xyr4cTQ8nz+R8ivzM9wT5eZ+QLiNuOrg==
X-Gm-Gg: ASbGnctutQwBFulRI0tfgftAj9hhywZofAR0CT6Hx2trbPnd0f2Xs1YR4uhOL4KEpfE
	dgN3m0Zwne2nycesDX4TBkAX5qCCsl4fZwThL/Q6pmoCTWFi9+xrufLjePdz6sHcDtbsZSPQwdo
	1SNhanQwGMlg96+KzEdu/fb4IEOhq57BP0BzlpQ1qG2R5e5XPJR42grSIt1IBieHkRODF2xfYeI
	WoYgTKEYvLTG8358GzwU7HHSIlr4pAOZA6yhGJzVGudWqcKFAflsozTeqnC5D1hB6xxIM8L2oNp
	/9M/t1xrSuK8XKhBvy0OHB0MZ3STnX9F6+ECuxppCEzqi95vNb0M/TYG8kgR
X-Google-Smtp-Source: AGHT+IGVV9SVLEMJ/BLIr/R5WgBhhLTjfQtVBSP6XnbRAGF2L7rZ8EZiRT/D1Dn4ulCCdamvg0FUkw==
X-Received: by 2002:a05:6a00:4fd6:b0:736:fff2:9ac with SMTP id d2e1a72fcca58-73905a2780bmr20109813b3a.23.1742816239758;
        Mon, 24 Mar 2025 04:37:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.1.152])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd564fsm7958349b3a.52.2025.03.24.04.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 04:37:19 -0700 (PDT)
Message-ID: <67e143ef.050a0220.2851a4.a69b@mx.google.com>
Date: Mon, 24 Mar 2025 04:37:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3814095548351811653=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] obex: MAP MCE Publish supported features during connect
In-Reply-To: <20250324104003.64019-1-frederic.danis@collabora.com>
References: <20250324104003.64019-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3814095548351811653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=946750

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.31 seconds
BluezMake                     PASS      1502.79 seconds
MakeCheck                     PASS      13.30 seconds
MakeDistcheck                 PASS      157.89 seconds
CheckValgrind                 PASS      213.97 seconds
CheckSmatch                   PASS      284.95 seconds
bluezmakeextell               PASS      97.62 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      863.25 seconds

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


--===============3814095548351811653==--
