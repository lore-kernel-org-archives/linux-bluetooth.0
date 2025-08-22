Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE623F291
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856827; cv=none; b=ZzO8g9+PFDtTcHmHkFtj1/3l6gMaBQP7uVu+iuuw2CbavXdfQzDN+pXjyZZ567NVbemOSHFK1nJeAyyBCBCja+kES+s2nTwr66zbHiAytd0HyrWJ2MPKaP4OOHNJg0MFOHXw0Zf/k0FIOSKBErr9d0erCfVb1TcGs5YLzy4DoJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856827; c=relaxed/simple;
	bh=rHpY6Eiyh8uNjeXoT9Ec8SalH5YDVRKN2CiK0tJAIC0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PMm5ofZtI4DKJkYGhQry0sH/OYYPzbPRpxdCAwX+5jys+DCd3k/ZmvLw6IlbFLJUihCCZODsw5sA81vkQnqyQWjONmZG/z3hRXRksioE08QbI7raQ3ivhBxA0FRKz1byFdNHjMzdNTMhX+RG4Py9b19MnifTJRvjylx1+mtABBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoGR2RCy; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoGR2RCy"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70a9f5625b7so16720356d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755856824; x=1756461624; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cfQcwQdiWhPSbCmqf6b3gdLXT8zZ4FbWc9Oh1p9reFc=;
        b=XoGR2RCypfojR9bX9Gne8HKfk5Ga0z1/gi+VVOhf+nGyrWb5OPEXso2RZNSMG+t9iQ
         0ChG/uDTUVzY5/CcbZcaDRzqxKrXofAxFrRfvabCSKoABRwHX2imzpDM99+h7dCzAhgx
         E5Wl44k+VsP3Og+AOrg3dje9t2H/Dqa4bpAv+6PEf0DnCrQf8igEBKMxe8OTvy5b9HDK
         TaFHxS/zHO7xTZWVNJRGCw+zGCbvmfP9nhz0xGWDIE+eC/sSfyl4E7vlAiNCN3l+ZPct
         CQLLMrrSyUHaYxlOxNOb/ooFa2lBVGjkwbUWTX1rtuN7W1fFzSp4dSOfjyLauZECv+kE
         CiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755856824; x=1756461624;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfQcwQdiWhPSbCmqf6b3gdLXT8zZ4FbWc9Oh1p9reFc=;
        b=CzOafHHZpduIHqHWpNrQ+6nNTZM35btweSrxVsE1SoVx9yMIxyp7AkmsXdKglSVTcL
         G6zvZxL8AmFu7Y8+lK/F8bkQoQc9NVdJLUP87us3YmUDizzxHv6tnHvby1pbmFlWalUA
         CLXSVIJKSXG4bxqzjZuHFKYjx2B9JKDOTwnmGeVJya+cg57QSPPNCxdA2ptJCj/Ygc4U
         cHxMype6lISgC4hOxw6OtUBRIopowudgOCinDauSgFmAM7F7cDfhk1QFozDX3RsYoRp7
         KF2AHO99YUBYxCPc70Iqtt/X1IPov2QIuJdx3QiKN7qezJERLUTyca7tFehIqT5sI8Kf
         TkOg==
X-Gm-Message-State: AOJu0YyTeOe4Rs/6o2f2kJNiebjt74FbGB5DI5HiAJAXqrVNpxn8nIyc
	3Ywsj+oAluURwFFPNyLCSNY6qbGwEg6YW1S5b45osh2rZoclc4IqkWr4MbDkiQ==
X-Gm-Gg: ASbGnctf3Vsnzjv+NKQC9LkJpvcYBhVXxhmVn6GzeQkieC008IiS33Zrz37XfVJTndM
	JhF3qvHtW7ANZNN1CfagLGXLwaMhplZX6TmVKAPDOlyXUHBu5DQ4ZpKYfXx60pkJcZlBDCAVAUX
	WpSqVqOhY5RbhFS7lOqgKlcJLLkn08t/5uHXXOBeFwpQKn/kl6aH6b+1z8M6bSS6L0ihs+nekWw
	oYqk03AvJJPr6lNs0b+zy7Lx+H+DagtD87+Jggrl0k1gBvwvdKhKSGPh51o5xWGr0i6yTwkebxu
	SQgIKEw12QLoOw8eSVJcupAUv/Zwy2oOZY9rBbqpsMiLuHg6OHOBTTzNsWvm4oBhpMVwrA/Gg0F
	tPEPhLXJMI6hQx4+DN5a1xKvia9Vm5C0=
X-Google-Smtp-Source: AGHT+IE4g48RClKhU9TZR8UHXS625oS5q75qljYjzjuvBfesdyVEEA9kIHaXrs8xTYHT07PdSmck2w==
X-Received: by 2002:a05:6214:5086:b0:707:228e:40b9 with SMTP id 6a1803df08f44-70d97105fdamr27817326d6.23.1755856823625;
        Fri, 22 Aug 2025 03:00:23 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.111.195])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9077520sm122489156d6.21.2025.08.22.03.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:00:23 -0700 (PDT)
Message-ID: <68a83fb7.050a0220.2d60ed.4de5@mx.google.com>
Date: Fri, 22 Aug 2025 03:00:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3526155245565092693=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pashpakovskii@salutedevices.com
Subject: RE: [v2] Bluetooth: hci_sync: fix set_local_name race condition
In-Reply-To: <20250822092055.286475-1-pashpakovskii@salutedevices.com>
References: <20250822092055.286475-1-pashpakovskii@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3526155245565092693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=994430

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.41 seconds
CheckAllWarning               PASS      26.76 seconds
CheckSparse                   PASS      30.14 seconds
BuildKernel32                 PASS      24.18 seconds
TestRunnerSetup               PASS      480.50 seconds
TestRunner_l2cap-tester       PASS      25.14 seconds
TestRunner_iso-tester         PASS      39.24 seconds
TestRunner_bnep-tester        PASS      6.13 seconds
TestRunner_mgmt-tester        FAIL      129.79 seconds
TestRunner_rfcomm-tester      PASS      9.60 seconds
TestRunner_sco-tester         PASS      14.93 seconds
TestRunner_ioctl-tester       PASS      10.32 seconds
TestRunner_mesh-tester        FAIL      11.60 seconds
TestRunner_smp-tester         PASS      8.92 seconds
TestRunner_userchan-tester    PASS      6.48 seconds
IncrementalBuild              PENDING   0.57 seconds

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
Read Exp Feature - Success                           Failed       0.105 seconds
LL Privacy - Set Flags 4 (RL is full)                Failed       0.276 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.031 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3526155245565092693==--
