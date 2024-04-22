Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB67502B3
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779841; cv=none; b=cMMh7m2DzJpChbwt6CPlQCoMix0ia2a+v6rP3o50DEzdaF+OiVs/5G4b9SvIxE+0EchiQo5kQdTOevOqSgA0PhkICTbn/N6MlF5JaWS8d3Byfue7DDkTGqMkFPPGOfEwkEZBsPEtyec9yytEuxrer8/XRQGM1Tnx/yzD7FzWH0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779841; c=relaxed/simple;
	bh=yJxqx2Fv3uHdCyVbz9ZZJ7pvlnWZLkl8m1zbhAi51v8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rivyqifnFxbgzHnxP/Mz83N4kDSXvgTZCcu1jDr3+PMyBho/5+Og5TPZPRoqcVCzWaL/JDD9IeAapaZqD+E1QWd5O/L2oFwMJgagAHw0ZMJEZPG4xOAtYI03fvaZvULNxbG+kjyDJHyCQlU/ADnvzLwjjWZZo4/Tu3nAcZ2QJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feWeiw6d; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feWeiw6d"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso2061751b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 02:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713779839; x=1714384639; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ficQcfQPne7djzqNLQvK/IQeNtFZw6zaC/OZ0Cmq/pc=;
        b=feWeiw6dVbGdx+UgRT74H79jUIWfUvF+Pfhq4DbY3rGUl/Q/1vTdsnbdm52LnK3M55
         pUSmTW9EL3TPbPAp6BGqQUQFf3H8VQNPZPeyrp8MB56kDfGOE5JjmCI1hxGNWnjiOwLe
         9QOqxCO2DsKKusnn0oRvtRY8gyTozsueNGGimGWYk3evaw0vXkYi1JENmQRrEeSX6/Oz
         y1UzYTKQEljoalWCViPiJm4iStObGS1n0KHZ+O9LWdoME8j+WDRlDenhuj4YYaIZZCVs
         jVkquNIthDvesYi8nzdQFdJOQwByhEgtJ1XSMSpunLduI/xxBxsmB5R062fnRjtM2ATm
         7R7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713779839; x=1714384639;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ficQcfQPne7djzqNLQvK/IQeNtFZw6zaC/OZ0Cmq/pc=;
        b=MJFZFu7zvjS23Fm6WyZEcUofW40XJi4Qw3ZgHnsxRqLFhSkkgTHMe9d8BZJO0boExr
         vTppTZ1ZPRbfbm+sGK1HqBzxUa+X6z9oMiWUufzH5iFX6rEQhO3hm0LlYzdmsG2IrlW8
         CcYOppdSQGlXZ70YAuWAOUY5+42tFZaZLL4IcH6KMejrxnkf9G28kMFL4ClwN3uuiOhA
         3+/6J/qM5M6gJKXyVn0UNMGOENVFpZzKkSujwn+fQ+JM+98gzTdRlyWFpJOhXsBPH2Xy
         FX/ZwG6L6ReNjfEQV1UGnIdjU9DwgAqlAPVVI/yl5QF7PFxss4Vehe+GBP2S4FIPk/Ek
         44nw==
X-Gm-Message-State: AOJu0YzHge8GKLvyCcIdgo6RD4GCkndK2+lSKU5jz8Klnsyq/4T+EshX
	0FWlzLmDTnzytKuv+A23cHo1gUtBEUDTtkW/+Dr3diwFfSgvnh9Xxtz9FA==
X-Google-Smtp-Source: AGHT+IFOlPfJC0SzZqw3hM131mLqLIIEzoEwgvfptrcom3rLGOQFPxPTttOnJToSbwM8COp7UOPfDw==
X-Received: by 2002:a05:6a00:812:b0:6e7:48e3:7895 with SMTP id m18-20020a056a00081200b006e748e37895mr17168355pfk.2.1713779838690;
        Mon, 22 Apr 2024 02:57:18 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.170.226])
        by smtp.gmail.com with ESMTPSA id p7-20020a056a000a0700b006ea8ba9902asm7446929pfh.28.2024.04.22.02.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 02:57:18 -0700 (PDT)
Message-ID: <6626347e.050a0220.2997a.7e3c@mx.google.com>
Date: Mon, 22 Apr 2024 02:57:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3901380174975256738=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [v2] Bluetooth: Populate hci_set_hw_info for Intel and Realtek
In-Reply-To: <20240422172027.v2.1.Ib96985e197f3db620a127a84aa20f3f3017aaf57@changeid>
References: <20240422172027.v2.1.Ib96985e197f3db620a127a84aa20f3f3017aaf57@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3901380174975256738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846581

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.18 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      29.68 seconds
CheckAllWarning               PASS      31.98 seconds
CheckSparse                   PASS      37.79 seconds
CheckSmatch                   FAIL      34.43 seconds
BuildKernel32                 PASS      28.31 seconds
TestRunnerSetup               PASS      511.93 seconds
TestRunner_l2cap-tester       PASS      18.17 seconds
TestRunner_iso-tester         FAIL      30.49 seconds
TestRunner_bnep-tester        PASS      4.58 seconds
TestRunner_mgmt-tester        PASS      106.96 seconds
TestRunner_rfcomm-tester      PASS      7.09 seconds
TestRunner_sco-tester         PASS      14.83 seconds
TestRunner_ioctl-tester       PASS      7.44 seconds
TestRunner_mesh-tester        PASS      5.61 seconds
TestRunner_smp-tester         PASS      6.52 seconds
TestRunner_userchan-tester    PASS      4.77 seconds
IncrementalBuild              PASS      27.26 seconds

Details
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
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.217 seconds


---
Regards,
Linux Bluetooth


--===============3901380174975256738==--
