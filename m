Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122471A38F9
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jun 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749225570; cv=none; b=AH+clnP7D/EiYA+AFF2KlXMtYDrZ7Rrxi0vkdj3Hb/nNC/tsOeWmP/GZ2tE416pPYszDvJwc/ZFl17++IemcAX5nZitFjktoLI/68CFeSRofQdt+WsPvuhtye3CmUoHbKXY2T3z7L/PInXthT0rInKlWRxHgrbxT6lyxuHxGaLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749225570; c=relaxed/simple;
	bh=LCO0Z7svUXeYIALPAOgJD/F8Zno6Wzmc6qK3ItobVgI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lL3buLuo7clatOw2sKb/fVAwNxXiatHlmHXr6qs6RTn/fb0HX+ghnvpS03Cd9cKtCvm/9cIlqDCpb7QC/bsdmP+I+0YQZV9RtfWddti5+7Z/t80SXXbwQNK8aRMaX0shweTZPesFVqKuHWyuZZhXOpwivezePueGjc0IgC1Y24k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxi3T1WB; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxi3T1WB"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a585dc5f4aso29626941cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Jun 2025 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749225568; x=1749830368; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YK+dP3d3vxqgcmirv9+LBlSMDXJkuU1wC89bB+PSy5Q=;
        b=dxi3T1WBo9qnJeQ9t+oHWwt28Np7A2LxDsGDOLAfU0isr5RXQ9UAArDAHvecpZuP13
         Q0LIxajCWdeyg1oFHQZjYxi/YZUjcW1JKsjCkKcgaATp9qcFTzAR4mHcbD0f5BKFyPAH
         QJ7W3ItXHZF+z3lVIPfaYAEQmDUozvLOGNi9ooCEPBMQ/yIiaGN74cO1DN5sG+HprgvK
         +nQORknjhUEBs5dGSxcAAXwlB0Q8Lil1+/PU/v43EKEjwqdCCG7tcL/2rwrjkcpGkQfN
         5a/2nbFlCV/ynV/rdgmjU9irCSfRzFGHGE3Fj7vGud1Rt3wOfdf1IuGbkUKVT7kPSb4k
         uVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749225568; x=1749830368;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YK+dP3d3vxqgcmirv9+LBlSMDXJkuU1wC89bB+PSy5Q=;
        b=SZt948nJUizpfHy4Zgw6+5usINws5bMZaTse6fElEbWXpY0XixhT9M9uZF6RiyNqYN
         rJk8pkesrjWdRnE5KZ9KzJDOYnT1qQdhfBNHZTJI4LbS0V3uTuASzL+BN+N9D1Rz8vR5
         AlQxb2hZIPLGzsXP4RogsMt4/Kyq3TKA06Oe2Jnq2DLos5gURaYKxrTrxnkg+6s7+eru
         CRQUWjw9Q8HIjBhVS6q9tpnCOZlXykusXoNZZ78RHUkQuZQgFkb7NzXQt+uhTL9jACKM
         Nc15wCTvOlq3XNHgXOaCjKzUWUwFsi3IJUKPdsLUYt8uKpBYmxeKjU//CmqIJFkBqCts
         j1Ag==
X-Gm-Message-State: AOJu0YwYc1dMrQmat+onzz8Tx+w6WYVwnqRCmSSz6VnH2MqQvOlYA+ml
	/WQGhEraRRVAm9A1G1ktNNU/9tmGiGZVIwXo7pOmypLl3xbQoSdiYK3V5dZWNw==
X-Gm-Gg: ASbGncsL5yVj3krs1Kf8ggalq7hInNaX67XMigEhhAV8P8Z4t5OA7N45G3LJDeQTbNK
	KL3JgO/6VxWFR5/F2AAZIBTZ66zokuZNwcuvFbm7G7YTtpMyV1K1cdLtB8qCzVBpkPiGUKrW9FH
	rfMp27UcZ9GOyqS1DIG1vfPZ+roOcp4+tHk0gP3AneV3FSVr51sh44muaBmE+sfF5cm79hxf9Lx
	ELHmkfrpxm4f1lYokBcNtV1242ydidlmsa86yP29blAd2709k4YLqej+qfnLiJuvZ1zPoxecDBM
	dKWs15r/Kw4XoS2bxcGtZXlHJNHifKSXt6nQNHHdgUoXM0W1T2wXh2QV88WfUmepZOu1YDE=
X-Google-Smtp-Source: AGHT+IGBXzrmRfJO1qEx2ciqbjkLHmQ+3n1uw2z0m9GoI2kvZCLk4xMUFd5n7WZiicW3hb//aEmH/A==
X-Received: by 2002:a05:622a:428c:b0:48e:1f6c:227b with SMTP id d75a77b69052e-4a5b9a47e1amr63388351cf.26.1749225567614;
        Fri, 06 Jun 2025 08:59:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.175.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a619894b48sm14183511cf.69.2025.06.06.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 08:59:27 -0700 (PDT)
Message-ID: <6843105f.050a0220.b61a5.2b26@mx.google.com>
Date: Fri, 06 Jun 2025 08:59:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6109871665563688182=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, i@hexchain.org
Subject: RE: Bluetooth: btusb: Add a new VID/PID 2c7c/7009 for MT7925
In-Reply-To: <20250606-btusb-mt7925-add-v1-1-9b64bfa86ea4@hexchain.org>
References: <20250606-btusb-mt7925-add-v1-1-9b64bfa86ea4@hexchain.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6109871665563688182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=969302

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.95 seconds
CheckAllWarning               PASS      27.63 seconds
CheckSparse                   PASS      31.33 seconds
BuildKernel32                 PASS      24.98 seconds
TestRunnerSetup               PASS      461.45 seconds
TestRunner_l2cap-tester       PASS      25.30 seconds
TestRunner_iso-tester         PASS      41.77 seconds
TestRunner_bnep-tester        PASS      5.87 seconds
TestRunner_mgmt-tester        FAIL      139.26 seconds
TestRunner_rfcomm-tester      PASS      9.58 seconds
TestRunner_sco-tester         PASS      14.91 seconds
TestRunner_ioctl-tester       PASS      10.30 seconds
TestRunner_mesh-tester        PASS      7.34 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.14 seconds
IncrementalBuild              PENDING   0.85 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.223 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6109871665563688182==--
