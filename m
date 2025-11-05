Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC6D2F28FC
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364210; cv=none; b=OeR0r64XQy2ff7bmJzstq8ooB9eF+qjAWPYidbMJb6Z4+JLBZDYKJHL3Zw6C5UIc7+AL4HAnc1Q0K7l9FmpkUkJOJB2b1TUfsBrA003O3tfT3V7LgvDDmb3bfmnxx1FY8S0KQJIAxvkaTaDdvtoH+VmtMUkXi0/gzQdsy1KgIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364210; c=relaxed/simple;
	bh=nX3RWYCXO8KF4flEBiBfe3ETbpH23LaKIujjehKoq0g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=keBFtIVU8Oth0li5MLkkRmgHrzocgBnF1Le5Z9JjMiDDokTqo2bsu0m4SYQ7aTRd+nLj/Jg1i/r+jVooWculVvT8mhX6nF+n3hEhXXyi+YBSDruj9WvlyG1nsNHS7uzSi7PHk8yXOzAW1WIIww19CLXBWWwTALu4xXVh3A1h3BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMpT/kBE; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMpT/kBE"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-43320988dcfso88205ab.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 09:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762364208; x=1762969008; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7RPB52uk1SZ1WXoat9jTSiesgYW+lIEmURWe7iHXzbc=;
        b=EMpT/kBE2sooUD92aQNVin9rVaok/K1oRtWehT713aCfw5k0P7rrUiQkLLjbiUxXsb
         qeoWcEnBrA/MqLi1ipSZfD7Ulpuy5v/LG7NLy6HqcFzwdYs9e2Oth1DecrVVwrva51lO
         rRJF6uujaj2OHMmSZ9COjxua7U9GMdr+vxhF/pG7Y+EzVF1VOx/2D5aOKOaF8lwpFZ4L
         2X043HxOs8p0xQYuggBaGowM+EZ2hty9D2bdRd1DxOSI6kRDOViNnxlvSzAF1an7lWxi
         zyIqwcrEd4pHnlaqnUNDYb2lVZ3/c1d+sLlPqlcf42Wfw3erAzDvMuNNxw1zt38AMDa1
         g27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762364208; x=1762969008;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RPB52uk1SZ1WXoat9jTSiesgYW+lIEmURWe7iHXzbc=;
        b=pbqeEAk/ECa2pvr683B0oocU9F6qJbTzmJv2BaF6RcO6Hcw2EL2e8iFuNzECfifeDq
         ourr6y4P1DH066h+8r0MBSEBZ/MWz88JyabSW+pmP9Bxk5tNX9P92zQrBsgmY6z07Ab0
         Yn42qZ2A1rn+e037VrhMNdZyLxN/0fWl+P8FvmN9wXrl9w195dx78bDnQonXOitBQhuf
         PNtaN/G/M+64cm4ryKjRisRZYdVpsT7lxbQ//7EJ5Q5DSWEeEwMJtEOqOMRaXK75rYx6
         HZpwKrDcxOkWrUYQeM8pyYNO6cvwASswdhlfSACpXGwt/s3Z7YGfShWj01/RBR8uyums
         d4Rg==
X-Gm-Message-State: AOJu0Yy4J1v40mZVj2wJ7O1aG7kZw4n3vimvetGKV/+8lWRxvkmXWuI+
	T4/FESVbEcOLPMzploZhze1YhiDtUPBtV/780V4WyE2x2R2R2y3tOGv6B4gX9g==
X-Gm-Gg: ASbGncsAYbIjO1JeRZnEzCmKIrxWMzkH1GsrSlIEhXY7MMhcaU4gx81VgZjoF5CtOJc
	BIDPy/Msl6xtrO/1gh9yMac5HuciqXUU890NiDbX164JCr0mllbsMlxT1pP3C3E/j3Cz9HinNxp
	ufOPLK5EQKGM2LQdNcdhr0wNNMZQfInvCX1d7oNpR7vNOvL4qJW+tuN8AIV2zR4qWRljKhZg3B5
	ILfs0MdycwvfYgjt3zUMUj+CTD5vqNvU/mpevp1X61s888cs87LBLwSXRpfkwn5sPtFRj4QB+xa
	eNdAnqxLZEsHT2eJeYJvEZ9Td11pg6PvrwuXAcuKBmT29JG9DzzkIBBecAAPIm1c5sjY0+A1qsk
	N2dxqTPC3PDDS1PRES1T+vbqPMtQzc7m4LkEql8afciqUej8VNzZBHen/u/iLbBVXoPBHnQrgzI
	uULHFseEhfPLFJFDvmag==
X-Google-Smtp-Source: AGHT+IHjB1rzwlbKRHtT45MSt6nELjbfF2N2/uOFzTih2q60d3H+1aNGReDboNHE9g/CChnjLj+S4A==
X-Received: by 2002:a05:6e02:2194:b0:433:2597:8cc with SMTP id e9e14a558f8ab-433407daa84mr62026365ab.29.1762364207888;
        Wed, 05 Nov 2025 09:36:47 -0800 (PST)
Received: from [172.17.0.2] ([172.212.167.80])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43335b364bcsm28956325ab.17.2025.11.05.09.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:36:47 -0800 (PST)
Message-ID: <690b8b2f.050a0220.c9208.5aaa@mx.google.com>
Date: Wed, 05 Nov 2025 09:36:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6888042317938703152=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/2] Bluetooth: hci_uart: Refactor h4_recv_buf code into h4_recv_skb
In-Reply-To: <20251105170445.518320-1-luiz.dentz@gmail.com>
References: <20251105170445.518320-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6888042317938703152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020010

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      25.10 seconds
CheckAllWarning               PASS      27.12 seconds
CheckSparse                   PASS      30.76 seconds
BuildKernel32                 PASS      24.24 seconds
TestRunnerSetup               PASS      491.67 seconds
TestRunner_l2cap-tester       PASS      23.48 seconds
TestRunner_iso-tester         PASS      64.17 seconds
TestRunner_bnep-tester        PASS      6.09 seconds
TestRunner_mgmt-tester        FAIL      118.16 seconds
TestRunner_rfcomm-tester      PASS      9.04 seconds
TestRunner_sco-tester         PASS      14.12 seconds
TestRunner_ioctl-tester       PASS      9.84 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      8.25 seconds
TestRunner_userchan-tester    PASS      6.41 seconds
IncrementalBuild              PENDING   0.53 seconds

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
Read Exp Feature - Success                           Failed       0.094 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.144 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.112 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6888042317938703152==--
