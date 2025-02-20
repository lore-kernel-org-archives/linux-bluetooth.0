Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361961D61A5
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 02:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740018970; cv=none; b=Y65rKPxgYs/2xzims9532KQt776zQA2DOC8+uFSVP7yjVCvEJdcI1zfGRRk4/NHeZBWwY6FVhC/L8JG4xUYRAy9EjxAswL3bwbz3k2KcbBDg2ExBgpT/h/IiHbNHD6j78dBfmoqnZL3m+PjFei+AVq55Qu33Hpz2ElcKqwY8eLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740018970; c=relaxed/simple;
	bh=RI1M4zQ+hMyAsLEz9HWVIwFBSoK9A0cAeY+PwswriuY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DW5AViqncjbwfq3UHyxAdSK8PSnZ5BXgiD5zjKJsk0QrDwyleRDVaKjhfDNZwGVTaSt2G4cZ/Tb02l3heAsEKGUce2cb3HfjYWzmxgYHX809T+yMgspPdlIIRJyFcY7jR+sqmtKjPjvnr/oSIl9cfJQCbMx8Ykx2IBMbHS6iNTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXg+t/zQ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXg+t/zQ"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-471e520a599so7850251cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 18:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740018968; x=1740623768; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wHvSWBXHnHz/g3/j9FZ+CfLmhfPSMsFM4+hdBD1GCsQ=;
        b=QXg+t/zQCsD/E7gDA9wFXUWIHsG2YMvKXst+yaKvqt25sHfp6XGDIKUiUL7F1eoB5P
         6g0XKnb00YD5Szh8rtK7gsPPS5V+/wxkNiS8a0K8fRdVFnJLAi3mBBnnqvUsUMcaPef5
         +K0GkAmaDoebYdAvcE1oZiqIeVJCSLFw66rFA+41dC0/DZGD4QOPdgBG/Yxkfz5CmAPG
         0ovYr51U0rDl9rlm/4yFdA1ke8IMddL0XfuruyHz9GCYoM79ovlYljfOTKO5NSkNDosS
         2lfiYjcfZzK/YDZX+mgmxK8IQ4Q5TXritSAHQbqke7aB5ZBnas6TzVoiyjGBje+SBWd6
         bE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740018968; x=1740623768;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHvSWBXHnHz/g3/j9FZ+CfLmhfPSMsFM4+hdBD1GCsQ=;
        b=o0UQZI3GDh/HLsGsYeD3kEZj7qYhZcpFxWrbdAO3D3dbvYo9mRSz5Cc4E2xsYqICQT
         uIQ9k8DPlijvyiBwkdPWwxA9dlrJvDWx+LW6FxVzerNGF5IxuIg6j+0F81Fe9zTiLOFX
         lj1NKxmPNW9NzmByPeinn9fNLm3eivk/TAJhHdrKTB4YcWvsFO5NnmpOsgUC2wSNYih+
         PhHlnsCxGu7+pmwyQybzOVXkqxZ4yYJVbXiW5xU1PZflHbyNFfNTPym8QK9zpM/nd8L0
         wguXphYJAyFoUPWokXxpaeV0nK9mdQvOOuDs84eWhNChZIYpkD7lJtb6ZCyz2G4zmLKG
         qEbw==
X-Gm-Message-State: AOJu0YzlYPPTcmh45+vEpveoP1H1wAzffdzFgGl98IrVFWyof454WKWc
	AlA1+XP8YBCwKSnFue1l+C107HP94yXo2jRABjSmsQfQixmUB6bpLdzU2w==
X-Gm-Gg: ASbGnctH1af5UE7jZnjRS+er+VviNe7lxza7Hk6akv08AXaIjhgSNY1ZIa8Z0wRpNe3
	R9o8lDzrTCRT5SRDFdE5S4w3TDtbpS3MMTQr9RwGr/ZtJqQW4jAwwuA1SmuCJrtn7KxgSTpV0iy
	8gRDLopFAXfS92s3RvjqnT569oot2/O82wy8SCVxAK2ySjhhWsizghF6beM+1hGXp8kWWhMjmqp
	1K8RGsQ95rPcMA5IH9rxLJ1Lqg6d9Z4RCj/egcXhsmKCMSUwXnH224YeNqXR1PWTIlkYzUTqtKG
	SNeoKIsTaHb5KJhZlmye
X-Google-Smtp-Source: AGHT+IF+WIlz6qleDbvsGqll98IkqK2GBFPublIjU1h7/vCnbA9LMxZii375lfH6dC0FBSYZxbUGpQ==
X-Received: by 2002:ac8:7f0e:0:b0:472:1573:fa9c with SMTP id d75a77b69052e-4721573fc3emr16855821cf.6.1740018967935;
        Wed, 19 Feb 2025 18:36:07 -0800 (PST)
Received: from [172.17.0.2] ([20.25.193.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f1e866f4sm39009441cf.33.2025.02.19.18.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 18:36:07 -0800 (PST)
Message-ID: <67b69517.050a0220.18d1c5.2d97@mx.google.com>
Date: Wed, 19 Feb 2025 18:36:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9049416834796626283=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jiande.lu@mediatek.com
Subject: RE: Bluetooth: btusb: Add 2 HWIDs for MT7922
In-Reply-To: <20250220020129.2400730-1-jiande.lu@mediatek.com>
References: <20250220020129.2400730-1-jiande.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9049416834796626283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935810

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      4.36 seconds
BuildKernel                   PASS      24.62 seconds
CheckAllWarning               PASS      27.12 seconds
CheckSparse                   PASS      30.59 seconds
BuildKernel32                 PASS      24.09 seconds
TestRunnerSetup               PASS      435.18 seconds
TestRunner_l2cap-tester       PASS      21.16 seconds
TestRunner_iso-tester         PASS      39.87 seconds
TestRunner_bnep-tester        PASS      5.13 seconds
TestRunner_mgmt-tester        PASS      115.71 seconds
TestRunner_rfcomm-tester      PASS      8.08 seconds
TestRunner_sco-tester         PASS      10.07 seconds
TestRunner_ioctl-tester       PASS      8.35 seconds
TestRunner_mesh-tester        PASS      6.69 seconds
TestRunner_smp-tester         PASS      7.35 seconds
TestRunner_userchan-tester    PASS      10.06 seconds
IncrementalBuild              PENDING   0.70 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9049416834796626283==--
