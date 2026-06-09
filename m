Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C80039903E
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996535; cv=none; b=tl2vhZzAON1JdPwhxRAi+CNSX7szRl4p+W+6IIT9NYuarnhXVQHBayUpeAtI3CKXm+nMMpbvoYULJhQPPc0djq2NhHnx/ehKDdS3XcJMAGPC6Y/y8vGkzEdbhinXpMnkCbQNKf70XWGwPAaE84lp3oF2REDsLbFOfoZJX5C7nTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996535; c=relaxed/simple;
	bh=cXLkyCOfzehlvEpqb2LxFjYezNjigWDaQp/sblYJXb8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Mkh6iacDwKkQ4w7omJ0RJTyqMVpt1PKrALK6On6IehszJM3jDdr2qECbRTNcYsKX7d4bTCiWsVvU/fx+sFnyPGQj6woGrCrHU0+fc3O3I/o4AtATLPo0HVlxXiwqvq72/lMLOk2qW/7jIxc7Sjv/WOIuhVsVCXWkYQS/CezhCVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKAxu5iS; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKAxu5iS"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304c520fe9aso8659069eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780996534; x=1781601334; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XlOo6oQ7Bg4z9+cHC1jk6LNYB4JXIabT8RooAIcJSqI=;
        b=lKAxu5iS9k0pz6djAIFWFsCsTyyyAkEy4f10oz3KBm3/JAV3av4cQXi+xiqDqJXc4w
         wx0Xv1iTUzXDDJ138hihrm0tcoRsTxTNs648kdHuwFrdBOTw7uM6aVCUxDZJzrCk4H2R
         uU7NQW8DJcLMKTTZ/6hyxzSQ+QurmHtFWUKnSRzUxhb+JHLQMiAscclcNAgHjxLRTKYZ
         Wwl/eiHoE2mDsmb8QQDlrfBPK7zY5mojkv7KLYs43OJqWH8nDIatlUfDEPON0F3xhxic
         V5vnr4BbrSlWPNv1Le/A1iPx0xESxaccqJvP+OvmZM7kcwH9XAWQTWrpdsiseqKcIUNu
         u5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780996534; x=1781601334;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlOo6oQ7Bg4z9+cHC1jk6LNYB4JXIabT8RooAIcJSqI=;
        b=ee13uBOBOgdbVJBI9dQzMvjfBgiCnWtcwlrQnC5GYWMogkLeD6rT9dV7I/DQ6adoof
         qZnjaH88QwwFRqWO19CNKXh/oY6OZkYf2x16NKnakUGpBrY5GbsZoJK0KiUKFxNFtkjP
         Z1rofWxF9LFncCI+aCgqu/W1+EL7vKbeR1+YkzGRNRuMRthMX5jfjQNl5g9C5MsXno6b
         Myb5zD67Z3kXHMecfJ/Yxho3HK6dWuI2QqPCaj4kTKS6ddozOmWR3BmydW9raWIbEwHf
         mnBSJNpAYK9SJbQe5GOwaAxUSuA+Gunh/Of+AHX4mr6AEvvJS/B29dDqCbimkuhZqSqc
         5JXA==
X-Gm-Message-State: AOJu0Yzh1vQQrQNUTQuTeEb61vInN44W8/JLI/9hM0tk7Kcj0DrWmwC4
	cAUT7nl2KIoajT7r/ZyV0p6o33HqH+oIoA+pBlUVqPM8PLMU9ojxiWe2zbcn//bE
X-Gm-Gg: Acq92OGVxUIS4AY6jWMspmKno/Zlkx3paDvuA/4/Nr4nt0J1qtYbn84YlsBXra7kVFi
	XeLW56bLaTj5BkBFFCb1owQ0ieS24BjuqJQLryO88F0Xpa6c6tg7oEZR6cXrfQ/s44DGG/ZuYKW
	5olUabuY1Z53SqfvUYv1pY/U+5qk+vmrPdu6G6PljwyINbe+GWadFEFIlG4iBaQUrHPtcoCGKP3
	70/lfFhZvv6p3R1JZRHZM3BA6hANw3/cBp/0NxjLkBl/Nq6az4i2WB4VScLtaYJhB037P8cTJB8
	UVds2bqfdk9WXg6dazb2PAp6ajmIsHOe8BBkuWq5U+7hen7cQxjJR94wI3Osc9EpJY1Lz8ggAS1
	ko2gAoReQBBXz19mQu3eGVG+8WdgiD8W9FRx4WoV9lpvner+CVxhvAmpI+QSUyHWH1wBqog9lkS
	O5qmeBwNq9LLhmBJL3ciMRMB/q2bLNKhDr1zMbWsWZ+Q==
X-Received: by 2002:a05:7300:818b:b0:307:140f:d511 with SMTP id 5a478bee46e88-3077b8b172amr11011763eec.33.1780996533635;
        Tue, 09 Jun 2026 02:15:33 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.143.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df9bbd4sm18618367eec.30.2026.06.09.02.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:15:33 -0700 (PDT)
Message-ID: <6a27d9b5.7554299c.24e399.86f3@mx.google.com>
Date: Tue, 09 Jun 2026 02:15:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3194914917412797519=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiuzhuo.shang@oss.qualcomm.com
Subject: RE: [v1] Bluetooth: qca: Add BT FW build version log
In-Reply-To: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com>
References: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3194914917412797519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108364

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      19.65 seconds
CheckAllWarning               PASS      21.90 seconds
CheckSparse                   PASS      20.60 seconds
BuildKernel32                 PASS      19.93 seconds
TestRunnerSetup               PASS      414.40 seconds
IncrementalBuild              PASS      21.45 seconds



https://github.com/bluez/bluetooth-next/pull/297

---
Regards,
Linux Bluetooth


--===============3194914917412797519==--
