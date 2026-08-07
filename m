Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B01641B8D5
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091124; cv=none; b=LFaISRs9nyjmN6U09VBehpDBU1wQxgclMKFFZlEktoOTMj5XsLQnR06xB+kfrOodEc6xiU2qhsGN0+X2k5yeDCI1BzhfIcvplniqNPb8a33F2ciz0l2eNoPDJbECL+XcglHKXlJGCNlnw8dbhZJMKxVu1KOB6cECEceJZKBBmis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091124; c=relaxed/simple;
	bh=XutsHPFO7hQtEr3pN3BlE16jhvbbCFUP0O3imdUNX3s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VO+xL0j6vGWwiek1lAeXHN5GsoLxTGH4WYaVJCcDaNVeGo2zR3WQxg8BilnOkJPZZztn9zQv7LMvlZhV704BatZxqd+Qqhtlp/dOBJw0+UJ2FKUzeHidI1qPZH4AET6J4vj12Y+AW64gzpwO5Rz74i25/RBzJe25f45vS+28Ykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTDct0M3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTDct0M3"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceab75934dso40265425ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 01:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786091122; x=1786695922; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cAPLhsjeWZ3iByD6KiXGSz+vbTxtp13StXM+qL9KU0Y=;
        b=XTDct0M3EGOemzBGtskJm3muYckgrcKX02ycaXDIoQUr3vDMpOpikVhOD17J9RkIlP
         0I8wa5nAuM9srY9T34r7zxH40ClO4WonXyYjCgXAqwPhBHw6vJpiQmDRQNNgbfe8qZ8h
         EIFnBompLNBcj0+9o7G/6N8NSe+NjiyiogOW3UH/uR85FBbVTCHc2wx7uxKf8A0oodj7
         u+iJTolnpZNkTINRfaxW7ryRCWnuITnwh/2QdeQiqhGz2yPgDDvneTELd+UOMXdVntki
         UW0V5GgbztqoldALL+g3CPRd/8kGzZKP2HjKc1rkxaPv/G433x8ZmR6Ro4enH/yBkIOM
         J7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091122; x=1786695922;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cAPLhsjeWZ3iByD6KiXGSz+vbTxtp13StXM+qL9KU0Y=;
        b=n0U8+uIJ1IBj58R2opICBtENRoHDHESlAzg9nnDmMgDBHNj8DvK1r5GPjxyMm+sgau
         DfSPTWxW1i+nRpG86er9lrEj1aYdX7nwFILoXg9mqS5+Jj19nKkq1wfL9QT8TToQyxWH
         pACdJEDDM573D3if8wZp7iwy47ZaGTbQmopndYRE/4eYVQDiAvfWha/8+VDfQo9kW6Kb
         dZIqMxZe+hDoWU+PAoTuGoHsehgYoXACRIzVM4grMg4dtnW2NRcJxy0QpzbwobNvW+i7
         9Z/H9DNWLOsji29K4cWn49VxBC+XgDsVHOPdL5+I/6x1wW2E7TIdGjTXT7ORZKkwPmG4
         ffiA==
X-Gm-Message-State: AOJu0YxoKo3vUDz57B0HT7C/xpvHPd7LE4+w79QQzLnn9bDqj8K/Z6dQ
	rH6MyylKKLlEndf0cimEkxPHvk6XoqlLtq4n863HORVmy2LJHANpo4cfbvn5znawtAg=
X-Gm-Gg: AR+sD11gfnYWTlaNrYQ7FNIepwFl9KgHNoQX8Urq8Emht0Xb60+MY3c99lPNu9/8+Jw
	T/MSBFqoEwaoGRGcwramlTegPRU+C+UsO8Cbm7iu9HWmwwn+XWVVTLBK/vsuMF0+ECgWgUIapnG
	67quwyJ3oMI6SNo2mTo11hj9JVNY4j8PatLHs28s4XUCMtCYCPZ8SUZBeFmzrQt+jdEyhjq7iYe
	JT9BRmJej1wTYawOwzg6foB+KsKuxIIFJWjlzX/OxmKZLo07Yqv8jJmiXvlNwNURFwUSGnYXDwW
	opix2Lbw/Hyir1bdtXxucbLeZrSHJiSz7zvXXmI4xqBvs4Jqe+bLYv9ht+PyVieGon5uIh4ylS5
	4qmA4Um+F77ZmPN1TwIVD67dztubVlMf1JnN9zGNjFAQChaepLuODZq9RZx0vAztgNq/fIdcGSd
	VvBH/sjGSqU74mcO02MKTHQZFDkGXnk6eUzqFEUSINvO3bZhRDYk7VlOCi7quGW00Ff5PIiE5Nx
	g8xeA==
X-Received: by 2002:a17:903:3848:b0:2c9:c991:3bf0 with SMTP id d9443c01a7336-2d0ca70da11mr257607045ad.8.1786091122076;
        Fri, 07 Aug 2026 01:25:22 -0700 (PDT)
Received: from [172.17.0.2] ([4.154.142.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccac19esm5374425ad.9.2026.08.07.01.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:25:21 -0700 (PDT)
Message-ID: <6a759671.c589044b.2faf32.825a@mx.google.com>
Date: Fri, 07 Aug 2026 01:25:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1762014468869992799=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: [v1] client/btpclient: Fix missing errno.h include
In-Reply-To: <20260807061316.1647216-1-jinwang.li@oss.qualcomm.com>
References: <20260807061316.1647216-1-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1762014468869992799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1141938

---Test result---

Test Summary:
CheckPatch                    PASS      0.26 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      20.72 seconds
BluezMake                     PASS      596.91 seconds
CheckSmatch                   WARNING   312.85 seconds
bluezmakeextell               PASS      101.37 seconds
IncrementalBuild              PASS      596.49 seconds
ScanBuild                     PASS      968.80 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
client/btpclient/gatt.c: note: in included file:./src/shared/btp.h:335:41: warning: array of flexible structures./src/shared/btp.h:340:55: warning: array of flexible structures./src/shared/btp.h:363:47: warning: array of flexible structures./src/shared/btp.h:392:42: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2385

---
Regards,
Linux Bluetooth


--===============1762014468869992799==--
