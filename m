Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E04408035
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 05:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788500244; cv=none; b=J0WLJKRMNmKwkO69KluPhmScFXFLCx/llYkQaf6idoVXDtzjRRKaJxk5eu6Njf3K3plgL+u/1121yXUtDNfBZgSc24dHcsnmb2Z1AUeneOKYt0N1ULAzP66yaWc38Mvmi2qVnWma3NX93zTYXOV/tL9VqG2JDURV4ApildKOOPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788500244; c=relaxed/simple;
	bh=Sgn+yzAtJeOmPHnzvSGL7pgKqYqOQLTYcQEB6NDGrSY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Z/T0PkjyRuNkcO8TRsIFpnLQBndv22M8rU8yEvJk7egebbPGOelKU1hwcsXN4HEEW4V3zSD6yUwellKkr/g2CsKlUzQIa7rT/k5J32qFvxiZxEU4AzB8uxQ90jkTFmAhdoMKHilNTpbuOEW5Wl9eXOHTcMtldxXJJzR8NAk6rDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrN3Yedn; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrN3Yedn"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f4e6b5bd30so1425202a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 22:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788500242; x=1789105042; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PcxF+DOC5gbrryQhaCrVYvUVxhYC48si/ufYIIzUyOM=;
        b=CrN3Yedn3DjNxIV7rWlZWHE5atie9qSw8+oB3xFf1mNA1tmN4XII5u4jB7UF92zMzk
         RyGd0pTIPnnY6xcOrSwYBbIsyJVH8e6ljSaAfd7z0n5OCwX0ID6wr8nwBfhrrm3vY3kK
         C6AHSq+AZYvrkj0SaBYYBOVmCQ5VXMVcxQyHGZoDOpwjdfDsK7Dezc+Nygy6tvmxeD3x
         72JVp6ivYD1WUmTAp1XmKaH5G+btLyPGLlLlyaRUe6wR7PhXicJNKu7lxoXByyRSPvnc
         4fGEOWLJ+DQdt26p7+LhcAZaIc4h3MkNjtF1mwub140vXlfqQFILS8lmwz8N0KWR9bl4
         +RtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788500242; x=1789105042;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PcxF+DOC5gbrryQhaCrVYvUVxhYC48si/ufYIIzUyOM=;
        b=mMs18+S6dqdMkrWm3ZzbNP29/i6WvUhStpuQ/Ba8Ap+z3801nsbcIf79dKGxdxUYZu
         xJgRGGfvF/Z53puyLaY9+MTaH+jTSOPFoxWsHRuB0f4xudO5Xw3tJZcU5ZPUlIB7F66c
         fLPcBA5goahYNlBW28xJXtXThbpYNe2XinoUD0GLibIIUC/yW2zFwt9eYm2xlXuK07GO
         oGDkZabUO9n81N9hWKbFJadPYpZSjiS9PBbC7h1OCiWmb5uVV1FXAmoTY/ndvNLcQVIS
         FVqpgTOcS5CzlI6TcZ+Aml1Sq2jQXB857Qy7LeVfxZIpjXo/l9a3F6Vi9MucpDCROSGU
         mH/w==
X-Gm-Message-State: AFuF++n55KQj3t9+FRStCm0B1lfJqDHlRUkDvYFm2pe3QDtGldIHqHTv
	3uXPJ/zEpDLD6NIvzzgqmBRu+OgNerIdTdlljjKziwv7VTQcPRcTdMU/kAednQ==
X-Gm-Gg: AYBFou1L6th4yh8SkwLdq8CdEibgoRF/dydJdH/1pp42fh0As1vUqRtPbtzKnMwFF+a
	B/jHmS4px0SqCW3xbcz0RkaFaSN1cEhZ2QccKgTmMc/8VJFcZi9AaPMs6jCBtMXWvH3MsqOZ4sg
	H5m6I9CkOZd8ICXrHcGKzghBmeFOut+gKWXV4wFRSLxcmO2oYaOQBGe1jv9smptX2V8c89NLqKs
	QkkU+hAOfdzqfpX5wcWNtVx6zC8bV5Eq2CsQCzpjhlCRu4GGVgfBa5apEe512KIibpHuQ2jEhrT
	v27K44lkus0T2uoil8gH28pqX1uAzN169fBtdRDYZcAyK2vdZpeax/W6Zj4hLHSbjjkXmNEJ6ZH
	+G2SrInqaYHPs2OzuFkH/4je5oGMxDf8/gYfOnvrW4SeW5IJZcwyLmb6T2pEw4SAGcjJQlYINeC
	v9LAzqmTR3+n6URLuY6ZlHC6urqh1Gc2xUOhTL7C/yOaQvPKi2iCOED9hRbFuJtBQJHA==
X-Received: by 2002:a05:6820:308d:b0:6b1:aa44:fc27 with SMTP id 006d021491bc7-6b71d77e2a2mr1019068eaf.5.1788500241830;
        Thu, 03 Sep 2026 22:37:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.31.119])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dd07214bsm2288585eaf.10.2026.09.03.22.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 22:37:21 -0700 (PDT)
Message-ID: <6a9a5911.60fb82a7.682fb.3fa8@mx.google.com>
Date: Thu, 03 Sep 2026 22:37:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3666824926868874717=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raoxu@uniontech.com
Subject: RE: [v2] Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing hci_dev
In-Reply-To: <049D60B81C44FFA9+20260904025457.3523467-1-raoxu@uniontech.com>
References: <049D60B81C44FFA9+20260904025457.3523467-1-raoxu@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3666824926868874717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157532

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      22.07 seconds
CheckAllWarning               PASS      23.90 seconds
CheckSparse                   PASS      22.50 seconds
BuildKernel32                 PASS      21.45 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      382.47 seconds
IncrementalBuild              PASS      20.77 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/703

---
Regards,
Linux Bluetooth


--===============3666824926868874717==--
