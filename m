Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD062C0F69
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910652; cv=none; b=OP7l++Dvw/lpcQAhJhrmkE2n5MQceyojj2sLYcYWk0MqeD4j+EbTy/6Dar+5WSs/i2Jjn+K6kbYDal1AUIlDSV/JWdkYfyOk35d4q6k18+0nkk7emWtASE5WT2gUYofMqWV1YHW1zVI+Fwkg2N0HLAInTF4u1GUaRCs1PsD+NmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910652; c=relaxed/simple;
	bh=GM4bsRtqf5aCmBlI1iLPg/mzYKhmwvoNJr9D3+ZE0FU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WEsCzsQDkYNjuyP10uRAt+d8v96BzWxJUMSLfRdFtpqfavBRRfmTZ7Zy4ppnbktQajMi8Nv5pq0Ld73Rc6IKz50SxXm/WisiJbOObTco68tB23hF4+We9nq7czpYl1V5SFPra5DR+MgCWP6fRkndPb5wMIYqvutqbUd7RGQ5ozM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxQVVhRa; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxQVVhRa"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c0e3a2605fso1386891eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 01:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773910650; x=1774515450; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FbErwgI4z0BowNgCB26IAV1hFN+VhxW9Qr2NJHpBWpY=;
        b=AxQVVhRaXXf99UdxLJep1Cgh56s+9D8hFAffEL5rXpWmLzzzNK3h+MJxt4+F+18ama
         IIijHYVIOL22R0Wq17eR+tReVGBn0H4SnUNGmP6uInnUgM5DSx+5bq8I7WD+qiqYH4Nt
         yG+Y2kmv2owHR8hCSQ8iwobJoSYaHnhiVf2wzocXEobg2DL5a39bTauzw4otYFJHEwLc
         om2foj9tRahsP3YNBS4kcemYqusCVkXQsS51rSrSVG1CEPFziEtzeEk1iHTAaNUqRHqW
         W/iAWxU2afcdEsKgKub4Hsr5xs0x9CoNXkw9mSuiNdbii5iXxvv6H+lGT+ZG75tFtfUb
         pO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773910650; x=1774515450;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbErwgI4z0BowNgCB26IAV1hFN+VhxW9Qr2NJHpBWpY=;
        b=fCyUgSmpIFW0PrC2ZdEGERB1YmpjxI0aoJMYSuFNlm7SPjlozAJj42fN6c9pbIEl2y
         JrLlYm0Qe4NQxgNTx3vv8Adu/T4shxMcAhSrSuZb8eDpLWMpK4OklESevjP2wOv2GMkT
         ncWQKszKhxBV7ZctH28ZnhAdYrdTVLHlWBosWop0ptxwfK9E6j0OGzn0725TQ9nDWRu1
         CydePW1jGkOtuneUMBLBE1nVhGmQsUqp0105OzwvxvHjVhE2wziE0hKPTA7LhhSfYYBz
         3LzB1UM7umaaJd4ec9TRm0YFO6koXplAgKBjRKUdrOqb6A+14uu2ks9C2PflnHLFofCe
         qAFg==
X-Gm-Message-State: AOJu0YwpU/8BC60OCf9firepKPhvNdVKetJgJAzLRks0m7RQlhU7Xgmq
	IdRuOl2mMfXb/OX3kPHtzG361kzgCO39jz0oxAiYEkvFnvCPu23QC2jHvgLZIg==
X-Gm-Gg: ATEYQzydTAuiTDQ/iXXfbJyLB6TORkTjxdN3SUhp2e3hiexuCmTtTZ/PwE5HdL1/m2j
	Rkwl+QlfIeH0PxPmcGbzlA7UY9cZjqn3OeQkWpXMf9nKM6eGfy2V2Va7wimZ9HdT7hyb2QpUT64
	EzWk6CzJzVDY4pePv/ljGz6K9iXl/BGWNG5qyfpWyfzmbU+BJ3o4Amfn84uErJyL9U8wlcSPZxv
	uXyIMAUvY7BAAPHRqwtM42Mj/Dim8vLXlj+O783ZrJCGDVWS7U8zUIwloepu+1e68AXtZpTT3jp
	Y5dx5fuRD5xf1aTzXP9jQ3XXT4tODA0wiIKkcwtExoYlYgWGyxmjiVsjMFSz1l4Z8AsZMMMNg7e
	XBfnI/tI8+Oq+cIBonNbuLzvXpSTWbdlKsYihyfjTEUfArTWBfrWLqB5jncXJbUoS1wNUWscgmz
	JHBgrexIEwITl7lcXpFIXVCFd/dfiuLq8=
X-Received: by 2002:a05:7301:2e89:b0:2be:e4b:60a8 with SMTP id 5a478bee46e88-2c0e4febe92mr3251250eec.7.1773910650318;
        Thu, 19 Mar 2026 01:57:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.213.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e53e616csm7314250eec.13.2026.03.19.01.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 01:57:29 -0700 (PDT)
Message-ID: <69bbba79.050a0220.228f92.6f84@mx.google.com>
Date: Thu, 19 Mar 2026 01:57:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9210465693602047056=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v2] Bluetooth: hci_qca: disable power control for WCN7850 when bt_en is not defined
In-Reply-To: <20260319075125.76539-1-shuai.zhang@oss.qualcomm.com>
References: <20260319075125.76539-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9210465693602047056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069097

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.40 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      26.19 seconds
CheckAllWarning               PASS      29.21 seconds
CheckSparse                   PASS      27.99 seconds
BuildKernel32                 PASS      25.50 seconds
TestRunnerSetup               PASS      564.88 seconds
TestRunner_l2cap-tester       PASS      27.60 seconds
TestRunner_iso-tester         FAIL      30.90 seconds
TestRunner_bnep-tester        PASS      6.23 seconds
TestRunner_mgmt-tester        FAIL      116.15 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         FAIL      14.37 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        FAIL      11.51 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      6.71 seconds
IncrementalBuild              PENDING   1.11 seconds

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
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.112 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.825 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9210465693602047056==--
