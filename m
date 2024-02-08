Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1794A41A88
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Feb 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402768; cv=none; b=fc6fp4u9XaoeRLUzLHOshhkZacfjg0Xq4uvX7yDocZhFtQcldVUhVFQSzJtPkXU3ccrRAl6LkbegYWZ8WrfGqOv99vYc0/mErZoKUlyjjlPFq+ke+luML78/ruCWFRld5pa0etXQXWiJSsME1LvBK303ZG1w00BSzvrXYerYTQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402768; c=relaxed/simple;
	bh=33l4XVQpru+/f20/I7aIeQNSWGaRdmj6BC/z7LZSBfQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fyRIO6uB7kSGI4iBUQGrlSPIPyJ3rE2H3RPS+QTYwKu4m1aFdgWHndVE/+Lnzusp6CnWxFYpahQR6p5lUMVBFZ9ke9kAFttvlD9vnDAIRRDyiVy2vYbAnvqj0eFNUEA5iZPJSP0uHjGUsLCAVfEs/6pKTGylY17ijlZGPhelZ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBzi0lHN; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBzi0lHN"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42c3a75c172so12350671cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Feb 2024 06:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707402765; x=1708007565; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yu1B065LnSH3zszlTnvwy1dNF8zbJTTMS3WkI0W8WwQ=;
        b=hBzi0lHNqgGo3r2gDKV52Vi2W21p0vFrmcpCd3WcS1lybdW8wkhyEVKzXl7uXnybgD
         uDE+5qIP3mdqfQW4+G/JyS4CoCA9hEGc35NMSJ/SmraCL4bFX5Rrao4ZZB+CggWMRBXa
         amWypZfTBK3gg49QqHLTsxy6mws9FNq0gUWkXaNF5Wnofcdt15QiysSFI852+XOrgWDx
         jtlhwZYyv1VmRDs5sJN2y/oJ2Nshduoi4pTbOxpNin1DJ0pf2wMGUITmX6aVWShM+p77
         1A24vQyYZnAC4giNrAp4HdXDN8+fAVzyDUmJWJeLkLifOLCqbG09kdW0hvUo6q5wb8JR
         6S6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707402765; x=1708007565;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yu1B065LnSH3zszlTnvwy1dNF8zbJTTMS3WkI0W8WwQ=;
        b=lTzOHyxnxHTo1pifYFEqtNJ9fflvbbGDl0W4LMnVaDf4VXSigwOyH+Hjikd/NArugg
         GCniodu4cIc/2cYcPvb7PF1wqwAAmvgnP+Yx0TGJxjndSH6Kg5uStOvR3nORAu1DAQ46
         4EHiv+j/LtEMNN58ReZWnm35tH04xBAdYByDRt5u/nb+wHegmTXTT0BUNDkq/KSDifOO
         telfc8gtWwv2IuVAELbZqrzzTcGVzvYi7nqANdCfnR8UWPriEgO2ktjiHXIPPjOY7cp2
         IIL38iULKi/yMSIAnVb0ylMt6s4sO3rCgMb2gTjYNDhQ5tZ9L0YwiMjVQ4RuYftp0+X3
         Maug==
X-Gm-Message-State: AOJu0YxCyP61wzxseOn0DSuSueqUK3RjdPRgYvZdIPyavl7tHSUL1yHN
	9QEnUs3tvoA3WLC7DiRwGdIQTW09UGXI9CpFEYxGSxymn4STTldsfguOO2DN
X-Google-Smtp-Source: AGHT+IFs/EgOQUzDVzZ3B4GIlYZQ5tzgfxjb+91O4X51bICgvEcMIB83dUP7BE/XVoAvwQsdeJDdDw==
X-Received: by 2002:ac8:4746:0:b0:42c:41ef:89bd with SMTP id k6-20020ac84746000000b0042c41ef89bdmr5044959qtp.35.1707402764715;
        Thu, 08 Feb 2024 06:32:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqgiT1ST3ZI6s6lMyG0fB58005pgXrbWiyeZU0eq19akYdW470SYULgdQYeUR1CV8V4JIG3477Y9B0sB0Id0tjej140w==
Received: from [172.17.0.2] ([20.81.159.94])
        by smtp.gmail.com with ESMTPSA id p21-20020ac84095000000b0042c3843af8fsm45201qtl.19.2024.02.08.06.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 06:32:44 -0800 (PST)
Message-ID: <65c4e60c.c80a0220.3cdfe.0746@mx.google.com>
Date: Thu, 08 Feb 2024 06:32:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1450609184902772362=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: hci_conn: Always use sk_timeo as conn_timeout
In-Reply-To: <20240208140240.3249372-1-luiz.dentz@gmail.com>
References: <20240208140240.3249372-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1450609184902772362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=824332

---Test result---

Test Summary:
CheckPatch                    PASS      2.15 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.80 seconds
CheckAllWarning               PASS      30.63 seconds
CheckSparse                   WARNING   36.39 seconds
CheckSmatch                   WARNING   98.73 seconds
BuildKernel32                 PASS      26.92 seconds
TestRunnerSetup               PASS      496.73 seconds
TestRunner_l2cap-tester       PASS      18.19 seconds
TestRunner_iso-tester         PASS      34.46 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        FAIL      167.45 seconds
TestRunner_rfcomm-tester      PASS      7.38 seconds
TestRunner_sco-tester         PASS      15.02 seconds
TestRunner_ioctl-tester       PASS      7.87 seconds
TestRunner_mesh-tester        PASS      7.10 seconds
TestRunner_smp-tester         PASS      6.88 seconds
TestRunner_userchan-tester    PASS      5.04 seconds
IncrementalBuild              PASS      26.40 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 4, Not Run: 1

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.115 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.143 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.147 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.427 seconds


---
Regards,
Linux Bluetooth


--===============1450609184902772362==--
