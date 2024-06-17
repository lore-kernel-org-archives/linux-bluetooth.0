Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221D8194AEB
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616959; cv=none; b=tJKkANi2R2NyIX7HZlvAEVnV7oL2+QBlsBmoY0QBEfAcWAlIrs1c5oUgRElHvzxcjzqq0xOxUVvW67Be1r+EkCYE3GY/dyrPBWHtN53Y+WlmZy+NQ14hT5tc69LpwejSoAIFAdAgmX7gtda+GeuPD40ejqEyIt5Re+sq4T7j5ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616959; c=relaxed/simple;
	bh=QH6wIyGU2MyUWZTY5+LxmQqywlyFKeZB1Pn1F7pIfg4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VwITes3TeAIwi4cz5a1EvzA/exj/bJp70EyUhGovZhz2mveSH5maeTrs2mrgN+gUHCGKoUcmmOl++YxdrD1Y6sJqlIvf5Gu1LKp/2XE0SD1lhE6oLhURHGclwM6+1Jy3A1fOTuUBK2wKd+BgTb13qe3zD4wfOaqQ0T3hJ2rnFFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCmtxzkw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCmtxzkw"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f700e4cb92so35899475ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718616957; x=1719221757; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2pXC6uR9WR81SFZx/XikiYx6vwx53SQnD+lpCcQUBDo=;
        b=CCmtxzkwHNO6Qn0u9WT9i+KnZm+TK1eJs5yMLPUu96uFuF39Qsuhj8qQlDKxHKIrpg
         jGzP+S5CKJDbzW7IoJWQqP7g4BqborxhKqFXvUir2H45JUFEgtkA3nhZIOvBd2qJ96Ff
         u3iUbRym4KvNYVMgfKofhMwUHnyNZZdYsTdp1D21YWjpHvv+UTlz88TC8tZ2rc1kYDni
         uY4K2/jcVyMySjQ2y34MRIF9H24w9pBSB505EG/9ztI0uwc06xumlg7vI8tpGb88UN6O
         nOXjWa1oITIAP6IPWllNR+gINPqSnUMm6KZCaqlVMeJxRI2pxJZiKhyFDVsca0vFK+54
         Uzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616957; x=1719221757;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pXC6uR9WR81SFZx/XikiYx6vwx53SQnD+lpCcQUBDo=;
        b=xKE+u1mGYbbwc5tYFJzHHQQ0vjB+dxRQ3rwNCGIzslJE2iqgwVplkdb7599LBkDB0m
         26hhRMEe/+/8PTucFhz+mCDmwcZBzGEIOnHjJWpEX76byfOtnqLQ0byyBrgijCJoA366
         5i+E+gnUWuGgsDTFb7bKPMQkl15rkhfeyDQuaFcUF0i+ETosEyjuBkgvw21fKRh/te8+
         fajsyCMLrN/aWCaXo9tSiSOXqoeQxCHQsI18ijeSoODpuZIp38I3FQ/O5/pojkxlx2Ty
         iXslTNJ0A45BU1lddV5mp0L12Of0FjZ86YejfRkLhZr3i3BBAsB7vNkH1rp3aGWHYWKX
         xI9g==
X-Gm-Message-State: AOJu0YwesUOE92hIvofl76x4wLHYVAJCH5sg5qGtEoZvLPnkT4H1YNgr
	UqFDGiRlb0pViB5lvub68I0cVuZ6BTk0YCusUoxhaxsgvpRKhEpjoeAalw==
X-Google-Smtp-Source: AGHT+IEi2mo0s32YVg4aCq1VqthZmaD3aXocYZVuwZm/761HRwOzipQsZe4X54TMZ8MLO9ebwCOUUQ==
X-Received: by 2002:a17:903:2302:b0:1f6:f0ff:47a7 with SMTP id d9443c01a7336-1f8629ff1eemr156097845ad.63.1718616957126;
        Mon, 17 Jun 2024 02:35:57 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.29.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55e0esm75831735ad.26.2024.06.17.02.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:35:56 -0700 (PDT)
Message-ID: <6670037c.170a0220.e163b.4126@mx.google.com>
Date: Mon, 17 Jun 2024 02:35:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8813952428752005005=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: hci_event: Set QoS encryption from BIGInfo report
In-Reply-To: <20240617085206.5750-2-iulia.tanasescu@nxp.com>
References: <20240617085206.5750-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8813952428752005005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=862517

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.73 seconds
CheckAllWarning               PASS      32.14 seconds
CheckSparse                   WARNING   38.34 seconds
CheckSmatch                   WARNING   102.76 seconds
BuildKernel32                 PASS      28.79 seconds
TestRunnerSetup               PASS      522.86 seconds
TestRunner_l2cap-tester       PASS      18.20 seconds
TestRunner_iso-tester         FAIL      39.11 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        PASS      109.49 seconds
TestRunner_rfcomm-tester      PASS      7.62 seconds
TestRunner_sco-tester         PASS      14.89 seconds
TestRunner_ioctl-tester       PASS      7.74 seconds
TestRunner_mesh-tester        PASS      5.91 seconds
TestRunner_smp-tester         PASS      6.74 seconds
TestRunner_userchan-tester    PASS      4.94 seconds
IncrementalBuild              PASS      27.65 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       8.199 seconds


---
Regards,
Linux Bluetooth


--===============8813952428752005005==--
