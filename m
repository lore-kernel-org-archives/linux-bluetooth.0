Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4851C28E
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Aug 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723301873; cv=none; b=AMPnFFI5lRY4XAzatireMtMxJQ1JsLGWOZn5uCZ++Oylpb+xUR2+AyzfI8fQVEF1tLaVJOkv0in53IcDUOtJq55IuqpdqPpb0ylnjW60mBrEoZT3BnA3BUd251J69r1poSKBJxStDOQyrY3qHV0xhn5FG2DivTzTY+okw379YkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723301873; c=relaxed/simple;
	bh=Eskn2VyhXhXkknHEdp0oqi43U9i3ltfS/O3Z8ylwGLs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=t8dsyBYjA+0iaiNKQJ8XS8lt+iMoZ4hUyhaLP/Sc7kdITF0i8U8qIyeB3m+aYhZ/2Fh3jP/jmCY7LWE3SHOiJZgTpTx0atBUP9DJMgr4R2IGW1nS1Iq8Pqe9LYeoFLwCGoLHheskr1en3wueoQ4qrTrN5R/ttEmnlfxJkLGKFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQlYP4zL; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQlYP4zL"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d316f0060so2624199b3a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Aug 2024 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723301871; x=1723906671; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bUjdcQJAhYoGPzjtudhQVQq4BSy90dc8lHFcImZIr0E=;
        b=dQlYP4zLwtDXPa8jivWusM+HeE/24xgj6VwV8Lk0TFrfRkkvDffBRO9UsegXltSkLx
         Jwxu9kg92txADf2aeAyexDg+CtA7bK2xCusmCYh9XFsppm9E0Ric4c/KCwc+FOaJRb5y
         NJIPw5OAf/c+U3UTmHjPuDrWi9YRMPKjjzrmGvtos5Yy/dLtM+b1x41HghDCEAoxKwTw
         V7dpumEvdiMMujXTN2mCQV4iccVJ3AjLc2RPR7jNtyJgvCbi//VrcnPigEIR+Q5HBJS5
         SFCMDEtN0M4wUpccXRxa5WLByBHJgMf9GNQxrU/YVOCIqtxDtgus9HBW0uHPnGeu6wr8
         rAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723301871; x=1723906671;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUjdcQJAhYoGPzjtudhQVQq4BSy90dc8lHFcImZIr0E=;
        b=R9MTejgDFTkcSVUa/Oti+b2r7R3CMVmIyh6AJGYa1efs+g+Zdmd0qnHsD9U/m8XN/+
         I3I/IvHLUifapdIV3/IsT8+m/4KGUIwEqoPsnxaNQpT8FLZnemRrz4lbUZXfQ/KDE0Nh
         CYuUV299fjZYvNTsdXwSsNf5cld4zR6+F+HpPMyqZJqA8bPjucQvysMSmu7ruEtTNYxq
         I3RWBYcs4qPw6EyuaxQX1kDPRmXcqSizkoF4zKW1pE/OZLQ+421Aa8Dg8LfS1lzkz9jX
         JUMZ4lYPmyKAhsSXesfxo8YeSNF17GdywodkkP+3OEygWsAz9XQo+xhcbt88MpB4Lr91
         AtOA==
X-Gm-Message-State: AOJu0YyCciH9pMjk0Mrf3423l3G8efoWZzW/oY0zM6jF3IQD8FhpMmCl
	8Nv4IBg5EUNkTOXcqye3A8ieGFL4N7vhBkAGwL6hqE3rZSNLy/ikPjEg+g==
X-Google-Smtp-Source: AGHT+IEm2v2eXenJNwqFSlMQkYQ4MYNgT3YkklN/WxWTYciwLUdrTp/Aw+0Ju4rERyOdPMT9Sl21jg==
X-Received: by 2002:a17:902:c941:b0:1fe:d72d:13e1 with SMTP id d9443c01a7336-200ae60b6e8mr62799265ad.30.1723301871012;
        Sat, 10 Aug 2024 07:57:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.78.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb8f8f29sm12727775ad.65.2024.08.10.07.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 07:57:50 -0700 (PDT)
Message-ID: <66b77fee.170a0220.12a4e9.34c7@mx.google.com>
Date: Sat, 10 Aug 2024 07:57:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8072260503324388588=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, visitorckw@gmail.com
Subject: RE: Bluetooth: hci_conn: Remove redundant memset after kzalloc
In-Reply-To: <20240810141415.124113-1-visitorckw@gmail.com>
References: <20240810141415.124113-1-visitorckw@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8072260503324388588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=878440

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      35.88 seconds
CheckAllWarning               PASS      31.57 seconds
CheckSparse                   PASS      56.97 seconds
CheckSmatch                   PASS      101.11 seconds
BuildKernel32                 PASS      28.19 seconds
TestRunnerSetup               PASS      530.94 seconds
TestRunner_l2cap-tester       PASS      21.71 seconds
TestRunner_iso-tester         FAIL      35.26 seconds
TestRunner_bnep-tester        PASS      5.58 seconds
TestRunner_mgmt-tester        PASS      110.01 seconds
TestRunner_rfcomm-tester      PASS      7.44 seconds
TestRunner_sco-tester         PASS      14.93 seconds
TestRunner_ioctl-tester       PASS      7.80 seconds
TestRunner_mesh-tester        PASS      5.83 seconds
TestRunner_smp-tester         PASS      7.26 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PASS      27.06 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       6.243 seconds


---
Regards,
Linux Bluetooth


--===============8072260503324388588==--
