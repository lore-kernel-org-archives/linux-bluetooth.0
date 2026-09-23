Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2202233149
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143884; cv=none; b=EIf92SGGyEP+8HE+wEsun+TaGPr2KlVQUz3YrJ3W6oGSIJC3L5rQeFc4yYSbGWLX3ECO/KqOmNc9OfLj7SusN/bznDuYlnBrVvNNmmjJhDb2qqUwmdM+jD81zMNR8/XlrtBnvHeKyCQWqNvBCON30mOrDIF0T7YFcfAOBahvWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143884; c=relaxed/simple;
	bh=auB5xpnOGmV+oG2/Loxkdx6u4u/LBKBNaCpPoE5h/D4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hoLTMy2/9ldWDARVsyKjQXBpOYtdpqp7ZbjgaygqMB+HiVhl7pJEqF41FwZ+e+pTu0rh5pi3dUX/Riscl69LNItbak5wxkaz4gcyODfo27bWazH2n61ckFs7iCepKH/aqdLVggbLa91AvpOeccMSs1bPbuNH1LS7vWRHIoW7kv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnD8YhH0; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnD8YhH0"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cc46c8so83071385a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 23:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790143882; x=1790748682; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7GupjMxE4c3JOF19v9RE4GBBn7VZKZrRumJJYApP5v4=;
        b=OnD8YhH0ReVHXe/whqCEwI3y8Kfo49hAALbj5W+txO6ATQmDBGWJLyC/2hJR1vBa0z
         A0pwRgPurTkKdNOnb4VgHdrGCkrlja8iCgq/De+bPjkllNhoD6P+A2BiFQgync/8vM3K
         /75p3Md6KAWdaAlqdawzimkLDkAzYCvm2uToNFDIQuFuIjZMhGQv04wTq7M1iySosXdM
         Jf/1QIYbkMIcJ/M2IceYv8jywGlkXe/9lKxDoegmBt6yIA4xkujTi+s5ryZ8km3QraUl
         NEoeGvw1+3H6mmL043/kklIqJcLKBpTnfqdIQFABX6uAjQaStqSgFg0hNiqt552soEl1
         vb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790143882; x=1790748682;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7GupjMxE4c3JOF19v9RE4GBBn7VZKZrRumJJYApP5v4=;
        b=zWdSLub+/D0Cyqvpt+9tqzof8KEF496KPTMOThYDemtA4akfXJJ+Ya6aqqaAMOyAhC
         Y+wDp/3YlvJuX1haxtDIQFyMjky4n8Hj8QcQm6K1AMBNMLtKQUAHjp+f929wFzOMaqc1
         s1ivR3G8Y0jHIZv06YNO89xcHWItRKnd/lj/x8U9E39ltkdMG0CliCavAcfJIhtpBDWl
         NF1FHwbK3HHTdMOAsG3fKzSJNYoxUnfjapyj0jVY8NDJfBSwR2j0dMJ2I6h4z4iFDmsp
         d3R+A0lVsDobnsAO7qSS7RpOKBOCz2RasuR7zFiBoqH5/QDFwg09m8/Iqjtv2J5zq1+b
         jNag==
X-Gm-Message-State: AFuF++npTiB9A5kd2dk2WuLW8CZ9zS+W3QgVf+vxsaxBPrSH7lqq8/FP
	QRr0iS8M/LKGaVjXbZzk6DZK8UPp1YJk0E6jVleuGw6VOB1HN9MoOnQmj3pGc6sO
X-Gm-Gg: AYBFou32RY8mxlh1PUU5YmVr6Z+L4AWKA7ua9mzD9Y1+tRsEOQE0EpRALtCOXCI5JoB
	9Tf2Op4dKco1RJewtTPGX6n/jbvAKvPQUxTXT0ssdZcgMII1qRYvpvcH20VA8knqacAK4E0Uy58
	XZGXlMVEM2izTlvIp5WZZbvIqomN2QraJxBTlEPEuvMIfoWeyN/i8i7Vb5FLcRy5nk1GTFqP+X8
	TwZu4RRn4oQR7RMkw7xA3+BVj1c+K25eyNfTbMm2kuoC7LKmXDisTSuzmIflYGuSzFkUNiXCQ+Y
	MxllZGcyachcrA7eqwxJWuaUOiBL6CkQ675nT5yhDrOz/u22xQc4LQUUTsnfR3pXilHIVBc+fao
	3Q41S1DH6ppexyOpsIUpxSE7+IaTcnO3LLFEDNc1dxfoL5pJyXQWCDYvwD6HR+ktfgHKhPCOSzU
	tH+7+KnKb741tcGYYhbh0nn9GSVieADc6Kr2W9yGtA1HNwtU6C0TGEbVabGeepUkUjFjeFusJst
	7aBr36bIqyaCAoisw==
X-Received: by 2002:a05:620a:269b:b0:93b:d7a0:d9e6 with SMTP id af79cd13be357-93c25236c3dmr256120085a.64.1790143881771;
        Tue, 22 Sep 2026 23:11:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.214.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c247521f5sm159970585a.5.2026.09.22.23.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:11:21 -0700 (PDT)
Message-ID: <6ab36d89.6ccac100.f6bb2.45e9@mx.google.com>
Date: Tue, 22 Sep 2026 23:11:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8125018033068117944=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: [v1] obexd/pbap: Fix u128_to_string skipping data[4]
In-Reply-To: <20260923032957.4133667-1-jinwang.li@oss.qualcomm.com>
References: <20260923032957.4133667-1-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8125018033068117944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1171825/

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      19.55 seconds
BluezMake                     PASS      376.17 seconds
CheckSmatch                   PASS      293.19 seconds
bluezmakeextell               PASS      95.53 seconds
TestFunctional                PASS      1104.66 seconds
IncrementalBuild              PASS      377.54 seconds
ScanBuild                     PASS      1158.87 seconds



https://github.com/bluez/bluez/pull/2568

---
Regards,
Linux Bluetooth


--===============8125018033068117944==--
