Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E467034676F
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401079; cv=none; b=T9doJtO92gmQS9kM1JCUpEiQ+/yPdzw6n9cP8A8j1I6fvRr6w3Uu+wfOZNkuyHjZ8rHJngCR+WnY0CTCXPd8xyyYsInXgmWPECk57PYOrQnVL4oqCX3G6uAQ3LPy7V+E6jVn0W5wdczsGByu0gXYNI5VA0CLlimAZ7SvUJZizsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401079; c=relaxed/simple;
	bh=yma/7nQkgVXg0NqzWgncLk+OkmGT8H4qwLmHqacXLks=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BRjQ+ErJRsggyFiORYQKdofPZlxY6MzADvI6cgzdhba/Hriv0SbU9cMiAFVkN5anp5x2MDJmN4nSKzqZP0o8BINxBUj3JIPgXc3REELUMx6+zb5PEMIijsdLj8UwSRTBEPEUSDYbDQ3xgunU5eYkChoyMMvUgXyDfrdO7CUfPS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUqzZFs3; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUqzZFs3"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-137eb0d76beso986664c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 04:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780401077; x=1781005877; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6Wgy+PQn8mD96ijLKi1S2FAExWzfOKmY5MOZSF6pfBM=;
        b=VUqzZFs3KQNwvqBkPiw8lkpqDsklzDUVUMagBOJs2FiQYczWN3BmR7proZk5Wk8OvJ
         K70tTZhE7nfMga4gYSG4uKihMd1kQ3oCyjtMJJn8xnsOmENAXwkUpi8wsU4S/06qZvJ7
         nq4B2w1QkSS8OTrtF8CyzaO094u5IXy+Kb1tYz09i2/w0DYznlEhOl4UM9x5oAblRr3J
         oSyo6QfsyJHtgV5tdZWb3fW0EfUmQP17TVkBRKNvk1uVk4R3eU1aVgLljNrhGcgo8jym
         XtI+t7OmySYytc/Z6bG1huFBelvlktOZOQB2CF2OgVxLrTNzhXzhXqAtxbRIAfysgdpp
         m9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780401077; x=1781005877;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Wgy+PQn8mD96ijLKi1S2FAExWzfOKmY5MOZSF6pfBM=;
        b=ZJyZcl6mR9r9Gb5iKV83a764wmo9eE1t5K6k2ssSb2pasKOeJCyeZ7+JxWfamsb8Qz
         5RWgZP44yz3xlQrFKtW7xoPcTVXEKK2+WsnLDHsPdzhEgn8lohKO/EqHwjQ+uAt4tpHZ
         ts/5VMYasGEPmrYUZYs80IQxonr2ybbOVVIR6vcGpJcrtEBoz0Kwr1MfANCOUbyTzCB4
         f0k+oGJiZ9kEgtrU7eJlYLLuPekW1tWdObI9VyzNYPzjlaCVOnzZXXNH0gzsH5+E1OFF
         3S9p1wG8/UXPjJmC6ab+rPmZcgA0JQge/EhiNb9kFaT83cAZqduECE3NOiGq+/BWNBtD
         0W0g==
X-Gm-Message-State: AOJu0YylaDanXpS2PlV1K0Ijz0zG1OCt59GZRm/adJQDlzrHX29c655I
	p7QM+rgVMYhNblFSM5nKtzFMwh2WUYpGP097r8WeUAa2GdbddPKt/mxE3VO6uA==
X-Gm-Gg: Acq92OGhdus1ZsQ5VPAxfzdBP5JtoeegIFUu6eEQXYCLnBqIvwDZP+t39SkoapVkDtK
	TBnq0uSMEyjodWccuy49ly6FgaKDliXFgAsTWwpEgCDZTl5u/YmKwljB/9TBXh+RcMABaw3zFyu
	E2RbOKARpEI8XhZVhMy9PE963ooenUAJj0rUjOsu5Jrcv/r5mpuE9jPsmfSEKDcMBAhGUDAYibO
	Dbcz4u4V6vzYsYmmALW9lJN4QJHGVL/xXpk4WOh43rBp8jmaVa+lqYzWJlY1l8G0Q5/ZAxGOjjH
	LI+LcqGiVfRdB3dwp7OINaniADyVi1+q/P26ZZtyroB0pS2lumkodv8jv/oxNLMnfC9a7qfM7p/
	xyoUjtmbbJb9FweGhjbR+KlDZztD9lWzB67mgikdXhzKz1JT0eFpbFT+PTSBYKtI5cv54+GbEyg
	Rj9fdXqlSmQM2+MJfFjE3dtjxYDnhdmJwN9m9/B7M57CbY0xYo
X-Received: by 2002:a05:7022:108:b0:137:24c9:fb4e with SMTP id a92af1059eb24-137ee0b2624mr1367220c88.3.1780401076939;
        Tue, 02 Jun 2026 04:51:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.61.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b2d04287sm11581437c88.0.2026.06.02.04.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 04:51:16 -0700 (PDT)
Message-ID: <6a1ec3b4.c5bd3d48.f819.6f13@mx.google.com>
Date: Tue, 02 Jun 2026 04:51:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8336031789968332594=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raghavendra.rao@collabora.com
Subject: RE: shared/bap: add ASE Control Point error responses
In-Reply-To: <20260602082925.7061-2-raghavendra.rao@collabora.com>
References: <20260602082925.7061-2-raghavendra.rao@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8336031789968332594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1104482

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.41 seconds
BuildEll                      PASS      20.94 seconds
BluezMake                     PASS      623.38 seconds
MakeCheck                     PASS      12.76 seconds
MakeDistcheck                 PASS      238.26 seconds
CheckValgrind                 PASS      259.12 seconds
CheckSmatch                   WARNING   327.43 seconds
bluezmakeextell               PASS      166.33 seconds
IncrementalBuild              PASS      617.45 seconds
ScanBuild                     PASS      933.99 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2166

---
Regards,
Linux Bluetooth


--===============8336031789968332594==--
