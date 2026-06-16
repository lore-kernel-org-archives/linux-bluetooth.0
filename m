Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA80D1AAE28
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615158; cv=none; b=NUOwXfeDNo6mIvS/zKBddn8gznUx/l4ZbGbdfS1Ag18hdhs6UjA9Dn1XQyeayJMzNUXCbwLan0bohv0Q1zlxdcF/iA7thC90em/K5Am2RRQuNDlDUYA8S684UDhbeUVtzn7MwJJXuKp6jBNs+aoCO00TkQ8uIz1nDF/KJOXdjJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615158; c=relaxed/simple;
	bh=82swiSREZdF25QORKTWnf8iTGJnF0I9OdYhoiHX6LgU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dyHkQGUly76aenG7i/IkzQilYL6Hn8/ExpJa20FGTy2JvC8XbjMvGdJfFDqc34+AtuiLsBlbbSr+YQYDfDD9hRp0ErRq+Ha2OUm8s4ed/XC+82xcX/1h9qRNnkx71/JIxaPlmdFtXsWwtsSMH6zqypdR+3sj4bh9cnUrdFRlCz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNEnI6wI; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNEnI6wI"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a0a0b46cd9so555700eaf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 06:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781615156; x=1782219956; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mPBwvCEbiCLkMWZnbuGMJAXk3HDzTiRmshgKQ4ZyxKU=;
        b=PNEnI6wI+119XVRwpLCidQQHU2h+H9fvDFLwA5PoXOZitBXHv+UQtGv8ZeO2LBfPmo
         KbzJd3n5JPz8bo+xl7dDR9EdYg3PqNj8De4Il5+S9yGMKv9QVZ25FZigWrGX7EjmQCbM
         uqOIFVSkTlAY5VC8ak68wdg6bMcpL2/Z19JgPExxh729p6Die6uNmUZRPnluOydiKgzv
         Ltdw13dBXT6paCbzIRZqsQfclrKOuIZIQlSsxuM5ORdfUZdSw4KEy8xq/LoNBSH/a0/R
         36CedbovV+mVW87YmtbqZ1g5ntEl6gvt2cyX5eNUfvbNvVAoHvIQAEV5UspwfAZVilvI
         HAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781615156; x=1782219956;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPBwvCEbiCLkMWZnbuGMJAXk3HDzTiRmshgKQ4ZyxKU=;
        b=mRb7AneU/3K1DvxBOf84FSK3g9vjrUlNVxM8OKeieuZnwfNGue1kh5PuhFrZ90l/l4
         6kqJ0JvIAHKjVuqUcnH+H0E/XRLJAlap+mW+nTJ7+mUbnRpfhfyoX4Tayph/CgwSRm0k
         lqwtlapBzhoDoiNCzDNYY78iDrhuaB25c0HkQ/KysjnSh0nByHwadHKrecvjvheNCccH
         CxGwFx6hDnFkWUzkD+jHBEALGEcHtrR3DFW26cm0INmIIYdgpPn89vYXiQBHYXjGGaWa
         aTcQYieweWiYV13/WOJS67iFuIv95xQpCxyQ9wzcx91FPWOGX2x5+Vs4cuBL6o91LXzn
         bLMg==
X-Gm-Message-State: AOJu0YwUaRJ25Ai6+PcrCxrU5utfgk9Bs24HQ6pKeFeYUeMh4kXjWQYc
	JiasRhG4zMLdFcdQ9Y557OqBiEDtPRiNOjylcEw7YyEHG4v2pmEijrhaGZx1uQ==
X-Gm-Gg: Acq92OFxQA8gOQmpWMlxnCjlczp0VxNQs6yKwrK0KJOZZGlo7GwBLxtCUjDTdvEuvZr
	22doCoXxH6L45fSx9G8ciOXGI/NpwFfN/gti91qGuciGeyVG2RzoGCdTwsDmJg9ZOy4Ie8yXnpY
	EINkmIpwg1xktu/JyyEOgMqoWTWhpGpEomtwDgiJrG/y3/+OACxbXtEgIsY3IxfmRI3uPoykKk8
	lEzllWUYjxwDexOEr9Ora8eM22fwNmPpDImGncHw6aRbyJBfBF3xBBZQgGO6yjMuIQIloRDRzDk
	LdFT61SBF5taEYMPEs5YjG3BELKSYUzKMDutefBU/DO4KkHxoheHWfZCBFQaQifxukbgayOlJse
	7oMplEVRDTddt0mPsHBIxK9gt3J3Hsthc2vE9MyCNRGmXouylFmkivKh1m6y60bMVI9rfXzPdRy
	yB9EseVtC8uqxmqadpSyk/+Xb3pSlG1qSw9GdZzvFCjg==
X-Received: by 2002:a05:6820:c93:b0:69e:35a5:1362 with SMTP id 006d021491bc7-69edc792de3mr11600550eaf.52.1781615155762;
        Tue, 16 Jun 2026 06:05:55 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.239.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f53cedfcsm31687866d6.42.2026.06.16.06.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:05:55 -0700 (PDT)
Message-ID: <6a314a33.8e833c70.20691e.e539@mx.google.com>
Date: Tue, 16 Jun 2026 06:05:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4416481622812082073=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] hci-tester: Work-around possible string overflow
In-Reply-To: <20260616085538.3568474-1-hadess@hadess.net>
References: <20260616085538.3568474-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4416481622812082073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1112149

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       FAIL      0.32 seconds
BuildEll                      PASS      20.10 seconds
BluezMake                     PASS      620.61 seconds
CheckSmatch                   PASS      330.69 seconds
bluezmakeextell               PASS      169.87 seconds
IncrementalBuild              PASS      628.29 seconds
ScanBuild                     PASS      945.21 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] hci-tester: Work-around possible string overflow

7: B1 Line exceeds max length (160>80): "/usr/include/bits/string_fortified.h:29:10: warning: '__builtin_memcpy' writing 6 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]"


https://github.com/bluez/bluez/pull/2236

---
Regards,
Linux Bluetooth


--===============4416481622812082073==--
