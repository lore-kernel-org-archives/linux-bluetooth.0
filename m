Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7821C01
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777145953; cv=none; b=MLmVQmmwPQy4Vc878VCthNjPhY5ChKZPuTedmdJ/iwWNxQuf2F1hez+OK3Xri6tMZ3Wt5wUjepAVuJ5KVbWBJEAxdnXPSM6xqWmmov59sBpRZzO5fS4uVwjuLxI1UJMPWanOKV35AEjUJTbOCIR/TyEGJHCXw6uRzcBj/Ul52+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777145953; c=relaxed/simple;
	bh=7fG3d+CHPFtXh61krVz59sEGYbIpWb7+9ZH2b/ybvPc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Sk3dVCEuo6FYbT6VCP1FJkBHYVbaJ4ELCRL8yJFcSnxjqqM0iljhFmSAhGl0CfShPHO4eXNnPMSzvTah68oEM/lwMxHgbPUcCSz/1s3apKhhwUYRQBoACLGawhp/ObxyfYOpzoWq3Utnc25VMpbSN0B8lCH/jsyl6elQuJifr2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hj4d4z0w; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj4d4z0w"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d75bfb259so66467831cf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777145951; x=1777750751; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qN4cVhoEXB+v+DdkSGea4j4dNW1M6ae8Y+B5Vu6fpwM=;
        b=hj4d4z0wjP08d+Ltwp8TzRI+t1/X5Q/WCbIkduH0oQ9vn8jt9ANou+qPIyuNYJoLPp
         OVcLKU55wRJFbpmiDjmvL3eCPsbNx7qxgbWQfWCub05hJrX05ZNPTlGwLZDlQ6QVxxTZ
         6Pe525UAD8Wee1cwQ9VBnr86jc51W/dHfh064+IRLrunT1XmdLyUmwSUrMKfp+abpZl0
         GltxCa9obxte83BA1HUsv2/0MUJb7rMzue3xD6UaPrAcjKQiXFm8dJMeFJYEMbWbcMp4
         5Vdg6RaD/gvYh5TCClP6wCWNe99izXCwosfeOUSCNVoT1s67W3V78sYExHgY6QTQEFM5
         a89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777145951; x=1777750751;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qN4cVhoEXB+v+DdkSGea4j4dNW1M6ae8Y+B5Vu6fpwM=;
        b=JFrbf5gTPcbQpLHLwwn+oQqLOZP4PfvHxBoJyq5EVUPaWaaOKYuNWUxgVnBqEF6KME
         rYB3Zna2x0ULGNRfdWwYHN8rWQ62iwptwSFG3aEZeeaU5ZAUtC/wkHYiLRPylAbSHNAJ
         jkcUillQKF2S2m3/k5++WElXkOmstDIVSnAE89BDATsOjWFl0NJe64gQ9Is83KYmTo/r
         lB8WJYr7IMBBFNVnBOtD7zYeO/Egxha24zT11gJ+ASHG0i3lWcaq22RPd9tW5EJVWup0
         u0UlkgpeOXvscIEpLcGU2CCTcPJPC3UGt1kDKTd8TTFBlDQ6CeILLg19AMwOpmQ2a+0g
         kfNw==
X-Gm-Message-State: AOJu0Yy67srbQP2Wfo0ftGMlxEecNOIwQLFypcvw/bUFdesgx3hSrm35
	EN7F7CRvObpy1Xt12RbT2x1oAb8iH9NOvcWTxUXEHujdqS9JmAYxUfx5xFvWUQ==
X-Gm-Gg: AeBDievoHvKg/tGpFBWCqQrBQqNdRUm6kLF7RKb5iwo49gUpj6KN/PIraSn8nYVqoW5
	n2oFQCIBjD4xTjgnjGv64rPwEzWcvautadVb0TSXppBzjOCFI13GC1/WK/HSjFkN6IksE75LsOG
	+yKEnPvrnHVRGB+Hc7t3t6C8hPqb05u511lB/B30nEl/NtvbrrRBWPkwaqxaNIusqyrOHEqcndy
	NqE2xYnRurL8xPArsQEvzgRbGa2JoMSG0298uLIvUPl1sAkHae1kD6CN59BbsRGJxrGjW2jGJpr
	AsmzCUjOwfJRQaT+UWRqGInFRwFKy4dAQEmgutPAc31DvcwoOt4J+ZoM94swKyXn/mB0JeDSexq
	MP+zmixUdw6F7MdflHrjOTcYTU7o5es9AO1UmiTr1iZgffApAtXtJqRYKBl8wGAttD2d3T0YuhT
	KSj61v6CGTODt1t9V3TzaKFieEs5T6+zuQZ9rmsLe1rw==
X-Received: by 2002:a05:622a:1646:b0:50f:ae60:25ab with SMTP id d75a77b69052e-50fae6029fbmr376471371cf.12.1777145950936;
        Sat, 25 Apr 2026 12:39:10 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.118.80])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fafe9674csm188406021cf.3.2026.04.25.12.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:39:10 -0700 (PDT)
Message-ID: <69ed185e.050a0220.107d78.67fa@mx.google.com>
Date: Sat, 25 Apr 2026 12:39:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1690390983028190230=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nils.helmig@web.de
Subject: RE: [v2] Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV
In-Reply-To: <20260425185659.13133-1-nils.helmig@web.de>
References: <20260425185659.13133-1-nils.helmig@web.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1690390983028190230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1085542

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.73 seconds
CheckAllWarning               PASS      27.58 seconds
CheckSparse                   PASS      26.25 seconds
BuildKernel32                 PASS      24.07 seconds
TestRunnerSetup               PASS      526.83 seconds
IncrementalBuild              PASS      24.34 seconds



https://github.com/bluez/bluetooth-next/pull/127

---
Regards,
Linux Bluetooth


--===============1690390983028190230==--
