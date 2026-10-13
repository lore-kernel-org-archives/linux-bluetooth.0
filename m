Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC89D472528
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865453; cv=none; b=Ui6uHFm6Xx1gCeTj8s6Wn1KTYlSNSKVwNqnL6ZZlolSzkUjtnPxddB10BnLqszdwsId6Vu7rKKcLBrR9LeY4vzlvgezZ9u/L20Lq+y9Iq3VW40bX8x03a20I5nSEsw+8bhdEy0RD++GM0+dpcZeqPtASeH681vmhILV1czHzBtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865453; c=relaxed/simple;
	bh=3LAwz3cZ/ycmGPDli3CF28tdAhaxGUoRAsvi0IRPGP0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bw27+iPyKKqVO5780YfwoYltV8FXBjHfUITeJZsf3yhIM19M2yapxp/UYKKwKwhW5TDq13dBrOVOl39Noy2jUNgNAjWSqY1/cuA2/g8JhoSUuSzGxF6p4aKmP+aZmh0BE+VIK7SuXzkVYi8gmHfzxgoGDZuh0qLfVqdAt+ERTig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAfc3+PI; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAfc3+PI"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1566896eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791865452; x=1792470252; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FmKZJ/lrJwPc+CNbboKh15NC7DoIKmw2gUVYBaViBA8=;
        b=SAfc3+PI3uTAd4qa6Hk8liXPoVIoWUJ9nf/+gfkwvfJoBfvBF733KfOrhINFX0mx+P
         YkB0mmDxQPu828WvD2Xmk41/3Ooi8h/mlHIOKhyNYxAYcD/ln0iCXQcvxW4aAG4mu5N1
         dKDWbbjgSBj7TTLZ3NfqU7LNW9dIUJaCdZjMDzP0zZO8J6X2FPy+0huhT6dgPdBtu5Yf
         pvMwvvTHr7ZR7Z3zZYugoSAUzOvYgmcwYth0Os0EW9ALnuhYhiv0NLga8HRLCmL6nyxM
         gH4YGjzr2hmDLoF8JxKZp2f46klW6Bdu9MwtiFhw2ZiZBZqaOnxy/RcLzm1DErgxyVSH
         7vEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791865452; x=1792470252;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FmKZJ/lrJwPc+CNbboKh15NC7DoIKmw2gUVYBaViBA8=;
        b=Ny0aOY8LTiNxK52VpgY4hRAnapbKbn/blbSFnxzLjqckxKPNC+4LgsSlKeCWqIR01o
         RZcenrPBjgVk7EBFR7Tsm7YqzM0fo4I5R+2lt0ppKtfUbJAno3ddsjKID1R3hcpgH6+c
         XNaprExmubfsUSyr1oxnqerBi4Fc+1WcHOQHPB5uEcHmh4Efh4NNMPMrK6o5W/6VOo48
         b8+H8ihshAv/W82gx4+b7uUONzIGzeKl8eIN6aN5I2m4l2epHt74XllB4IxKoUhbZHkr
         TVPyB0j4/R2uvsNRSb+pXuqRV4ZZAMQ41BL3d/04eBc/B7tuuB0H51VAYfCyXsvJ6Uk+
         cEwQ==
X-Gm-Message-State: AFq9FYK0yRTmXbDtCKgGFfy17Jpf7D7hw4vGMHIb7O9rV8MOhRdFqVi7
	PYPLrjYeQpjpIRKyTQv/g7xHgIDe5VJwSw784bUqX+n3BEhbrpjXAEeyUQNvgmff
X-Gm-Gg: AYBFou2bFq1VDnCwSmgkKs6r2dH0i6VyP3BO9b1RKCP0NsmRtcuxjpQTp/9huHrJm1Z
	tNa58z/tZVYl8gYqQm817kRlPBW+3aulQFzC0uuBJpvyqbeAxhU6YsnOwQ8HooAr/gwT/+nZEBA
	5rypwzK+sl3KRlB/GAv6Tu/0OER1G/WJaxLGoP5pEEYhjVtD4VzDOEu/hpOVeiu/Sp6ICnakneD
	Ug8R8XGXmA3NvD20yLtAzigQ2TT+b35nZmu1zQu6kc7/HxnIMg/60NTK3aLFtTojLAf5OL8NN9G
	cB1QTznGMKVxt/jWBZ+vcFMLbxVcMbe07/xJ9eE5Q84zSJpjUlkfKxPuxUv9/EvfnKpsQg2EF62
	1QfPGVYAiXezfvH0VNBJ8DAaHoVErr8ICkSkXbS4C6PJhh1iFM/003IGzITQG8W/wWPoPoD3ovy
	VVaPoaUekGdjmlygRcKJ11DOYhYD/+9qNUFEgZfNcYSsckzKKUl2I63srz6gOPQW6cLUnzJ+qyK
	pLZ
X-Received: by 2002:a05:7300:2392:b0:34b:101f:cda2 with SMTP id 5a478bee46e88-3537e0cd902mr26044595eec.27.1791865451594;
        Mon, 12 Oct 2026 21:24:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.37.180])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35a352d4b05sm19591893eec.19.2026.10.12.21.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 21:24:11 -0700 (PDT)
Message-ID: <6acdb26b.453d2d35.156886.80c4@mx.google.com>
Date: Mon, 12 Oct 2026 21:24:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2961302195418782080=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC] Bluetooth: hci_event: negotiate LE Data Length after features
In-Reply-To: <20261013033452.505349-1-cochcoder@proton.me>
References: <20261013033452.505349-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2961302195418782080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184346/

---Test result---

Test Summary:
CheckPatch                    PASS      0.89 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      22.62 seconds
CheckAllWarning               PASS      26.01 seconds
CheckSparse                   WARNING   28.12 seconds
BuildKernel32                 PASS      23.94 seconds
CheckKernelLLVM               PASS      26.98 seconds
TestRunnerSetup               PASS      528.87 seconds
TestRunner_l2cap-tester       PASS      13.34 seconds
TestRunner_iso-tester         PASS      9.71 seconds
TestRunner_bnep-tester        PASS      2.84 seconds
TestRunner_mgmt-tester        PASS      87.94 seconds
TestRunner_rfcomm-tester      PASS      4.08 seconds
TestRunner_sco-tester         PASS      5.06 seconds
TestRunner_ioctl-tester       PASS      4.38 seconds
TestRunner_mesh-tester        PASS      5.43 seconds
TestRunner_smp-tester         PASS      3.96 seconds
TestRunner_userchan-tester    PASS      2.82 seconds
TestRunner_6lowpan-tester     PASS      3.97 seconds
IncrementalBuild              PASS      21.61 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/910

---
Regards,
Linux Bluetooth


--===============2961302195418782080==--
