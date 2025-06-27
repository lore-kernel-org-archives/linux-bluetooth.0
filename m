Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0214EC73
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040101; cv=none; b=tg/TrUSjyMGpqkBMiKbSBcIaZEv8xRhScESDB9d1QdmdcvS1r/qqZhrT5pwuUFy8tiFq4rKtlQDS/zHVjWjxm5oBC36//IpaCZMVMRwA/WP/YMF4XqgBK2uAwSGfx/lLtUwlZjfaI0ZyTas8kNIuT3xZWrSUbL5Hcm9Dl0HfL4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040101; c=relaxed/simple;
	bh=mqpFNn7mdyPqi2yTM2CTvfW6I2iOvs/AndjAPDS9N0w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=d6d89Fuv8Jw9uOk/5hCSWmo9iwdobRg9De0ClhJHEkDsxdg+H1gKTTx9znmXPpjj0F/SS7fdzyOAwVQDltzk6bBp1ItFOeJ7oAk/9VV5CvfJhJxBjIt5r4O5Dnf2HYXOUheJICaTk9lGNChuPoqm/SMiEEaxsNOIGQ/2s2DHdzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kj+EUVq3; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kj+EUVq3"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72c14138668so609368a34.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751040099; x=1751644899; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=599qTOHKc6J+0J5FiB68OzqREPEphI7B3xmv09MJ40Q=;
        b=kj+EUVq3sZvkHeEGNM3xxm4dInRr7IB6aOcC3nwS6ZvKuRYBv4PLhusQpv12IBZC10
         ntiRrheOOYHHMr3Z6TCbftoah9VdoEiBtX9vZkaMmyXr0Dpb3mwr/WVy8Jmfjf6rHXgr
         GTp9R6cRb7yqR1NrSHMacO9uw6SUjgJ+OVlTUOrJO7FWVWTJaua/6ZCom8HWifBMo1/6
         MUGu1MjtHUU0pzQF7DZlUKVrXJJw2AzGgiZXFgYz5ahA0QS6iwn4sdAjTYzHZt9bJJ2H
         1tfU+MmGR70GgKoE9MsXXdj5lC2MefFbLoF18hvqSPUFqejowyYxG2M5KHw1iqwZOIhb
         mdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751040099; x=1751644899;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=599qTOHKc6J+0J5FiB68OzqREPEphI7B3xmv09MJ40Q=;
        b=cmFMt4O4IRmyM4wIr9aDenFJq8ya13pjnbwKxwnVq70I6TbkZK6dreeiCXg40Yg6IE
         eZ5Taa5+ASTHRrYEUnAoaMcTpT5BuVy9fmNgBTbwy96zBYv+OR/gcidszTtS2qnD7LMX
         tgqCi4Jht+WutzN5Saeu6k3MScgCQSbW2bbgx0wd75xP89JBvo6iH2THGHXRUZzN0MQG
         IiBxF3bpgkTKDgUzGx77aEyBopwK8KQ/DJxnmbUAvMzCBTQL3gjhvwTtHEJWHHZZS2qy
         z+xC/778jQ2cJ0pJ6vZIC/8nc27N6Zcjp33I4xdtmxQugE2hPkqPGkaClCb9NOorZhTm
         XhYg==
X-Gm-Message-State: AOJu0YwFcIzzf28uMh4l0geIUKIcyN+XqJCdQRPKbLxEcDhg9wRAV5XZ
	fXK1rFCeHivU5+XW44qL7cJqK3VPkKSZXQCMfacv41+fYnAAeDWhZhW4F7WPag==
X-Gm-Gg: ASbGncuIJJLb5RCqJVPtouTXDzqFD68GYwwOHOES5v5egfsbuAuPRsCJwiR91Masvdl
	xJPguWdofHCmQ/prinTv/xHmhV9ZesNrnYj6oAGmGioHJmgTQ/F3YzBM918+sYVGABNTKw2059D
	rUtGtMjPxSUP+Tm2ZkJ9eNVbWQqRFJzzt+6mT6ffhin4exNexF0TJ1eLgUPw8iuq1yKMDaCv5pc
	dP5bj786KiUw9+zmxM1ML2KV8PbSDPy6lWdbvhRCpSrEdCwCdKWzQ5lntD+ESIxUd2ZWnUjTEGL
	loxvHWD7LhSNkEKJOGro96owZD/HKBuXpzazSAAgr3Wk2GXASQkHC0rsQpRzCujxnJTDsrFg4EP
	M7/Y=
X-Google-Smtp-Source: AGHT+IEgfkbtBTt2VvonQG8iBZp0fp8kKLKaYSZdLDjsYTzG21iL91hVA9tJQGHPvh9zzyTztDesoA==
X-Received: by 2002:a05:6830:9c9:b0:739:fcb4:db1e with SMTP id 46e09a7af769-73afc6602eamr2672204a34.20.1751040098497;
        Fri, 27 Jun 2025 09:01:38 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.54.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7730aa6bsm22547696d6.104.2025.06.27.09.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 09:01:38 -0700 (PDT)
Message-ID: <685ec062.050a0220.1e5af3.7fe9@mx.google.com>
Date: Fri, 27 Jun 2025 09:01:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3681700059860334037=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/3] Bluetooth: ISO: Don't initiate CIS connections if there are no buffers
In-Reply-To: <20250627151831.421443-1-luiz.dentz@gmail.com>
References: <20250627151831.421443-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3681700059860334037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=976702

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      24.63 seconds
CheckAllWarning               PASS      26.92 seconds
CheckSparse                   WARNING   30.61 seconds
BuildKernel32                 PASS      23.99 seconds
TestRunnerSetup               PASS      469.26 seconds
TestRunner_l2cap-tester       PASS      25.13 seconds
TestRunner_iso-tester         PASS      35.95 seconds
TestRunner_bnep-tester        PASS      5.89 seconds
TestRunner_mgmt-tester        FAIL      128.31 seconds
TestRunner_rfcomm-tester      PASS      9.20 seconds
TestRunner_sco-tester         PASS      14.58 seconds
TestRunner_ioctl-tester       PASS      9.92 seconds
TestRunner_mesh-tester        FAIL      11.55 seconds
TestRunner_smp-tester         PASS      8.46 seconds
TestRunner_userchan-tester    PASS      6.08 seconds
IncrementalBuild              PENDING   1.01 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.188 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.167 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.149 seconds
Mesh - Send cancel - 2                               Timed out    2.002 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3681700059860334037==--
