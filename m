Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674842;
	b=BeoNdwkwlnjebVqtqeL1WqrY/HHoU9XuG08CDTfSwa6rPulWogKTiWQQ6Q/wqU7fj0Tx
	 Id2hBcGpn+Lj8lbIQJYLnnlh9sT/9VSSmOz7WI9690BOLoghs6B1c+ZS/HboM5A4AwOlQ
	 DjrJEIJAKI1MAvY9x8sfhyJgSYS56qpMe/oQzu2MIQhZ+b/Oykrq1YAZ4+SFZfiLM8xSA
	 j/bDHW5ZWAoqAXdaVnrOanzo7mZIloFDvBAMHDaWVDN4u6ZQVlXlLgqoK4QvdYOF1sX1r
	 wllajOnVX5MqwFJFGQYMo2aPUMhxD8cGpcieL+v0yC+ZT6oqO7LOUjg0i15KX7QOkdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=v9jqjX8dIc7GZAD7UzGZez3Dj37QkS8uEkVKipF2xRg=;
	b=1emqt50frlFk7EGCJITS6Jz8eKGR4Y7lGt2E1oLPTfjt3+3qgju3mwFwbSJPV0ZJ0Pr+
	 EfwITQ7QO2hueVsZrKnNVLRhk/KuPWdyEDWju43nBzGDQC2DtWgaOH1VBCBQ0CRsYCvtP
	 r6ki2/uALGDhM/PMe7BgAYYG+6qpSqUC0koW5pWYRzuNwPzMisZ9YHzQEMrz1zGB6NXMm
	 cxqBtXJlyxPeXRk+KH+WYmLTO0bx0ScgKcakzXYt/UsVjce0UtqRite1iDoNXiJYxf8tV
	 C8H20KWeJ/F3uqnQhC0Bmwtvx3orJL867Rvx+bExtyUkBBwx+AS0Og0MOJC3uAWsG0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bRtaOOTN;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943AC606A324
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 13:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 943AC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bRtaOOTN
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35ef6b49813so2409587eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674842; x=1793279642; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v9jqjX8dIc7GZAD7UzGZez3Dj37QkS8uEkVKipF2xRg=;
        b=bRtaOOTNlqRJWOMT7NroTaSp5ZOnxLjwzXAzXmeH+6zvJGxXdb/fFn3k70sdnHuB3W
         a9mfT+PdGLGQAkehMbMohaPVWXztBzQwqn3++cIcHtFsSxuj0VFhU1eacRhNi+YyXlUX
         +dxVuJGWYPq+P5rw/Vd3IJkdv1Rvz6vncYWk4sF2BTMkjCjlhNvaqtt3rjiPtv4MSQ/1
         4H/BzKyzWXBl++TudJj3JXfwoLIOyD7hngkSsby/Sd/PhsmPU1YKqxZgYzMnNhwyvQYD
         XCbSdx6Bu0E55ReTTh0gjodLKFH2AFrYjKgdYDs6CQKwV/Fn1/jOkUFpfoIfg6oFH7vu
         RVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674842; x=1793279642;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v9jqjX8dIc7GZAD7UzGZez3Dj37QkS8uEkVKipF2xRg=;
        b=tEjr7tFtQ5WWhXeVeGoEKjUBDN4XWXhKNgEMRbAnM98caSZnkfTlAQ8mgVyYt7K2II
         MV9wm4KLCtT0ESZ1FluANyscXn6yvHY+8t81xGEYJwNvKiMlCd401L2+nM1CD+tE6IRk
         7rjvT1eWKRfsBuhGg7oMotan1dCqVtC5GlE1NNmf7d0/YZR1bbUapQcEl2OXgXBRquTA
         0x+onxfakZPTGoMlDbgoEneUz7XnO2sVX4s+z7yxaM2yicEskTXy5KYzfkezg/O2B2lg
         UISgkmTFz6LopDTWZwgmMxSDkkYau9jPYW4D9mS4gnXandYUI/jDXmuNidiwHEIkJer9
         nR+Q==
