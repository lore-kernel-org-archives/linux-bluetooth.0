Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449C30FF2A
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 01:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790385080; cv=none; b=PsM6D9AZPXzshoovehKR/5jhLJBOTcz/4lp9dKF30xQol+HBMA+JtabG4OBoZTp5/fYkH/d0z7kUYS1QJFsdFsYEoXsXW7ClVdCuXYyHhT5PVkOKHM19N2t82I2uKucLuPvmtWfjBlHYLS1y2RqfoaW4+CTlSRp7lusimxjrD2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790385080; c=relaxed/simple;
	bh=H8Hs4gq94DeKTR14AW0MuQ2wd/5+Ium9i1uPBXXU+FE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OM62lHQgO4X0K9G7jwLFVt2X2jBlMExfHDgiumzOBFOoxmWWo1AA6E7kr5XStmU/NSbn4zd5pLwNCnEEeMtsRQSu0EWFfTioSn4Tq0DjYOpMh9ORQGihAJ8gDKgqCj6xzUTgDV1noUCogIJqumjUY6nliBAJGCeMJyv2fomBgzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kN39BWHN; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN39BWHN"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-486e0f56cddso702956fac.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 18:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790385078; x=1790989878; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uGlRNaG+KpPuWL2qoR3TQk4h/hp9/8QMXTfWFVEVCaA=;
        b=kN39BWHNx6XxvU00D+PRi93A2+3jpqmiaKrhQf1VPxNwkL5dUBzPzJdM9eIiqGLHra
         DNIkH24KIZV8T/uAOVH+jEc5dBeNRkN/C5agagRITwTUYoiIuV14CXMJJfKmXB0CRu/c
         byEb5r0+STxlq+yTaFCtvK8ry9i8i/rgMTtujIk6RvP+RB3FAI2jOMhDjuLGMkw7K1rd
         +BUw7uA2w3S58XCO2e7zpxhNhCMgkTJTYa9YQhY95xheeqe2ysj39edg2htp8y7PbtLb
         K/U6ew4yxVn84U5sJV+Ln5exneuud4632rGTjySmMsgXG2dFOBqPq0g1HJvOFLZLwMGQ
         DFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790385078; x=1790989878;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uGlRNaG+KpPuWL2qoR3TQk4h/hp9/8QMXTfWFVEVCaA=;
        b=JKDfNmgZnPQtBo26G5uktuRkPWlcUfP6sgReLygfAgrip/OKeNW5NIiz2nAXB1Bl4H
         b0JYTKKSRftMqSFEqiGoAwglpv0PC5RqdtoAXva2uA5cBpbl3vgSIqJDwFQHkCZnlyg8
         lkyTo7YmyWKeUIgDtW0ne4CEuGBOMpcXgPU87e2xyOBqAyFt47qzmjge+Xgz1oWhl28H
         We4WjmtxOy5KrB9xPgfdG3eIVpaom3FhqvY5slZl4gDnQid5txGS4PF82FvTna4eNGBT
         JyVlp8K0DTlVSTs8qiSi+fjsqbabQGzFVd8pgURDFXrPziHO36AOplxTlpsRxtSvo+Ii
         KOGA==
X-Gm-Message-State: AFuF++mer26RFGPX+c7TDiQMsK51dQXO6BCQbB26P1n+krgIniEfXINF
	TUmvKlZmGxphBcc5iKehNxpS7k2lPfPaxalspsgYAzEH/wUkVvBHbBs6L7tQN7Qs
X-Gm-Gg: AYBFou39cMqW1kvoH7nbphLMIN8tbRwRBG80oPyBHW1W+XiEIB2Sk9QeXvoB4ZSkypR
	BQoL7kMsN1QicflpSI4HFL5Ay3h1jzclWWy/tJP7z3T5QJJq3c731tcoMsZ1TO5DR/3x6zs8iKs
	NQplIDKC+MI7tzpGenTMH/t0FxbDns++Gz2jBJQ3/gfOBUoaRXXOyK3MgoB+uTErlEH/oEbQj74
	EX2t00bn4ZIPfZVpIEAwXSr6Qk6r0qRJvfWj10iaaJYOOdZTU24+NLvK5arxpqWc6Kh8UEe3R/K
	CP68OrQGlkC2iCgzuBAPcR/p92BdUk6ilowAObiODjPd8ED9pCi5oyIHr3KFjmuvyR5Er6O71BB
	yuV7bNjF9dQ5TOVULRnFiqaiJZAZzho7u/6RwpzLHnZqbKv680srim+598F3lD9ubr3owDfg0Fg
	mpoA+d/UADwjo/KnFsFX6OTbOKQzp4ZyA7XdPzGcQI9OYyEypbN4/vx6obu+kLrL3jpOMRAzPcp
	uraIA==
X-Received: by 2002:a05:6870:e456:20b0:493:bd68:526b with SMTP id 586e51a60fabf-493bd68551cmr2110930fac.51.1790385077888;
        Fri, 25 Sep 2026 18:11:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.221.68.246])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-493364b4711sm3994111fac.16.2026.09.25.18.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 18:11:17 -0700 (PDT)
Message-ID: <6ab71bb5.99d0dbd8.144d65.00ca@mx.google.com>
Date: Fri, 25 Sep 2026 18:11:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2972761658001309977=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, caiyu7372@gmail.com
Subject: RE: Bluetooth: hci_intel: support the CcP controller (X1 Fold Gen1)
In-Reply-To: <20260925234043.707679-2-caiyu7372@gmail.com>
References: <20260925234043.707679-2-caiyu7372@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2972761658001309977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1174141/

---Test result---

Test Summary:
CheckPatch                    PASS      2.74 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      1.20 seconds
SubjectPrefix                 PASS      0.41 seconds
BuildKernel                   PASS      27.88 seconds
CheckAllWarning               PASS      31.58 seconds
CheckSparse                   PASS      34.51 seconds
BuildKernel32                 PASS      28.01 seconds
CheckKernelLLVM               PASS      33.04 seconds
TestRunnerSetup               PASS      722.80 seconds
IncrementalBuild              PASS      32.88 seconds



https://github.com/bluez/bluetooth-next/pull/821

---
Regards,
Linux Bluetooth


--===============2972761658001309977==--
