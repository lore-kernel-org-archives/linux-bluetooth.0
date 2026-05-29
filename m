Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFEB37A488
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079011; cv=none; b=lhy2Ct92W0lM717gRfJpXTAP6eaYkwJrfTKxxSbq6jaKIGQW/NFiowzIWJqInJAXyXumrM912WtktZ2t0DeB0ffY3BGAqKOWnOjlvrHcF1ZEWuvZeyfSfkbCRheMR7J9Ye4nvhnUAdQx8JLypHmM6vQSIiHlBJdRVlmt+4f1YxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079011; c=relaxed/simple;
	bh=7I1zuEfEuhbGWn3f3O1OuNWZHlcFSCVdPdmgKqRTPi0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S2tjDAxQZJXuUA9y147bdNC9FnesxIRBEX9PoW02IzQgwYyuW4Zp3kklPkO6Sz4tJeDL9XlC7h1rqnN/guMW5+kPrpN96gbMirzMHSxbbbhnWJBgwzFuvEphwk0xpQE/jtwXWdqhflHG2EPTdaibHJBFXKPhSN2weY0Otg9QNgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knN7mb91; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knN7mb91"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-914db83362aso620438885a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780079009; x=1780683809; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gfXC/TZbGJrilvUL/reAtYeNPlorV2yuuNA5Gfn6B4c=;
        b=knN7mb915aDt/WBMU7xzjRbLWBlVJicjTmsEqsY28jlWJupTxiGof9kEXb+1nwLqrY
         ZJO305X9/xVdRt6t1KHSx5D+4Nq7dMuuUO8sonGwt6lXAsLru9vXuetPo5Kl9XMzPloY
         Qf5jcSgXzwvxyoyoBwrb3s2diksY8rrd+mdaBTpXyQSoGBasGZO21pwxqJ8rdWTqTird
         LIsS018r5tjq2W0gz19egWBsInqFecY0csE1vlN3DASUNCv0LjltUCftPGPoaO93eUgR
         mj8SFq0ds59RnWdpvbnzKyGzcFwhM1+nUCmT0OmEcmCMWbqvK0G/jqaP7Z45+vOljVW9
         59OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079009; x=1780683809;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfXC/TZbGJrilvUL/reAtYeNPlorV2yuuNA5Gfn6B4c=;
        b=gb3J0DpobRU19CRf+yR4HllMqvGyXwquiBVvQRn8y/CDayYlQO8StxgfhgfwucvTRF
         3pABLSrcx4/Pq/yIKIPJNST9WB1uBvYNCx5F+KPMwzI30/CTJRO/i3RKQ8NokGMfzPQ+
         NB9WcJncEquuLMJSfLb0Y451CyD+1aSWIuv8o6N6z2OV7onE7o/TNt+OhUJ7XMFgYhoZ
         X+sZxUn0dtdNp544U8vDoKeoDYhugsU+BEbFcJFbiMUwf2TiJPROlgoq/9CUvuxetaW7
         JHjOfWBNks2laFxybl2XO8qEiV4domKPBMCcCNjZuZ+FGNOWu1E6JBnCH8mOXl2r8u/h
         haTw==
X-Gm-Message-State: AOJu0Ywer5R8gBagiF6NJp71/kMRdYzNyz0/c9cWxhHskFLb+adGr9Jh
	/103YRtfJguu/NivfsY3k1Fw5qPEywfn+Bw3Qxt46hk7lTgx72WWdbT+Mxwr5g==
X-Gm-Gg: Acq92OEe8cVatVfkZm8xhbXlIiJxAPRjka2AT9mg6UKOa9RIpzXMddzlRH0rxCptyRH
	MlAy3EVvuy+IAu5XW4xRlEf9SNCKavZ3w/X+EYD2lI6gzlNBoyZc2bLEHjRyVY7qKae8UcWNcjH
	jHWcWfujLgAlnOIprxYXlXvqjbWxUqnON0lOPsnbbQwUvTbjlQNoHyIaImeKE05Uwv0rrJzqIcx
	d+DeBBdPT0zXVMOEvbFnABKAJTwBvxCdnLr4G/jbEBHzldBHNc5jOAUoqKg1E5crp2g3EY45r+j
	5yaRUgwfXfYZRmn/qyZxzo2/Yq1WD7RYKhjKxw3I3ydYqEcNYNVys+5mxLy7jeEaLjHGkoL6zfT
	5oSHZKPYnKP52o5kQaqH8A8MS72UW+A/qdSyjZJakcHcLCKY2+TMy3FBLk5BLsV9Z12JjXJeBtp
	v+enGObgHYF792KVPA6SGt5ako5o7vbAzlSg1ZGgM=
X-Received: by 2002:a05:620a:2551:b0:914:c130:2599 with SMTP id af79cd13be357-9152f950c40mr513639285a.19.1780079009243;
        Fri, 29 May 2026 11:23:29 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.55.57])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532628f87sm268664685a.35.2026.05.29.11.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:23:28 -0700 (PDT)
Message-ID: <6a19d9a0.517c639a.158ef1.0fa2@mx.google.com>
Date: Fri, 29 May 2026 11:23:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7787169088967849881=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, suunj1331@gmail.com
Subject: RE: Bluetooth: Fix data-race on dst/src in connect paths
In-Reply-To: <20260529173347.43967-2-suunj1331@gmail.com>
References: <20260529173347.43967-2-suunj1331@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7787169088967849881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1103047

---Test result---

Test Summary:
CheckPatch                    FAIL      2.45 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.67 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      27.00 seconds
CheckAllWarning               PASS      29.72 seconds
CheckSparse                   PASS      29.31 seconds
BuildKernel32                 PASS      27.06 seconds
TestRunnerSetup               PASS      556.66 seconds
TestRunner_iso-tester         PASS      85.01 seconds
TestRunner_sco-tester         PASS      34.65 seconds
IncrementalBuild              PASS      27.62 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1,1/2] Bluetooth: ISO: Fix data-race on iso_pi fields in hci_get_route calls
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#118: 
race at unknown origin, with read to 0xffff8880122135cf of 1 bytes by task 333 on cpu 1:

total: 0 errors, 1 warnings, 0 checks, 91 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14601826.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,2/2] Bluetooth: SCO: Fix data-race on dst in sco_connect
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#119: 
race at unknown origin, with read to 0xffff88800e6b0dd0 of 1 bytes by task 315 on cpu 0:

WARNING: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm")'
#131: 
Fixes: 9a8ec9e8ebb5 ("Bluetooth: Fix three socket race condition bugs in sco.c")

total: 0 errors, 2 warnings, 0 checks, 26 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14601827.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,1/2] Bluetooth: ISO: Fix data-race on iso_pi fields in hci_get_route calls

16: B1 Line exceeds max length (88>80): "race at unknown origin, with read to 0xffff8880122135cf of 1 bytes by task 333 on cpu 1:"
[v1,2/2] Bluetooth: SCO: Fix data-race on dst in sco_connect

18: B1 Line exceeds max length (88>80): "race at unknown origin, with read to 0xffff88800e6b0dd0 of 1 bytes by task 315 on cpu 0:"


https://github.com/bluez/bluetooth-next/pull/257

---
Regards,
Linux Bluetooth


--===============7787169088967849881==--
