Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C71BD9C9
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015901; cv=none; b=HPWe7qHR0YCQj8x61ELsy2Y58nSpHq8RN0a/oLjp+UVU8QtECJtHTbOiupQXOqku44ZGuoyNyQ+2uENMGo2spzILqvKLa+4nRucS2eAPe/hJ5BUSHowE3jjVIVr1HUQVUt+f608aW0qm17snwM9hj8bVh0PuC2Bv0ZO87LjUmtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015901; c=relaxed/simple;
	bh=lj0REuKVIWY/lFM/RIs4pZupJD6P5ssN/DzsfmDHaok=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ohJW03fbITCnPs9vyFzSW4+c9AVAhEwQj15W+brwbVYCe73lVVoT8r8Air6tilH7q32MabsUxxX1tsMA3fIl9Y+UkuoVLUgqirKvSt5oadQFounsQPcBELAI37trih0PZ0aA1H8lRic0PLCEE42VHIyg3Ct2OgZWebZtSf4muk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CND6tEgD; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CND6tEgD"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5a7c7e13b84so3190113e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781015899; x=1781620699; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=merqoAK78fKAf7cy3ETNC/2XhphELpl6aXxtHZdzIWo=;
        b=CND6tEgDH0ZrkOv1lS0koVmEM4kG+gsN+UY6BCjZ5n9mQD31fApThHF6ucc3CBxQOr
         QBoZp9AH7Ihky9Ujz/VGiH87BaRx6mAeLP9xuoAqfVdtB7HoHVRoh89/ZeYWOqaSI23p
         ux1k+dqL8k8TTU/mQpCZ8vHUbbsPpEXwbvSFhLE8Rib2LjVqyH42yhh8eXFyGMe33BMz
         ya0RTZt8nPCeDRoZy/U+QR8DuC25tVLRyX8TYBUO7lmOeMY/Si0UBADG0aCk1RPLxvxg
         hE7jwQc+/GE0Ms1fnP4GKnmroBDzWD22nPTDWSW3P6WBEC6wJdyDeW3aeSlXoDnMpNWj
         vqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015899; x=1781620699;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=merqoAK78fKAf7cy3ETNC/2XhphELpl6aXxtHZdzIWo=;
        b=Q/SuVR+6MBE0tFQZ83cE6BYNr8K8coe/lFECRmfz2AYcIYYVZD8zeF57JJhBhEhctV
         RAoPCvHUnlLiymx1y4KsIxvjVNQWLIcRpVLWK2LYpnzC7b2of3okQ8gxeoAjC+vtTuG9
         1wqx6A8CD/KA+ZfTQVHuc1BZdc4Z24Pm/Ae1YNjCofTbAx12EI65F1/tYSXePwUwWG02
         oF9+R1ab6wViY/hAbLNXH1u89bCGEGngPsRqbJk206+CTdUt4084sApHRTaP3b5294zq
         N2FHz3tOZX8ubN7u5BVRbUcs9vRBB8zKPgqD9qv2wnr+7yExRD4LogTg04eNoIrAORW3
         luNA==
X-Gm-Message-State: AOJu0YxcwFqIKdig4ljYJRFViWYhni8APyCMZ3UPCPZcifXspNnDIwDU
	r5emcrS80zc+lZXsv/2cfzQkslA+p6iYkvgDWeNATpX5jLIOlS1MDEIX0JlGqAng
X-Gm-Gg: Acq92OEc7oOKu7xKSFlh8Mx9BCqpisb+mmZpd1VYaJciVz+dyCVA43sTiXGdvFVAcRr
	y34T2oyKWpPpVkUqahTll6j7+YGVPvmb1DybtCkw8emxcMnMDukVCw42z+vcxlimgYSEXcNZnYp
	zqWtOBwjZEelkErTLI1in3e4dZ4XPocwaJ7MSxaw4cOcKqq0FdedjZ/2t8PITSvxgI6iSGZAsqj
	RWR6vtPVuSUhp95zdQr8mecaJM8EBqedwj8EqFXsBsJJe0jMiinKXmQr/uJf6PJsWSa6Jwkh1xJ
	Yxzzki2+ZyZhVrCAj3ZBFJNT38t6qDnNknpikbULYSH01AFeJFZdOn7mbAKqiR8DIqwsjGUrUCk
	Vw/SxekhJiAlFSoktUHI7FdelS56Pi9ZLNJ7NBwx/BYoNEBnQ4ps5U1Kr9gUWArv4arKciVWhT3
	OM7A4KNBjUqTSXVke6JKAOxAhIXvKhA57GwKM9gr+zjQ==
X-Received: by 2002:a05:6122:d11:b0:55b:d85:5073 with SMTP id 71dfb90a1353d-5ac4dcf272bmr11022404e0c.4.1781015898869;
        Tue, 09 Jun 2026 07:38:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.103.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b9d5sm223162556d6.44.2026.06.09.07.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:38:17 -0700 (PDT)
Message-ID: <6a282559.4ed8569f.af6dc.2fca@mx.google.com>
Date: Tue, 09 Jun 2026 07:38:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2586074962628091088=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, senozhatsky@chromium.org
Subject: RE: Bluetooth: btmtksdio: fix infinite loop in btmtksdio_txrx_work()
In-Reply-To: <20260609121329.1262170-1-senozhatsky@chromium.org>
References: <20260609121329.1262170-1-senozhatsky@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2586074962628091088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108559

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.65 seconds
CheckAllWarning               PASS      29.25 seconds
CheckSparse                   PASS      27.91 seconds
BuildKernel32                 PASS      26.67 seconds
TestRunnerSetup               PASS      550.04 seconds
IncrementalBuild              PASS      25.31 seconds



https://github.com/bluez/bluetooth-next/pull/299

---
Regards,
Linux Bluetooth


--===============2586074962628091088==--
