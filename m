Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0C0248F68
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Jan 2026 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767563400; cv=none; b=jMLHUUsUh4LXNLtWNk/p8qMu+rf1Ryx3Kq2p+i0rLULSrF9ibnPIWgNi/EbdVFhakEnYIJ1/h2QmxM7YaIX8T+Eqp55z2oezdEU+Gc+V8oGYITC6ASDwlwgy75+9UTxdifTIRMFgDnBB8cVWjNbiLRHifI7q5xI5qHzrNxK26jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767563400; c=relaxed/simple;
	bh=IPr0qdmUweZwPStvb2xt+U/4xim14ECRpgZC/BATLq4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nKaO6r0yLMQTW3kgQFJHH0mbQYU9S/l7ngu/Of9WAd1yqDvhcI7i6TH3BcZFp/PCPajr8slcQQQv1zwlg7JA0jo/zLttpQSu8wOJ5LQKdMP+KcEcW4rkyPIenTYdONu7hjRXpZ8WJc1yGMkWbgY6VYVfVFk3F1DiIZrpmAIsyUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUv8telQ; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUv8telQ"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8b2148ca40eso2185445385a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Jan 2026 13:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767563397; x=1768168197; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HaA6osQBqklizduMVbpAqD5111ybrQVO4JMQBZlStRA=;
        b=XUv8telQ8n0rwP8yXhCOHUFU8dJZstNRdYZXBx6o/jQUfxg1guCUp80gcM0a2hUC2L
         NwhnlZzn2ayBXemyieDI3WAfpBMGTGMyxdDv4dqBOWMjG5ovY1I2fbW+dIaMVCE+kxi7
         3hkKmJgLacqnp+9cmOo7kEdUdXKnY5aCA4cI6syiLLFsWjiMKJDUowr2NrsCe7s51+bR
         mwrMAY3HL/5aLAhmEi76olWsNbzTtEG2WrSHaUyMn/6OuIrDNZ9kRevt66p9d8vwyciv
         voaTiMpQxzoQgLjKR2IU18+1OV1afNajQfEVhwH04teOjMciJ0ntk5V/cdmmHH59+qIn
         UY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767563397; x=1768168197;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaA6osQBqklizduMVbpAqD5111ybrQVO4JMQBZlStRA=;
        b=xRwRtN+NxXGp+gICEM40SZxKwKvhhcrC+amU3d8AR8meWq8uollWNyv6FRptZOsZT4
         Iu0cpPnI6kvJm0BrYGlBdOhQK9YmCzNNC5Mh6rnPfz7pUgP9vA6LLa6f1/VcCKPlhoKn
         crO1FlwsHuojOASpUAZsfbPLuj/+Mbnjdy1aCGCQXUPoOdFR+yQrDYuYA+OhzXehG4vE
         DqC+4YbhMOmKEduN4E/kni4Pj0svjAOsUxtv+lyUhM5/+Tw+PQTnWWKUH8m6RaddPiT+
         H3jWeM0WmcHLy3rhe3UDJ3vB6O74KzGwMDsEDJiPbre55cpHuhPpF1P4MR3GPRq0ojzR
         SYUw==
X-Gm-Message-State: AOJu0YzKuAsoks1wB/xucWNepJuDGeJzu+t/xN1l99EsdIKtXhLhXv24
	NIUxtKkxJmDFn3w4OdEkrqbBCdKRBOsgAbvaJQxAGaV9xzT31OWyScQ91bhgKxbd
X-Gm-Gg: AY/fxX5CifknvTV4E/BzQShH6RjvlSV3JnSkatJFKHpQ6VdUiG6wh15o4yeXikauXHv
	A87gWmWsAFAHoFnS1UClfx+IdL4kNjD3R3QuJ76AcpgN0I4JD3lWdxHqJMk9oYMJYWlzv830nNw
	NQer6WGG5i3f2YpxM+68BMBIaFMuVu8y5bNjkA1/snYjWBJFRgdCglahy/JsZTJ4gx/40rWhPgx
	pvC1eRia2YlIDP5Z1ubtQ0bn/RkCZ8x4aGURpeJNnlJ7y2RVEb0RO5lkMU2XUFQNlV1Ud+JFpth
	kx0CelZtAIDyHkv2Unbu1ySY7OFiztM3gXj/F2BHsaZH/PsUK0Rml8PTUpt5ACvmlz/Qr8B0c7X
	5PTX7PcrfTWbPLIZhZvk0fkf3h+Lw5rUPQet05INwN536v08i7PA5dofGMSWj+waT3JGIDK3sPW
	OM0b0GayyqapYb7BhAAdUZKKc8HA==
X-Google-Smtp-Source: AGHT+IEQalthATqhzamDF3LD0qP/GfM2n5bzKmtZocptU+4Q3mZEAppdKlrz4Mg/aDMxPuBRWLIfVQ==
X-Received: by 2002:a05:620a:319a:b0:8b2:edc8:13d0 with SMTP id af79cd13be357-8c08fa9bd25mr7479625985a.17.1767563397408;
        Sun, 04 Jan 2026 13:49:57 -0800 (PST)
Received: from [172.17.0.2] ([48.214.54.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fcdsm3567944385a.29.2026.01.04.13.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 13:49:56 -0800 (PST)
Message-ID: <695ae084.050a0220.97868.ec10@mx.google.com>
Date: Sun, 04 Jan 2026 13:49:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7217705825146284050=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: transport: distinguish BAP mic and playback volumes
In-Reply-To: <ce1ecf069f0856ff58471bbc39c6e38ad4acf0a9.1767559459.git.pav@iki.fi>
References: <ce1ecf069f0856ff58471bbc39c6e38ad4acf0a9.1767559459.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7217705825146284050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1038262

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.50 seconds
BluezMake                     PASS      658.19 seconds
MakeCheck                     PASS      22.50 seconds
MakeDistcheck                 PASS      245.23 seconds
CheckValgrind                 PASS      306.15 seconds
CheckSmatch                   WARNING   354.28 seconds
bluezmakeextell               PASS      183.48 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      1048.98 seconds

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
src/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7217705825146284050==--
