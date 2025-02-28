Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787FF277030
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740770386; cv=none; b=KJ/n3XIWVoAviD3/W+Q7GKwF0GSNWWUkCTJPTq3MuGoconnMeKfUfI9Kxu4Inexv//vnlb+yAfu0kTEsQveiUacOpvcXiinTclTIszsmj2VYl2ThbO+vw9rCbDaCldD1kDEt47b9MHtrGrp1Y4kq4XDRPqYK54rOKfHCOie5RBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740770386; c=relaxed/simple;
	bh=Raj76/jhjqsXXjO1Ko8ULv9mbt7xD5/+RUeEjGrvJI8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DMnwYrwBRA49dKvlo5dtIKEbAd20nzJiq7jnKwBKeEolCE8qBMG2D4rXkpTcqVdaon0aLuw8TJUoG0Xrxi3V8vUhyBG6FSAD+hDtLCx8lyzVLrkir7rud00Dlo/ln4MwBhPUkOjc/USttC9kzrKH8NDUPCMT+yqNsMxAemPNnvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZyxZ93e; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZyxZ93e"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e894b81678so12772186d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 11:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740770383; x=1741375183; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/Np90zZLLNy4iHLhByE2Svtw2knzPZ5lbAwkUe0YH0c=;
        b=lZyxZ93eEyPdmwIXE2G1HVC1zyA6yy8X5OmhC+qIIzd6oqo43mOFiKV5dRDi/k+h5e
         yMOD6iCDn44ZiGAJQ6Ox14zcyudgPv83ImOXI67mnoukKUyRFJ4QXOYkK+g9YWSR87i7
         JvZZlbp8LLYvy6I+b4Yypysdg1pWwhYGXtRXp/+3CfekOzxacfyrrbVfF916139RBslj
         VglWjlQ8Qtd5HvQCOjgi5FHgIL59HaKZ6MIYVfqzIML0V485j/hHO3BKxkrXpouc2SBD
         /wcBxX/ui1CwzYds9sm4QzzB1oKr9lNo/Gq5WcBCYboqpTS/k6NggjABOwDXM6Qlqjvd
         d2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740770383; x=1741375183;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Np90zZLLNy4iHLhByE2Svtw2knzPZ5lbAwkUe0YH0c=;
        b=mRIFkhzCIyJ+AFwKYC5DGPWnDWLDU4SQEX8DZR38PRAkdqMTjKIpBFCkpVJr/qC287
         n4Q1tHKgtMHEAz98Jnk9uZaKhIijy4lSxNxJidNM5baUF92XPtKr0XPKLaonIEDg/0+c
         jgyDC/Yu3sabnvAKItneGUiJZ3lBRUKyWar0b2w1YYVCEHSIoFmyqd56/nUlNmQwjqYe
         31LsLGQrhPum9KURA9Pzic6b3mGm4+njizjQJ5CoT63KNEnAUDKDb/qv1rbJIFdaAG/p
         zqhvl6hC7cBrPFOWiHV2oLoJmZRmS0fh9dUAVCnQkWg2mxuwKlQX72249W0xnK/XtPMN
         FIxQ==
X-Gm-Message-State: AOJu0YwHiBDkcuXoQOdAH4IaTRu1PW4tT5VbmtWagG0F1KA17jlyheQV
	aApUoH011vS2CE1YCOWxdxMDSFAOQpIurGZOP0yflqkuY4uQtAdiCbnOOw==
X-Gm-Gg: ASbGnctZCuOZA2kQ3f4ajVrNsSEHzfl9PbUMy6syB+NhTocTYzsUw5Y8EyH5P2xAJUf
	fbX2XDgNDi4ZKdEWHyUAipkW9smcI2DwIDE4+hqoydWzWJuw6zRPZByZN/uFiNED+SPhoApORTr
	fKVRakww3wMUsWnNzSdsrayBRPHxv8zf1R84A7XEc3GdV9Wb88u1/RgpF78pOUglBesphzSa0EG
	39rZfony0cgtKHoEZ64tM35Vh+CcwPzWKEfr7xjFeA7zMPr8Mt73A74qtv2N/Ebhi8cOYghKWgJ
	eqqkCymVK8Rm5n+CVIAfrQJzcnNAdDg=
X-Google-Smtp-Source: AGHT+IH7nKo2YleppX9+DQTWIzMuWUaTD26SC/ulfX/qZoH4YFF1PavsUfzhhDOKng91xKTy/EU/nw==
X-Received: by 2002:ad4:4eeb:0:b0:6d8:8a60:ef2c with SMTP id 6a1803df08f44-6e8a0cce81amr72792166d6.2.1740770383104;
        Fri, 28 Feb 2025 11:19:43 -0800 (PST)
Received: from [172.17.0.2] ([20.42.10.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897634687sm25037486d6.13.2025.02.28.11.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 11:19:42 -0800 (PST)
Message-ID: <67c20c4e.d40a0220.2d5a1f.a3a2@mx.google.com>
Date: Fri, 28 Feb 2025 11:19:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3103837317447505481=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/bap: Fix state transition of sink for disable operation
In-Reply-To: <20250228175048.3471469-1-luiz.dentz@gmail.com>
References: <20250228175048.3471469-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3103837317447505481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=939122

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.21 seconds
BuildEll                      PASS      20.47 seconds
BluezMake                     PASS      1437.83 seconds
MakeCheck                     PASS      13.16 seconds
MakeDistcheck                 PASS      157.43 seconds
CheckValgrind                 PASS      212.18 seconds
CheckSmatch                   WARNING   284.54 seconds
bluezmakeextell               PASS      98.80 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      851.41 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3103837317447505481==--
