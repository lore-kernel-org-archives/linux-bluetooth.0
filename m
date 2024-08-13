Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640FD29A5
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555041; cv=none; b=X8Ilzw6HnPSKhX1NNaOY9065d8zGRxl8bVCvi3OvKg833PV3x9LrHNzYS7EgU+1UhRIDDETIPS3lf8XoYgHln2KTzrsN+0K7zTUpN4SwdGk++f7xgQjWcJsxiEcEehgfA3E4Lbyxd5esMeO575NiJilZ8TuIkxvrTPOoMWkFJZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555041; c=relaxed/simple;
	bh=32KgQkjUpS8z8ONxx5CZ6CZ6uRqpSKD4EXm+D3pnlDk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pImI7ZjTH+vSiw8hEWfhTppm7E+XyXRnbISNQ4sXATELMcj7LtmpVGY6U3npUAyMi/8FCfR9gQJ34zbICYGl0+MzrHj8S3YGaIOqCDBtdQNj3zSL1bYEXao2ZbkPVAI0w74oCCjI6/90oVN0AB97aQ8HNZ6V/47ko6sWoHJPrh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtsXdgBj; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtsXdgBj"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6bd777e6623so23274426d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723555039; x=1724159839; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VdSKPxSg4uDVYyiC8xOKgMis5BMr5bOw3gkjxMKcadw=;
        b=DtsXdgBjzVfZh31QzlsZPgq89jOxW629Qbg0J9dNz+THLpQkre/GkjylqxNNNSEu3R
         IllDrbj7McQM7HLy7A7OcRpJ5+hE3XHnI19pOCPOMxMJLZhyBZZjRB53iiVyEm+T5wPm
         nKOO/QUUJZenEozdQB66OZSDMC1REF0WXtMDSKNUKmaysRk9c1SUV6WUV4iMT2kmrpni
         JiAosHc7QVuzLNM6Vc3+MdAwKeuLD6HzsuVpUl2YBAzD5cqxlOVZ002m/vQ7HXHs00t9
         +t8BW15fFh1eYd2+NUKhHO7MXwsOAk++wylSF/O1/QgZHC704hnvdQm7mCboknEV3xhZ
         yH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555039; x=1724159839;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdSKPxSg4uDVYyiC8xOKgMis5BMr5bOw3gkjxMKcadw=;
        b=BJe9OJ7OCC2zThrTBKtx4+yF4FdEwszGM7JvjBa/RBjGmIhnz+doq+gkQOlF46fjEp
         FXEbt1nn5XsIvHUbCDFYfpJ13nA276nZ4zbiB/8vr94+FLEwQFIAaldtcV6LffujKI7n
         uafowhWE8+UFFfNOnarmWFz0z993KMSlSz68S/lFEruiwQxOSXHxVTafI24PVcLCuook
         O7FgzKiGkfHJApf8Nop5Y6npjoVBMOfIpRicgi8tsYvfKvypq6kXnYilthWWVzIoj1/F
         JzcJxYu4ILX8sgqIhpM3uMyByT2CCW+76Ic6WYVamMkCxOwKE4E71EehLkZ07eGa8+qa
         +2sg==
X-Gm-Message-State: AOJu0Yyj9pi9j+h5wCF66hFavrV7Q9UpmVMni/1WiLwOKxAuni86yk8a
	YO/inAIH1Xa3ZqqKbgMZP2RXHO4sg7rTcnQ66nB2b6ZMFdJrWCmKRmDuSg==
X-Google-Smtp-Source: AGHT+IH0dWoWG2Bge1vd342hxHxaCccANmsHzDSM8wSt4acg3O5QYwh8DNYWXl/y7q/E+IHpLypAxQ==
X-Received: by 2002:a05:6214:320d:b0:6b5:e3ee:f804 with SMTP id 6a1803df08f44-6bf4f79e8e2mr34054446d6.16.1723555038953;
        Tue, 13 Aug 2024 06:17:18 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.51.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd8c88bdebsm27996516d6.32.2024.08.13.06.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:17:18 -0700 (PDT)
Message-ID: <66bb5cde.050a0220.334641.8349@mx.google.com>
Date: Tue, 13 Aug 2024 06:17:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5301680263689070359=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 0xff07@gmail.com
Subject: RE: Bluetooth: vhci: manage mutex with cleanup helpers
In-Reply-To: <20240813121829.6693-1-0xff07@gmail.com>
References: <20240813121829.6693-1-0xff07@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5301680263689070359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=879205

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.58 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      29.42 seconds
CheckAllWarning               PASS      31.78 seconds
CheckSparse                   PASS      37.59 seconds
CheckSmatch                   PASS      103.26 seconds
BuildKernel32                 PASS      28.48 seconds
TestRunnerSetup               PASS      528.42 seconds
TestRunner_l2cap-tester       PASS      22.26 seconds
TestRunner_iso-tester         PASS      31.00 seconds
TestRunner_bnep-tester        PASS      5.00 seconds
TestRunner_mgmt-tester        PASS      110.45 seconds
TestRunner_rfcomm-tester      PASS      7.62 seconds
TestRunner_sco-tester         PASS      15.23 seconds
TestRunner_ioctl-tester       PASS      8.13 seconds
TestRunner_mesh-tester        PASS      6.13 seconds
TestRunner_smp-tester         PASS      7.04 seconds
TestRunner_userchan-tester    PASS      8.52 seconds
IncrementalBuild              PASS      28.73 seconds



---
Regards,
Linux Bluetooth


--===============5301680263689070359==--
