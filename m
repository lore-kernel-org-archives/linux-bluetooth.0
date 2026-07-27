Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C83BB4A
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154766; cv=none; b=ucUlni4Ub2sHTBopjrfTCDtqw5jro8V8BYTQY6ho+crNbAY8snvLKtMLL8H/0UrLuuegJbmBWiVs6PQpMOE5DhsokWIJFTPzL+Cqru3TgOMVF71vzEWjfVdlCNwu2puWf8ZYEhLPWvdpnQzW7nv3LRXBlcWOFIXLJk6sreN6Njg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154766; c=relaxed/simple;
	bh=eqEPW/bpw0+iDEknYR6K9YzDrR2w0YBc1QqPm19UqVE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ATWK9bHrWbowjvpzXmP90Z/AP6Tgz9iTJ/gejgM8KNGD6bOjXIpW86rfnuw5+6Wc38Vm/fCdRvcGTyCCKWaCYtnELPFvCpqTYD7GLKyybZHt1vTC2ANqaJUiSL/11dXXpyL3Euk+4FApv3tzInrdVxJFHTTeamlBMvrY5uSnzCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIvElp82; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIvElp82"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb29ed2bbdso805123a34.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 05:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785154764; x=1785759564; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G/QRVQR8cM4WuEOC84FC/+YtfztAS1180Qhes0iAVEc=;
        b=aIvElp827RrVwuFE4x44X/Q4O1zLKpFTiUEeg25PQLWJzkq0qmM37g8Agwcys8znaU
         8h5686jceELpyNYuRC8MTu0OARGubHp9Kocr9YZ1RsuRxVXqM/Tx9rMLfKSOwhzqN+5H
         5bzPmXAr1LH4T2aZBn1FhWe9xhedRjooWvrTRcsAYNPAr23AYx49WxwRqrw4RSXI6yg3
         +I7R1sgz7+V48k67NOBon3kV4rGHDJrFoSbZVWUJHZ7NPr6Cl6gu+zngiGbCqRjE+Hue
         TIJb+puq/OANiMvaXq5vF47P0zxm+Q32AZY/6wubo5P7ktcnqV8Bs25Z5q2cATUmr8TH
         WAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785154764; x=1785759564;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G/QRVQR8cM4WuEOC84FC/+YtfztAS1180Qhes0iAVEc=;
        b=J1lEpm9hZ/15e5BHkfx3+dwcVbR+4KBGPo2VAjejDs59YF4FcGTGQ3q+xK9HndLDUy
         ZZs+f+YlKR4Blrs4fNWJmPf0GorzIPFXgmqcnVtQRF3Od3d2e9c9k6PrBGDVblQokf7e
         i3WraT54/Bn8tBy4X285e3FGkXxhcYpL5CfbNhfJvEG4vBljBY7cwOm6IrahRPjTfwOY
         Qjvk0UG0RoVggJqv/RIhBQO0rFS2Md33dQTlR+RdylAXeWbTLLpa5yRJOda9W7KAE8sc
         YnNLjZIWt0SneuDDz1GOi6OJgCAERCuyDF2PT8vzH1ZZblzt5ADiRiLMRAfeMyMqm0ez
         6ejA==
X-Gm-Message-State: AOJu0YyAO4dbkpUvNS0duvtsewmmji7bUWb8cASE3B7N6N99hewpqVRP
	KY55/lQclS3tk5rKkvdRCu6bqhkG1fcVyn9uP9RbI2xyvSZZ4YdpavHW6qfkhg==
X-Gm-Gg: AR+sD113zrBWbZ4EjgZ1tRYzaD7TAH38hpZsBBviro5fT1CPEZuncjmJVQvdffJ5Mpa
	rnR7Pp2wphDByVIPuEKgf59+v8iHU83OqfeN4YjqYnuSjtE7C3kj9Lv2JF6+wMIR3mumh4Vd+v0
	T+U1yACDhERb2+av7z8mTF97YHUEh9KKozrUKRCHm9rKT4wW4NnF9Yeel+uDMwZHsmh5G/QD1To
	4QRIPktCpg0EQuwE2qDe/Ir4bOWhqWvi2bnIScBnP/pCrkltvZLhWLPcCKhvuBrHuGldaOZCMmB
	9fZpvBnMehMdNt3zFPTGz9Bx4s1JCn11MJ7dM40q3Ha6S5EymI9kqvX1X36qaGq+rH5tjBZmkyy
	brSlGgux+VcEZ9HCudZS9895KiYIdmfh8XPwRNG8eDQJJdxsoTP6tyDBsP3arqmkt/iFGqp26BK
	ptts36h9OOJwjV4M5nn5ei0A==
X-Received: by 2002:a05:6830:370f:b0:7e9:b4cf:683b with SMTP id 46e09a7af769-7ee78ceade4mr7166255a34.27.1785154764276;
        Mon, 27 Jul 2026 05:19:24 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.136.248])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29e0ec50sm12650190a34.8.2026.07.27.05.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:19:23 -0700 (PDT)
Message-ID: <6a674ccb.88aec2a3.21009.9f00@mx.google.com>
Date: Mon, 27 Jul 2026 05:19:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6320560509310298726=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaojiale02@163.com
Subject: RE: [v2] Bluetooth: ISO: fix UAF in iso_conn_ready
In-Reply-To: <20260727090011.2814616-1-yaojiale02@163.com>
References: <20260727090011.2814616-1-yaojiale02@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6320560509310298726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1134987

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.26 seconds
CheckAllWarning               PASS      28.40 seconds
CheckSparse                   PASS      26.53 seconds
BuildKernel32                 PASS      24.64 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      462.18 seconds
TestRunner_iso-tester         FAIL      94.00 seconds
IncrementalBuild              PASS      23.68 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 141, Passed: 134 (95.0%), Failed: 7, Not Run: 0

Failed Test Cases
ISO Disconnect - Success                             Timed out    2.500 seconds
ISO Reconnect - Success                              Timed out    1.995 seconds
ISO Reconnect Send and Receive #16 - Success         Timed out    1.995 seconds
ISO Reconnect AC 6(i) - Success                      Timed out    2.372 seconds
ISO Reconnect AC 6(ii) - Success                     Timed out    1.998 seconds
ISO Broadcaster Reconnect - Success                  Timed out    2.792 seconds
ISO Broadcaster Receiver Defer Reconnect - Success   Timed out    2.333 seconds


https://github.com/bluez/bluetooth-next/pull/499

---
Regards,
Linux Bluetooth


--===============6320560509310298726==--
