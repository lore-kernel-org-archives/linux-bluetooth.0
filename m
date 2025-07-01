Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC9226E701
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364287; cv=none; b=KtL/AMH9mEwOlQ5fJ9ZgCAgnYszMpNnoTxQOAE3Yc9cGB4PVyU4QY/TeABN3jDNKKW/fTcAJPvaxJWwU4dq668gTbqAgxhCQtd/LUNWwT1YrDoUiwaHcbKwMr+a6DUxKoBNtbAuE+jUhrg8zSqNkBldRyEXTx+4BJtITjLojzWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364287; c=relaxed/simple;
	bh=/HVm+Mjw0CctHLUT/JAxwgmUWvxHmQrOJEZlH7tDkXo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SZ0CTyuXeyh4ojqiWdZtE71WFpYYqytRMzgoiJip8dmvAeqlfgXnGhCHLQ9UYrCM9U3bMvFlosvQOCPNeBBjBS+9O5Da3ZABiPNqoq6k0Q7lsbCBLiq/IBl1zACyU94jg08YAgBBDusYfVZWSzogH6Y08TaaYi4PDz17jnGr6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cz8DCz5v; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cz8DCz5v"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d3900f90f6so289556885a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jul 2025 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751364284; x=1751969084; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4KFp0yUics4pmKTR9ZoIaCbBy4PTNjlkZXb6m2/jDNU=;
        b=cz8DCz5vK+MvhkEfyWWqRU3pJlQJQU8wEY5740Hl92GJDS/EOiPi6xbgS35W4WJzNI
         YE4VIXd8VATYu2P0RwH6Yf/+zD6E51SM5js+UkjS2oMqRokGoU5H4SroS9hQFmGcR8PO
         kNc5bdJDtSEsaTlIyqDkxUj0A7n5gj9xw0zOViKChnEeItwInJ5Am3aQUZ7U2rpn++x0
         VsKMYmvIE7Jh84aOFq9AKfHX22sxfIp3J/3IFy/SvgZK0uhdG1rCZtyE7FtipvdLfW1t
         +KSOy9n6dCp+jbFpmn8Bfn/E4lDgnjy7ffX8jO2O23ruFsL10Y0iipAbO0pbpsj4lMc1
         sWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751364284; x=1751969084;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KFp0yUics4pmKTR9ZoIaCbBy4PTNjlkZXb6m2/jDNU=;
        b=rzD/ytr3VbUHUyYxQl3/SvJEjCKmosZia/ElRqz5mnznxpVSzHsEUu04L2QK6JQni9
         9cFBF4H0XwHyrRUpXks7fqgSPa6B7LayeVx0RDvqwg5G2I7Loau/9N70nzQ0oiz4Ze8Y
         KMAExB/LvgXb5Can95BjywuaMpNpZvkLlIYTXozsMV4KcTvbMg8GycTxL47/qN+Rpg9T
         rXa11APRIrPMRd9u4+hz4xG/qtxHrgAGvoWak+Pc1nEm+d+zEAFPTaUZAcYtR8B1Rrfn
         BrbLzrXXZGzVCG50IkUK5cEdh5FIdlD6GyDGpamCbS0LZi3KBBsEwZ0SKi3ebngrtIqP
         Jf1g==
X-Gm-Message-State: AOJu0Yz67XpKBLntlIUsWGAkxheH7CilrXPYIwHXl6NZkLUhPjjc4uk4
	1nCXGIjaJiNsxqeV7/wYpmO+HvokYiT9KijQUxJRt9BbHL7WUrp2zYdhTo2grg==
X-Gm-Gg: ASbGncuo2M3/8swoeoakdkEgxyCVxGxbC2l7JS6Ktqn0kJztbaVgv9qKb2z453L7LAi
	EOuw4w9Hc1HLgOPSf7q8upjo/V/oUflHBdSjF071O4s7LO5CBQdksCol+QXx5p8Rt0DOwl5c8H0
	beN5VTYY1I4KesXNYbfTdNUGkVmLOr+h1o7EyuNYOBWShlqYbDb1PWJh56WOi+7eI24RsLiXJva
	pu6wVPfSpxmy73Feip0+/qNGINyqUZfrW3+zKPxk9duKhz3kNF+nM462piQkoDTLflWrt5SftkB
	JVsADZLWKslVf+IUcv1ZgswhnML8QFHbvsHPh2FE9um/aS7qJYoQJ59wiK/tRZF295cG1SyriG0
	gGg==
X-Google-Smtp-Source: AGHT+IFG8jk2DxJ7dVDJIoJH5MCtVDierV+CP+X63RRqGulc7D1ZLLEMGbnCTB9J6sPo7fah/xFAAA==
X-Received: by 2002:a05:620a:a209:b0:7d0:a309:b1a0 with SMTP id af79cd13be357-7d4439233eamr2319557885a.1.1751364284232;
        Tue, 01 Jul 2025 03:04:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc55c1e0sm74491641cf.42.2025.07.01.03.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 03:04:43 -0700 (PDT)
Message-ID: <6863b2bb.c80a0220.2260d1.6955@mx.google.com>
Date: Tue, 01 Jul 2025 03:04:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4305016774769649653=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: Bluetooth: btusb: Add the more support IDs for Realtek RTL8852BT/RTL8852BE-VT
In-Reply-To: <20250701093630.2388069-1-hildawu@realtek.com>
References: <20250701093630.2388069-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4305016774769649653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=977646

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.07 seconds
CheckAllWarning               PASS      28.15 seconds
CheckSparse                   PASS      31.64 seconds
BuildKernel32                 PASS      25.13 seconds
TestRunnerSetup               PASS      497.90 seconds
TestRunner_l2cap-tester       PASS      26.94 seconds
TestRunner_iso-tester         PASS      42.80 seconds
TestRunner_bnep-tester        PASS      6.41 seconds
TestRunner_mgmt-tester        FAIL      138.79 seconds
TestRunner_rfcomm-tester      PASS      10.08 seconds
TestRunner_sco-tester         PASS      15.54 seconds
TestRunner_ioctl-tester       PASS      10.85 seconds
TestRunner_mesh-tester        FAIL      12.59 seconds
TestRunner_smp-tester         PASS      9.02 seconds
TestRunner_userchan-tester    PASS      6.63 seconds
IncrementalBuild              PENDING   0.71 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.241 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.637 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4305016774769649653==--
