Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9B51A2C27
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136568; cv=none; b=H2SojwsTN90AB7wxrHEU7ChXLPz0i3VWTzj34TRoBoD1CnNXIgyW0Tnhs9TF3B1IJTRNXdfEgVgkmKWPwrHs5mSsBXxC0Y1D0LlZBPsih1AZFXXag5+MZeH+dpeMvsCz44bfS4Ua+xAhDkEQjj7WccZWKVabqfFUD0b0Xb9xqm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136568; c=relaxed/simple;
	bh=dqtTs1wku1y0g5T33Z1T/9uC7TL1EZjG9O0+D8P4daE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cvestiWUFDA+lVPICphPJezYe1QhGmey0jOejQ32rE/dgj66sr46rd20j5spOs0d9BxCvF+vLEZi0Qek1kflgPIKoBCsT6x6jLHYKFVRt4djTWuNlJf1F09UVsISDl5E1AkOD7824ZidVDKU3xgaZP4AnF+2X1vNDoqVPWW1A2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkbH8g44; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkbH8g44"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21c2f1b610dso32045795ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 09:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737136565; x=1737741365; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5LSQwOWo+YJcqdA1Oy93gUvqEKEzcy0jnr4OKGcAeMI=;
        b=kkbH8g44ZW+pc5x+c9U2ZjYTv7U5qZvVLANl3hU3IGViJ4SHFODmY1rdWlAt1+2hBu
         9bWSecQd7oQirOEZg+pZTksl3HSl0Wdsre0toZCb2VQWyX0Xzcou7jgfcnQ2f5BTp3D0
         Os400RYBoOn8XIyyaqY61eUc3M/cF6vL5zqVluodMx9z4wIEwfpCCWpRzYWVYPNt590W
         Ce7f56/jpnXTvsF87kZRqw9Mrrkv4oDRDysCjcsSI4qh4xo7OY0VcHYyAO+ut7KWWXAI
         COaY9Ek2ibq8IIYluGPHuycv760G4e1lxCoMTWVPCwn1xnJ3cTGFmZapmM3+p3/UzDq/
         vDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737136565; x=1737741365;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LSQwOWo+YJcqdA1Oy93gUvqEKEzcy0jnr4OKGcAeMI=;
        b=uiaL+qRpUWRP3vYOyiSNe6sAZMen5IvDBF52Ed2aGfqjeXEajzfXam3neKOUi/GvND
         QWnmC0wrGjFXg6qKPc1Hmz/sDnh4ow0UzBG5Hu/0EuobMpuBmWlHHh3/sHZbL8RHCBSd
         b3t6SsPtGTtzrtUf4D/x9TixbvGbNmrZcnK1o4dFOzC/f+E+lst2qp1BXG3dwIOMARuZ
         svMAPJTRkwJhVDWF2JZHyg+93ckCCxpZ+y2RVMfw56wv6zS1w6COsuv3Jy+sC+b7tygN
         9ENXDsjaGdnEFoSYpTPnlNvVLrTIYxVARZ8Zku/N3lFbxuOFAPVk6Ly4dyVuXeikTeAp
         dXow==
X-Gm-Message-State: AOJu0Yz1QqyRnbUPKId+6hUZp5D4F2e4psEbuzOuiucVek4vj5yWiyMK
	SQqUT1yufqjY+SQ2aMAJUuv3CQSPHGG7gH6MEJfq75UvnpszZ7C/w50bxw==
X-Gm-Gg: ASbGncs3c4Zq8ujQ7UhwnYWyE0M4uTqD551d79qLXDxxHfjvMeZPIqOFo5q3dXFfehM
	geP6ujiJWYfhUv3ZhQpGrW/utEXFvsapGJv4gFXi8tW/k1W8gE8c9r9NLRu93uHnIUVG70tCM0v
	ts4tCFvB7tV+IV/+sYkGIwi4WvNWV8MxRB7KiZMxUDyr6OssI/5R95D9odTQQ6PLmqnJjXdDK0g
	2L9NGsDnrgWWctnpTaiWRYFdo4m3tzaHSclKdenpX4HtttzSHLmhbiCObjkDQ7u
X-Google-Smtp-Source: AGHT+IHJZ6gzww0FngZhM86YiK5MdukDhJUP3o2mNd8IXU9Nhn5N6I6ndVqw351av7B8NY9sevODjA==
X-Received: by 2002:a05:6a20:a10c:b0:1e1:9ba5:80d8 with SMTP id adf61e73a8af0-1eb215ec495mr5386727637.33.1737136565157;
        Fri, 17 Jan 2025 09:56:05 -0800 (PST)
Received: from [172.17.0.2] ([20.171.103.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdf57de17sm2132353a12.77.2025.01.17.09.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 09:56:04 -0800 (PST)
Message-ID: <678a99b4.630a0220.2e5307.73c6@mx.google.com>
Date: Fri, 17 Jan 2025 09:56:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4282736956561816687=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
In-Reply-To: <20250117171425.3881114-1-luiz.dentz@gmail.com>
References: <20250117171425.3881114-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4282736956561816687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=926539

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.39 seconds
CheckAllWarning               PASS      26.85 seconds
CheckSparse                   PASS      31.13 seconds
BuildKernel32                 PASS      24.13 seconds
TestRunnerSetup               PASS      430.68 seconds
TestRunner_l2cap-tester       PASS      20.26 seconds
TestRunner_iso-tester         PASS      31.90 seconds
TestRunner_bnep-tester        PASS      4.92 seconds
TestRunner_mgmt-tester        FAIL      120.08 seconds
TestRunner_rfcomm-tester      PASS      8.67 seconds
TestRunner_sco-tester         PASS      9.46 seconds
TestRunner_ioctl-tester       PASS      8.20 seconds
TestRunner_mesh-tester        PASS      6.07 seconds
TestRunner_smp-tester         PASS      7.18 seconds
TestRunner_userchan-tester    PASS      5.11 seconds
IncrementalBuild              PENDING   0.95 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.178 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4282736956561816687==--
