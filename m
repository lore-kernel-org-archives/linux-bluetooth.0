Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A72741CF
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728220; cv=none; b=oGOPHh6jfy2NfcPsnA299sr+Hof3w/9eVGVemiwk+oRbGA4FX/J3UK2IcGQ0qp7X7uX19Y6zGfSROGtSRLENFIELvjpvppupzUrp6BceZ9WfKJXCtZHsV6VDaAO7eyZOaWY8Ha66KrI0bR6rltVN9ggIDyymAz35XD42Nh5cQaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728220; c=relaxed/simple;
	bh=7jrBbZyzHvFozy/EGj46r+UzS3bXj8YgK6OoYlyX1xI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=acFYxuey3F6Uvs+OFkthKbrTOmFlNfHtirQrED/aTqlGu/MD83Y6V8zqOIkBestxFoeS40bC1rdn9920AEg69c0U5TdsTnsK9maoVIXF8zklb2N7/NllEICn4Enfs6oGxpYwZmNXlCCPswR71M6Ks5NmxWPT5n2hbhRWG6dZi+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcBHjP8r; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcBHjP8r"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e3ce1ca6c5so22544595ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753728217; x=1754333017; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XAOqddvnRM8uTQcwmzdObAnaa34jXFQGCtzbHu9BM8g=;
        b=ZcBHjP8rW+yVa6eVKT2tgfpiG0pEgZAji4Aj4AxAIbs14qaDydfYjo5rikVjj+FjWu
         v6+3ynyJcYfc+qMZ+wztUD9tjV1kJTvC4wWuGw2URv3Dgl1/X6PhkHXanqeRDoUuyzzJ
         RByhq0QrySVToU6xyt31h+7j3mUpVgSRs9RmuebcKwOBH/W4ntJNqX7qefxKzZDAaf7t
         Cy0c4fc6CxnH1c+CBArR2bYvy6HJ6iaYlONhIZ55XNs6kGKIKAMGrp5lqyYcV9oE/2KN
         UW4n/bv1nwBbgXz9XRDiZgydKKJDqUoY/KgQ3DNiDwEk0qmf9qCRuQJtaNC02W3kjtVW
         eKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753728217; x=1754333017;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAOqddvnRM8uTQcwmzdObAnaa34jXFQGCtzbHu9BM8g=;
        b=K6VeO4fQ01J3/r7FG8PCGF1v+NeqCy1Z8M30xzFfCYTCD3KuBtLBYJv9zG5KbT0w4U
         V3juvgQM+sp1GG0GwQiyZpfH0c/rwTXdKFJuN/24JgOs7k9jCmFsKkDIMLP2rZC7ZaXJ
         maWPZ2meJnJo0rPSidvF6IjmuUwKRvyndNpw6zendgfqW2OhxdSi7MsDpaiJjs0Sy6RY
         3wHg2Q4TDhZKCYui2p3JRhENqzZ9SvYWy0MJ0kaFh2UV7o/o9OEMHe2VcFtln+0JJKfY
         abzgVIY/CQ27KybyrxXd50PLOq4oyMIh9SqSPo0MWSjaQbim/Gm4sK474ibN/S+xKUew
         QcUw==
X-Gm-Message-State: AOJu0Yz/9xzrsdrCyILW1eNbk9VojZn7AZTYixFVIabX0kfu295xmAvs
	aJjyUrTrTGGG/tp1sVJVGdJ9ujc/iHFR6GZXfXr+Ln4GIrwtP9PwkUFzBNeNBWXt
X-Gm-Gg: ASbGnctJWpE5RzsSYHDXqwzbNCjvAq2b71o6K5K/I+VDqlvrcdBlsaAj6RRvc32ro5l
	UX8YMuZXfUrfjWUNT7vBlKZb1eCKaR8WcsfQiAiXS1yEY0lkDHZS1Hej5ctE+IXerVOBNAzTet0
	PD7Z8j8Va4bhAMz9U1xhxXDQU5wT3maLSG2f9RvjF7CWpaLWU9kqjJVHSchFO0fZGSy/8IXu8Rb
	mwTqUVbznf0ro+lEohZKddmAGfBu35dgWr1PQQ+MLdo9A8/J2aS534uQGOf8x7yWlDxkwVKu8W0
	Ki1yu2m234BQmBZ1AjxrDwzbqz++9qPsyKUH+JRiLeCcTyR/xCosPIMUylMlZI/o20RY8e4f+ax
	PR1il0mv/Tc1ZpMxbZlVUU1kRLLylHX0lixzSQCkH
X-Google-Smtp-Source: AGHT+IE92C1uGdnvNgUCtSqzowzWywypH2yRDVYpv2w9oftpsFb7IqgFZ04YTas4W7hMCSbqC8TX6A==
X-Received: by 2002:a05:6e02:3c04:b0:3e2:8bc9:170b with SMTP id e9e14a558f8ab-3e3c5312d7bmr191060365ab.16.1753728216959;
        Mon, 28 Jul 2025 11:43:36 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.163.129])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508c93b04bdsm2031179173.121.2025.07.28.11.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 11:43:36 -0700 (PDT)
Message-ID: <6887c4d8.050a0220.2cd896.344f@mx.google.com>
Date: Mon, 28 Jul 2025 11:43:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8547518981390685696=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/3] Bluetooth: hci_sync: Fix scan state after PA Sync has been established
In-Reply-To: <20250728175816.850399-1-luiz.dentz@gmail.com>
References: <20250728175816.850399-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8547518981390685696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=986502

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.65 seconds
SubjectPrefix                 PASS      0.27 seconds
BuildKernel                   PASS      24.20 seconds
CheckAllWarning               PASS      26.95 seconds
CheckSparse                   WARNING   30.03 seconds
BuildKernel32                 PASS      24.57 seconds
TestRunnerSetup               PASS      477.12 seconds
TestRunner_l2cap-tester       PASS      24.91 seconds
TestRunner_iso-tester         PASS      37.36 seconds
TestRunner_bnep-tester        PASS      5.92 seconds
TestRunner_mgmt-tester        PASS      128.67 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         PASS      16.60 seconds
TestRunner_ioctl-tester       PASS      10.04 seconds
TestRunner_mesh-tester        FAIL      11.42 seconds
TestRunner_smp-tester         FAIL      10.86 seconds
TestRunner_userchan-tester    PASS      6.16 seconds
IncrementalBuild              PENDING   1.01 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.088 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:
WARNING: CPU: 0 PID: 51 at net/bluetooth/hci_conn.c:568 hci_conn_timeout+0x14e/0x190
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8547518981390685696==--
