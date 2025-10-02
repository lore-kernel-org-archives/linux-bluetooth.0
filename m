Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B334BA2B
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759412809; cv=none; b=AWvkqvj88TWURuKPYHR/W6pIgpBGED8W5QBLrqVHOELLFH1jZVrslH81NTwkICyX0c1ccxo9oO9r6YHyoeNgpJ1IhoIXr+Vy+OaukIVETAg+W7XRp8tnjgBsFiZSRmoCPUAODwIJkRoQZYbLFqjNCofpb3sdVblFdIezIxAPHW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759412809; c=relaxed/simple;
	bh=XR++eDOHyP4Kv/gkafJhan8VRb9pSesevWa0FO0X0PQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NgZA1fQiJIKpgqvIHsUC8uLODXfYOlWUmd/FhTC6JreN5U8B4Us04BlrGkBlLfDTEMn8Mu9Rx0lDZXpX/qY2bFegrh6TpLJJzO4S8kHCha78tGxalMqxeK/sFH9QrB0/YBFeMEv9/rS4JzO3toPU2qmjw1Es2xuqhYWmU2/mF1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQ0rtl5A; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ0rtl5A"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b55517e74e3so1186549a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Oct 2025 06:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759412807; x=1760017607; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XR++eDOHyP4Kv/gkafJhan8VRb9pSesevWa0FO0X0PQ=;
        b=AQ0rtl5AmpTeFiq/BhOmo/walCiOcDLbgH49YV5juR7f40oAtsXzTsh56C8E4OFFWY
         t2g3pZZNy/U8lbik0IJl8alygwDs2uC0ip/5nuoUdHnm2OldGSdf8CK+kCMKk2hIVF0T
         HLNDuDO2B+ua/YjzVgNt2A9Swcwo7dA0d0oEd9rtElWQWwT8M0olEu4rJNmQoYVjlByn
         lr/PsgmzpXspTjVovR2FKhxHQu54dv8PqYD9pfhCGmsiHDPyg16IJ5jIalX6NOX7oD2R
         MfGhLfgmd1i4BtDtRQ61eDJI3DKkmPLQe/UHYGpdjFeuDnWu7FZ62yy16g4hncbglEgY
         1GFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759412807; x=1760017607;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XR++eDOHyP4Kv/gkafJhan8VRb9pSesevWa0FO0X0PQ=;
        b=CO46221XcaVjuQFNzt/pwlizlg5QYnqEmhlVuxJcaPgSl2E50wapgcoYfk3PLWKEDH
         EvWCd7rvCMSwSHI01aoAN34y6CKIKaTlAYYyMp9BvyhWiD6bzmCDPYjw/WqAzKsodI9C
         ycIeWrKyns6TAAwGvWZvCzqj0vc4JfmPfgPclN+DnIKWusMUchNta7WuSP5BQqIbuX8M
         gm2jcCZMoAdL+j+P7W+iEswFdhky8gAvWCUbUAaM/b+UaOeMCcsZXYxUMZOV/d+oo9dK
         GjdspUiLikMC9yRLr4vyu1yMo8SdogfuXAjkTkzYX+sqQxVsGgBuxvMyqXd0LRkObdl8
         Hdxg==
X-Gm-Message-State: AOJu0YzNOai1x64ignm+qw+iPa8Rchd63/bCVRKUSdRqeTtYPeDJ5RMZ
	1wnXRGaX3r+8CEKbNxW9kGjaD3p4AhCa0JMxuFxyD+rVF+DezelzhcX8r8oO6w==
X-Gm-Gg: ASbGncsYbtymoesvnd/Oi3jFOL9UaI6d9IP6r2Ap717oqlBtAgMkOtpDDEGPfjm5hOl
	ROFK7eQY6bPu6tFiLhqrAnX90QDq2pgja8K8WN69O8lg49QaIxKh1yi090srzzoNHltLJ8My67T
	ZD5MXNMXmUfls2SumVTP8XZvAZSNVaAReWoYPv2LFvr6P3UGLVFo5u54BeHDUCOBtu59lmzwIkz
	QqzMrcHmDop14ALrY4iS4RmyvDHVJxiGPj6aPsNAdrcWNiD7hVcZqbXdT2H8u9nNeGqrKo7ra++
	+ZnlMautiPOeM7B2ADNHtFUQDp15QKOszSSKkPkPL8HMOGshMiJfjl+Cxjhc9WsPsTpIT50Vnwj
	Hl0kl4FF8a6whn7qUt4IYzJP518O8XycixRtZBWddlyPFq3ZUxLAGgn/kShYtuwXC
X-Google-Smtp-Source: AGHT+IFAmUjv7vVVuzXCXZXW2Khv6Sm0OT4rcU5Oy2BceSAs5dcMA3wTkYBXlN5CU/yvo369BjuJAQ==
X-Received: by 2002:a17:903:b8f:b0:25d:37fc:32df with SMTP id d9443c01a7336-28e7f30f867mr105767355ad.47.1759412806639;
        Thu, 02 Oct 2025 06:46:46 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.212.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110995sm22899705ad.3.2025.10.02.06.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 06:46:46 -0700 (PDT)
Message-ID: <68de8246.170a0220.28b98d.8f82@mx.google.com>
Date: Thu, 02 Oct 2025 06:46:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2659888824002330931=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/3] client/assistant: Detect if object already contains a valid BCode
In-Reply-To: <20251002134043.196760-1-luiz.dentz@gmail.com>
References: <20251002134043.196760-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2659888824002330931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: client/assistant.c:293
error: client/assistant.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2659888824002330931==--
