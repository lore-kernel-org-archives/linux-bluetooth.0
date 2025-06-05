Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7C523741
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749156684; cv=none; b=kRVfTCsS/zWPZzvTcXzArKjrdtgqoQmmEs1GyD5ymiry5YAe/0FscvxnHftKq+1L9GMhxUdbidc4V9Mw6ZEerVPdiy1aCT5K40fsOTjP2BvxS6CA99+i1Cn9E6/LA+vdAdLc+RaVT9JOz1HOvEgLCz4ElFzM8FKkd0rQRgjc4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749156684; c=relaxed/simple;
	bh=W66JowHtCKeyuqx0Wds5nsZ+FcrsPAjdwHZZyqhRnuA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=smuzFzdrJjqCfDg16ESwhjWi2SVzlPyijXeAr/KcXxmXOypNX6UNnRTUzEJjfZaiE7DVduHdwqt3gavAMr4qrmsreQwf1pq/6/gkNG5aVZhc9vO9ezB8d5ATG48xADl+6bbDH4A0vTtsPcYR5GZOlhFcHueHBUxVh7jBo7HSncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvkIHj5y; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvkIHj5y"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d09f11657cso143570585a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 13:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749156679; x=1749761479; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SAVlrWmKNS7BINMA7p4I1j7H0lT3iAitF5UMUoK25SQ=;
        b=fvkIHj5y5AM4xG2DTrz8RlZj8peikQgxlNNnOiCEkF6SJ/qeDLvSDGUgQRBZs80SXb
         yDqsdSRh8szv8psZernLTeCZX1LoFBayB/z1zHO7sfYbGaKejntac45OHOMK6pI7hIgm
         LAnwVWRNAKt/VA6LB9MrtxHiKa9wBCiyajSKps5KIQg7s30hytwu+avSUmEf6S9zzOCU
         2B2LtwlE8R+RBbsk9R6yoJGoSd7q4FodFh4oboGaFIVvMSI0uGG77rne8s50sduve5UQ
         bb+hVmpuGV8ghWIFgzEQaK3kUap5UzGeRc7TaYa+jIpt9hQOCkXw7/+s9DDtDbv9y0Cu
         epWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749156679; x=1749761479;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAVlrWmKNS7BINMA7p4I1j7H0lT3iAitF5UMUoK25SQ=;
        b=wM5d7OiYvtH+LUIPGQZZ3AqLSXgqM9q5qRwnFbbIwQD5Bx7to9vG7ShLP6/hdd2paK
         BJL2cirV4u205NHScFEdFVgUctImWMOuhoTSF97dx300fCvs+MYN/Q4Mur4qxEDsuonX
         xFS+GgRuPUUikHrROO8ibBnw+SpSYyD4UwtD4I/yYiFRgJiceQyE2QT9NCJwRl2ftjWJ
         wgUCXbNcmkoawDHo+JSlFUM1cA+c+icv778URLYn5uCTs4AKWls1A2/MqsP4rhWrlaYe
         H3BXoPx9TBlsDa6VjUX0lOipMCSzB1qoFzuy5FzTsNe+J9+yaW4IFoJPJHIX2gusyGoQ
         CiaA==
X-Gm-Message-State: AOJu0YynjCxRoaKdHwx6q8nWj0kU9KP0tRPCNWYPVKLatuxhQ38RtLmq
	hWqjakcgMDjbJfqU8dEpPwLxvFP3cnsUyz6icPmGNUr6MlmlTHx+7avJRgX+Wg==
X-Gm-Gg: ASbGncvDhrdvz5Tz/zf6mq5468eGvQMVnIfsa40LHaKCvd95diWG0OcpAmHvkIrdFLs
	J6KJQkgOFxv6PgPmSVAXcdz/jfiA0TfaH9m59XJgE2fRRE1YTekFk+W+fM+otgYtow2N6DqE1n+
	kX0I+Qs3HcMgmMmi9qMHDIIU2WTGWjmPbz3/OcY+O4RbFqEIw4iTfldLemzhTtWe+IqxvrDWH4e
	dvze3dDSDQqPWYLhc1/IwlY+5Rt9FXLWuqfh5uLUcMUQ5siP0C4nzo1AAdTQy63mpD4PsRk2TNa
	cKJhhRJpTs6r989EUf5xFz3SrhPrDYcv31o5lHCyB1y4JS6WFRXhcAKB7SF5RXLwScE=
X-Google-Smtp-Source: AGHT+IGE7Kege+jV2fB9kVf2cus8OMJ5LY6HDtvwrJa4HsLiFlxzTirG9HQVCKiCRe/7nF268wpgYw==
X-Received: by 2002:a05:620a:2412:b0:7d2:fc7:9572 with SMTP id af79cd13be357-7d2298eb9bfmr140912985a.57.1749156679314;
        Thu, 05 Jun 2025 13:51:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.12.48.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a61b5fesm18235185a.93.2025.06.05.13.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 13:51:18 -0700 (PDT)
Message-ID: <68420346.050a0220.4d5f9.06f3@mx.google.com>
Date: Thu, 05 Jun 2025 13:51:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3159387906904387694=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] shared/shell: Add support for -EINPROGRESS to bt_shell_noninteractive_quit
In-Reply-To: <20250605192406.909397-1-luiz.dentz@gmail.com>
References: <20250605192406.909397-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3159387906904387694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=969046

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      20.44 seconds
BluezMake                     PASS      2696.22 seconds
MakeCheck                     PASS      19.90 seconds
MakeDistcheck                 PASS      201.06 seconds
CheckValgrind                 PASS      277.43 seconds
CheckSmatch                   WARNING   301.60 seconds
bluezmakeextell               PASS      128.65 seconds
IncrementalBuild              PENDING   0.22 seconds
ScanBuild                     PASS      917.34 seconds

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
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3159387906904387694==--
