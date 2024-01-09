Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8986D6FC
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU5J9MxP"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ddee0aa208so133380a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 10:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704825425; x=1705430225; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=COQMNrrX4c+htv4lenIadv8aflnRNyhj8JA1FKS1CZI=;
        b=KU5J9MxP9ot8EMoq0i628ex78/Jifv8z9v5KxqzaaNYFVDRBDUguzYQ7MarOuDHPHZ
         PoKUBoDZB4NiC7DkBhvW/g5I21XdV7gPmH9kVbml2lAN2s+kIaLxtV4IG+Ot8a2ttxB9
         uegVC7ZKNYkd2oqlUKn9mksE4NMPhW10FrWbGKn4eWPEnj0iYaB4Wcns0nQnTV+2KH65
         wr3iuqHU9dmDVVRvGXc4LeXLffXVJjof6qKTQ3AXCBTPLEaA/qdoVlOvb5JxakC3z8L7
         3GUA4N5wj8YXsKYlJrr+/gCu4PTcUzmMVvIpmZO+C32kdDuBff52fpaEesWKCCcJIeYE
         qwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704825425; x=1705430225;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COQMNrrX4c+htv4lenIadv8aflnRNyhj8JA1FKS1CZI=;
        b=Dksxsn8iDebi/6Gk7y9TmvHE5OB4vkC4J5gkN6Xk3qQWqONXdrCQLzFphJGMv4NlML
         7XVAzqBbiio9tYM2cx0ZpwvPg3Icl/zp6SxLTNpUQlm6wHMvVk7pUSNZD2cjEmpAcJlg
         2NCOb0ZL1aHPNbVwgiWKaSdYMEELls574FFiSNoa4WItefDMbwvPLMNyZiWCPmJpgmgq
         wXNs/OX1bHBxwbJlB3biAqncDAeNUT1mmRW84avwYFhlOpwIEjS4iLHJ6DoKnX3NOwqW
         ++hbnlGDZYT4Hj4kUYCr+YYth+mBptz1fHPorGKCJwZAk4jW1AvkE2RLsh61dKYFwfOU
         pw0w==
X-Gm-Message-State: AOJu0YwTYeNHDaVhOv8gbb8uWMrqVLQLNa2aA0MMLF326MB4Dx/L/6i/
	Wb+aKdSieM3OD+X+BhVd5o4NCjFAjWk=
X-Google-Smtp-Source: AGHT+IHhwtAi3JjYDqQra9TFX6+R77r0dYLrEzIjnDhPe08Ti2bVxNvNR0Ge2N3WQ9qnCmUVzmYVGg==
X-Received: by 2002:a05:6871:200b:b0:1fb:23:6feb with SMTP id rx11-20020a056871200b00b001fb00236febmr6751555oab.39.1704825424944;
        Tue, 09 Jan 2024 10:37:04 -0800 (PST)
Received: from [172.17.0.2] ([13.88.99.129])
        by smtp.gmail.com with ESMTPSA id a22-20020a630b56000000b005cda4d88933sm1898557pgl.43.2024.01.09.10.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:37:04 -0800 (PST)
Message-ID: <659d9250.630a0220.d8383.7cec@mx.google.com>
Date: Tue, 09 Jan 2024 10:37:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2600522851055547825=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4,1/4] Bluetooth: Remove superfluous call to hci_conn_check_pending()
In-Reply-To: <20240109174928.488595-1-luiz.dentz@gmail.com>
References: <20240109174928.488595-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2600522851055547825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=815485

---Test result---

Test Summary:
CheckPatch                    FAIL      3.12 seconds
GitLint                       PASS      0.87 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      28.61 seconds
CheckAllWarning               PASS      31.31 seconds
CheckSparse                   WARNING   37.01 seconds
CheckSmatch                   WARNING   100.36 seconds
BuildKernel32                 PASS      27.23 seconds
TestRunnerSetup               PASS      446.17 seconds
TestRunner_l2cap-tester       PASS      23.56 seconds
TestRunner_iso-tester         PASS      47.72 seconds
TestRunner_bnep-tester        PASS      7.47 seconds
TestRunner_mgmt-tester        FAIL      230.72 seconds
TestRunner_rfcomm-tester      PASS      10.97 seconds
TestRunner_sco-tester         PASS      18.05 seconds
TestRunner_ioctl-tester       PASS      11.99 seconds
TestRunner_mesh-tester        PASS      8.73 seconds
TestRunner_smp-tester         PASS      9.70 seconds
TestRunner_userchan-tester    PASS      7.22 seconds
IncrementalBuild              PASS      96.93 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,3/4] Bluetooth: hci_conn: Only do ACL connections sequentially
WARNING: 'firware' may be misspelled - perhaps 'firmware'?
#84: 
requests in the firware.
                ^^^^^^^

total: 0 errors, 1 warnings, 0 checks, 181 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13515173.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 494 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.195 seconds


---
Regards,
Linux Bluetooth


--===============2600522851055547825==--
