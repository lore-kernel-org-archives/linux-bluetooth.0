Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B60218635
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866132; cv=none; b=lpAnciBGBacYwATTdzZvCzp4h7Y1jFxXa0K+k+qxt2RhFMTPkRiFSHQrZtKB3TItXZ4P29ywRZ/YUvi9mb+WVj9Mo+GWZ1llPFtlvivCSdmA2BD2xA/3y1ejYf8XC841sbrEGqlxGhjOLF3uZ+prWkSgv5IdKQ2c5job7/n5n0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866132; c=relaxed/simple;
	bh=tPCjB4cDGdCHN1Tj5GbdtHZP7ugUPbuYiH1tmBzAKqo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UuISfZcsZzTlEM0u0LCHgtagy6/Sk8Y+TZv3yqLLc6L8SEJxpeHUwJR+Spnp71eGBX7s3dpq4e5fxGwmrzNEQcm0OcwmkM5IwydVfWRBfYCmByenGP59nrV8UG0WK/5zuhoRIdsi07D4VSx0RRqiJs5CatPpMK72LhXrjcxXI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7ijonzr; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7ijonzr"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-64b417e1511so30897087b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2024 13:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719866130; x=1720470930; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DZhBEMKipQne3yZ++OmQr9A2Sugs6pbLRD0hVWhCClQ=;
        b=G7ijonzrZHU0+tZwO7Y+FHYzrvNgoZEHMHOCH4T2zEsmfECCwYvN03T2fLo1OMjnXN
         xab/m4LBu40HBTOImwQiVB3Za1wmY07TB0TWltqC8Dnf7OdTqav88ZlC56CVs3WhBtj7
         pgyF1b+3Zkd4/qovzbTtqzrZJUGtjdUiGA1J9Y2cPC7nwoz+hFfNwvJVKILf9Kn2FYa+
         kmyYO8dTfU/F+PQEcUzkualBOOB9sEPoYwCKsMjK2+Yd8O4pYfgT7o1Fzotx+pGhKJ8L
         uWhHdEIeGTsPi6A0UHpAlp9zQfk4oFxGIVQkXsCI/dL+7jESy1VIxAS5hZzEE9Slb3Wk
         x74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719866130; x=1720470930;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZhBEMKipQne3yZ++OmQr9A2Sugs6pbLRD0hVWhCClQ=;
        b=avjcEORagOmSQEb2JQ9hMGUEpo4ytb+bYjZb5N1AiPF2yJL9PnrbWgYjr9IZ2zBokw
         l/zFh35lLV34vq7zsqCVxSer4WUD9XF4++3UNtM1rzJcpuDSzjKMrGPIIET0zzBaO0ot
         i3WRq2/KzM/sy6evZeDi4N80/LsIQTWI4TCaJw6rC6r2tru9039dL3GDFCEZjFL7Bcrj
         FAkSEchor6bxzlqenlhKa7sbvZ0PwiiTAAk49iM4j4dBAESpxXnJf2bMT/58F8FpMVtY
         M/UYzpZQAak4Lcjip/+YxJ6GjaTEn17sVhok+Weq4tl3T6/unqEtOGeDEthHe3872aua
         6KkA==
X-Gm-Message-State: AOJu0YySQrNAs+Og3fgesdwdMBr13etZeaWkZQHRgpyyMpBIaZvjlD7S
	mqrcXreSvS6gn/NkLWL2w18+ZWVDbQ3gPqoXGmr/YDiPQiSAS6lOLV9u0g==
X-Google-Smtp-Source: AGHT+IHdYViLG7ht8RBJmjMwUFrGOKx7wEql0EFrQ8L4xYjyBoNHXgp+88OSL2DYXVcClgeB36qEkg==
X-Received: by 2002:a0d:e612:0:b0:64a:3d7c:2782 with SMTP id 00721157ae682-64c73606e65mr71589827b3.41.1719866129028;
        Mon, 01 Jul 2024 13:35:29 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.255])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9c4068c4sm15154967b3.134.2024.07.01.13.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:35:28 -0700 (PDT)
