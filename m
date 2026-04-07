Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA230221F1F
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561469; cv=none; b=JYRhW2VEjReyTWJq2+XCJq07MtSXMtmbWNbM3rGUB2eIqG8ICxoZiXu6klo6LmrDhHsIX2s7Q0bEXh2wYlHkPhZzbd2p/E61Ry/ICepbYeJu6Ik48gaZtnZkamzdldTgXDuIRWu42PEaMIdLpFESLTeDjL2HAwXUKgCygg/MFDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561469; c=relaxed/simple;
	bh=i9QFNoCDQHVkSnBwogxdSoH8X9DK+mESejtWDpQqvMs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=r5MUkeVDNM698kHuI6Gue0ADSvbbVAsMQEniGrR/fPfV8KD2nkiixdE6Tx9iBsQH6a2FYfqYoYizB9bkgqRRel3YVhkVxBykVS3vhkQqnmrn1yG8plVvj4b07TiRyW83qilOrd9qw1QMIQ+Ri2SJAeAiSC/h9q/rmKsdIrxKLHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+OyLloL; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+OyLloL"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8a093c784b0so70423516d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 04:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775561467; x=1776166267; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i9QFNoCDQHVkSnBwogxdSoH8X9DK+mESejtWDpQqvMs=;
        b=S+OyLloL+h1mgIQ+rV55m/CqCur1iXXJocJhQPE2q8Pr7Wj9E+dGef5BuHAt3zCKQd
         dTXuDcyIxWkFUkNp3nn7kROQFXRe0asB9HDuE6kGOOVKDQa6+jzsWF/l5A+Rn0pSaUJv
         XJSmtncC/domXXpPijWyMPtO/E+l/KVf6vgxz9RnDmE2z2iAEBQdIAJk7CODYmuvdWFu
         AtWAs0YKGBEF+QLm3zMOgFSlhSAMCJH3+qOKGZdIsCT1I15U9qoyilkPWJrMA8GZbdhg
         RiPeE/2RLJsDDB5UCMY87fpIyv4/kXW4Pp8seWGMI82aRBcAm9BiGr5w5f7pYVhDzvvB
         0hXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561467; x=1776166267;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9QFNoCDQHVkSnBwogxdSoH8X9DK+mESejtWDpQqvMs=;
        b=GqX6t7RE4gSgQjHzpt/WMpGVPCmxqFOuCyMWN6LF8GSPtAgssdWH1aXOO5pELLDbe5
         s+R1nM272ZSsVg7Iym3+PXJgs4XM01AOEODyEhM5VU3RvVEuWl9eiIab81G6tmrMBa6q
         k2lK9XDYWJYkeCh61NH2TslDxC0hxp9Cmht74aYiA52pg5yjzb5SkjAZAdObxNODR9mn
         dnFXnF+uKQ2iQxgXuaWjys3ssoZr+zetigAT0R8+iRIVzb1TTX9pkTgl2e36oXPPADk9
         2rvqAeddxCnEdikkTqwZpBfNdu+JaBDGPtBah0d5ppBdd5SvmE3bQUQnuQiLcjZ7VTzs
         U4gQ==
X-Gm-Message-State: AOJu0YylPz7TSyuGQ8Ef/0HgY/zziHtLIag7sRgZ60XFVQtW/w8IqDZn
	orlc9Wi3ZPfB3GP67Bryi6wYvyvVWEE5Wx25wV7pNwDDQx44iRw/u6YxNS52Bg==
X-Gm-Gg: AeBDieuD5YfftSZo9Vktjuxmf5lHexMgvJHI3oS7sOEEzF3OdZZb27//pSNqykaePNm
	T76FafmaNU4enaNqYleSSdOjfapgMDgBY4jVL+TaMZkBwHsALmZ8zZfIpTAEla+dzxjp/YJjeyE
	iMkErIK21W8h1A/msN0o+iDLAsddMt0tiAgM642hZJKuZUmnMh1BS3zaXbX6QEw5mbbQwbyEtYX
	JDCWJyS5Bbm1SqvEBbjD62BkLcHVsrPkh2XsOCLLtFVJUE7o5uoqBoUv6C1titdR/zH+a2NWXgx
	eeSMTVD7A0qMtApt2PEK2kYDbcUNLesajeQlpNWEh9hWJISwgtCZu8iQe+hRes7iDBYCtS4AFZY
	QyadZSDO46A2xUCt3COGDy4cGmL7iM78W+QdCuZafcUf6qP5MM3jOMkk4i8GXz0PZMcInkbjA7u
	laFIp4m7WqjInq+jIAsSUHMjH+cNaBIA==
X-Received: by 2002:a05:6214:4104:b0:8a7:16f8:442a with SMTP id 6a1803df08f44-8a7170788a6mr285498246d6.39.1775561467355;
        Tue, 07 Apr 2026 04:31:07 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.159.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ab48a8855csm51954346d6.7.2026.04.07.04.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:31:06 -0700 (PDT)
Message-ID: <69d4eafa.050a0220.26afa4.c93f@mx.google.com>
Date: Tue, 07 Apr 2026 04:31:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8616080693739285953=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Bluetooth: Add initial Channel Sounding
In-Reply-To: <20260407103516.2371804-2-naga.akella@oss.qualcomm.com>
References: <20260407103516.2371804-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8616080693739285953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: src/shared/hci.c: does not exist in index
error: src/shared/hci.h: does not exist in index
error: src/shared/rap.c: does not exist in index
error: src/shared/rap.h: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8616080693739285953==--
