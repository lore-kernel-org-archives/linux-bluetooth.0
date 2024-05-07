Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8614EC79
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095936; cv=none; b=LXShltG71XoSoOTxO/Qvs00jVBSZAHwo5xMemBcia1Kg8ExHbJYXe5nxkEro/rEN108di6CPS8HIbchV2IcCL1s4eKSuqw4Kv40B3TevColf0jdevxcx2MIJZtd+DYNlMrAc8kkeyNjnYawtlY7lzEkHpCVV6wQa4S3Cc7tUJg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095936; c=relaxed/simple;
	bh=d1aRwX7mll0mhAb8+L5FgSZxIppe+h7UUpEkMu3SF2Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qzCipelYD9YzuCfXjUE9o+8diMEa/TEJDZowQ9bcyYzcyVjfhdzy/FUqk+QurrjTt8dyEQUcSA/eqhoHStPP/+noyi8qCYbw7nTnPKR5J4k/zwbxQblNNnvafl9e6DnqvrRx7Mt38DVEvKFIbqghUX3jcZQYuMOD5riwVKb+sD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQuxxaad; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQuxxaad"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79291d441fbso306130485a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2024 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715095934; x=1715700734; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pkN9faLltL5/b4Xr4+JO98ht8UdYB1eYt7JJthXc360=;
        b=nQuxxaadIUIBGqOuGPPKLn+ttyufu8H4DWuzx+OiEY2kyoQM4ox1934d8/MjD29rGG
         YD4pfuPFw5zuM5QyYEEy4GrWRUdfAX65cPvOe24nw6a3bR3k4yXGkRiHcdD6iL/1Uhsd
         GDy79Lzeziai28EbcvWkfda/TDWKpTzIo9GQDaHxAoDfGycSrf5gRagEnXfLFhUnEiOU
         BlY6iJ6AKWjRhuh83W7xP6skwC3CGqYJ0otLo8mY6DRboAv+OPbJycL2L9KnveGBsE4t
         FAhZTEaNgXcDA834LgeCSbwWWLonNHlKhxAWJbvtACGvau7djrZzYfGmjUsriP/VEeJr
         FZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715095934; x=1715700734;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkN9faLltL5/b4Xr4+JO98ht8UdYB1eYt7JJthXc360=;
        b=ctHeWqUNHW9q8s2+Vh06BWW3XCJ6hZEUDC24T2wRpUBERHt2oLYS9hvMiT+GNaHfoW
         is39rEz91h872D2DFM5KnWvAtxiGlTyyLLfeNqj6+1RJu03cTag1G5i7DtM6IvV0TQd5
         AMFdMQl6LhTU5hvsbyUA/FjZtBptuP7fGi3E8IPhD0txXkthagb/EIFstFS1DqXI6jLX
         SU2OtsY0Tp73MBIzjAc2/+GM5wJzg0VKSnxe9q42bwxBy7+P1W0LA1Fj+naNpHBhbhy9
         LPO9E3Q+WIfLIwAs9whl9L6BEnhXNw7/5LKqQJ4n+1Hl+u0b3rdXBqzUcJepGnLQ+oxL
         zlyQ==
X-Gm-Message-State: AOJu0YyaaSRcL6JJDIJxeQLO527Gry77P/n/c1XfsBFGULgGj3qzXIrp
	AbZQr+Q94gHRk3WC6XOtxtNZvMFhvhdQ4Iv9VjqsOejE7WKxiTcJkLciHQ==
X-Google-Smtp-Source: AGHT+IEpHsd9BhG1WICI6OFHu+U1CWVyaGgk1Ke7SM5oMrWuXDAg/r+ZEJPzXUC9lJ0oLUN5kSu5nw==
X-Received: by 2002:a05:620a:4709:b0:790:95cf:c784 with SMTP id bs9-20020a05620a470900b0079095cfc784mr18603818qkb.78.1715095933694;
        Tue, 07 May 2024 08:32:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.106.197])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a0b4500b007929602e42asm2359580qkg.96.2024.05.07.08.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 08:32:13 -0700 (PDT)
Message-ID: <663a497d.050a0220.99cab.8529@mx.google.com>
Date: Tue, 07 May 2024 08:32:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2029867690278880697=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: HCI: Remove HCI_AMP support
In-Reply-To: <20240507143639.539863-1-luiz.dentz@gmail.com>
References: <20240507143639.539863-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2029867690278880697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=851233

---Test result---

Test Summary:
CheckPatch                    PASS      4.09 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      30.43 seconds
CheckAllWarning               PASS      33.26 seconds
CheckSparse                   WARNING   39.06 seconds
CheckSmatch                   FAIL      34.73 seconds
BuildKernel32                 PASS      29.05 seconds
TestRunnerSetup               PASS      523.69 seconds
TestRunner_l2cap-tester       PASS      18.21 seconds
TestRunner_iso-tester         PASS      31.03 seconds
TestRunner_bnep-tester        PASS      4.70 seconds
TestRunner_mgmt-tester        PASS      121.03 seconds
TestRunner_rfcomm-tester      PASS      7.19 seconds
TestRunner_sco-tester         PASS      14.93 seconds
TestRunner_ioctl-tester       PASS      7.67 seconds
TestRunner_mesh-tester        PASS      5.80 seconds
TestRunner_smp-tester         PASS      6.75 seconds
TestRunner_userchan-tester    PASS      4.84 seconds
IncrementalBuild              PASS      27.92 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============2029867690278880697==--
