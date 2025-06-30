Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5920F21ABB1
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272870; cv=none; b=te0ZhQXhtZ0rOHoGthWRVsRFD1JkXBEMQK6QVmIl/3b5QZfqFqw2o1d5/FowE3pm1kckxlndBQZMeJyFLlivuNAuti8O0389bd99/lPgr1YGUmQbh6WuXIzIJoOT2movya8nOa70Z7WHVmMBKHgrJJJJyWIK7CP8uXiFxl/wqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272870; c=relaxed/simple;
	bh=FDKwWXr/ZMNGEVY8UzmNvNYavzO0OTZ5/GeQ1bif9sk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rNcr9M6eaI7UtFBmDinmKmx+a4BvbnoYmygytAZzX04ak08QZNBiIu65b0fscaipaJYJ5IugVKxnJ3rn4IOqMqeXKV+Z3sWeiye3CtB9psKGvsJSD+lJ+2WG5meqARWFOr5TxH2PqKUe7LvoPJnxWUvoYWdyd/MrjqRNTpJqpY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJgHbGdl; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJgHbGdl"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fd1b2a57a0so38104656d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 01:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751272868; x=1751877668; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YtevRvdEJ03bZRT1+TXz8WMKAnB1ZHuaE24hLud9GLw=;
        b=NJgHbGdlSU/VwH8Uj7o8Jpb1lAxx+Q8TDHjB3IGUQdUpK5XiEjVVmThU63lLduvdJB
         Rhvnldm56A+aWCEVyfsX/R/UbWFJEjEIKH3SSySUeSgpezaH9txHEMkrvO6JGOLjGiij
         IRVit6ehSpWfjEpZH/FJBAyBojvSEMsAaqz2E0tdaztoPNiDz7Civv3t69a5jf9tI6Hk
         LeP8H+nu1sCTny4CHlfTnPByY9ZomgG3vYlp2fIxwtsbEQY7DVb7jDAUGflMZYlZKewY
         3/SIxWv2DXpzxU4GT9P6TJqUKhI3oYZYHj6sPiD4KZvG3XJX8eQWuHLRWfQVHaY1QRjV
         tpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751272868; x=1751877668;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtevRvdEJ03bZRT1+TXz8WMKAnB1ZHuaE24hLud9GLw=;
        b=JCYkWvyUdA82Meqga6e7BmNBPFLaEM1tyAuJzsiWlzodJdeO24C9xMvdXl/TEMAwOh
         BoBeWcick6OVxxnHxV0ZIhIYzi/no4mCLMD2fkkhwanUVb7VU8LcED06WKR+9nBq1QqJ
         3h6Ul8fwlrYZj3FSVTjx3M9tWeUNwRgmmBVsb9OEsNa3mEyOyUlo3ZUSSmXRva8cdEJN
         8QeCgRx6KggTtYkoj66PVoVMvmoR7IMaZkAmrN0V6ZlknaagqNQyOwRz2ofXLeuitebm
         79jdYNZs/9/BhprhqYXigobkEQHiweQh2qfo6/Y9J0f4N1Qb3Zs813x7baCwhTbPyHpi
         4exQ==
X-Gm-Message-State: AOJu0YxqReY/OZ6Axec2aT9olF93fn1h8bx0BS3mbRLo8maDS1YCxAoz
	xFfs86dxBXxH4lyNWQSC+o1FVQPiA387oSxNw1BUd4WipsJ74nCuac2LIlvS9Q==
X-Gm-Gg: ASbGncs87dNsKuljMOj//Cqutqun1sRwZmRizi5muJV5E5cd7QyNwEbzqApB1CN85t7
	ySpnVmtfLVnDiC7YuhSzCMRiRX22Ayf6oTf8ZUG2c5HgGHS2jJ40vEEx4+rir9kcwuIcMoEnTSK
	sOq6d01EvjH1U3GQa1Bay1biyTsd/RCl6Lo1oMLr1uuLTFCLgFqtctwU4nbCUgHgVV6EIJML+p4
	szL9Cd4AZsLZK8eFRRLVBNg+M9S+rxPSwSbYWWXZh5Oz6x5MNGj0amSYIVSYppzu6T7V8InActx
	ndNY7BoUoqqxNFG1NfAbtxTmpPfmC3Rg0O4KmLp8ZH6rUUysAu9iyAifcLu5BnwnnGL3
X-Google-Smtp-Source: AGHT+IEtKPUHH53w5VRbPav5vyVcZr30oAl5G0tNoH74WVwr7D9NAuSjDKyIjRt0sCfZK1Z7T00BQg==
X-Received: by 2002:a05:6214:4587:b0:6d8:99cf:d2db with SMTP id 6a1803df08f44-70003c8d7fdmr215665036d6.38.1751272867985;
        Mon, 30 Jun 2025 01:41:07 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.31.195])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d442e8db3csm564249185a.0.2025.06.30.01.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 01:41:07 -0700 (PDT)
Message-ID: <68624da3.050a0220.35b121.e281@mx.google.com>
Date: Mon, 30 Jun 2025 01:41:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7570543985152161584=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: Bluetooth: HCI: fix disabling of adv instance before updating params
In-Reply-To: <20250630075848.14857-1-ceggers@arri.de>
References: <20250630075848.14857-1-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7570543985152161584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=977197

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.28 seconds
CheckAllWarning               PASS      26.41 seconds
CheckSparse                   PASS      29.89 seconds
BuildKernel32                 PASS      24.07 seconds
TestRunnerSetup               PASS      465.67 seconds
TestRunner_l2cap-tester       PASS      24.91 seconds
TestRunner_iso-tester         PASS      37.58 seconds
TestRunner_bnep-tester        PASS      5.92 seconds
TestRunner_mgmt-tester        PASS      130.33 seconds
TestRunner_rfcomm-tester      PASS      9.27 seconds
TestRunner_sco-tester         PASS      14.79 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.22 seconds
IncrementalBuild              PENDING   0.94 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.174 seconds
Mesh - Send cancel - 2                               Timed out    2.001 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7570543985152161584==--
