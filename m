Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695893D413F
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608820; cv=none; b=nAEA/4chjolinVnLmmrTzZ4FYcm+zDibPB/IUhaoIAmIXtVNslcvWLepv0NOOIU4xj5BocNP/uygLAeVkUsRwpSSJTSjVWYHT5d4el/VyAdu20UqflMMR16sk4Qi6BNY32IkE6N2sxCc4U4AnueT3W4ZadytDelH+MBa2UElswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608820; c=relaxed/simple;
	bh=aPhNLLtMJB9kx9w+y6sYP6w04WGqjxKWKKs1JoEsts0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BW8tUs/ZnF6hxSzg1w+b/HwKw+MoVzkaBcCEEJII5uilfd1x+u2zCdi7R90wKoZvzAvO+2kMMC9zzZEYEAono/ZaOcTzxyly8IYQ6v5c5nrQd+ZXcYQv9DMdUGJBtPYM3J/mTxccSiGRy3SXhqT3Rwf4pvkLejxe+mMRSwwo21k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6l31wKg; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6l31wKg"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-149d5ec8e96so213332c88.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790608818; x=1791213618; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7BgVrerLAT4Cx1/yAkcxQknt8oLIHsOiVTNqYLgzZc4=;
        b=X6l31wKgS3Cvgspjc52jlhEpfmW1FwJ2zJ6GvQQuMqwJVE+9UBbeDu7QgLDg0K9Oy9
         y7FKHpMH+mv1EBeuDJG69C+0ng3oplHOIRbd8Uyd1D7IJqd7hf4mw2FsrWcNn9Uu3yBu
         /v39Qod4LlrZ9rTzizooavjQkhNp55JYPgLtwhbRXJcAx3nQIZ4GeSIBQ4tnH06UM2ND
         InQL4Nx5T51+DCKE66AQjEjAsq86wBTtpxwj8+3NskLHepsPOrDJ4i13u6p8PvaoQiFm
         awkl3DLKF+VHw5xo4OMFSnC3KsF1pAFD4j2r8mANOxK4AFxVtMXSfu4s5yqdDcDpnLUD
         jL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790608818; x=1791213618;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7BgVrerLAT4Cx1/yAkcxQknt8oLIHsOiVTNqYLgzZc4=;
        b=tz/K3uOqNzYRdzKXmlThbwnYb7CyFFje6KsQ/kZW2wwzVlN7Wenu04sgSBZDFBUFtZ
         kFvf4UemRKoNHPn++pAGDDsXhaJHUoFP0JjTsB1iFQ8E9pt53t4ra/SEM59+2Sk0rTRE
         VCi/5uCOV3an5Oxm2PoxPRE1090eI5JTaBYYxYaN6Ws4UdB68aO5OBv8A4CS3NquKBRX
         MKrL5XRF+u4fLWK7GsirmnbbivPbYuAmVqTIHl7Md3qDjfUt8Qjr6Zyh+F3LuUKJPaxT
         2htg7gvzDxerFCk5AWYsu6gkqhA0T6ZezlRWU0bpB19V3actuxX2VCvOfD+Asz9M4y1U
         ngvA==
X-Gm-Message-State: AFuF++l0zKf6BSZV+EKHx0VnazmPfn5Xh0dW3ZJQFcroWjjNUGrWD7O+
	lcPGFmapCPGs60NC0Dd2izi81ztpDemn7VzDwlBdy/cZvcM8q5ZBoaJpUmINKmnn
X-Gm-Gg: AYBFou0izuAGVOG+XrIYGPuOx8zk1soWllQVjyxS2WXfcfVq/9HCtp9En7luvruznpi
	FUHk/bBAwjHWU5h1TOiSEnJecUV9cuUvfoAa1gbRHkJBu3yud2GgUIZNsq3cJuSJOqnT4Ub1zvT
	HhwD0ZgRPFNYC7wwZSCJJ7yftzOBjxisjclpJfhwLW3JYNrpLUi1dSBRPho1IZBEloyX6bLpJaw
	xBd/FnxOTMDhVwthLzQTAzonchuP78wC4kYihsFz2dkUj3KxdUA7tmHVO8LTU5I1WtnXAYSJJWT
	hrTWNnnyiY1+uUOGANGoqp5cFkJo4r74Hnx8DDu+ju23tGsNikk8Rkiy4rOWDsiz1wR7UeFiYRg
	DqRj1cJlZCVq0ZHWje8NwqjShqim30JjNXoKP7yO9mj1B5XVPQ2DC47OTtr0m9fSlTCHBwvHshb
	CxZ1X9AGWIPv/e/WIrNIJNlCFMjZVGofP5i0fM3dF7zW67Orf5b0bylIUnBXqRFvC/6vPI1bLhA
	k1Y
X-Received: by 2002:a05:701b:4189:20b0:143:7821:e151 with SMTP id a92af1059eb24-146d0c4ff1emr10649884c88.47.1790608817911;
        Mon, 28 Sep 2026 08:20:17 -0700 (PDT)
Received: from [172.17.0.2] ([4.242.195.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ac67c0ccsm25794880c88.4.2026.09.28.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:20:17 -0700 (PDT)
Message-ID: <6aba85b1.acba1091.2f156f.de8a@mx.google.com>
Date: Mon, 28 Sep 2026 08:20:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5784131905302067148=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qstrydom0@gmail.com
Subject: RE: Bluetooth: btusb: add ASUS 0b05:1868 to QCA Rome quirks
In-Reply-To: <20260928143655.22223-1-qstrydom0@gmail.com>
References: <20260928143655.22223-1-qstrydom0@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5784131905302067148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1175334/

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      23.68 seconds
CheckAllWarning               PASS      25.65 seconds
CheckSparse                   PASS      29.00 seconds
BuildKernel32                 PASS      22.48 seconds
CheckKernelLLVM               PASS      24.01 seconds
TestRunnerSetup               PASS      580.48 seconds
IncrementalBuild              PASS      25.51 seconds



https://github.com/bluez/bluetooth-next/pull/833

---
Regards,
Linux Bluetooth


--===============5784131905302067148==--
