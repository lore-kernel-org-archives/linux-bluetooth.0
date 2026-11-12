Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459665;
	b=PNEc2wMhNQlCnEEKMO1VydOi+pcpKpiJlLkukZiKUuKX8vJq0yIOjFx5KgC+GGy9bB8a
	 gLv+PwT+4wgRbPN8LOGlj2y2zOy6Nm1zq2RuW3LXROrm3xZhr8lzIOboHyrwieJ4gX8Qu
	 iBvyJhZNjft+bE1HfnHwpLR5vPgp9IF02NS/t/1OLGsTk8KP+y0Ffyoa5yL1CrwzjCL3e
	 Qg29U/iYHhm3PDhGQED2vejhmx6Ju2Cdi1UiipyreaXIRx3PE0q6a6B8NG920UoMvSRYc
	 8/KGDU9cQuhEVq+TScka4yhqxymHVlvd/BqxQc+b4osN3bEpwVEPDmftyTkLl1NqCMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=zQkVBzq71YdirMlCEUXBHGkFJzGny3TChqF5Mqdysyg=;
	b=sPkXt2NPB4DEbwzLCj6I9nI9/3miA6gTC+Fx3esxjL6PxOJxnPMnUaqPC7tyihOCrNzT
	 ALEnTs45h0iwYF4yGAwb2QGVNp46RT9As/9zeEhYB6Y88Kr+DFjRlp2rJqdIfDArSrE+f
	 RFR58tkIInYATK9jbOHjNLXfytjM5ViI2e+7+bE+YAjEloMB8h8cdhXri1c/ZcrqPGLM1
	 mfAJXSU/g0WDnePJdk2aes2REndznX+4slXt36Xbh0wEASLmdGPqs2SGEICJkKjyrujbr
	 fa1H5BlfsqPI3afQDcs9HxVCDaUvOKz7PUos8D6y2fBmrsjksnaIUnDSZ0bzEG3v7yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D9M+zLCR;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D74606A327
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 05:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2D74606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D9M+zLCR
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-37071c0f42aso6607988eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 21:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459664; x=1795064464; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zQkVBzq71YdirMlCEUXBHGkFJzGny3TChqF5Mqdysyg=;
        b=D9M+zLCRj+gN8ev1p54VLim5kNHxATCWjvivhO9rsFAB149P9TUyhMwmJk5KGNB5Ox
         3kifjeUOhjCdjT70PFXuyO9P3l4bbMdaChyihj7PpUjhUsWHlPQ97v0H4X1iXGcPTLa/
         MWO3trGyVcEEJjT0zP/70gRFA3KuI8ER7PHm9lCEw9c3eUtA+KM6/WxAhrRtQkkOcW42
         UuWZUdM3u617Kz1hYe8+nnycBy26+J6FtY8OUZVZP+rzY5mPA2o6u4U/N+7SJV3LBfsY
         W/FucisDl7HbB1r8b2hOoJ9IOW8cqqyXse8T1BVJ/ZQ+JafpZjys2gUEHipMAK59f82g
         9XCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459664; x=1795064464;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zQkVBzq71YdirMlCEUXBHGkFJzGny3TChqF5Mqdysyg=;
        b=eQU58vtmM/vuAqVFOc8Pl20JU5OH2NokRpSrWNdrYQg1TPaLGmGlQFVF++7gIObIg5
         XEbUNEqGVR+1fd9cI8tXQs/x4qad6NBjyc8e3wOk7N+18sIr4kZTVZsMqzJp9+elI9c2
         ACjb89feARt/8vSSwbH/JaZSvgXKQxB1gdatYku2q3nYRF8BGsmyZEx+wgCUZYAoV3PH
         FRutzzF8q02eAArZy67p87URyvHObyM5zevW2bmMzl18U+bjTx6up1OwaH0ryaaSt5CB
         sNY1LTf+IOtHZ4ZzPB3eXXOtAje4ypPbKiBo73OtuwBcIrSSQzOfkZTy653r5A20o2aS
         768Q==
