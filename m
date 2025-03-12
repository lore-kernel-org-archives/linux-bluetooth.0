Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F772528F0
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793873; cv=none; b=A1/5T6U1+AqXm3AuNAYfYAQddRlyzzSUp3nWefuspgJMov30P7u+lM0cwByxAJ/EUsfe/diPzEiC8ZDqLQ5SGxOhj8jlRsF7Fok7JrMJBYzUKrv1vip4B84/qjuOWxliScQd4ID7Plv6Zy1yV7Y5A0Fy38OwpKKxyj60MP8gNL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793873; c=relaxed/simple;
	bh=ckDpocoqXtWb51BYB9WQNJa3nGJvEu8/SfwQ6qvb5Ow=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iUBzfK9jbaf6Gfh7pNVdRDpHcq89fcZWWdHUvpqRDIR1YB0p+NUWuQ3fiKEeMwHhQAUe9qGRIDsep2ygaNX5dbiLdmxegmLOan1vv3hAN2nvV5eHZpN+SRdILVAFX51FjzMTqIuaytzBQNJ0cDnUBprXd7thScmV8KGBOn6Akf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVO8yx+H; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVO8yx+H"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8f6970326so321396d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741793870; x=1742398670; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AbySPsTP+fCRvjTwKDnEeSHZkAEFJ3HP6G3lNDFsJgE=;
        b=LVO8yx+HZcXlG6p7bzx8Km+/a1Q0vkBQk0dVgBgbDZ9D3xwXKaeNNF683JFa++KUHA
         1Dvqn2LsyA/Xj8WVNYiNXOlCsva0u4cNimCuDgrQ5teD11Qk3BeGqeRbmpva289DnjoF
         B8GqWIjmk/7nb1kQWJuBZdM09hKr8lR+jAbM5z14xNy93rc+YjjSv3V39D18OPE9XZav
         Zwr/88D14a/3zw5rlYLFkkP2khkXPZLOQ8SYneKXH2oU/MHA77aTmJTuQeNHzyiWpbun
         tN8sKDv3t2WbJAAI1fZ6ddLbbpO5sHjI+Dzs6qsaoJ5/ifS6qvLOeH3xMkX/d6h90dyM
         yqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741793870; x=1742398670;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbySPsTP+fCRvjTwKDnEeSHZkAEFJ3HP6G3lNDFsJgE=;
        b=jM+hodWj8CLZgfn0075Bw3NTvF2inSwDQnvJ/0t+YuhVSrk/HFpwaJN49RP/OBrUcV
         ZebC/Kp4vxC+k1UNTesc3qdjfwhMKcIjiUtlkpzVSaVKVcFqFWekTk8SylgjCnCwih9g
         qE6+7WUi4e+lK4O7xwZfUDt9nndkbcZnZYIOMyZzQ+naXxgUun+LxDxQ2ERi8Ed9W98a
         AKAzDdT1yUmtZEBIWGOVbW8fwxPXIMormWJ3ZrBrx4dCheigdJ0oGhTlwdqL26a7Z2Ca
         QgrPak1RiDq4L48A0SabQvkgg6Tnj4HE/jn8EAmRgdvIyHEoFPbtfDoeKcE5+bMraD4L
         mjbA==
X-Gm-Message-State: AOJu0Yzr7GsAr4GfehTj0rcAlTKfZzEuTMkgBAS5P6Art9dkPvHyib3f
	5PoSLcxflIg40tR/9ufy4Oxxv0mP4kuQVpVamScG17gPNN/NRibvBDNS+A==
X-Gm-Gg: ASbGncv3VdRp0vzJuoeq4k0dm+R1IuY7gFkL/UIQwmETyh3vmAT56LbltzbJbRPIz/V
	w7ALB2V+Cbg8Ut2mShmBLqQZtlFZ0EtOGkbQN7cRsMdMERFY8GPd1dQjIHUwHiL+9PGjcTeFAxU
	WDlIJq757tNoC41sfBe2oW4NSLoRfcNsF8u3a6d1oV2rIkluC/I7opFZ3/20u2stJJEYpk6Rnvy
	waibBvuMA1irVnvnnAgmZBnTGE8A7W4ZsHr7KUDG04cx/B9pNXUcd530Ca6vGBpDNv3G2MFhLoT
	WNDoNnQOHu1hOR8UvxeMDxbpeIKHMkhMNBbZ3kEBWXzIQIX2EVpiKmMBA6WM
X-Google-Smtp-Source: AGHT+IG7EQF+Ap7aP9GeanS7JSxV6jM9QoUOWwWrAc6pTbBbZ268oGaIc6s6hcKYssz1a4KHhDV/4w==
X-Received: by 2002:a05:6214:5012:b0:6e8:fbb7:6764 with SMTP id 6a1803df08f44-6ea3a6adb62mr90722166d6.45.1741793870619;
        Wed, 12 Mar 2025 08:37:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.17.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7094611sm86107106d6.50.2025.03.12.08.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:37:50 -0700 (PDT)
Message-ID: <67d1aa4e.050a0220.17a20f.ee10@mx.google.com>
Date: Wed, 12 Mar 2025 08:37:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1308368498908204101=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
In-Reply-To: <20250312151421.201772-1-luiz.dentz@gmail.com>
References: <20250312151421.201772-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1308368498908204101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=943172

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      24.83 seconds
CheckAllWarning               PASS      27.76 seconds
CheckSparse                   WARNING   31.09 seconds
BuildKernel32                 PASS      24.87 seconds
TestRunnerSetup               PASS      556.27 seconds
TestRunner_l2cap-tester       PASS      27.73 seconds
TestRunner_iso-tester         PASS      62.24 seconds
TestRunner_bnep-tester        PASS      7.68 seconds
TestRunner_mgmt-tester        FAIL      177.90 seconds
TestRunner_rfcomm-tester      PASS      13.22 seconds
TestRunner_sco-tester         PASS      17.96 seconds
TestRunner_ioctl-tester       PASS      15.13 seconds
TestRunner_mesh-tester        PASS      10.95 seconds
TestRunner_smp-tester         PASS      11.66 seconds
TestRunner_userchan-tester    PASS      8.43 seconds
IncrementalBuild              PENDING   0.69 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.329 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.345 seconds
LL Privacy - Set Flags 4 (RL is full)                Failed       0.424 seconds
LL Privacy - Remove Device 3 (Disable RL)            Failed       0.382 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1308368498908204101==--
