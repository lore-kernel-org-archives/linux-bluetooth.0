Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49266481661
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961774; cv=none; b=kKWKQHlLSkuBv26t5fDxP74I5BoMiLs27/mBobUIHShdT8MXZTN0x48ZI6+GWSkoAjTkeSD0HAU8uMYDbHo/xuyitF25gssxI+M/wwUO6bfHsWaU7aN7EWP5F81ZNeW3XUFGOeCsKCm2C3uQIOxsajIlW2nlil03W8cc6guAV+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961774; c=relaxed/simple;
	bh=o0RtCuyLuFMzKgjXs1ccGsBvIv0YU5aHr6greEJgbn4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=b5ZrvjpF/3qNsxbVUtseRkJVquec88izPqiY6RmYWhdUFhQmUAee18nNJnhZfRgnFC1v8ShGvWv4onU1Ky/W31kffz3HGxb2On1LRhIsrcf+5Ximd2G7V126akU7NqQZGPm2b/iQYi11mgv/blD2m6G+vUqvADkm2ZIW2gSZYLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbXnNwVs; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbXnNwVs"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-9178510f3bdso50499806d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 00:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791961770; x=1792566570; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1JIk5dMgyxvKn+/CP+rzHh0gCnApYUyU4Ysrqp2mxlk=;
        b=SbXnNwVsj/qRfeG1WuBOdZSHYphVnXzacqMNnhWuLrDNiiUPsa8tuinZ/n/FzlyAJZ
         pH8dmvoIQkM/pPHk/DBiqCn78uYP3/cFHokkK2+E5H2dyxLrP6e6SyTzbgVIisS3GRXo
         Op/2YW9mnSXXvJXIABLOGsNiF0bCLa7C4n0+Q2SVJfm4SpoGM5GsZ8D3lE7rmQ7d1r0N
         rTD6rRwPxnbDPP3b4AIu+ZnPzpZGl1/LclcZCE0SN1DHZEhc2rQUkR8rJ7vN6ySHdZ9Y
         TWnPxXsRF8CbxtosJAfmlyVKMqoFAtTO6KZvzzzJ3MzIimoUHnd+KroqvNVOrWigFPbz
         Vy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791961770; x=1792566570;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1JIk5dMgyxvKn+/CP+rzHh0gCnApYUyU4Ysrqp2mxlk=;
        b=X8W3e2sd4dccprkwAZ/1jYz4qTR+OPZK0ND/x1pjyeJip7kh7hP3lQTQujTYK3EWWx
         teeVXWHXd4o8ZLHlqFomEoc29ewZ6eEGzY9+k35bP23PB1spt3ngfD/Mzk7sEDjb+OPB
         r/G3np1cEHEtpyinaNtYVnDvzP7n1sjSt8K6vVAy09zeYgjDJSXmILrhmZyYG8Hb6iUS
         U1K7879E7yFH+VDdc1A11vG8dPP/3KuwJ6y5JkLo96ViL4445eliA7E5RBBJZMJPefq/
         TQrv6iR2gOKj3lqRp1C9/L9rn5HgzAvhgd/pgmJHfAp0XCA8oOmh+mx46J2sBVj7+7uO
         Eong==
X-Gm-Message-State: AFq9FYICgUaIWo5ObUttgDm8fDX4jVrlaVBZzgC51vbhSLXEzEVCPbBU
	yU6TzvKx27X4hpzrJP0jVG9BGqu/bXSdXKEj7lbc6xnzCNEodgcXwOB9oAQ/xQ==
X-Gm-Gg: AYBFou1G48L7n3KSkeLkaizKLY8E/iQUmqxr6M4OiNzhi4NUNImsqlaivurSUNGXeNu
	pNg1hfm6dUWB0mL2rFRI+kXs/VNUC2yjdhft+KckXeTgyHIcnW+K8krUdY7Cc0FIMdVeV7HsLN9
	PwSs+bSo7C3qNtq5P8Bk1Wy9OmiRHDRVZw+gJ0iA72vacZe8l5TEhFfv284JdXE/uPvrh9TIUD3
	r4yHaK3TVjpMdbLfD9jBPjMVyPw0ocYYUzVq/kle3BOlOWU8m7js++pkTVDxhYc8fhocbSBQge8
	di2pTrPufttIUD//eCF0f/GLR1KEmUYKyB1AUJW5CpAfT7nk2I569ig5DZ/d1ep1veQTcWebBmH
	1JQljMdfsxMhitEPip77NNalcBbcYpLk5GnPxZk9U13wAiJPbvv1AbYsKU9EiV38YOylBAqVaF+
	1vodN4jWh7BAf+brhUbGLuWhyuaiE55l23gPhH/6xR/eobeY7Dwn7c0gexqu7ahdwV7hCTJeREV
	QkR65faxHCHdAwhmw==
X-Received: by 2002:a05:620a:1b8e:b0:93e:49eb:a274 with SMTP id af79cd13be357-93f00ecb8e3mr407868785a.23.1791961769878;
        Wed, 14 Oct 2026 00:09:29 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.236.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5009ca3sm427040585a.7.2026.10.14.00.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:09:29 -0700 (PDT)
Message-ID: <6acf2aa9.75e3b9bf.39ec54.d88b@mx.google.com>
Date: Wed, 14 Oct 2026 00:09:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6837994479476453501=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: Bluetooth: add hardware rfkill handling
In-Reply-To: <20261014061947.1238279-2-aluvala.sai.teja@intel.com>
References: <20261014061947.1238279-2-aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6837994479476453501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1185286/

---Test result---

Test Summary:
CheckPatch                    PASS      2.13 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.65 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      29.57 seconds
CheckAllWarning               PASS      33.50 seconds
CheckSparse                   PASS      36.49 seconds
BuildKernel32                 PASS      29.60 seconds
CheckKernelLLVM               PASS      33.23 seconds
TestRunnerSetup               PASS      714.03 seconds
TestRunner_l2cap-tester       PASS      12.59 seconds
TestRunner_iso-tester         PASS      16.83 seconds
TestRunner_bnep-tester        PASS      3.14 seconds
TestRunner_mgmt-tester        PASS      87.37 seconds
TestRunner_rfcomm-tester      PASS      4.46 seconds
TestRunner_sco-tester         PASS      5.61 seconds
TestRunner_ioctl-tester       PASS      7.76 seconds
TestRunner_mesh-tester        PASS      5.85 seconds
TestRunner_smp-tester         PASS      4.35 seconds
TestRunner_userchan-tester    PASS      3.18 seconds
TestRunner_6lowpan-tester     PASS      4.42 seconds
IncrementalBuild              PASS      29.63 seconds



https://github.com/bluez/bluetooth-next/pull/929

---
Regards,
Linux Bluetooth


--===============6837994479476453501==--
