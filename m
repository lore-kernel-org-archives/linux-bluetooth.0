Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333203BED38
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790551538; cv=none; b=riDPvVO20bVuEtoYJOSMT1aAP7Vjv3s1ZZXCzK5Qkc3mvNlxHKbYv02msSxj8+zSUktbFVGKAVVprInVry0K8GNq0JraTEO90DeK2yemVvAA+E27AutoFyqdfSVShGQTMhFgTZzxO0WM8hpCUv4tNMxVwsE+WFqyHGC+MbAsfe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790551538; c=relaxed/simple;
	bh=kYRL0lSvYuiArmLp8qt64NLyezfd7GLLDQDKAt2yKNg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dweBDHcWGHmXfjTKiETGzBsCjQTse3TjV62CxnhO+DBHF7OGoMMMXD1Gw9uJwf3lvzTx+JOLmDbwB1PQJ7hLyCFAOWenA+igRpF4A9nwSgPjr2+S9lOYqWwgiG0M2069OZpP/HkizpZwiwkCTRPCXd06sqrJhDe/+Pr+OecrFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co9J/3jJ; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co9J/3jJ"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd05d97cso2804521c88.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 16:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790551536; x=1791156336; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qrjau9Il1Sz38sigYtUyPOe3lDUgFhW8F01TAj3pCd4=;
        b=Co9J/3jJYVUWghSFd71x8e4ZqKgsWHVHta2uaydyKXI3l/JRMQuuQWGxc4qb96KyO2
         HXuJfFhtgl+ZSlUiRsXujl8wxNQQ8C2Xex4n4R9wRvSHhdayH7l2WRVOW+GsNso15brI
         +PtzvSx7pUmFi3zzdOouMyIJXdpPGFrh53mGa9U0LCUS5VxTs82TJ+qIW+c9absrOxKT
         HkzJqvAl0jSuHsR/HlLr2+MdLozYu6fjWfQid45f373XrKCh7lEAGohSTz8YTefHeTpZ
         lL+wpVUJPOEKeevxm492fzqkfNzIwQUKzetGnULX7Ji6yp3rng4P1LVnvDV5P0ymxfyR
         nWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790551536; x=1791156336;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qrjau9Il1Sz38sigYtUyPOe3lDUgFhW8F01TAj3pCd4=;
        b=hxqs24eMI9eijZDuJUIoQvo7wvYKCWNGfVBfdLBlHgzqCYylm1VtRsn9DFt6w9tKeJ
         QKHu83h93Z2EgqJlizSvO6dZoTKKNQDZjYn6QrvndrhHxX97CpgAcGKvyav313cxSml9
         ll7q7rigWVHDX7mRERE6iPDmjlMHtKFBv9UhLBU9P5jyKSuujFBmMX1aV62VSmJnRXdu
         9K+AxrRsdRsPCSuZKG9JzfB1/83/5kfQHQiIRPlRksJae4yj6nJrN37b7NyOLZck3jYh
         WEgzs4oHp8YvAyz1/kl5nehrUBovJmY2m7QfBh5xS/lyyja/m7ElCk9MmWAeSiI+ssKh
         2UAw==
X-Gm-Message-State: AFuF++nDmayYQU8USfQjsPG8KZnUUG3W1eHYyCfCefzfrItG575UL6K5
	D9SsWGi3Lii3U+goICfVSwG+McSWU2P1588cmyoW/HiQmLn6FNTAMc8gNFvCrA==
X-Gm-Gg: AYBFou3EbQmJip7EuttI/5baErtUV8Q6NCr8CWLxu3xjUtWkqE815o7aqG1lnil53Hs
	2g7kr6UdujhLooPOq3YgeOi9Q4N7VmhLV3WqX2ZBIGHqBEsFA5tj4+fV6nmrvpIvxli4FBPmC1y
	79Tfh7suEYc+5ZxIzaRk7CI8trTuOM5BfMZoDC/WJyS2ZAg1hcHJi4+C/WqTXEGozeirNMoXY9q
	pPsoKXPvJpII3A8o2ygK6amaKL5Qh8f2nodqaif5i+rQ7KIaIFLcH8QSTP5ER5LjZOQgFPNCey9
	2ymlNV161BwPesSDst7RovpKM+VzspgST/KmX5/Cf8PpBbQiP9aJbUSE6huhm2pGOHKp0SXU4/9
	rYAkyN1IzDNREZPvwKodZCI8XADOBGnB7+FGygxFTX/f3Y7UcuSJYZjCmpldx115Zkj/TL7ke54
	+EDYra2cK6jKYuYpBN3iQuXn38Zx8cx/qNCI1dfBpGZ7lqRalQ+9avyCDl7B2e9pqZ915rmcyDw
	zyC
X-Received: by 2002:a05:701b:2404:b0:149:50cb:2175 with SMTP id a92af1059eb24-14950cb231emr2386131c88.33.1790551536049;
        Sun, 27 Sep 2026 16:25:36 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.88.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad400be8sm18370659c88.10.2026.09.27.16.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 16:25:34 -0700 (PDT)
Message-ID: <6ab9a5ee.b97a138d.6f87c.1bf3@mx.google.com>
Date: Sun, 27 Sep 2026 16:25:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6874438626356114715=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: Serialize SMP remote OOB data access
In-Reply-To: <20260927064250.3692041-1-nicoyip.dev@gmail.com>
References: <20260927064250.3692041-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6874438626356114715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1174574/

---Test result---

Test Summary:
CheckPatch                    PASS      2.55 seconds
VerifyFixes                   PASS      0.73 seconds
VerifySignedoff               PASS      0.61 seconds
GitLint                       PASS      1.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      29.84 seconds
CheckAllWarning               PASS      32.51 seconds
CheckSparse                   PASS      35.23 seconds
BuildKernel32                 PASS      28.10 seconds
CheckKernelLLVM               PASS      31.78 seconds
TestRunnerSetup               PASS      691.48 seconds
TestRunner_l2cap-tester       PASS      15.98 seconds
TestRunner_iso-tester         PASS      36.52 seconds
TestRunner_bnep-tester        PASS      2.86 seconds
TestRunner_mgmt-tester        PASS      59.37 seconds
TestRunner_rfcomm-tester      PASS      4.17 seconds
TestRunner_sco-tester         PASS      7.25 seconds
TestRunner_ioctl-tester       PASS      4.36 seconds
TestRunner_mesh-tester        FAIL      7.65 seconds
TestRunner_smp-tester         PASS      4.02 seconds
TestRunner_userchan-tester    PASS      2.90 seconds
TestRunner_6lowpan-tester     PASS      4.07 seconds
IncrementalBuild              PASS      25.50 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.552 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds


https://github.com/bluez/bluetooth-next/pull/828

---
Regards,
Linux Bluetooth


--===============6874438626356114715==--
