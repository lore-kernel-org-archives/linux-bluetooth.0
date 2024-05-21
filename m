Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5C76049
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298333; cv=none; b=h4W30T/elw7j5wTN/kFSSz2KDzHh9UvOAlLvtRVDu3BSqHkr+gHdU4oKffLm7m9dJFWRRVjm9PG2j2lSXbHaANNJT3nbU/RWgsendGPaP9G9JKhvbM+4czPiX0Xcu8cOoL/DY8W4JxkFl1usG+/QaCK8fmdoMTuIVOMfRZMuYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298333; c=relaxed/simple;
	bh=LfI9H4ut28xHkmGe1YOUqdAEptK/pyXgqCGhqS9lrRk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J3GInp7QtZMPbAMtByrEnIatNm1uX5f5N4FAcEfHtgJtOm/Ow4Pf+r7+5afKhYEbu6GtpOzXnaz7Gwk2YNOKUm2zHh6T12ImIydm2paXts0FEH6bgXRk68LgMiaZWPhXRQbjPOKTG0tW5NkYAek7RjJcH73wnnFuxLTR2adSh3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnCzbny9; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnCzbny9"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-792b94301eeso13988985a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 06:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716298330; x=1716903130; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pVyxcYuZk2dbUQJW7CGQ4CV7mSO7AOkdtASiqroXyWo=;
        b=jnCzbny9bPF4xPPL1/77SvBEXb7xV9QRNX7a+5lr5csKooNVsM9MiwQoAbh2I2Abai
         wpupKlHKrpSkCT+IohYuOAbFrdouEAzMqlMMS5KyAFBuyF1iYtxGA05gwLS7P+iKcs/B
         43wBIln23QQZgNGVdwV2zIRuHQUFed8kLU9mAEGCkqZrQu0j1InwBET7VxkE8HHcTwMh
         5aoooNajA2aXnKIMMDROrB3jhSbMZQIPYIyRxXMfWhOo4p6g8w+4eLm0IS9UpqLQIMCK
         GoXO+vYtg6Rxn5Fkg4mlRWo3pjno4ggn/SndU+kKXXsEljFbveMp2uh6oA3gOWeiwTjC
         RRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716298330; x=1716903130;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVyxcYuZk2dbUQJW7CGQ4CV7mSO7AOkdtASiqroXyWo=;
        b=ABDAFShx6BHOFaCH1aYu/5wLLqAic9oo9Gdok4BNLjGWNjLbKub1UY1WfWvhbmJaCr
         MyIspSRM5nTmLAKoc+WSIJDdA2VECX/tZ5GG0FX0v/mN/LgYK3fVm2N1IZJGA6ZwDGIr
         5z6Utv/05TZA1iggCjLeF4K8ib+08WDkfgFYHPGS36xQ+L2u8Rhb1Q/I9nowASYlzuvB
         QHJdVQkLBY4J4P3bwgy6cPg8Q1sUeuF9r/81MDqjFidF4nLd2VwD1gZfUacI0nW3E5tE
         HteL3ms8a/ATJYelzU7zwlH9HlsFvNxagTicqBVMOt8dRFD8zMZhwyopPUJXeJeymTb4
         hz9w==
X-Gm-Message-State: AOJu0YwrmztPFR551PLCOTph0d4XrhxwkHE3VPxu7cPBBLXimP2P3+aR
	nrdBWbOXe0glr+/d+PeMHdiu3TpA7SqDapPB2XoIt4uXqWdMMVX3r95sjQ==
X-Google-Smtp-Source: AGHT+IFTrfXjugW/E2oKLiYlxVhog9QXxR79rIeDHJNbcwh7BYmQ7tV0xn/7+uV78tJppQIrUHN6Tw==
X-Received: by 2002:a05:620a:2a0e:b0:792:e8c4:414 with SMTP id af79cd13be357-792e8c4065fmr3210216885a.26.1716298330116;
        Tue, 21 May 2024 06:32:10 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.122.157])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79482d10f3dsm222234985a.11.2024.05.21.06.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 06:32:09 -0700 (PDT)
Message-ID: <664ca259.e90a0220.a6620.66d8@mx.google.com>
Date: Tue, 21 May 2024 06:32:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0946967093914131157=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: test-bap: Add Broadcast Sink STR MBIS tests
In-Reply-To: <20240521105515.103972-2-iulia.tanasescu@nxp.com>
References: <20240521105515.103972-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0946967093914131157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=854690

---Test result---

Test Summary:
CheckPatch                    PASS      1.44 seconds
GitLint                       PASS      0.88 seconds
BuildEll                      PASS      24.54 seconds
BluezMake                     PASS      1701.10 seconds
MakeCheck                     PASS      13.38 seconds
MakeDistcheck                 PASS      177.37 seconds
CheckValgrind                 PASS      250.16 seconds
CheckSmatch                   PASS      353.02 seconds
bluezmakeextell               PASS      119.69 seconds
IncrementalBuild              PASS      4655.16 seconds
ScanBuild                     PASS      988.16 seconds



---
Regards,
Linux Bluetooth


--===============0946967093914131157==--
