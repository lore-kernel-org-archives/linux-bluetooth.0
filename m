Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C1519645C
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960374; cv=none; b=SxQUXd6BbwfG3IyTr6erVrPlWhHeUgJC0ST9sFr7iYbmbHriDcxA/sdrqQPbuXC99O06Iarwsm+s/kiHrjAS6WHa8i1cYc9JiYZkDSNOe5h4xygOhicfCKzKtoRubNDbXdKmmJlUpm4oZfcsi68oenTTF6/LJBRcBXq7vaehuZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960374; c=relaxed/simple;
	bh=IWu8o/cE2W7BPiVHay3poIesrTSGtaw/zTB/tB2Xnuk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HzL6wR+ITHyDpWbfGuQePYyUN6yZYeTKRCjqnc636i9y99VNvtxNJYJc0Tkupe8A4s67HjgoHzc1jBzGg1z7IYfWqPH95eK5VRSw8JKCEv6+TX8PYT52AjLqNaCtXYxEYTCONRk9HIaHxBQ49HwV5XJYumqGYnOHMvLHPMluDsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GK8IvuNm; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK8IvuNm"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467a1ee7ff2so83201cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 08:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736960370; x=1737565170; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=poEvv3/+3zCezi4q8adpm2JQyFopRsVlC3QX7jdmbyg=;
        b=GK8IvuNmGr2H0H1I0oMB0xNz3ezaLsxaDwMGzQPdc/B3riPHQsCHLRBXzRi4qx5Kjt
         sNFR63Lq+Rx4Qsd4H0e2WB3bK6BNyRR7IyoPfQm38I6Desau/EMB/BOJyAEX2zgjpjrx
         XbO5F6GORIuia6n/QvwLH6cZ23s8vfVvHbqUeIfrzZMGymUC77/XJqp60Ow3KbkUfzJL
         0nRMUNk15YhXEqlfxB27+drWNfDKG2SK6BuEYaBxqjT6bKTP+VhZeYeZlbrydIsQI2Sl
         FHinNO4282eZiiERSzSdXETzOchS5spJdeKcHNhAlJDpLYvKepkfaUTL4oh4c0nFcBlX
         roYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736960370; x=1737565170;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poEvv3/+3zCezi4q8adpm2JQyFopRsVlC3QX7jdmbyg=;
        b=hs0d3KJxTV6RUoX+d+Cb7vkcLLF4vnU+WAF7SrmU10kQBdbnd3lM8JfVIZ6vGJl9hn
         Y5VhgkIQew7XIQPsd/VrT3FPPrBAq/KXX/L4Tm+aSqMhOP3QyX9V/9Im+NKuaxi0Q2Tk
         dXoKv4M9cW1jNjt5ewlZxjIddqwZPtg3RXe1lSLIo2FAnZA94Ee15+l+ZAnUA2mX4J/z
         taKVfooej+APstv/EpAraqfHUIdchP6EiG2j+Q2lODt1HlVtOTk3ZDHRSp89rdH08a5Y
         AOENE2UpTID4GU86kAdpW4VeS3KAI9y6vqiK0Imq8hp1tnTRwpga9+Z4xkCfBGVj3rHv
         uioQ==
X-Gm-Message-State: AOJu0Yy0dqqjgCwUcp/hp1Df802pydQuvHvOmBA3Ta8BYjX4C+3nh/J2
	NvOpCjbt3oRCuhEiCAAUoUIebw1jQLY+/ROz9xbHhKeYGPIqjlzHjrSt+CCi
X-Gm-Gg: ASbGncuc2ucUGXPIk0GolPeY2MwnCFjGxyFVBWdnAGANPMBeAM8HbaYgmVeNB/o3cnt
	UY/FaLa7BF1j0CyS8QQ4HuzPojQVmntBiYFi1U8+WSi5WvJ5RKCb+W0YXaWD5cH6Uf7ytluGhDe
	/azIwFuOLJf0G6K4a2K0bobz4CDgIvLDP8E1ilHSHaQG0UZ5t1Lz6HDz9nAHAssK7iPL05M9fzC
	x/OLJiHpV9gI6/H6pwK/usOgmO7Vy+zjWwpgMHli/G9OQBY1IxMNWNDElkFexjSmQ==
X-Google-Smtp-Source: AGHT+IEoZdlmXjUYQ7t5/AWJ46ztqg2m+IbYX1Sjj2gbQGmUdu74i5/8sT/sBMZj5Cp2OwXuFhRUjw==
X-Received: by 2002:a05:622a:214:b0:467:5eb6:5153 with SMTP id d75a77b69052e-46c70ff77f9mr385345531cf.19.1736960370038;
        Wed, 15 Jan 2025 08:59:30 -0800 (PST)
Received: from [172.17.0.2] ([172.183.133.165])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873ce201sm66321561cf.55.2025.01.15.08.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 08:59:29 -0800 (PST)
Message-ID: <6787e971.c80a0220.29185a.9bb3@mx.google.com>
Date: Wed, 15 Jan 2025 08:59:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0853466387175988330=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kees@kernel.org
Subject: RE: net: Convert proto_ops::getname to sockaddr_storage
In-Reply-To: <20241217023417.work.145-kees@kernel.org>
References: <20241217023417.work.145-kees@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0853466387175988330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=918455

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 FAIL      0.43 seconds
BuildKernel                   PASS      25.32 seconds
CheckAllWarning               PASS      27.13 seconds
CheckSparse                   WARNING   30.30 seconds
BuildKernel32                 PASS      25.53 seconds
TestRunnerSetup               PASS      443.82 seconds
TestRunner_l2cap-tester       PASS      21.15 seconds
TestRunner_iso-tester         PASS      39.91 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      119.42 seconds
TestRunner_rfcomm-tester      PASS      7.62 seconds
TestRunner_sco-tester         PASS      9.29 seconds
TestRunner_ioctl-tester       PASS      8.03 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      7.03 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PENDING   0.49 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.146 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.165 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.186 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0853466387175988330==--
