Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C6A4C7B56
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420935; cv=none; b=KMe2K2Skj1FFUvTzptE3qOT/8mUBd68F3e7EDPtlCrdYr3hTQbQm5500QrJQMqCruuDsGYtONrpbNKouEjQ6BwFcpr/6tww8sfsUiF7T0aKWfFdZQMj4u3Vb/GQkdutcOy5QVMZmRHZLa+YL8RPr883bX+7xVD6Bl10lQMeSEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420935; c=relaxed/simple;
	bh=AYIOB1Zpp9zDASy+XhHBBEpgUh/0v8dAPhiuzhU9DWA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N7zHcgZPwz7mw/rzanf8anaeehtqV/6aMNZFtWNBESntIFgMjXl9h5hHk5f9+Z+yHdkHfmlsjTwA/Tgqmr2y2EnV45V7GBUoDdtF844DEyy1vxQMPJ3qvYkR019I3wBZRZyUdCgs3XYjiVjnJKgHxuODqAOdmwUgawYfjVIpgLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlSO+Zs3; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlSO+Zs3"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-534e6545939so15673851cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792420933; x=1793025733; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dVVxbt+e0zv/5ed9skDqtiWcWoVFqnecfeumpKanXIs=;
        b=BlSO+Zs3L8Y21ht2/0ljQeufC6T9oczpI4NIdDcp6N5Iz/nH2W5idXiucmFErrOKzf
         Sq91g5rtTZy+nPidpioJ+z1mYiTvUyZAFay5jXcMrBnwLeHsXobrQdUZp67jHeWA4+MN
         bSNOualRdzv/THKUTm87qxVGiD1MIUYczZIi4r80+1QWPLmWDh+pyf0m1ZsKRi0Gef0o
         ZMxLkTyK7pEa45EPWVLa5C7qmas0WxynAVR7/3ofQsIU8/b+6REfl3DB2Cb5PJjO46GU
         YTWR1e2BgMCGjtkBeI9+hJTpDUI8YWpTwgopM/rc8QBPMkZAH1xHzF8s9hVV20AlYqIP
         I4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420933; x=1793025733;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dVVxbt+e0zv/5ed9skDqtiWcWoVFqnecfeumpKanXIs=;
        b=EPs0m7pL9ZkaTVgboXCbXFx3p830Owta2laDUi4RERNR5kfK56dfuglK3ZFpt+Gv9o
         9dVcvoHJF3no9DNkmVOVHXIABQpVWXBoTH25bJ/dfnH9q6sOM2z/uW8/6NFAq+ME+Jeh
         z7yDenofS/koJkbo75A8lZ6EGxW+M4op7tRHKHeTDLBwSmkWWnQPZIvvJAqtiB4Psdkq
         FFYTWdQgiNXoOvPQyXGX4w/l4X+t9E2B4hmJk+z/9uNagC0gMB5uKHj2V0KICXBomEw1
         DDBUwFztcuuVvXTPeo8beEAdXU68BFg6yKgM/wuymNhwj45gjbig+Su5CT8ptef0k295
         3uRQ==
X-Gm-Message-State: AFq9FYJXftKZSRSR/1hOg9vpsr4ysCiEsrkvqhci81+w/XYcm7Ypg2ol
	rIe1wPYT5PWGD9I6k145i4va9MWqNy5BkcJqwb80vWeACUjx4uz1Kstg6trCXoXN
X-Gm-Gg: AYBFou0TKBn4GrqfiUo2ISufGmn3XlgYvCEXt+w5F2XGmOtFP6R7nPu+BAtGTBZ2qg9
	bul8q3Xlfr11CTX9PsGTwXhs+/z2IM/AB7+aIH740Z5veoSl0hqM4OUEiBfWF2zh/OjB9cBBcDW
	5OjIJMoReJImsXS7LHSwW6b8Xycs4gKKWfZ0Xz/Km9Vjzc0nR86FA+zgN+bV9JTAn12PgyYEFw/
	QhtUzazTYV6efksNCZiIkfS8A4ZOXPTDgd/Di0I+He8E6gish7JEpWAsse5mXrLiARgzjP/4qE6
	EZwtJaUmREMFmXXNbvktaN3VL+7RMqamOkjZmw94poGm6yUqiv3We9k4J46yhDW9Rddkf/4gzIG
	WREnvG5LuKfjnTNGgaz4RwofVllQBPJVNrSynZAAy/6EhJr9h8I7I86HnOkrEgB7unRfuA36sgx
	KfP2DPujqHOepfiGwcPJFzruZ7NNQQsEykWgTjUnLQVojexks3jjg3KMNA2B1w0/kd+5u2/66sa
	LVF
X-Received: by 2002:a05:622a:5cd:b0:532:9b14:96c5 with SMTP id d75a77b69052e-536460dbfafmr120892401cf.60.1792420932693;
        Mon, 19 Oct 2026 07:42:12 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.87.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa19fefsm99188741cf.23.2026.10.19.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:42:12 -0700 (PDT)
Message-ID: <6ad62c44.49dcfff9.2dc232.2154@mx.google.com>
Date: Mon, 19 Oct 2026 07:42:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8538012550154200980=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 18983559317@163.com
Subject: RE: [v1] Bluetooth: hci_core: Initialize LTK before publication
In-Reply-To: <20261019105624.489859-1-18983559317@163.com>
References: <20261019105624.489859-1-18983559317@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8538012550154200980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1188810/

---Test result---

Test Summary:
CheckPatch                    PASS      0.85 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.77 seconds
CheckAllWarning               PASS      34.06 seconds
CheckSparse                   PASS      36.67 seconds
BuildKernel32                 PASS      30.36 seconds
CheckKernelLLVM               PASS      33.16 seconds
TestRunnerSetup               PASS      720.35 seconds
TestRunner_l2cap-tester       PASS      12.80 seconds
TestRunner_iso-tester         PASS      10.91 seconds
TestRunner_bnep-tester        PASS      3.16 seconds
TestRunner_mgmt-tester        PASS      88.00 seconds
TestRunner_rfcomm-tester      PASS      4.51 seconds
TestRunner_sco-tester         PASS      5.65 seconds
TestRunner_ioctl-tester       PASS      4.72 seconds
TestRunner_mesh-tester        PASS      5.56 seconds
TestRunner_smp-tester         PASS      4.40 seconds
TestRunner_userchan-tester    PASS      3.23 seconds
TestRunner_6lowpan-tester     PASS      4.48 seconds
IncrementalBuild              PASS      28.19 seconds



https://github.com/bluez/bluetooth-next/pull/964

---
Regards,
Linux Bluetooth


--===============8538012550154200980==--
