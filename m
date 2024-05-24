Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0C6EB67
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580557; cv=none; b=e1cttpttD+Dk3yppGlUMlenvyVA7iFnWHiZz9bT8LxtUobqoxIXwfqym7mOgEN0xGqxZWTDIXK9wmHbc2J/NHLUKK4i5oei75IiezzRe4TGFpySNEm6SvLtOWM3hOxWcbyezaLwiF6aYaNExf8Ji5JQkCxD86VK0eB06m9T+Pjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580557; c=relaxed/simple;
	bh=rGMkqTApXsvFZ+aNZ6vKGdePbsHagsGUMCO2A91abkg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CVR7K+W7E/CcoOOOdZ6Xh0lOw9A0nAdgruO3z93zg/UJ+poI/N2iZ/cF4cVbY/FyZkPFv456wVXq5uvTEnZ9l05AC5MRj0M4/HksNx/yGFX1zb1o7crZ08eUAFu5MP0ACRQktUa8GIp1v/rUcOIGHYeh19TUvnazPBcaw+hj20A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/so6TJI; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/so6TJI"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f0f7ec684cso4498008a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 12:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716580555; x=1717185355; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ci+sVQHfm6inSl8KX5IOyhD7jYqKm0xvcDnfuTh115c=;
        b=m/so6TJIL0FNciPZTLMJ9Xv0u9poPxmgK1NQF2SIGnRWuaFD07dPlkLljydicDV32x
         1s8h6n0EsHzAqk2KpMstikNaeW3h39tbY2XswnAYPJn/9I7U1zuiuD+6wQo1WVM6DcFY
         80odOuRfifafEd3mVNTaPzfxrMTFAUB8tFeC1tkcxbR4WkA4K1FVFR0OWe/1Et5lTAOK
         HSbeeausaqbjPi3gmvySSw6JuOtSlGxVIKI90KfnFy3/U17dA6l9Ap3ti4TzomyXJuc2
         sPtaBk1yECPpLV65U6d3TXSUwNIyQ+HC6Rmh0vjoIsscMaTzsPp9jYWRa/dNVN48d0fu
         7aPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716580555; x=1717185355;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ci+sVQHfm6inSl8KX5IOyhD7jYqKm0xvcDnfuTh115c=;
        b=GbztIuCRRBnIhiQRn1Hqv4gJ+Zk4l8CEMbzaP2qj+c8HJaRlxX0SZ4hnXvOl173Va8
         VuJX87OkYfdczLQ0wGOC3r8ZZFZ10hcE4aFf7yW83nlNqztS3H0HD+Sw+dQ8ewYYaWwc
         0HI4IFJmwhfyXgn+GHDGSZp9pQKLLRqA2Ck6iLeO6UD7RwoZeWgUSBr5JVEur6ApySz2
         AWRJS8m1MuO3X66MK5mpDKWSw8QegpwffO2ndwgXNhhqOqNe8/JkiC0G4wxZMLmNJnlI
         ZFbT/DR4eeuxD9v54vWY+9hg32rCVyqZd/zLzEnHHL7IAeGmfMAB0QN8ZElZN81DhilT
         nSrA==
X-Gm-Message-State: AOJu0YzVBtPPjJFngkyiWgShGnvE5hnTN6ueUplbgtohjxoXoSABjemK
	ufBKNRMTtl9IBrYRqKyeZfxh4R2VeYqLVsYWo/BebmiQGfvlI6OWDv4kqg==
X-Google-Smtp-Source: AGHT+IEvmnXIYtv3ekY5thLOF0NzvYAhwj99a9/lHXyyggTDdEffEkO9+KkYvmS1f+kpv1y7JSJSPg==
X-Received: by 2002:a9d:624e:0:b0:6f1:a68:aa7a with SMTP id 46e09a7af769-6f8d0b22bcdmr3106516a34.30.1716580555221;
        Fri, 24 May 2024 12:55:55 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.37.88])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb16becffsm10920791cf.20.2024.05.24.12.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 12:55:54 -0700 (PDT)
Message-ID: <6650f0ca.050a0220.121cb.4cea@mx.google.com>
Date: Fri, 24 May 2024 12:55:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2778071748699427714=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] shared/csip: Fix memory leak
In-Reply-To: <20240524171147.2733570-1-luiz.dentz@gmail.com>
References: <20240524171147.2733570-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2778071748699427714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=855755

---Test result---

Test Summary:
CheckPatch                    PASS      1.27 seconds
GitLint                       PASS      0.84 seconds
BuildEll                      PASS      24.49 seconds
BluezMake                     PASS      1698.23 seconds
MakeCheck                     PASS      12.96 seconds
MakeDistcheck                 PASS      178.78 seconds
CheckValgrind                 PASS      253.27 seconds
CheckSmatch                   PASS      355.10 seconds
bluezmakeextell               PASS      119.35 seconds
IncrementalBuild              PASS      4647.48 seconds
ScanBuild                     PASS      1020.94 seconds



---
Regards,
Linux Bluetooth


--===============2778071748699427714==--
