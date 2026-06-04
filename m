Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B236C42EEA0
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574986; cv=none; b=N9LVDCuy30+QjMA8olUXiCQAAib/6ocPNcnBhKIgEDs/YOjPRfUd/wqkMJ1TiHIaH/5ExOZGgkiWh4JPFMjqkYp4pyB7HQCX0jKqEXxJbPHf0iyPOzOJCbXgzApIVebMX7AWh2XC5D/a4Iq6y398/cYrv2+hdCPRavktK2kcGqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574986; c=relaxed/simple;
	bh=B4bwJri/iVSEHmLaqFfHupkBA9L+GWZ2Oy5hHQ2exZ0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DtG9bVakiO90ZdakahA7tq7GAzSobvuSFBEXhlJ2D/YinZyir1+Di6UNF6NxKqJLN0KvST+usAEyQQN1xxfyIB3s3p++VUU4Y8TIgtXe9XkJHkyV0vX3XvMs2JPvNthqKRRifdveMSgXBcQUSOvRK+kBYU4ECmqBIOq3K4Ajd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liEHNbgb; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liEHNbgb"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304e83724bfso669749eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 05:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780574984; x=1781179784; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=35VuJqkB2FISw0Qh9QQsqsmfQ0aunVc1EuRchajq0/o=;
        b=liEHNbgbS8WVmwHtpsca72w9cYiO6CKlF9jG7GtVF+8VPF9OVoIcujho+EXpvnoZk/
         C7ZKtHITldGGA+uzHSTvA/fEt5c+g54xTWaa5Pju8bVCsjl+Mt7JJ4ujjovUj5c4S4lW
         u9r4fyWqDIbY/2RanuRv5eUOM+zF4i/xGLWl7IFql8BOJUTBOfHAq0rfcIpSVs5Hat3J
         5SEpz1zj4ZNRDUKbMEQa29/+JC/stRb7SHK0ygqNwof5BBLSGL4K90zCtTPTy5pS/Zjd
         ZtGoFYVTvJjQInxb6HRVT1LmbshPMKFh+TogI4a08LG3D4ZwwUxGd7JMwmriFiyGx65H
         g0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780574984; x=1781179784;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35VuJqkB2FISw0Qh9QQsqsmfQ0aunVc1EuRchajq0/o=;
        b=rcmIWioIN7OUoCvUOe1L8h2eRWM65MlGkfJpcGVeI8WWrFyhEqq8bXUmzwHwQ9N/Y5
         ign6M8kGag/b/5Zp+qhoddAJbR+tPF2qWtsE5scJzoZoYId42/3kvatAS82fMj7v74Q0
         efXVUh1sO65Chx0sFd06pIhSKDS0MoZoNWwSRgnmlG3OCdSXSTO8IfEq7aeuPCV76OlN
         am6JlxF+gWOKN59anTkKKjHPSkmu72R6IGLmpYzmBxxsyB9GlBcpJGhOSoWfDGKiBSJD
         nP8T0vXaEKaDx9GDXBuPNt/nVTU5En5usOgF9t1iNT9XMKZkoQtSpPep7MHXh9TQGx4l
         nqcw==
X-Gm-Message-State: AOJu0YzgGPjejAn55A99UkNGeNnX3ZkLjEzLexO3Rl/5tYO062vnMgrm
	qDpmRki5HrSzQphlAr3Sce/CbbND8a/aZry1vlz/5CmblPFKK7Ekw/boNhgTLA==
X-Gm-Gg: Acq92OGByKrmByppgqPfcjorSXUlM/LAS+2wHSLSQAZXwQPcz0Fd3pyVnQ/uX730vAb
	za00d2HQLksRUb6OdtM57lyVEaid9FGYIH8o8aFt6niVMVBxqiPI6iofkmWuOYJCflJgmuW5wfR
	1c/AR5kjeZZBRVIhJErfsKOBAF0xer5ns4y5TwarP6yatvApwzDLHX8cWJKY4Z4M11hU2RyFhyy
	2wJLMiKkgTVX7xEvUrEIMsKAlBQxr4yrJVKrvDXhzwq2xXVQPNtcWxkK4NLVXpDoQoYzNZ/HosA
	4CWmDWqDwYNpAwi82qCyXkUL58XtMXS0ARTYOn7AaDzXTlU4SNuTLFbanXICNap1bF+1mMXbab0
	qNMcWz91qYvy1A3xXA5COSd4fsCYe0leb/J9W5YtpQoQr8uDIe20et8mtfAXJTRq9Z+7m8v+8xj
	C9jcJKhVdyGrpx07F4MYfoZ1JzYtRQWFf0aQkhh0Jojg==
X-Received: by 2002:a05:7300:80c3:b0:2d8:71c2:255d with SMTP id 5a478bee46e88-3074fabf4c4mr4065297eec.14.1780574983687;
        Thu, 04 Jun 2026 05:09:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.117.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db56697sm4948290eec.2.2026.06.04.05.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:09:43 -0700 (PDT)
Message-ID: <6a216b07.de8afdfd.21d06c.4ff3@mx.google.com>
Date: Thu, 04 Jun 2026 05:09:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1117720947801673868=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wei.deng@oss.qualcomm.com
Subject: RE: [v3] profile: Set L2CAP IMTU for OBEX profile listeners
In-Reply-To: <20260604093024.3594022-1-wei.deng@oss.qualcomm.com>
References: <20260604093024.3594022-1-wei.deng@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1117720947801673868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1105837

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      17.80 seconds
BluezMake                     PASS      634.83 seconds
CheckSmatch                   PASS      311.82 seconds
bluezmakeextell               PASS      166.60 seconds
IncrementalBuild              PASS      599.14 seconds
ScanBuild                     PASS      913.59 seconds



https://github.com/bluez/bluez/pull/2176

---
Regards,
Linux Bluetooth


--===============1117720947801673868==--
