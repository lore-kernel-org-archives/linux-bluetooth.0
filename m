Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B8914884B
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355589; cv=none; b=DY2WYoY/sgK2i5q95o7f2t8TXdzGFbz1sXrWOZbsEqJlkst8r/1zvu0MNryadBBhHZGP8sWpbi1hvTpcMCYNQig8ionYgW2VlpyIBFzcS7EkNse+rL8cIr/2c1MAfyP64vXftePj2SS7vebPD1Zu4yhVWU/VJ4b8arrWXROArHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355589; c=relaxed/simple;
	bh=o7VAZildQik+bgPjk5JwcrhDEgkEDj0a3mXp1aec9L4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VTRm2xrOJvN3yaEo1d1jNnklwyufV/iX80+0FRo74W8ic1r8vv0zQ+2VFwjUDLB+tizYffp9I9gGUgZZ8UHylMScYjMXTvIgsiRoX3T4T5ItTSgTBKlamdunag+/FH/bIil5ILE9NIFv4bIfukvXnJYo5xdJ9lKPaeNOXqQxiH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1YBjHNV; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1YBjHNV"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44051a92f37so16261731cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 01:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718355587; x=1718960387; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DbIBUh0f6/QhleX/nQJ9onNuC8K2/AHwh5GJo4LsYUM=;
        b=W1YBjHNV6KQrsJqvNu7LoxJsQmDK7XI29ga0Hgt8sI7fY5yomOoL+hVZqscT/H3YSK
         jmtz9dktPzaJWSKxU14glcTo7rZsHvqBxg7npau7MwoACrh++ZnHhrRtDq8iBp6kJyBD
         EIwWBk9DSESXbH6vzUvrzglhoJ4QGC96EP5Y/dfn+dn21Qm/zcFYeBx+tuYIC1qp/zIV
         wfun4Sz5VgKROPTYztHJR9qiEdWePzDGZKVBueqX6RXZjL2nLtnnDu+aegMd7156ZkLA
         7RIrei5TfDpWY2prg5mUulVPi6plwTTj2AovF+87UdowAU2VLKqsfhlPKgjzpW2X/RJL
         9x2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718355587; x=1718960387;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbIBUh0f6/QhleX/nQJ9onNuC8K2/AHwh5GJo4LsYUM=;
        b=RWZM3kHZnbv35/GUtKur6zu9CM7t33cmrMRqPLshvwWGBGWuQtMVSxynafRy50ZYMC
         dLOuofOT7zcpzLkU59XuLHNYZEvqr2oNksP21r1LN2QRqZA59GCjYafen+D7jgsrQ4Hv
         A6VK4N9f4M4GqAVQnadKm6MLJ2DO2EREOjbM32FHCDHiq1q914ZAV5l1g86BiMheiPid
         wspxWshYNvinbwl8Qa3CtTf6iZo+dD9l55GHS3LvxgyEVUcq1whX0FXeQPyQtoZowf2V
         AVYuRMUjh0G5c/CuArHstA/+iTPhGN/XGLOaMbIAtwA4h4cQL+ES3EvVus2dG+5duRdM
         Wv/Q==
X-Gm-Message-State: AOJu0YyISQ7AK/w/5EaqyfOEA22TpX6r2oyvyPJP+UrLZC4/SiHmkYfd
	ckhGtpkibK2hPip2IGv6sc4380cHKCCRCKf3sBW8Wtft52cVttsXV/OzJw==
X-Google-Smtp-Source: AGHT+IHEwLb6Nk6JMdYwJ0ql4TwCqwydsZZd0XWtcaF8fXJ/YlWgAKj2oQj0yntRW9RWtzR+FgJJEg==
X-Received: by 2002:a05:622a:15cd:b0:440:97b5:cb with SMTP id d75a77b69052e-442160b43c5mr37122881cf.32.1718355585964;
        Fri, 14 Jun 2024 01:59:45 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.51.251])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f859bd18sm14103801cf.51.2024.06.14.01.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 01:59:45 -0700 (PDT)
Message-ID: <666c0681.050a0220.3ac8b.5155@mx.google.com>
Date: Fri, 14 Jun 2024 01:59:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2854891546215713304=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2] Bluetooth: btnxpuart: Enable Power Save feature on startup
In-Reply-To: <20240614082039.6465-1-neeraj.sanjaykale@nxp.com>
References: <20240614082039.6465-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2854891546215713304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=861975

---Test result---

Test Summary:
CheckPatch                    PASS      1.18 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.98 seconds
BuildKernel                   PASS      30.37 seconds
CheckAllWarning               PASS      33.05 seconds
CheckSparse                   PASS      41.71 seconds
CheckSmatch                   PASS      106.32 seconds
BuildKernel32                 PASS      29.30 seconds
TestRunnerSetup               PASS      527.09 seconds
TestRunner_l2cap-tester       PASS      18.66 seconds
TestRunner_iso-tester         PASS      33.50 seconds
TestRunner_bnep-tester        PASS      5.28 seconds
TestRunner_mgmt-tester        FAIL      112.58 seconds
TestRunner_rfcomm-tester      PASS      7.56 seconds
TestRunner_sco-tester         PASS      15.09 seconds
TestRunner_ioctl-tester       PASS      8.47 seconds
TestRunner_mesh-tester        PASS      6.10 seconds
TestRunner_smp-tester         PASS      6.92 seconds
TestRunner_userchan-tester    PASS      5.18 seconds
IncrementalBuild              PASS      28.41 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 7 (AL is full)               Failed       0.197 seconds


---
Regards,
Linux Bluetooth


--===============2854891546215713304==--
