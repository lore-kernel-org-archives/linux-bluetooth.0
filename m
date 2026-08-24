Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92EF329391
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558591; cv=none; b=W8GL22s/qrHbMqQXivufaJVuhU1DCBsf57aDmceuIMV8TTxtNKtPPYi7bJBUKFOnOxcgnxnFHBLsj3wd6RaIy11FpzquEswhmDAVlsz0zQoWZNlSN8P9p/taoRjtGjAJcbvbSNZ4gE8rI+EC+ea0BRjgN9HeNTecU/Z6EukHiFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558591; c=relaxed/simple;
	bh=6vU4mIPzwuDHCAEyLxfQ+W0XpGH8LYKV93FHF8433UA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qRxFmxbxj5yvEZJJrVfC0KfujTTJJVEI5cmaeOpvwWtXMp2wyyVy9nwnEIAxpafJ5teXkmyMDtdYgDVwN8cWNBBmGJOxpWRFxUODgv4XRwfNGiCnBrBNcE9R/WFixaTl6GdKlcnfmMr2FyNlE+2Kk509y0liSJr4DLu/tDOPRmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTJ9tcz6; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTJ9tcz6"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93738ebbffaso150000885a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 01:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787558589; x=1788163389; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fB65jIyGIhMpvM04yhtSg9gJy26qRCc1IE5V92Bk/js=;
        b=nTJ9tcz62rAHC4ni1icsRU0RrlVkByKgUI9WUSCxiMgZ59UFwjLS8Ptc7asyW+A6H3
         hQ6Nky/kP1mBsXNQgLerHRwuFcM+uUdfE+ECfl2YUGFWEwpuVpxD8+dcFAU5hqSDgOfV
         ewmh3uwvsqD+p6e30If9HJBNQDRdnU5Yog4CCft8gcB39ap2QdxhKbvxGIORa6YyrBBo
         6wui8DIbK+lj3ANfc93mVCzeC6ithyjLAEwjUmCQcb/OLm30qHXPIE5jzJMK3tVxyDYL
         0SqkEokPxKTz7OI/Vy3jT4VRGDUlBwAbQgZZyXaQ53xIFpd7qxNJCd6VDdRwV9yAN2IW
         Go1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787558589; x=1788163389;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fB65jIyGIhMpvM04yhtSg9gJy26qRCc1IE5V92Bk/js=;
        b=sA00t3deFFkLgLcR8HTRj2vynX+X97AKat9ChED7I43jrfBc8FUR5XzNJspCvNF8SX
         y8/fNEbvx2PgBqx0/iVwXoJ1EJxjguZM4A5Fy12+Qp64AixgHi1t1p/BX/wIcCMTb0Og
         6QULSXzRH3RinPtOGUxOXX/d4ixdLJTcQK0sQlxLFAjHo5/NSxipw4nAU6la7GtBSHCF
         LvjrPdMKDzchUgxfYKiHVl2REIQZFABdNrDTytt/tr+wTHQf1tSJuHhveAAPRVbBCvoi
         rrhr74M9EUuXrV0g+SgJWw9gfQ/N0nmvqcQGzBk43wCqoY2VXO5UAesnqEwvpNnpCscU
         QipQ==
X-Gm-Message-State: AFuF++mDMtIezxeaPoi937Lr0LsvSC/NJR8GBa89f1iqS5QQ32gzYO/F
	BXIHxK1RUNS4t1u0vVaBUIdNRyM5YKw/B3wqpoc/rjEpsbe8QSnSs76Hh4fCWA==
X-Gm-Gg: AR+sD10KSKeg21gxcKd7X5gi3XzWpSaTekcyCbDIgC+XBemlvT2dSrjac+l1lbHIi8S
	Dnk7+6svaknwTU8k1tbT/bzm+nlM390nDhvjn5KfDtAJS2S+KxTmuCdR/nLPTtV3kYwUn3EsT5I
	JuzcBRlTXT7nJfsyz8Uby6lFbrRPWKau9QOk2eXAppLN0oRtwlUbwR1OGkW3JD/BzVH5Hd51rjE
	Ms8BSbxtEx0tlxJYMIaGfOGlTdXIZ6MG3yB7Kf8Pjr4QQ+S63zOw6LcPKaUnVIjvHIPBs1wuXpJ
	5IrQFkbsT5TNjHjKW3YemfAzzwH2y9g27G69WUGTpP5cRVkpg5ule8AFNqvsosU1h64oq8RP3rJ
	HUNFrCPJMu7Zsi+DGasVSeS0pKkEIDnBA3M62boEUoFsdoC4Quts47fDzJu7JVVu1J93Lys3U39
	fx8hePnRaoMbM9zYrOGMsI7zPzM+4CTO+LhpONRXc8p8NZADKLL/D+H/034rceVTDkuI2rGI/9r
	0Q8arcL
X-Received: by 2002:a05:620a:a90a:b0:92e:61f1:6b72 with SMTP id af79cd13be357-93739467daemr1930030285a.13.1787558588793;
        Mon, 24 Aug 2026 01:03:08 -0700 (PDT)
Received: from [172.17.0.2] ([135.237.130.147])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749d9544dsm448750185a.27.2026.08.24.01.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:03:08 -0700 (PDT)
Message-ID: <6a8bfabc.e0a65cc7.2e1605.9af6@mx.google.com>
Date: Mon, 24 Aug 2026 01:03:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8886354999287210001=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 13875017792@163.com
Subject: RE: Bluetooth: hci_mrvl: Fix wrong return value check of wait_on_bit_timeout()
In-Reply-To: <20260824071257.2791009-1-13875017792@163.com>
References: <20260824071257.2791009-1-13875017792@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8886354999287210001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1150676

---Test result---

Test Summary:
CheckPatch                    PENDING   31.89 seconds
VerifyFixes                   PENDING   31.72 seconds
VerifySignedoff               PENDING   31.73 seconds
GitLint                       PENDING   32.84 seconds
SubjectPrefix                 PENDING   31.80 seconds
BuildKernel                   PASS      26.32 seconds
CheckAllWarning               PASS      28.81 seconds
CheckSparse                   PASS      27.40 seconds
BuildKernel32                 PASS      25.23 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PENDING   496.43 seconds
IncrementalBuild              PENDING   55.68 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: VerifyFixes - PENDING
Desc: Verify Fixes tag format and validity
Output:

##############################
Test: VerifySignedoff - PENDING
Desc: Verify Signed-off-by chain
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: SubjectPrefix - PENDING
Desc: Check subject contains "Bluetooth" prefix
Output:

##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunnerSetup - PENDING
Desc: Setup kernel and bluez for test-runner
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluetooth-next/pull/642

---
Regards,
Linux Bluetooth


--===============8886354999287210001==--
