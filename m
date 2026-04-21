Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D264C6C
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793190; cv=none; b=VDcqFJhtThBDLK4MBzmsTbDaTasYl46Bk9ULd6xQxJsv3qpy2M71n/iEkFvkLo5Mv//BS8PCUOzip2hHHX41PlIpzeKk6o29DaxXTUY9ACp6C5MhBKDxPxG7uxdcbkO2avjdmJaG7hWyjlZH+fY9JV4ha+b21OpTUmgOXxaTdO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793190; c=relaxed/simple;
	bh=J3YaYDo1Y44on77sykR38Q8w/5TogE/aDdIIEEScWp4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fVktqX2qqoOeR28+c4Og68JrNwirGY2BNxyOwENjSDJXpsJt8Vbkgvlgmr481IuXl1F7G662/V2f0o/Uw85exbotaOfo72XC/fbbHYBpvIibSh1mbHJ3qKNPnVMA73+bOMuvDKGO4JGzF9o1I1JH/AR74KdZNUnE1cmg09T5xzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sETH1ohg; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sETH1ohg"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c8cc7a77eso1630725c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 10:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776793188; x=1777397988; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9CtK7kumyUC9OtcBFYfej3n4U6D7ZI8siessWUqziCc=;
        b=sETH1ohgH9H9ghAjkiM92sp8fI91izjr9QxEzdMO1nputwAhagggvDjFBg2sDbfelM
         CXEFu4Ea+PVb1j2C8gO7YBqPzQT6Wd53d9LMSELPFb1wdH1eFO7RsP7+t5rSYpWxXlBN
         WpUFSuKGPDKX8RaK0h8ehKE0vqrL7RxCBgacQx63lS/eNIhD7DOctz4TFTifbxs2bcJf
         5xz4jpHQkwQo62LZP+94OqAAM6Rkjz3W5EfR5RqMG4hG2vNiN4ua3lyYvQ9+0cXN3rlR
         f1GogHhFnrZTZom31KTWA3guLw4qbC8BWIzmL288NLO3MQDoUqV8y+uXg0pbKw3vS5Ma
         jiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776793188; x=1777397988;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CtK7kumyUC9OtcBFYfej3n4U6D7ZI8siessWUqziCc=;
        b=AA8+EXzY+xsnJQWcYA5eZokH/a3F2wDeWzgBM/gOAGwsEjC+q+x6FBjDi/5ekLkatp
         gqNPEHoc8e1KMbYDkO65DKMkr9DYRzNAQ99IMzq4A944O5+1dQy0tDrxJu39wPf482Np
         Zwz/ut7VKSss8NGdj/SzMvCzyeOaIP61wky5KiBVzwSj5WHsoFEqqr2907z9cj/pPkXV
         IZ0tCX14vAz+dBrgoNX8Cp2eG/CW7LFjAISjFkjVLKAC2khwC1GoUir1A7NuPmxJvlUf
         PlLbdkufizWF0ekuKJqM/wcBKwOOSFXzyY6u4U4tjhWbGB6QMw85wvm9qFwXF+ky4bcd
         2Dsw==
X-Gm-Message-State: AOJu0Yw4GOYaxS+CixcEzMu0Yo47RQqG8L3hWE9DD2mBYodFcGbdsayK
	ewstYeQmTPqNnbsASXtoNzlzHB+mjO7p6PN7lhJhqhZ0ml7BazFIKgesubDvSg==
X-Gm-Gg: AeBDieuGBJcava757uELf+IqoxP4VvzZfJuF2e0KY8h9XN2sKvUDXAMJwMDqTZ0czNz
	qfo/fLYPIhnCXkR68D1aiw4y2XUCLMa5+nFEMMKDTJSk7sXBgZcaRBKVblTF5/s4PzAdifoRPl4
	gs//aa9BwoYrhrQFC/17ebB36Fyl/U1ZatJtc118uvquWjS4KXrShSWtBZwvM14lTRRSBJYWKyM
	fI8cWQtogYtCQuWYmsuUn2ZNJ/AIN3I2rT8f14Q5NJqMq3p0BzbtjNXm7h1/6NsIW5Jh8bXZSRu
	U9RNSHSHUxapdk76FlCAxJLJ5b2hHqpiyP/JIWO/ntIRWlxWC0j3Xf/IVyIq7p3AHCGtD7umStT
	0kWcHcUspxgfSYgwKKpyJ93t3oTY9Jhwcsbqy7//sd+fULse5WGQn+djNrXOZw6LDsaYTA7bbuM
	czAkg6mUifdLcSMvL219SuLoj6pTW08kx3EcaY0XvZoZo=
X-Received: by 2002:a05:7022:423:b0:12d:b2ad:fded with SMTP id a92af1059eb24-12db2adff6cmr1671051c88.10.1776793188080;
        Tue, 21 Apr 2026 10:39:48 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.210.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c919266f6sm10235479c88.1.2026.04.21.10.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:39:47 -0700 (PDT)
Message-ID: <69e7b663.050a0220.150fee.e1ae@mx.google.com>
Date: Tue, 21 Apr 2026 10:39:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5340692345258249664=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] doc: Add AI coding assistants guidelines
In-Reply-To: <20260421155141.1863559-1-luiz.dentz@gmail.com>
References: <20260421155141.1863559-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5340692345258249664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1083932

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      20.06 seconds
BluezMake                     PASS      638.04 seconds
MakeCheck                     PASS      18.28 seconds
MakeDistcheck                 PASS      243.02 seconds
CheckValgrind                 PASS      290.91 seconds
CheckSmatch                   PASS      346.63 seconds
bluezmakeextell               PASS      181.86 seconds
IncrementalBuild              PASS      644.64 seconds
ScanBuild                     PASS      1003.11 seconds



https://github.com/bluez/bluez/pull/2060

---
Regards,
Linux Bluetooth


--===============5340692345258249664==--
