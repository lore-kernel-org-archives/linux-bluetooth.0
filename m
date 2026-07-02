Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC75390613
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783014418; cv=none; b=qSHJgOCp08krFGy4ke7VbjIWCpec2gUrnDcDNI1ooqcS2T9EEmn9vvwe/zGayTBoDuWYkCKtlC5Us7x/JU4LJ318SHf/p4bxkr9aifd92eaJzxEPTcFLQ18UK3aT9z7VZYD/ioaR+pVgr9HxfXvDDyhf9wVDWVwL56h1QktG2EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783014418; c=relaxed/simple;
	bh=D17dEZJgwTJnXI12gRIiqlF+fYgtSJGIQ54wTq5HUmc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N5ivrgQiL07QB5dbxlj+7pw/EXqF+2WCppxe5/NtfqsSjSb3DxcJfbdN4I+AO4BYpZqRXANf+7aZGk3zPlMjvk4a+L5mM2JSwtgi3zbH0aE8OLwVlW9GqyYOMY4RjAMvu6xmaO8vhRHA4Xoj/IVfPKxhorLk18vycMB7U+wLeIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOkD94HS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOkD94HS"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cacf197759so840015ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783014416; x=1783619216; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RA+uVrr4s20yNc2XC735Fuez7yeyaO9aFNzIDMk5pD4=;
        b=TOkD94HSOchLmiB8i/tY96MyPP8YkCAcUx9kJGn1POTVrAKi/b/dF6pDBYQa+ZUGVV
         bQ3oFgod5OUzCmDUPntTlSCx6fhp1QcBGTMQW8l1KJYGIwBqrjvdiSNc77CYuRuVXiqz
         HPr71cnxcVOzln/TlkZlX98IQeU9ZHZ07wWl3XFO2NQoaBCfriD+6+DF2BreAGgbLASx
         xVLyESLyuG+naCIZpkzaOjnJwNclLlM/lCLs/UAmQlpnBOOV/1KJ/SJuPysPrqUk2cNl
         Wv0W5GVqsUNStwNXx2rVHcjgF/UtyG56WNKwZtQRjYASqccxvXPAoibWTc5QIdn2kyli
         sXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783014416; x=1783619216;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA+uVrr4s20yNc2XC735Fuez7yeyaO9aFNzIDMk5pD4=;
        b=qUO5ZmFxKfcsZeq5iF2rK/CFrdWSGK3nErft/9k8mpccK+01TVKAVUOnql1PaQcY+1
         vGaYlPrlQnrjxZJcy2bAvj1n09S21hl1FZkTWSyyAvKyeC8tViLCIvVdQcytqjX3ab8d
         0y1VTsPVKXSbzEswcOLeZl7cfZXqtE1daATM3MieocZ0BqOU+Tawho4zSdWChsEUbCB6
         V44eXDtpsZRa9Mqz91WQ9IORl4A4lHmXR3vm9XEZrC+Oe/C9l2xUQPi/nzComN8baxHv
         mXz16gZ3CM5Wuok+sLfgfYTwy7nFhNknWVKUIHWLYUzp3ZRhC+3rNBWMaapUdVr9kR8b
         U9bw==
X-Gm-Message-State: AOJu0YwcDfHsB/jfUHFSpr0q30NdzvmNpO1B2nIoKK3qYfjq+4xxkrCo
	5wZxN/fWNPVJyn+nvThT/QCDSIJJnevoo00YfezjU2otmo1FnQGNBD8jSXbBOw==
X-Gm-Gg: AfdE7ckCjaI/blsonGmxrWsmwaTnnn7YDgCweQTn6ibdymJglJ6gSIjZRpA/pdiuXTZ
	c1H3VPS+JQVmBMUwPTHkvC2dp4/h7biHNn+Y/u8YcMA7ADelfaxcUen4j1rE4fJXGtQ509Sy+UU
	ulSklhniHPPxRJ8+c9rCIuOhMIy2rpDC7IJGJt7rz6Z6zAynEw1XcE3vCEubR4yziEsy/9evg4l
	tf2bgaWI7YB6nsybIERh1hHHZnhtwr20He/fZmBqgcu9N5eBDGufkyOlo+zvk3f/Pns3y93musQ
	rrt8teslfkvmHZn0p0Q1u1YwYCTjbY+fQbOLte2WZBTaa52FmOybzTJAKtlbpVwvwbAo0sM/eRf
	a1of8NMEy7vJVSx84oXpDJ+EdflyPaPIAdvB/Fc0E8ILVnNgG7nlcP4+6y/XxaFQvwBwwuw7tCs
	zFEuHoAINbgxOoNNmlEFb9/Q==
X-Received: by 2002:a05:6a20:9f93:b0:3b3:fdb0:2295 with SMTP id adf61e73a8af0-3bff3ffaea9mr7000592637.6.1783014416360;
        Thu, 02 Jul 2026 10:46:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.213.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc2e119sm11288508eec.28.2026.07.02.10.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 10:46:55 -0700 (PDT)
Message-ID: <6a46a40f.abb10101.208f3e.9622@mx.google.com>
Date: Thu, 02 Jul 2026 10:46:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6297803947239899383=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] adapter: Fix crash on dev_disconnected
In-Reply-To: <20260702155037.9931-1-luiz.dentz@gmail.com>
References: <20260702155037.9931-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6297803947239899383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1120587

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      21.00 seconds
BluezMake                     PASS      544.95 seconds
CheckSmatch                   PASS      312.22 seconds
bluezmakeextell               PASS      101.33 seconds
IncrementalBuild              PASS      539.68 seconds
ScanBuild                     PASS      962.30 seconds



https://github.com/bluez/bluez/pull/2264

---
Regards,
Linux Bluetooth


--===============6297803947239899383==--
