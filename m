Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6342E407
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922512; cv=none; b=AtpWAZ48b4SWz9o+r21ceyLcQCGhO9s7HA+ZNsmc5GLUwdkQAsIbXZZJebIRASVt6WF7VSLgbP96ZYmTwaot5zUEmf5IbFWF4rFqGCxALHEJnkBnrBeu4Wl/8aB59Vtt25Yr3gev0GSygC9L3YoDCiMMgjgYMfwt2QUZpa6ROlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922512; c=relaxed/simple;
	bh=/XP1LYrWUHaJZLFUInEHKQ/VRrvxK4MzsPGPNMGEUHU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WLGmzkI3VTs9CannRVL7ttMWQiBSzdL4TdJLO2JMf1YSfnz5EpHib88ZafjAor7X3mMtG6JiL3R71WxyrmUc2qxrGlCM7phC4QyzZNaFb+h5N+UeM3w7e16bcC68wbjSNdBmIgLalBxaSaVOokTuWBtFF+bL/CpWTgqSsUnkccA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATzBhuix; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATzBhuix"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1def3340682so42167935ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 01:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710922510; x=1711527310; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/XP1LYrWUHaJZLFUInEHKQ/VRrvxK4MzsPGPNMGEUHU=;
        b=ATzBhuixnQJ50552QRqgBI9RlLIm91R0wcj9BC2lZEd5fnXIsItTkJpGSyVAW2m4sr
         qD+UtfzJmmt6bV3pxwyOay26AC5Dw3CKNBayLJeYgXlqso7JlnBEoCE0jRvQRCHMHast
         U4Ewd4SoUR20mZBoR6703zna3VGJhgQIGGSnOnGQtHxOzN71W4D0XaL8VDriUyVweDsD
         nFNsJdiCpZp0AJRpjOCnxNrRr5dE4dK+bqhKtFIswAq7UqSMIeGpGz1QT4XTdlLRwd/S
         1tltqSlRfpylmTB9DXlKpeJ9U2pVCHGBLtXNbuLkTs+Ztpwso4IPWv0IVeuKaqQBbKe3
         gWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710922510; x=1711527310;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XP1LYrWUHaJZLFUInEHKQ/VRrvxK4MzsPGPNMGEUHU=;
        b=UMrHwiCPqT7N07DWMoeSlT9XYYtckD62NjOMyGFoCFKYVfkqwdhtqbFLu1tHXIxHat
         N2i+IfrFq/cavEdytWl5zuM23rbaBFcTnrc788tTGKJWcSILeLme7fIgI5QYwllGjljr
         XwkYD9D7qWuzTOS+3PPoAsFK94DVjPuKrhgv3EQQww7w1yIouyVTYuPupokaN+Wh34UF
         tUVbEJZckKWWKykcELml73qWdNmAAjdfclW255ua8gAtw8iZ4IMRlbdGsUE9HHs21exQ
         S2Y2rw5v9UjotlqdYaEJBufw5RsemyCmxr1puvUVEUigwL0N0n8D12MSfAaE/L6M1OC1
         JiOw==
X-Gm-Message-State: AOJu0YzwYW1KLN2eQcGIpGO8B26SURH9eA5vic11F0OLkCneCqQivzHR
	hxPXv0tAsq/Y6OeegrAD0c72ndUTeR7e5qWtTooK3frb6F5ZKZBTrh5CTzsu
X-Google-Smtp-Source: AGHT+IElLdAWZ2zs12RlsRwPSa7Nv/FFX7AksjIzzoUU41PpQSq585PTtwa8O7tyfE17hMtCX3FcUw==
X-Received: by 2002:a17:903:11cd:b0:1dc:fc84:edaa with SMTP id q13-20020a17090311cd00b001dcfc84edaamr6334468plh.29.1710922510119;
        Wed, 20 Mar 2024 01:15:10 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.115.109])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b001dc30f148f7sm12879691plh.243.2024.03.20.01.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 01:15:09 -0700 (PDT)
Message-ID: <65fa9b0d.170a0220.52f12.50d5@mx.google.com>
Date: Wed, 20 Mar 2024 01:15:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4144235659141208775=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: qca: fix device-address endianness
In-Reply-To: <20240320075554.8178-2-johan+linaro@kernel.org>
References: <20240320075554.8178-2-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4144235659141208775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_qca.c:1904
error: drivers/bluetooth/hci_qca.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4144235659141208775==--
