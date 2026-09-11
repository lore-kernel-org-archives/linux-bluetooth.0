Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C132DE6E6
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136749; cv=none; b=fHEg9htljg/+m9eihtHd/pX6HHiWfFSL1lhU6jWfYa6cudKbwjFh0Iy+TowninEkbxC6rSrHu57kndVYiTaSjkDdJBcLWtPQFhQpZwNLCLppOQoH4vs4PMHydYFYrtQAwLj3gFdJFP3hneZKzGaLe7jycNx7K1WNAuNB9vuoVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136749; c=relaxed/simple;
	bh=8Mytskx0GwkEnePfqc8BbGoM8MNVFjFvMccG0zYSTP4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SrzZ3XNre99ge7CN3f/K7FACGeQHC8K1XTC2FMPsr/RmgrkNxt2BdLrLqYPV8EPo6sGxOag/IBLVcSYjxntQRmdGjpSJRhN/SNXSe7GYIFbvv1neUQebaiaK8Wf8du0CfGUa/li7kxY3JuOAzcBO8maijcbepnAooTM/auFSxAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSAEAlxR; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSAEAlxR"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-47b5043f191so543836fac.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789136746; x=1789741546; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lk/HHJsx8cACcudy0xSFtWHN5LUARHTXfksquFxcrSM=;
        b=mSAEAlxRijhzpMlwhcFsjL7wyMYnVCxnYJJsRvgaxseN89ENyd96gWjgu5/kr8TLL2
         58JkfInBbJ/Sb2bGQ1nWvlOb8oxKhOW/GfFB293aKqEe2AIRvfYROYOeosm2pwTMWeHH
         +6HPVFtTZ81DMAo18EI4FJ/nVv/WJZUE70Lb5hzcp3JkvzujS3AF55CU/vzyyni06SpG
         W0cbwBL14LENYWBP7aLON7MJJYWmsjLokZOf5CbiroinrgfVNaQFk+5ktFil1SedM6RK
         UsPQ35Zs6HhUqwad3y68RpBHgfdOtFGFXmHh8t7gukU+yLV8Kgz0eDx0aDXNFTeVwwlG
         jlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789136746; x=1789741546;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lk/HHJsx8cACcudy0xSFtWHN5LUARHTXfksquFxcrSM=;
        b=Ob/IJ9Dpm+UxDR7H1xbgH4i2cF0DYOgGEaNYoxzWKYW+OPwoFrWyBX2h1HNgi0Pv9G
         fFkjZHO+PeAL/IOWIQ9K54Gn7MUE820aHSA4DO5tEVpLaHw0h4/AbbUJvJHzairJ4CdL
         +3KzHwonT8/uhsej9ItLpBheBofwlPYAjQ/HgjllecbVNmDNEUioklzR4KH9T+tUM293
         wnOR0fxmixzPfjZFBRVN/ADLFVYGKmeTQVqoLpA4B47STXG/lbo4/ALObKPlW/sPvxGG
         UK7A4c1DY322UQvz4LNaR1JsVi0E/02iecU0KLuB+lbIDKXVyoSXRVH0pBkUQ09SbOQl
         ZfDg==
X-Gm-Message-State: AFuF++mSbFw2nZ5BGjrchjwxSSBq6o6C1aUcvLZrNP/JAdYoHpFWeC8c
	AE6NO3V4tZANinNpEu+5C0gwj8h+gKyaOhTFmVJaF07ER552rBjVezK/D6MKmg==
X-Gm-Gg: AYBFou1kgv0YiXZ2kZHJcNxO1pMsqKhwMfoiymPInxJuX8Pv6emsO4iabmw/Ad8j0ak
	EcWS1eoEvaWjY2MRzu0rLtnYruRWxW7pdiH1UNpS7mGBbdGs/S120SlHPOjKZVQVjp5vlqPMHVA
	98jg3glTI98E10Nlw02Ho5if2+D+3I9cvbdyGaQYxvv4VRNH3j865BsrUPbbNc8gvdGDEFavR+1
	oGaxlElLJK6mBbSMI4M8ULVD7VH7QwfHvWeD8ZbK1hL5htw7bzgp9fUs+fi5CywDDLIhOb+HgJ2
	Jzrh51R0YOq6jd/eAefM7b4L0qUE6rhIcm6RWJ82T1Dyc8JuBR1cZ8ObyShCMGlMmFIHmgBpOvV
	PIfqL0v+WyKjlA0yuOXualueQ9KAj3blm52nQ1QSaq7TY+b+pU39wkUOP9XClJw1QkXhByB0Lrx
	/DCM/Rpbe5exCNd+MBE8iRwIdTFMRiMXy1xEBkrrZmPpJYet3rfU6ilpQ6Cv30tCHPqPIrDbDAe
	AHrOEMFFgfbPNZR
X-Received: by 2002:a05:6820:3406:20b0:6b1:51fa:3562 with SMTP id 006d021491bc7-6c0bda74b25mr4325902eaf.34.1789136746335;
        Fri, 11 Sep 2026 07:25:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.214.80])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c0996e0f19sm3094797eaf.7.2026.09.11.07.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:25:45 -0700 (PDT)
Message-ID: <6aa40f69.77a0a7d7.194968.005d@mx.google.com>
Date: Fri, 11 Sep 2026 07:25:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8651800564886199942=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: firmware debug event routing and WMT FUNC_CTRL status fixes
In-Reply-To: <20260911104234.2276126-2-chris.lu@mediatek.com>
References: <20260911104234.2276126-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8651800564886199942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1162820/

---Test result---

Test Summary:
CheckPatch                    PASS      1.75 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.75 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      20.38 seconds
CheckAllWarning               PASS      22.26 seconds
CheckSparse                   PASS      24.03 seconds
BuildKernel32                 PASS      20.12 seconds
CheckKernelLLVM               PASS      19.95 seconds
TestRunnerSetup               PASS      484.80 seconds
IncrementalBuild              PASS      24.85 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[3/3] Bluetooth: btmtksdio, btmtkuart: validate WMT event length before struct access

1: T1 Title exceeds max length (85>80): "[3/3] Bluetooth: btmtksdio, btmtkuart: validate WMT event length before struct access"


https://github.com/bluez/bluetooth-next/pull/753

---
Regards,
Linux Bluetooth


--===============8651800564886199942==--
