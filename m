Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510232E2DFA
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851383; cv=none; b=iYrgZQ/obu+FauvwAzdQzWQXEJQ07gZ0U5udUtz0rW508R+equ6lUSE+uQXswMYBFWSONUZjTN75ToRGwjXAHMFLzbiVPUzgnEqtmGUtf9Gol8b7NX5PiPuxbWsTM1Dz9zBGQwHjzd+82Im2R0Jxxh8DtTUCDCPbYZct7GSRIMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851383; c=relaxed/simple;
	bh=AruJ0hBIWBJtdDUNy0QblsG5kygn3b2ETPDjW5d5fSE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QQcjsaHQOG0UxWlkIrsj5CUCkHDho73XRl6wwiFdTIOOn6LNAHWfIC6Wzo5dZ9QH7jtv8BGRDMAshpiy3NBFnomMbeTWQYBYEnbToCnK2Efk37rGjRDf1YLoblZdIESHLXJbf2rq5+mVXpkQSVIK9VeQ9jC0np24YKa76E89C04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqbBRVBC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqbBRVBC"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so4968812b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759851381; x=1760456181; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vxwlIb33uG+T3C8exFJvrdX3ZZCgUZcaF0d/VYTH6Uk=;
        b=QqbBRVBCRWzVd9AYhrG/GG3e8xJDUg24nGKrlmGg785+0JoLjhClo0SLnfRVQbdLvt
         SCgB7hgjznFWXkZo5ucthOC+vz38cCsHwta4PjPhu30hLM16w/XPcjeNVqfGssW1xQQy
         Ee2MOnbA/0nYnX8ykabBmKmq8l4uU5dZdMYFikbXxosPtQq8NgmpzRTtIjoHuRLgN2sh
         IYKPqD1Pgy4gYZTwcfLjtx218nHNxKLMkPWt6Wy2EF6z0SgLNpvPHi0EuGdHwyWWm+Wl
         SUiNFe8X24rcFc5+1o9SCR+Ed8ORvboiZyRcFhsfZnNheKqaNVPj79JsLsiFstzWlCHw
         Dr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759851381; x=1760456181;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxwlIb33uG+T3C8exFJvrdX3ZZCgUZcaF0d/VYTH6Uk=;
        b=V8402UUdIDrVuWttGKakJwQLUhiRZ2kLE+yICq+SrM5pLLv3vxQEICN6xh/w2t+E3p
         vqXsSAeGu9uBAxB5ae5aLog1LXOyknAKsNdyoxSjpeS/OcqmojfPa5JVJVqYEHmvC35a
         WS79BXWNsj+HW0NiJlNNQPgrLYUkv6/QnlL0vU2Qz1wBsdwyX4fEX9lcDqoN8x94TqIN
         B71NEF3R9YtVWbc/8rrjBpRbyfknP7y0TAIf5Qc9aKIHZAQOL961dYE86IcOBnN/rnvn
         lZtvC/URT6NDYITdN6950apr6q6ZamJZkDtuvFO8o4y4RDhEnMk6V3meTfR9b5nY9UXy
         +CLQ==
X-Gm-Message-State: AOJu0YyrSZ+qOkMSw5eIKxumTQEZHrJ3oKLNAyu88Lk6V9RUfJoIbvPG
	g8cXZkY6hGeOT+Dfh2bmpyVzTfkhKpz1+OVdP7PjSGGzqrIAOGmGxVnpD4W+ukOv
