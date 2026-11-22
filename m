Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795368790;
	b=c6q8XeYV1nDV6rpJVDw2cY4SpM3kVcdDZA/URsWn2aNr18bybslUWD9h10KXspjTHRMC
	 vVbS/Da9ZU5MtBTWHxFl9KpKke2uNcxm6GCnO6SXNylF0b+nkaXTY/4ML8tVOgLDOKbaG
	 hNb3Iy8rEOJLEMHbgGx3q68nsFBTqXswtMeuBGpChxuzEmUOf9FigOQZ83qLlM940hocm
	 n4DB7enook1lBCU5IdPU3x44SjuMNzqNbrduo28w54xzKB6Sg8WVWVfb4WIiiCbe/xuP4
	 Ec610staTmbOK1bxwORnA2cdWneeBzDxSqluzfqUbpBN9iwAUwzjaFK1DaGTRddLYgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795368790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Lh90hScJ1sDssPAsqd8mCNkFczXDB9NBcrOBFKLPqQI=;
	b=RYXCtEWvEGCE3m+TN+K4ZTbn1rzGNLxO5zYKZpiXDGCMXqQLSXNiN1K63t9bkRZNwdTV
	 RGEejvMUTECfpYLE5KBbBZ5NQary1r8ywnAYy73JTwzhQdEnaJNap/AkISYB2ywFXOEZU
	 hVbXr7X7XQLl2ve0JTJcZrSN/lvFBKheNZpE6NxCPBEL8EB7+yF0s3G4IQolMgygXsjXC
	 b3jtPDp9DwtQ/ww8DV2OEiQ2jkk7FYngMQUrSIpnyYd8tNKlL3NByaWS/Dl04kkYja+W6
	 EEtPLl2A6vpDJnQSHiGD+zfoNVHmEvM2hTYqjw0KIa0sn3mb8AAIH55zW6NpQzAgbpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U1Yz4pTw;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C56606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 17:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74C56606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U1Yz4pTw
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9496400270fso253710085a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 09:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795368789; x=1795973589; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lh90hScJ1sDssPAsqd8mCNkFczXDB9NBcrOBFKLPqQI=;
        b=U1Yz4pTwcdVO3dbvPzLPBLCs0ENoX5MBlryQtEUDNBriGgPT56fnq0y31UnxzxTZwK
         YTaoaOCrFCYrPS67oKJgpOpOKmza3rwh+gVQE4ibWlPaOeIpFSPXzvVmobEg0RcEUuFF
         RDKQsUo0F755yGp1WG6xfPvobDTVC7Gy8WZINKOzKXEnD1Cw9z4pvRCB6rkoJl6gZxNk
         WjncNH/T+09LBJfJkXB1Bs/uGXivNOt4FOE63WEXMLFVKOWFgydfIOni8ScSc5A7Apxw
         Cl64gSRlY2aR7Lr8bQwVaow69ymivFukfFgfpJm0uYuKcf06r4Qq5Gu7h3Gk+RcgV1Td
         EuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795368789; x=1795973589;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Lh90hScJ1sDssPAsqd8mCNkFczXDB9NBcrOBFKLPqQI=;
        b=ggKOTkcPBHaIfLwLxoDnqzP9YFHwSNXJpYe0WHSP4efaYSK3Yuyt3gYh+z8qBh2ihJ
         CG/yJuFl5cAkr26bw0DLWRE3U+bxhV9ofUQ9hKDdV41SKMtXSkeZAJAnsYIDjGTYVY5h
         DYA7e+J2lKpcZgIWFnbI1qu3svS63kp0KaNcVn565+LkW/wN6urq+DZlhCnT7XJFHbor
         5aB0lpx5J/zMy/RXuT7OJrtBgwmmiNeiQ9l+WcRGGal/Qrix5xQoPJK02tiwZLOzu8RV
         QWEer7uMqFSj0BQCJPicRqyv9qs+jJJDbAMhwaMIqB/M98+OLYDsit1Uqg1l9iCa3t6F
         T+yQ==
X-Gm-Message-State: APuU4Z86Wc3lzCVGarlFK3/3qhn02sF3Ev3+9swPomOG0DZxsTPFtyQX
	QPqa4DnB4nKGSiLe3tK78rH3U+ktIxXYeaGEVjEfY8+qwXsko4YCcDgJlSddcf9g
