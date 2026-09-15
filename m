Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AFA480DEC
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494078; cv=none; b=n6LxvMT8WiN+PCYZhVkGg13E0GNZEbJN9LtkHAkMYSLcdMC41eyvPGZf1M+QtHDNBZIpCdW7PYRIMi77alwGhcyjAaqq2qRMZtigIWqKqfkB56bDtpM27vTdtmC1vJ9j1w/lulGldbLsD6vgVRx+XPdyUvZnCexpCHBhFam1aR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494078; c=relaxed/simple;
	bh=M3aCxOb52eWyeRaR1azY4CAyZozbQe7jfWPszRcWg8Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=To6Vk3F2i7MrSDP12yv7EEsCv4lFBPPTeAeiHJCKVzSWva3XB1PaZDFHis7hfHaqzQFNZEawS7uMw0rpYUEDGpejHFUTcMR5kLV2lQmOAr+2eCSNSDzNUn1tnhrlMpF2jjHw2mqOq4UiprIFhHnnD3getov/0/Gi+jLYNm9TdZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pcZS6Fuf; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcZS6Fuf"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso21515a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789494076; x=1790098876; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IGPce9Thk4/qyrRBrrGY/TyNjCrtL+SrFskRyBmgUZc=;
        b=pcZS6FufvXNzvg0RBLctCckbVGksxYIvvytvwRPGPeHhw35nidHxJ2wUt21xPIIPFl
         HjkTm4pWKJHyanAKpqKtBj2v2qE0tgXnTEEabw4ScbTlcSqPv/7f8nAgHZM0msMGFlLc
         Hkh6YIikHzcRAPcAllcHz7TQI7H7nMHlvVKOkxllgRcWjw1rPgnhpnrRUFmVjDeNM2Ul
         8C775S91h+GIAGY2cYcLBSJ0HbQ3FB5zQAG0yNNfqLT+dJsw9uLehUXDA9znndF8sxUZ
         31TaHbD5DBisBkVDe944d2VSD/ZeduIZOLei0MDf/siUvXPyg6/VrupICugxBDyEQZ1B
         0O9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494076; x=1790098876;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IGPce9Thk4/qyrRBrrGY/TyNjCrtL+SrFskRyBmgUZc=;
        b=fBw7+4CQQKBp/wYFXcJQs6wXg5/a0b13BT8/PYGtbnzI2a0HKO2NzHVqus1r1udgIw
         ap7A8vuVLPhsmNrJEeHfKBN1idBVW1BkvwlVUB0OxlZc4Kq7lpcBpFwFi7LQP9GOtEc1
         8BCBXoAq0m97lhaWI92ax2ISoZaMuEKDAKdP2jnWA8XS3y5QcfGnKAh54c9ubFZQIwnt
         TMSoYzuQKFD4yaSoqZw2tefTaISRznrKM6XUcsEgCJbgQ/Drooat30tNZGkHskwPQBdA
         0W+Dff633wJCzzr4odqCyLD1QyH6lBAKEY5b9QRGaURaPNWWBnccGoTkKcVMP8dDMxP1
         uxJA==
X-Gm-Message-State: AFuF++kiy33ogKk7ZrgOVH84nH6dcw/pXEtgurLLAqB229QRahG5FC68
	RgnUKyYCQbNj3uC4DksmX/JiGZBw+puaJkA8H3FyV6xiatVH8hDt1fRvVpri7A==
X-Gm-Gg: AYBFou0+orVSHgg9uiMQTgIIZbjP0CQaFSLQbOQSb38OdEY1BDXkYNiTJzIHuUhI8SA
	STqI9+GqKl5W/2OBFXGnHflBT7+9t+cMBteD9yoVb3bU/79gzQdCJY6tdIEG9zKCRKZZbEkW6q/
	FechXgoy8sUNqCHNTWR9gLqrjVHg8wkuvYyJBHR3IGdQ2F/AD05xs14bvKTZ3CeQ8ir+iZPxRnS
	spqHvwjLKwB/Z7m7sRTmxirGPg2xcsJWZ+vWLoonhHEi2BpV8spA7EqZfapN+qliCtz/m4Ctrcl
	4UrqDYnePf0x/8nZpc7paYX5ywe9Ni1izau3rx59+yIWPXfDxM5Oske6pbJUTJoaysrwnFW9QLX
	b1f2tni/xphkZbrO6RwyKQi+Fw6DnfTbX/G7djSaiYH2/6EbWwgYLxWDJpaQG8aofvtaQQb9i1p
	2nmg9bX5NGQgJBESaELEXOnOuxoz/ud7AiXEYyGq/3E3SCAA86YLd+F5wcefXnzyXKkkeOX2Qg5
	5r5nw==
X-Received: by 2002:a17:90b:1b08:b0:39d:febe:7460 with SMTP id 98e67ed59e1d1-39dfebe7695mr9414517a91.22.1789494076293;
        Tue, 15 Sep 2026 10:41:16 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.177.67])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5ac47cfsm465214eec.17.2026.09.15.10.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:41:15 -0700 (PDT)
Message-ID: <6aa9833b.17b2f02a.2d9832.9e73@mx.google.com>
Date: Tue, 15 Sep 2026 10:41:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5212857094490527877=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qwe.aldo@gmail.com
Subject: RE: [1/2] Bluetooth: hci_conn: fix CIS hold ownership on reuse
In-Reply-To: <20260915160430.3108071-1-qwe.aldo@gmail.com>
References: <20260915160430.3108071-1-qwe.aldo@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5212857094490527877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1165738/

---Test result---

Test Summary:
CheckPatch                    PASS      1.02 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.43 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      22.14 seconds
CheckAllWarning               PASS      26.92 seconds
CheckSparse                   PASS      28.93 seconds
BuildKernel32                 PASS      22.40 seconds
CheckKernelLLVM               PASS      24.14 seconds
TestRunnerSetup               PASS      579.01 seconds
TestRunner_l2cap-tester       FAIL      8.98 seconds
TestRunner_iso-tester         FAIL      6.17 seconds
TestRunner_bnep-tester        FAIL      6.33 seconds
TestRunner_mgmt-tester        FAIL      6.17 seconds
TestRunner_rfcomm-tester      FAIL      6.04 seconds
TestRunner_sco-tester         FAIL      6.29 seconds
TestRunner_ioctl-tester       FAIL      6.02 seconds
TestRunner_mesh-tester        FAIL      6.24 seconds
TestRunner_smp-tester         FAIL      6.40 seconds
TestRunner_userchan-tester    FAIL      6.13 seconds
TestRunner_6lowpan-tester     FAIL      6.21 seconds
IncrementalBuild              PASS      24.23 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_rfcomm-tester - FAIL
Desc: Run rfcomm-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
No test result found


https://github.com/bluez/bluetooth-next/pull/778

---
Regards,
Linux Bluetooth


--===============5212857094490527877==--
