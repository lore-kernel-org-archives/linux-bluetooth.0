Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00829521234
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068245; cv=none; b=LChvArFq1gLEwpnbxnP8DbJvGtgIf0ijJR+KXiHzjLbktE8cqQQCL2bDrCeCysLW0rzZvZlBNg35cfkQpHwrJXOpmDIKAw3kq6EKKuLiAK8sJhrbhrVI3QVvoNUUl2EjXmOHhjt7iKjGDWPGGOehO9qV7zBbNjXIwWFcjSzPZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068245; c=relaxed/simple;
	bh=RW2kkDkVtpdkmUAy/VZwd0oB/AH8klL1KefDYCC+OtQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MNXG/XU+ByB92hv9mWZKTiUdUhZ7gnpT0JM1Dx1FkF9QoglGduwqZzWyoa6P8AUyPqcbGYbw6Q6psbC6Cm+opUkD4g7dC/Sn7/ncwn9CwNPOP9WIGGIt55n6p0MBZskK488C8Jeicc5ovoC911h5hLqsf2x/9VN/qOTu+Hoiwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz1TwnVx; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz1TwnVx"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7fccba9c675so8708394a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792068242; x=1792673042; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FHqZInVqU4Lk/KW1XqqJ5b5oyIB9pQ6ZbuiWogy+v7U=;
        b=Rz1TwnVx+/fdIcz4YW4TWw3Nt9D7Wh82DoSregSv87FkvEK2a7AXg8Dg6GHV2/iucj
         ZQ4IK6CINvx7mh6F1PHc/GWOz2TMkO4qUKPlZcZIEemkX4RgLwzXjWPjyjL8Q/W878k2
         XD3t+VGtp3ic67FtywoNvA40i6etJD5ik6eBR8c5TJlOzAsFNNpulM/h9KWXHA5R650U
         LffqL+KUP45myvQM551YbjsTamULkmfPb9moRdpGQ79cbWr2LVu9o44WJhzIVbEQIG9t
         dn9l5nKy9NWBW2fupeL67yHmRiiauQJBSqiDN0w6Tw+dOkz/lEhg88EmybznqPdAozTg
         W0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068242; x=1792673042;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FHqZInVqU4Lk/KW1XqqJ5b5oyIB9pQ6ZbuiWogy+v7U=;
        b=VqNGfJQ1QUa7je0b9kVTuelB2FOLfiaU5bnNlG1J61PmdGewWx9u9XhBHKRFUzmm+n
         a0bcTN5WwnomVxKyceRK24Ab3aErOhdUqKGIddgx7ahhc/wikknwA1n9mWCLbMicEpfX
         bYTNuE1P2OqeyMM8pcA2ge0+gsLm7s80OIwaizlIFa0nMb2VVrM2ezyknfuoY/Ml2cag
         TGQsEADKX/2WpOrVj+PDd8in+YTQBy7FuqUMBAnFlgiXj4D6XYIwx5SzBv1tUW+C0dbT
         Z62oMe9ZNVgQLg6BQ32R/RanGLldd4Fh+60mcMtFhAs/pQR2f/MDzFtsn5fMH7yUGTRZ
         CI3Q==
X-Gm-Message-State: AFq9FYJS4xN/TFQraqOrUQPuuJ2zBAFJPThwSciJRGwaOUhCXjJKqEMC
	PfalsipjQXGKVgPN/wM8CIqhBJ6iqCAhkbYVPEgiswZqI27JOKmtRPoHkX1fHA==
X-Gm-Gg: AYBFou3eFZh1T9HM5Tyc4Lca0ENv/4MBg8ayNLx4/+GZp3Rt6+Ill9JjcF31arnHSOY
	hY5+Rn1/5ewztCmfl6NTEQgtN6y2JBU0DZaeho5uwsmVHmhsV7pYCe39vHmtWJoOnWNSAXJLkU8
	+vndaZJELjMcvtG1GyDYH3evX1avuXgMHe3rDmN0Z0Li6u6LYClX0AkTrnnlXRHyssGsbY8Cyba
	bxlNkwCH6nK0l2cMUW8xsyCWeNutuCr8W+TppKLnrQsOloHr6SOSSETHbW28SyWT32qDXgh5ObH
	2pAdiJ14KJLFkmewnjYtfGcnX2A1gF8+SwdKTXHeszdvgJcM/Wq9zCOizph9hqIAKf0xetF/kxl
	apHPxLq6D6JlQkaocILmncgcB2QxTTVtDd3xWidGOmCoL0tiCAnFHAvUIouYaV2UXEDFSrwokd/
	7oHI5l2c+OfAdjnNcMPzSgwVIe3aXELGtCEKpkTYZ1zUqq/fRG0RUb7zSe1EyxfclANdH7RkhQ8
	5id1Q==
X-Received: by 2002:a05:6808:2385:b0:4fc:32cc:6c0e with SMTP id 5614622812f47-50b516ec932mr13254609b6e.6.1792068242228;
        Thu, 15 Oct 2026 05:44:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.40.214.132])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5283bc29ef6sm6356413b6e.18.2026.10.15.05.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:44:01 -0700 (PDT)
Message-ID: <6ad0ca91.78a3c13b.1a24e5.8b19@mx.google.com>
Date: Thu, 15 Oct 2026 05:44:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1711747667515411309=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 66ton99@gmail.com
Subject: RE: [bluetooth-next] Bluetooth: hci_event: strip Broadcom vendor bits from legacy adv report type
In-Reply-To: <20261015114903.784731-1-66ton99@gmail.com>
References: <20261015114903.784731-1-66ton99@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1711747667515411309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186421/

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
VerifyFixes                   PASS      8.86 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      30.14 seconds
CheckAllWarning               PASS      34.43 seconds
CheckSparse                   WARNING   37.06 seconds
BuildKernel32                 PASS      29.94 seconds
CheckKernelLLVM               PASS      35.93 seconds
TestRunnerSetup               PASS      724.13 seconds
TestRunner_l2cap-tester       PASS      12.96 seconds
TestRunner_iso-tester         PASS      12.83 seconds
TestRunner_bnep-tester        PASS      3.14 seconds
TestRunner_mgmt-tester        PASS      87.62 seconds
TestRunner_rfcomm-tester      PASS      5.62 seconds
TestRunner_sco-tester         PASS      5.64 seconds
TestRunner_ioctl-tester       PASS      4.67 seconds
TestRunner_mesh-tester        PASS      5.54 seconds
TestRunner_smp-tester         PASS      4.31 seconds
TestRunner_userchan-tester    PASS      3.17 seconds
TestRunner_6lowpan-tester     PASS      4.43 seconds
IncrementalBuild              PASS      28.85 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[bluetooth-next] Bluetooth: hci_event: strip Broadcom vendor bits from legacy adv report type

1: T1 Title exceeds max length (93>80): "[bluetooth-next] Bluetooth: hci_event: strip Broadcom vendor bits from legacy adv report type"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/946

---
Regards,
Linux Bluetooth


--===============1711747667515411309==--
