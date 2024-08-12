Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060A31EA8D
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478561; cv=none; b=g+3iGmqeci9rhlFfaMjdo4JijX8rdSqV93vuK4pMwy0W9AvEOGktNNTuq3ISByMHbvmE39Ov1ZyOg/mcZeDi5R3lv2WyiaFJtZeXF+Ueuc2Uby/SvcLbDjCPOc4SEjsYl3b1m+JSAgztHwiLyCos6VBQ3OHNJ0Fzu7mIph8PTe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478561; c=relaxed/simple;
	bh=v0frGAuEBdAi5vv9G2W3dJLzVqEnYEl9spRXQ4Rb/t0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=i7Lm0CbwlGyw6f3kSzcQHtJIE0XN2/mnZ/xrciduGo/I0STzAY76LJa1gVO/1PlSAtphzaRXTzMgO0u+1XVKP3MDNnJn7i1McDB03ChBZCSiY1w9IiGe1SV6BYOeoPJzqLynH7VheTUR2M5F38sUu0SID8P2afWyUb2z2SvE+lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtQCaN2Z; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtQCaN2Z"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44fe9aa3bfaso26588351cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723478559; x=1724083359; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AYHSm3nMsxcEqUuVrjP0bJlEgWDPNtzNrMP/5IWOb+c=;
        b=WtQCaN2Zos5lpsdZO3dlPZ30CfUy8YkOIMEO5s5qLzN/RnIg4nNR0GGiAHe4YD1oay
         pKor68zLp1vXiaCg8ysXN0dAkUr9C/iVfrNaUdppLy0eGR/nwni1axRR80yV08ABrFRl
         ZfRH/LscfOvOw8hVfZ08d6tMkxSKgV69YyNokSD7z2+8LHx15spbWWZ8HJZHE+T1AETo
         h7X//XLvIIxILBVn/O93U3DLNnCRYcWVR84Kb06oiF619fjh3I91vqr6+0btsOSBSSIg
         z1Of8SzaGe0oFoYy7xy4YxK32B//Vj7KmMX+lhMQuZGb/q8/Rc+egzW4b//Kv+hZW7q5
         JoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723478559; x=1724083359;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYHSm3nMsxcEqUuVrjP0bJlEgWDPNtzNrMP/5IWOb+c=;
        b=gsAnSxi21cSYs67xYD4wF68wCx2DZk+FlI4ybqyS/vjzohmwzAFUw4T3XFdVMu1ckg
         UAuhujBPANWlm9rjBuf07ypsTUMuB5S/tfZa252FMbSUffCDInImZeM302vwG86RuizJ
         RCK6GVPg1d6TEypahee8Bn3mpiGEp2ncM+WvpFUlx9+qFhdY6zwQFoSutGKHQ8U8hbeD
         LsHozflWr8UJ8PgoR+lUnVYbyYeqmGWkXxC6EyapP5fz4mbuWBKfHvuwtx4W++1Xr5HX
         0RR/l07sDsXJHiQlR5NF+wA+Gxtgsd1GgrQfz24/dyJFKGCbAo+58A0dBo9OkRXZGIR8
         Mm2g==
X-Gm-Message-State: AOJu0YxNON7599Z0qjkOSEFXgM7l9KVgnoeKdhJc/tix6p7o0+I48zyx
	A10kKm4yfyKSL30UCRUkJGuN8pg9le84P27BiwIimYXE5TfC3TR325/QcWh+
X-Google-Smtp-Source: AGHT+IGYlTbrZff9ODaquArA1iIuEcOABPIzkuPL0X5kGzhijxPFbou58tIo3+O3urAreVV1uCUe6Q==
X-Received: by 2002:a05:6214:4187:b0:6b5:da50:ac1f with SMTP id 6a1803df08f44-6bf4f838ee1mr5949876d6.38.1723478558487;
        Mon, 12 Aug 2024 09:02:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.6.135])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c7e6e0sm26269186d6.38.2024.08.12.09.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:02:38 -0700 (PDT)
Message-ID: <66ba321e.d40a0220.192685.761e@mx.google.com>
Date: Mon, 12 Aug 2024 09:02:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3493193680895886884=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: HCI: Invert LE State quirk to be opt-out rather then opt-in
In-Reply-To: <20240812145359.272554-1-luiz.dentz@gmail.com>
References: <20240812145359.272554-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3493193680895886884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=878842

---Test result---

Test Summary:
CheckPatch                    PASS      18.81 seconds
GitLint                       PASS      28.13 seconds
SubjectPrefix                 PENDING   32.31 seconds
BuildKernel                   PASS      54.78 seconds
CheckAllWarning               PASS      52.60 seconds
CheckSparse                   WARNING   45.15 seconds
CheckSmatch                   WARNING   127.26 seconds
BuildKernel32                 PASS      42.69 seconds
TestRunnerSetup               PASS      531.38 seconds
TestRunner_l2cap-tester       PASS      22.04 seconds
TestRunner_iso-tester         FAIL      35.36 seconds
TestRunner_bnep-tester        PASS      4.86 seconds
TestRunner_mgmt-tester        PASS      109.25 seconds
TestRunner_rfcomm-tester      PASS      7.47 seconds
TestRunner_sco-tester         PASS      15.15 seconds
TestRunner_ioctl-tester       PASS      7.97 seconds
TestRunner_mesh-tester        PASS      5.94 seconds
TestRunner_smp-tester         PASS      7.05 seconds
TestRunner_userchan-tester    PASS      5.09 seconds
IncrementalBuild              PASS      28.92 seconds

Details
##############################
Test: SubjectPrefix - PENDING
Desc: Check subject contains "Bluetooth" prefix
Output:

##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.230 seconds


---
Regards,
Linux Bluetooth


--===============3493193680895886884==--
