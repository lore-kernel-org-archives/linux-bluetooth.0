Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32322ACF3
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975926; cv=none; b=HLJJXXOSbbyC7b/T4Z8wDyafrlH7PtRhdxOOGbNHry2WcaU+hb6BQb4Lgz7F9yMvFoofZU5rc6M0yEg6QYDoJ6hVK7lpYtfhw3FTuXrIB00pQ5VQAoD39TzOxZt6Y2H5mjsZljnTYHdEGtVw4bFG4DRnVsQBv/UNsMIxoLljwEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975926; c=relaxed/simple;
	bh=ZNvqp8xYM05PCz/HfAL9VXWQVJknPvWi1hNFqmeJSlQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OuStrW+tPDbuoPqWW6B+xjhfqeh7DmcnLBmX3CdNH+kgnbrlZbYam542woBygW4VlX2zUO/hCPpYq70uRqUhMfxx8PfceDCBW5Xi1UQTDtz1pRx70hzp/W1dl9ovQtK32Z7jWBycqWLvPkYgdnJ8SO+3IaCjeGpWkq3nRqhSWxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZS9da9x; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZS9da9x"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31393526d0dso2890537a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 04:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751975924; x=1752580724; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/XX7iDj4DkscLGhW8hLpLsrFOCJyhed2j7Jp1Mzg+9A=;
        b=CZS9da9xcaEQLlyjUAbEa/I3OObYws2oPzLSRUPSsTyCkfKZGHawfeKebOxUdbZUAM
         uryVq1fuojDXiM8NR8gVl9MeIq8fRfcZCzia6c8fQUaNmZMm5M4YhgpjYluSjqKL/G70
         3J6qM/4Bsc/S8CcdGLktnQZlY62CjjVpI4hSg8qTOGBpKdVfsVoGcnBb09ESHRxR+kcA
         gic7+veFOkmPVE4RWoh4c2QCEc9d3mbE8odWEd2g415Dm/Eyy/+oI2NOqFMO3IpBj7fr
         E7zsUdG24L0DraNExguwf2JMzrVm3PwtkrriC3igUHp4UyHgll/ySKG5p5I7ZS/lJ76+
         VtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751975924; x=1752580724;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XX7iDj4DkscLGhW8hLpLsrFOCJyhed2j7Jp1Mzg+9A=;
        b=u4HNMnLtfGX4jOe7W6AJE1wlvOrfVyXNWOQ3zuyFvTNkhGxW9YLBQd4vprT2Lel8r+
         uXxBb01cQEHjGaMPYKaq/6bYVKh1Cyybd2rpFitRuDRhIS0bchUoc4DvEHRXOFohIoCR
         KJx/oL5gWflVsM6kZKSQlHko8mj+ZvEuC89NNx2LEe1j1mb1rMSAr9wNAE2jaPNE/FCO
         eYJVHpyONgods4fEDWatRczCyC/BeuqRqDrHs9fjav7PiP9uxheB7XoPim7lJgp5Yen/
         1dBa7PuQj24HxoxEoEYspP48FstRsriezyLQtpcsj2rXusClLmiYyoIDfgm78i40N8eU
         iFTw==
X-Gm-Message-State: AOJu0YxbsEpKXwCNlExIIV0VMK8FrW+0PgFpnx0NRV0sVpvf4qSE5cWH
	POwkcF9gRnI/dI4QsuFuqyDnQMi1vOogemZE3cZHYnb6uz9hVD23mNTSXgdvT6xk
X-Gm-Gg: ASbGncuOhTQ3Wlgxl0wzqDCeWluVo9u0JCMylBRfXEi5en0V1MjZQ1iaUfuS+c07Jn5
	OANKZSKTuKtq/zFCqkq/42mDBeaY8YW8aGbH4DgWOjmt5H0VaMIb9s0G9ypPeE6+d+SBozsE4bQ
	xw8InKn3J2rLXQ+OokOlQSJb4pJN1LhVC5VvFJm2D2zCD6yMwLNGZIxW8Apanx9aijdT0J7WsVx
	V+33lFLlaPn6e3NUuigLYWETolOMpfuQULTeiOTpctjOM+wFe9qbQRgnlNGfQY5iDRTqp88yll1
	uepeyWPp5xzmcJdYsbt/EehqnvjuzPRRre3qQgqj8YP78hH00VhhA2fx+CD/3c8m7KJm
X-Google-Smtp-Source: AGHT+IE63bd4JIpsj6xTn53ao7gmI9pTsHKailTBUIIspEjv70MtKPTW6muedk9H7yH3ZPAeI7LEjQ==
X-Received: by 2002:a17:90b:3d09:b0:313:271a:af56 with SMTP id 98e67ed59e1d1-31c20e6da95mr4639515a91.30.1751975923960;
        Tue, 08 Jul 2025 04:58:43 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.235.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c22055ca4sm2000054a91.7.2025.07.08.04.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 04:58:43 -0700 (PDT)
Message-ID: <686d07f3.170a0220.92722.3074@mx.google.com>
Date: Tue, 08 Jul 2025 04:58:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1552899123655809223=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,1/2] build: Remove deleted configure option
In-Reply-To: <20250708102418.1863891-1-hadess@hadess.net>
References: <20250708102418.1863891-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1552899123655809223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979993

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      20.56 seconds
BluezMake                     PASS      2747.52 seconds
MakeCheck                     PASS      20.36 seconds
MakeDistcheck                 PASS      184.59 seconds
CheckValgrind                 PASS      232.17 seconds
CheckSmatch                   PASS      303.47 seconds
bluezmakeextell               PASS      126.80 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      905.13 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1552899123655809223==--
