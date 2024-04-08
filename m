Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7C79955
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584569; cv=none; b=C4LfQQJDmmttx1B3QmWuRRaw9PbJj0WC4Qc7yfxQHTBxtp3eqrYJ+9hIdujvRqa7H3aEf2Q78l3wZtmMK26w3Esz/2+UWw8tEdA7Xa55wt42awieDMNd2SdDLSZPtQ7hKLnxLyJiOq8aEPKY+WOH/RGjCJE4Gah4O552dnq9Evw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584569; c=relaxed/simple;
	bh=Yd8esV2RdRhRlAJcDc9WNdBB4Ubx3jNedGB0N9cG5F0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PdPN7NkJP/zfFEgFTRperi6TqJgTd6AdHqxzVBrTWcjDv9mS5oEhwh9TJE0mkviuNn8CsoeD1wbpVqzy3UnXu3438PQaXvBT1ucIE9UQbzUuI+GUJrxQY3dsdB2Rc5gnKQaoHQGmL1idKKfs1XUMjCEycBUj9Ch0TCeBtlaHBnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMfIqbpS; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMfIqbpS"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-432fe06d76fso23319581cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712584566; x=1713189366; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnoIi5vsZOBObGOmT8D9StyFyvY2v/2Rmhjwu7v8MMU=;
        b=iMfIqbpSLtVCyDmOIYSiDNKMHrReK1r3jKGPPtu9E8IPJhdAnQoG+HnllWbNaGKVay
         rim+UA0BJPuVQcWUcUdhpYJBKxEo9Fkz0qihQHA9Z9ywSZL2A9RGcnlWiHDL2tbpccVT
         TJNA3iEBt1FpFq5ToMt5GVhGFoPKqqULgllfyULtppwEWkZq/DYEQgBuYOniDzHgNA4R
         dpXQJT1OdTE/x0/Z7whW4v4hTjEagNCbE0kDchhsKVwX30E0doRnYZDNe07Mm2ymUiBl
         dDS/43WzLs119waxbMrBSsveGKLKwKpICntaql/o0AbwIRa8rxb3vmYvimZrLiBIfcC8
         XYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712584566; x=1713189366;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnoIi5vsZOBObGOmT8D9StyFyvY2v/2Rmhjwu7v8MMU=;
        b=njN3A43w/9+JWmw8lqehxXqqGutOvGB64/LxU7CqW1bzBr95F4hACjjpkA45tWT5jw
         4UtiF6asUg3cGUrlmdigDCmRRkoWGq/TN7a6IzAPK34ex6rBQWyV9mLJEEWP5Xz5bxr4
         9iflEYXeHFs8FqKWZIegUPXls5WqFKR3FnFH7QmNAxO8R2fZgG7qZht/hDzHgBa6dvIG
         KQzj4RbBnTSNsRJ1dPXwXLoj22seJsn8jbiqiDgPU2cHWxtRKO5PPx/iKODIda4m2M6c
         7hZ4FGD4K3QU3+PgCUt15C0amorg+5ePkUH0YONHZd44S6b9tikQiNmNLXD0xLN2jhxq
         zYPw==
X-Gm-Message-State: AOJu0Yz6allSQQcmPxScs6wpE4Awh4mCJWaIcWnuT0CYkcV74OXuywwj
	MuQdRWgchigQe46BiMfcJeemVxIyPO3JRRVpqoNhcecv/KjSd+8CV6pZU93k
X-Google-Smtp-Source: AGHT+IHPFh87XziVrGPXPvJaXJ0OAdpiMATLHOduoHWj9fXZI61TXlb2Znkq3BKLoSr5Hw4fU1bffA==
X-Received: by 2002:a05:6214:1c4b:b0:69b:1c28:e69 with SMTP id if11-20020a0562141c4b00b0069b1c280e69mr3110807qvb.13.1712584566408;
        Mon, 08 Apr 2024 06:56:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.132.70])
        by smtp.gmail.com with ESMTPSA id m10-20020a05621402aa00b00699439e5050sm2814468qvv.14.2024.04.08.06.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 06:56:06 -0700 (PDT)
Message-ID: <6613f776.050a0220.b5bb.ea47@mx.google.com>
Date: Mon, 08 Apr 2024 06:56:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3542901127557638169=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Bluetooth: btnxpuart: Update firmware names
In-Reply-To: <20240408132241.750792-2-neeraj.sanjaykale@nxp.com>
References: <20240408132241.750792-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3542901127557638169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=842464

---Test result---

Test Summary:
CheckPatch                    PASS      1.19 seconds
GitLint                       PASS      0.57 seconds
SubjectPrefix                 FAIL      0.47 seconds
BuildKernel                   PASS      30.45 seconds
CheckAllWarning               PASS      32.86 seconds
CheckSparse                   PASS      37.91 seconds
CheckSmatch                   FAIL      34.73 seconds
BuildKernel32                 PASS      28.64 seconds
TestRunnerSetup               PASS      527.80 seconds
TestRunner_l2cap-tester       PASS      23.08 seconds
TestRunner_iso-tester         PASS      28.90 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        PASS      112.36 seconds
TestRunner_rfcomm-tester      PASS      9.41 seconds
TestRunner_sco-tester         PASS      15.01 seconds
TestRunner_ioctl-tester       PASS      7.76 seconds
TestRunner_mesh-tester        PASS      8.64 seconds
TestRunner_smp-tester         PASS      6.81 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PASS      33.26 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
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


--===============3542901127557638169==--
