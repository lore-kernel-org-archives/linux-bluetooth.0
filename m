Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6C37BE72
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082630; cv=none; b=DKxgaoGWSGNZlsMdKrpCcwitrcrMTjrR+8lbxf6S+/zEFcRggHwlDmfNbZ0WoCMYVRQnRWsgroUZ6027pdLX81JY6ejS0NOKqUmZoFPk8zY+/WJXWQPSkpU6pd4RHtuIPTD33iyaQ2yb5zRqqA/vz6sCecLrjPvI4PGH6OFvB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082630; c=relaxed/simple;
	bh=Dcs7CDtRZGInMzc/BAzijgNZKiChQal3x/cnQ/3yZw0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Jz7Mc0Ei7e31AobM7Oou01s7oQSNMwTIkTa1lVDnj4oDiH80Y7hVFKP3jTKPEwfe/fOvC1tTmUODj+G5hKGCxgZCL3yTJFBzM+dBsEQ+C6Nwnr3k0WtV4TwIXeZt+76+/DAiIG9T7tgiosUuv1vd3yw9UrRlj6vZ2sgBrrvgzA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG3rGLF+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG3rGLF+"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5352a876d5aso68901501cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792082609; x=1792687409; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mTO1C+WTtX0vZxODv+F9HrbM5MMxM1wCtxbxap4RUEs=;
        b=dG3rGLF+/1vZJKHh7hMwg0wjT7DSd0v0E3lsiG80GeBj7TymlH6QCRL4TXIKfQcpjQ
         B4R+zmRkNVF40P2NbJtIQEBLtG1hxdc+Q8A0JWpVgHK+Nh+mNNWKKv9yIGUcQ+PTB/b4
         718c/iziEk9+9EBXoKdeXQSD4M2xsYCzDfK9MJ0rgp7v1+yMegjKCrxF2gXhbhswpsll
         DUQoude0e562nN9+zQvP1PfIkaAvcqDMIQ338k8dxkEf3mCx3dUj/Qj053o/P6efNfQ3
         PkUnWKfXE+1EZe76lsNQhUpXdEuGlFojLQxLPtVSAwGJmiAGEFNtRby75f1X8EXTuUrp
         ke2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792082609; x=1792687409;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mTO1C+WTtX0vZxODv+F9HrbM5MMxM1wCtxbxap4RUEs=;
        b=fwJvgh/+73IKoHl1QtH7kbyktWQ3LArVZX1xIL/ne22JELuknIVRZ3D4ffQGZR7OaK
         tHcP36LSEcIN9cjTFdtgQm1SoULRvUCrT1e2HwEcs+SP4hybjAdXYGOOwjoN2ADXxKv2
         U0NOSo+xOLPzK0ltqxtvThzBoyMF9ckyrcS1jkr3NSvSrhiSxTdWtNh9z7yTfaM8mvuv
         154ggdUTfIKHfncDKVq0+281x7O7LySmKgZEMPSxOg/8SwoLMPs2ALvDjgX+5sLyv2uC
         UFyT5du4L8p8LWJGWVMXxRD2BjH5uaS+tHM6Y7ATsbG9CETTp2tx/v0lVnF0CWBUDQci
         uyFg==
X-Gm-Message-State: AFq9FYJF6gN/Di/px8PPQ5Wc93BtbHVNEMGWADkXio+8hVmmGXn0GBgX
	j06Ni9j7f+lpOWH21A2hyAQfXwtQ6lCtbpvXWa4E8FsNcPedtzjb132/yGyuqg==
X-Gm-Gg: AYBFou2HGNazdOTqh7/7f2wbDw2v/ZKwU+0qlwCqIe/gxZaH763B2+ijH6YYWO5/4sn
	bbGJVGxW9rfN/QO2YksFngP6JP7iVa/6b1v0MLmTqEPPVjFtBFdg031S48+IRHGau4R54sUgxGe
	1KwnNRv0BcdINKSJwn2kIZC06tcQEYgJ870H5iOzzr7yltp+16lSzqsKrSJYHnQDz0j1DFvhqsI
	FEIAEZGzk6v0cjdNeaWmUEyIZ/o6Bjd8arIqZR5+LSZkwYaCi7JlMFecv6YSkcFBKJtrlhQiNPo
	BXDFbepIzd7Nrf3nrW/3/kLGZw0JwrlaoxGdiJ29IfhgtVS/w952wUy7xjzX4WZziuaVQgouekj
	MnJ5N4s1UgqS8PwygygagoF7deP1UtqFdh4CntwW4V7sJLikOspy6H8XnNncBZ2gSQGc3x7+f9U
	Ab2OuKDSqKM6NgdEg3HvBMRftHzimwoaSkxJcelfBWgUnWNcoTTnWexOa+we656y+fZ6jF2Scw1
	L8JdJAG2K4ieTk5Fw==
X-Received: by 2002:a05:622a:356:b0:535:92a6:22f2 with SMTP id d75a77b69052e-5359fac57f5mr337269401cf.15.1792082608941;
        Thu, 15 Oct 2026 09:43:28 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.99.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536127bac07sm30559511cf.14.2026.10.15.09.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:43:28 -0700 (PDT)
Message-ID: <6ad102b0.2aef856b.8164b.415f@mx.google.com>
Date: Thu, 15 Oct 2026 09:43:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8023504205781874832=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix invalid Supervision_Timeout in LE Set Default Rate
In-Reply-To: <20261015153909.1870855-1-luiz.dentz@gmail.com>
References: <20261015153909.1870855-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8023504205781874832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186606/

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.60 seconds
CheckAllWarning               PASS      34.32 seconds
CheckSparse                   PASS      38.07 seconds
BuildKernel32                 PASS      30.33 seconds
CheckKernelLLVM               PASS      36.30 seconds
TestRunnerSetup               PASS      716.05 seconds
TestRunner_l2cap-tester       PASS      12.74 seconds
TestRunner_iso-tester         PASS      10.77 seconds
TestRunner_bnep-tester        PASS      3.11 seconds
TestRunner_mgmt-tester        PASS      87.72 seconds
TestRunner_rfcomm-tester      PASS      4.48 seconds
TestRunner_sco-tester         PASS      5.65 seconds
TestRunner_ioctl-tester       PASS      4.70 seconds
TestRunner_mesh-tester        PASS      5.55 seconds
TestRunner_smp-tester         PASS      4.32 seconds
TestRunner_userchan-tester    PASS      3.21 seconds
TestRunner_6lowpan-tester     PASS      4.41 seconds
IncrementalBuild              PASS      28.88 seconds



https://github.com/bluez/bluetooth-next/pull/949

---
Regards,
Linux Bluetooth


--===============8023504205781874832==--
