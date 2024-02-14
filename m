Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892A1DA27
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952711; cv=none; b=ZKFN8GN0CNwD4CKrQw/pMPdMwnpwAK9MPX5P4OlRLi08KWhsQj0A0P4xzfv5aX5hxxoK6e+XG01PhrLEgDzZpfelYPPog1GCMTF2PJkx1Ud9PTWtKCQH3bVujqWE9QHKARytrvfGtpHhKs6TPjsavoAAfFitmb7E+5ZR2wm5Lps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952711; c=relaxed/simple;
	bh=pe5O18tmu7kI1U4i1B9McKxYAcs3ibtbOzy2oXWgm64=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Yhze3t0XggmkqI61zkj73U8+ll4MXsQG2GCaa+VYltyMt3PlfFU/oN9S8utE275uCiLXJKhEi0uo8UNjXUTZ6gz80LC9+9SxMk5wAZ+M9yLR5p4nJxqAp0YZOzKpc3QLVHKs1es1L6c4cFjVsAbx9YXICZmIZGxbdQEljC2KG1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coU4GFOY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coU4GFOY"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e0cd3bed29so244689b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 15:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707952709; x=1708557509; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zaBgKIlLJ9sWt9OJ671eQTFxO0fuZhaVfOFFEf/lIXI=;
        b=coU4GFOYDOdd0HBRpjf9ZBuV3H2Unr8IJgj2dIUcIAVCyMef1+PSqj2odEhEIcHcFO
         UVrsLIPHp2E19DjVOwxPa1Rfb+GPzNP5IKv1sZRiDAq8QAOD/lzyfYjXFv3rFR85LIxm
         cSZWgaQFkC7p8V90ZlyrvN0nWBypxrxCbmvmJfZb7KN0lshDMMs3vVFaOuOYgBwMPFj3
         BfAy+Mdvq5i/QNmfwnLt9jzkAt/Zw7rEI9tGmfvmT0z9EZoYvNaiLqbV3qwiXYOhk7PI
         26dgVzYSyLbPONHUuzkqg64aoG/DiuOvrq5uJFh7fGoKGy0WQhWUkLIU/D7rMPhCmzhc
         /VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707952709; x=1708557509;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaBgKIlLJ9sWt9OJ671eQTFxO0fuZhaVfOFFEf/lIXI=;
        b=PsWef4FmEBbzbDnRHgwskKORqL4k2KKwOKmZudf9ZaFkbnH7+O8zr0zfZkqs6rRCRg
         97/kB5rqWcTXQDpAwA8/HEvZQitA8D4R0FM2FlscX2HQGZy0kteRPKGcnyQLBPk/NOG6
         9ajUbkpWvjagLANuhX297oM+D2RpRRCE9doVmggCTaFNwNazXf6oxBNgfkHIgcDmJ7vB
         Rg20iypfkot4cVKhQsOWVFrKtj7TEUQ5gplVx6j39GCsB2CVnxSXQTjlfEkwUz8s4r+h
         kMfw3CWswU0QxdshGXePep2IYOP+BcyUubQjnlX60MGn8iLEmfHfhLSNx16KyZkG8TYK
         TCcw==
X-Gm-Message-State: AOJu0YyvdIExspm7AUh4AlAthA7iuE1tj5aQcq8pn72pMuHxaK37Tw3Y
	FDApzapRB8AjI31tMYinzwY1Q3vvtr/jL7mdxpVjOkci0YeuvzXkZ6ud6Rbp
X-Google-Smtp-Source: AGHT+IFocfOwGJRrYUUltZa5+HGIk8EiWYbJf9IUnAQ05jrcT/5Ndd21hfzc8sFrREDZ78KWdKsgKw==
X-Received: by 2002:a05:6a00:3cca:b0:6ce:6b61:2f2e with SMTP id ln10-20020a056a003cca00b006ce6b612f2emr358404pfb.24.1707952708919;
        Wed, 14 Feb 2024 15:18:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEnTNrlHwzd9PE+8nOv+z3djL3qvfuGynE0hHIMiaoKUsJ49bsNCEHDIIo4a+VkZ3q/AReJMmtaLmIYHs7o4y2fjVUBhG8g7FJDrJGWl81CSTpzok1sEqCjgMg
Received: from [172.17.0.2] ([20.172.43.102])
        by smtp.gmail.com with ESMTPSA id o21-20020a637315000000b005dc5289c4edsm4729487pgc.64.2024.02.14.15.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 15:18:28 -0800 (PST)
Message-ID: <65cd4a44.630a0220.d3b66.0b96@mx.google.com>
Date: Wed, 14 Feb 2024 15:18:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2406249881407791713=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+emil.l.velikov.gmail.com@kernel.org
Subject: RE: Handful of build fixes and cleanups
In-Reply-To: <20240214-hook-fixup-v1-1-0e158ffea140@gmail.com>
References: <20240214-hook-fixup-v1-1-0e158ffea140@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2406249881407791713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=826159

---Test result---

Test Summary:
CheckPatch                    PASS      1.12 seconds
GitLint                       PASS      0.89 seconds
BuildEll                      PASS      23.94 seconds
BluezMake                     PASS      724.63 seconds
MakeCheck                     PASS      11.86 seconds
MakeDistcheck                 PASS      164.98 seconds
CheckValgrind                 PASS      228.99 seconds
CheckSmatch                   PASS      331.74 seconds
bluezmakeextell               PASS      108.25 seconds
IncrementalBuild              FAIL      1354.33 seconds
ScanBuild                     PASS      971.65 seconds

Details
##############################
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:

error: tools/97-hid2hci.rules: already exists in working directory
hint: Use 'git am --show-current-patch' to see the failed patch


---
Regards,
Linux Bluetooth


--===============2406249881407791713==--
