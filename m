Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44CB36D4E1
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300504; cv=none; b=lhc2w9WF+bkaLW+ubqrs6t4vC9gTY98fJrE3q7Tog68p55iomG6fHX+3RU9nKWaFX/MAoQDz5hDaW5M2jHiETNSn7G6+wLCWVoXL6WgbW5aa9g8dRuSsTk2Axtcn1aNPtVjEgQ7GadnJ9vXjMZtAs2NwLLjuSqyNqY0qvDsXVtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300504; c=relaxed/simple;
	bh=+vkHn7sGJhOtQqoEjr23S7jqjqCuwug/kC1IYFNv97s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uiQYep8lESF7+nxxw+i99TY9vZ6My24Telwhc5N5rtrLZDYoo9cCkCaDPL0Es80CP/Nuiv7NKkacc5kwc+z8zeyNIZHM9+mn7BSYLQ16GuSOiw7Ezzs7BNRNfh5Q7/Jsx3e4Qw2SAhfGZPjRdTlw96YQcyZV1gRL8M7OmfxBXA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYUTyaYy; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYUTyaYy"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-47cbd444fd0so3415030b6e.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779300502; x=1779905302; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pOkUNZkCBUwaf0BdA5q1uapfGjJbvJX3Ttyqzvx7dpg=;
        b=UYUTyaYyW9hmnJMFhePPWh6MnCPzpREtf0xNW7htWypEWLt2S9FpQr0otu0x6mKHND
         OtqFtq0YqFEz2MTam7bJ/5gjLSwwuLjnCiFnvQtVyPlu2PWNE2KqYEDN0LjchedMQSds
         yIL/Mc461T1p9nUw+TDVd/csNlJ4LoISdniuoYhb7OyA6+JwJCDZJh16mCX4jv9EFlZX
         j7wYiMTAQoVkfWcuKVhq8HtdZC6USfzIazLWEKWB+sqOwdZ4fxcChbrcaWLZCwl8k35n
         Cv9L7zbcZra1UZLTLUZ0d8Gn8scyR7Ak6i4JEPNKQDBRsXHQxrTRUrmwRJc5Vd1sbvNZ
         DtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779300502; x=1779905302;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOkUNZkCBUwaf0BdA5q1uapfGjJbvJX3Ttyqzvx7dpg=;
        b=rcvJl21URkDJALihQi8QzVvCNRj69UWDIxs7cJd+skH1JjONI2KhvN3LOjigij5anv
         153B/xmD36bHXZvP7JvungNlg1ARnWihg2a0k8aNYK9ee5LH/956SnrkynuuwPIZ8Vjt
         hoVC3GrHwnEzDylLaJgsGqR4T7JiMyaxXtKqDpuIBNvd0o/SnB0DXgPlOf/r0iTFBOlO
         0PtICikmwYUOEdYhlTHbekyDOI3dxs8x5MscqP3IdOhhFOPRJk6DpH8O9WVIF2jIxwNr
         fsZarrv5ghlCbq5kK+uaNoyjc9VyRnPrM3L1UAekVNjkCdeCo/ZljdjcNDVB8sHGrC/V
         nXIQ==
X-Gm-Message-State: AOJu0Yz//SdV03/NhfdWY0WUcu1YF5Dp5B0+NWOYiojiwBOGdrCX4XJH
	zTmSyJzzXgkrwXMOTz8LeKH/7meLQOUOtiGwYNFy+z0/XhmiwCsrHDC0ByN2Xg==
X-Gm-Gg: Acq92OGYdPuNqZz55q1xHwu3uQ5fB8hUWn5h4aYkzFkLDqZRRjyGYK8MJa2yooG82F6
	StjQOJGISooMmnQMYL5W6FGzKpIdSeplK7yJPu0hduXEEgGIqqG/8YgKJQWoRNwf/eFSyUv4tJ+
	8gVGUDyeUdx7Grs92hoYZHmvfWQMbGn+GcFGC0mHlbwyewIbCLsQ5oC8VKHkZ6g3ULvt+eicHiM
	SxI3EqvKSeNsmZPhOcZlv4AsSNEL/ujH077G6WOD2dLAMkMSudM5nwb/GWdypd2R/3QHibvwush
	SyDsC4RAo/NrfrbtDd3QVdLsBO16nWaOQf+DEFicy5fXj7XJGyRX95dtVs0K4gWsLwPg3YTn2HY
	Zs46AsD0K3WesR1hGNR6muOl0UMxHHlHJyhnZY6IttF5NDjKDaqefMxAXxtuRqHLqevLYnMgbRB
	M+cTz2OR6ELdZ1muYYw/0Ylx58HIAQHWo=
X-Received: by 2002:a05:6808:6503:b0:468:776:1e92 with SMTP id 5614622812f47-482e576f723mr14313683b6e.36.1779300501776;
        Wed, 20 May 2026 11:08:21 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.251.240])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee531c50sm8657445b6e.14.2026.05.20.11.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:08:21 -0700 (PDT)
Message-ID: <6a0df895.8f264b12.335f0b.552d@mx.google.com>
Date: Wed, 20 May 2026 11:08:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1382521673532042496=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_sock_cleanup_listen()
In-Reply-To: <20260520163859.2859782-2-oss@fourdim.xyz>
References: <20260520163859.2859782-2-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1382521673532042496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098174

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       FAIL      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.43 seconds
CheckAllWarning               PASS      27.91 seconds
CheckSparse                   PASS      26.60 seconds
BuildKernel32                 PASS      24.81 seconds
TestRunnerSetup               PASS      533.99 seconds
TestRunner_l2cap-tester       PASS      376.93 seconds
IncrementalBuild              PASS      23.53 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v7,RESEND,1/1] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_sock_cleanup_listen()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (88>80): "[v7,RESEND,1/1] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_sock_cleanup_listen()"


https://github.com/bluez/bluetooth-next/pull/222

---
Regards,
Linux Bluetooth


--===============1382521673532042496==--
