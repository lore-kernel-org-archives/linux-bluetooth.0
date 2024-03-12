Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CA92F2F
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2024 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710211077; cv=none; b=ZYNiRao6wobG+oFqpGqJvJ4jd4AietmpVJtTlKZFaNQ0uqeFTDduafvPj90hOofVUNd+VTkB9/pMnRPuZ+2sM01mabiqoujsNLUsySK1St7EBEPppX5sl8thNGIV9AqsC1jUpTIZLKE6a6ylOvJp469GavZGGQLYxC0gD7FPHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710211077; c=relaxed/simple;
	bh=CjqQTbK6lA88PtNH3NAxkv03nimTfi0MPbthk2nmIIY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ayQiJvQ3pO/F2sznmOo8Hrb5TxKzlR05/cz/rVjPfQKMVwTD5Jr21xcV8xsX2JfX45jHcdx6Z8x3A16KhHbftHJs/9G9A1pswP47gyGNQ2xeFkbc0ouJ2H4h1BZFtBrqIYzMP4gJJjEzNhmwytyFx1TIPCjCTFpe4GyphPuS6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6zxb4O5; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6zxb4O5"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7885980949eso184987085a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 19:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710211075; x=1710815875; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+WSRDAjrWGDNS6TKhodA73jPxVn6ZfuTZW5/mS6yrVQ=;
        b=U6zxb4O56Ng614wMEfyiSxIocYtq2mR0yMdOi/MgbCQFsZJIQ8UBN2sSd/FrNqlXTH
         qJkWrhP2gMAHQ62iphZhv7sQkxPoe0tXBpxrrMpTT7DnKlN4k1W8V/5XWyV9Cn8LoBJM
         YFetq+PjqUY8fEw/nLT108vVTjk3h8Kh3Zz9wW0BveUwCT9SxOe11Uy6iqPcIJGU2kv1
         eYP1O+pD3TkN52y2436fk7/S7JzgIu+PM6qkI/SyrHlP+etSEEsSQhP++TidwfmZl0pm
         CbaZQvQt22vYIxFhmWlwCnjZbaJMIPAmc7+wmT58EQby3B2DqHN4+VuO7KDC8vzr9g2M
         zkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710211075; x=1710815875;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WSRDAjrWGDNS6TKhodA73jPxVn6ZfuTZW5/mS6yrVQ=;
        b=IbBFMtEhO+Vwn3n8nCBGhlJ6KBBei/iTB1SKRn2mu4yPJBmA25fba0Dio0FiQ49ceA
         tG4gyLr8wx8ZsO7sxbIJ+M3lEPnoJtoxTHAAEylkjA7pt9U4xfsjPLrBMo9nT99sybDT
         tQcV7wvTGejcjdRIoWnTL4gY0zab19ymDrPuwusRCrSfTDtkNuAOKW/+NnoavgCjsKp2
         2lJRvNSXPZliPUorU9li2iYX6cILcpYjgKmAXw1hM6LLLJbumjedIQqm4p0Iie9VaSv2
         XobQeIy2fYhmSyZcpz0o8GAVtYiIjhSNF2AacjkOJYo/1Hc5Sh/JMg0kjaS1sG6ztR6y
         NXnQ==
X-Gm-Message-State: AOJu0Yw8VlBIP6txY1ve5nsdUdORljZ2pNUC1Qb/G6uXZaRUut2gUBQx
	efh3hR7ZEg4jHbxHSULmrCwXUfXah182zgjmTFiutBZn35GkwAUB8rn1Nijm
X-Google-Smtp-Source: AGHT+IHJneKoj+XjDxmRlvKMMylMVGsfjhxCmilFLGK3I3PXywcPXHBlVpc6RxN3BkaFL0YEZmGThA==
X-Received: by 2002:a05:620a:4484:b0:788:6217:9646 with SMTP id x4-20020a05620a448400b0078862179646mr9027625qkp.39.1710211074844;
        Mon, 11 Mar 2024 19:37:54 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.21.240])
        by smtp.gmail.com with ESMTPSA id 26-20020a05620a04da00b0078838695dfasm3242541qks.59.2024.03.11.19.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 19:37:54 -0700 (PDT)
Message-ID: <65efc002.050a0220.98033.c78e@mx.google.com>
Date: Mon, 11 Mar 2024 19:37:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1079175255520681063=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wangyuli@uniontech.com
Subject: RE: Bluetooth: Add device 0bda:4853 to blacklist/quirk table
In-Reply-To: <893FB314C6C03130+20240312015133.232214-1-wangyuli@uniontech.com>
References: <893FB314C6C03130+20240312015133.232214-1-wangyuli@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1079175255520681063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=834497

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       FAIL      0.50 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.67 seconds
CheckAllWarning               PASS      31.95 seconds
CheckSparse                   PASS      37.03 seconds
CheckSmatch                   PASS      100.64 seconds
BuildKernel32                 PASS      27.81 seconds
TestRunnerSetup               PASS      520.13 seconds
TestRunner_l2cap-tester       PASS      20.46 seconds
TestRunner_iso-tester         PASS      30.77 seconds
TestRunner_bnep-tester        PASS      4.99 seconds
TestRunner_mgmt-tester        PASS      113.83 seconds
TestRunner_rfcomm-tester      PASS      7.63 seconds
TestRunner_sco-tester         PASS      15.19 seconds
TestRunner_ioctl-tester       PASS      8.13 seconds
TestRunner_mesh-tester        PASS      6.12 seconds
TestRunner_smp-tester         PASS      7.12 seconds
TestRunner_userchan-tester    PASS      6.07 seconds
IncrementalBuild              PASS      26.59 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Add device 0bda:4853 to blacklist/quirk table

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
40: B1 Line exceeds max length (82>80): "Link: https://lore.kernel.org/all/20230810144507.9599-1-Larry.Finger@lwfinger.net/"


---
Regards,
Linux Bluetooth


--===============1079175255520681063==--
