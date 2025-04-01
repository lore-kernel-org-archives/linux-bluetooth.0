Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418F13C9C4
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743517999; cv=none; b=m+PrJmaqI0693krAhnX6gmL2W/vJyyxw65lTXvLFxEw0LI7Re0OrqHSBMStt5mVZhhGgiFoO/HTVtF1Mvwivcju83rQSrIIKrFZM99k9oXTu4uqyxqReZj8fx7Z9u3gRUiziklqDDs07yKrrmVvJ9XMQu7vHAkx42RBz5IfyPjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743517999; c=relaxed/simple;
	bh=vioy/zrdU4m8K50YO28Y/iC/sGwdITZpco4gqrRVDaw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=izkKD3POPIQFiPwMUfGML2PYUcjsQ+szZBjyaRIKkAxRhxd8odgbn6Bq40TvHAFRLkr5yD7hxHgdvoQRYDctY0LeNUAGl94/8Y/WLR3y5lpjTdd6a/c6nJqpED3USlCu2gMwAy2LWDpqRtoKQVFSboCPIeKZA0sWVdYG6YJ4l5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e92/QC8E; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e92/QC8E"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c5e39d1e0eso533585085a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Apr 2025 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743517994; x=1744122794; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/fzUxT4riUuhoKbFSK73vyFLD/3Xc3jGVHTN/1i6aeI=;
        b=e92/QC8EKMr4PtHPGdE3HRoxNMDnAyY0UxRLOjClqK+xkOsMztw+veNU5idd3zFIoj
         I1s0kAObKFFJ4Yaz6cX43vJCbF/RGIbiNPS2Ci+Jb5NAo4R6L5bP11mRL5Z4GmYslyv9
         4ER65nuKB73NaU69NskBb2OUkA5FqhJbw6zdJ9vxS2lvDIKmKgPpvF5RlRLQ56+fBpEO
         +0W867c6hnY/rE9HPd+KsZlrhSIEjqcgD4MNRTXpSVti+lnxXax80UrIk7GiKpdNTzS/
         z4cwKzjGpAOMv10UjIdO5Pu+bHksTaAJWxwYo5Yol2BnNAUExi66qisfm+OPK4RTKtD2
         tqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743517994; x=1744122794;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fzUxT4riUuhoKbFSK73vyFLD/3Xc3jGVHTN/1i6aeI=;
        b=pp9/WW82vtY9ljvL6muLdLzFrpH6YYohmOZpXGzMaaeebAd7/qfwVyq1RVDzPb5FyO
         e0j6fngDA/5TzKLXbM507YFDNSiTNG/s7f4bKkj+Yo2w6pJ9O/0nHyAhP1LOYjThAreJ
         AIozBT1bZl8qJ9DVmrkdBjf4SY0oNHvdcGVeknAX6ADI82oiB2+iSA09mNnRPH7cKTYU
         gpD7z+WHQ4hKQvRmEtWRfaRVsCZsIqG62W9/rVqwgHreuC7x3lK8P0FdJ6zyaPAUrPgj
         edqq26nQuJnD1RtPcZw/QXyQOapGbXNVvTOwEL3gZBtyYaNeYH5cwbJclw9BSpLWRNz+
         XOqQ==
X-Gm-Message-State: AOJu0Yz457HHrBb8hzeRkdeq2EaZwYNh3gT5LNDce0SUTlwDDhwwc8FF
	TqWMmP15Lkl8IHBoe1ALB3kD1ZtoqklnkTLhGOnXH0rhk1CBrtUBL2qsTg==
X-Gm-Gg: ASbGnctsjAPVCEmPt8ianPgCqMn8QGobYZ+M+vWT+PGJikC4Ftv9obxtktOKXThmDY/
	RdN/jedOxhrluWacK/FZUuUx9+Hy1DRO3cUxuksFuax+K1dVQFyxR6WqIbPwLHP+7EDJLE4Pe5C
	VjAlcgEv1TV0XnWeYHIdMKm0IeZAbO2mhna1IVTRzy3Zf3lpKL9uOWDpIMxSfShokF+LCt0xv20
	uyU+AYe8O2JZvPSxcCNamVJKWW+glCy/ImGZY12Mp1xovU+1MrtI8iPh4xE0NiZdqO6Z1eDvqoo
	qNYhpNtxmYWIJgLhxTp2rWJQAMgGa1t9FL8vS0qNppHBS9J7qWQ=
X-Google-Smtp-Source: AGHT+IE6UO20pQ3cTsOk7cOQHeUTc0kRSNFp+L3YJY4EXm/CgB2x7UgB4PQsK2jSBiV5b+0Sz2//lA==
X-Received: by 2002:a05:620a:2953:b0:7c5:af76:c827 with SMTP id af79cd13be357-7c69072edc7mr1864390885a.30.1743517994540;
        Tue, 01 Apr 2025 07:33:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f76ac916sm661941485a.65.2025.04.01.07.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 07:33:14 -0700 (PDT)
Message-ID: <67ebf92a.050a0220.19b15e.730f@mx.google.com>
Date: Tue, 01 Apr 2025 07:33:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8544438026952006440=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: Bluetooth: Add driver command BTUSB_DRV_CMD_SWITCH_ALT_SETTING
In-Reply-To: <20250401134424.3725875-1-chharry@google.com>
References: <20250401134424.3725875-1-chharry@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8544438026952006440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=948951

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.01 seconds
CheckAllWarning               PASS      26.43 seconds
CheckSparse                   PASS      30.05 seconds
BuildKernel32                 PASS      24.08 seconds
TestRunnerSetup               PASS      428.46 seconds
TestRunner_l2cap-tester       FAIL      44.90 seconds
TestRunner_iso-tester         PASS      34.68 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        FAIL      119.51 seconds
TestRunner_rfcomm-tester      PASS      7.76 seconds
TestRunner_sco-tester         PASS      12.47 seconds
TestRunner_ioctl-tester       PASS      12.65 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      7.09 seconds
TestRunner_userchan-tester    PASS      4.93 seconds
IncrementalBuild              PENDING   0.50 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 62, Passed: 61 (98.4%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP LE Client - Close socket 2                     Timed out   23.647 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.154 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8544438026952006440==--
