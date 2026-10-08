Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57C3439328
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446927; cv=none; b=EhB/9ym3kE36J3Rn1bdAE1vwf3enUALg9/dsGZmhReZv77h92oonPDpLm4YgdhyIKJol+Xc4QGHFR/+uSRud9FPBoZCjlR+ss8SF468TbXyQQ8X4RWihJRyDqcrZZNLbV1JCtjFtvw5gJSuTEjTeg+VcA5iCIeREtbOLAP4ND/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446927; c=relaxed/simple;
	bh=83DGAkal9WkjlzXqZoj1eRysZAsPsgdfs06SRBYSCFI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m85j8XGhXmnSOGFbjf0ssozjqYEMMv9dn3Uk5hS98TIyp3ClPRjzsLl87FEs5BP3FgxNg8VpfEeWSm3OzPf8t2KNEF987nSsU7a+NyyhCOfaiO+uUnAW/S8au0mbQSKFZq8W/Fw4yUUfbbqUrhYSXVUq6KUmZFivKu23e3YvR6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxI258v6; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxI258v6"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33c2520ad38so6379710eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791446925; x=1792051725; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8r47eyFf2TX0ltk7DZg1HAwnneRz8/26pMEUF7G+tPM=;
        b=JxI258v6UNPTxTOPrKEd00kx4Armw889IwQcs2lVW/HmX5ERFuJewwvqk8KmuNpqZr
         Iq+hNb48b0KTiqMUM8r/kzlgLUkIPtvCqzItpfaP1JlkD6q4MuXQJsiXdCiTrVUDmgvp
         tKQRoipFQ2gEfiOK72PXvc4vGZpVw2G/IeuqYKwOL0gHMtES0LPMxmS4i35KI1bXez1P
         EViyxD9MhsPLSLeHzTW+eMYi84V34Sb/fH4CS4z9a4xHR7qfXFF8Gs6JhlyggCivVk7C
         Fbk6kRmZ0KpVRzOZkdsueR304gSMYYhgnUpZqp8WyYw0J9VW9tYGls5Q95/kLTHMPhJK
         XuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791446925; x=1792051725;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8r47eyFf2TX0ltk7DZg1HAwnneRz8/26pMEUF7G+tPM=;
        b=gldS2HiIgOaZeap8hlVWqCz99x/LW312G0T6aMKYX/bCCtqLA8CAAxAh2GDT5KcXrQ
         iieuLZFpdOee/WQAU82asj/rIzhWApzXveR12RbT6AvW2589i+M/8HxGuEpWLi6dp02K
         0nfUzuhNKC/WZo56p9K8LTWnail2hLkkMrXLUPxnATgF3H63v1DvROBQpdHjxatu3GRK
         8nNVED57AWZxRFf/2doXORy/qWRzws1+E6O0vsgBBvjJB3jdlB5F9i+cSqtSCq3ozzAx
         hKpOnrxPOfqEHOgYZsL4beFN9ttykRwjXGdEjtvMuagBeIkEQtg5j6BPAofo9sLaW1Cp
         l6bg==
X-Gm-Message-State: AFuF++n3BNI5uI52rQYPkk8G+ISH58n9qSxowgt5NZAlIFpaD0vO9X1j
	d0YYNqrZzFHFHnnp9Dzs2I/TopXbrcqeOI55JvMu8CdXj6qcbbvEIh6WNsvrDA==
X-Gm-Gg: AYBFou2+WYCq5ChA+cN8MOJvaiEmKiNNOrM2uFX85m/k1A9UKQhexbUtS5wrmqrxRrl
	IKAfTu+GkER3S0H5xGTsg0p6EsBw5c4Nva9CdkCb1HOO8BARgX64NE4g+FEzVKEsW0l5KbEyMvL
	aeaLL22aPL6AZC59gw/OHYjz5xI8M7QdbN0JyZhRNpEwatvgj/CmyQQtmJtyPZFrfz0fEsw+8gP
	itbSaDkpR/TPuzhhgf2y9Y1GeqmTI6QF9Hw/U0MPGaGeOppWcNPVgT0J7zyVn8Ve3nKA28dQkTM
	OtPpuDQHjL+PpBuGHfjDsc37AmnYIzzOZ8K20XeG+s9iDVozFg7ypcTwpndgGgOzH513MZh5psn
	9z6/Pgh6p4k4SA11nbP/O3vGiwZrs0QwfcV3tDDPrfrE+U4cZmUBeBfTlhkyAvXoRzUbgcceRMX
	CTFM9WDm4cJ3gNYJfQBwjvj+qNKiBMK5EHvvaQbI7LQ9D2vsSPRmkk0uwuI8AqrRE/bHHUZEcfV
	nMMC7un
X-Received: by 2002:a05:7022:ea86:b0:15b:53a4:3495 with SMTP id a92af1059eb24-162071ebc42mr5155368c88.35.1791446924508;
        Thu, 08 Oct 2026 01:08:44 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.243.201])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1616602b33asm12754800c88.3.2026.10.08.01.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 01:08:43 -0700 (PDT)
Message-ID: <6ac74f8b.0a7c1997.28b7b.5b05@mx.google.com>
Date: Thu, 08 Oct 2026 01:08:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4855325597210947939=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: 6lowpan: Drain RCU readers on registration failure
In-Reply-To: <pm-bluetooth-objects-candidate-0230-v4-fd2c82b141a5bc3c5841@gmail.com>
References: <pm-bluetooth-objects-candidate-0230-v4-fd2c82b141a5bc3c5841@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4855325597210947939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181243/

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      31.14 seconds
CheckAllWarning               PASS      35.64 seconds
CheckSparse                   PASS      38.02 seconds
BuildKernel32                 PASS      31.01 seconds
CheckKernelLLVM               PASS      37.77 seconds
TestRunnerSetup               PASS      810.01 seconds
TestRunner_6lowpan-tester     PASS      5.65 seconds
IncrementalBuild              PASS      33.78 seconds



https://github.com/bluez/bluetooth-next/pull/878

---
Regards,
Linux Bluetooth


--===============4855325597210947939==--
