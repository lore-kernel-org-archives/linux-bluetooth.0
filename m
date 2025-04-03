Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6C125DB05
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Apr 2025 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707039; cv=none; b=I38vj2Cd5E/ibLWJMC5IXVxG6RPdTJBeRGl8ZLvDPCSJB/RT3/HS/lIje8r0hNjmJ+Vmscpn9qkrxdiRed3sy2M1EaxASVQUq7ICYTx7VYlDl6i5Yf9h2Pm5aomPP0q7Fur3CAfRWkhGoYoTTuQznRzXMGOQUAzpngbwG8DhsOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707039; c=relaxed/simple;
	bh=pnwzMuWgvKPa0aXlvsE2igktDcp1eZe89RVDGLBkt9U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fHU6ZkZEDY50DpdbLmjUjQWI5K/VykjQqoHwT8iGtgCOC2YRivzlpGZ4SHHCkQbupXHDLkM+kKPpGHpon6eYJ5Bi22SxvjkKshKgOa3MqnVS8y/aIOymHUnJOT6ZrRwf7ibqviunugVXo4y4n7j7PjwTaopaBk7RIV3gQBTKN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiLDFHCy; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiLDFHCy"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e900a7ce55so17375996d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Apr 2025 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743707036; x=1744311836; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pLbgKgZfzJuogSaUoLiKzYkJq5CUOcSgUy/sxVHqOyI=;
        b=BiLDFHCy+G9Q3Pee1te5ibsAb8SasZP7iaSTovD07tqOuVMibNo31r2CnUOjoRGEiW
         Qy/QTL5x4k9Vdiip4N4N9r1fqpg7mL/8Pq8BoSJJIBCVoKUEw/iHH0Q0agmsqnEq+tSe
         qKnjuw/Gp3ZLap/baEv9CwE3Hg8UHmnI0G/4SXO4qiKBrruijzXjihgy80DXe5W1h8tS
         DuwwQnoYKGUwdTATfcgPag/CDeUvK00KbYhpXluRZcnefoFtMBY8d0IB8ZIibau+WYOX
         l4/D5hpfyvVMMWq0ooITR5GJMkbkl1MfV8mZcWaeJ747xQL08wPvHluU5+knklVv21YJ
         qXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743707036; x=1744311836;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLbgKgZfzJuogSaUoLiKzYkJq5CUOcSgUy/sxVHqOyI=;
        b=OdujuZSCJ2gHhTrKSxMxvor6ZQae1Tft7XTofLSbcu5uDTgToA9f7JFXquz4RvrHP2
         DRcCooHT/anofq2SxG1gW5oq1JbFlObJD4N/eryVD/8wrjcgoAYLlOOdRaC9bsR4KQL0
         Njl8iYIBrz0aqyyRdgbdQ/8Cv66jujhPst+cow5FBbJbM9CJjnE4+8RAOluqcP+puzyC
         yCgmXZtndss2iwmDseryciIveY+6+t83ckaoggOOmpjiD1OjJ8wfxWBHMVj0MUaVs0Dh
         4cr2ePoZSyykO1BP6Yc0ukdXUyh/LmTZaNHjtt4AroExl3ILN8zwFVBl1JO97QrZ1pxZ
         PDbw==
X-Gm-Message-State: AOJu0YxdZap1wYMwpn9s7vYTogO6SC9AcLMmzvsIZR5uDSyuXtBwRdMh
	AWly6mNdGKIjem0xYgvur8aDV2Vaj8PAfNVuT9aXQ6C4DExtiI2AE3S14w==
X-Gm-Gg: ASbGncvm4wUR33S/SFIOIijTFvGo9f6bhJ5iVf/E1nfbE/JpBWZjjV9IbdXXK0S98SH
	15uVsSiCr92nhFJuYy+UT6W7c67Ux8RCNKs9Ror/HkKQWIWJR7T1DLdkX8sOalmPkeKENJHa9aM
	o5+HKN+Zo3TH84GRFe5lqIF545nEQpFtvxNP+AKiu+tUenfjdhuYZ1LX2ET+f+umV2PwF7Z/9RG
	omGZQVD1LdZSC8q5CJD/GiEO33cGHuKvPdMC13oqnqGEcdSaZtRkISFbLYl8ccYhqQPPKQHwASL
	WeqiQHE/QRE2g/XKMlvySF9NGfWwVAWkSRYdOjlbpbS+dgwsFQ==
X-Google-Smtp-Source: AGHT+IH8vmLbxoQlgnqiMhxSD22o822MCHKRl5T0s5mHzHDBYZjA93D2oc62oqH7o1NIrKKmEZk+Qg==
X-Received: by 2002:a05:6214:b64:b0:6e4:41b3:497e with SMTP id 6a1803df08f44-6f01e79133dmr5254216d6.40.1743707035961;
        Thu, 03 Apr 2025 12:03:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.193.39])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f047aa7sm10860956d6.55.2025.04.03.12.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 12:03:55 -0700 (PDT)
Message-ID: <67eedb9b.0c0a0220.4e0bb.4480@mx.google.com>
Date: Thu, 03 Apr 2025 12:03:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5822260941887394075=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Revert baudrate change in nxp_shutdown
In-Reply-To: <20250403150223.4136-2-neeraj.sanjaykale@nxp.com>
References: <20250403150223.4136-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5822260941887394075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=949649

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.15 seconds
CheckAllWarning               PASS      26.67 seconds
CheckSparse                   PASS      30.21 seconds
BuildKernel32                 PASS      24.38 seconds
TestRunnerSetup               PASS      436.55 seconds
TestRunner_l2cap-tester       PASS      21.31 seconds
TestRunner_iso-tester         PASS      32.67 seconds
TestRunner_bnep-tester        PASS      4.66 seconds
TestRunner_mgmt-tester        FAIL      117.89 seconds
TestRunner_rfcomm-tester      PASS      7.75 seconds
TestRunner_sco-tester         PASS      12.46 seconds
TestRunner_ioctl-tester       PASS      8.21 seconds
TestRunner_mesh-tester        PASS      5.97 seconds
TestRunner_smp-tester         PASS      7.16 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PENDING   0.87 seconds

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
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.183 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.150 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.179 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.138 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5822260941887394075==--
