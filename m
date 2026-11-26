Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795730356;
	b=wdyLOWppOH5MNC+Vs5Do53nNgQdOmQdelUiTWIBLXmWqZKA9uCkmSv5Nq3b06UCRITMb
	 /QzsCsTnr0O4FNoJFdcrg90x+loaUoaJi6RthNrUAOlHugmdn+0PUvy+a9Hd5Jzyoko6d
	 /MQ53LvlUQaJiTZFHEz4M52YabkiWvMff/3Hg1RzPr8utwI58tF+WU/djhi0nYONBN/3Z
	 W1Ve6vYJOCgRybw8wucRV4CWsmGmUKUj4Tuhsrjl9Y2DTNue/0lhzb7xMQCw1Oz/xvnmT
	 FkT9GPT5seMyUdKzQ7nHHi7Kw5xNQx8Tp0Raf7kmwWZf+DLgI5otyvJ6anSOGBe8RrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795730356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=848qCt0kVFc1YhnqPf24l69kQooFplbaUtHa+AGMnR8=;
	b=QkprMoy47rFCICkVPsAla+ciKCEEYjAx471h3DgZkr2BdIA3lnd3RFjFDSnvoXmB0SGi
	 p7z/7I4eCDu3XOhe6HsAGrV5hq3jWwtdrYkXTyVn2wEaG/r1P+7ha0XnVumEaB8QHKOWU
	 3W08IX8o5gHFByJtINajPZz15I+3Xi5HZ2n4hxwsGdiXI4uxgBQIeIzVkA0Xz+Ise1nl9
	 HMgrT9qu6/eYwLZZaLxNFYBsKyNSc7R5jJPzu/if7oX1+1ghvBW+HT98ACrcORQIOGZ1G
	 Xt3H2G1UMSCoxKwRDvhCTBL+KikSx2gQlYjyhY+kEnR8vBQMqQI9dW2nmFJZB4X1MgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YoV8eK3M;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05165606A327
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 21:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05165606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YoV8eK3M
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-57e49de1d8bso1867475b6e.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 13:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795730355; x=1796335155; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=848qCt0kVFc1YhnqPf24l69kQooFplbaUtHa+AGMnR8=;
        b=YoV8eK3MdGbb2VmwtHzSg8KfP9ur51okaJ8GoFFfCO8SKaglktDzO29F8QNRH/rwX+
         O8plnr4i2m+l4qZdcr3khW07AR5wIU1p5bvST5dfX3tIbRs7GVzr1Y/GMlJB7bWEInDM
         YZq+s0Gb+OB35NOeuqjvcIwKG3mHhMApYBNsVbljWU1w9is3UnQhNpuWSfJGkA/Ei6oJ
         ++NJSaECUQXmy4jx6OGu7A5fBb6v591LYwAyMHFPYu7i0B17M7EQAvJv5rgYcTZpndlB
         XozdEQuWpUzOlfBFOhzBvBT+7r/qBCoKG9LhNXsefZRO41g50+E3IYvt6q5toHEIqVie
         x8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795730355; x=1796335155;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=848qCt0kVFc1YhnqPf24l69kQooFplbaUtHa+AGMnR8=;
        b=dJDqlO210Zm6W6qGRydIVxVFrz/5WJXbaKsLHerngV8u/vTBdpNbDbyp2jl84bdo6Y
         kXevmsQsY5UOe41FVIUFQzK+F0amIyqz/eM87UKmY8hUI2ajHfAnSSPGwS+dsQNy+L02
         8Xqqu31FMlvcc57XJqvBLCbSyQp+nN0isRPOm2ODij/IPjt/UXcZ8qXWLtfYzM+TWOs3
         5xfduKqmhMwNX46JDXx6XUJd9bEsHNF2wJeB8yKFeHBbJBcWWnSwIWamYJn4nnKIEXhw
         ufgWZxZzgLyE/0PIxHXxcYJ2Pi0l3G5lPU/lvc/hNqWAFz3IohKrY8f5nVOIfKgG/rzZ
         JdKw==
X-Gm-Message-State: APuU4Z97AA+BNnQTIV6SZZILGg+4dLSnUI5vWwYjd1auDLRgc5obUhrL
	71qSqlnD81pSZNwVoHJmit8DW+KJtu31+rBgeTIYcSo31i4uK0swW53eYSU3Ag==
X-Gm-Gg: AZFdTZegYgLGlAZUuDBQX0tqzCkvmR4CUOIw42d35NZacSjKXjv/VvaseTOVV+OsvHB
	jmpUlMJItdj6xr0yB+X8H07o+R6ImEY3M8uqbUn390d9ofGLApEW/WOSs5eim61tPEBjKGc2A1z
	UKttKrdPzYSY6Zci9Il4gvVSjwCoZPlu/25n4qFVvFxQ0cANKqbAMvHwK1RZ2nBqDJtyaDli1gL
	66N53BhyAxOfciFJK3S3CvrCmQtH9UXvBYpuNuqEaXxiZ7s0d/4a8oiQ4J5aXTcLRmllfPviYYP
	yacEmq50W1E737L4A5oq125uYckahZmCswITvOjl4E2/CNY7xvGsCOkfBYXXFgi/7/+XJ8xw9Xv
	D9mC2HBxYRYcYFoIXHiqgk/jCJ55zikWJz3/fSrF0meJE4wfqkD5Kq6Z/BiJpfQNtQrx1H7BT1J
	L4NO/2csO3WElwoAG4TGGVqv6p0LYb9sA1nHy41bkmV0a2JKr4MILMhS1YKAhLnvURZ+OKrlzjn
	YdViYc99dWVcbSfTLRxRMcPDK1Up5/xODK1ssoLmdQ8zyX/WOPbfUp8Gcdgkuo=
X-Received: by 2002:a05:6808:13d3:b0:531:7f68:842e with SMTP id 5614622812f47-57a06d1a865mr23654324b6e.8.1795730354994;
        Thu, 26 Nov 2026 13:59:14 -0800 (PST)
Received: from [172.17.0.2] ([20.29.60.123])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485a164sm16220494b6e.10.2026.11.26.13.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:59:14 -0800 (PST)
Message-ID: <6b08abb2.4b7b8f83.4d2b2.3c1b@mx.google.com>
Date: Thu, 26 Nov 2026 13:59:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0096341998912288718=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, daan@daanbouwman.nl
Subject: RE: [v2] Bluetooth: btusb: Add QCA Rome support for Surface Laptop 3 AMD (0cf3:e303)
In-Reply-To: <20261126194049.123171-1-daan@daanbouwman.nl>
References: <20261126194049.123171-1-daan@daanbouwman.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0096341998912288718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1223678/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.50 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      18.80 seconds
CheckAllWarning               PASS      20.96 seconds
CheckSparse                   PASS      23.69 seconds
BuildKernel32                 PASS      18.79 seconds
CheckKernelLLVM               PASS      20.53 seconds
TestRunnerSetup               PASS      427.55 seconds
IncrementalBuild              PASS      17.52 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: btusb: Add QCA Rome support for Surface Laptop 3 AMD (0cf3:e303)
WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15027209.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/1235

---
Regards,
Linux Bluetooth


--===============0096341998912288718==--
