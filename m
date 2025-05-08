Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028D22236FC
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 May 2025 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716560; cv=none; b=jg5NEKOFtHPqJk8Te235IE7lmbH6e/u06gTxNApnNq4wfOlQoJaIFFjRKb13iPGU43cTNayrBT3nU7BTv8kD6GCElPTaPUhbBA76oLma70LypxpslXMEYx1I48/l2XE3BoX+sCYdTzDJrfrkmUzeFP8nytTACs8Xo0rC2ZqlLKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716560; c=relaxed/simple;
	bh=lhgSZhxp3CAmF+hK/TkKurdZajkT2bzWvvyrj07+lKM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OUSwPBvU0BsaxoQt2LDcp9JBNCJ65RRWC0XepDMQ+ZWA4Ra6QoluBSTnMS9mpLW9aywHMP2ZGGxeaNq2X9nnknpzGLXzsGll2+ZLTqm8Jt9JgRqB6yq5n9TYDqliVfFWzsjVoTyxHTt7IMDci3PW/rFTi0Cu6VUMk5mWaN1lrIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDsHD5gV; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDsHD5gV"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f53c54df75so14479136d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 May 2025 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746716557; x=1747321357; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yFHzFD3J6Vo2uQPgU3m1gF1tfVF3A0GosVmn9xRcAnM=;
        b=BDsHD5gVMT/DsImK6BSmIDzMCAXhSYnNphpTPEW7Ii5G5HQdDPwTYNilX/JckYkUwR
         0eTOi2xOvKK4z/ItXhUgCzXK9Io306nOogNNHLmDiGrfmOkl2qQfqZGhYFT0s5QYYoPI
         5LafsLdG5w5QI1FIpute5sszyiHQaGwMmb8DVldOHoY40m9VxQaBWLd9BiZhJayyG+BG
         LNBk3K+xawT0YuBmjgEGFYcB6e1vUQsVzr84DLHnvSOKStMnG7EqI8ly7lIc/INKVAS9
         lZG8vNRePAS8g/msQokg9u6neV8L+T+O5Vx5GQWoUVcyWPL8Q87L5L820Mnf30mA0ubk
         VSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746716557; x=1747321357;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFHzFD3J6Vo2uQPgU3m1gF1tfVF3A0GosVmn9xRcAnM=;
        b=SkoeQYJ5cpJmEgv86/kvudtxWM1mK60oSgPzVM7Rs4MrL9VUEgq7c+2lQt+CZpfd53
         Vo5SZbX1Nr19F04w8/AD9c1ot+H3c4vWJHEdOIbZXT415tXk7M9lDMEDUM+d4maegf1P
         Ej8hkthSEjAJjQ+v3B51e2CCi07sJkMhxhdWpTJsy1LOAyebLYZEGowi5uMTXt+quzoh
         uKA1OdMEJYbiUFx11O+eaXtX77DRHhg9c1VIDSrrYXm3+5jBDYehXa+96zn4b+JKXfye
         rD7JtJds7qpShf/vI4czsMo4AIcNiB+Z3Vx+UsfUd1Pp14830W8PEHQEB42plMa1OyVB
         1nOA==
X-Gm-Message-State: AOJu0YxITWea8fFtUHoOTNy/r5HKisgT+1bTave6vkHsYOfGLuEiZ+ii
	7u4L5kkFfMLTEI9l1FdO3neiLvHF3IainL1wC9SYns+xEVs7vn+DGWFjlA==
X-Gm-Gg: ASbGncu4I5vuVbGdl3VPrnrmInUF4sZ7wk0TwxUjugMNho+39uKwTM0FBwbbl+pxA6s
	sODw+taVqn/sQQQpPkiDZN/k+Lj+StdzLP/3GG2N5VMPosULFprAytVkuQHtXDWRc7C8l9mQZll
	7nz6LE2bE1syTt6PN593iEw0QCZDLuMPDn2YcQT/IeXUd9eLeUahBY+J/Su8Wu0OsRDbDRumagX
	bWEfGXJO36dNMaSQPZt/VGT/tsqo+oG0PsBFzNPhPuS1cuHvZ9ATuv4zjUvXZ7mOf4vEjdCs9cj
	0A/YGU5p2+RqHqhod4pozKw7nEGRqbzil9/cajKYLdJkr6E=
X-Google-Smtp-Source: AGHT+IGHTBVbRoAvXL2jEBObzh7e14oWu/WYyvIW2QT5jSbosY8p1fssuiNEuoGy93AQSWPCYtk4Fg==
X-Received: by 2002:a05:620a:4881:b0:7c3:c3bb:2538 with SMTP id af79cd13be357-7caf7387d25mr1047462285a.14.1746716542825;
        Thu, 08 May 2025 08:02:22 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.30.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00fdc49fsm2016985a.70.2025.05.08.08.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 08:02:22 -0700 (PDT)
Message-ID: <681cc77e.050a0220.379d7c.07de@mx.google.com>
Date: Thu, 08 May 2025 08:02:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0380482554608922709=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, en-wei.wu@canonical.com
Subject: RE: [v2] Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump handling
In-Reply-To: <20250508141520.440552-1-en-wei.wu@canonical.com>
References: <20250508141520.440552-1-en-wei.wu@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0380482554608922709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=960920

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      24.89 seconds
CheckAllWarning               PASS      27.12 seconds
CheckSparse                   PASS      31.11 seconds
BuildKernel32                 PASS      24.32 seconds
TestRunnerSetup               PASS      465.29 seconds
TestRunner_l2cap-tester       PASS      22.50 seconds
TestRunner_iso-tester         PASS      32.23 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      122.57 seconds
TestRunner_rfcomm-tester      PASS      9.24 seconds
TestRunner_sco-tester         PASS      13.45 seconds
TestRunner_ioctl-tester       PASS      8.52 seconds
TestRunner_mesh-tester        PASS      6.25 seconds
TestRunner_smp-tester         PASS      7.48 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.99 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.210 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.158 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.174 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0380482554608922709==--
