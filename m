Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC78357D10
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339706; cv=none; b=S0SEd3xPkSJBOdxLYwd8vVK+gmqylg5QEAdnPn7SHZrSakc6O5wkV49Swfb6143YV61QznxGq6Q8tidsnSYfHDlttC1aO+/YgkzlzsWbDOVfmRamouhxo32smbzhx8VmbWJVoTSYFnQrS2TsO+aqX7wfmSQkRHpP/4gjTtyVJcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339706; c=relaxed/simple;
	bh=gKN9hHOjBGpjq8se/QXnIPFi2pMD1ifZ8AMOP75cdhw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=V7eAVSdKwhbCr6kNLkqirgW3mXLKUWoXBId3Ig0NylfIi2qoF3k4mQi1OOHK+/HhzNX+SbnE3Pr3UCczUOYSdZn8gFKkRk3q+3ga+VmhE5wStc1TfBQn/G7tpwrmvrldj5d8oIkwWq3IKJ42ZMPuMLaZRezodNwNoBxfCqoh2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS/Qyxk8; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS/Qyxk8"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ce9de10985so19906996d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 11:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780339702; x=1780944502; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KrKOMvsmq0DywVrNer3TPwl4O4dIAKUvYMn5rD8yhfM=;
        b=IS/Qyxk81bjtvcO2PdcohpCmAAYXrOS1ygsTZw9rxXNtlZV0YrggvFwivITbcGt/g4
         MijHjQwpwbHp2tNDH4DuDmP+DQGzVreF3b0NXh1FaqCkTQce45mF01VZRcmXWaIr39SN
         R/6xT0xYCAmU8xPAdAk8fV3M3FbZN9OVuM+3joAlzFQ50Z2j9UXV1LGqIlj3NjJX2eg2
         H+NBV4qKH0XehcHJPfSBDWl12ajQg4Ow8+WijNuLPXKHRZM/aJmI6UfjA+HMRnKk76y5
         1wePckH/MdPu2XONQqa0s5muIGMEf7mkluIMEum+vLTuArZ4acZRBtc/X92Z4E8oO5hM
         38ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780339702; x=1780944502;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrKOMvsmq0DywVrNer3TPwl4O4dIAKUvYMn5rD8yhfM=;
        b=BoyIx/HKODxVrof8xFCAsN9GkZOYrV4n6RKxIHTUKh+S9C6OKS00UN5c5MDo44/Zwo
         jsXykBJlmxTjV0x2njOJii0lQcxy5f/R8rld2ae1kFB6lUA3XpRYfw+oYv2QrfdUFqMz
         Aib0RUJ3OVsibnmLzL3wHlPON20AxMkowf3rZf2aHQDEPN8swaispIjGxkkrlG2mQRwJ
         7LNq/i1rfnb8tL4wYgU18NmFdc7CTkX2/LQAyCptByJTB319HqZMRZRRGc8j7er9mwvA
         lmDOW4qP6oKeXVMLFZ4FCRbDdGhadVD1KrRH28tNYuUw302VDMXiKUtP2zmo0K/BZv97
         zQsg==
X-Gm-Message-State: AOJu0Yz+Ag+ObRluhvvkLiD+ldL+oZiu15jFEXvjv4UwbqKxs1u4iKiV
	0mhnS2fsRZHNOD+fMoB0qXqJYDYdDI6KnO7DldIqjn/Mas1XZrbSZA0dd3q3SQNB
X-Gm-Gg: Acq92OEdE4xnN0y78n6/mCTv4JuTKXk8Wp7vOKg69zFi/jOQ0V+mMpLnZW82lxGWasQ
	8wQ9MhtMNZ/ATsUgsjE/5nNviXw8aBTUV/GGZ5kZOT4qyo/JKpxq+RTQLsnU1/n91Ad5N+MzwBU
	YjTLW8OodcSGInDUk90dgb1kZ2Z7S4Z6PJYwrqd0Pkz5UV8pe3sJwoJ7Ttaeclt17/bDKY8vqWg
	a89g9uD9g77P+mFEtCydBuJEfvROh5VqDeEGxgUUy6kdqW4UuVMAS6FP1T2TdcQuMvvZeVYtCwR
	Fn06mIbfV2PIWtA4P+ierpMLeZtZOiB/ye0kCpUrjz6q9A48k8stxDoPYOaYePuixR5YiVIyCVA
	mv8giJ6fdLzuasFmhlCfVqZDtLfD60MEXqgiLxVTxw8KM1Hptmg/1GLfSzsHO3+cmWbrSkYRwyf
	hOgJ6XZWURV60th8LZLvTKzLXMs4Hkduv55AvYicPR
X-Received: by 2002:a05:6214:492:b0:8b0:33a2:2520 with SMTP id 6a1803df08f44-8cebf43027bmr12540816d6.10.1780339701665;
        Mon, 01 Jun 2026 11:48:21 -0700 (PDT)
Received: from [172.17.0.2] ([52.226.124.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea045508sm100053056d6.1.2026.06.01.11.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:48:21 -0700 (PDT)
Message-ID: <6a1dd3f5.faeca26b.30e2f2.cfc0@mx.google.com>
Date: Mon, 01 Jun 2026 11:48:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4542498777814994726=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] bluetooth: btintel: Add Bluetooth SAR revision 2 support
In-Reply-To: <20260601124825.216489-1-kiran.k@intel.com>
References: <20260601124825.216489-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4542498777814994726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1104005

---Test result---

Test Summary:
CheckPatch                    PASS      1.19 seconds
VerifyFixes                   PASS      0.16 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 FAIL      0.13 seconds
BuildKernel                   PASS      28.45 seconds
CheckAllWarning               PASS      29.87 seconds
CheckSparse                   PASS      26.84 seconds
BuildKernel32                 PASS      24.85 seconds
TestRunnerSetup               PASS      536.15 seconds
IncrementalBuild              PASS      24.15 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/267

---
Regards,
Linux Bluetooth


--===============4542498777814994726==--
