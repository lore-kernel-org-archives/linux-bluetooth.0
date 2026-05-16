Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B4A299A84
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 05:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778908275; cv=none; b=HaWXtnLTC9LgMT6WDSKNQdQEHnFVxl7mPsVXMHRaDfki+3yUN9aoUiQ9bdRe8hWIkais3qC8KWxe+q4aLQoqpjNr+wSk9xtMQwkpZYtsfhLLCC0jkesujMKuIHYIsIqzRBONX211qmyytvcF9DjOoWWQG1VJxkpcIGECDiqxG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778908275; c=relaxed/simple;
	bh=JLhK18spJ/bUUy/PHGcKXRJt5GomPFSLm9Fqqf9fi+g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZcxxlwuG/iqbSHf3ydi8WKRKrqVJlklYu0E4gxtPJ4jWeiWy2sCcRR6yFFM7tpVtgMvNLoyRqEvoAt8dWR10ZY9pPTREcctoFPt7L/aQ5y72asYK2n90RY0xbeACApMe9ZVuJgsTQWt/pCRdSHSG/ftv/O1q+cCFGUSMx/MDuKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6hW8rJ/; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6hW8rJ/"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-912278ed3b5so81390685a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 22:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778908273; x=1779513073; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aQhkjHe1MhTe4OONQbKn5eA//gR1ZmNWtUwFuEhz3cg=;
        b=W6hW8rJ/zHmRcxsYn1DnlzBOb6otxko56u2yE3KLBgKUlsJ0i4p+DMi0uR8TIizBMm
         vMGJtEX2zkJ85bAfc6fmlnH86WlVwvvUMug4SvZxGlT3F/k/HAl7knCNRv/QicDHJSoY
         iT9T4yNIEZIH1AMUqlp7dpRwAGmVL0A/ykNNar+IqP7pvYkZBbptKhE/A0JFJCfqgk+D
         4jfHerPZiybv3IE9/LHX/9jG6z/UmogNFHP22m1BzpqgtfnahoWv2jUqwYF7VDSTPbpH
         z9xb22XPuz11sYOU9/RmFG73WDvyTGlH8/ITVXAfNs8GRq7gr8240NmMCaoCNNeKQuBv
         Dibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778908273; x=1779513073;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQhkjHe1MhTe4OONQbKn5eA//gR1ZmNWtUwFuEhz3cg=;
        b=aWedmDUoSbz7zxhBX1XLI8fauMOW5mF2ZZRdzMCmKfcnrF0+z82XXEPPfm/i0vsJSO
         1AtPgI9qtQL5WJ7uhj8NRgk1PiLnbWUOmeunTsojv/O6xcKFSvYAtjYTdFVkxUixRMYk
         58RgRt2Eb8jhUpxw4TNHXlrnhAz+ETPj6AB/5c4i9RCbkVQIPbvYyJLIMQZMeCCiohfP
         /86jFoUU3CU4y10lwMo5g6j7Uanueom2+kuA4ZjqoIs4LkseegoDzArK4CKJL+Rjfx9V
         j9J4uTXZifsbf+Nhm5M7mGSo/ZEod/OGW+oCr9DqEzKS0cCOiFGknqV+Va6LAQc7vQzD
         DFaw==
X-Gm-Message-State: AOJu0YxF3K2h5KBfCH4F8mhr44gn5j+jeis0ES5j1Hy9HVmzG+AfNkaS
	uEnSjy2/oA32e0yzbmtcp7MAAemrfUzCTQ+Fxb+4slhWBbKckeJhWRuYsNVXPQ==
X-Gm-Gg: Acq92OFsm8xFl3/OkiGAOh9Nj9r/7qSL4+luDDNJ8xiR7GoC8SBNgvrqHRKFOcwonEi
	A4f3ZggCdFgLJ4CEh4TR9CEw2BwTzsQ+wPf9PQ71TWLJZcFHNnWkcH0OMLzbTXDZv4Vcujwlei/
	myogwCUyyY4XjRBGoSG25yiaKPRLeaOIB14JV1I20h8lp+gEsUKBVKVDzMEA254qyrA4fR6JNPR
	o1l3QiTgI2JjeT4O+TEHI5KxYrnX5q1E4hj5AetIjcy93+1JxjoD7lowIk/kciI7zD/umER4a4t
	EYJF7Nn+4aERyEXnsV/N6q7rFQ6/1LVmjWr8+m2xqbgtACrGA1XWL31IPGIHwDhjkchnkO9dycb
	2Bvcd4BqXSzEovZe33ntgBbrdrKapKmNEL8yiquZ7z+j3frPwWH4flDdYM4yF892/HnG9oQnJeG
	o0pQBRQlhk501PftXFuvEyla7D/Cp/46hcIDqrAyJgShc=
X-Received: by 2002:a05:620a:468e:b0:8dc:5094:ea79 with SMTP id af79cd13be357-911cf3f622emr1154979485a.39.1778908273203;
        Fri, 15 May 2026 22:11:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.207.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca214cb980sm15744306d6.38.2026.05.15.22.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 22:11:12 -0700 (PDT)
Message-ID: <6a07fc70.81b64c21.11d712.ed40@mx.google.com>
Date: Fri, 15 May 2026 22:11:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3922752444224695981=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, w15303746062@163.com
Subject: RE: [v5] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
In-Reply-To: <20260516022200.396369-1-w15303746062@163.com>
References: <20260516022200.396369-1-w15303746062@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3922752444224695981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1095737

---Test result---

Test Summary:
CheckPatch                    FAIL      1.88 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.45 seconds
CheckAllWarning               PASS      29.64 seconds
CheckSparse                   PASS      27.83 seconds
BuildKernel32                 PASS      26.56 seconds
TestRunnerSetup               PASS      586.79 seconds
IncrementalBuild              PASS      25.50 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v5] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#88: 
  ODEBUG: free active (active state 0) object: ffff88804024e870 object type: work_struct hint: hci_uart_write_work+0x0/0x940

total: 0 errors, 1 warnings, 24 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14576205.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
16: B1 Line exceeds max length (124>80): "  ODEBUG: free active (active state 0) object: ffff88804024e870 object type: work_struct hint: hci_uart_write_work+0x0/0x940"
17: B1 Line exceeds max length (86>80): "  WARNING: CPU: 0 PID: 338273 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0"
57: B2 Line has trailing whitespace: "- Moved disable_work_sync() to the very top of hci_uart_tty_close(), "
58: B2 Line has trailing whitespace: "  before hci_uart_close(), to prevent any concurrent re-queuing "
62: B2 Line has trailing whitespace: "- Adopted Luiz's suggestion to use disable_work_sync() instead of "


https://github.com/bluez/bluetooth-next/pull/199

---
Regards,
Linux Bluetooth


--===============3922752444224695981==--