X-Gm-Gg: AZFdTZckb5nCkqOtufeE05pJEuq7To/rugVeSepexjs7Ga0pMEN5a57W8o9yzdqyD7e
	YI/pt2aXyhjVQ18gQ6iXwM50V1TwMOgY9dxIodzZLoJaWIjgKSVhyZvDTb4oEyhmvw8HTyRI50U
	nFxIgEHxrQVz/cwqbEcYRNDmsxjsiZ0+dFLhcV3L8+lgQYDtYLTLzHSgM+uJQAIIER5GzqT9in9
	PTPGJk8p2jF2JOUDIkcha9hjLDWweWnY0m0MUxTjYpW+2fMtTiT4anqMSeng2/Rtx86SVuAaZPB
	vPevDhue7Ajpju8UGawvKNEsMmGQghhPF+wZMW9O1evzld0EmCKb15Gd+Ts5Ax9FtjkQpG1W06l
	HPWBR0KJWc1uAtzn4FoLweP7lWitFFoeN5TzGY8WWji3W8L7/9eJ+FnazHSM3iMZ76sRKOaLB5V
	U32izex6GdxwmFuXd2qCcHi7kJlg879of+NGLW3B8EQnZM+MZTeBdwaKO9SIMFd85h7U/Q/wXHR
	w+zOgs2uW0RETIQUnlMllIpVHxHULDOV9MohC+7Cca2eR2rdRZYhWqgz6MSzdJq
X-Received: by 2002:a05:620a:29ce:b0:949:8901:dcab with SMTP id af79cd13be357-949ba9b3de8mr1572373885a.23.1795368789377;
        Sun, 22 Nov 2026 09:33:09 -0800 (PST)
Received: from [172.17.0.2] ([52.188.86.147])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134bfe82dsm81798006d6.0.2026.11.22.09.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:33:09 -0800 (PST)
Message-ID: <6b032755.2a8138a3.4b484.735b@mx.google.com>
Date: Sun, 22 Nov 2026 09:33:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2217244447085333071=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: Bluetooth: hci_sync: Fix start/stop logic of default advertising
In-Reply-To: <20261122145428.1499940-1-simon.mikuda@streamunlimited.com>
References: <20261122145428.1499940-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2217244447085333071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218676/

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.87 seconds
CheckAllWarning               PASS      35.43 seconds
CheckSparse                   PASS      39.15 seconds
BuildKernel32                 PASS      32.38 seconds
CheckKernelLLVM               PASS      33.96 seconds
TestRunnerSetup               PASS      762.81 seconds
TestRunner_l2cap-tester       PASS      15.14 seconds
TestRunner_iso-tester         PASS      13.01 seconds
TestRunner_bnep-tester        PASS      3.19 seconds
TestRunner_mgmt-tester        FAIL      101.09 seconds
TestRunner_rfcomm-tester      PASS      4.55 seconds
TestRunner_sco-tester         PASS      5.66 seconds
TestRunner_ioctl-tester       PASS      4.72 seconds
TestRunner_mesh-tester        PASS      4.55 seconds
TestRunner_smp-tester         PASS      4.42 seconds
TestRunner_userchan-tester    PASS      3.29 seconds
TestRunner_6lowpan-tester     PASS      4.48 seconds
IncrementalBuild              PASS      29.18 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 529, Passed: 523 (98.9%), Failed: 6, Not Run: 0

Failed Test Cases
Add Advertising - Success 16 (Connectable -> on)     Timed out    2.008 seconds
Add Advertising - Success 17 (Connectable -> off)    Timed out    2.008 seconds
Add Ext Advertising - Success 16 (Connectable -> on) Timed out    2.007 seconds
Add Ext Advertising - Success 17 (Connectable -> off) Timed out    2.007 seconds
Add Ext Advertising - Success (1m Connectable -> on) Timed out    2.006 seconds
Add Ext Advertising - Success (1m Connectable -> off) Timed out    2.006 seconds


https://github.com/bluez/bluetooth-next/pull/1181

---
Regards,
Linux Bluetooth


--===============2217244447085333071==--
