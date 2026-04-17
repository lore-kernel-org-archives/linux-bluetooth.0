Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF7282F25
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776427707; cv=none; b=mJL6QTNdwhe4IL4ZXFn/F6phLKeyBzCXBclChxjlbmKj0KNdhtuDoyu22jITu7kOx0Fl8e3/0tryWsofHx0W0kXAJzjcXQZBF76BVU1fj/opmF5TEdY0XR2vcgGitDHe0Nz5V932LcGXLkVHB/0wnU/zPA+UkALgYvmLqP0adUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776427707; c=relaxed/simple;
	bh=sjkb/GCu3zbDAv2Z6YkKxJ6pKxwInroY3jywndOyFx4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TKAzHbwZQrObnn6+XggiEXlvVN7Ya7JMtN9aj07nafSt/u24FMJsYOCoGKFJMV4H2vChl83hkiKQqpIPM6Coeqy/Ha3FSjynHdy2BEHFvSWgl7dGi1shqEzFLGKtFDGGCBNwexXzI6jHDnKenGXeGHQ6YoOcO+NElvt3arb6H0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVL+daqC; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVL+daqC"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d68bcf50fdso69337985a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 05:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776427705; x=1777032505; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U0Ehf+746bSL8l0crYK+XaE0NH5EmCpRJ7LtItfPCfQ=;
        b=FVL+daqCOQosC9ceLH74GfgQCNjmUsSX+BDl4XqbmXQSS6WfzExI2GEiW3T8svtDxs
         gJp9qgqkSfXUiVBJElA1UjdqcB1aUSG/+9xw6w+IGCeSi29Mz1NaoVblEOme2zRwQKUu
         H+MOMJUYaIR4MIUePgbs4iNBEQZJUbn1WkBJvfH/zowRHZ/lqwl2v4RZlMPvoJpuJGyu
         e16W65PHo6C26m6Wz0LdUR/S4JD/tv6TyV6EKXN4rfKb6Oq4mTPae7JnDgsTVVY2SCwH
         G83UsgHYrtjeXJQ9tq8Fo+aswp+t36hcp44AalvdYIC34RKgsfKyJLFyp0J6SkVFbyyJ
         jTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776427705; x=1777032505;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0Ehf+746bSL8l0crYK+XaE0NH5EmCpRJ7LtItfPCfQ=;
        b=q/++TFlSX0stE2gSdZG2kWYmjDp4DqVycBhjf+yxcg/Dh62MZPqKZ4YiYtNE2mgkbG
         uNOZwZx7KZOewjNzHU4CJkixxh+EuSuINvVi1yJwvYuqzvHHRcGWNenFXuReh65X7bd4
         SuWnbCgIPMtN622wQmTzy4u/jmI1Sy4hcsmdBHxJtSTuo4Nq85drqBlmN2KwmdXJ4cBW
         PR/4UN38oYrDMx2frNaYivEQx4saxH8UaSqL7esNIDFioY72fWhaAV66oTZQjmtnvBnb
         gcck8S9l2X6JDHjBSTIVYdcDo+tTrbjprAp9Ic893WXB15cNNeS6Ean4NXHiNp6f/wZF
         68vg==
X-Gm-Message-State: AOJu0YyavgMUH3JDLHjV+AwOzD4cW/uur9hhdJ7WMrrADWVnuEpFFwyV
	jmuHq6kq20jIEjHimVw87CVnD6Od5lAxrhU3CACuSYyPf+arKm6tl1wc2m27pg==
X-Gm-Gg: AeBDiev6notTWHXInPE+opysB17a9AIQYEQz9NmaWWhuR0Xwo2vG0tfvS12DBFjAi8N
	5VvEP80ycwkGj7o83nVOxxq0pgeZv81KkSvA3Jn1CsU0zMs3uttlByYgz2cV+Nisxf4KxTe+Vym
	EF9Fk5bNnC6iALN5DrhTyPMIsy197jRZurUhe0SBxG0g2wahIWJ/edF20IIA7X6tc+9lOCdfSMe
	c+ZqgdTwWsXQu2sjIITaPC/sBikWu1ETWrzxwWxxrgbU58vxU7QlhtJoFBXRVIsVBt9IFHprEuA
	4myfBn0FuFQLb+220/tgIdijKgr4KOyXAuwwCf45wiALiK9eAz4XSqkkJjCnB0wiKKFNtz+zBOn
	X8aHoxqxZnBVRWHPBdoAJG6lzP2MKIkLcB74OtzARVx7XmFF/YBpQp8uUyR1Cm8X3RO/0zm0P59
	5U8+5CZoiqWZo8DIunE01RvS20SeIJtKwNGCKIk5o=
X-Received: by 2002:a05:620a:4013:b0:8c7:139a:bf48 with SMTP id af79cd13be357-8e79236e343mr331849085a.49.1776427705245;
        Fri, 17 Apr 2026 05:08:25 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.54.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69ad49dsm113606085a.18.2026.04.17.05.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 05:08:24 -0700 (PDT)
Message-ID: <69e222b8.050a0220.1e8036.90ac@mx.google.com>
Date: Fri, 17 Apr 2026 05:08:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1980794307337320204=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tristmd@gmail.com
Subject: RE: [v3] Bluetooth: hci_bcm4377: validate firmware event length in completion ring
In-Reply-To: <20260417104639.2608008-1-tristmd@gmail.com>
References: <20260417104639.2608008-1-tristmd@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1980794307337320204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082469

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.35 seconds
CheckAllWarning               PASS      29.94 seconds
CheckSparse                   PASS      29.01 seconds
BuildKernel32                 PASS      26.57 seconds
TestRunnerSetup               PASS      588.93 seconds
IncrementalBuild              PASS      26.60 seconds



https://github.com/bluez/bluetooth-next/pull/99

---
Regards,
Linux Bluetooth


--===============1980794307337320204==--
