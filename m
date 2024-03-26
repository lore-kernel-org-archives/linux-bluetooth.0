Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6031F94D
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474294; cv=none; b=rIobZRot50dmwPdbdSbT4cpPnft536Tnbl9p+BmWcfjCEggtvcmDfZF9P7JtrxR05GItUb1WXAfqXRYnSDo1wIyqR2ly364BbsIhfX4sjJSOAyfh4sWxkNMlNIrF0cSVGloSrfkq7RuK3/UWJVHA2YJvjX/LF3X5Ayipp44eO5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474294; c=relaxed/simple;
	bh=gibUEX5MA3Ix6T/9R8tigWWYiib14P9IEznSRsukQyM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EliWcEy+bwoSHZ/iH1tyrHAxhiQ9Z8n427lzhKnii1vuljaNnLgW1jgtv5JJKlG5q90b+r5iwJVHHcI46f8rVABBF7GcEU1dgz1Qq7I94wgU2l8BK+gkCtdB4SSnfUMTvt493SbFF0yx+GVqt3cAym4lhszWNy3vdi/7qZqr4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O63Q0Xlo; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O63Q0Xlo"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-690d7a8f904so257736d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711474292; x=1712079092; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ro2x6R7tkWb/YddAZtGpMuUERVicraaEyuqesAccFE=;
        b=O63Q0Xlos46XgjouPTnSbG+Nw/xUgVbzUhDo5P77bAGCw2pf58dQh74cSJHmyV2e/J
         35ku0gcTnWyPYOSSRLZCbHHeBrR/tSIJqTK1RzY+G4KjjsNTgx3vEkK/6RxyUn9+y/V9
         X/gPmWOAlzJZwnt/2jtNIq8E8wy83mGVa48Kd2VQW8OHyph6EeoGshTn4PP3uJTJDWNY
         kyuVdHcV44o8Raa8tFzLHFSZEVtSUc+qbMfhpquyYMl4Piz7o8XFCiXsPqGrwCnpSI8O
         W9MVxh0CWFFQp6e0gsuEox4PdylFnCOXozadlWl04QSZ5Tf5zgzEA2PQPF3rLFgalfko
         4ZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474292; x=1712079092;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ro2x6R7tkWb/YddAZtGpMuUERVicraaEyuqesAccFE=;
        b=wGBhMc7aBinBSGaN44jQoKzheJoWn8xoEWjGwzKUIykkIrSUIuz+nbYwvE3AIR33Nf
         rEuykYgM60OC7sVGulHv6i3svoLn9kWwDmHPE+2o8Iculh8Y2qf2EJ8wLEOIk8cWRIC0
         LtItbAH9YVUQZdwtlshRiLB/9TpjfCAysBDf7xDVL8GdZQRe/nDA0WjFIeHKkC4FsMIq
         ar5+5NpbkIbp0x37PNP7l1i5fqZ4P44x8NiyRlET+De72mT/P4xOUPES4tdUOMzS425t
         +i2xS8dSg2UXt73tGW9mFAjPvXppdKs7f+4MHHsn21RkXyqrKMUKTIAUpkQRylVBUIr/
         vmlg==
X-Gm-Message-State: AOJu0YyY8OxJWRzk3vCL6uc9WTixiQ4wqo1/eF9YWAXPFCTpOhB6oSwW
	wYf1UZDzzIevsjoUxM/CesK/vy0bzpW/xQml0Q+BolvA+qrm0rk8kfvKRGxL
X-Google-Smtp-Source: AGHT+IHvnogikYocf71+BBw0izcymJj6xeMq+Oj+JYzThp9V0qLEnVwB6q9WLglq1lsh6gO7mLQsDg==
X-Received: by 2002:a05:6214:21eb:b0:696:a4d5:d318 with SMTP id p11-20020a05621421eb00b00696a4d5d318mr2156619qvj.7.1711474291791;
        Tue, 26 Mar 2024 10:31:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.82.151])
        by smtp.gmail.com with ESMTPSA id gw2-20020a0562140f0200b00690cd39da04sm5424293qvb.32.2024.03.26.10.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:31:31 -0700 (PDT)
Message-ID: <66030673.050a0220.ed7ff.c79d@mx.google.com>
Date: Tue, 26 Mar 2024 10:31:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1493290138391775419=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix not checking error on hci_cmd_sync_cancel_sync
In-Reply-To: <20240326164317.1460864-1-luiz.dentz@gmail.com>
References: <20240326164317.1460864-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1493290138391775419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=838479

---Test result---

Test Summary:
CheckPatch                    PASS      1.28 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.04 seconds
CheckAllWarning               PASS      32.00 seconds
CheckSparse                   PASS      37.18 seconds
CheckSmatch                   PASS      100.34 seconds
BuildKernel32                 PASS      27.52 seconds
TestRunnerSetup               PASS      519.04 seconds
TestRunner_l2cap-tester       PASS      18.16 seconds
TestRunner_iso-tester         PASS      30.99 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        PASS      114.43 seconds
TestRunner_rfcomm-tester      PASS      7.42 seconds
TestRunner_sco-tester         PASS      13.00 seconds
TestRunner_ioctl-tester       PASS      7.83 seconds
TestRunner_mesh-tester        PASS      5.94 seconds
TestRunner_smp-tester         PASS      6.92 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PASS      26.02 seconds



---
Regards,
Linux Bluetooth


--===============1493290138391775419==--
