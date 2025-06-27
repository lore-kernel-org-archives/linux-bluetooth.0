Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408C33C2F
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751009750; cv=none; b=Ghb4pX1vGirjqT8umDewU8w3eRKFOLXRJJsSkxh8kAufmvFG5rgpk7mKPLg0P+BASe0qbUK6o3FTJBYeReYFtpSf/PMQiWxu6d61nb593Z5jzrWznj5NYGiUFMcjeTcnobBmVefTby806PLXjdFX8/poevgQ9dblvsATx6KxTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751009750; c=relaxed/simple;
	bh=cGPJmZa25+5Y1EcKK11wTcRiXN1zMAJaBov7GpFVucw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OyXxGWRcdBUoKPPidSApu21xwzNVtfHPUT0/55xVZh/0kcfB0p5LHuBVRUFfZKoyO5RWIUQdyhBTS7186c7R5GdktvywZObVXL/hrvvimIA3KvP+t+hou5YunErFJPvcARD0sypNEad0LasNSLhKv1MLQKvKnzzTDFVTzpG+yCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H331tYJ2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H331tYJ2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2353a2bc210so18455005ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 00:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751009748; x=1751614548; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aqoMKlpDD/NoEcEufVxN2tuoNuDZM4S4fanlXuVYAUA=;
        b=H331tYJ2ecZHUCPcPtEXCI3CBdfJ861wlAGxzJly/5oVTeTE2JnoAK1IXrGjEBvHK6
         0tOAx92DUNvk9BefIu/hdWI4qekmjgUEAzRSbpt6kB8fg7f72izOL7OJQ+yeY8pyIIbo
         IUVKh8EYU4FfWwISem7RtHEpb3dL+4S7TxzTQ343yxVVnJhhLgoPgPrtPDxaqHr1Dfob
         xioXAltOiL0BFvndit7lQQPAvGJnHdon7aXhgk+M5zOSVUhr67GFqMMl3xwfe/eXJfcY
         Rqu4SVB7DlUkDOmOUfu4gMJYoRCIMkz/vDO94McBbo5oNWRUZOrOloCJqxQaLbwlYN5f
         wjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751009748; x=1751614548;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqoMKlpDD/NoEcEufVxN2tuoNuDZM4S4fanlXuVYAUA=;
        b=KT15elJRcvD7OOPY7DzAAjBjf8MSxoV18dCGBTK2/UA57Wu0yepJOzh3N9dMZvBbl9
         6F212+P2PoTFeAArdr8UsY7sfulqjzkXSu313qWpueELRxvypSxTpS9fmtHQR2kJvriH
         90CDe0aYWzmm2IaLmB7XYbTokjhgSZXVr2FUYzLRv+LQFC1vaH+09hIyc+vLxmrdUEu8
         AgJHcjYmB2Xt/Hc8frMMYyBLsp0IPU63+lMmuh5Dv46KOqLhgOrfXu3aBLm7Zg+LTStp
         OHA6kbldGzRSXkr7J/5VMZSTZz5zG/d3KA5TCEaUHDH61SDZNT1Al27GoOzFsIbVHr+g
         Z0wA==
X-Gm-Message-State: AOJu0Yzo0THook/PEMZGSf3MiLuw7yu25VnJOuoeB8xUhcRUeq6ZrPgs
	Mg5SFvwlr7nsGGoNuH0y3lizYhmoCSI66E7Qqf9gPTvQcypLyaA7zbuNuQ2Exw==
X-Gm-Gg: ASbGnctrtQgCQqQBoOJH+VlMOG++oE4ZVBxvC4WdimYkCJ1cSLsTsVd+iD9Svyetxh6
	CRgumOZirGkT19WzEFwdGhdo4T9SVg99q6TrnfA966vuW66iIb/jleQCYq1Tn+vCtWTf1LKZ7ey
	5FN+IMNSlGcTFzGpH3n2oPdwS+L9Rpm3fbHdTpKM0OpUX4zbgBqiEgfQkGAqI4yPEEmpuvuSB9m
	sV13hbqjpodm1PsVBGD91zRa9xe0nd0ehLuvucrRGmmF/dQ08MoFVRvrEx4L5pqAitjka5Blnb0
	s/EHS676ML3MeLUcbG7ToEU8LtOa0wtx2hEee1v69Gmdzb1KH+oNlXXLUIlLiXWj8x/T
X-Google-Smtp-Source: AGHT+IGFZQk+fWQPRCi2tB7L7kZG7uCxOEmenJ3eU89ywbjXoFJKI/iKsiM0R7StXIoENBanm/T5Pw==
X-Received: by 2002:a17:903:41d1:b0:237:f7f8:7453 with SMTP id d9443c01a7336-23ac4667df2mr31318665ad.51.1751009748272;
        Fri, 27 Jun 2025 00:35:48 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.77.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b7a21sm10167925ad.168.2025.06.27.00.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 00:35:47 -0700 (PDT)
Message-ID: <685e49d3.170a0220.2b3728.244c@mx.google.com>
Date: Fri, 27 Jun 2025 00:35:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3129489274674693289=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [v3] Bluetooth: HCI: Set extended advertising data synchronously
In-Reply-To: <20250627070508.13780-1-ceggers@arri.de>
References: <20250627070508.13780-1-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3129489274674693289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=976499

---Test result---

Test Summary:
CheckPatch                    PENDING   0.54 seconds
GitLint                       PENDING   0.45 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.65 seconds
CheckAllWarning               PASS      27.06 seconds
CheckSparse                   WARNING   30.44 seconds
BuildKernel32                 PASS      24.15 seconds
TestRunnerSetup               PASS      478.45 seconds
TestRunner_l2cap-tester       PASS      25.31 seconds
TestRunner_iso-tester         PASS      38.53 seconds
TestRunner_bnep-tester        PASS      5.98 seconds
TestRunner_mgmt-tester        FAIL      136.89 seconds
TestRunner_rfcomm-tester      PASS      9.25 seconds
TestRunner_sco-tester         PASS      14.74 seconds
TestRunner_ioctl-tester       PASS      10.10 seconds
TestRunner_mesh-tester        FAIL      11.76 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.21 seconds
IncrementalBuild              PENDING   0.94 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 4 (RL is full)                Failed       0.276 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.025 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3129489274674693289==--
