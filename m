Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9772DF153
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780780898; cv=none; b=AVjbiWOIL5z+D4iFcZgH4usIGFEcJSHbqAu6XMdeczK5862CNmUxCNsCz9YYF2u4GR8hwgFT/ci/GaG8J47LNOjVqg+nvMEm9bhZiAx/PsNAJMlBIf9d2ukf0IE94U0gApK/gsAB0utTpJW/sFwUIYPv53ZboGr9O3p/+6cdKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780780898; c=relaxed/simple;
	bh=XVjpdTI2KXyL/G2mXGNBcv8a+FRyDdBv3cpLUj460lE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eAtKCCtCE1myDdiYlnAp1N/lOeXyqN+wNC7Q6fgeMlEBZU4vm/71keAUY/c7TFISlk+/nubnRzkyEtdGuDLGorLddI1Vvi09/EqLuIHWz5pUJHWwjpdp98ewYvcBhHRtN4Gs+cyUrxpfzWjorafJGyKnPsEeRR1Qafnu8aOzM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHkxEESV; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHkxEESV"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3078e0dcd67so1094152eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Jun 2026 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780780896; x=1781385696; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XVjpdTI2KXyL/G2mXGNBcv8a+FRyDdBv3cpLUj460lE=;
        b=DHkxEESVD8A2EUbzi1tYd7HIqxOeg26gblwiZ8jAtYp+Gz1amDKJ+Ci/Z98cDjGSrI
         AH7aZsVbMTb6JLpDx4H4UjrSuccpdJT1Q/h7PgJn8Evx9zb1v5vRkecyJCMDsIpqfpry
         GzTTkfsxKIOBYfK1MD7ydFl2G5LNVB1oMdJq5BOzwTEVk8/BNdLK8fVAhBLqhVwtaS3F
         /LX91hP0Jfycho4W6e6eB36unGOz6naM6slvr5xSY9oSzDmwaYGBZlFlUZeAbFhPYfkt
         eHI+UN44EDPOEiEK8v7itOr29jFzQtoq6iYFMMaIo91QB4L3Zu//xi/OsVRHg8bYSZA0
         o6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780780896; x=1781385696;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVjpdTI2KXyL/G2mXGNBcv8a+FRyDdBv3cpLUj460lE=;
        b=EexbsIHwsULMm2GG4bqE/WT/bS7n3n4FDm/5f55+VXCQ6maavnRijAllc2dI78ZOM0
         PEYLmns8c6JGOZmZqlp6VThG1KtjkPGCUCxd40pMg1rozuAtVEVwBm4Req9pdQ8ykM7S
         rdyNg3yYkwRdif+4Mt3qNYBtL6XgOdOoaktruqO423y+HLaOVWtscnsZrMRrDAoxmlhv
         Nr+sQeeHC42oA+n/Hc7sc6y7ceBgwU08ORo5M6EWNUzmCceUdTUDQ0zlAx1ZwyCQ5+Zm
         C2TvDYz4ZCVkFvWG+lpiaO7rJ6Rg+G6fa+pDbamSNMV/qeQkPVpHXBgZ+gjdw4ZJ6XlE
         H1XA==
X-Gm-Message-State: AOJu0Yxp3/cUpZIm0LcomWaJ6AaXcENyk02R/HgOhcTmHejXXDE5VXdx
	TOf7DuKiBIY/3vyQeFxb2U/QtfC9UAViXvyBUUzAOF/bVCYeuZpE6RdEKbiNDw==
X-Gm-Gg: Acq92OHPsSAA4fDQGqjqHENH6OdfzHr0guoMxuTeOL2WkJMbk0uEXN4B5vHSHlKt2to
	Q/t0/PGYKGpoONns8B4+94dMoTz/roz6VRFqGTWGCAX8qzqkeEP/DeZUY0jlvPKVdFfqDq8rRw+
	Vjf9YM51stVvBBCRuR+gZz6ApoUWW7uoQqrv6R2ITdmCYhyJv/JTevas//B67Y80CSN0h6l9I3G
	0+6N2IpFgIGYOLDslGPLFYCbv7JRb5D/Lx7LLIwFmlS1ohqzS1rnC0LQBzXoJX39tgyVNgryHnc
	C2tTK1QgF/GRFrGz8eE3w2Le1xRb3dk3SLlRn3Imh+3ReJGH7PpDlUenLlkydWXAbrKiZEvcvd4
	b0LM7z/vdxfd2xfUAx2LHEWDYulsdx9D9r6yH7XgZa7aMunCZxqsuqxTY0JPj4N3uzMbfyUiSNI
	BYkd23+vTVo3CdXgVCQQSs2wi7eL63bDRjcrHCay89Zg==
X-Received: by 2002:a05:7300:572a:b0:2da:a813:a5fd with SMTP id 5a478bee46e88-3077b229ff5mr5175183eec.22.1780780896080;
        Sat, 06 Jun 2026 14:21:36 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.196.48])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df349d8sm11790270eec.22.2026.06.06.14.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 14:21:35 -0700 (PDT)
Message-ID: <6a248f5f.fb1bf61a.318c3d.973f@mx.google.com>
Date: Sat, 06 Jun 2026 14:21:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0131554983337269007=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, david.laight.linux@gmail.com
Subject: RE: [net-next] net/bluetooth/bnep: Use strscpy() to copy device name
In-Reply-To: <20260606202633.5018-26-david.laight.linux@gmail.com>
References: <20260606202633.5018-26-david.laight.linux@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0131554983337269007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/bnep/core.c:639
error: net/bluetooth/bnep/core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0131554983337269007==--
