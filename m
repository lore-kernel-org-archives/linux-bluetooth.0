Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AED059C98B
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066891; cv=none; b=rzaTwnMgwQQUhFRoncLuUPyotyHky2057zL8rppIYUQlljDDkw+UrgVhcOMoqbPseo8PQcAKY7xU5yOCsRNYgR/oXvnIfUWoC9lIsqKGt+Ax2v19IRI+gkYVnGob97ffAYmgCJEcOocq9ZudUS9NTCplX5LjrMozXtO82eS8jp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066891; c=relaxed/simple;
	bh=Yu2OnNqSULBACHHXlwKPPwjJyxNciTvFsasyqrlD3Js=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h9Ar5oQFU7WFnJi4Llx8o0KwrvT/BefL4Jd63gXk9XRf8Fw/L7wffHoRernFH7LUtfBrOBXe9aA5pa88NXF0qWUbrZeD6bsCM8h1DPnXFbjSA8xCdUNELU8PZj9qdSyz6IwYKnmPUybq0jEztYOrYfvGjyoQKCFgwL2NsBOi63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5XvrxX2; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5XvrxX2"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfbd148aso322986d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 12:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789066886; x=1789671686; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iqIyZxVOsfWOjVy0IsMYP5K4OtGY/wNzuAQNwcG/na8=;
        b=b5XvrxX2hbllARI7cqKLKV+lzLk0BVXmx2dfgDdqZ5sFrKr4Oa65kPRWdmqZcNhxcK
         K7rK4/ptTR4fKwlmBK8CEkxDNVvW06YtfSUWqCnTUiEm0TdH5JmpVZNg5fkcrMN3TIGq
         45Na3IVkeyS+s8JwvjzZM4vunn7/+8Kz9qVB7Wq9nD+ir/nQbJ48S5s3IE7JYDYIc/8x
         AuPWmzf/n/roptVY+gqDAWwz5wNWniPZbVjDOLTs86w2rqzx00TrC+dwviSbiubHDhye
         DOCXN+J2DqUApuBsGudWqnLkx64dLTEbAmNlXZXRxvfoyUGrWu+eqIqAeOVFQEAwFh0w
         WOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066886; x=1789671686;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iqIyZxVOsfWOjVy0IsMYP5K4OtGY/wNzuAQNwcG/na8=;
        b=oWBqfhXfxWukyIA7UxqJY+OMXsqPkRLifLprBQyC7w5SkM2a67Ju0WhHzBpbsJ2oOA
         tIKsVkda+n2AcaE/DJBp9DFHLiVa9KQrXEgPVNhXtje/2GjLAMcZMzAvwmD4rdhQ+/ov
         0PDSZGyqCdD/kjnpYHh1uq8WdEEd0edGB+AAajfDrwhsPJj6ZwNzNE9QN5mOglKYdnbH
         Nkp1NWiHeVbG3/JdMEn7NZcZPeFTGtHMrz5rBmsSazbCEHNHipG90L9wmDJBakJVDrjC
         2wr7Gv/eZbnXmBLjXVkEU+70OZMmkrT4sKMW1JtKffwU1docGl4e8WrrwwH3bgwxeokq
         ITbQ==
X-Gm-Message-State: AFuF++k3paL1W4Qke2LPCYY5jug4dLt9McLOD9+NUj014NjrfIuqLAaB
	Mnu0s6nUYaL7RqVvX6UrShA2Rq1DN7elPjoFjJMvXhxjXbY4LtaM4E4IE4ySOg==
X-Gm-Gg: AYBFou2wUTSUPgMFcbRvx8Pz/GshBt5vT+djufHCla/KS5Q81QKlP8p2v2hjw2ojC8S
	h+2taYEb7PT5Q4SkwiBQWazdl6+xasJbXa58P0RfPVJVdD7HK7XJjfIusHCpmKdDqlgGWUzjopo
	3Rk4BF9v0TWMrep1GH8ittYLKF8fCX9CfPxgh7rjFl5JR5MeiDdu4GXvui12T30HFyRDXDl+/G1
	adEORJVblTflF6hhZVeRJvMT5NqLSoPQ9KOF4nZmGVXqYvIgitr7Xk9WElDY2xcASK3TcZo2WP3
	OeD+eQu/r7gNn7K/zSgS9dvgGlq1jivggg66xXFzTfYT4WJKvr/fcLqiX5/7m5ZodjLIZ9Zw+Si
	V1D6v6KaLBmU6WuW8p9Vs8+Z0D9FlBhtS+Mn2F7/DkFA6pI1q4YhvTWYjhEVmwUS6JGlEXDy+4e
	b9HIfC5Tp1mI/+Q+aptIDq4iWtZ+R7KaQuJf3dALpXB3OsFe5rnjB3EV044FhVb2fD3ZCzlfrpV
	8OJYwS6