X-Gm-Message-State: APuU4Z9h/p2lsl87ERKcE0duBXuL/9232yJ9aV7WachvITU5tVYOpOAK
	pi4aKd/IgYMV6QrC0Nor184gaBcPEOSq6eZ0qC7nSLN0RZ04aejmlMOuWwSOrw==
X-Gm-Gg: AYBFou20YCnH5LQZzcx5D6EcxCI1T8l7RpLFkBEXBGjBBU2Yk0ncHL381vs/24kfNmu
	+l83nTl/Dkl+3aOg8SCa9+eiOLJrnUTyYCl8c+7Vf//Toc4cHFK0BKW2K3GUKOdgHmWoODzEQiZ
	yoTryAlGSVkN1iE9+H4OX8C3P9/pZovkW5dwNzewJQEfwn2l7Mgg3Ym15cNiNLStagoYaYEZng6
	IwytNYmDrF1mrSTRg9Xh9tVNW/Sl57FvjS2aZn7s3Ujlgo/evBcTkLCFY2lvVoj3WPckQZ9dF8g
	Khb4Ws/iTFXn7WC3nojx/WDoZ41M+yLmhGUnV281aB371AOECO8OMgwN57zkalswzPGjXa2c0N8
	spjwBpeyhwqnRrDeygnE5tB8cRbA7JVOt1itbObFXsyHD0MUjBkJhWZykF5SxvsjLcUxrH8TgsN
	MxC4XHgDy0URGKzyvJvMF4MdSQ4nGx0p2rd6Ne/gKc4cUOtgL1Nvn/BGZ3VJLx6dcXcDqou7q4V
	JtUVCYYVCGlMJi6f2mBLA1H0Bh7jvfx9aqyzS1EJDiKE6u4Ch1NiA+7AWIqZw==
X-Received: by 2002:a05:693c:62d0:b0:36a:1e0a:accb with SMTP id 5a478bee46e88-37686950cf4mr5043926eec.35.1794459663205;
        Wed, 11 Nov 2026 21:01:03 -0800 (PST)
Received: from [172.17.0.2] ([20.169.94.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bf3e18sm44956385eec.16.2026.11.11.21.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:01:02 -0800 (PST)
Message-ID: <6af5480e.be2e0958.3760b7.e237@mx.google.com>
Date: Wed, 11 Nov 2026 21:01:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0511471706848382276=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, weihong.guan@gmail.com
Subject: RE: Bluetooth: hci_sync: Drop the command's sk reference
In-Reply-To: <20261112033428.898540-1-weihong.guan@gmail.com>
References: <20261112033428.898540-1-weihong.guan@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0511471706848382276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1209014/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.58 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      23.38 seconds
CheckAllWarning               PASS      27.32 seconds
CheckSparse                   PASS      29.02 seconds
BuildKernel32                 PASS      24.00 seconds
CheckKernelLLVM               PASS      24.60 seconds
TestRunnerSetup               PASS      551.26 seconds
TestRunner_l2cap-tester       PASS      13.21 seconds
TestRunner_iso-tester         PASS      9.45 seconds
TestRunner_bnep-tester        PASS      2.93 seconds
TestRunner_mgmt-tester        PASS      83.91 seconds
TestRunner_rfcomm-tester      PASS      4.09 seconds
TestRunner_sco-tester         PASS      5.11 seconds
TestRunner_ioctl-tester       PASS      4.38 seconds
TestRunner_mesh-tester        PASS      5.15 seconds
TestRunner_smp-tester         PASS      4.04 seconds
TestRunner_userchan-tester    PASS      2.91 seconds
TestRunner_6lowpan-tester     PASS      4.07 seconds
IncrementalBuild              PASS      22.60 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_sync: Drop the command's sk reference
WARNING: Non-standard signature: Assisted-by:
#132: 
Assisted-by: Claude:claude-opus-5.5

ERROR: Unrecognized email address: 'Claude:claude-opus-5.5'
#132: 
Assisted-by: Claude:claude-opus-5.5

total: 1 errors, 1 warnings, 0 checks, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14974701.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/1119

---
Regards,
Linux Bluetooth


--===============0511471706848382276==--
