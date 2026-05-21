Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97349384CE8
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366213; cv=none; b=Hpk/vSM+83IHMw+9YSxZotNz9fD/8Tk/XJdKHrwhs6/apMBXDunMUcRZmGCVGxfVaY+7ID2UevB0gqCsCYKd9lqK2bu5J9aI7qDOELhWJCfYS4L+AeoUaHSFu1ni/grQlbsE+sW5tUJlhohtSObv/U7F2M0KUv0FtULZYEp/xO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366213; c=relaxed/simple;
	bh=qZVcuAVLFcUnKfsbNLAHaMPu5cKAMF0A6TXe7uda1lU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KUDL2qo3YfHkipp80y3rj8rYjLd+SqLdo1a0X8zuLVmbHwsiUKWch8GesBkVEpe0dsfZ1Pt381FbkuKz87/H1FWM2AgtBY8gMJwWkFuvjaVdmYZPfNSlwTYDz59X9sJrW1UYyVzPKZK8RvCpwckVucbGN/wx35oSuLfLavQYQQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzfrOhDc; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzfrOhDc"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8b6ea7716bfso73024406d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779366211; x=1779971011; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u2BWCwDlijjwQ1U8DQhdQxlt3N9LLH0zAfaREYu2zgY=;
        b=jzfrOhDcE1OVVHvxEGZpg4sYgemDm0VWoB5xPvVxC17jiot3I4VjAiej2iMGJJycXb
         yanZjuwrbnklDNBdjFfE/4ItWVvmVH7t43XWlZ77eQ6URvVn/TU3s3SpdnORXhZy5dJx
         hjC4l6g+CxER6fb6U/kHle3XRplxGBdgxfQNMGJ2Z2zXuQlJIwnkC5KFES6kx6Caeq/f
         Kn3D1n6o3jCYR8FSqic6fVd/khfS1fV6aAC76zdAANbvB+gJcWTs3ftiitpX9JU9CQAf
         rrZmtPfxFAWoEWQhogMGH1sLbn7m3JO+EPx5SWiP/zIKWynuxCAkWUk7gYH1QTql6fTe
         iQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779366211; x=1779971011;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2BWCwDlijjwQ1U8DQhdQxlt3N9LLH0zAfaREYu2zgY=;
        b=Et06vCxdptFvgSZoxXpqvlUlU8hHPMQ3vuJ6NN9FwW7JeOJ3aZENDshdUAq1mO+mkk
         fgnuEdUTsntBWqsKdYVqnuwYFBBeqjong54uBwMA2xjwLIvFgbFhy4s2t1YwSzv1wru6
         CoUCl32WCCx+a7kQcnhhsKRZajEGfZtdBhLBrgmMBJ1T7Unc+g8cJyvkXQc+YCfcS+bU
         W9UG9ciuXKNAuq8Yzp4wkNVs21fm1RzJ9ZVcGXF03lVYulqfFMzCAjL4ACW85CoXpQQd
         SylbtbGnnbVnuIWX8AyZAO+avvemK5n7D9wkAcxkSH8PigSaMHzAtyE0nK47KU1jpjN0
         2jxQ==
X-Gm-Message-State: AOJu0Yz2GKzip6fs9XC9vGX1TsTgEm3iwwYiobPcsZl3JinuBN/7K8cP
	plHFoKRkyEalup5xoAhE9ILI/9RMH31b5OFnygOcVVqgHqyhzxObH+4kGLKVGg==
X-Gm-Gg: Acq92OFH2VqwmznOtY4PSnTR8piOwBAcsA00lPzWL69zoS7rX2Y13myP+ldVtXE71GY
	kD9r0Q8LxItGoGyRNj0kQ7LBYDrWpJrXmQFNqhKb1XwfN4MVx9vS7899J4csfE4Y79dW4K1Vc9u
	lBnX0jtepoJ1MBTxK350PD2lDlhDb3Sqxc2czjvNxldiAAHbisDGT+ShgB7rNVKrlrHWdX80Ls/
	RjdXUBDdEx91VIdYdhxJdkFDx9gLZvCc52hlIDhva4b6/4HduSSyat/fStg9o8WLeJ1PU5//CTM
	NIvcZw3icKqY5rPYALRSGLiUuk5qeWB8eZGhoLqkXFJn9UvgyPMgZJOYmdRQ+/ULiGoHuktx7pI
	ZgjTI9DfBXYTaHGsRBPCNJ/21tdycAHucPeKPE8aVRR0J6Ptkb77LY/DtdyG5z/IfqKOpRMKLPI
	ReQad5lB7+kBKcCzq6UuKfBv+LUP+dZunz
X-Received: by 2002:a05:6214:c26:b0:8ac:b738:45dd with SMTP id 6a1803df08f44-8cc6e675678mr35677036d6.34.1779366211471;
        Thu, 21 May 2026 05:23:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.207.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc768b4d50sm3831696d6.10.2026.05.21.05.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:23:31 -0700 (PDT)
Message-ID: <6a0ef943.beeecc10.280efd.8a3a@mx.google.com>
Date: Thu, 21 May 2026 05:23:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2592612589533088335=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jhapavitra98@gmail.com
Subject: RE: Bluetooth: hci_conn: Fix memory leak in hci_le_big_terminate()
In-Reply-To: <20260521080414.44460-1-jhapavitra98@gmail.com>
References: <20260521080414.44460-1-jhapavitra98@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2592612589533088335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098541

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.54 seconds
CheckAllWarning               PASS      29.95 seconds
CheckSparse                   PASS      28.59 seconds
BuildKernel32                 PASS      26.38 seconds
TestRunnerSetup               PASS      589.00 seconds
TestRunner_l2cap-tester       PASS      379.35 seconds
TestRunner_iso-tester         PASS      597.75 seconds
TestRunner_bnep-tester        PASS      19.30 seconds
TestRunner_mgmt-tester        PASS      2024.30 seconds
TestRunner_rfcomm-tester      PASS      63.92 seconds
TestRunner_sco-tester         PASS      142.85 seconds
TestRunner_ioctl-tester       PASS      134.60 seconds
TestRunner_mesh-tester        PASS      60.19 seconds
TestRunner_smp-tester         PASS      18.14 seconds
TestRunner_userchan-tester    PASS      19.35 seconds
TestRunner_6lowpan-tester     PASS      51.23 seconds
IncrementalBuild              PASS      25.94 seconds



https://github.com/bluez/bluetooth-next/pull/229

---
Regards,
Linux Bluetooth


--===============2592612589533088335==--
