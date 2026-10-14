Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E2C3CAA53
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982397; cv=none; b=G9462ntGC/g3ODLzQ4Fq+KBS/TnMogBXmLXwrEKYn6vnm7QZwlNKMYx6k8GY7DlHgpt5QlGgCCNF7ZlTJW9lMsazYMOJjy1YaTsb5jQDAjsJwu2VaVaPIpa4GJx6z5XuxhPCMwOVuq1aXW4CgWsat12YebiAWDagB0eIrR9dbk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982397; c=relaxed/simple;
	bh=CwfrTLf5j38/1uxZ1W2iieF5FlKUXdDhTms5bdUDCu0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C/aUiGLoQ8zt9bF/ACGbN6rwErPrI18xpntjab7HeZh4QWv5/aP2LQgiE3sWlfZvPNui6heHeUxZ0DW6Zo+CBvSTIo+gP2pfNy/BQMOHpS2T3WfA7PQQwZHhvo9kc+y3ziAkLWWujaaynd108OeDshm6OfjSTjTfzuznWVs3Jqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OflBWAvh; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OflBWAvh"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15ea896ddc8so1308571c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791982368; x=1792587168; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kLutK47HtQldoisgxu8S3x805pQ/hzfyXrd5UodJPi0=;
        b=OflBWAvh8A9mOtkLJUJ5s70emRzyaMXvuXiith8gN2//IlKaGYVzyPcgZmyK2KLFWj
         daG8z7aJHCy1CSxu9ZYhHqRRel4uMVbdWu4A5NlVineC1Y6cf4ricVJ00CdgqE/whHSU
         vH+VOhLh+8dqcgwa9fIdUJs9J5d06SVHxK1NufDmzSsQA0eyn+14PZr77gMY2rDgDZIm
         CmwL4TnGr0GGbeFUtGJShOY1nSF6LeV79QEnzfBZ19POn3MX5eGLgj1PgE84EirPvK7X
         BOETBhxOtGNKq1owUfHO12opY6lXMbliW0Mh4hjGxLKBlxOlPMKLaX/lH6i8f9TQ2Xvp
         ZrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982368; x=1792587168;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kLutK47HtQldoisgxu8S3x805pQ/hzfyXrd5UodJPi0=;
        b=qkJe3Pi85yxAQIwEqQNsJ4Im0xumGS37dEiVYTWRupI3bWBXYwjpNkwoK9C5qJe1e7
         d02IWTE7Grpp7IjuAZdLCQ3Kd2PjO+74wXtH8qDN3GgGuE7dR1o6OxAXz/8g1vlkR/w1
         arraVTg7Xax0hHXHFAiRJokRwwCcbNkfa34pdTamt8Pghfp0yE6vbnyWx5Dv5IZpQjOF
         e+eMNlMuTLpwcEygOOLBVCvFj5/Y89Xqg6GeR0XOsACBsNg1BnaBLYMDt0MgPwGs4mMf
         v7OnKY0pr0Hw0P9xuxX0+b3GxKzVN4t6357YuVS+CsMfq7qPGUUcCpVeIVn7i8cyFJvT
         pRSg==
X-Gm-Message-State: AFq9FYI5eSw9Ngi7KDDbSoFoiHJP7SRc5Yy7HSctK7CV0DqJ1Mc28lLH
	onbQE6zC6XNlKBWUEkdtNdbZsuoupPKuTWoxh5a0D1r4plAm3bvLIL4QPM/+IA==
X-Gm-Gg: AYBFou0ZNyPq7GGnYdnNxZLlttEoxgFWfq7oJYs7hb23DFl+LxSImreRUQE1wxopbEC
	6HhAXfbznCi2WLzxZjUWnPLGFGxuZP40CwLvcmBy1xzHHGpbU/p5rYH9HY+HSqhHMBWRy1K6vlj
	Eta32f9Y0DzIoS2BeAOnx1h2Zf7iUCLd2hHVnHR+JLsUInhJ2ydZIfw27McacNJl35JX1d3cwa4
	koDjpWib5Djx3cG0Vr/Hr7zFh0q5XOn2RA/L7H3dwtr/LbKvHsuz92hFz/zI2m2qUbeEnxAlJ/n
	Yvk9JrGkX81SsKQzVveYDIwyUQ34wLG5U+o7CjcJhNCV/jvLa0htpHf7IT+U+Dv2wDp7hhN93sv
	MaUPPWFVrxoj0B/1kYVPf8GIGav2obg5RCp1gpbQoKZV0QwM0RlCPNgOXaJ0F6jZs2ckVNdFhbx
	n0Mv3cPiIGo864mgZq8eB3JzLYmbwaAm40/13bT9DMY6pbsHBDpCLIoZy9j9iDI8mDoQXjRetgU
	y3rHw==
X-Received: by 2002:a05:7022:150e:b0:15e:6541:3099 with SMTP id a92af1059eb24-16a5e49fe20mr23391009c88.7.1791982367642;
        Wed, 14 Oct 2026 05:52:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.101.200])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1dd57d0sm47590965c88.8.2026.10.14.05.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:52:47 -0700 (PDT)
Message-ID: <6acf7b1f.45417901.a236f.466d@mx.google.com>
Date: Wed, 14 Oct 2026 05:52:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1535084156885423270=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: Bluetooth: add hardware rfkill handling
In-Reply-To: <20261014082650.1270679-2-aluvala.sai.teja@intel.com>
References: <20261014082650.1270679-2-aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1535084156885423270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1185391/

---Test result---

Test Summary:
CheckPatch                    PASS      1.56 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.46 seconds
SubjectPrefix                 PASS      0.27 seconds
BuildKernel                   PASS      22.51 seconds
CheckAllWarning               PASS      25.95 seconds
CheckSparse                   PASS      27.42 seconds
BuildKernel32                 PASS      23.15 seconds
CheckKernelLLVM               PASS      24.83 seconds
TestRunnerSetup               PASS      512.02 seconds
TestRunner_l2cap-tester       PASS      13.40 seconds
TestRunner_iso-tester         PASS      9.38 seconds
TestRunner_bnep-tester        PASS      2.78 seconds
TestRunner_mgmt-tester        PASS      82.92 seconds
TestRunner_rfcomm-tester      PASS      4.05 seconds
TestRunner_sco-tester         PASS      5.05 seconds
TestRunner_ioctl-tester       PASS      10.17 seconds
TestRunner_mesh-tester        PASS      5.09 seconds
TestRunner_smp-tester         PASS      3.97 seconds
TestRunner_userchan-tester    PASS      2.82 seconds
TestRunner_6lowpan-tester     PASS      4.01 seconds
IncrementalBuild              PASS      23.08 seconds



https://github.com/bluez/bluetooth-next/pull/931

---
Regards,
Linux Bluetooth


--===============1535084156885423270==--
