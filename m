Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2340E1DA31F
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247079; cv=none; b=Vzy08hvI4c6hcyc3LKzwN7Dz/lbawi/KGXrjfuSskWj50ZuIeqoSLewldsGprQ2qdTkkW3drxLGKRlBqm0HAJy6JD2A3+eSj+7X98Ev6fDrmKzMCPkauSx8ffIfeD6ieQBoSmzP/ezj23aLhVo+6yPp2lgnGevCntdfptyZ1IXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247079; c=relaxed/simple;
	bh=UTalk9pgovQ1KWtNMQTL8GTZoxhOqIAy8SraSZHBQVk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AZs5sRh05BeX0eEWuJGienj+KVGTZ+QdffESGrLqVRzSdT8O6T8Tf6p+7rFj2/99+l9lTIKMmzpYZClr6wfx66/Qf/hsEhPK2rkiSgu6hfI9OYEfSxEidEoXPo+4hjsGSmIP0AjF/yJBKH0E7ARhItUP+Bv58HTCX1+pEQMwcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0XHvVqm; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0XHvVqm"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c3c4ff7d31so626717085a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 14:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742247077; x=1742851877; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QdzOCOYQNPCmGpnpWkkCFvzoF/OchnySlOieph+V3CM=;
        b=M0XHvVqmXFpbyYvE5ZVFEgPIDcsv6HoMaX50vqV/rl45D0A/cvX/kaHPYpswROg27u
         AvoqPgzrHNZeblxhTlUxykypy42jSU93r7GnX7t5BYNWuPU0jw2nUd1TdVr7zeBZXWk5
         0aCAxZWEc3JxuUC6ZnOqDnCc68EOFD08kHMeLbtGVHcB8bphAiONVersq69el6Z6pZWP
         gubVJeBG6dmP0JGh+NQavQWTN40PoCteqz3MQkcfxi4f9Yw9XDJLWlRRjaP/e9+R33G5
         joUY4Alhv7xCOnXsEZWnr725e84fYYsH7SNRFG+OInrYhkCNF2nNjm8nEu7+SicTv61l
         t6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742247077; x=1742851877;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdzOCOYQNPCmGpnpWkkCFvzoF/OchnySlOieph+V3CM=;
        b=CgFL1bmps/2qy0nNy6P5nk2Tqv1Z0JJ3QzBXEgdSX5OVo0jk+HCR/dceYZ9i3KWhG3
         XGfxAQ4x29AezY2hQpQ62IldYUV7S8im9GVHTHdspJe365KQJsRULsKc9c+D+VOFcmst
         nPZOXppihy1DlMqPfUooDyzDUXjEs22oKK92sJwX2mS9bN7XQME/I73ZUQPez/NReb8K
         pE2jMnOajJr/VTv3WNcdIRnXP+nit51t264UyL1AJVh7tjBixy7JBugflAc51VsDsCBv
         UOl+ocM/q9GA+gqstkMIAJjgYwu8i+xIV7TpC5x8naexEEZ8r9m4EZ0cK7SMvMarlO0o
         MAVQ==
X-Gm-Message-State: AOJu0Yzq6oGB1Hlxgf443xU/msuBTy9efnyr4uSeNNu+kVwfYm4or4Ny
	tp9zfOYXQ11f7/9kuiw7S0u2OBewwMtRodUnRc1wVFlqBwMZ2+EL+ys31w==
X-Gm-Gg: ASbGnct2oNy71kJ30ing1Y6vAuFZyf2Nris9qarFIbogItzJkZ30ATooRoC0/ThWzE0
	Ic0sdTxqZ6G0faMtExLHja2S1pVBPU7z7J9RcmsHpuWqsJFEuGIS4Gs/RqD7rNhlAGcc527gk7Z
	8DVsNq/LKs+gTgL/IWCWinu1qTIL5t3zI81qL2OMFMgNf5yZMe5yD5x7PbshZuYBHvcMhRb3/QO
	TURrvIP9Kpa/PvqxteAqB0fyy8Iz+cmcAwScE3ACxopYQ7KxS2gMwxydnoGNvc4aZ6Kl7OLB2wD
	AAnlignL0C2TCGpUNLsK/mz9zcgMbU7MgkZfa+KK/iQ0pVuqshLRQA==
X-Google-Smtp-Source: AGHT+IEayzojxQ8tpyuviCx8hANYTww608gtwarg0Op8DK65CvFi296mSVZhy/ftpEqclR/koojbsg==
X-Received: by 2002:a05:620a:199d:b0:7c5:61fc:d325 with SMTP id af79cd13be357-7c57c810e66mr1850550285a.31.1742247076750;
        Mon, 17 Mar 2025 14:31:16 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.199.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4e60esm637010485a.6.2025.03.17.14.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 14:31:16 -0700 (PDT)
Message-ID: <67d894a4.050a0220.297e03.6b4c@mx.google.com>
Date: Mon, 17 Mar 2025 14:31:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9108295722229233906=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] HCI: coredump: Log devcd dumps into the monitor
In-Reply-To: <20250317203841.598380-1-luiz.dentz@gmail.com>
References: <20250317203841.598380-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9108295722229233906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=944837

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 FAIL      0.30 seconds
BuildKernel                   PASS      24.63 seconds
CheckAllWarning               PASS      26.88 seconds
CheckSparse                   PASS      30.43 seconds
BuildKernel32                 PASS      24.27 seconds
TestRunnerSetup               PASS      432.91 seconds
TestRunner_l2cap-tester       PASS      21.16 seconds
TestRunner_iso-tester         PASS      33.30 seconds
TestRunner_bnep-tester        PASS      4.93 seconds
TestRunner_mgmt-tester        FAIL      124.54 seconds
TestRunner_rfcomm-tester      PASS      8.06 seconds
TestRunner_sco-tester         PASS      12.32 seconds
TestRunner_ioctl-tester       PASS      8.66 seconds
TestRunner_mesh-tester        PASS      6.08 seconds
TestRunner_smp-tester         PASS      7.52 seconds
TestRunner_userchan-tester    PASS      5.14 seconds
IncrementalBuild              PENDING   0.82 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.149 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.158 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9108295722229233906==--
