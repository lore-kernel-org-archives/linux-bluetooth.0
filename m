Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3139649252E
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732162; cv=none; b=L2A5Quf20QLa+S8v/ZOikC3Uy6/aPDgBtu0QKEv2G2nvaPh7VIFkkQbFlr8ZnpHyHFcY26Aki/l2f2Rp4AsB9n48AWfmSlLIbe03ddW8jDGdFhsYQWSB8E3tZhO+QzLt2NkO6nHjHQB5XtBmEZO0x7eyf2ntdqxxTig9K4aqpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732162; c=relaxed/simple;
	bh=FbYhJxNwuwI/GRLS/Dq34SFW3KR/KAsYv/U/dtOinI4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dvaRsltKH6FAlpbj7zxmWJU3jvSEPB12CxyDavYzLx4aTxElE0oVus6/Al1C9u7Mz65doHYO0Ywkq/f/Xn/MWTLBbLKJTpKKgiP4DliZLchoapqYDmGfb7NJr3VLBufnrYYD1YLYcsHMIIxf+jd7CxSfubXeM0+t4D8dzvkGZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGM5F+iE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGM5F+iE"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1882819a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786732160; x=1787336960; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6Rrr6dR+gCBYvTA05mXTQKAhtHGyxo3JoX+rwLUD0CE=;
        b=LGM5F+iECVPZRwJPrESJz8tuGa2I86on9z0zlltx7wciyCsIOXXnx4DUkY7qrwz/4s
         lfRFdevkDPxGLRLdNGWkwDUWZXzANnzVDUfS1NcTCYe2X1ZdnnBQBVRMBY2dBrj0yeNw
         DUCX2w7OgrsLLSUWyYE8rOP8WN0jn5qQ/jFGEDY4Mk7M0QyF/KOKZpjev6anGFEJ0Jfa
         7pys/HqHKznfPqw4YxtcuhOIpJtuiFlEVdd8kb+7wKaebzUFKV0D1uI5drfC3MyS4+/x
         VRnyYJ+sJkzfl97mGJEUui0fdZ2a19sFCqlG5ibIMte0Grtq2da6PW2p21hjvrK+w4Ht
         7ERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786732160; x=1787336960;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6Rrr6dR+gCBYvTA05mXTQKAhtHGyxo3JoX+rwLUD0CE=;
        b=V/dB/upLn1PlJTTNYKioOlOiegkibFtXpvc/NXO2l+3/GyTGz1/NrL8vkQ/wOQiFsb
         DdqL56IYu87Zx7SLkOoVWFkpP+rhmJujfxHzkszC1hUkNZRfc8cTuXwKm986xa3m0/ny
         NQC1WMb56QwVW1OsCLYSmzmyl2ihhvlURWbkuN9CejKZMuIC23FDbvLj+Fq+1vNAbl7x
         EPH0fqPnIkNca1goNAtFE0NANsgW17Rdv0nUavMLcQclk2sWvsC/mezK6AszYuhyv1To
         sCTu98R1tcqg11PVlaKc8ZAHwB4l3iNX7l6d/PWkptJiDIzGrvzjIvBSPNYqPWPzja9b
         ltPQ==
X-Gm-Message-State: AOJu0YxWDTevI+3nEaNualpLnd6gfUyB8gYYbdT5MPBjq63dSve0vYnp
	DpbQyD0rXW0iXm6aHZRx9D3AbnzzVNqkWcKv7Kiya7lyRqsjnbrnZDf/S8UVhg==
X-Gm-Gg: AR+sD12PyF3mvoy8d2MflXlA1x7GLIry0K4qOrdfesYujAnA734/6hlN0+GCoTvDsoa
	Wc8ZCkVmNw4LqXf/tQHNhbnU/qjJSuGECtYpumSFRz3WBpydv59OdmiEs6v3CabSPzRtmMTmLeT
	b/BQMruP7XSqcRj1vYrgustQYO1s198W/A7AJgl1cu9gke0dj1OIj2sNeDaS8G13dKCvD1sPBMT
	KTUQ2hORBdtu7WYFNFVZlJpfaI+FzWfAe26y51LE23XoGXRdWGFPQ7wlr9rnxyoQsXE9AqvJ7J8
	3epEq13duwGJY3DRXKIXHsQMGq9oneiOeaTZTDeO1bMNbT1l8FOLmSuHZ2xlT/XLnVjpAAdJbsq
	siQ0HiL3K3/jgvUAZIoZtFyXrzwhiVyoRGRsQ4RH0ZuGrwiJiot1HC+03GW1anasSR/98kA3QGw
	wUwxvARsk3Xc22vUXHcBqttLIF+YvvLSTRbuHm4m86mBYXV7SHg5bgN4M07I0Uha6G32wCFBOPr
	cTR
X-Received: by 2002:a17:90b:48ce:b0:390:b41a:b92b with SMTP id 98e67ed59e1d1-3933b6d05c3mr10009567a91.4.1786732160200;
        Fri, 14 Aug 2026 11:29:20 -0700 (PDT)
Received: from [172.17.0.2] ([48.200.98.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eaca8e4fsm3519587a91.12.2026.08.14.11.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 11:29:19 -0700 (PDT)
Message-ID: <6a7f5e7f.9e083835.25746b.c1f7@mx.google.com>
Date: Fri, 14 Aug 2026 11:29:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7563869551255332946=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, acharyalaxman8848@gmail.com
Subject: RE: Bluetooth: btintel: harden version TLV parsing
In-Reply-To: <20260814171503.42684-2-acharyalaxman8848@gmail.com>
References: <20260814171503.42684-2-acharyalaxman8848@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7563869551255332946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146215

---Test result---

Test Summary:
CheckPatch                    PASS      1.77 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.60 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      27.89 seconds
CheckAllWarning               PASS      31.18 seconds
CheckSparse                   PASS      29.20 seconds
BuildKernel32                 PASS      26.92 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      510.91 seconds
IncrementalBuild              PASS      30.52 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/583

---
Regards,
Linux Bluetooth


--===============7563869551255332946==--
