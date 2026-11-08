Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794104698;
	b=wipMKRu9o+M+vA0mzwPgIvHeTGLg+DvREwVafJblPv1ejB81/Itjt5QvmlHNuAoqkbTf
	 TFCnSnj/b8EQD8AJ8OpgIBEr4qlMSPfYfAvfNPwC/onRMUVQE0g8Ryb+Da5mLwrdXxe6j
	 vV4+vzmWerYmTX33qfdn8vLJPE3hDvwvcm+l7/qIZybHIiFzH5zuztZvmK+7BdNqSHuTe
	 cHWfO4Q3TdaleOfXQonBAtXMJrVPtqgr6QbBsMvOhPpv101mQ9E5MrMFiuw4X6VOI5Isf
	 GYSO16Kkwk1I83A3frSg/2qNsx+VDCNeU8Cpl4NEKY5ItQqRv8vaNgc587L6ti2SdJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794104698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=6VQSXMHBF/7d9l4hDf/IKRCi5MyedcgD0zyX09Drsbw=;
	b=5dEKMr/a/2z2As/xN/4JN9JtjgsW0Py2I7H88IXUp0F/7dVikxmCpgfNjZszStt+0fvI
	 MLCZE9Db9l9/dL42Isl2fF5fQSFpbVY++Vzl4msASgMFvzIvlBKN5G5zN1rAJURH/eZAG
	 tvErDRfFE4KEVJEI5p3MElK8KLk9072B7qzXJV/SNLNf0zR3Co6jntq2f9tGYA9CIT3uu
	 e9TaO+QxvkE0/WLZPan9080cG8Me4y1JOhZ/RX14yK9vr13qkdxJp8jm+ks2+Z/Rzrayu
	 bNrAsg6tMm6teOHPvb/Wp9sWsnS4tcsBk3dvio9jxE5S9cM+asFw1GXeWaze8pgLFjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LH53hlK0;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AB1606A31C
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Nov 2026 02:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85AB1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LH53hlK0
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91b52ba422cso1298086d6.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Nov 2026 18:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794104697; x=1794709497; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6VQSXMHBF/7d9l4hDf/IKRCi5MyedcgD0zyX09Drsbw=;
        b=LH53hlK0y25t6RGBpZbm5NyXbKwdM3txSMC9usNJ/wCnt5wwC6l74Qu8KTXYf65THd
         iCQqRV60EFmf2A1bim8AYO1/MvQku5Gv5m2AcYoEDNiRxboDKGnLUY9NzM5ecffZfKAv
         5fGyDya1M01ZVYBEXUDuSuwgm62nFvCm8celNXcL7G1MwZSu+seOAmO3rfgMItTohUqy
         Qh7rQ3xODsWUwP5zattZgx9fbaD2oW/SBacTi2SrEoxmYW3ZwI916n5wvKYeEza+CJE3
         G2Ts9oaSA+AFVDNI+Ts0027AsR0mIzKvNNWdVVguzWH77b+gJrwkBYl7bmJ+i8c11s+U
         mQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794104697; x=1794709497;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6VQSXMHBF/7d9l4hDf/IKRCi5MyedcgD0zyX09Drsbw=;
        b=IdknQ6bsYh/v9bLMNjfjdm1Lp06Jzq4Reh/K6dqObwhwNWAFoFtK3wkn04cmD6pGYT
         CdWGiz963eZDM/3SuZd6FT+LDwft6INvreuctV6vvrRJBVt2s3NaHlH3hr/XsWS9NHd3
         b5cZNegOLuxNVsVsU1AlS0kOuxj8S4PNKeV+KBSrDUuLRh8peFhmuoXbwfK5auBEq+gj
         eZCjWxgt7HX9Uwy0wmROcobgAjVkEoot2gk2M4DiSAtRlNE+Y0qf4u0VrYIjTux/NiD+
         eEXHDXiL5gjNurK5rVsX3N2IFxFltbaYQ0w3D/8xSavNdMco+HaeY3Q/dTozIUdtjrnx
         qZ8Q==
X-Gm-Message-State: APuU4Z9ZrZFkSuKtPqReVakzfLwV4aER4EOKiGsXgU3SjoxGdTxpw3NP
	JjPG6L9aN9B0nxclEc0S5J9dw3EDTHDO//ezo39oMOC+wX9yFX0rYxNHFgjiNA==
X-Gm-Gg: AYBFou17jPmuDOGxiKwtn4Exol/jsdO6+Fh9Xf2RDZGrsSRZkh3KN3ZcAxIgWPdunfg
	6viTTNmglECHs+bfeyRfmuVPuOr5ThIhZ38B70EX4d1oA0mTL7DxwqohgfoTgihNHN8a/9V8k47
	uOkUkAyD7RLNmJKGhIidY8/Qr/9I5oid/Ybn8So2OQNRnkYxfOqnIuyEJ9meN2Ujd7xhhlUcsiu
	BXjW/484Xza8BpQkuCnH0hk9WWpTIPNPKUDrAMuCujFSStL5DAXTfu/6gnlKDFX1xLwYWdsKKlL
	sLo5AYSS6Ma5pUI91shGRlatAAjsWySiE3M4hUBhRolWnj1EHVmoJPY744/nKPHY9t6aDCYG74p
	kvG+kk1Q2VxTaIFAXsaoQreADhKEmhoLimVOMXOEI8sB+gwU/hYc462r6D6dEF+4BrGextppysC
	zhMkbjbo3Vj0ZM7Rhnud/KUuDjX/bY7UCFtVf6lXKjfB/HKzJW/6hXl5nv4+jOQGVIlWHMBRq4F
	NvmhwFLUkEPE3Hv6mx1hhAOzr4wkAtgTo4eBERtK+ROqn1yi/vcJPrbyloT0hH0MQ==
X-Received: by 2002:ad4:5f86:0:b0:91e:9230:6430 with SMTP id 6a1803df08f44-91ed24a02camr3235256d6.40.1794104697529;
        Sat, 07 Nov 2026 18:24:57 -0800 (PST)
Received: from [172.17.0.2] ([172.210.149.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ecee04e40sm7836766d6.23.2026.11.07.18.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 18:24:57 -0800 (PST)
Message-ID: <6aefdd79.02abd67e.2423b1.fe94@mx.google.com>
Date: Sat, 07 Nov 2026 18:24:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8387087403638203264=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hex@freenixos.com
Subject: RE: [v2] Bluetooth: qca: Disable SoC debug logging for WCN3990
In-Reply-To: <20261108000449.2664455-1-hex@freenixos.com>
References: <20261108000449.2664455-1-hex@freenixos.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8387087403638203264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1205155/

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      23.24 seconds
CheckAllWarning               PASS      26.59 seconds
CheckSparse                   PASS      29.32 seconds
BuildKernel32                 PASS      23.51 seconds
CheckKernelLLVM               PASS      25.54 seconds
TestRunnerSetup               PASS      547.27 seconds
IncrementalBuild              PASS      21.75 seconds



https://github.com/bluez/bluetooth-next/pull/1087

---
Regards,
Linux Bluetooth


--===============8387087403638203264==--
