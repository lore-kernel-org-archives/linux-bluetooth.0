Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A72EF284
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587800; cv=none; b=JVttSLNlpseh4ewDEdjvcx0urYxuF/hwW5HvqRcpR9nIhD5mHW/jx+CsPS5ZkLrj/KLNMLgADrl5YEKWftYxdDd2+xVigCYEkNdAfri9hDxP/mwbHs3MH9hHmZ3xW0aJyW393iYkj1utTiFnH3MkltmpGBgDCCPLZ/Yk0BdZMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587800; c=relaxed/simple;
	bh=as95C0BrPEcFGTtmLp4iV7+pzI0PBWeXT2y/ZTR7lz4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TFFLZLwOkBa726aI76hLRvViSz/671aFvqwkhYipkKk3yjvUcPIJ0s1OONkanq6gugop6dmquyCHD6RA6nx0Fs6aWimFe1QtHJIJN1gkGQjTLZypy43hKbz6eRADz9zaxS0ocdTxiiB8x3quoRpOFFyFJViBW6A9YgSIFkup3MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6d7gotw; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6d7gotw"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3df2df6a25aso17788295ab.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752587798; x=1753192598; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2mlsaAefe9ARE/XipPeDeSXnuxx2jGJUCYD8ooJK7k=;
        b=d6d7gotwlhbZ3PZLu0OvvksVwV/LDuTApNgLujS/HyxbCk1lhiIzizoiMPeRJedP1W
         azA1larj3yRKVK8Ts9Sxg1kfIio+Br6AaudvZwr0LwseXOFiDcZ6aUSBbXZF4rt0J8zy
         M9etRearPpS1VYDHD4BFiorjTT73IyroCdDuRkVP9eaBn1pKFbcoGec+Z4wqQEzsB4jh
         2PrF255MFPNhBQ3U1x/twAtUBzJhutRisUhvVyG37b/ijm7OpwJL9wS33kJBkAU6VEDe
         sdAsu+yp10+SUjN0CHRxhy+1H2iWOG40U9NlQUzsQxpN4GeUCxxLBtWreCmbAnLb6GX2
         b8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752587798; x=1753192598;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2mlsaAefe9ARE/XipPeDeSXnuxx2jGJUCYD8ooJK7k=;
        b=uaMe0u3id9mqm+5aPzECLT8DNzIlSaw3cAY2N45yBkxWuNVlKn8vM51sb4tNBtIRAt
         7txXyfsVHdDkKPzJTCTj5V56Crel06vnYS2BE0M+hqU2ClrR0vH0WZMeE7BbR6aot/6P
         3Q5+/0lbYUEncTny26Ea+rWDuymY6hLcnhF/HJqK0kMbdwc1t1EMwhgu0LeLlWe6g/Ud
         Nq7EzLGPMKH73EXAKdFppsg/imV0WWnJUthh2CQCj5BshoJ1Ba28jdUNwFZFSJMy1BEa
         L7chR5cTuIQMEyWfertjptBZwh1/SaUcYxNYIH+ZJJtnQoHGL258c3x8yLr0b8vtS1oW
         cHyg==
X-Gm-Message-State: AOJu0YyHKR/ghOVo4hh4sZS4OHpDKs9nmb6bcmBZC1RFnLuciLVvebyo
	Qq9NXYa+2uS0VX2OIM3Tmrt9B98jTl5l4PWg3m/AmG3wyPaNx11weG8J6DkjOZ9Z
X-Gm-Gg: ASbGncuVrst8QiXaQCcIB1lGkW1Ta7isDhSiOm1jdmdP8WvOEj9r+FzaQnF52QyLNpj
	hJhvN6jR70CknnMtJnoDNxW+00BGCNbfCyvEsqDwgHpcGbHb/FJUA5xfwmxAEkIbCLXkixeZwyY
	QCifkullqQOLGqM3JLi44oLaEhz1RDKU2jvp+WjaUJrL6Ok3xkEYLfk7VHT9qrNgta27uKrz983
	3KHp7+UmaOyxtDtv1+yeHB0pgU4fm6KdhzVkMyPqYGMhKWVEMPgPmDYpqbITwI3Oyioo2tSlcFj
	veSCJnokywok5h2qPy6ToDTtqvezpFkJxFV1Zq35cOz08y3/X5WTM7TgBiMDqTtG2LeitUqFU1C
	cn4wBKGeH6UQyF8T9mSSR+xvNZ1xv
X-Google-Smtp-Source: AGHT+IFIK5Rxc1O3ePjFPaKd5npf2lYGVnpZmpDpVEFvwTDu+GkQQFVtqgOwQAW5sYPmbSXC2dzwVA==
X-Received: by 2002:a05:6e02:3783:b0:3df:3926:88b7 with SMTP id e9e14a558f8ab-3e25327322cmr177367745ab.5.1752587797997;
        Tue, 15 Jul 2025 06:56:37 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.162.33])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556970e13sm2590864173.82.2025.07.15.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:56:36 -0700 (PDT)
Message-ID: <68765e14.050a0220.5a516.390d@mx.google.com>
Date: Tue, 15 Jul 2025 06:56:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3164460377840881121=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun_hu@icloud.com
Subject: RE: Bluetooth: btusb: QCA: Fix bug and support downloading custom firmwares
In-Reply-To: <20250715-bt_quec-v1-1-c519cf7a0e16@oss.qualcomm.com>
References: <20250715-bt_quec-v1-1-c519cf7a0e16@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3164460377840881121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=982516

---Test result---

Test Summary:
CheckPatch                    PENDING   0.51 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      23.80 seconds
CheckAllWarning               PASS      26.38 seconds
CheckSparse                   PASS      29.69 seconds
BuildKernel32                 PASS      23.97 seconds
TestRunnerSetup               PASS      466.76 seconds
TestRunner_l2cap-tester       PASS      24.68 seconds
TestRunner_iso-tester         PASS      37.74 seconds
TestRunner_bnep-tester        PASS      5.84 seconds
TestRunner_mgmt-tester        FAIL      132.09 seconds
TestRunner_rfcomm-tester      PASS      11.72 seconds
TestRunner_sco-tester         PASS      14.72 seconds
TestRunner_ioctl-tester       PASS      10.19 seconds
TestRunner_mesh-tester        FAIL      11.39 seconds
TestRunner_smp-tester         PASS      8.45 seconds
TestRunner_userchan-tester    PASS      6.13 seconds
IncrementalBuild              PENDING   0.56 seconds

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
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.192 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.176 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3164460377840881121==--
