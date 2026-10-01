Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A09387361
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868734; cv=none; b=SxhUzFsw9nS+aj/Y55Htiqc+drdk41RVC6Kr8PvBPeIveO0UGM9r6n2kXRdjQRKxKatQ57DykSsVx/V6465t/7gy9ghmDbUQBhz/NVI7ZPZk3ZIU9U9cdXM7eM/9jP8ac5W86wFIXfK6/PxOMKxEa2t63+PY95m+a3gk5Agdpig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868734; c=relaxed/simple;
	bh=BXWgnytKay8cJxN+xwONr28AgKFGFnMGMtuulyijBH4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=snZB0DiSoIsEaySnCs/qtXMzR0jL5whnL2E/iRYjD2BMl1xxuGgBOScP0UoCT+d25d+ZdMpjBC5C1seRoNitqF0eFZRu1y7iTpdvHKx/TjaHOFfmxK81XBscX0eQ9PowQLO3AuUVD1jPXG8OoUAzxKFiA0F0wxrXtTZFhu1iQTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvF/fk3P; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvF/fk3P"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-34e0b5014e8so592480eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790868732; x=1791473532; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ma9oILGcgl6PGn88j6/xslN3pC5fFCFPcZ+vZtrPU4E=;
        b=dvF/fk3P/of1Wj7280anpuJZOQNTzE07TSrjQVH+3Km+6bDhE3au2+igGs+5NyYvCs
         HvKFnpqOIFX+0OI7lqS78xKKP7g8LCKRiNEYenQklIMDqDwtKcDtd5D+TI2pn5nUz8C3
         pKBtHTHu78XOegOl8usRUsFySet1j7EdInUvD59vc3LLUhSQn3FuTMYb9MIh3Ct1y9ln
         whC/uO9WYZXxqGySDdWqq/CIlDXZpymL7rK20zSZ9o0BwvU63VW7C7iksZK8Ayl/smum
         OQY/qgt0gkkQx4x0gIjtvwo7zipWE/RJ35+XQiPs12zQw4DbFKElr4jn27MzYFlh5U3M
         Txwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790868732; x=1791473532;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ma9oILGcgl6PGn88j6/xslN3pC5fFCFPcZ+vZtrPU4E=;
        b=nA5mZKy5Kd0tHl0Tn4JB/vrkP0vNs5HrEBy6K9/BxKb3WysQ7TktA+zauVDWzS4SNg
         Vj9AtFcwhfb7TL3PUH6LU9zvbEOZDEDFlodtdOfS6+mNYVKoWgUx19O+6dJ4n2UJZknj
         x7gtMj5c1+25D14sz7eyeXZdiafKsjvCsom3DPo35mjPuxaeizhobQQXjKmVTpNs+fxH
         uGjFVHYDs1Jev0y+C2+2KOicTmSWWMUhc6MZUZiQdAaXQfu2bQo9PszqtaAu9OJH2+sI
         kt/On7+knpT38iw5DPNGHOgv1A19i84DNvlXWV0Fwvai0MiQe6BV7I8i+e7iER818gBZ
         B6zw==
X-Gm-Message-State: AFq9FYLYN+M3hGGmOWXPBOweY0gBsJnUM/W3zyGQfnRXPIrJK0xvOWH9
	3k/EGZfRPH3wWndL3VEzUA867XbKvccaeZy+gRXDJt7a0Nn2ocks+DTJEdX0kA==
X-Gm-Gg: AYBFou3XVaDLkKlxP1YIJK1LSbkOazshL2KhotOYwPKcDeyVB8ede39M0g7TLPuWAK1
	tMRW9oF/jN4L+gLlRROwbzQfNMKRuYaugCaPZffmDR+juLsX2/1qMoecnxpPxlmD0U4EUxEKu1l
	uiK9DRtU3NimYYsjKBDPfzKgX/BxGg4VD3utOLU5NQj/Y0hdOHKX+/oxfcoJ53HhaI6x8xWpaaF
	byHXQZFjHb7jD6lPuEsyLBZu9LLIR8pCigIRqZvQAOA/a4RT7CrVxhHgHbOUHaQp88Gd63WYF94
	q7OlfeprV0TScdrjkpbVw/GMc108KlZNiCh/Ki9KgpsjmhNN+OtVn0YmJXT/2TefJD2s4b3Ngwv
	JjycWzdZueJoZO0s7myzs2EIRWEJ1W5NNDixiylPZ+UxmtSNEoihm4Shf1RV5ZqD7LU/a04n5zZ
	aiPvROwhYx9iAfw5IHCLaKaxS1QDOdwkL/ZiLgPv8r72hiDvLSPb/rBTdUHKHhHSWmlLe7WB9pg
	dO540qtZ2fAur4=
X-Received: by 2002:a05:7301:6195:20b0:33e:61ab:8309 with SMTP id 5a478bee46e88-34db72e503amr2905343eec.23.1790868699965;
        Thu, 01 Oct 2026 08:31:39 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.161.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db491fae1sm8489813eec.24.2026.10.01.08.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:31:39 -0700 (PDT)
Message-ID: <6abe7cdb.ac572b67.376b49.0c30@mx.google.com>
Date: Thu, 01 Oct 2026 08:31:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8746963539923672758=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [v9] Bluetooth: MGMT: Add management security level changed event
In-Reply-To: <20261001135108.964362-1-frederic.danis@collabora.com>
References: <20261001135108.964362-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8746963539923672758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1177706/

---Test result---

Test Summary:
CheckPatch                    PASS      1.73 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.26 seconds
CheckAllWarning               PASS      35.50 seconds
CheckSparse                   WARNING   36.07 seconds
BuildKernel32                 PASS      29.90 seconds
CheckKernelLLVM               PASS      33.58 seconds
TestRunnerSetup               PASS      725.30 seconds
TestRunner_l2cap-tester       PASS      12.41 seconds
TestRunner_iso-tester         PASS      10.42 seconds
TestRunner_bnep-tester        PASS      3.08 seconds
TestRunner_mgmt-tester        PASS      59.63 seconds
TestRunner_rfcomm-tester      PASS      4.39 seconds
TestRunner_sco-tester         PASS      5.47 seconds
TestRunner_ioctl-tester       PASS      4.57 seconds
TestRunner_mesh-tester        FAIL      7.79 seconds
TestRunner_smp-tester         PASS      4.30 seconds
TestRunner_userchan-tester    PASS      3.17 seconds
TestRunner_6lowpan-tester     PASS      4.39 seconds
IncrementalBuild              PASS      26.95 seconds

Details
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
Mesh - Send cancel - 1                               Timed out    2.453 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/848

---
Regards,
Linux Bluetooth


--===============8746963539923672758==--
