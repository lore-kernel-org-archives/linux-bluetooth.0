Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FD622DA18
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 May 2025 03:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747797305; cv=none; b=QQCGaiggtEQflipwHSrBLoasCT1c+AAp8w3O4qGeOdXX3nJpF2UT3g0MQGGAqqffcgx0DJ60xBuVlSay16QgVgjoE/nfM5Daa08ALcdxJF+lA4GU2IfD0gvqnIfFy9cVf4+3jzizOuByx1elmnEZ94HuCxp1xu8AEDYghNZnYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747797305; c=relaxed/simple;
	bh=c9XQ9GhfLj9Ge6YCzN9Brd8sFtDl5ZlruehOhJ3CQik=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CQkg7kf2WKzyqUBvBy11OXxdtGOKXsV76HM1CfqTFxUd6V1Xplo9mTceRZzPZejkaUbiO3dz9Ulei47uknOhyq2YHqICAB/u1/AxLur2IXr2R0CpD5FS5CM+WPQdbNVER0IPyh9Gesd6AE909lc68A/zu7IQKIAPtlAyeFYzktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BM7xEGxR; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM7xEGxR"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c76a1b574cso1432591fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 20:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747797302; x=1748402102; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L4FeAeYh9eah/ohED0QIc+FzXeV8dDwPFwZC1bPEKZk=;
        b=BM7xEGxRThNzX4C4SqesAVeIo374dxDin/IeA13QuE6O3r6lWp9FmkX4NWaPi+KRp4
         0dWCUTZBNBlIsh6XwZAEtsqK94oI1Prw7cJ4ws/EQ1YCW7dxCVcWQIQI5xEiZQrVp+ZV
         DEcmw6/3P1McOqBtmhpoBjUwpM4glf3v+Zi/do4kwgXo+RGEweuAKs+0fVxyVYI/c3he
         Ujs7QQGwXgpf+mPgahmNTvgtUHRTeuPmFA5qd5oYJ3L/sRWeOAGBgiPD4BH+tgNEaAxs
         pIZi7myfl1jG8gSz7X5wMh13NueQ+8/sptr4dK85S7aDjBesfnXhnhYTSnfTdWU2U7hW
         FhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747797302; x=1748402102;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4FeAeYh9eah/ohED0QIc+FzXeV8dDwPFwZC1bPEKZk=;
        b=BRIckYGZmKgkhRavVUknq+EcbVTvyOJJDr8ZRqeioQC1IPk1Ckkc3YgqqioKH3ZSQv
         j2CuHWcearYIhOftBy4a9EYBYuqrmS/TcsDviXuKB4vbKGfTqhTmWw4XNeB/Z9e8nXbc
         s7nMI8AqJC932AMBHR8rduQOIxge7UaOjXOgwhv9OS0sAg4Ir2tpgbuYfKHpEaBPFJxG
         noXhTscar/Fk++wmm4vJJbV2MtGT/hUb8FK03e7EIDncB61G0W/7tBtkGGvmxx/sn7zB
         w8nuIFgcbo0TFmQ377e/zRZf/HDyIkhy3zIYycAhI0aBTmP+NUiUVZm3VBm9PWtgwxEs
         aEjw==
X-Gm-Message-State: AOJu0YzwVjTJWUkzhTcMuFLU0qbc9NCyHeq7im25jPDtdJI1Fd6GBMre
	bq3aIFC9Jh727W0VBEQWAe+pR846d6sGDuDNigaJjirjQMcCJnS2ch8+TXQ4iQ==
X-Gm-Gg: ASbGnctX2FrZtSowgtBHm7GtqZce8uoX2Yc2oqAcy1GD6GgJhpgyNmJDWYYWTQm2P7z
	IcmvfBCxd/F7tD7jufTXjwYr52u93THy+9lVLyqNqLwntz1lpG99PJzblOy6tP5c51D+Mxk+asz
	f9jShyI9EqZtPPdw873lLhFtwElNptqh9FJPjlz1fvf2ed2VYPqKA1U544a9RWtbiXWDS7inH0a
	WzirJqyT+aJzuQPKqpdSB1B5Pn6Fe4tVAwAUCCsRDivuqpUyMVSKpIi9HnHz6+MoxSFVEt24fk4
	fk7INrB5RHbYB1GFFpwNvlJMTisL+BjDfOvKIU+B6tpWcM76zB6BpfLHcUaofYPIGa4=
X-Google-Smtp-Source: AGHT+IHxl5PTIAE5TTHakfh7wEwGJ+x25G6TbpCPkhYJNJEutPzyH+agh+W6G1+SZW6W+nk6GVV79g==
X-Received: by 2002:a05:6870:9601:b0:29e:6547:bffa with SMTP id 586e51a60fabf-2e3c83775d5mr9992540fac.21.1747797302209;
        Tue, 20 May 2025 20:15:02 -0700 (PDT)
Received: from [172.17.0.2] ([13.85.44.118])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e3c0b21cb2sm2460643fac.46.2025.05.20.20.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 20:15:01 -0700 (PDT)
Message-ID: <682d4535.050a0220.1785d1.ff2f@mx.google.com>
Date: Tue, 20 May 2025 20:15:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3613669481102206440=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zenmchen@gmail.com
Subject: RE: Bluetooth: btusb: Add USB ID 3625:010b for TP-LINK Archer TX10UB Nano
In-Reply-To: <20250521013020.1983-1-zenmchen@gmail.com>
References: <20250521013020.1983-1-zenmchen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3613669481102206440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=964791

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.31 seconds
CheckAllWarning               PASS      27.09 seconds
CheckSparse                   PASS      30.40 seconds
BuildKernel32                 PASS      24.84 seconds
TestRunnerSetup               PASS      463.73 seconds
TestRunner_l2cap-tester       PASS      22.33 seconds
TestRunner_iso-tester         PASS      33.34 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        FAIL      121.79 seconds
TestRunner_rfcomm-tester      PASS      7.83 seconds
TestRunner_sco-tester         PASS      12.95 seconds
TestRunner_ioctl-tester       PASS      8.35 seconds
TestRunner_mesh-tester        PASS      6.06 seconds
TestRunner_smp-tester         PASS      7.17 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PENDING   0.65 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.215 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.150 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.158 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3613669481102206440==--
