Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880753CE489
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447071; cv=none; b=VwKmhsvDkXOrc6TFKcvFEOyAhphi2aVFCAXb7GkEZBeTeBz+Jr/9QV0EuLcEpDODAGULZ37M+nSYp4unE7dbSX3IAGG0sq8EuGneSzv/aa1Bf+2roSKA3oRSP62ilqBxlbPVif/cPW8i20N0dLVZURMO/0Q097DhsduZqZKyqcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447071; c=relaxed/simple;
	bh=nQL59XyLsZJM3xxbDsAfp8e1uMy5FLzNhFX5rL8eLEM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RhDQtZ0YS/QbFX0Gh/OWxFqrQh5Nan4Hy3B8OaRG2/NjtcRjnp8sn+8nrUF4omRwkYqUb8sr81jcNW2FmXeuIJi0+Cx0bNIvG7zGTE6XM2lOl9q1uRIlZAe9BjEE5eJhpCw6SuAe83RF5hsYvpLb2L5vLvecWuCFGCijW0JObL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcCE8X9/; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcCE8X9/"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1419d3416ceso9162902c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 01:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791447068; x=1792051868; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0hrf0pr0rajNX/CbbxrUOwuy2FTXimvGga8D726ZvB8=;
        b=bcCE8X9/qCFQmOJcsfjRHn93DbTlw+POh6TK5TDXlXxRoOwMyerS+rHCv/6DqhDmAk
         bmzbZcejv8KeazwGapFIQOOciRizJThm3m8d/2VH8F5ZGmjfrnUgCz5LLX+/8JOebPoH
         xCSrN1QVWbIMzEcmy0gtdV2y3/ZAzd6Z2ZQA7RiPKfHQZtPjXSaNhJoa2Bk/8zYhNiBt
         A0aevTVlyNH6absSgXlczJSrPsXrVWnveFewSsYr+axN+evVOVpQMvaWBltWYiVg0Sgv
         ObZ6Fp9xq59sntTLfOt/exZCCFQjYGK55TUIlGjOjO502ZDj20+8u25R7FZGJxUdzYxo
         Avyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791447068; x=1792051868;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0hrf0pr0rajNX/CbbxrUOwuy2FTXimvGga8D726ZvB8=;
        b=WzQo4S+P1hMjyKGam2z+2j5EBPTaSzsBwRgpBUfekke8rggw8rGb1NnRUzC8qn6+cQ
         OcGQNFG6wAmx+xsLmsrrVo5RoRafiP+Cu5ouiLYtNdpXdq2M8N9yzr1k7DAXZUtsfTlA
         FbZL+YwgKBYTVWOdL6MtQ0LAFIG739JfRj6R2elxbBXMW1Q+vrS3l4XRUhebcdjrMdj+
         IYlvtPFhIC86rxoBeYbgkpuie2blEpAvG3k530dIJquTB6PNbswFSa6aexIuqiaJo+Dc
         SONEW57HGvF0GxDTEA3wb2xpmDRSkw6NlM9cGuzS8EkWX+5m4PxsSsL4FNzHEuJ61Oci
         nnKA==
X-Gm-Message-State: AFuF++nFZkpcFEQNW7OVdD+yPHRoak81MHuy89UU0KP2VHmuSfBOijwk
	+Rk8CESEiKMUxYT6GyuD/akf+NRGsfcVoJBq+mOUw2iG7Xz7RSczrt6LXcM0aQ==
X-Gm-Gg: AYBFou0tGbfRhXDo/9YJh1lBBcfc3i+vN2RrQldM+lMprfYO/YNCni5N6qxArPs1mES
	wqNRj0oLhiQGIHiiHR9V3QURPGxGLbYAiEznhfv5Z5dWGOXtPEZqq80LC5dfn9blaCQ9JmPu2FA
	LjxjNHt1hT+YnkPwn5z+Re/gqa8sXpM17QUNCp2ehbqn2tNdXdiKd9XDfSq9xjkrN/yUO1Z+h5W
	UVx8eHDIffp/ujNwGZJ5xR/u3ubCvjLU2Ez47fsWotxWjzstdJHYJHid2JQKRCxtRrQyKqYrXpc
	V2qnuAXIxOEm0wukhAOHOw8106UzQbH3x+ffBYRA0X3rp9kIK2Yk4DR59Zgmyuh1eDxm6uzh2vv
	Bau9o9H1hev/UNe9qxF+A2Wy/Z3VSGjXQmtc/i0zPW7x1qvNBhZwUf/N+waxVi3A/adKsVLzQki
	uJ/UpOClo5Peq88Y3Atukmn9ymT033Dp0e9zyQfBdiheCcMO6alEtR49XkomkiJZ9in5Gl6u86G
	T1G7oo=
X-Received: by 2002:a05:701b:270f:b0:165:8e0c:1886 with SMTP id a92af1059eb24-1658e0c1f22mr2638594c88.25.1791447068209;
        Thu, 08 Oct 2026 01:11:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.128.192])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16352800ed6sm8943210c88.9.2026.10.08.01.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 01:11:07 -0700 (PDT)
Message-ID: <6ac7501b.8a95a640.1f5af6.38e7@mx.google.com>
Date: Thu, 08 Oct 2026 01:11:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1761537728496930018=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dungvn2345@gmail.com
Subject: RE: Bluetooth: hci_debugfs: Pin module for debugfs file operations
In-Reply-To: <20261008050140.483853-1-dungvn2345@gmail.com>
References: <20261008050140.483853-1-dungvn2345@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1761537728496930018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181257/

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.09 seconds
CheckAllWarning               PASS      34.73 seconds
CheckSparse                   PASS      37.55 seconds
BuildKernel32                 PASS      30.33 seconds
CheckKernelLLVM               PASS      37.00 seconds
TestRunnerSetup               PASS      794.44 seconds
TestRunner_l2cap-tester       PASS      12.81 seconds
TestRunner_iso-tester         PASS      14.65 seconds
TestRunner_bnep-tester        PASS      3.56 seconds
TestRunner_mgmt-tester        PASS      61.55 seconds
TestRunner_rfcomm-tester      PASS      5.21 seconds
TestRunner_sco-tester         PASS      5.62 seconds
TestRunner_ioctl-tester       PASS      4.65 seconds
TestRunner_mesh-tester        PASS      6.17 seconds
TestRunner_smp-tester         PASS      4.29 seconds
TestRunner_userchan-tester    PASS      3.15 seconds
TestRunner_6lowpan-tester     PASS      4.40 seconds
IncrementalBuild              PASS      33.22 seconds



https://github.com/bluez/bluetooth-next/pull/883

---
Regards,
Linux Bluetooth


--===============1761537728496930018==--
