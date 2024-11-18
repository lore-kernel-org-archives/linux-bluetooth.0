Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3855153836
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920575; cv=none; b=RQH+MSZZ7RBrTojcLffwoyITS//EmKQJWEPhT75IIrXtiZotmQU75w/eXfYbEBIeF6qmI8SiC+KMbQbUGiqRUQwbxPbXTzpX9skeIgz8EF83gmEbxvwbIULH4NkBL3YVMsE/OPDk2Ratarc6qXjYhYL3d2ElbIOIUDw5Q3k196Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920575; c=relaxed/simple;
	bh=UPV+95FMCzS8ZOJc7zWWwgD/GSGbCaAeekJJs9VUURk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nMBU19wzKqzcsqpkJUyI5l/LWSX23EezeNJnepBCXDefYv7KjiRgIvc1o1e3JVJZioyttKa8wI5hfNc1c/3DGk691JhmVJpElugHxa7yKapF+nWW87bFTSI7PFUVBUIfVSgkXAk7OuGSXFYpDL3EkQ1voG3scqsPeyBwaQzVCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6JPiWm/; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6JPiWm/"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d3e9e56fdfso33992516d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 01:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731920573; x=1732525373; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JQMIwJo1jvCeXcrmitB2HcSMrNdt6BASmnTWOnlyuUk=;
        b=C6JPiWm/LNc0fks3DXUBG2Wlwvvs6Gt5gPncClk1jxqSt+XPpZ08OWWhQp435P2ns5
         Kvoc0ifZDNyabDsXmh0Q30hyQEG9Lt0xAnAYIM9GAFx23tMrtYGOYgX3o/PQ9qFkG6F0
         TCLCIq8Hlmm90nNvl8/yRVx7aGzRM8M1f0ZUW7G8pInBcTB+S+pG9MCt+I3bT5SUwPhh
         4LF0vHcNQpgnDSdLxSVq6I6FxYdeLYv+CJIU+1hqlrxGyhw8y6LCLGnp/TaQLkovPQ1C
         egni3nRIe6j/Ev7EGgrBWxZnthNEbEtRu4DgSFdXxsQGWyk3l5K1YzHNSJAt7RkZJrPX
         XgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731920573; x=1732525373;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQMIwJo1jvCeXcrmitB2HcSMrNdt6BASmnTWOnlyuUk=;
        b=QDEO7gOy4QQN8ej+r1laCcXZ8nnUs0PnCzooT+gDJlx5fIm7+exWqQCDF7rOCnGSxB
         jE7pP0lBMZHO+EinzPP1IHCzVS57aNfUfbJOUCW4z5kx0jsM2LHg/m8Ud0CnKm/WZ6Kk
         +6no/07aWYWVH9pinJAJwwRmQF3JENsx2JiASAnkZtKHkTi3TPqxtEF+rGI0TRPP49bc
         lO/xhuOqzi6mgOE1PbHIKlQ3Xn0s9YvIc0VXJ59lcpr9ZsL+X5SzE3XcpOQaTvVKV1c0
         NLdaUh27wNRNSL8ROKwkU8TCL3HFF96VkNHDiDeVpGZy43aZWr8HXrhab8ihv5tBPX9v
         TJJw==
X-Gm-Message-State: AOJu0YxmTPdsnKINrdtFLTACwcO0H6+cIrTzetsUe1Arm88+1yZ6OwHe
	sa1i97Kpt5ttMQqs/C80kGf/vTl2LtU76ZPx0YAHkq/Hewrs4NT3JI08uw==
X-Google-Smtp-Source: AGHT+IGJcoInbul5jlnXkNpVvQTq/jVOLW3xdT/4bOUcaoF7tD63jWjbWg7ScSY1wfAHtretBEtMnQ==
X-Received: by 2002:ad4:5d6a:0:b0:6d4:1d7e:bc72 with SMTP id 6a1803df08f44-6d41d7ebe3fmr74806196d6.12.1731920572724;
        Mon, 18 Nov 2024 01:02:52 -0800 (PST)
Received: from [172.17.0.2] ([20.81.158.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dd1fd29sm33086176d6.73.2024.11.18.01.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 01:02:52 -0800 (PST)
Message-ID: <673b02bc.050a0220.3f2a9.65bd@mx.google.com>
Date: Mon, 18 Nov 2024 01:02:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9112143077737425727=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [v2] Bluetooth: SCO: Add support for 16 bits transparent voice setting
In-Reply-To: <20241118083724.25632-1-frederic.danis@collabora.com>
References: <20241118083724.25632-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9112143077737425727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=910540

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.81 seconds
CheckAllWarning               PASS      26.93 seconds
CheckSparse                   WARNING   30.19 seconds
BuildKernel32                 PASS      24.36 seconds
TestRunnerSetup               PASS      434.33 seconds
TestRunner_l2cap-tester       PASS      20.42 seconds
TestRunner_iso-tester         FAIL      30.49 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        PASS      118.06 seconds
TestRunner_rfcomm-tester      PASS      7.62 seconds
TestRunner_sco-tester         PASS      11.36 seconds
TestRunner_ioctl-tester       PASS      8.14 seconds
TestRunner_mesh-tester        PASS      6.40 seconds
TestRunner_smp-tester         PASS      6.98 seconds
TestRunner_userchan-tester    PASS      5.12 seconds
IncrementalBuild              PENDING   0.73 seconds

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
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9112143077737425727==--
