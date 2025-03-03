Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0304D20D515
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002864; cv=none; b=eqS/KIKBu5wmqkFz/FXF6bwAqI22awc6QunAkO9sAc3WNheVNrt3/LsakamH7K6r9yRobSzY7Vg9qoJGrRTz3g753TyVKDT7ohVtiyYTCA6n01eD6a/sX6SL++mF4D1OtN/KD2kf/5DRVb4ZnMovDA7ylrKwy45sAnOPX/lWOy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002864; c=relaxed/simple;
	bh=wR86jT412eSL9S1YP65gH7CWeDRbnNPUMQokslfgG78=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U0iHNXJV9UPps4FSZSn+xm9vHAnMLK6XifmJGikLcS37kZzbDAPfrtAvoFNqmBa+XMLI5K8WqdyvoG1tFmv/s7QGqyTk4Qh8Va60mtZ5wwsfNLmCl27Ivyi+gSgN6tYWrWEnrU96ySaCPRzmhhs6hySiAUh+CqiQ/O5G30hAqBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtOiIqHC; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtOiIqHC"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e891e447dcso49419956d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 03:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741002861; x=1741607661; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e5kx+1+QXDb3BMtpcIwtNDIRX4xA6H/Oii54/sZD/gE=;
        b=WtOiIqHCkt7IU4wFFnWHyzzgp3K4q00Hz8OyziIwWoll3QFmRf/gfCH0EA4u+Al53Q
         azbNV9dYDpMMj9iHXHWSiY46HnuELWqPzwzaGrOchMWqC/OvezB/DBAONlyruIVAA3Ss
         khIaRlRO9C6g9N+dfKsYUDesPpzr8TPwoJRxRHoKdrPzbzQN/KafGpHefspTNGMcXcNe
         xL04mB81tG9eWLchKkup/fdzvINLdon2Q0CBp6Seaao9yNu+gCnnHVj5lHJGRZ53S33B
         ddgYFLyT6XPqamsb7EHg1aCWRv3lkdxB6Gt1A2km+GxMsj67ppdLu8jwGhYtiEC1ELeY
         vP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002861; x=1741607661;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5kx+1+QXDb3BMtpcIwtNDIRX4xA6H/Oii54/sZD/gE=;
        b=jAozpIBJTQ7cfmxaG0RVpxo2xHwTLTp/9HCmBtAqi2dvKV9mcc8kCbmzNd9Jui5+WK
         TAj5HvmaGb3CUMR23uixYB7JuHElqmFu5qiN5hje9j6v1xPUyzgFZ/rGhIyrzFxnqu/P
         iF8Q1/6yd1QpPjAU8g+XO/nehnm36oKMtixp7KnOYtWnGGJzNsMpgYioTlRYqhCUUIWH
         /0RjGqpW2IORo9yzRpk+DVsjpij+aSqSttiku4B9JBknkhjj0A7O/3zkB5xisowSOW4e
         FTcPWfRW/eBik4L5ijZIC/jYMgR/Ica/tG1gFPKVVx7qGyoqgv4nG8mj18liqH3CdP6Y
         qoiA==
X-Gm-Message-State: AOJu0YyTZY7m2ps0xI99K5zSOPN0cicYa7D+N1FcbAx9RJDA9BjA2cBN
	xnzIFMCg5GF3bZPd4jUDHVngJhkoAUhbwe6W5o5Bp3ET5smLfFQOzrQPVg==
X-Gm-Gg: ASbGncutiD36lijDZkw/1a+FnOsBbBIHq/y96TzipsWxe/brbgUt8LGbLBykCti3zN8
	0PeTx8OzuR5AbxdgPf4VSXzc93z+IDkYB/5KyNHF9GOZv+ZyaTxmgMabok6Bi6DFVJXrKNay2T9
	27RIkk43Om3edpRl90mkDgW8oamGU3TgFlWeCZF7vTBZOnrpX0onGofCFf+xcfBsr0H2vrSk1td
	ULGav3/OiDaZ8u4cbxvOFOOi7u7TzXHDds0pD9PvjD7V1eyRLuI+A82VN8c8G15qk5eIQ4V0H9Y
	eNFm0Lb0r7DKMC3JSTajbDV+HTzoUtBH5BAV5rZ4FdwTQre7h3o=
X-Google-Smtp-Source: AGHT+IFBzhr00FvTDHPTIvcpHYW1ORooJDRhnjVn/+gmuRJmOHNrsnbmjn6/+VX8fX9pVOrRseGtPg==
X-Received: by 2002:a05:6214:2584:b0:6e6:591b:fa61 with SMTP id 6a1803df08f44-6e8a0c8019cmr211919996d6.7.1741002861619;
        Mon, 03 Mar 2025 03:54:21 -0800 (PST)
Received: from [172.17.0.2] ([172.183.221.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976608e7sm52144966d6.51.2025.03.03.03.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:54:21 -0800 (PST)
Message-ID: <67c5986d.d40a0220.14b90.17a6@mx.google.com>
Date: Mon, 03 Mar 2025 03:54:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5574385559365306744=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v7,1/2] dt-bindings: net: bluetooth: nxp: Add support to set BD address
In-Reply-To: <20250303112752.7292-1-neeraj.sanjaykale@nxp.com>
References: <20250303112752.7292-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5574385559365306744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=939557

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 FAIL      0.38 seconds
BuildKernel                   PASS      24.20 seconds
CheckAllWarning               PASS      27.21 seconds
CheckSparse                   PASS      30.89 seconds
BuildKernel32                 PASS      24.14 seconds
TestRunnerSetup               PASS      431.75 seconds
TestRunner_l2cap-tester       PASS      21.07 seconds
TestRunner_iso-tester         PASS      31.95 seconds
TestRunner_bnep-tester        PASS      4.65 seconds
TestRunner_mgmt-tester        FAIL      120.99 seconds
TestRunner_rfcomm-tester      PASS      7.84 seconds
TestRunner_sco-tester         PASS      11.77 seconds
TestRunner_ioctl-tester       PASS      8.19 seconds
TestRunner_mesh-tester        PASS      6.06 seconds
TestRunner_smp-tester         PASS      7.09 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PENDING   0.84 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.147 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5574385559365306744==--
