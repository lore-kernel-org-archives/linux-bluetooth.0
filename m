Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CDD1C8639
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Apr 2025 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744303008; cv=none; b=Hn8latHF3T737rdS1yfP3xPJtmN23kDrHbHqvPVMhq16G/CY2xND7zDx1hrP6dlQ+i7Vnrlgj08vT0bd+za9WQs7G0hyLqWI17DdKQzaFO/uFMVn232+Bfg8uYC+6IzhFDnkMWMOvQqeamWuFj0jeRDcCRFpHa+8WMrUgckviTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744303008; c=relaxed/simple;
	bh=iw70Ht4/PVJeYBc8j1iIAuTJhV4VknKy2wEZ8heO/6U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=l1lbHNXKBr0l1mxgA9RxNOBoY6fj9NOSvbwE8+1WiiFyn/0STI4Q9IxBGUcSeXnqfMwDDVk6MaiGov6ed99OCWv/YITGmoNIxlOXebi1nh554eqwIAB4n/gAbDnOpzPtZAaQi/+nVlXfN2U9ap6gghtPqwvB4UW/2qKdmtDEqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlRQmnKo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlRQmnKo"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c08f9d0ef3so70123385a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Apr 2025 09:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744303005; x=1744907805; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=61/JPBLRLhiN3m17+050Fcqj2hhV2hdNtyXedFgI+lw=;
        b=NlRQmnKoYNNAKAfmvmyjKDxI3T+tOKcFH+bUGnMkQDZjO0tU7U/bFdeAl312D+nprX
         CxHOzzqBARR7oJVjbcwZH867x9mpn8VF9NOv1UPKOAo4tUP2yauNPyO7/r1EEZbIEHCE
         Ixd1RPZ3RRVWDzRlgx+Ybq5yc2uk8eRugR0zX8gLCO3w8qgK8hDuyF4CfOXogJjW/WZ+
         FEURNoS9CGZFs8Xa2lkuRNsMqkxpEQBQtrCM66PIKUH/LDxCQGF7wLO7PLwHUN68son/
         sLtoCh6iR0XVrAQ8gXYCuz36NrcCN/qb0DAh7/FE5Dz8M2dmF50vPaAFR5ouja+/9wrq
         tVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744303005; x=1744907805;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61/JPBLRLhiN3m17+050Fcqj2hhV2hdNtyXedFgI+lw=;
        b=DXYNpelmiQeD02uVz+iRy6oFzHEPF9G5PxU8mInkK6i+PGqDiWWruKNEltjf2MPXsc
         c/rU6XyM7wTNv8eVbcDLnqGkp3mLgfPizMsOFDhPWn4hTkMTeB+0guh9PuYcU8tDVs5t
         xy4EfOF/atca/0pTHRX4XoPaS+n3GQk0ureQmWv8qhwTB6odBRCEVQx9VtL3WZZZnvXs
         5C40HxOP449+NMw9nIVOIv9e+Chkpjn+eZcvAiwCYDtRYTMnB1o6HNePEzTEP2b1s7IK
         rwTp48ABn2MuflK6RjICYEF1iBxuxJrlulw3WymRaJhyNp/jufTZ3mx1eIhLzlv0ggjl
         lULw==
X-Gm-Message-State: AOJu0YzTUcsbe2wcbB+s2iHeJXA2H3CPqYB3YIha0RAdAvCJyW24eEhp
	4oKZfNDtUOMwK+O4mUQxd/8Eciv2B2MIUDAD2HhZeiRr22Pn2zb9iTooHw==
X-Gm-Gg: ASbGncuYd9Crw4FbIJjdDnHZpi0miFW5DlLJMFfWzXY5TWqQCw6//Xn02zGLS/rus/3
	yNyW+F1tpePww6yOAuRDXd3Zl9vA2phqgaZjI7LH2Jda1YdhR2TB9z2qCVoOgCUk9qshOF0mZZ9
	m1ENIpbP3sw8LO+eTqC0Zm8/bwOU71lknQGRIlxYNC6RjSL6xzSQapSwdJd5OqmN/qLC/fMYZnz
	BInLdPthWk8LJPrQ9JP3VIOwx5KwB4kaRVnomAdbz60tY4t6yjHryOqtyYRYRyixOsTA8ucg76U
	shs8pkL5kDMXZZZEHByz0VXnss4hxI9LHGwPteihsLXmJMpu5Q==
X-Google-Smtp-Source: AGHT+IEEGFCM23pGnMah75IJT1jWaDRwZSTMtiQ8ELfHGpMIPeAFCpF425eCmlsIhqkuewtRmnzZBA==
X-Received: by 2002:a05:6214:40b:b0:6e8:f3af:ed44 with SMTP id 6a1803df08f44-6f0e7618469mr33604476d6.12.1744303005299;
        Thu, 10 Apr 2025 09:36:45 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.174.106])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea10798sm23101716d6.107.2025.04.10.09.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 09:36:44 -0700 (PDT)
Message-ID: <67f7f39c.d40a0220.427e8.83f1@mx.google.com>
Date: Thu, 10 Apr 2025 09:36:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7288362441353277664=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver
In-Reply-To: <20250410154040.499074-1-luiz.dentz@gmail.com>
References: <20250410154040.499074-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7288362441353277664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=952120

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.64 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.00 seconds
CheckAllWarning               PASS      26.84 seconds
CheckSparse                   WARNING   30.58 seconds
BuildKernel32                 PASS      24.49 seconds
TestRunnerSetup               PASS      463.22 seconds
TestRunner_l2cap-tester       PASS      21.19 seconds
TestRunner_iso-tester         PASS      35.83 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        FAIL      121.36 seconds
TestRunner_rfcomm-tester      PASS      7.89 seconds
TestRunner_sco-tester         PASS      12.68 seconds
TestRunner_ioctl-tester       PASS      8.34 seconds
TestRunner_mesh-tester        PASS      6.15 seconds
TestRunner_smp-tester         PASS      7.93 seconds
TestRunner_userchan-tester    PASS      7.38 seconds
IncrementalBuild              PENDING   0.97 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.194 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7288362441353277664==--
