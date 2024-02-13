Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B7D1E501
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834787; cv=none; b=XtZKQHA0xHlMNN09+/0uTmMAKpC0TW99A5eHmBAMTY7slcaG3snwtpwOfsARZR++W2zT/E/UMq1C6b7Ll7uQK3Oc7JggpVTsBt/g1STuSV/gn+Y8T2ewcg0ZD4xd8jkkHmxiF0R88GQxLt8lFf0DlOsXrAmU32YEwO6wx3mlRg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834787; c=relaxed/simple;
	bh=FfX0bWyYq9PfifYqS/XmpbYiNVsoHvNjK716HbkDhVA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Dto/kR4ALink9ANlcjHLhA2HQSzulq0g1WEBK4HBQZ6fbrz9L6SaFWNFi+p1AU6WoEy6ZPZP7MkY1QjZQoNkTItGwnxXvP6iEHFG+T4ef5/HnQ7xEbkgJgx5UDcV+K2zBfc66mWi2I5rafHxrACIHnO3zuPNkJppQIbviEhKAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7qmHG+S; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7qmHG+S"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78552105081so283917085a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 06:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707834785; x=1708439585; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tLSHLt8DtNR/f4T8Mk+186y6dKAYMvXizfS3ysJA4tU=;
        b=b7qmHG+SrHVY7ooZTsMAa5HzSkDr6AtqO3yh9uHWyl3tdJlfiRXpITTBb6bX8nfXnL
         SSG2ECtfEaFEddBQviccDiS0DE9GtVcPqce52yZybWxJfzjtD6dik/VkbAq6VmRLqbSL
         lnumsuDAP4q7Xw88zQ0EgEZPLelIp6YlA0ZRWzrnIouImwBnJCIPADN+jl+xbLC6/PU0
         cmIrIuY+S0dXrkcymDflammfgdWFVwl0x9agO6F0zozKm8gEEiQ7K7At5OkKehkI/GvP
         Z6EcKFj/6rQGnXiFmiPFLruqDplmi5GBXZ7MEdPXiZKveZhsYKT1P3h6sZNUmGsfyVMH
         v8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834785; x=1708439585;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLSHLt8DtNR/f4T8Mk+186y6dKAYMvXizfS3ysJA4tU=;
        b=ewdNQvQ3xb2RGbzDN0jAZnhzWCMJNU0dZTgeoSU4AndF78wneb657Zg9ZI3+nQwI8e
         P/VX5bycziWRbbXyMjPTNMoL1jq6nCjuuvJ566fiRRdntSPtaVt8qJoZK6ku9ftg3+SW
         RD61Fs1sL0UGGZCv9IO3an5N5SimStDf6CW/crOn5S9KJxLXSlMlzDvQXXyZIaeYeEUV
         02fuIe2ZgxKZYg17e4Rx8B1CYgK2+tpVZ0b/iay0bq3cjHM4UlbA2rRoBay85ZqBel69
         KSgtebBL2YCv16asSJzqt2hqGO017CLMVNfuuFkuzRWEBGhqgq9XjDhXtHKiZlwg0JIQ
         LNqA==
X-Gm-Message-State: AOJu0Ywwt9lctrkf9JhhB3tDQ8WNwauba2eKJLPfoSaiEUzBbInepupD
	J0lPSMylSl74FsuIU6p9/lllvxrqVc2HQCr217wuMSMKJZ5s9sZHmBQ6JEFT
X-Google-Smtp-Source: AGHT+IGlGbD/HItv8N9YzO+9NWMeWYNVl0lEbo1Cw4F9SohgrQDvh0oGVzx92ERXXJVqs4EJyZsG3A==
X-Received: by 2002:a0c:e147:0:b0:68c:82a3:a440 with SMTP id c7-20020a0ce147000000b0068c82a3a440mr10172885qvl.35.1707834785005;
        Tue, 13 Feb 2024 06:33:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhIKl7zwdPyG2k8F1xCY4JnAftzFrT00d77mF6dy/B7rXU9k37Z1IT0eyMJfIz64XoXdyneI+E1mIEoOU2Ugzgjp3qzA==
Received: from [172.17.0.2] ([20.75.95.104])
        by smtp.gmail.com with ESMTPSA id ld28-20020a056214419c00b0068c8be959a0sm1296438qvb.111.2024.02.13.06.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:33:04 -0800 (PST)
Message-ID: <65cb7da0.050a0220.5ea90.7e40@mx.google.com>
Date: Tue, 13 Feb 2024 06:33:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4737571906363155843=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RESEND,v1] Bluetooth: hci_sync: Add hci_cmd_sync_queue_once
In-Reply-To: <20240213135746.82167-1-luiz.dentz@gmail.com>
References: <20240213135746.82167-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4737571906363155843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=825632

---Test result---

Test Summary:
CheckPatch                    PASS      0.85 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.97 seconds
CheckAllWarning               PASS      30.43 seconds
CheckSparse                   PASS      35.59 seconds
CheckSmatch                   PASS      98.06 seconds
BuildKernel32                 PASS      26.91 seconds
TestRunnerSetup               PASS      497.24 seconds
TestRunner_l2cap-tester       PASS      18.20 seconds
TestRunner_iso-tester         PASS      28.35 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      164.45 seconds
TestRunner_rfcomm-tester      PASS      7.35 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      7.78 seconds
TestRunner_mesh-tester        PASS      5.83 seconds
TestRunner_smp-tester         PASS      6.82 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PASS      25.72 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 485 (98.6%), Failed: 6, Not Run: 1

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.110 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.139 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.142 seconds
LL Privacy - Remove Device 2 (Remove from RL)        Timed out    1.871 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    1.846 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.114 seconds


---
Regards,
Linux Bluetooth


--===============4737571906363155843==--
