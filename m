Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8812FF70
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720305; cv=none; b=oqmp22nfIAHLqiiGXOGn7+4Qjor6346m54x1KpSHKe01/aFiXtzF+by2G/w6KnxgAmlP+vl66k7AS6MavScxzozCPVRLUN5h/f4D3khROyiUoeyf5vgnvxr98n8q4VQI5iTT05ZegzTzIdIVWXyY+o+o+i5FOZfSf7DWGwAf3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720305; c=relaxed/simple;
	bh=Guy/KPy+t9mpgkv249tesVH9eyOu/ocpeMroUfVhLgk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=slJ9keQ0GQtOI4pD4bVQC8NbATeTecB0ScRyyFkR2IrDYGaOKSaKE0vBZfUU1rkQEfwE7Zdw70kPChdhHgfeWi+SB5j8Zcdg7n2Wp5tXOoHcKd4hjaihI2Xq3qTUUY4Yzg8J+v+nZ4z/EDajHwh8xiNNZZujKbZkgAie/KCNw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ie5SW6rN; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie5SW6rN"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78407987510so1483585a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 08:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706720301; x=1707325101; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u04GUoTBDT1jxK1mUg12MN5X5OYa0p6NdmM8BgiQNuE=;
        b=ie5SW6rNCDwDRc5W4j1uf/YsI8dNiA+It+m8hwP5XsTtZNWwRCs4ZoDdGuNq1N8QZw
         SsspYenf5vS5VeSlSjycGAxdzKWJet8k67+pXF6T+TZVUsS5y9AtSCBsGV/IRu90j1hz
         QDLaMfazM5N+cjJOLk3n5uWzYr3eWqi2jExk9UPhU5dTJOXSsF1Q+2olOl5y0K9cADi8
         6k70/Jj91a+VReHIZ+qXI0BHjXdZEAI/FOwC0LptxiHYsKcrRmRv1xBAtYEmmojphT+T
         yZNyU7Osv5oWHdE3Fk0NZWijhFisd8ofs3YYhmbxmCSZGSOK+ffn1C8431oNroXz+X3k
         DEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706720301; x=1707325101;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u04GUoTBDT1jxK1mUg12MN5X5OYa0p6NdmM8BgiQNuE=;
        b=jOaD3XhExGi2mk1Yi7Y6vpi6J1Jc1DelCgDc8eZP62SJVtMz6MY0pMY9/Ds+nP62gh
         Da5FVa/pdfnNKLDABlW6rOc33ab3xQQSQi+T4hqeiz4/HZaqeDbfmyfjhv1c6m9ORe5k
         WvyaBGRgOso1DjeekdannlFKhRJtxYGeHm2yoK0mTZ5Z2/27YNEn+svZOFxToJLSO4qf
         xuW0IQrl9qt/UObSJzhGzLWjafJYKAHROIfpWdyErWsAjcCciwtAarjD6q5E+I+otHxK
         gDbKfFq8DSxtUZ+YAHeQSpTsJAyWhRSpCHTX7VKsVtCHOmxEHamsiSVHfypmVjqq9MHX
         RsZA==
X-Gm-Message-State: AOJu0Yw8kg+q/FymMaJV7cABPnuwIB9p9h1lFTvKzjuVcpnfPc5UZ8ZB
	8vVnDG/aIwhQDlA8a7NgI1bkAZdzY0XnraVx9vxYHy2qvM9RjEnXnFDmNPW4
X-Google-Smtp-Source: AGHT+IExOr3koTqy67KdCODEB3mAKcRqUu9jg+6xH4eYoqtr4vWbq+zykD6/DTab7R5ik8FpnPrrYQ==
X-Received: by 2002:a05:620a:1a1c:b0:784:8c4:dbfd with SMTP id bk28-20020a05620a1a1c00b0078408c4dbfdmr2499466qkb.30.1706720300926;
        Wed, 31 Jan 2024 08:58:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU431m2MpMRH9qKC9Q1diuPuvlOAf2f9n3EVLAc1FinfgO5PZ/1NxmMqPOCN1IMCJQ7u2HMmJPxS0R411BAMHUo2SFKoA==
Received: from [172.17.0.2] ([40.76.119.9])
        by smtp.gmail.com with ESMTPSA id i22-20020ae9ee16000000b007815c25b32bsm4981631qkg.35.2024.01.31.08.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 08:58:20 -0800 (PST)
Message-ID: <65ba7c2c.e90a0220.94fcb.7357@mx.google.com>
Date: Wed, 31 Jan 2024 08:58:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3608941910202298273=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_event: Fix not indicating new connection for BIG Sync
In-Reply-To: <20240131162825.826774-1-luiz.dentz@gmail.com>
References: <20240131162825.826774-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3608941910202298273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=821786

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.89 seconds
CheckAllWarning               PASS      30.81 seconds
CheckSparse                   WARNING   35.76 seconds
CheckSmatch                   WARNING   99.14 seconds
BuildKernel32                 PASS      27.12 seconds
TestRunnerSetup               PASS      433.23 seconds
TestRunner_l2cap-tester       PASS      22.89 seconds
TestRunner_iso-tester         PASS      42.58 seconds
TestRunner_bnep-tester        PASS      6.84 seconds
TestRunner_mgmt-tester        FAIL      227.13 seconds
TestRunner_rfcomm-tester      PASS      10.74 seconds
TestRunner_sco-tester         PASS      14.33 seconds
TestRunner_ioctl-tester       FAIL      17.16 seconds
TestRunner_mesh-tester        PASS      8.62 seconds
TestRunner_smp-tester         PASS      9.64 seconds
TestRunner_userchan-tester    PASS      7.22 seconds
IncrementalBuild              PASS      26.25 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 485 (97.6%), Failed: 11, Not Run: 1

Failed Test Cases
Get Clock Info - Success                             Timed out    2.354 seconds
Get Conn Info - Success                              Timed out    1.838 seconds
Get Conn Info - Power off                            Timed out    1.822 seconds
Adv. connectable & connected (peripheral) - Success  Timed out   10.770 seconds
Adv. non-connectable & connected (peripheral) - Success Timed out    9.992 seconds
Adv. connectable & connected (central) - Success     Timed out    9.996 seconds
Adv. non-connectable & connected (central) - Success Timed out    9.993 seconds
Ext Adv. connectable & connected (peripheral)        Timed out   10.618 seconds
Ext Adv. non-connectable & connected (peripheral)    Timed out   10.000 seconds
Ext Adv. connectable & connected (central)           Timed out    9.994 seconds
Ext Adv. non-connectable & connected (central)       Timed out   10.003 seconds
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
Total: 28, Passed: 25 (89.3%), Failed: 3, Not Run: 0

Failed Test Cases
Connection List                                      Timed out    1.905 seconds
Connection Info                                      Timed out    1.991 seconds
Authentication Info                                  Timed out    2.512 seconds


---
Regards,
Linux Bluetooth


--===============3608941910202298273==--