X-Gm-Message-State: AFq9FYKjgag66Bh61YuGZVLawGP6TlPb/EOS1OjSwE0If9JJaOEbHPb0
	MQ4xbE10fTDgo+L3d7aZnbYFoQOP1uIWnoOleLf679gXR8LgZkyPLu9iCjbiUw==
X-Gm-Gg: AYBFou2vlT57Rh9NN2+jTGcRPy1dEW5NhdAbPgpSt5iE69PBQ/pU8kasZ7NKEbqtfAT
	SC2Rar6HCZ8w7imxFgZ/uy/5bAs9aUFBJATGIMEQRvLj1ArKKlnSDozG11Mg5798m/J15047Jkq
	Z0lWn7Eh6IX7mw9EbGvIXtW6i0tv5Jpz3L5DdFgaRNh1VLcjQTb7s8ukszLnV3NDhmlgBc75aJ3
	MxR35KmkT0wFu/9xcSCDCtPeCAsc5fZCfT/d+GcH+0ipMcnhHejjhe8tv/xQYIMOZ6oW6s/ALFs
	0jsxw+aFUkFKARIRbC2jS3H9ZOPL4trPqVWdVdpQIQd1i7/UYRZvvHZVGopPS2vXz4wcWXbMuvE
	3UzZ5rubW6MJsYJOwXv1zQvktYLktb9fE68xTR+5W+VgvZ9ixU/cuOxLsSN2BtJZJjbiZ3w8nt+
	2xKtaaUZV+YcxG+kotHcN1kYR28PWaarKBqOsJ+dqXn3E3y735kJOU2Ur6dyPPbxEz9fWbALGsM
	wi8c5O/gD1Avm1h3BpLTwvFrMVRP2kKEaHMwzOenJBMpQc1HWfpAhwTdEtPtoc/EQ==
X-Received: by 2002:a05:7300:80d6:b0:35d:2c2b:215a with SMTP id 5a478bee46e88-3674f11d996mr9663232eec.35.1792674841582;
        Thu, 22 Oct 2026 06:14:01 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.128.205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1d8sm24238619eec.24.2026.10.22.06.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:14:01 -0700 (PDT)
Message-ID: <6ada0c19.78c6c619.2f541b.1309@mx.google.com>
Date: Thu, 22 Oct 2026 06:14:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8321866764537815416=="
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
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: msft: Revalidate address filters before canceling
In-Reply-To: <pm-bluetooth-objects-candidate-0237-v16-2fe5728c6cabc061bbcf@gmail.com>
References: <pm-bluetooth-objects-candidate-0237-v16-2fe5728c6cabc061bbcf@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8321866764537815416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1191274/

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.51 seconds
BuildKernel                   PASS      30.24 seconds
CheckAllWarning               PASS      35.35 seconds
CheckSparse                   PASS      36.82 seconds
BuildKernel32                 PASS      28.72 seconds
CheckKernelLLVM               PASS      32.46 seconds
TestRunnerSetup               PASS      665.94 seconds
TestRunner_l2cap-tester       PASS      12.56 seconds
TestRunner_iso-tester         PASS      10.50 seconds
TestRunner_bnep-tester        PASS      8.22 seconds
TestRunner_mgmt-tester        PASS      87.34 seconds
TestRunner_rfcomm-tester      PASS      4.46 seconds
TestRunner_sco-tester         PASS      5.59 seconds
TestRunner_ioctl-tester       PASS      4.65 seconds
TestRunner_mesh-tester        PASS      5.49 seconds
TestRunner_smp-tester         PASS      4.33 seconds
TestRunner_userchan-tester    PASS      3.20 seconds
TestRunner_6lowpan-tester     PASS      4.44 seconds
IncrementalBuild              PASS      26.83 seconds



https://github.com/bluez/bluetooth-next/pull/980

---
Regards,
Linux Bluetooth


--===============8321866764537815416==--
