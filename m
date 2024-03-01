Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6479915C4
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709322171; cv=none; b=aGg2TEfcYSpGDZZe+88uzkaJGLZUoYQgPMbRK+Je+7T4lf2X6NWHFF2yJOYbHw4O8Jai4QNeVPTcayepvy+TSuOdJUadH2/p7jAhGz7RAQeZ0SxFBbriOM0VAce/AzMNQqBO9cgXjsMaqvtUoj15z2BdsUJBxbW4WdqCaA6bR+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709322171; c=relaxed/simple;
	bh=0gGqOex04LeVhpuzyrL6LnTgDY1AuOAFVLe3jxRHHNk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hWJq59omBBJrEWFl/ld4CMNSY4LTMbJwusRe8pApb2cLgoHEJqk32nwOvsfxho7TNuLZ0wBbnogdTzmkmY/+KXwN5cbtaol9tagV7pN4JLrkax61unuK8cxnRdaJsOfwjWME6TDIEOo7yNCi8fE+jb9QJ9xz85cTAxtQ/5yn0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DM+/gufW; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DM+/gufW"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6098b9ed2a3so4548957b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Mar 2024 11:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709322169; x=1709926969; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bgMjkQ5Qy1/3nJdTHtXC9e72YLv/wa350LhsXvkfN8A=;
        b=DM+/gufWZ06yYoiK/TVQJUXMj5CkDZ5NlVwh6iRgkpWHGd+LnfO7ejb11wSMgUBWCF
         8UAxX4ZP57a15rKCAbdTn3vO1NH7KH4wITjCsvz8pdYiG2hGrg8hmUGimyAuZMBl763c
         z0l10HcwgoyY4tOBustIuBEsDfm93bVz1mNOgfKZALXZEIP6zdVx4Ov5vuBy5ZBRw5xD
         n3+NBtih+tAiADxjnPShOy8WC793GVHL8j0tndrgyS4zOJNGIlBTF+sHSHcDc3E6ftty
         1kTRkabUVsk/srNNM6dEnySaU/O4DzEx3QokXHWTsKkAOCbcoadBlWpP/16+K0POjQmh
         665g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709322169; x=1709926969;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgMjkQ5Qy1/3nJdTHtXC9e72YLv/wa350LhsXvkfN8A=;
        b=AKvVOPlO9R+uPHLDMswMPOX8NxfoYDBSFABgtWMQ+oXmhbHrD4EF1LwFiZvrqyslVm
         0p6ndDRAHKfBFTc6Qr8h+i/Vpaw7Ejw8McVTLoof07AqIVUKQT2+MgnJFJqOUyrvCpSh
         7+yK1JKRwdKsiLZUASwHi8KWRisONVym62INkF76f5FPgY8hT4ABCiR/YaEfbanfwL/C
         b0zffPgHIvulk0NoNZdSDsdIYjUBysC+vlXseSBvIS0PanAgKN/0zEzLkVIuYWdRHlpF
         r4n7frLjkQYrmkQDTfTXAsqPXg69SGjSAD7ROnzYZTwDisDKJ7zH3phn0RCKJP/AL6wJ
         k3sw==
X-Gm-Message-State: AOJu0YzuQoHcmYo7cc4vCoCPSlYOSyz4FgKsoT+TfFo0hI13qCC46k7/
	PzhjDDtBMx2rLLqJKyyN3bBrYX0kh/3lkfGoT4zRxCCVnynSsr0G5us5yTU2
X-Google-Smtp-Source: AGHT+IHwEkPRDlbkwl3r69pK7ByWiRnfHPuGKuAWFb13nNaWjJOO497h6XRAKIoGfr+PzGsVh3BGKg==
X-Received: by 2002:a25:aa8b:0:b0:dcd:5bdb:4aa4 with SMTP id t11-20020a25aa8b000000b00dcd5bdb4aa4mr2494766ybi.51.1709322169417;
        Fri, 01 Mar 2024 11:42:49 -0800 (PST)
Received: from [172.17.0.2] ([20.81.46.145])
        by smtp.gmail.com with ESMTPSA id b19-20020ac85413000000b0042e625a110dsm1961479qtq.78.2024.03.01.11.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 11:42:49 -0800 (PST)
Message-ID: <65e22fb9.c80a0220.251fe.a509@mx.google.com>
Date: Fri, 01 Mar 2024 11:42:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0567799888673470239=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: af_bluetooth: Fix deadlock
In-Reply-To: <20240301185034.2756103-1-luiz.dentz@gmail.com>
References: <20240301185034.2756103-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0567799888673470239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=831666

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.28 seconds
CheckAllWarning               PASS      30.85 seconds
CheckSparse                   WARNING   36.83 seconds
CheckSmatch                   PASS      98.99 seconds
BuildKernel32                 PASS      27.51 seconds
TestRunnerSetup               PASS      505.14 seconds
TestRunner_l2cap-tester       PASS      20.25 seconds
TestRunner_iso-tester         PASS      32.70 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      114.53 seconds
TestRunner_rfcomm-tester      PASS      7.45 seconds
TestRunner_sco-tester         PASS      15.01 seconds
TestRunner_ioctl-tester       PASS      8.04 seconds
TestRunner_mesh-tester        PASS      6.02 seconds
TestRunner_smp-tester         PASS      6.93 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PASS      26.39 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/af_bluetooth.c:223:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 6 (RL is full)               Failed       0.194 seconds


---
Regards,
Linux Bluetooth


--===============0567799888673470239==--
