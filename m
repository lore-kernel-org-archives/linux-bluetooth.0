Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D12B17BA1
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 01:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734052997; cv=none; b=E+rqf5coRdR3bxeroK4nz0xely3WgImJNHm4geOWc3+h9Qgf9z8/irBOep/iVaNWbmvC/KkTWD2FvK667IZ2F/A8xThdeTehhR756+FjDPMwyxuznGwf06pJwoTYuey859O2MFpiV9t5WPvLIo9pjZtmh8+pKMqAvzIRarkprZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734052997; c=relaxed/simple;
	bh=jTvqFdObzI/Yk9Ne9kbJW7rZ8VMRqWkv/kUrQRbeWlU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ikmONAwpEb3MScJbB35PT5pV72gGnR5dt33IVRVabnXCD125IjmwIz8pJz9ObZ69wDFrZwXDCnKmmSY6ZtOvgi73sKaa1rvwIQam21+W7MWouhBeaFRVyO40PUobR4SQEiZwsVe2rYf80XWSiSFGyZB16SJfo7YJYCoX8ZsYBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqkXr2Kb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqkXr2Kb"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21683192bf9so12252875ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 17:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734052994; x=1734657794; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YCMqulXTbtECPECSnHIx3hcjz3gmlueepdP9a0GJafI=;
        b=ZqkXr2Kb1u7LIbQgwBJQs+t37wAyg3Bmm60xWg2CSMDTuvzubzvdlacvHErDR166ZP
         7c7UMN2EcPYD79f9+8/4bhbkk4sDu2LYZx8i/vwTyE2eNwoU+NDfuKRJE1O9uJncJFD5
         IXHpZ8Hjoo4UiO4ylRFltL//cfH613DOU8GSlSaMc2+Qk9KmdZbiVKhI2/l0Smdv+xAf
         FKEO4ixuE5GvnFgSWdUSYmr8i/h5n621pHcwNUb0hUEgaZvpz4ss4FI/i9aYAbnZgoFZ
         +vHoHTAm+GT8QWSusqm9fLLh3E+cZ4C6eEC+unUpKlH7ZSpwJ++K0qHQ9pvJYzwFMyYQ
         TCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734052994; x=1734657794;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCMqulXTbtECPECSnHIx3hcjz3gmlueepdP9a0GJafI=;
        b=kIbnoepvAWweAnRTx6tIAc5FXtckgexIqX85bZS7Ao0CHoQqZfWUmhsA47BDNUyxjT
         ++WwNsB8rU3B58dHvmGwKyTACYkoAPHkWxM5fdbvj2F2bSwWuCCOmKplYVFfaSHy61Jr
         k36ts1nC9gv1prnpEcS5KGIinZ3CGuDhDt8xDR0MvStzDDID7J3iPokSDbPT+ez1Si6x
         D71A5VwhZn8YLMKlxPkFZ8MurJGIS5nid8grJr5Yibb/2ak9AIzz6AUSUIuKCn4j+0Fg
         8YeidSat+XQ1wkxxaXfsmU+xK0pXsNhr6yfj7b+Gixde7w6efSgsABCy4Go+GRZaVQtW
         A2CQ==
X-Gm-Message-State: AOJu0YxMiQG4no6Uc2KI0PfB/lbrLHsRA7AEMzo6RSaqlFj+ZF1DinuF
	VUO0BD5Eco9+OkemsnJ+5u3MxgkmYzkPe1tegCRKbigk3QTRRMJSsEbebA==
X-Gm-Gg: ASbGncuC8cOnYIK9dUy4aHwvkI9ZW/gF2qy9Qe62yTYqJbFl/m2lkxQxoGU/7T3+Ey6
	lF9ir/1pbTQWbajo4xyJhYzxzUczIQgnubSdQq+x0//HnTnvbWgLeXCb11ISTh4DwH3YjTmy4aK
	Cwl3udUaP7at9SU8QbXjB63GQJ2S1DrhJEgi8Yxp26EZccSQkoh8o56NUF8xw/sbkrEvfuA/kYy
	Tyj27Ia97hB1M6b0dWm4/F5gGfoh9HcEW3WO71+ibMBlwz3AaCqR8Z5P3wZsA==
X-Google-Smtp-Source: AGHT+IEbZT3bhclyo+jF/mqSaKOuJeCj2vR/tV/84wLPZ+DCbyEdqfe42cj2/Svip/PSMnJueZbg2g==
X-Received: by 2002:a17:902:e74b:b0:216:527b:5413 with SMTP id d9443c01a7336-21892a01fbdmr11362115ad.26.1734052994405;
        Thu, 12 Dec 2024 17:23:14 -0800 (PST)
Received: from [172.17.0.2] ([52.234.36.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21626df6a86sm98851165ad.207.2024.12.12.17.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 17:23:13 -0800 (PST)
Message-ID: <675b8c81.170a0220.15730f.a485@mx.google.com>
Date: Thu, 12 Dec 2024 17:23:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3158739726026041873=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, git@doridian.net
Subject: RE: [Resend] Bluetooth: btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x
In-Reply-To: <b9a5c3cb-d3d4-4fae-8171-5b8c2ab9744a@app.fastmail.com>
References: <b9a5c3cb-d3d4-4fae-8171-5b8c2ab9744a@app.fastmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3158739726026041873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=917404

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.02 seconds
CheckAllWarning               PASS      28.02 seconds
CheckSparse                   PASS      31.37 seconds
BuildKernel32                 PASS      25.32 seconds
TestRunnerSetup               PASS      439.20 seconds
TestRunner_l2cap-tester       PASS      24.13 seconds
TestRunner_iso-tester         PASS      30.02 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        FAIL      123.24 seconds
TestRunner_rfcomm-tester      PASS      7.56 seconds
TestRunner_sco-tester         PASS      9.39 seconds
TestRunner_ioctl-tester       PASS      8.03 seconds
TestRunner_mesh-tester        PASS      5.98 seconds
TestRunner_smp-tester         PASS      6.95 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PENDING   0.78 seconds

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
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.172 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3158739726026041873==--