X-Received: by 2002:a05:6214:2f01:b0:90e:9460:1c04 with SMTP id 6a1803df08f44-912120f0ecbmr1769196d6.28.1789066885100;
        Thu, 10 Sep 2026 12:01:25 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.238.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f49661asm2640496d6.30.2026.09.10.12.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:01:23 -0700 (PDT)
Message-ID: <6aa2fe83.2c36cfa4.11cdeb.9336@mx.google.com>
Date: Thu, 10 Sep 2026 12:01:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8132859548727675217=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: btusb: Support Qualcomm multi-subsystem QCC2072
In-Reply-To: <20260910-btusb_qcc2072-v4-1-e78f04b7675e@oss.qualcomm.com>
References: <20260910-btusb_qcc2072-v4-1-e78f04b7675e@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8132859548727675217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1162140/

---Test result---

Test Summary:
CheckPatch                    FAIL      8.10 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      13.19 seconds
SubjectPrefix                 PASS      0.74 seconds
BuildKernel                   PASS      27.98 seconds
CheckAllWarning               PASS      31.81 seconds
CheckSparse                   PASS      34.97 seconds
BuildKernel32                 PASS      28.16 seconds
CheckKernelLLVM               FAIL      27.38 seconds
TestRunnerSetup               PASS      733.79 seconds
TestRunner_l2cap-tester       PASS      44.15 seconds
TestRunner_iso-tester         PASS      114.89 seconds
TestRunner_bnep-tester        PASS      12.23 seconds
TestRunner_mgmt-tester        FAIL      149.40 seconds
TestRunner_rfcomm-tester      PASS      16.84 seconds
TestRunner_sco-tester         PASS      25.03 seconds
TestRunner_ioctl-tester       PASS      18.33 seconds
TestRunner_mesh-tester        FAIL      19.23 seconds
TestRunner_smp-tester         PASS      15.72 seconds
TestRunner_userchan-tester    PASS      13.79 seconds
TestRunner_6lowpan-tester     PASS      16.39 seconds
IncrementalBuild              PASS      54.67 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,3/4] Bluetooth: btusb: Build the driver from multiple source files
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#168: 
 drivers/bluetooth/{btusb.c => btusb_main.c} | 0

total: 0 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14805662.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v4,4/4] Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#524: 
new file mode 100644

total: 0 errors, 1 warnings, 4915 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14805664.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,4/4] Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072

8: B3 Line contains hard tab characters (\t): "       USB I/F	|	   internal link	|"
9: B3 Line contains hard tab characters (\t): "BTHOST --------	|---- PERI -------------- BT	|"
10: B3 Line contains hard tab characters (\t): "		|_______________________________|"
##############################
Test: CheckKernelLLVM - FAIL
Desc: Build kernel with LLVM + context analysis
Output:

drivers/bluetooth/btusb_qcom.c:4255:6: error: mutex 'btusb_qcom_xport_data(hdev).tx_mutex' is not held on every path through here [-Werror,-Wthread-safety-analysis]
 4255 |         if (is_vendor)
      |             ^
drivers/bluetooth/btusb_qcom.c:4253:3: note: mutex acquired here
 4253 |                 mutex_lock(&xport_data->tx_mutex);
      |                 ^
drivers/bluetooth/btusb_qcom.c:4261:3: error: releasing mutex 'btusb_qcom_xport_data(hdev).tx_mutex' that was not held [-Werror,-Wthread-safety-analysis]
 4261 |                 mutex_unlock(&xport_data->tx_mutex);
      |                 ^
2 errors generated.
make[4]: *** [scripts/Makefile.build:289: drivers/bluetooth/btusb_qcom.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:549: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/github/workspace/src/src/Makefile:2187: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.148 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.420 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds


https://github.com/bluez/bluetooth-next/pull/750

---
Regards,
Linux Bluetooth


--===============8132859548727675217==--