Message-ID: <66831310.050a0220.6e5ba.9913@mx.google.com>
Date: Mon, 01 Jul 2024 13:35:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0144358385465531487=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yskelg@gmail.com
Subject: RE: hci: fix double free in hci_req_sync
In-Reply-To: <20240701194531.97576-2-yskelg@gmail.com>
References: <20240701194531.97576-2-yskelg@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0144358385465531487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867274

---Test result---

Test Summary:
CheckPatch                    FAIL      1.82 seconds
GitLint                       FAIL      0.49 seconds
SubjectPrefix                 FAIL      0.31 seconds
BuildKernel                   PASS      30.54 seconds
CheckAllWarning               PASS      45.30 seconds
CheckSparse                   PASS      38.87 seconds
CheckSmatch                   PASS      107.07 seconds
BuildKernel32                 PASS      29.74 seconds
TestRunnerSetup               PASS      530.55 seconds
TestRunner_l2cap-tester       PASS      24.05 seconds
TestRunner_iso-tester         PASS      37.17 seconds
TestRunner_bnep-tester        PASS      4.93 seconds
TestRunner_mgmt-tester        FAIL      110.24 seconds
TestRunner_rfcomm-tester      PASS      7.56 seconds
TestRunner_sco-tester         PASS      15.26 seconds
TestRunner_ioctl-tester       PASS      8.16 seconds
TestRunner_mesh-tester        PASS      6.21 seconds
TestRunner_smp-tester         PASS      7.00 seconds
TestRunner_userchan-tester    PASS      10.04 seconds
IncrementalBuild              PASS      28.81 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
hci: fix double free in hci_req_sync
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#129: 
6.10.0-rc4-00217-g35bb670d65fc-dirty #22 Hardware name: linux,dummy-virt (DT)

CHECK: Macro argument reuse 'hdev' - possible side-effects?
#304: FILE: net/bluetooth/hci_request.h:31:
+#define hci_req_skb_release_and_set(hdev, val)		\
+({							\
+	if (hdev->req_skb) {				\
+		spin_lock(&hdev->req_skb_lock);		\
+		kfree_skb(hdev->req_skb);		\
+		hdev->req_skb = val;			\
+		spin_unlock(&hdev->req_skb_lock);	\
+	}						\
+})

CHECK: Macro argument 'hdev' may be better as '(hdev)' to avoid precedence issues
#304: FILE: net/bluetooth/hci_request.h:31:
+#define hci_req_skb_release_and_set(hdev, val)		\
+({							\
+	if (hdev->req_skb) {				\
+		spin_lock(&hdev->req_skb_lock);		\
+		kfree_skb(hdev->req_skb);		\
+		hdev->req_skb = val;			\
+		spin_unlock(&hdev->req_skb_lock);	\
+	}						\
+})

total: 0 errors, 1 warnings, 2 checks, 78 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13718597.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
hci: fix double free in hci_req_sync

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
31: B1 Line exceeds max length (103>80): "BUG: KASAN: slab-use-after-free in skb_release_data+0x7d8/0x8a0 home/paran/linux/net/core/skbuff.c:1119"
44: B1 Line exceeds max length (86>80): " __asan_report_store1_noabort+0x44/0x60 home/paran/linux/mm/kasan/report_generic.c:383"
61: B1 Line exceeds max length (88>80): " el0_svc_common.constprop.0+0x2d4/0x3e8 home/paran/linux/arch/arm64/kernel/syscall.c:133"
64: B1 Line exceeds max length (87>80): " el0t_64_sync_handler+0x120/0x130 home/paran/linux/arch/arm64/kernel/entry-common.c:730"
139: B2 Line has trailing whitespace: "Since applying our patch, we have repeatedly run the same tests in "
142: B1 Line exceeds max length (122>80): "Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=89a32741f4217856066c198a4a7267bcdd1edd67"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.163 seconds


---
Regards,
Linux Bluetooth


--===============0144358385465531487==--
