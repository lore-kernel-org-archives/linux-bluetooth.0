Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57D52BE32
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689239; cv=none; b=EVlvDSd1w6zdhWZ1mi/Q888z6gxCMcHMxmYjSfB2zL78iAfGsN9EUCi0EKjObr1xGHwZHMCfh/8qD7itnDitYt07DkG4ZqzeK7UZ7BGhyJiu42deb2gsjOZmhWZYhc4jwoSxzsTFH8s7k/tXWkw5b2yPgj9YwMk8DoQJBdzRpKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689239; c=relaxed/simple;
	bh=qfWPn+Ok2ZEIDDjJu4xUo0uD9YI81+Cr3uXUbuuoMOY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EO4nZaDRi4/p7hTz4c6OkCxfo1nxn/SkEifD83ncAK5dCJFj2+vpbXT085rLZLoXCrY0hgVjQ4i2Qtwz74YcM7x4zDhK7JpjnMVSWsXhXnkLioHufx5sagtLxWS3KSbSP1c3vhShZk7XTAnUBaMHEN2ejAg4GXE1diZ+Tji5LTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euX/VR9L; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euX/VR9L"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-8137b129131so2767413a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790689237; x=1791294037; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c8RpwvKnWIvhPb3J3zGDHyi523YM5wN/XZAjJ2WhR4I=;
        b=euX/VR9LqNYvPBxmHH4zBeYD1omBd1gSXRwbE9ATGp73pX7ecfaejk9KvoQeOdM1k0
         OYbyJhigDGMCe3RVjpR6SZ4hQ2aQk+K42U9lyq8E6Uv9JIoZoxt5X71PTWokKH5/dNzZ
         V3gmbzgO+NS/jvkcAHbLpKJEKJB1kGJK6M59hoWIP2A5fdpN9coze7VYfgV08rki1vxb
         MpmC/kggoUyBsbK+K1MKleSqxkFDTdPjyLQps9Gjfe7pKuZ6PLkXtLQwtt4F8YYixjo2
         CXcWmW3W1IGDOOGrFMkOzaMVTHbhEU0WQjJPhmfPBDAZ5vfp9vMnOt2algNSzI7mqv2f
         8u0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689237; x=1791294037;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c8RpwvKnWIvhPb3J3zGDHyi523YM5wN/XZAjJ2WhR4I=;
        b=TTpOaMCByxEeNUozXUAUhHb+okKVDl2sOVA3ehb6la95F1Daexvl9ElWDiDgivpLsz
         t7TQNsdB2A95HlUpIn9/4BO4c3UcTbA8fXCtcEezjfvLWeKC58oNQVubBVNmOQQx53g+
         UApRYBKhaUjdb8LER2J2tnKT46/v7UBB1TL8oE4+el4PepXCQylM9q+F4qGzJ+izfAxB
         y9Mvey+AP1YSXdtig7BnOYs7DPARnzhWVEd4hHqIneKG1aTL7s+17XBbA7cPppizz62u
         Uspd25CSEhBJqJByQPIfpSHN3sc/IT4DN6VOggVevqTYfH9xns5hLLJy6j5QUESCgVDy
         vmtw==
X-Gm-Message-State: AFuF++k/2+2j7D8HT6bVmS6XpwzIAa3jWgQHZd4+QC92e96Y9r/GJny1
	zORAA+GNaN/t8MiZQig4y93iR6ECxO2JMQCd2mbl6BtOoQhEl3JWERcDbE8/NQ==
X-Gm-Gg: AYBFou3YodohFSuiLUx6VuCbq64XsKQT50BjBIJOOOK6VGvP6oG0V7cvxxbZxclAw4I
	dGpAv7jpBmbD6gEpwePVQUSl45+annV0VKcrS/gi15+Aewf7djhQUV5OZpR5ZWtEUhHFfj7C+Rm
	USBQalG9xMdgOzqkAm5UGAFZ/Dzcir0n2BrmJxKJWBPX9yt+ah0XL+XmMqn5/FcpE5lyqw8YPQO
	FY9Nk85R6hVWtDp+ScwFuChuBIuBI37+vRYu6gF5IuGWaC5R/sPF+saCzLrV+X0qiWjBc/i27Vt
	VWXxIofS3nvDBdbt0bqkXj/2qKYEpSpzeqjzhbUjl5FGIh8h41P9wKjRKXqBvuhH1cw86E/GxPP
	xRvUIb6U6RQtRHGqWsoLq+gs4WIdIhc9mzM+O1g1GUrOKz1PRdX6YY4BV2M4khAneiyfy9iP4BP
	Zast6bb53a5meaW8fx4fbrnOTV4X//NiES1XSMq3EMu5zg4a4mBtGIvZ2DyShKFkoaKapA5iECc
	sx+mhY=
X-Received: by 2002:a05:6809:250:10b0:4e4:9d2b:58b6 with SMTP id 5614622812f47-4e49d2bd374mr5301316b6e.65.1790689237255;
        Tue, 29 Sep 2026 06:40:37 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.140.164])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ebb6ea02eesm4461295b6e.2.2026.09.29.06.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 06:40:36 -0700 (PDT)
Message-ID: <6abbbfd4.31957b85.77b97.9ec5@mx.google.com>
Date: Tue, 29 Sep 2026 06:40:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1535625616986907283=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [v5] Bluetooth: MGMT: Add management security level changed event
In-Reply-To: <20260929100923.252597-1-frederic.danis@collabora.com>
References: <20260929100923.252597-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1535625616986907283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1175986/

---Test result---

Test Summary:
CheckPatch                    PASS      1.70 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.38 seconds
CheckAllWarning               PASS      32.34 seconds
CheckSparse                   WARNING   35.77 seconds
BuildKernel32                 PASS      29.23 seconds
CheckKernelLLVM               PASS      38.48 seconds
TestRunnerSetup               PASS      752.77 seconds
TestRunner_l2cap-tester       PASS      12.40 seconds
TestRunner_iso-tester         PASS      10.63 seconds
TestRunner_bnep-tester        PASS      3.12 seconds
TestRunner_mgmt-tester        PASS      60.18 seconds
TestRunner_rfcomm-tester      PASS      5.22 seconds
TestRunner_sco-tester         PASS      5.87 seconds
TestRunner_ioctl-tester       PASS      4.64 seconds
TestRunner_mesh-tester        FAIL      7.83 seconds
TestRunner_smp-tester         PASS      4.33 seconds
TestRunner_userchan-tester    PASS      3.20 seconds
TestRunner_6lowpan-tester     PASS      4.39 seconds
IncrementalBuild              PASS      26.74 seconds

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
Mesh - Send cancel - 1                               Timed out    2.446 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/840

---
Regards,
Linux Bluetooth


--===============1535625616986907283==--
