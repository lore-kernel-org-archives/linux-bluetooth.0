Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE671770E2
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Feb 2025 05:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740202285; cv=none; b=sR/YiBx1AMFdgXY3WtSX1qhT576yfA+nDpTWKBa0NwUkew5Lsql5dYERTUmimASSsawVPCJ8TobUncL6+FjyyuG3CTNXkBBrmLEpEdmsqfXmDtcyHolrEvSAI6dSZo4CsVDpsCZqKJpLsSZ/uCRErDI6CZgCZIM67R33O7EFXKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740202285; c=relaxed/simple;
	bh=8pb5EHYBbjO6tXRlUQcqPBZ9YJ7elfkiI9+a04+hhrc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FhPcuLNRdsr2856AnK5NlFk8XBr1SBko4ur10EP4fTyC3P8TyasMgt2QpQbLnUU+e+sNi7iM3hxDbepnKJenw3moLHL5fu32j0kYojqsRKsRgKQxvlxso3vJgD9Vj4UBNZ+nAukbZI6C1jkyV85/TSfwae4pi/jGajN/E5ERDG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QImcNn8d; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QImcNn8d"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c0893f9aa6so257059585a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 21:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740202282; x=1740807082; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A+zD5fr9TWcidlM0kVAIMPTUC1WtFKuuL3HEoN8/AOo=;
        b=QImcNn8dFCCMYAD+V2Pgp1SdfLM7W0wrTwSicO3fZDdIBWfFJdQsSih/5GJz4Zqjqx
         pXP8fDdYXbmNIjjvFhvw9zLLJKLYJm6JCnGm6y7S3rDZyvLltjmv0eIqJiSutnVPjdBr
         ow0D0GpeBcWXFr8BjFw89YpPMuAKrhsQMtyitCYDse18WKCadd5QdjZu7HRxcU8FmA8A
         XOAr4R31u6jWYdz+IW9JU42BCuvNX1rhC9QlFWTovGxQAWz/9TUb1N9ebxYjw7yd4Jjq
         j6XSZfXpxHni0ElGkcmB2GkSOSvpsPVP1unj7h0jGahdABLDlindJzNqazyrYNuW9d8X
         cCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740202282; x=1740807082;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+zD5fr9TWcidlM0kVAIMPTUC1WtFKuuL3HEoN8/AOo=;
        b=vYJhXdy6mlvy8O1+tfDSgYXtJUU78hnFPGOjOA1i9terDemUB1J+Hw6fuJomwEQKTj
         GLPZMJHgG30DtQhcOhXfVp9V4QQylsX0V6oNhcw+Fcy3Y83kzgut2gxgRTL3jdDBAWhr
         rxlE40UxtooESqxDDufj4QrJCOQDk/kliFziq4LVzN5eXIR+qpi5QlmLNfSIzlM9ipO8
         bf4aXdkuCkr/8usdMjF3t8q8ITBoX7Dt8XeddHzH62nybZYZr6dqV4i+0XWdqvyFxRul
         dJc+sUcw0M9gRUTW6HcyLq5OwpPExUFMet2m2VDeGKOECcU2uXpgJd31dYJi7yWCIAZT
         5Y7Q==
X-Gm-Message-State: AOJu0YwXdX16YfnzEqJALJCI427wzxjLtJ6rz5Cr1puorZflVKuc0+4z
	jiZWKeqHfpCo4EMXdV+brEcKerD/8irXjegBslVijZkDnV5QtLZXbigC3Q==
X-Gm-Gg: ASbGncug0PpjEW1B+r+ua7s6+MDizvSOD3C+rvTT6bbxW8twZ356kQT6vL/krIcQqMf
	zsOip5Dx9Ql45OoCZ+lb3sBCM6LXxoLvEUECPTCV2VjIMo6nRPOJdcYzX7ayQ3jVKNf0DRr1rJd
	WeAjzCDJy2xWrg9m2NEdAD6opywuU/0kulGt4nC4FEHnEM8CAlMo5V4ss7OteyydAaYV2iijLZ9
	0IQ0N4j227cxvcBHpWFjySGhJOqTrLXRA8eMPvC0PxYMQWnc9bIQfo4GXcKyOtGdHLekzCMs5hb
	bF9nRKJNaq0VlyZEO88uD6R2ZB0IHRl8
X-Google-Smtp-Source: AGHT+IFGhF4vSB90PFcuJVUPNy1O6GLx5ycx5uzl/9JQPpUj4f9/EoK9xvKxASXpCOqOBjzHm585zw==
X-Received: by 2002:a05:620a:4548:b0:7c0:ac69:c62f with SMTP id af79cd13be357-7c0cf96dabemr942324285a.53.1740202282438;
        Fri, 21 Feb 2025 21:31:22 -0800 (PST)
Received: from [172.17.0.2] ([20.25.192.135])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a39c5213sm644188385a.87.2025.02.21.21.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 21:31:21 -0800 (PST)
Message-ID: <67b96129.050a0220.164588.e302@mx.google.com>
Date: Fri, 21 Feb 2025 21:31:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2704399204582013218=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nishiyama.pedro@gmail.com
Subject: RE: [v2,1/2] Bluetooth: Add new quirks for fake Bluetooth dongles
In-Reply-To: <20250222050439.1494-1-nishiyama.pedro@gmail.com>
References: <20250222050439.1494-1-nishiyama.pedro@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2704399204582013218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=936668

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.16 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      24.35 seconds
CheckAllWarning               PASS      26.54 seconds
CheckSparse                   PASS      29.96 seconds
BuildKernel32                 PASS      23.91 seconds
TestRunnerSetup               PASS      429.56 seconds
TestRunner_l2cap-tester       PASS      21.38 seconds
TestRunner_iso-tester         PASS      37.91 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        FAIL      123.99 seconds
TestRunner_rfcomm-tester      PASS      7.81 seconds
TestRunner_sco-tester         PASS      9.70 seconds
TestRunner_ioctl-tester       PASS      8.38 seconds
TestRunner_mesh-tester        FAIL      6.35 seconds
TestRunner_smp-tester         PASS      7.35 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PENDING   0.51 seconds

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
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.174 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.124 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2704399204582013218==--
