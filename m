Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7151383994
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757530; cv=none; b=NGtdm4WGknmSWoYZ2qNLs9NE8T4sPnIKZvn2ZMILOEns9kK0+Cdl1yYkeadF+cbpGnc0PL0huF4lliIa9Xq8Ld09Ax0o4gOeB5D9pUR4sQwQqza9XnQ5da9sCLQoRTVddOFwBk5Qca8ZFFvUnPFvdlxlpdP2JaNOuLFJX6+OOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757530; c=relaxed/simple;
	bh=ezmFiri8fcFKBptu9AMCcMehMw+0kOZBvZdoIXQC66o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Qd1Ol8aWfBslFdcSRMCCa9+OjDrEr5w2aMcmq4asQa6DbdJwfWQRqw0uoLiUcMxQJ6q5DuOwkySPIVc4z4+U1VqxG9LJvyoV8s2+ZipJwSCQt7KrK5AeFfONOFtvjAqa9MgQSfq+EQ2Ne/2JVSvm7n5bIKbvnmngzeFXs++TH9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAh4b3AC; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAh4b3AC"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e4a4a46eeso121274985a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782757529; x=1783362329; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wfONHVsiFoqrFpbxt0UtBrMD8/BVnbHerj8qpqrNTjY=;
        b=KAh4b3ACiASFyXfDQlRokoKAnLIBBGJHG/9w6ZGJvUOfjehLVXeo3jG1G5LnEgpSti
         +eE/en58dG+RWLu/PdYxz8FQ+xKYsM8LdhnaD50fzZG3QXmBt0ZCc25gvNhEQYWqq6v8
         1yyfygt/v17jvxBRlvWgvPCWVQc1nytlSIwq/mCRHms4LZnXuLj+pny0/nTDbVNzghBu
         7bdg8C+XpTTQjcQDHxX6wexgxNUlckb2NuyUz7bn+40khLUt+Igi/lZs5QRgIhtuxzNa
         Wi8CVHlR1vVrCAFY0m1T0YZU+10UIdMd+7+zDRntfruZYG+M9hfVFVmb6WbhQVf1cXB3
         9RIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757529; x=1783362329;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfONHVsiFoqrFpbxt0UtBrMD8/BVnbHerj8qpqrNTjY=;
        b=HA6K1vsZCcIDriW2CLe2aqVPVPZiZENdI3C3SnGs1CQTMTRRaARf4jcMuIDdD/eaH1
         s8lqwN115WKVg6dspt3P1pVdbbVzwEDbrEMKttBFyKk3v22eHdf4wev0q9iGWcPxZcS5
         FNZ0jOnV04uFmjvN8eDwk7fEiaDly+Cav+sjRPckWA/KNX77PV6nvHel+zopqoWrxDJz
         /AUHOM1xmePJO+RN54TyTT0TiiYhSCdDLRMgXpHPEA3nhy47TTHUiPZ5oxw3ZjpigUhR
         ynZ1uHUqLt9gMQIoFFWXeT4dCdhE1GvLVxKVxAyM/cGAU/66DCQCr/zNU2MOMQvEG/TU
         XFig==
X-Gm-Message-State: AOJu0Yyw9XnLnX6t5N5iGrrirI4/38aMlsJS9nBM93kxfjRadtbKYapn
	fuJ9AvFAzBZ27JW7129NzrTCNKhNocYVLE2JCyAg+6lCaKDG4/6jnRXZEueXlw==
X-Gm-Gg: AfdE7ckdr981w/UR1HBhyhOTQoE1SNAc3F/fBLSR1YimmoIqEwYL9f00XhtF8sgWpIz
	A/R3yboazOfeQPk9a8Pd+EWkrH7rgTKSKyzy8SjS3hLnJ4BwyApNHYiU48DlKtixkXn1jJk+8d4
	2WaiANWGGGATBjrAiD3W9+U+4ttZGrvAMFmzIb36igYyUjLS8J1dxjQqwtxTSco02UN0nfeiN+M
	uaDZgxz0Mr7TTtsvtDoq0cWi5L1DQkBzS9lq5Voq+RSOyHNYmqpaAasrcHV4Gs5L0rQZH9xP5zx
	4FdW+RKQxU+xPbMSOcmIqiIooXz98nXm3HE8w/luXrYGBcnjoz/0yaEwTVEFzimClfQnd4fQrte
	cm4/yrpSkn0m9g5u7LS6x2El05+Qgg8YDTdevAArfxFOsjgBnJpXYDPKGrVTexjvKM9A/Jm6kxY
	uXRym5H3665kt2JmcqTbQ52Zcyt6FLaQ==
X-Received: by 2002:a05:620a:269b:b0:92e:5b86:672f with SMTP id af79cd13be357-92e63321218mr60054485a.23.1782757528669;
        Mon, 29 Jun 2026 11:25:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e62371ba1sm42647985a.42.2026.06.29.11.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:25:28 -0700 (PDT)
Message-ID: <6a42b898.d5c1a6d7.362c9b.fa70@mx.google.com>
Date: Mon, 29 Jun 2026 11:25:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7580875209347938155=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, i@rong.moe
Subject: RE: Bluetooth: Properly disable remote wakeup for MT7922/MT7925 on Ryzen platform
In-Reply-To: <20260629-btmtk-ryzen-remote-wakeup-v1-1-1d2f1cee6d22@rong.moe>
References: <20260629-btmtk-ryzen-remote-wakeup-v1-1-1d2f1cee6d22@rong.moe>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7580875209347938155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1118363

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
VerifyFixes                   PASS      0.30 seconds
VerifySignedoff               PASS      0.32 seconds
GitLint                       PASS      0.64 seconds
SubjectPrefix                 PASS      0.32 seconds
BuildKernel                   PASS      26.01 seconds
CheckAllWarning               PASS      31.31 seconds
CheckSparse                   PASS      27.46 seconds
BuildKernel32                 PASS      25.44 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      471.00 seconds
IncrementalBuild              PASS      25.49 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/372

---
Regards,
Linux Bluetooth


--===============7580875209347938155==--
