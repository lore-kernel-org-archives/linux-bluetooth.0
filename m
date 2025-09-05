Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E103393DDB
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Sep 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084400; cv=none; b=QRePAoVYbfVspCPqu6RxEsCpCLQJabUCRl1x7R6nvB4sbEulyqB849bRAblZe6UM54txUCVi5j8oo40Xo3p0hztVi6umZYAq9C/FAc/+WUggizrYVzovE+khZvoMEme79ldEESgn7XfnYsvke8UGtXmkA/7aFP7YLyHEKVS2S9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084400; c=relaxed/simple;
	bh=PAfR40q7atXKssZf2G2BLVAxqoaCPnVHvI97yeTWYe8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DHTHZpmBB2zHLt7Q3EqRRRQbjCrCnuoPD6JqbNfdo3cfPWibKUJ0qHHHM6Lz458BFKlNhtBYrObuju6m7AO7PszqmIOmhkHWKdEU/wQ1PL8RnPckcJfSXXCAUQAFrotfxpqe83QJcU7mfi08QdE/Cs8MiFHko62oIkoC7NgEzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzVoF1+5; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzVoF1+5"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-807e414be94so224287885a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Sep 2025 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757084398; x=1757689198; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6i+o4QI+cmKzGiSek4g17jrfAI3Nox02ZVUkG1LWHKQ=;
        b=HzVoF1+5dMiXjZlw/YBnWjxICAbItUFAWYAyOGDRE51x34qyHDkncei5oDIEpe2LfQ
         w0eQK2zZ2xSWCgdZOLA6UynAeG+mWNwU7nyVVBAQz4/3FN1Ic/Df5CZrYYMY3tM2SJXi
         sVtiN7f2F76GiNfhbn0rqVulb5buxgZaNyGTmfvTHvFrRYq3xu+LCK3fcABcKnf8ddfV
         WCCvp8N98J1salRz7H/+XKwEkESXosMPJQpcUwihjrSXEg3xPvqIWqef6GvpBPLBNQ6g
         lQki0OAMzsR7BW3FTOLVEsBSSuBJrzNoBQkAzfrKOr0Oq3hbK+m60qdoNPWWxp81IT5x
         vMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084398; x=1757689198;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6i+o4QI+cmKzGiSek4g17jrfAI3Nox02ZVUkG1LWHKQ=;
        b=I/2qkmPUGdBOS6+ISehytekqlM/2K11vum3laHcO4SjQLVKuEgjY2DJjt62haYz5+4
         XnJdbGYCZ7+p0Z5V/+6JG+ymqxQNqrree+nXujFXYKBZef6atmydnCwohEvPDCoLM947
         OwkhQJX3LzjyWiX0TpDl48kMLtm4ajNVbOrUzHltkGmnengJVpzNX1xCrtGZDSV1WZ3E
         QwFk78vWOcX3jhvy5on0DRPc5Naokb1O80FOdGHLQtdl4MXopZ/nColf3/SXMFQVAKeq
         dLbhFwWpkJOSlFeJPML8UH3jjD5fqkCkmeCN9KeCY4iKMjm1tFoJMPQsbqjOTQW8P9MN
         FdGw==
X-Gm-Message-State: AOJu0YyOuxBcGtNT1ZnYuwL5jkGqVXxoidcpVRWkbQSl8qwFaMY+n7EN
	MWtkIvrWyS7pA5YpTEjGiv2A5ESiVtypPqsilrqThWkmXh0PucViQCi5lek1pN78
X-Gm-Gg: ASbGnctHXLvegG3OIpaD6u53PcssYXYxpF7xyR8HmKtEw63IEWx+i75cvM4rvM9znkf
	MSb/FE3ubwhEbwG+CNc1r+lQJLb1g1P/0DsHhNPaWd1CiFzuSYskwCQzvydPlk5ongsuPNC6JHZ
	K2uxbv1UsUsLSHX1YPdHEd24J2+Gz2PpkGaV7b5S7WlcMn8hRHO7Wb1NPcByOgNo36zaGuiAoii
	W/UjqAVRpvzF3O1YkFbMBNeQNbPRTuyVNvXJkXnoNB/JGSjgp1hOacjM9AJxcg3Yi46XtM/4UHj
	0AtcEycWchBYkKCSCVA0L/HCT0ZB+nErBhlzM/aLKi1SqlkfxDqFyTq7qXC1zN0ygSm5ng85fL+
	aCPSGQSxZYrPtWQG5nGUfqN5nyZQ+QJgE7fklKJE=
X-Google-Smtp-Source: AGHT+IH6vnXqkxYjzF6wHOuUQAsnQEjk/QceLxKo5/GEIaN/3AZStINfxxxKIhnxaope+v1vJ8zVLA==
X-Received: by 2002:a05:620a:45a4:b0:80a:caac:56f0 with SMTP id af79cd13be357-80acaac61f4mr1283764985a.28.1757084397464;
        Fri, 05 Sep 2025 07:59:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.47.194])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aa6e4cfafsm499627585a.22.2025.09.05.07.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 07:59:57 -0700 (PDT)
Message-ID: <68bafaed.050a0220.29075c.0e06@mx.google.com>
Date: Fri, 05 Sep 2025 07:59:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9042077983353032762=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix hci_resume_advertising_sync
In-Reply-To: <20250905143341.908473-1-luiz.dentz@gmail.com>
References: <20250905143341.908473-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9042077983353032762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=999381

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.46 seconds
CheckAllWarning               PASS      27.43 seconds
CheckSparse                   PASS      30.67 seconds
BuildKernel32                 PASS      24.76 seconds
TestRunnerSetup               PASS      483.63 seconds
TestRunner_l2cap-tester       PASS      25.04 seconds
TestRunner_iso-tester         PASS      39.23 seconds
TestRunner_bnep-tester        PASS      6.09 seconds
TestRunner_mgmt-tester        FAIL      124.46 seconds
TestRunner_rfcomm-tester      PASS      9.44 seconds
TestRunner_sco-tester         PASS      14.84 seconds
TestRunner_ioctl-tester       PASS      10.08 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.58 seconds
TestRunner_userchan-tester    PASS      6.32 seconds
IncrementalBuild              PENDING   1.04 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.165 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.023 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9042077983353032762==--
