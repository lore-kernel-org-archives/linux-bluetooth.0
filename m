Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB622868B0
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842584; cv=none; b=ckfmrGPPU4GErB63vjabJGQ/XaZpx4zmvH4i2qXIsLUHsGWQyNVNdKdlI8UciS8+63SezP7UaK0KSfWcCbpddsCAUUw+ar+BQuEt1asbEvZrooUs7hwevmt0mTKQtNKui7cug1y3P4bEhgD9Uyvl6QP18+6XXR+bJZEjmgWdJcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842584; c=relaxed/simple;
	bh=bci7okrq5H0ZChEg/RqcDX7q2zp+Vp15BzKjaQbM+aw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MkrKQhAf/Xwo4SFk7DfgwkY5fpCa2+Jx2DrENzVEidqBhuA6jyYa30AvHODLZAjffZjv9CJO2Z6g5vM7G1EaoZ2SfSAxDesBIhlKiGISy8JrB98IBdTdQ4gvsib7A9+MPSiIaUqLpofLm2VGJXCHAc7CivQ91aHLrxyf6lmszIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L54/Kjp8; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L54/Kjp8"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d3dd14a7edso1002726885a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750842582; x=1751447382; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+oTZhY/j5eiTaH/T2BWbZ5isqymH5nB5z51nOv0XRns=;
        b=L54/Kjp8oS7l0HRCYJtxJe61ctjLH9E5khZVC28Bc9VZPcTwxqTIGal5lIF4UoYgHX
         b4HHCJFLfy5ScTaZrsi+b0Ew5e6bUIgOZg5lSPYtHzu5ZdjNGSqnCIUtRijZwiaqEM+X
         BC84h5kv1AsE+Gyq6U88PIKUO4xhpZPYYlBZqKv3BNlTwxGiNEp89wEPcr0D3I3SVyks
         ecMWNi+YF3UH5Ld8P24259EXNdxHshUtjwwCSCkCkmPwAQyTQDkPDQboIU1J2pGniSpf
         JAY4qN+8rjW2lgXB6ldA8aC14sk/HSlws9dQMY4s3O7rJqJpniSJDUa6jFkN3CotXBAs
         Y4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750842582; x=1751447382;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+oTZhY/j5eiTaH/T2BWbZ5isqymH5nB5z51nOv0XRns=;
        b=eZDG9kjOhxkebiRkarrR3sBNLXI/zO+LF4hcWHkK061ISX3RNI9QEBOOd9BGw0j0XY
         MBPzAY5mV40ZI7STtsz0VawrCga39OhGuHBZcDTwP4/4C2Rg+34aC7Pee68VL/c7UUWf
         Vs3hrDqWY1W3De9Ec8yJhZHDa06Ji4CW10HTJDha7al+p+vXPe3BhC1pLABUwpbZECJt
         PhFhvkz+CT5lUa4QGVn0kc+gpuJgGThB1XjyMKAe0x06vg/2B/ynyJIH1VooLi8qHPR7
         zclw5VcZwMROn3Jhb9BzDgnQv4/SbTkwZqIbGX6M5SRtkhegOssoso4ekxmqAP2jcf73
         KJvg==
X-Gm-Message-State: AOJu0YwOy6As9eWcWU/nw8cRBXbjnbGhEJ25zTUoP7Ll+Y9lQxpSFMJR
	s5D97SnB0YmWFt13ze6hz3xiFPuZwLLBRGjxGJEioLtyaNhCSrrvS9jqaSHvyQ==
X-Gm-Gg: ASbGncvtVJyPk8WV3WOy4fO6FSav/HYf9nMtGAmJbHxQm9YSicAaFmpR10eF2rXLeT8
	SHiq+WJikhHKH5yhcWwqgJR7r2E/U7Uf4/ulZvkfxd7WGSN4LKQB07PvCxORDEP7bu/ChGIsZuP
	tvUTH72kRFGIjMJ81FbgrRiR9kX/nXV/y60v3Lku4j5odnCJO2CU0jswKhm63mEpgvug3fULIJJ
	0/rK0VSFwVyA4lKLX8uBsAZ3sA5LuidcIliSjH1QbiPy8Il9ASL23cpTWRM0qeYZ96ZD8oq086S
	GRRLBMa4D2X9ztBs32uWSpilvXR1MLNxxrBtQnWabhfY5A0PguiAIMd54qmsGYzQuk2cHQ==
X-Google-Smtp-Source: AGHT+IHZSbzK6AKp9U4qosyef6YnRlV4t4jTHe9Q79yyAE6amEKTvaMQNmfAS1C2Dh8AVZlgWDn2lg==
X-Received: by 2002:a05:620a:4105:b0:7cc:fef2:51b9 with SMTP id af79cd13be357-7d429793e3emr324552385a.52.1750842581483;
        Wed, 25 Jun 2025 02:09:41 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.109.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f9a0727bsm586796285a.108.2025.06.25.02.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:09:41 -0700 (PDT)
Message-ID: <685bbcd5.050a0220.bf089.56cf@mx.google.com>
Date: Wed, 25 Jun 2025 02:09:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3963170186169061410=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [v2] Bluetooth: hci_event: Add support for handling LE BIG Sync Lost event
In-Reply-To: <20250625-handle_big_sync_lost_event-v2-1-81f163057a21@amlogic.com>
References: <20250625-handle_big_sync_lost_event-v2-1-81f163057a21@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3963170186169061410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=975638

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.26 seconds
CheckAllWarning               PASS      27.56 seconds
CheckSparse                   WARNING   31.23 seconds
BuildKernel32                 PASS      24.98 seconds
TestRunnerSetup               PASS      483.50 seconds
TestRunner_l2cap-tester       PASS      25.59 seconds
TestRunner_iso-tester         PASS      36.46 seconds
TestRunner_bnep-tester        PASS      6.13 seconds
TestRunner_mgmt-tester        PASS      133.91 seconds
TestRunner_rfcomm-tester      PASS      9.47 seconds
TestRunner_sco-tester         PASS      14.92 seconds
TestRunner_ioctl-tester       PASS      10.07 seconds
TestRunner_mesh-tester        PASS      7.50 seconds
TestRunner_smp-tester         PASS      8.65 seconds
TestRunner_userchan-tester    PASS      6.18 seconds
IncrementalBuild              PENDING   0.82 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3963170186169061410==--
