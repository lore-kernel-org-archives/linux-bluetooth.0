Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546134;
	b=IBSiFU7B7AedO99bk4QtoajN1WFSC6CZKYq6BXkJ0xAafAB9nqHhDc9TdnHsMH0LgtOq
	 8F7qrN6cYhgbD+w0wZSWfQZODCcmOjaewps42NDysemZOGptx52uTQlZUqFu/77LX0o7v
	 PJNFdoILE5ib4lIPKSFnU+rSU2RRrsSHrvz2MmS3zhbJKWmdDFvBLyFKPB19AyYM6Aj4d
	 FhhO5NuIL/GQX4B3OQts4Z8ije7Hfha93RoiSRprJjdQC2SmW+mx0hFNRTIo6cEVOW+3q
	 rM1x6rVBetSnz1nKdg1xEcyW/PnOsSLR9ne9G0zrwXCtGtUCOaJ9UVj1qKHX4SVcbdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=tyHlTFz9S9R5P1qwSVnwYH5LkfRkuXeGRKQxh6Q5F1Y=;
	b=Aw+Zr5LHCdnfCif8c6XVemZxj7LqMHLuCe6i8qUPINmRL7059ZpR7grntY3Hj1G+B0Cm
	 SjIqg4y7LiflbKldwuU4oG1dl+mquQ1g+bFpG2muQLr+Toz3QqDTrr1cZggfmisacNVvg
	 LjUppHoTBvI385Pd+5M3RpPXbXqYC22sxHrL+Uv4bLCQp1tKXLtYo2SXQCoUC+L9p85Z+
	 80cGp/EQYIHhvGLMnPQgJFmWiTpOpOKEZHIX5z4/gNl+RajOK2uwss+iyRj50GNMJaO6n
	 EEi2q3IH0RroSRBH1cK+DgTI9nNUUy8wec7/e+spgQktjJndrfiZ+uh3vDb3UAGbHRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b6en03Zq;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C12606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 18:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96C12606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b6en03Zq
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4d7034a99a9so2898243b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795546132; x=1796150932; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tyHlTFz9S9R5P1qwSVnwYH5LkfRkuXeGRKQxh6Q5F1Y=;
        b=b6en03ZqdKdV7yZa1VfeDsuzXwcPpkUv9OlaHYBdhIxkA6/hCs/75J71J54u7FK9Kv
         o/Tw9M6qWhhBPo2oUnYWfUbDuE8ahoURXoVbtpK7+3yf9FYksSGopkUQkUlI3Pgfk9Zj
         0z1yd5r7K/H2No8Bqfk91Q5yDO6djEz58paR9F1IXHP2hvX1e6FWHTgLYw2+g0WV7PSm
         r1Cpduge+1An5BLOL80P3Uuh21Yt1USR5j10UwO/H8feHbajME084t+F0SwUHEohDZBC
         iicV/qXFsvySLPMVjYG4Y/j0lK74JyJoutbT4S3gX7JLt+muvVffouDqJ18EL29JjD2Z
         wzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546132; x=1796150932;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tyHlTFz9S9R5P1qwSVnwYH5LkfRkuXeGRKQxh6Q5F1Y=;
        b=fz7xTxl7KUPrhU2QOHltiMETkn3pQkPDHwyxbbjF+iOCo2gAs10ggFCBGsgOtsZWSd
         KrW8FYRGYUX4HJvnTx3A8d7XNceBAMo41oGeho3qKjDUPMUvj4rswVttyvNAPefwVGbo
         M8GRWtrPL66mCQ5KgX3jFjh2wyoLX0SzIu59Ua/N6Bwyunc5CCIOYxfW9HVbTNYA4lwx
         gGBiSwH9w43xcKyef2ULfs4WMuNChXS3vGiOS0+9z4eHj8VVMKdv1WMwD3rtY/Rrq7WR
         kHEMC7fvfB4+Y5dGE7u1xdUYETv4VDq9L+VuetFfRvUiqEzSlGkAJg49eTLm5ox3zPWs
         XPkA==
X-Gm-Message-State: APuU4Z/WF59NA4JC0RYtPOwks/A4gWbgRfPW5X4yOnxg/733BZMwrxfn
	irxLzUYROlm89rnn9BOAnBYInnzZRlo4RICD5h9rYUl0pIKzMT2kS0TDrq5YJw==
X-Gm-Gg: AZFdTZca8heWn0paDQXnqmkx4W8uAwsq/ErlryHwRdOPO83w1frpHROGvcrA5pFUhIC
	UXxPLbkPBQAYUH3rKk7SbHAly0WAx5QB1F/JltKbl56EpNM60KCogb/bfemeaGbv58ooM69nHT/
	9EXoIioDLnIaFRSL7uBhk/OXyL1/Vd+voeY7c8mfopMAZULT/9WqIDUm53RyDWwuocie+SiD6XU
	NnsGOfaktpHgfd4FUJGrCaar97SH5Hch7Vv6nc6phLbKONjWfgaU6bI5N6ENQ3/vzjijsxajN6c
	QF5p8JiMJZEfMLeyQrbLit4v6cvps8iB79Dv87C+ZBDPniGyVmeSXX0ol1F4HgFyD33RW0snRrQ
	h+tYEAG/qDY2891ZdKKTA+nBxkcifxYA3btIYMkQ5ovjdis+msbhYF5frTvUbL/SHgLTe6LAc1F
	xhE257HR60/oOKLHFynImyC/tMsNTvX7QS3V28seCSp8wLFJARTgor8IysZbGsAlwlqkZW7hUUq
	9yy5EEMLHkGUrbkjozX6Xi4uryFTmfm21n9tmQBX37i3JWHcK2lvGNMpxJkMNA3CGIDXzf4HzNz
	m8qqvA6Crm0=
X-Received: by 2002:a05:6808:50ac:b0:53b:f634:83b2 with SMTP id 5614622812f47-57a025f405emr16763592b6e.0.1795546132533;
        Tue, 24 Nov 2026 10:48:52 -0800 (PST)
Received: from [172.17.0.2] ([130.131.205.179])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a34252251sm12599563b6e.6.2026.11.24.10.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:48:52 -0800 (PST)
Message-ID: <6b05dc14.a8342903.a6b10.8976@mx.google.com>
Date: Tue, 24 Nov 2026 10:48:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5898277908821522874=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [v13,1/2] Bluetooth: L2CAP: Restrict LE credits to connected CoCs
In-Reply-To: <9d9d37680044266dbd1d6919b08564026afcd87d.1795528595.git.github.filter194@slmail.me>
References: <9d9d37680044266dbd1d6919b08564026afcd87d.1795528595.git.github.filter194@slmail.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5898277908821522874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220931/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.59 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.49 seconds
CheckAllWarning               PASS      27.91 seconds
CheckSparse                   PASS      29.82 seconds
BuildKernel32                 PASS      25.18 seconds
CheckKernelLLVM               PASS      24.71 seconds
TestRunnerSetup               PASS      572.47 seconds
TestRunner_l2cap-tester       PASS      15.27 seconds
IncrementalBuild              PASS      23.86 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v13,1/2] Bluetooth: L2CAP: Restrict LE credits to connected CoCs
WARNING: Non-standard signature: Assisted-by:
#92: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#92: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 0 checks, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15017328.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/1217

---
Regards,
Linux Bluetooth


--===============5898277908821522874==--
