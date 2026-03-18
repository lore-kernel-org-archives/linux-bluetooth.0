Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C013258EC1
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861588; cv=none; b=qrqVUvEUt/KLnfGdp/jagkzFAMzX+VEijP1IXps5li2gkrAbq3ZybXwauBqfqYgRgoZKDwgyK3p8BDUwKjnjLlQemtc7TOlXLiWbnaKH8xz58/ybziem7E+Pwc+o1ZezoUbziz2T/793N2awA1n72dY0S7ggYRuOJWOCoqMcCSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861588; c=relaxed/simple;
	bh=eldBkQQK1ZXi1VWsANEbbwtaCSwBVZVJZ0fkZ0Z1tlU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Rtl4ASC5ki5iwoa2BnBDYy/4axBM2ZLEe8HlewjeEM4RTNMzTuDrH8rWLxjtN8XC3xsrcjoEd6mx7FpFUwhgr8OFmTzQXkqfAxHsYkJUwUCRylUPWWEv2mqarFnoGieOfaZj8XcO6j9VWtjMXLqGmDq4NqTwXHNp3x7atMwokkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7iSlP6P; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7iSlP6P"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12a695044a4so75536c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 12:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773861586; x=1774466386; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IcPKVDrQBJH74Pj4lMUHmrlmnepxajEMOdrDSonmjPM=;
        b=S7iSlP6PZi1PaogEBHz5fPuFx3Dijcb+SI78/vKC7m6tS8WH3RzLOFQ0t+RtJzL4p9
         MqQATjcXu8hkHZ3wnm0mXYw908/i4NVA/HnOdiCPjozpyDdX7IFQxL2NMozp3zmPmzvM
         W/Fe8xeBoq90wlFt9CbAhAs7Lv9JyvQdyi26/DuYxpgf3GbjYbEzVcjKQjCR/Tw/0LVw
         b+2ns9Rr/fuCPKuqRyB8LPBR023IzKSMvTcZ58sI0fou4yian+MSdJA3FpaUz/dFb5Ck
         v4U0MRY72T7E6zWN37C7LTqEN5d5OqU4SYoACR0UzV33HUNiJvzzxabnjWd076aCIEfQ
         fzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861586; x=1774466386;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcPKVDrQBJH74Pj4lMUHmrlmnepxajEMOdrDSonmjPM=;
        b=X+aR6HSY81MXWWc+kDiZbCMVqkFrXQwTq6qfbH7ou8nNI6QdnROF+T/uwTTBVGU8S1
         XlnagRkemtSJG75b/5lyPXD9ird8XhoRMhFPJ7+d7Y6bVCXzaXyp73FhSkAMsE9NMQIn
         Jt80VDDBk+XV71FgMYns20FrZRmJHSmc2G4kX5N608dyPFw71IQh5phRaEZPQqnGknR4
         Z4gMDoMUXpPdXFmfI4qQf7voFVwiRisDmPZh1VTx+7nZFtC6ptYYQQU2kXdc+U3ttdYo
         jFEpBlQTmWlACz7+HVlMZsf9r1IkHUp7HIhTnXGJmJJcXnXJOzUEVnZl7B2rYMm6IDoh
         wR6w==
X-Gm-Message-State: AOJu0Yw5s6pc4NLkhiNhJJbBQKz1TOpTXTlST9ux/bqy6gECtX0b9IA6
	gOdUBlGAtsWzWD85toulsEwuaAa2RanmWusDBgrv7c3kFPxj8aNIPJswXklbOw==
X-Gm-Gg: ATEYQzyIRMqv0b6GWqNPsKrw2IbQ9jF8YtSzAw3JEorfD7w7DJ2GIQzWiCoyhX2JP2A
	KZZULd0uDxqC9qUqxdsyFv1/YPvsJ55+q1F9xwIKHm716dWg0gopJ1IL8zh+kd8F+ARTjCQAnAs
	IG0uu1Wk73Xubut9gipT79DS5nK22+z1MhCvGQML2fOgq7bgIWo83Lrx34ip7vEGa2A8fSPe4Zn
	rE0R0ei7XgjBcnZ2WpNlARV+ckpnHqeqNKVtC/UXmJn6QUCfo14c38YLB3PBVdWtJbkpA6xLtlr
	HAjp5ZDHG8Rs+2m0CTYeyOT6cbdHsdtio3iaaHqhwkXMVRO6stov/goiZvuj5qLNMcNqfQGpYOx
	Vs9TXn+3ZhypPdoTcudEkcQcIAuBYGOo8yJ+jK1J9WgJstkRA09JEwbQfiWUaGQjjxaBRnHqTlC
	INfQyFwJcwWlCmob6gyfLYhZTb2iYQjw==
X-Received: by 2002:a05:7022:3885:b0:12a:6902:ddb8 with SMTP id a92af1059eb24-12a6902dec6mr167875c88.4.1773861585766;
        Wed, 18 Mar 2026 12:19:45 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.136.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129b41271aasm4183023c88.11.2026.03.18.12.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:19:45 -0700 (PDT)
Message-ID: <69bafad1.050a0220.346817.917d@mx.google.com>
Date: Wed, 18 Mar 2026 12:19:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6796520415244282767=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix regressions caused by reusing ident
In-Reply-To: <20260318180116.288242-1-luiz.dentz@gmail.com>
References: <20260318180116.288242-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6796520415244282767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1068801

---Test result---

Test Summary:
CheckPatch                    PENDING   0.58 seconds
GitLint                       PENDING   0.53 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.30 seconds
CheckAllWarning               PASS      28.95 seconds
CheckSparse                   PASS      27.74 seconds
BuildKernel32                 PASS      25.37 seconds
TestRunnerSetup               PASS      575.66 seconds
TestRunner_l2cap-tester       FAIL      28.85 seconds
TestRunner_iso-tester         FAIL      38.39 seconds
TestRunner_bnep-tester        PASS      6.31 seconds
TestRunner_mgmt-tester        FAIL      114.59 seconds
TestRunner_rfcomm-tester      PASS      9.44 seconds
TestRunner_sco-tester         FAIL      14.43 seconds
TestRunner_ioctl-tester       PASS      10.12 seconds
TestRunner_mesh-tester        FAIL      12.53 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.62 seconds
IncrementalBuild              PENDING   0.91 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.119 seconds
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.111 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.769 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6796520415244282767==--
