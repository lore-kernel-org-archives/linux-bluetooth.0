Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B92C225A37
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059021; cv=none; b=mhce2Nn9RLGvqRo91hjOz8dxTDNNQv5DzQaiUXecpR+TPCBiQfKsJ4vObNMu7/terlRGNnDmtuFRZJu/RllwKsy8J96+W+Y/IXSpgT9aERHmc+7H7geh+cRzit1JeUJzFrgN6oYDFFoIunWpADyJrs11XP3ayl2Hl9uq2Yb3NwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059021; c=relaxed/simple;
	bh=A80KjQQmIIxNHmc6yrvYPN5bW5UMdASfdVbFUngvf64=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GEhoOYVtr5t7gc8ZxNuf6ASuDzJIKe73/n6ywK/Vp3XGGk9Hz3EQmJttBeWD2iw4m9Gm2AZWo1QmTjdwMV4wzVcY4Dnl+uOIe8TbGXdir735skagUvJne1v99IvK5bsZqJL3ewylr08+OdhKsJZCjOsgt89EHtJbP5jbO2eLyks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTIbYrTd; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTIbYrTd"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-876231b81d5so435422339f.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 04:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752059015; x=1752663815; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xRk0BGiGBD2LMyBPRbWQBsFMAC9KCVJ/6UsYCGn2LdY=;
        b=mTIbYrTd4juTxeb7Kd8WpmHoMXCfGFKXNQ0mriPFmvGUDnwWeH7pX1KptUwb2C3qRg
         kEgJL3ktosZGwYS9J/on4FesXVLix6HzbApxwo+vlTL8+2k3ukSr3ViIVjOBaxAqQsap
         sUi2gTs6AHDNjZol/QgNReYHCrBv3F4jOa0Z0oeuBql8KkTCM6VDg0qPouORnWb1LOjf
         XLfidYPHTjWz6lZy8r7cO49Mw8TLFnz6KH8X9MswR1xfCgKXlgrmidND+J/yWFuHbEAa
         srZ9qsO7AeMxhKP4ou8MEjwQdIZq1M2GaILHq5OUISXK/oF1pp5larndo71cIbJIL6Ox
         u1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752059015; x=1752663815;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRk0BGiGBD2LMyBPRbWQBsFMAC9KCVJ/6UsYCGn2LdY=;
        b=xPV4azwiwqcH88kyVkyRD+t+tHU9MmfBB2at9lhlHb+JBFRrS2097zbKelf1aac3ms
         CFaPk64t32R3brz2EIzCLdG5y6KA70AB3P54NWzrxCOUVcxZB49IFmwOyOMZnfl5RVTP
         apnFc9kpIygskLwxSuCceSIc40igkVBI2NX8ri8f9uAvVpt2h0T9EXP2woiZvBXbl2qO
         utA6+bUcemvPqBlElRsn8gv56L9ppL6pWRFsejvPoQHxjzPTB0oG445wFrw0TkXRl20t
         4cyaJGId1saiNdjGLH0fVXrjYDHqYvKYEs+AW4W9yQNRHb7xnG1C7q/fpPvJ3mREZZnd
         QICw==
X-Gm-Message-State: AOJu0Yx9RWbDdYYt7n8tOQYbED+Iq01VDGaRJNZ8ACds+UbjS9/t8p9G
	o0SpRyGPzgc9Hrs3IZhQOBLGFePSaQJvshNw8YhsRgjD4mQQhoPMyUdoXa9Y5Q==
X-Gm-Gg: ASbGnctT0PAV7E2N8p5pQKn5I39FUy0TBqtwS8NoWsy7DdH9vwZHrYdleb6pAFnLA8y
	gpBZT8DltV6fkHk8TXZqW12XzakivsnwqAQ1JcFCDhCxFGlPLxff4TqbUMyyfMtpbrGFS95b4Rc
	NufOfHR8id2xBgx0KV0ZV/7/P1af+dfuQxEKK5rwNj6vEOaAfQFwq/3hMvJ1+w4aTMuuaY/SK9U
	lA5uh0cKSUPChuckx7yBjVfzWNCl1DNLB8xpR0OwmLXSOEPJb60BVqA7eXAHYIBRHux2zrujg5S
	ZXA3goas1FWmM2diuuT2FhxqH3PQdO9Jenx/rG492Hz8fGpribmrq+e48M3w8F2IJeAm
X-Google-Smtp-Source: AGHT+IE0AGT6Nfyn94wAsI/Yes86VCcjI3hNoHRjJUn1LFbHa74HS01l6Qi8MvDIsuUsqcNNXlpX7A==
X-Received: by 2002:a05:6602:3586:b0:867:8ef:69e8 with SMTP id ca18e2360f4ac-8795b088fc8mr238046639f.3.1752059015185;
        Wed, 09 Jul 2025 04:03:35 -0700 (PDT)
Received: from [172.17.0.2] ([13.67.183.124])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b5a29eb4sm2632537173.57.2025.07.09.04.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 04:03:34 -0700 (PDT)
Message-ID: <686e4c86.050a0220.14a0e8.470e@mx.google.com>
Date: Wed, 09 Jul 2025 04:03:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0736444544745039224=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] shared/util: Refactor code from strisutf8 and strtoutf8
In-Reply-To: <20250709094055.516584-1-frederic.danis@collabora.com>
References: <20250709094055.516584-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0736444544745039224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980429

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.55 seconds
BuildEll                      PASS      20.07 seconds
BluezMake                     PASS      2575.82 seconds
MakeCheck                     PASS      20.22 seconds
MakeDistcheck                 PASS      182.18 seconds
CheckValgrind                 PASS      233.93 seconds
CheckSmatch                   PASS      302.45 seconds
bluezmakeextell               PASS      126.73 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      899.39 seconds

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


--===============0736444544745039224==--
