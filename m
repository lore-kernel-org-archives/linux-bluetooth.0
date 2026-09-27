Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F73D2673B0
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 23:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790551642; cv=none; b=VA8zrs1l2oXvbW72yWiqAHIo0p543eOL6GjPAG3QgwqOY+cEteifrnS9OIXWBIO4PGiuyOboK8tKUX3pqhhqsatf+RTZboyNLT+a5B3waqgbTn3oIeB1ePRwdTgLMHq1l+c2Yj4YI412wytXoBbSacOn7l9YsAyBOrDf7YHeYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790551642; c=relaxed/simple;
	bh=ANjiBKlN0WH6Rryh3INdwt9+FGu0gW5sudA3b/BHC9E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gnSXKE0Glg3UQFoiiCg3niv6S7UHkEKTa/AzKDoU/9F1hMRHta6S35keC6wpj4tnQ3Pum33qyiUGMXBDoWBk1gfibIMMF8XpFI+NpQhUs/mPKcJ4a65CWZTUxwsw/0eVaOLAOY+BQTArXtLeHAWiKj7QPiahnAgqsjOM6vZJM4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0m/d9cB; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0m/d9cB"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93bfa7b2093so286546485a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 16:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790551640; x=1791156440; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=//MoToUdMudLeXA3LV3Tag6gRQOGbRLfIz/2o2C0sEY=;
        b=R0m/d9cBOr0gJPPNGkOBUsHoKt97jqLDKUDm8zJFctwc8sqyzn+duVFC2yXlcorOdj
         XyNjbX9yhScKIONKfQvUu5oay+yLVstbTPbatx+CC9SyakPDY+dC3HCrubXZdijHRbIc
         tii6ZyhkwZ2qYqQYrN7MUOCpnVX7FYfapn+D/xZ01p5OFCkh9WN9hb7wdp/2GbPN5zQb
         ktQro+SJirTWIUxr37ieVNPi1soipYTEhn50Tc8zvPcJ/1RP2TC5OavgtvlfuSCv3Z0U
         CG7EaVikYDxx3Q/+YbPInHIZohtAuZQYe6C7/fWXhhoo1fn5/8oNtt8PEGEzlLofbMjV
         xcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790551640; x=1791156440;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=//MoToUdMudLeXA3LV3Tag6gRQOGbRLfIz/2o2C0sEY=;
        b=pCT92WTxRVWEjiklLm+lTDNj+NR2yc74gBHsl7d9h/q27MT0T1aMR/9mtNbhTGcOY5
         Yz2gI4d0plF5sdkRd3hA/44CVdVvazXyqykvI0pVTdRSx2JkTxYAjgFSys/hNkFajGsW
         j2UXhu0ONs6t1nU3lKrbywvtISfDVKv29BXOT2A6ZUKNc/8RUXKznWnpcnhf/RKlIaNX
         vWqCrMQHqBjarZSTi6wnWUbAHUdDI1PrtMtn2+4ZmX0pMNdc+WkI3nrosU3oDrBZQK+J
         OeZmra4CYGWmmVV2lxfj0f4ow4p/yx99sJblE5Ds0GxNyxYz8jZb51yi3FKrQRiW4w4J
         Prtg==
X-Gm-Message-State: AFuF++kRcDeVi/6iAq5QVxIO9GeW5Vx3nys5ngKUXxufVkVHvOntIcPL
	nLP4qXsWKLUeOlUKDiz1grY4P4pllzzH1vZ0RsRlmjo1Gmf5EqBZBsvoOJcxxQ==
X-Gm-Gg: AYBFou13IFDv5ajf7CiTBw3cGAlF6Opyfr3sgXwl4OgX4GMCG5SAzyBR7aScXdII6D2
	irICj4n28Ql4Q/lpdZ3Za/8/dlFYmgihWV/e1HgSQMicJD2a+7XwK8xLI6g+WYYJHr8NXMsC6so
	9sRFgEOW/TkOaZywEc+mvvjFtRNZTELDLXHfp0GWjY5qGD34NR5J5nUJoQKFQWSCvb8eGv5XlIa
	d6rEhm1xsPBy06r8yTlt+jtgECSC0LtcbIIK10iVhnFfK5uAqMM/ahM4T6Zikyw4zxRKAMCOAQ4
	McSm6nX17j7LLYSFvJ889vOA/VbAlo9Qdic3R3ArO9bHz3iiEZiA0NkgLSdya5/iKZjYrZEMN/4
	KPT7hRF0amrpyHazJE+aPtrWMuCvVh+nz0FXLFBhr8K08dRwjHFKVHU8GkC05Tgg+k1212TbBo3
	zA4OfJl8NR36ljzaS2eWmfPpz0Xl0/CRCQq4UzZWO1IkwHikOuXVhXAQ3RTtATTcwNJyKMgzy17
	MiPo6HG
X-Received: by 2002:a05:620a:2955:b0:93c:6ded:4665 with SMTP id af79cd13be357-93c6ded4a0emr581573085a.1.1790551640425;
        Sun, 27 Sep 2026 16:27:20 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.207.192])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c8144f9aesm8376585a.32.2026.09.27.16.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 16:27:19 -0700 (PDT)
Message-ID: <6ab9a657.24090018.283065.3160@mx.google.com>
Date: Sun, 27 Sep 2026 16:27:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3643020157812094702=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: hci_conn: Lock parent access during enhanced SCO setup
In-Reply-To: <20260927110450.3902328-1-nicoyip.dev@gmail.com>
References: <20260927110450.3902328-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3643020157812094702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1174575/

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.13 seconds
CheckAllWarning               PASS      35.37 seconds
CheckSparse                   PASS      38.27 seconds
BuildKernel32                 PASS      31.31 seconds
CheckKernelLLVM               PASS      35.17 seconds
TestRunnerSetup               PASS      806.02 seconds
TestRunner_l2cap-tester       PASS      16.77 seconds
TestRunner_iso-tester         PASS      29.01 seconds
TestRunner_bnep-tester        PASS      3.18 seconds
TestRunner_mgmt-tester        PASS      61.71 seconds
TestRunner_rfcomm-tester      PASS      4.49 seconds
TestRunner_sco-tester         PASS      7.70 seconds
TestRunner_ioctl-tester       PASS      4.69 seconds
TestRunner_mesh-tester        FAIL      7.85 seconds
TestRunner_smp-tester         PASS      4.35 seconds
TestRunner_userchan-tester    PASS      3.20 seconds
TestRunner_6lowpan-tester     PASS      4.43 seconds
IncrementalBuild              PASS      29.71 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.409 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds


https://github.com/bluez/bluetooth-next/pull/829

---
Regards,
Linux Bluetooth


--===============3643020157812094702==--
