Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F342AE78
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784394031; cv=none; b=SyUswjPK2o/4TNpWdcf1rkiah1Bkac2pxCOKudycEvLfUp2SZ+i/35Pz0G+bPqu0qXV8z5ERRPQUUzUDoa93fWUJQkQWmV1KWbPc5Jegj7Lvesy9O4Tz0kkwnH632Jss02JWtK9EiFVQwKgZdQ5ybGGKRxh9eKvgdzbELyUrTtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784394031; c=relaxed/simple;
	bh=iHw4qUJTvx1vf1sXuYjmMZ9WP7b4Ci75jg0Af9ZkjHU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GvXgZfLIAr68STX6F0+vwd5eUhvNiAvZvfGBU9cbM9IDBw7WDAosnIq+Ewt7QrUu819rAJ1DXmrVLT+zgKnoy+LiKkf+o/8ZY9Oto6I9Qusii/qn2m1NPDsKWvCJuI/Z9STnVluLzMaShxjqIkoA+gfeSCFpR73oVudJzTFTsKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNjmbO+j; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNjmbO+j"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e5b048375so634075685a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784394029; x=1784998829; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IizS1+Gq006/gnuYBOVCCYkWNVkro8zZUb9v0x0N9n4=;
        b=fNjmbO+j6nMWvcF9Hi9vp8E+kZ3ibQTByttrqrWidAQ83OjALgVF/4GiEx20Xyn5mJ
         XfwEPXZ4Y5cBZ8s1lVCj1P/n+SWyV9IXUthY13u8lQTHkqnfWPb1bN3UCDKnrdxsI/KM
         PJL+Tpib905GHL/S0a1BdtFyMcxkB5PRBauLXKKrVTpi0I+5F3jq2h7eRS16WIGWOmqV
         QuLrF+MMvosc6ROXVeQ8cTIhryJdiCa0Yml9JwoXTVy30i0coeSQrxZ/o/wshSUWEBjr
         BHH4nrhQLwfye9LPjRMnXEIprLrhBASGFFi0lOirXh4Wq0Q+WlyMtlda9h8o0OfQoM4b
         neCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784394029; x=1784998829;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IizS1+Gq006/gnuYBOVCCYkWNVkro8zZUb9v0x0N9n4=;
        b=POeOMS1BwOto6gldi3w3RJCuNzfd+mq56qonUIG7CnczqPYpvDsqlf8Cn8BlaecZW7
         SoA+Bx1mdVskhcUbQAU0Ytaqql5QuS6WLnz7vSSopyvA1oXvVszJz+h4RRuzVc0yY4d1
         G9aDR19p9POcAkTXGbjU8ih4S4cBgiGWuDratAQ+A6iVEPAOUZc/e18mQ8fLVLJVwsJt
         fn3yXlbiysJiVth9KBmI2/TAkvKvu6gX4cpghQ4nRMlQCsQSSb4XVcpJjXSEBhausuyM
         eYhdES/z0nHEL6SQ/YsIZmjotxsRlOarUn3rOJ+YU9eqApS+PtRRpTb4Auu6hbORUDlw
         vBxw==
X-Gm-Message-State: AOJu0YzKgHQn6X2Pku8tUsMvqYjh6P8XhohRknzMG656ECmXTSPXxqJk
	dwHxFojFecGG7RHHq/eSd9TGC+QvONmg/PybULhipNo0nsIZVY0P45rtrxKhVQ==
X-Gm-Gg: AfdE7cmmlvN4zFHAaP+npStt1Sk343c8yg4chVbWEzX2UG9NLqfT3LLdTxeEhtnoZk5
	cAt0kzYP5nWRynLDo5WhvrdMOYyVj3VHCQRqFJXQ2GZF5RQ+Scdkwt1QoGTatVzUkBZ/vmgcLT9
	p1Z+oE+f58He8Rgquziq9FlGpFFfqAmxVQrtY8NePccCN3+af1lldjeLnV+qoM+hbTzysT6uZLq
	L3Wm5QApWayUv2dVJAiebWZDMeMvQK6KUupswX8OjgD96DY3yAWtZdL1odukTNnBNDIyXtlz/ON
	l2jbQXmf5ZW+aUW0sxf/Bpk0DNoiqOMCheYHJ0XPI7d5145BcWHxsbkwyNvVTdLSl7CgU9wcZg7
	bBY69UOUo5Lf8u/z7SgURg26F4LBEGQfEpoQ82F4sx8ZzZXr3rYF4UXVwjd/FY/KjwPD7ApE7E4
	PDgUN3QpCF5vk9I0q7ZFSG
X-Received: by 2002:a05:620a:4483:b0:92e:4859:49dd with SMTP id af79cd13be357-930b3eaaad0mr738401285a.26.1784394029101;
        Sat, 18 Jul 2026 10:00:29 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.122.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b5494c02sm444215685a.45.2026.07.18.10.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 10:00:28 -0700 (PDT)
Message-ID: <6a5bb12c.4a395752.3867c8.195c@mx.google.com>
Date: Sat, 18 Jul 2026 10:00:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4228370127816702894=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, u.kleine-koenig@baylibre.com
Subject: RE: Bluetooth: hci_bcm4377: Use named initializers for pci_device_id array
In-Reply-To: <20260504160940.2168650-2-u.kleine-koenig@baylibre.com>
References: <20260504160940.2168650-2-u.kleine-koenig@baylibre.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4228370127816702894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1089397

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.64 seconds
CheckAllWarning               PASS      28.11 seconds
CheckSparse                   PASS      26.77 seconds
BuildKernel32                 PASS      25.05 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      467.42 seconds
IncrementalBuild              PASS      24.68 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/454

---
Regards,
Linux Bluetooth


--===============4228370127816702894==--
