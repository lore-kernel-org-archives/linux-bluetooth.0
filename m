Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A722B165F16
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680713; cv=none; b=cfoamWZCN6TRY8B+T052oSyq6hgPBzdRnYNRuz8U2YaaMhm6pTqhauOuLu8ascqrqVkkPjwY170rCLPDIm0uUJsbcm19k4h8k8MnB5AJF01X4OqkDWqrqhrjzeJvxFLxUUbmXnijvFMdtM6ei3Us/77MF14Uvu1z1Bc2xHEimr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680713; c=relaxed/simple;
	bh=dqLcMC6K9J0/1pNeV9weTbp3cK/bzbXbG94OS5+CowA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PhSjeJ7hHVUaIrI/751FUZGrDUgsH0qRGzrf1sRlqYlIvCdOkYaLfXtIQz0vkNitOspQYw7jkve7ic3pKp9586eYXY57tDiRQ9gpt7zsELVLc281MAh1flSTcxKGoJulab+uyuBlfmR/aBcJOkOGN1iVvOf2VOu1dx6UT/zuQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Le/V2SGX; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le/V2SGX"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30bd47b9f0fso317444eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 00:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781680712; x=1782285512; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ4q8McL13+LWIuj+NeI0oWjxd22o+sLh/ySB1gd/aQ=;
        b=Le/V2SGXXdYdir67iEks/0zm64FCW1cLhS1LKoyjemsaAAmjKjmaxAp4dazg25ZfUE
         C2RbBOi4Ff9R0GZ0vmzrIJbRLHRKfBPlVwoYM521dsSYEZ1aOckRhT1HJmDq8m9vexnt
         xMj+ebOoq8u+MsdjShkEcob0RBdczFpM9vZg1VHz+XuqTDeYaGRbuphFuD0BkeaXyl11
         Bi6azPiOkhL28aEaNe2HiPckKlL83EJBcVbIxmaMPaR7djuvly9HmOcLIC7FRoCC3b4F
         +omgeb5IfLFCWBKkAeUaCulXvxuG9dwm5foirOvMOSD/h946DLbYgri2220piIBiICZQ
         aVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781680712; x=1782285512;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQ4q8McL13+LWIuj+NeI0oWjxd22o+sLh/ySB1gd/aQ=;
        b=DKtpkXcna+vTgJ8DpaiOiJULgN1GS4OXESDP3BmkHtubMiyN/0pXF03qid64TskelA
         CMktUEj+30sdr9xVgj23FM2qhCJh/gguaRyc6eCE6iQSHCj2ORQhPoDYUBTuiGpw4jb7
         bd+DA2h4xsIfOU7ow03pDM3Prxb+EN3mxFn0rRjje6Ce32kEaQgs7jgtrtWKUPV4h3qA
         pgG65aP2KYgyC1jopmig2ANbcUgmXcLoHfDnLJA6rFTDKbVA6zUjofRLR5XuzBlHyxXa
         PJ4hsPDfA0e4OwqHUyKjtnX5Z/0kvFsu2HqeteMvhfJgt5aoSZg+6NcMoGJJBpqYGMZU
         wrJQ==
X-Gm-Message-State: AOJu0YxtBm9jo2XJid41O5eCZTApK6KeiGNBKg1kmbIHROTQ8APIH3km
	hJ1s5zlnutgHCPguWusFaNMucRbI5EoLgTpSnP6aZKTGgbkO9AMqclIlkV2lxw==
X-Gm-Gg: AfdE7cmMJYY9dFQ182pLHVqfzZ3J3ys4D2pt5ct+wSYxNmb571FUQMWxZ4CA14TO6CY
	BH65HDzerhK77DTdf6UeqoaE5BYIyMIqUm28aqOY4omjJCb5eLK32Ul+05VZOcwj0R5D+8NnMNK
	bXY5ScLw8Zv5EvU8KQ+if0JKxcs7vsEEqxXdWLwS6GFy6zTQ4tIDzkWgXXUam9DzLQ3Yiup4KUn
	mSfQqeLUtvLkuA3hkMuU+j9gf/eH6KtlqgnNPYlGVEcxi5Fmplh+qAqsYXiKus19KpRs0OqkdBD
	+YeT+NIf4ZbkudJY7Mi4iQ5IsEGygQ7vkdaRHUnqWgFhxvG/homLRw3QYwmjvD0lVHI0xll5TJB
	6qSWcxyMi84jvLkfrRFJEbbh6pm3LPdjFRPF84WQjR5ooUDfVOP5+s7zWD6ffFRCYYWCqNQGFKn
	67OE20OWWboqIIDRwQuOQ=
X-Received: by 2002:a05:693c:3105:b0:307:287f:9bbc with SMTP id 5a478bee46e88-30bca0a3900mr1286993eec.25.1781680711700;
        Wed, 17 Jun 2026 00:18:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.154.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bdcba4b1bsm595323eec.20.2026.06.17.00.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 00:18:31 -0700 (PDT)
Message-ID: <6a324a47.14d9b9dc.267f5a.d138@mx.google.com>
Date: Wed, 17 Jun 2026 00:18:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6244412206844455701=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, senozhatsky@chromium.org
Subject: RE: Bluetooth: btmtksdio: teardown fixes
In-Reply-To: <20260617064543.574704-2-senozhatsky@chromium.org>
References: <20260617064543.574704-2-senozhatsky@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6244412206844455701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1112708

---Test result---

Test Summary:
CheckPatch                    PASS      1.09 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.47 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      25.03 seconds
CheckAllWarning               PASS      27.24 seconds
CheckSparse                   PASS      25.75 seconds
BuildKernel32                 PASS      23.81 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      526.47 seconds
IncrementalBuild              PASS      25.43 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,2/2] Bluetooth: btmtksdio: call cancel_work_sync() outside of host lock scope

1: T1 Title exceeds max length (81>80): "[v3,2/2] Bluetooth: btmtksdio: call cancel_work_sync() outside of host lock scope"
6: B3 Line contains hard tab characters (\t): "CPU0					CPU1"
7: B3 Line contains hard tab characters (\t): "					close()/reset()"
8: B3 Line contains hard tab characters (\t): "					sdio_claim_host()"
11: B3 Line contains hard tab characters (\t): "					cancel_work_sync() // sleeps"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/324

---
Regards,
Linux Bluetooth


--===============6244412206844455701==--
