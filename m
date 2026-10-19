Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B632A491B38
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420904; cv=none; b=i9bTb5wQkIPFED2Do0h2rC8AE1JcB45v41QbByadxbbuoPUC3lFWyuajEuig13/aCInB6e0RUuh1CD2UPfnFfMBNHWatLhJSi8GDBqxPUuNfbEwsfEwTaBQjmptOopqp8rBCuS+mo3fTwkHF79m6samI5UVEwVC2iERnNWPF64w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420904; c=relaxed/simple;
	bh=VsksSuYMnpGJjvIvtfJn+2OiHLqtMUyySH+eI58dbm0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DdqDz30/woo7EqFFy578Qz6L0ATOd4/LjpkKxJlTnJ/5i7B0CedJj/Pf4t4dfKbMrHvazHmaRvHsvzFviBwIRjHgrzbrNSVpLK0+jo9Ijgg6YYCwiwv+fP3LQ7gW0ty428miLBOcSeaF637yZ3WkuToQrvdjJktG4H79JQ0Cw5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI2pGV8c; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI2pGV8c"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53512cd2f85so24939971cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792420901; x=1793025701; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4qH7T0Qt0K9skWawjGDA/Gs7TdJs6/Dd8eTR1JQkAgw=;
        b=SI2pGV8clEEDe0yLs/UDaAz/cugzlZAxYr49OtkysCvbBH3rxRaj+Exf5VSFNa/qQv
         b4e8oeAaj4iaaRtiL/FEjxteKrbBaYgco3F4JE8lqfQU+9dxFcCXUzXGJNm5A3t2vs95
         yWZrZ7TP9d+cCddB7XXa6peXTL7MhAZwRe244f4oqaDZpAb3UlYKb/+o2lZ1q39CDoeP
         IlHXKgWrBCuux6xLs1Rw2Gry7sw5JnLS0gOfdyWynI3RzdNId4JjVp1kYPzZKqHyWP51
         TXTH4nbHT3+d3DsCjswbp4oOizXP641kQ50SIRb+Mt10JgR3Ba/PCL9y+kvyNCv4lBwO
         QHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420902; x=1793025702;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4qH7T0Qt0K9skWawjGDA/Gs7TdJs6/Dd8eTR1JQkAgw=;
        b=XZt+CTjkFMu7MvOxLru/scFEGPZUSQu6sfXV7Su52I3SXZSzUY3oMMjFV4B523Zz4M
         DKs8246tRQvSCvLyzfB481Vwr5UNmH9OLXWgxc/KkP/ewaejYkE7PEnEkA1IcXb7QmkS
         FTkWguIFLfyVazWFDwh6jdCjkmiahqak4DVkJqCdeZFNgqM0XodUplRA/fhlwPYe1MlU
         KA/kfK2T9nWEFnsKgFutMvzXVVEGj6yvXG1UnMSydbIQMZcaz8KvOn26dQPoRgal9fFW
         APeHGYFL0+xGvqJPoXHMkpZ4A6Lx4LupjaZLZz0h9ygWB51X5BWC9uz/bNeDB+3hS6zO
         JA2A==
X-Gm-Message-State: AFq9FYKxhnLWS67VSpYj+IEDJOfO7YNI3hUw39pmYxsuOZRou3R9h2dR
	FMiHgm9Jz6itZ+Kqta5WCE0xiN/TIq6m5UmcYCYo+4pIAsrQzwHaN75YO2ngzw==
X-Gm-Gg: AYBFou0/wLDxsBXX/tZvCN4Iwxc6BG1nAk0FupyDLRrxDwFnGjiLLB/rMk5KDd1dS2+
	++Os1tsMwzvTw8Bj/6J2D0oHgPR/rCwzAYy8uKAoBqb8+SVMc9fOErBztdwLIPzBvAqb5dnY1gd
	zP4VNMh80Y8OeJk8QR2DB4CezU/js+ZZ+yJRx1GRNEeT2TU4BveZYzvBZsdF7l8V2Ty+N5Qmedx
	P6ljMsYfbDbYK/4bDMqvX53PzkH2DwAU1DYM4tz/s3rPplwcG/ig7YXIbXinCRMN39nPJqrx4FH
	BWWRHPAebtzik/nsXlUE9UHWr2+n+MKb9BW2aCC3WvCKSN6T1da7QAXV90jAzj5xqsJ7yb8OhPh
	xhyOWbJMGIGpcSAiDROItxSLc1uRwtNCQ+LrESJojdVSP1CTKgMt4LKvnSXcu1QCTfXkZCbdwuM
	5upy3AealScbtkmX5MMECrKOOSX0b1QjGVp56VhGjFatKzFNWufPzk6Zl5mOIVmQR74IAU7dMf5
	Lk9
X-Received: by 2002:a05:622a:418c:b0:536:600e:843d with SMTP id d75a77b69052e-536600e89e7mr65028381cf.50.1792420901507;
        Mon, 19 Oct 2026 07:41:41 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.53.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5364cee9ae2sm67724741cf.21.2026.10.19.07.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:41:41 -0700 (PDT)
Message-ID: <6ad62c25.4f80ee4c.21ae8.1acf@mx.google.com>
Date: Mon, 19 Oct 2026 07:41:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8594602301442829019=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 18983559317@163.com
Subject: RE: [v1] Bluetooth: hci_core: Initialize link key before publication
In-Reply-To: <20261019081711.479294-1-18983559317@163.com>
References: <20261019081711.479294-1-18983559317@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8594602301442829019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1188682/

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.24 seconds
CheckAllWarning               PASS      33.50 seconds
CheckSparse                   PASS      38.88 seconds
BuildKernel32                 PASS      29.36 seconds
CheckKernelLLVM               PASS      35.32 seconds
TestRunnerSetup               PASS      700.43 seconds
TestRunner_l2cap-tester       PASS      12.55 seconds
TestRunner_iso-tester         PASS      10.64 seconds
TestRunner_bnep-tester        PASS      3.13 seconds
TestRunner_mgmt-tester        PASS      87.35 seconds
TestRunner_rfcomm-tester      PASS      4.48 seconds
TestRunner_sco-tester         PASS      5.61 seconds
TestRunner_ioctl-tester       PASS      4.64 seconds
TestRunner_mesh-tester        PASS      5.50 seconds
TestRunner_smp-tester         PASS      4.34 seconds
TestRunner_userchan-tester    PASS      3.21 seconds
TestRunner_6lowpan-tester     PASS      4.45 seconds
IncrementalBuild              PASS      28.11 seconds



https://github.com/bluez/bluetooth-next/pull/963

---
Regards,
Linux Bluetooth


--===============8594602301442829019==--
