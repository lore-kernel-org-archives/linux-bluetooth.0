Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C01C4A34
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Dec 2024 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735054381; cv=none; b=jtHE4jho07bd4nJLlXmU0th4v443RMOSIOpn+F1Btl/glfyDBEm17DXHTI5N1qZ4fQT9qKhk4GaOW47L50UkvNOlKXNFlAulOxL688rJBl50LeG05jTQaKdBCAsdFuJdiu2UluMvC7/9sXykjElXpY/pThBwagndrv/13zHZHeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735054381; c=relaxed/simple;
	bh=2zQ2VCvCuKH2O8SNOvMwN0WlXl2WQJjPN8zC1fDI0ZE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nzzXAbUDzN1L6QxAsj/8p33O8W2g+k1esKc0itn6PHNZmyc0EVO4VdxR9jik/2CxRJO32HmA2/gnQDqtmr4qpbup9R7LMlVLpImS4+CXrf8lDG8ZAuiIaABgZx6sNCgBC3Rmh6qSduOnyNRbKD6fkbfuT859zB8gIagQoVTsIP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irRbfFTo; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irRbfFTo"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6e8814842so437873885a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Dec 2024 07:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735054379; x=1735659179; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GVYK9LrzyrAIsiAY56syPhHaGboz1xEO/cfHtWcMC6Q=;
        b=irRbfFTovPptnvw+z0BE2kkgoUepU54vgaq2dQqApo6qecgDbNxTWxIR23yrRfD1oF
         2U1IYfU1TY1hr8sqPJ3rZheyPDKOnpqhzggXObRhx9JwS3z+QwHf4Kpz+JdmH9kY0Ob6
         DhWolIPEqzCJhoyL/qlfgkaOGrQlb9Oz6T5708HVnSsMxmrWAS/2UgE+vf2tMQyRwsZj
         jgex9uac8LAbvfETtYxce6PU0ssZhqYd+Jpp4L8vie4SqrEZfT0tYWd1sohLzzznOHZM
         Sqr/xKLf0WAm7XmnCbxeCXzQmBzduK8fN06ilBrbNVhWz6wE1SM8FEc0soTMpOxolwms
         nL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735054379; x=1735659179;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVYK9LrzyrAIsiAY56syPhHaGboz1xEO/cfHtWcMC6Q=;
        b=ehtPnoIoNFYz+ZZybjH+Y0sCsLvzqbkEv43Ol4cewN4f2UF1WEYsiWp2XOmlUP2IWr
         pTod68g14Lkf+9mnXTv9/AQrXcBVFdgTDT/VaPkncGxWWlekty6vsM0dKbtBC8K1xJ8o
         mXYdSF1vn3CNHW0IvqdPHB4ZhDpphHuNt/+RvKtUUtC7FZDwLWyJSIVSWjbRr/xOW2KR
         acmQPLhgZ2Gn65/NppMPL8aqwc/LROkFSTFP1ivpZ5x2d+SmcmKRUshRW6AiEgUhg/D1
         H9dp4aQN3nKQJTl8t0ua1qwp2DNrGBTH6YSWseyoFchzwBHs21jXk79yDggF1XI4ELgg
         fZRA==
X-Gm-Message-State: AOJu0YwMBIKyoaMFBWXC0Mw5JBlhvCxf8wEMn7NdwwXc37VME3iMtUdR
	0Bu89+ZnlpCsKnX2j22l/7+RWh+iAoX9cCBCkb4XNC7Y8v7IwEq3yw0Qww==
X-Gm-Gg: ASbGnctNOGqxCkvZznWI1hChLyI5UjV4HhbWFGMROj7tqJCUQ0WJvxD9e/b6ogVyqpb
	zKKMmckMKCzU2bFyTzyzKWgkh4rAvH22MRRmZn62k3b7xl3UWaracSu9Xa5/KV6iaE6O0+qI0Hg
	G/hBrz3WGzz/N4lRZjKa4RfsX/wo7jeOV3OD4dpgDE07+AX6aNlAIKVsY1zlNQs991y7cvslJUn
	WJuhpOWTe/Gk13tYj5hQ+tOWV8AYS3u7NKK9lPMDdDsIK3Bld3R3dhdLs9/qw==
X-Google-Smtp-Source: AGHT+IFw1+ROiUpvIKNoZHlkQzNuIjvgHcdsXQN+tzfPXDESXVsRq3R1JO6bXMMZAiDtifLXgoD08A==
X-Received: by 2002:a05:620a:454d:b0:7b6:dd32:ec99 with SMTP id af79cd13be357-7b9ba6fdbc6mr3012418985a.5.1735054378740;
        Tue, 24 Dec 2024 07:32:58 -0800 (PST)
Received: from [172.17.0.2] ([20.81.159.55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2e6587sm475286385a.48.2024.12.24.07.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 07:32:58 -0800 (PST)
Message-ID: <676ad42a.050a0220.38ecd9.feb6@mx.google.com>
Date: Tue, 24 Dec 2024 07:32:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8081526262051294614=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mahesh.talewad@nxp.com
Subject: RE: HID device connection issue fixed.
In-Reply-To: <20241224142424.10572-2-mahesh.talewad@nxp.com>
References: <20241224142424.10572-2-mahesh.talewad@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8081526262051294614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=920753

---Test result---

Test Summary:
CheckPatch                    PENDING   0.18 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      22.57 seconds
BluezMake                     PASS      1563.66 seconds
MakeCheck                     PASS      13.64 seconds
MakeDistcheck                 PASS      161.53 seconds
CheckValgrind                 PASS      215.49 seconds
CheckSmatch                   PASS      274.53 seconds
bluezmakeextell               PASS      99.83 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      863.68 seconds

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


--===============8081526262051294614==--
