Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CBB374CB
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Aug 2024 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223145; cv=none; b=Mtl0X8vF3XBiCgUFWTpscjAOBcIDznbHoIEcvh/Bps3kiTYB7wP/VjD5lUJQpGvpRHacj3WkcbtKpw/ZB0id/qZqdwOBPNRkwuiEkQxSnpVctygU7ySHw264GhUkYv42HsGCywcCTvS8tyd8lgqMNKfYG4o2oNguK8sP3rl2ArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223145; c=relaxed/simple;
	bh=1soPjIbXwZPWWrKkrrMY6mrDbvL2tvPMJ88KwROufzg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tntRk0qqbasmZTPkC6H80W4nhQUhMHyO6Xrpwy3wq7PEfYhjPUUKEKx/rXXbAT+y4R1djDPquYepLsDODIRGiJOC0gVDFHv/hW4ky7oCURNJyAwa/gyD+oTDrrzqA3FInOgvBZcUV74QefvYdUA+IKrqsBSgvHYnTfXlUoBAbUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfufHSAo; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfufHSAo"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44fe6672297so13203181cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Aug 2024 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723223143; x=1723827943; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TVMo75F3xnbsDrN5CnCWebmkN6qqIOlpoT+lH8WhaeA=;
        b=NfufHSAoD16DRsVLpoWEzLbrUbqxHCEvSz3Z8YOvwxDc+hJjWr4Cp0fPX7vUQD7gUX
         kyT1amJR7Ilz86kMe+4R/giCHvXsFVzoMd6HPxbzUlcJ9HTt1jSxbGJ02D5ytqgxyviQ
         TQmxmG2fNMCqaX2J3T+nmJJMngGVjtwtOK61wB7pI678Wr3lfoJP7Pi9wNCzCkj2FNKT
         P4fi/IYE9ZOLVDZ290gGf3ll4HCTeJmIXgh1FxYrNZG++SDd+JZimb8GF6C6xlgLVh0V
         LS12A5Zuqc4tQEKWYXtBGYAmfl18D8BHQNvRWbbZaJmq3Z4DQB5tTUKrCEKEbsmZSv3q
         u28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723223143; x=1723827943;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVMo75F3xnbsDrN5CnCWebmkN6qqIOlpoT+lH8WhaeA=;
        b=hWn8FDy22sVZnrxRyOIt5TxWCxp3Yg7h6VOword8T5pYDIk1JyVLNEOSUULdD5xGE1
         OreudouACTTinUAQrxaUSyiqCx4k/Nn+XITm/HB+z2L55QQLAwK6IxVngUzeT5YLCeOI
         XQBpHRXPYPAMG1XC+qLfGGA9Axnv0jFMVMIPUc/KYOPNlxmEpah48d9PYjhhVC2VJXUg
         EKtAEcWZ9DsII6Jhq/ju+TMHOGtNIeUv/HvnO1MgaPHuvPmMEMnq6+i0oYuI5KnPSFwb
         Xoj/ardxmNTSgQN1ZQ+Vhw7WmDH36PiZ46XlFAEZ/NVbFt2PafuBDBG2YP5Rjf2ksEOl
         6Rqw==
X-Gm-Message-State: AOJu0Yy4KQvvn5egyYAURIh3cOtSz/tMaC0okIP2brhNf+c/AUbOtxDN
	SlBDiKly/tvxJydsBMEBbSmKY87Kb4ArfEt7YfIlcevdMP+J8A49U1pMRw==
X-Google-Smtp-Source: AGHT+IFLBc4yRPe0Jh2wZsFwzRxKWDW+BYO4zir+D04fhCNkBJNwhXAkAd64EnzGPwBQJ8JhIljKIA==
X-Received: by 2002:a05:622a:1dc3:b0:451:d522:8cab with SMTP id d75a77b69052e-453125879e6mr22064001cf.22.1723223142893;
        Fri, 09 Aug 2024 10:05:42 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.113.196])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c86ff90fsm22942711cf.5.2024.08.09.10.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:05:42 -0700 (PDT)
Message-ID: <66b64c66.c80a0220.352a7d.974a@mx.google.com>
Date: Fri, 09 Aug 2024 10:05:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3779877544331836357=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] doc/doc/org.bluez.GattCharacteristic: Add missing link option to ReadValue
In-Reply-To: <20240809152207.989730-1-luiz.dentz@gmail.com>
References: <20240809152207.989730-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3779877544331836357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=878254

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       FAIL      0.46 seconds
BuildEll                      PASS      24.74 seconds
BluezMake                     PASS      1756.87 seconds
MakeCheck                     PASS      13.36 seconds
MakeDistcheck                 PASS      180.34 seconds
CheckValgrind                 PASS      256.54 seconds
CheckSmatch                   PASS      363.04 seconds
bluezmakeextell               PASS      120.08 seconds
IncrementalBuild              PASS      1525.35 seconds
ScanBuild                     PASS      1021.84 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1] doc/doc/org.bluez.GattCharacteristic: Add missing link option to ReadValue

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[BlueZ,v1] doc/doc/org.bluez.GattCharacteristic: Add missing link option to ReadValue"


---
Regards,
Linux Bluetooth


--===============3779877544331836357==--
