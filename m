Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B1395AEC
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778761771; cv=none; b=WpeMvIyJa1moWBBPSoguWns6B885U9NmUDlBhgJHrgQ8UM5ELg//2+d4nuab+BbHgNJ7KdRev+aoFBx+QdP0/yr5FcjCWVKgvFxGcYO7z3k0FKI6+/ecPwcGOjQWQXxA8e2is7lD8z7vcGynHdnPLUosZ4nc45TxJjda5oTi2OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778761771; c=relaxed/simple;
	bh=jzkLpNgzDO6tB0a80nJuP0iP+WSNmKf5mmYop9PPzyI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FIc5kH2BEUNuMKUbBIGx0IWDg87HQRGu87hgIgmAdj5FihZ502NBaITAVhCdODdSA8iAkes/rh2GFrRL+gFJUphuyj4+TcX8rYhBIdflCIDTw2nkp+6RFROdVLHoPNZdgB+tRE/PBqXbDdGVyMNst2heyi8Ko3XBllcfhEcp3zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3C8NlAF; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3C8NlAF"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso90672166d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 05:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778761769; x=1779366569; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1TU+zy/qrsWw4mFl27P3Ic2qqZDS/ewGMW75HL+mKpk=;
        b=K3C8NlAFVDettIouhKyi66eBGkYY4yJ9TTqGY6MYCyeQECluydlWzjMMtVy9TeN6oK
         FwLBDSzd0TGFGeFhUA/ooSBSj/06AG4h7duRz0OPskSa5qtjpPbhQ680Xzi5jUjeAfRi
         g1YDd4A1gTiHP1cUNpFC11xk4X+MzZ6Dff7Qs6DkxdNGxRTIFkgDEj7nq4TZVgBsKmjc
         UxZzfHmcL86Ayey9wckAaWNDkIZ9sBaGJsnbn2RphW5UTiozZQaeDVzda0Ficv4bWmXP
         gDiEEK2MjMB8cS6rb9rURMxitLaYxy+UOzLXjsYuPPAfBZr7bMmznZaKwe8glJuqzrOs
         3k0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778761769; x=1779366569;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TU+zy/qrsWw4mFl27P3Ic2qqZDS/ewGMW75HL+mKpk=;
        b=STPZpDQ/wPyGRgq6TMYlNsaatiKKZ8yzrZuRqpfTWJ7W4MlpstKf5yF7rEe2KmGGNW
         sZ1WpTiaphuBsXaq/8Y61T1QPLjTF3hhEv0nAHB6+f6mRsg6nv+aABRi3sA3aQwwsMWl
         MnYTrHXWk7qD/zEh1z3ucrDqVxB2W0h8Wg3kLRG5ip2o7QxjOLaYIvSZOteUMU/Rqx4x
         f/G4+ocYF3oKmWzq1T9VPoQv/5nkdIjwo7OfNMbi7yeYtyTYM01Q4GarVNtS9iDReoLM
         EfOoT2z2RgkKfaVySTqz7KdxW1zQEGVhfEG3/AoLPieqVddl2BJRLXSGl3Nb9vJz0qym
         X8oQ==
X-Gm-Message-State: AOJu0YwlDdbBuo97VtI25iRVynhdC3/LjdfXZYvILCAsLStso1vmXBrS
	FSP0M9+WgYyydJ5VCANX6I4GJIZnr5eGcw1JiEyfEeOipbH7d+gtMqMI/0oHQQ==
X-Gm-Gg: Acq92OElR8igG5kEtNK6Mbl/Qp1lhMa2DIPdnKQ5JScFLylDiDUGpu/8KizxCuhyGFW
	0lLjpw5BPzrhjQLnaf6A07oF9h77t4bdc5y58m8MDFoXQQ+4cYcWK+koMw6NIDja/S5WJjWLieT
	OjSrp9ZpgbV0JX+ZptCmUZi6Ncobs8+fqcJXl4UtZKaGZlRqWclXRs40OKXx2A44XdgdTGwWakH
	U5URGhlEuVIRxlwqRdsyKnH9l+p4lSBbBvs5aPXMyMGVlSDJ7CRlbfo6pUReBxHc2UzDoZ2qTFY
	UE+IFTuFmBJgPXi0FOxZU6dL4WV27Asy3HjVNJ0kzKP/1zdKk3K0T4Naa88x/Ajkjzuo3Udq01J
	f7sPyDrDJA8o0wNTYfrOV4HlvctCaEK2mXYlJm+xhrfYTldnKg9piR1ZGPKOpE/D77pqvsx+auX
	JPSBvXfX/PDZLjhwX1sopn4a6IWovpvg==
X-Received: by 2002:a05:6214:4a92:b0:89c:ac42:e119 with SMTP id 6a1803df08f44-8c8fb63de9cmr61113996d6.8.1778761768892;
        Thu, 14 May 2026 05:29:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.102.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908561c35sm22316096d6.8.2026.05.14.05.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:29:28 -0700 (PDT)
Message-ID: <6a05c028.1c3a6f4d.2dc0e2.1a16@mx.google.com>
Date: Thu, 14 May 2026 05:29:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6681072806706664125=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, winter91@foxmail.com
Subject: RE: [v2] Bluetooth: btnxpuart: Fix use-after-free in probe error path
In-Reply-To: <tencent_4A1D33225C74DB33EFAE8A0B6E884567DD09@qq.com>
References: <tencent_4A1D33225C74DB33EFAE8A0B6E884567DD09@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6681072806706664125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1094755

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
GitLint                       FAIL      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.41 seconds
CheckAllWarning               PASS      28.81 seconds
CheckSparse                   PASS      27.58 seconds
BuildKernel32                 PASS      25.67 seconds
TestRunnerSetup               PASS      566.44 seconds
IncrementalBuild              PASS      24.58 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btnxpuart: Fix use-after-free in probe error path

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
23: B1 Line exceeds max length (96>80): "v1: https://lore.kernel.org/linux-bluetooth/tencent_05373BA21CEEB5195F2ECCED0C77D0C57108@qq.com/"


https://github.com/bluez/bluetooth-next/pull/188

---
Regards,
Linux Bluetooth


--===============6681072806706664125==--
