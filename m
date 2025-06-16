Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC2620C030
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091890; cv=none; b=ak6pa3M3b4YeA7aOYDgk47Qcd98zwuiTgvbWHSDlZ4daxfPEjJ2y5l6I9ApqjVzyyCrEslVwHNqhVhqCU4AVLT0qm685nur7J8w0IiaspAO2mcITlwptFp6y+rfVrTY2e6/iVndCSoIuKcnFCCTlGS34JraRykWxrbD+49CqTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091890; c=relaxed/simple;
	bh=9eresGpW/xyI3yd5vF5TGICgy+MhsvLkpY6dW3Pn2rc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U7gByMJHlYjCo0gVVqdOjFTFkQ1Z23ev1GHTn285RMd2pCinuvUunTay+y9DVTnRq2tYudP1m+J5h71X+kEWPaGObmEImFbVhOiroIu9NmDpyfIDOpIt3cwIGzg6q2fExvcFPYS7pmibuHXw5u40PnVzlNgI2Ap9aaYPTYmPzds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAPTcSKC; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAPTcSKC"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fad3400ea3so47779256d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 09:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750091887; x=1750696687; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f11LoDlcPXT3iYfltQloNv67NaOtnQcxFm5mQYziUxg=;
        b=IAPTcSKCKgpusLUcdqzOBboZWqsbmHxmE7e0X6BMEATwOKJM2suCQpguPJ2lTlWVzg
         as3ScXcuXH2p6O2k605UTiD5AYhUKJcxA4U5krTz0cyJal7i4NTohVn/aIp2OYhVsU6C
         h9F9SdM5OPwE5cSmTFIaneHRmxCt8Oys/lgQMfb1O+T+ZZGJvueMSwuoDQ8T7M2N+jMB
         1K/D1mUIBJU7UEHugh32bSdbwsPcCRbLGPdCsmRCdcAO9hujwU0+RsoJVnhBGEfciGnV
         mGiDqpQLUaoYU3VNH//ioZGzeLpTTTs6iKh3xAMPVzdMaZl1wUrpum8N2paYWY2U2tv1
         YHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750091887; x=1750696687;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f11LoDlcPXT3iYfltQloNv67NaOtnQcxFm5mQYziUxg=;
        b=Tm1FPJUzRPzPHTcZEXtV22FP+hY+ezLfrlx0Qn4DOIJxT/iJ7100c2OLWkRVCsZNh/
         MOmp6uNRK6cxwBAm5b6tq7JLDwQ5Y/MpgBiEGXXuqicZdF2rRrgOPCyPneW2QTmAKw4d
         DtloheVsQ0zlOaexE6fpZQwfgFkLHE+ItbJqwTGhe9kgKbxQnBcLe+9DGRwQlI+ZzSLN
         neRTUFnZb0YdONmL8+mUlC+xmcYq3BJrTnXoJs7m7PbjR85Oiz/WBJDv4hpHshfJDRg0
         4UWXiYMNZHwEckGh1wDYc8VLZ+28I88MeLFsI6ruBeccR/tMwQuplg8ebwUlAoxucrKl
         PlTw==
X-Gm-Message-State: AOJu0Yx42RN2cZREGaQUUOVFGQZTmwvMbLjZjO/tCyma22xW/XEj2V3o
	573jYGyJHTj/thY+YaIxLLrR5WCBakqPLzKVx6tgJJN1OHIzYLaS/33vQbzYiQ==
X-Gm-Gg: ASbGnct7OgX3xBYemXR+0semF+nWWE3jeXA4gg7tWVseSafI2dwHUhEUAv5r+raLhrG
	EDXrvUsPoKhPc+MxqTFJ9fZHFFBGpeqNIIt18joSJFcInITxR9wAZvACOaMvRGPLncpEdbf38o3
	ufAz9aHgeJKuhnPDjgjwmOkqUE8/bbxnVzeSu3VSbeHPeLHxMfyCv8aMku9fMjNT/CeA6+gGkYY
	BQ5mU/WDty0ECOkK7oZQLv3k1iU5iyWaCYHeGOdMvffAOgkamEIJWX+5BY+xnFDOEwBmQdNC3l2
	zhEoliG3RcU5XZmGqQJBmbou5e3aSpPPCSm6poUoQF1zv/afFnYnGm9n4cQ9eNLzJvk=
X-Google-Smtp-Source: AGHT+IFWl7wT8e4Rsp+ft20h/Ue+RQRLLMyNoDIQcR4k5kYrKk4URjMzGXAR12wT1iCpn2tsthA9tA==
X-Received: by 2002:a05:6214:b6b:b0:6fa:d956:243a with SMTP id 6a1803df08f44-6fb477927f1mr140990196d6.30.1750091887527;
        Mon, 16 Jun 2025 09:38:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.62.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c4cf21sm52964746d6.87.2025.06.16.09.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:38:07 -0700 (PDT)
Message-ID: <6850486f.d40a0220.74a5e.452b@mx.google.com>
Date: Mon, 16 Jun 2025 09:38:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8228364880366953081=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Add support for BlazarIW
In-Reply-To: <20250616162633.756567-1-kiran.k@intel.com>
References: <20250616162633.756567-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8228364880366953081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=972597

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.18 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.26 seconds
CheckAllWarning               PASS      27.28 seconds
CheckSparse                   PASS      30.78 seconds
BuildKernel32                 PASS      24.56 seconds
TestRunnerSetup               PASS      466.01 seconds
TestRunner_l2cap-tester       PASS      25.98 seconds
TestRunner_iso-tester         FAIL      8.08 seconds
TestRunner_bnep-tester        PASS      6.00 seconds
TestRunner_mgmt-tester        FAIL      134.71 seconds
TestRunner_rfcomm-tester      PASS      9.43 seconds
TestRunner_sco-tester         PASS      14.96 seconds
TestRunner_ioctl-tester       PASS      10.12 seconds
TestRunner_mesh-tester        PASS      7.50 seconds
TestRunner_smp-tester         PASS      8.75 seconds
TestRunner_userchan-tester    PASS      6.31 seconds
IncrementalBuild              PENDING   0.89 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.196 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8228364880366953081==--