X-Gm-Gg: ASbGnct7+DtECMPH+GIWWQtOby3oisCt28/Ge4pKaT6ZhR5z8Wgg3NNN7GYMUe3a/lU
	ly/NfWxhWgpHzJNq8A8jokgm86lhd8KyEh7p3NS7oEo4AiTmx7ReFakcfNPWhdwbQcrAtUftJS+
	2BKZvIGXSitF+qH4t854bWlpivclwEb1aJ1Tc4WmOB6HtcMgP7PUEBExvY3z/IpdKyjktRDpuK/
	6/bHIPXFmoqbUErn2K9HsTAREObxXdcB3eTwtT6VMATavkrbA8bSKHvASmz595zoujgv3xYWh/b
	kVSTPPAy3wj+7dJvUmf7cq/MGYOuoKFhcVPnZwcHeCzbhIm/MD7fWS3l8/ifx8eF8YWWzm0mN0B
	hFNAWkUsNtGetiyo8InMSbzEjz1dOpI592ldvMwWPX9qiz/7dlOvtRQ8=
X-Google-Smtp-Source: AGHT+IFYHv+7jXZi3v8ZETOiIInRUysuH+m3RsZwdIeaoic19liP26tsGgyhcsz18PLhYX7Mn5H0wA==
X-Received: by 2002:a05:6a20:3941:b0:2fe:d5:4e80 with SMTP id adf61e73a8af0-32b620b181dmr25083202637.37.1759851381300;
        Tue, 07 Oct 2025 08:36:21 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.173.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b630b79e772sm5469450a12.3.2025.10.07.08.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 08:36:20 -0700 (PDT)
Message-ID: <68e53374.630a0220.3f41c.549b@mx.google.com>
Date: Tue, 07 Oct 2025 08:36:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0511074428109319262=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/7] Bluetooth: HCI: Add initial support for PAST
In-Reply-To: <20251007144930.1378274-1-luiz.dentz@gmail.com>
References: <20251007144930.1378274-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0511074428109319262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1009062

---Test result---

Test Summary:
CheckPatch                    PENDING   0.57 seconds
GitLint                       PENDING   0.40 seconds
SubjectPrefix                 PASS      0.45 seconds
BuildKernel                   PASS      24.59 seconds
CheckAllWarning               PASS      27.27 seconds
CheckSparse                   WARNING   30.76 seconds
BuildKernel32                 PASS      24.58 seconds
TestRunnerSetup               PASS      486.71 seconds
TestRunner_l2cap-tester       PASS      23.93 seconds
TestRunner_iso-tester         PASS      70.01 seconds
TestRunner_bnep-tester        PASS      6.07 seconds
TestRunner_mgmt-tester        FAIL      116.58 seconds
TestRunner_rfcomm-tester      PASS      9.36 seconds
TestRunner_sco-tester         PASS      14.42 seconds
TestRunner_ioctl-tester       PASS      10.06 seconds
TestRunner_mesh-tester        FAIL      12.83 seconds
TestRunner_smp-tester         PASS      8.43 seconds
TestRunner_userchan-tester    PASS      6.35 seconds
IncrementalBuild              PENDING   0.90 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_sync.c:7281:19: warning: incorrect type in assignment (different base types)net/bluetooth/hci_sync.c:7281:19:    expected restricted __le16 [addressable] [usertype] handlenet/bluetooth/hci_sync.c:7281:19:    got unsigned short [usertype] handlenet/bluetooth/hci_sync.c:7281:19: warning: incorrect type in assignment (different base types)net/bluetooth/hci_sync.c:7281:19:    expected restricted __le16 [addressable] [usertype] handlenet/bluetooth/hci_sync.c:7281:19:    got unsigned short [usertype] handlenet/bluetooth/hci_sync.c:7281:19: warning: incorrect type in assignment (different base types)net/bluetooth/hci_sync.c:7281:19:    expected restricted __le16 [addressable] [usertype] handlenet/bluetooth/hci_sync.c:7281:19:    got unsigned short [usertype] handlenet/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_sync.c:7281:19: warning: incorrect type in assignment (different base types)net/bluetooth/hci_sync.c:7281:19:    expected restricted __le16 [addressable] [usertype] handlenet/bluetooth/hci_sync.c:7281:19:    got unsigned short [usertype] handle
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.146 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.183 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.900 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0511074428109319262==--
