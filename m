Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754471DD0F6
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 21:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433310; cv=none; b=tjniXLtP/Lim+bexKCiZLwWbgOEaCKVhgr7TvGGznMygA1/O+0KOCsbXKLWuMGPtDQq7FDcbz4CmMJzgN+WsAsBFkb9Uut/OTXfa3QZ3q2Ih2HRXk86H/eaq4wv6XzyWckC8EwjaXuVWpVcqgeMTci87b6UxK8T/XawaLu9BHLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433310; c=relaxed/simple;
	bh=zR2Grajiofi8PFiJ0KkD5HrB6l+ZFs76SQpcGaT7OK8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aA46TiKPyA7eTYrLu0oDloDg/fwySfm4in+FaoaB+y3Txz2XvqbWKR/MQFLkbMYZkxDetwHgsIL+WOCXTiMFynlDm4pNO8sH3yAaF9Sext+z241kBRxQrjbjagDmfa24BaDlJBZKXGaxLBTMQpu6tsmdoaSLjZPZSvunI+qkjbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAHvHlt7; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAHvHlt7"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e677921db0so33742486d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 13:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740433307; x=1741038107; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JTdlGKxVcLFsbMXgmO/wz+uESNa2yfMKqYi5yKiGvTc=;
        b=UAHvHlt7zDo8VOUxPXf/qS4pU9c1X5qkM7Oebt+Rcr5goetVNKeCWH5WO3W3Ib4AIg
         vKJm+UOFbk3S4A+cslqNFKVDnMznOcr+7WKzXhvQcmmSaamDR806ExNPZ/FKJxSAvshg
         0Jwt0+ZcMnqBJGXbYWVArBQuXlH5ADZwxmJNNYTom/ecQug3vLl4G0jprYBq8ZmQqWtx
         CSxqM2MmHwFx/FtKbttk/zobVKZZWs7qtod0mWr/B7VaXVclstnMGyOFLVSG7Q5cjb10
         thxDOf3feBs0JdT9hjhwi38wPtsQZALfmWY4Z5Air4WNfzFrcy7910gPqH0g318Gjl78
         3Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433307; x=1741038107;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JTdlGKxVcLFsbMXgmO/wz+uESNa2yfMKqYi5yKiGvTc=;
        b=jjsTUjAI4rktmlcCToVaT6On/1Oj3oIK1LGSs1rLD+ZOFC67MLvuS8X9RD0KdAxJXf
         MsUAIECvidngxX7PD6289GlljRbuvXMGAY/iQWvU7oozHPZgccKwAW1sBKZJXWl4axR4
         /skXisnKFLyvS8+191elLhmC3p58sbA3fvbFJ8Ps15huuZ8OYTozefVgG6Hvg3T2SZf/
         /1bFVskY82eqjuaVf3WhmQJFDlwVDXc8ZDOByzwsCwFdrlfy3yrUkfMpZbvZjkZpLOE6
         VawfoJq+hJPI5mhQdOYzE1GEHouzr0RRBG/cQELbuV5JNZUIhkOulD7HhiSdq2xzgx0i
         X7WQ==
X-Gm-Message-State: AOJu0YxYt7m1QDe93f3vMfm2xxvYqgybPNoVVsS/jXd6+//UnBXSe4Ag
	BSRGykMpakJhPcR9Ck/sg4mnlVGgIUEcLz2BateMCr2SPO6l2i/ZX6xccA==
X-Gm-Gg: ASbGncuO6Gif0OYbgPhU9alzSD/BPx6ymGTRc2CoBuMLypOMfOHUwSzGjP/lxJ9VgUR
	LJqR1+R73I6Zr98xnSwI4LS+QsoQrqZV80XagfQjhPu4fPtXdhkm7SMuXiLS+XiXWX/XUn3VH4y
	nYdCasowE3r4xO0/+FSZeXzS20ZWXU23YUTUgDpKUOGQz2omWAaR31Hz+JD2ghjQQRGk0/UOq6C
	W2pIjz3M8IfVOIdOvR4XzIEUxPQA4dC4Tybn7QKvbbpLdFHOj1fHtc3w5aY3pe38/n4434F7+1k
	X7sRersZuCOfeVno6MLXscLH9O0wcok=
X-Google-Smtp-Source: AGHT+IGXw6DJubkR8aLftaQwKdcMnL1lDTSHUd7d38pqnYgHZK5qq2ZeoIUzy909uLgIubWZKuWBxQ==
X-Received: by 2002:a05:6214:124f:b0:6d8:8d16:7cec with SMTP id 6a1803df08f44-6e87abcd064mr10212036d6.37.1740433307227;
        Mon, 24 Feb 2025 13:41:47 -0800 (PST)
Received: from [172.17.0.2] ([20.42.50.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b06dc41sm1776886d6.20.2025.02.24.13.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:41:46 -0800 (PST)
Message-ID: <67bce79a.d40a0220.29f1ad.1384@mx.google.com>
Date: Mon, 24 Feb 2025 13:41:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6488292108526928601=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nishiyama.pedro@gmail.com
Subject: RE: Bluetooth: btusb: Fix regression in the initialization of fake Bluetooth controllers
In-Reply-To: <20250224205439.18672-2-nishiyama.pedro@gmail.com>
References: <20250224205439.18672-2-nishiyama.pedro@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6488292108526928601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=937249

---Test result---

Test Summary:
CheckPatch                    PENDING   0.18 seconds
GitLint                       PENDING   0.16 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      24.16 seconds
CheckAllWarning               PASS      26.55 seconds
CheckSparse                   PASS      31.43 seconds
BuildKernel32                 PASS      24.05 seconds
TestRunnerSetup               PASS      425.71 seconds
TestRunner_l2cap-tester       PASS      20.97 seconds
TestRunner_iso-tester         PASS      31.95 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        PASS      120.52 seconds
TestRunner_rfcomm-tester      PASS      8.31 seconds
TestRunner_sco-tester         PASS      9.59 seconds
TestRunner_ioctl-tester       PASS      8.42 seconds
TestRunner_mesh-tester        PASS      6.15 seconds
TestRunner_smp-tester         PASS      7.27 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PENDING   0.40 seconds

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


--===============6488292108526928601==--
