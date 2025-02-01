Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4E71BEF8A
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Feb 2025 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738432397; cv=none; b=LupRzYpWWp8VsCgekQjbbsb1DXF4feAHecOw7ELfa1bt/W6z0mZuW8rqqFMYfSy337Znu2DxY9fKqBPna6ARX3ZomMN6MyXzpNNVdGaViUvPNZ23jtyYsptQMruwVANW207KKEm0cVJ4UW5kf1PNgjAVL2fuBIsnShIlgoN4SaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738432397; c=relaxed/simple;
	bh=8fPunExvvP1eITjB2J8ZW7OWdzWUgNxOqnDdM1xmYwc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H5/phCo5QhDBnINgkK7JavuD5bnFbOGC4tGQdGHSMZJK48Kmo5z8+anufhoJZWUwGFXMVqjumPXCDreD42VUBmEnV9iVLWpgHcVpcfXaCc/9ezJSke0DATLYwDQUzcdS2hTwNjzqguD57jNcWRsn36g8DCCrhaKTnpwkvNdNowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQFWTOdO; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQFWTOdO"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46783d44db0so28757571cf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Feb 2025 09:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738432395; x=1739037195; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JI/Q5kLx7ratzwVCkQk3RGhCmFOCoV3hTPXYIH0j5/c=;
        b=LQFWTOdO3gJDUFbVmFOjNoyg3WZaJVD5VmpNdgoh7C5McYP58d3xa06Xs1/P5SSEkO
         5GFH44HPlj5Lj3Gu8kyH8hL1SWcLm0gbSFrym/ejfvfnLj1Vq0R/jiGr86+taFjLjntZ
         b/ES2eVObUGVp0tTx+x+ymYg46f7c+gaNl6JNwuaRYI35359tsQlImeJ0XCbwDgrfjLP
         YOGGAzhzRH0jJalMB0ZMAIpuhfw4//ypYHb9mqTDkS+tscCCQ7gLbafbSKLfQR1alObF
         0cG/pPyPD4lTFjrz1gUVj/mBZLvXPUjnq4QTCAI5dNzK8rbe9uWHEp/WKwnW+E5NXLYm
         QlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738432395; x=1739037195;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JI/Q5kLx7ratzwVCkQk3RGhCmFOCoV3hTPXYIH0j5/c=;
        b=Ts9FqbmwMg/+SfrpqAJY6hMz1eUoqgdswk7F/4qiYyBmGVRZPQZoVwVF5xxn3ARYhL
         AfYTKWdM+zmDv85uxkpcPSKHkz1xV+wtNF50uyXKNlERjCkMgpZqYCyD95oRnqiOyX+6
         9htfLyESRqDyMXFpx4i6jHKLLwf4RjTDSNmkpAsTy2dDJzAFVPvNjpFG/HCjjGBD65V8
         zthWemCjWDw6xlMzUZoBkIMDKD8/QDJNS5QBhTCYeA9AxxzVktVcIIOmUVjIisY6AkEU
         hFlgC9e/uZKNlpSJi0SXgVbQb7wX/bkU6Hs7VxVcRM3o1a3DcFRzBn9jYIx+Jc5+ro1Y
         i6uA==
X-Gm-Message-State: AOJu0Yx2zfQ3orQFAAMAYQz1/mxHkxE+4F/JstWJpr2IKdlHngL/bZHX
	OWcRm/HNXCtap94hdLlgkiuhTOVEnU0tb0hywIW6X0o445rZZwsKlgjfr0GH
X-Gm-Gg: ASbGncshj8XI1hpNIpaeGbMz6+ueGRDV6KhExjYCb2j3Wwu1SSxg6q7ZFOFfoH3lQmm
	Yb1MHkemnalMLkRqxLrxwGcCuwFde4yo9Qjjs/25YIAAVROcZO9D09mFjYCE5X6Lrmts8wNS9jO
	vZkgax4Y20FLiFE+RsX5o518NUK1YYZnSAcJDl4y6QEVmaomBRF5xS+LBP56q7RB6ni35ZTAmgF
	nMq9OWyRF0aftaxVe2v028FmE+Amcqy7FdtKKFnhf78tnzrEOhMlJixHroAa7ATnXLwnVxvhV/y
	q8jgpghk52h+UfGNdnPjtQ==
X-Google-Smtp-Source: AGHT+IHMcQX10ne5SG69PY3KAV6xFJ2SBvt95byIkx4NYr6F6SMkGOHE3oxTtkAFX/qhtwydjtGzWA==
X-Received: by 2002:a05:622a:1454:b0:466:99a9:c354 with SMTP id d75a77b69052e-46fd0ac9e21mr206931421cf.22.1738432394989;
        Sat, 01 Feb 2025 09:53:14 -0800 (PST)
Received: from [172.17.0.2] ([74.249.22.149])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fe2fe0a21sm27357361cf.32.2025.02.01.09.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 09:53:14 -0800 (PST)
Message-ID: <679e5f8a.c80a0220.1eabf8.acae@mx.google.com>
Date: Sat, 01 Feb 2025 09:53:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8540988038440659148=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: RE: Bluetooth: qca: add Qualcomm WCN3950 BT/WiFi chip support
In-Reply-To: <20250201-rb1-bt-v2-1-fd44011749bb@linaro.org>
References: <20250201-rb1-bt-v2-1-fd44011749bb@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8540988038440659148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=929737

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 FAIL      0.92 seconds
BuildKernel                   PASS      23.94 seconds
CheckAllWarning               PASS      26.56 seconds
CheckSparse                   PASS      30.15 seconds
BuildKernel32                 PASS      23.84 seconds
TestRunnerSetup               PASS      426.11 seconds
TestRunner_l2cap-tester       PASS      22.21 seconds
TestRunner_iso-tester         PASS      27.60 seconds
TestRunner_bnep-tester        PASS      4.82 seconds
TestRunner_mgmt-tester        FAIL      119.89 seconds
TestRunner_rfcomm-tester      PASS      7.60 seconds
TestRunner_sco-tester         PASS      9.37 seconds
TestRunner_ioctl-tester       PASS      8.01 seconds
TestRunner_mesh-tester        PASS      6.01 seconds
TestRunner_smp-tester         PASS      6.94 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PENDING   0.73 seconds

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
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.179 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.138 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8540988038440659148==--
