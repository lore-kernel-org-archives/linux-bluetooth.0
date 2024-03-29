Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504F139846
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 03:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711683141; cv=none; b=t0BLQ6MpRxPeIZSKKNg48cgqzxMpu9/brA/6FNW7iiVvH2yAl0qSHqv2N+Me4qZUychZN09xbmMwYwEGybl4Eht6WHw+6a0TuNLrrzmaNVyv51kfSxlb//geWcLQrUNglaryX7XkqPBGmfStUTSzXrLQ610+N6REkjlj/4nJqzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711683141; c=relaxed/simple;
	bh=69KRmUtWXHywhnB3iYY1w/fb3Q4NhRnIHst9zW/e4+g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bsMC1xDuo7660IOyJwbrn8FFH2Gn5Xlgmk2HEW/r8R9g83ZpwLujG6uUdjRpFBCilrUVfE+s3zCgdkzfG7uzmSarhbY8tzEVf3FPAx6zSDneYu92liJ1Dny8zASWXRX7zPOfiWGNS9bbFhSPtIifosqnTGtryUT9RbGmLmqIEts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4m7NqcU; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4m7NqcU"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-696a7f533aeso9333446d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 20:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711683139; x=1712287939; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TRPbpaL2tzjx7BiB6PdedNMU2dd5vHkulV5chN8/HhA=;
        b=l4m7NqcUyl1QcX+0sJG3LMXIxA3zvOU1ZVfJlcjhEvXcAayS8WWLx1t24Mgu+TI4mE
         0tVmI6wXJc3MYtxx0WlfexyQWTUXYPARRNTMy/bxH6BjED9eNlwr5VIKjo2pWAOcADTO
         gthVi1s9x8LlhF3gg8Rf9/7tUPO80Fz3J9TqAg4mgjL6ELBjCL+l9akaCGhtoMMShc6C
         lyMRfa8VJUmXNi2nwYkD3ZR0kNWspb0gr6o/yBScqsp9+zD9HeWmHSwNF3ALcnbbEhc/
         s9V8kmbgKaA6PgwcNTAGwNVKVb6t0oz55KRnNpjErI0+lSBoZU16m4AaH/T59EFszRYj
         H2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711683139; x=1712287939;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRPbpaL2tzjx7BiB6PdedNMU2dd5vHkulV5chN8/HhA=;
        b=E653v/+0QDa0C5BxYTlJZ+ZUQYvLc6mLgxoXc3xwismL9YwalXYVjSqoJIXh+MdXi/
         uu+atVTHSD1zm38IcSx/cDv5uTVg8f6RhMqEa+YifMIsmLQseJGZsqcWSCXou/15JzfT
         2tpkMxQgAtdI6V0CpqKplewP1VcQeIQWwEfysyQWYBANgYznjtcYc/C3+/WKWBL3GdRR
         EG5QGMt+c73HsqH5w92Xh2PC3ypSn7lP2P1/Tf0tzvsb5n5WLtdMh4/nfUOB7aTHuHk7
         Sc5+w26dBQcI6VZ5eWCXBrA6vl+apPmskQmdPbOcJ261fUAgLTyBFNUo/VAWxTfzsLOV
         Enmw==
X-Gm-Message-State: AOJu0Yzr8bjcrBYuPZlLTLLUfCJR8NJ5qik8Tt7oj3lMZwxBUm5rfb6d
	6Idh9y8+ZCeSlXDPCO+nVZACV9NdtSv3wK6P+EJiuOcvsN6tbGk/oLKmugbl
X-Google-Smtp-Source: AGHT+IGkg6hTbREqQW4/W3sdwxDDZwvNNzzKcm+gffPMuLK42XVeVbC7+Vn9mRE7SdIxjP+fzbjVEQ==
X-Received: by 2002:a05:6214:329:b0:696:2b0e:ead4 with SMTP id j9-20020a056214032900b006962b0eead4mr1061285qvu.54.1711683138971;
        Thu, 28 Mar 2024 20:32:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.206.228])
        by smtp.gmail.com with ESMTPSA id kj15-20020a056214528f00b00696ae38c7bfsm1249205qvb.35.2024.03.28.20.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 20:32:18 -0700 (PDT)
Message-ID: <66063642.050a0220.551b4.a99d@mx.google.com>
Date: Thu, 28 Mar 2024 20:32:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0825961313178321871=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wangyuli@uniontech.com
Subject: RE: [RESEND.,v2] Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0bda:0x4853
In-Reply-To: <883A1BECA61AB8B7+20240329023440.191799-1-wangyuli@uniontech.com>
References: <883A1BECA61AB8B7+20240329023440.191799-1-wangyuli@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0825961313178321871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=839622

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.11 seconds
CheckAllWarning               PASS      32.80 seconds
CheckSparse                   PASS      38.17 seconds
CheckSmatch                   FAIL      34.97 seconds
BuildKernel32                 PASS      28.99 seconds
TestRunnerSetup               PASS      524.06 seconds
TestRunner_l2cap-tester       PASS      19.97 seconds
TestRunner_iso-tester         FAIL      30.47 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        PASS      113.30 seconds
TestRunner_rfcomm-tester      PASS      7.31 seconds
TestRunner_sco-tester         PASS      14.99 seconds
TestRunner_ioctl-tester       PASS      7.79 seconds
TestRunner_mesh-tester        PASS      5.94 seconds
TestRunner_smp-tester         PASS      6.85 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PASS      27.93 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.181 seconds


---
Regards,
Linux Bluetooth


--===============0825961313178321871==--
