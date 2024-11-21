Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76931581F3
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210294; cv=none; b=Hdtu4i6EHu/0vSBNul//Qmk6S5QAJV3C2qvdvKUMxa39h6LfsyH/PoE1DEZcXXb48tP0o/U2O2kG8x8OmFUUJDYw7Tbz1HDkq+CGqn78Wn5fDgqvxcmb18OHFXAYV0O/dtH2STPY1cJxG1gJcoezngw2pQ/1a4BmCIr82Ud3tOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210294; c=relaxed/simple;
	bh=MI+8RiOZuu65bSH8Kvxlq6jfPPpi6JmXbbW/6X2tgNY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ftvqIp9sGzkDq3GnkB8M9aZebjJ8Dyi/Xtvz0r0Gb1LDI7h6bJk+KWA7gViwOdB2oPKzQcU9UthZR7lsyyfYcZ7CuUAKauLQq6+Eio+CsT2csfXDWQVChxCIpdXQdn45ZAc0cqJg7xiZY1oUidx3YtXiYP70o1MvrtwCFixWOSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcNCDpYH; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcNCDpYH"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b1488fde46so79173985a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 09:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732210291; x=1732815091; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TbsKoEytzvvRSvd6TbTxU6T0x9a4ONYsLyTymwrpiu0=;
        b=IcNCDpYHEto4fZGDITVpX3zZ86Qcy3rC5FBqPtcTwWpeeFQC6FnE2kCuKTGcfg0Y0D
         N4o4Lm4J3Chw/M08ujk/iyiERq5hbMzTlnMHi0n4YqPkDr8ynTz9AtTXPFeEY6c8iw71
         RikZ+mCr6WhTmcomHFh3e3F+OpdH7Hrw13T20WTAYzcvyYeGQBkz7e8jfoTsfFBcO04J
         GSkdTSS4IbxuQZ8j7s94CCjdO+xi+S1nE4X1AOM57GlDe5zvcxK5uzPATYJwJdwUQIUo
         OlBm+cvb8C7JidvnvcZHfOoKiKozfVlCBM7JEqKRqmaOcEWhh8IOhOypzHmq1oFfAkbx
         CqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732210291; x=1732815091;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbsKoEytzvvRSvd6TbTxU6T0x9a4ONYsLyTymwrpiu0=;
        b=GxnitpJCEjXHhxwq/RhBadcPdwnv4NC19hglcV7LXKeyZzvk7TUixA9mK+PuNRgcJt
         fwJ3rocv6zHnVZK3m0dwSuBr2SYxTJOlAHnPa80UEpHzL7heTriOgCgxjsqO0BNSRWrL
         dClSJcRHlw16arkPl4ATv9Kn45JTYaOTncGujTQ4LAhzqckX4oPiued2nQVEK+IUfDCj
         xB5EK1ckI674xvLpayM6ghGPAG4URgYxpjn53oZnfDz+wLot4VyNB6jOSYcLTVOC1xqv
         Yogm5qTTF5qWOD0LkQWtexAucsQziTclpfuDe8tlN4lLhWb4mAmManPPlrt0gmBbJAc/
         X2mA==
X-Gm-Message-State: AOJu0YzoC0pmYE2owlqr/dEV+f78T+v+dZr0AKoJG2psJvUW4q8BY5Mo
	r1ikPI2xs//QRFc5kA7kwfC7AsSTYMfVq0r0rSXm/BiHEy/vspgBw1IqMg==
X-Gm-Gg: ASbGncsxKmvH8bb1D4+Umz6T4RXhgwPkDq55HmW7VIf/ThMBUb5Krt+gSK63lg1WpnO
	LU0QHpLl6VRfGiU10tX81U9hMFimqmqDmQ9LsUYI1qZ3g+EhXrgBshozkudbwE4256wU3rOar+V
	J1NLWincaoSa7b7CHInLQs/jDHSZzdOqbNsLN5qFov1gM9g7GksuPrdjMdqX5Ex815205GqJ7Ch
	qcZAjvuEBAlXv9iDjJ2pPj6yF9VZHchRQ+zdgsVrsWUCImomooIsA8i
X-Google-Smtp-Source: AGHT+IFKhJDRvQuwfx3paeuS4hsCci1DD4W0DQzNvj1qnnIs9RYW+LYP48lRWpV9RepV8IyhguVmkA==
X-Received: by 2002:a05:6214:767:b0:6d4:25c4:e763 with SMTP id 6a1803df08f44-6d450e6d997mr372906d6.5.1732210291292;
        Thu, 21 Nov 2024 09:31:31 -0800 (PST)
Received: from [172.17.0.2] ([20.161.78.237])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4380b2d5esm26104006d6.1.2024.11.21.09.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 09:31:30 -0800 (PST)
Message-ID: <673f6e72.050a0220.11b9ef.7eed@mx.google.com>
Date: Thu, 21 Nov 2024 09:31:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6856109356335807639=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: MGMT: Fix possible deadlocks
In-Reply-To: <20241121164335.3848135-1-luiz.dentz@gmail.com>
References: <20241121164335.3848135-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6856109356335807639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=911554

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.95 seconds
CheckAllWarning               PASS      27.42 seconds
CheckSparse                   PASS      30.87 seconds
BuildKernel32                 PASS      25.79 seconds
TestRunnerSetup               PASS      444.05 seconds
TestRunner_l2cap-tester       PASS      22.55 seconds
TestRunner_iso-tester         FAIL      30.68 seconds
TestRunner_bnep-tester        PASS      5.06 seconds
TestRunner_mgmt-tester        FAIL      121.90 seconds
TestRunner_rfcomm-tester      PASS      7.63 seconds
TestRunner_sco-tester         PASS      13.49 seconds
TestRunner_ioctl-tester       PASS      8.14 seconds
TestRunner_mesh-tester        PASS      6.62 seconds
TestRunner_smp-tester         PASS      6.98 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.96 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.177 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6856109356335807639==--
