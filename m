Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828EE1547D2
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743411835; cv=none; b=cH/ZAwjrlmOa5aav5lYzCfABcEqYk6sIF2pAjv+SvZxJp2aucia09grgOUIOJczM4i+9ItkdIirt7vHzFMYd5ceTmbQUg3sGjWajhti8pfxRLTODQenyOdY+HpfR1TeFNaFA/KIposniYa+zwjwHpRAaz26wQk+ZioJlT1tHZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743411835; c=relaxed/simple;
	bh=8vfz3jrR8VPVhQ+NHA5ByhUUwSiQS35O6XFfiMFBYQ8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Xt2xyQPOJBKEDTZRs4/vKJQWQAR9MUc+AUmIlxEqrKBHuvOGaAGXgv0hKXEvQx6zlKnkF7xu7YgQ/fMihzMwIDMUghciWHftEIpDdTVFSF11IjXeCOKd5qdgERPWzkOJqww9/4jl9w1YdPEM2xzgIH42dsFPHFHc3SctSjpQTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgU2tzZ0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgU2tzZ0"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-227a8cdd241so45622305ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 02:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743411833; x=1744016633; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KtcGRiQ9oEekL3oiqhhfwGWCIKmbRkBODw5FAFNe/L4=;
        b=CgU2tzZ07xGlQ8nOpRge9l7JoQYOJpQE6ZXMtwie38l1YYmaHhou1LCOERe9e2oFjx
         pCBORyIkfV6Igl6A9an6PZsg0s+yutJc8W8IgBp5XYBWeh+6syx/w4oPoPjsDmrrndU5
         iO+1Pc34dGyiTSuuGzBC7luvTu8OAV+KTGVRWfSa7tcyPzggNu1y6i17rQRWiPCLvDPF
         R/0SokhIrI3vULezvNarDU80o/tdiVuefy5wwXxMbwEoVeiAHIZ7f4h8HIVe1hoWDAos
         Z4OxdN9nl9qQysXW/pc1h9unsT1hQ08LhWcb+toTys6zYhU+VX+ZaRopzPh//xZyk91S
         j4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743411833; x=1744016633;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KtcGRiQ9oEekL3oiqhhfwGWCIKmbRkBODw5FAFNe/L4=;
        b=rm+1yESoKfJko/SlAxkfMRmFMWBjiZPGKlMwju2TqEnHusbuc6qItCvUir3FKz83uL
         9Cbg7M0u2cNHpx4ZXReS66uRsbdpY8tEr/htNWPkauUjCkPXJumH3ZzguOTzSrqXQm2k
         6NnVQ1R/yCuem/qa3Nwp2DaOFWi1mY8zvcyPlpxwfCr6JSgY8WULxVuEZ/fhYzx8BUoj
         3nnjoWXeQEigYwJw/bXo90GVOV8qjYw8rMmDSYHTnvrGEI8WeM4ZmAaDuKQNpRrn1Jm6
         fuzOl3DFhG2hr0KH7gVPA190oITBdyvJSkYiiV6hFHEGmKpRwpMCOYEpLAe7y6oj/BAi
         azcw==
X-Gm-Message-State: AOJu0YwCkMsUNnbjj6tGK4Ivc26rDFS4Bue7TRq2pojwqVvC0onXkb1N
	fPakIgaenPJAgrwrTFPx2K0eB8KJKMfnk+PzY3j5wjBGU2cYROkraYcwCw==
X-Gm-Gg: ASbGncvzrVS56ji6N7HSWelg5fDo8SeeHuwlOyhIUA96yZB1PCQUGeEQON/SSEU0CAY
	CMtfg359tYu3LZSGWtEvqELS3LIIRraXk6hIuHONhJlCG0uCUSfzlFeq6UsDkFVvfpoqk/1XTTA
	2b0XCUCISrjIpdqfq4hQD3I9DkrG0R3INakv4ssPbJ76EB85pO37u594DAoKqkOwqJ0iKaFkOMR
	RCeSPb7quQmqWsEH9oYpKGfSdsLmjFgv5wxVzJvGGct7y0yTlR+RZXF2J9d5d8CIpQGOnq4fPId
	3hBoMGs1fFfJfUgP7ZunGRvUCW7oYymCaUma0MpZiekIPR4zh/w=
X-Google-Smtp-Source: AGHT+IHHIJ8Ik0gQcx2YhMoyIRB8G0H79k5s5BQT4OcyuEiuvZT/DsMcGP0KJw5sMOAQeEh5pZxY4w==
X-Received: by 2002:a05:6a00:4b05:b0:736:4830:68a6 with SMTP id d2e1a72fcca58-739803359e7mr13757083b3a.4.1743411833421;
        Mon, 31 Mar 2025 02:03:53 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.38.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e27183sm6721024b3a.63.2025.03.31.02.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 02:03:53 -0700 (PDT)
Message-ID: <67ea5a79.050a0220.264666.4c7b@mx.google.com>
Date: Mon, 31 Mar 2025 02:03:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5297378922226761144=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: Bluetooth: btusb: Reset altsetting when no SCO connection
In-Reply-To: <20250331083523.1132457-1-chharry@google.com>
References: <20250331083523.1132457-1-chharry@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5297378922226761144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=948479

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.41 seconds
CheckAllWarning               PASS      27.01 seconds
CheckSparse                   PASS      30.02 seconds
BuildKernel32                 PASS      24.00 seconds
TestRunnerSetup               PASS      430.44 seconds
TestRunner_l2cap-tester       PASS      21.06 seconds
TestRunner_iso-tester         PASS      39.22 seconds
TestRunner_bnep-tester        PASS      4.67 seconds
TestRunner_mgmt-tester        FAIL      120.34 seconds
TestRunner_rfcomm-tester      PASS      7.93 seconds
TestRunner_sco-tester         PASS      12.67 seconds
TestRunner_ioctl-tester       PASS      8.37 seconds
TestRunner_mesh-tester        PASS      6.54 seconds
TestRunner_smp-tester         PASS      7.25 seconds
TestRunner_userchan-tester    PASS      5.23 seconds
IncrementalBuild              PENDING   0.77 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.146 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.194 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5297378922226761144==--
