Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5F317FE
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 05:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737697198; cv=none; b=KtgS5kxzbkz8zxf1bEcjliH91lIl6bFR+EWEOkzqPRAy6Ss27WEqef9TcUmpABmW2kXOtELNHyrld8GaXtkOXioWh5dGRMkk2sNHY7ymNVlfk+6j2y9Ze8haKNOTh4eA9bM3+6acnqwy1aO7Jli03NtJ3uEMzhAiVP+Y3YgZe3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737697198; c=relaxed/simple;
	bh=eAiCYxffuG7N2BL6lMSIF/I3Hzq7DAhaozvqUNT6D8s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fe9WQZwiHZ+i66lKMm/4aj9Mnlwz4FrHAeePI1H48ZUVuhowsO2vlmtrImV4rcLJMONNti9wM1EjI1+Ne+uUjsoseSgPwA2uS+A1KlYB/uEEPMKYMSbEeN4vanIe6b/nWuIOLuNLGgt2JVLas57ThjEg/yAsiUh99vJt6KNF+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZqJ95uC; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZqJ95uC"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd1962a75bso13309496d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 21:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737697195; x=1738301995; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eAiCYxffuG7N2BL6lMSIF/I3Hzq7DAhaozvqUNT6D8s=;
        b=QZqJ95uCOLOCn+c92wqTBWIoTX48ngH4z5Tuk0xxq8YguNCWi1HAGsaFw1o+iHrUHq
         tOHI37JPkOVpQ4PToXsxY8/GiJp//8GFbFAuPaRIL1dyk2OXYp5iIAf/5RBOd5nWJPeX
         wMqbXJ850wsV965Asx3astIiR5189uH7lwUXkWsmPdi4QUZFYR3yAUEKB/JkMldAyhMc
         pPi27OBcAa4w0NLYToidChiJiLN5XgALziPC7LxPB4ovrXjnjWFIogMKLNNU4biLaHFp
         m7NECx40UEHSH16XRyd29v6Il/3OlP1gexmKTjOz6YGhNp0NPgLI/deRydhe3qGqtlCq
         vcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737697195; x=1738301995;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAiCYxffuG7N2BL6lMSIF/I3Hzq7DAhaozvqUNT6D8s=;
        b=O5lCuZApFXwTwvNlP5kKHM9dFNCw0yyPe+AWLIq0NUGnuEjWVO4NdryEkE0swYRGrM
         CttMpA7dlKUiDhq154AJJGvmpfSHX2l3hqOsJY7uDu9PuAID+0io9jkx28AobM8LFi/V
         mL1Xshlce9a6pOy6i9C0eE6+13jCFw5qPkrbY7hedj1c7fWzEvIbn7Xn31Gm0knPQuFp
         vdhWJHckbAW/pVou2AXVHD3Mw3HN3sqvFpngNfBU0mL2rJRyR3Ir27c8hcnFrCwHl5n5
         02OQhn1tNPG+aKTJeb1J4hhs7ioexOlZXzlcq1+9XUW59rEugaQkg5N8NvDx3i95lxoq
         sebQ==
X-Gm-Message-State: AOJu0YwVBr/+H2KUsWEALiWcZRmu+kuKWvZnkCEJhuuwVotjJ1A08wX/
	LO34vonZsti+4qWINPA5EaFEKbTYY9bSSM3Gs9yC5Iglbm1RVLQjEtFePA==
X-Gm-Gg: ASbGnctavuif+qfvVbmMzHgok7Eb7KfUxhuzF2C5QNiIBqgRuxpiVUKR8gicidhEitM
	imjGruUUiPINTaczIS29RtFe8naYnK9r4+4zGHupM+ehiUR/i47XpOkvQgbBwGo9Yurmj70Zz5L
	9Pj5J2SzG0dgWnbk0BIV4b6F0VAUXQ2Eetzu76bGu0IfNXfwruJsMzCvD+WRWUuQWgr/aYOOWSe
	famiBZTyMGAUEPTfVfP61m4a1BTzlpEgPmSvsxE9hRBRmK7pIDDxhdR9rMtftNQeVXJfDdHI+9c
	KLlGyqidcg==
X-Google-Smtp-Source: AGHT+IFb6Fdm1MLzDOXeQqncm0yf/TPdnyY/yGrZLhrBb27EztGRMemCeUhRpra9K8iX92sf91aq7Q==
X-Received: by 2002:a05:6214:2b0b:b0:6d8:b371:6a0f with SMTP id 6a1803df08f44-6e1b220c7cbmr409579746d6.31.1737697195650;
        Thu, 23 Jan 2025 21:39:55 -0800 (PST)
Received: from [172.17.0.2] ([20.246.78.63])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2057a83fesm5467216d6.78.2025.01.23.21.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 21:39:55 -0800 (PST)
Message-ID: <679327ab.050a0220.3740c2.27ea@mx.google.com>
Date: Thu, 23 Jan 2025 21:39:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3306105756966097532=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, keerthana.kalyanasundaram@broadcom.com
Subject: RE: Backporting the patches to fix CVE-2024-35966
In-Reply-To: <20250124053306.5028-2-keerthana.kalyanasundaram@broadcom.com>
References: <20250124053306.5028-2-keerthana.kalyanasundaram@broadcom.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3306105756966097532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/bluetooth.h:420
error: include/net/bluetooth/bluetooth.h: patch does not apply
error: patch failed: net/bluetooth/sco.c:822
error: net/bluetooth/sco.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3306105756966097532==--
