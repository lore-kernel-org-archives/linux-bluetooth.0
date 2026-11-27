Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795819053;
	b=Ocd6oGGtp8HCa88O4ohNoZWbTmvTVHCDkGyblshT7mtTA4AsXSgnKzptY9YFKZgaKrbu
	 BjV2Sas/hLeEIdNmtjNgTnLP92B7gXrgW23aRQxn1iSqBi0XeQeOxyXmpP4uGw8vSrhi5
	 xEdLLxdUSmkcZVHyGyr9B5TlUMhWqCgGYRiaxi41UljhezhFJEAWCZ8lCB8eiC2LPiH0q
	 rwd/KIt0KT4soyt0Q9eOpWuIQjoNs9lnAQAobeGQX95w1SypNFkTB/QYk+3xPxZL1cpiv
	 SvyPlGSEevl4DhSZWgGmqiXYIH31x9ZHoF7AcHkZTx1WR2ZUXcyI9xKdzYV4EoYGYOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795819053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=iEr0kQ4IeGcJH330EgRIkitNnTYVol4HxWsHcWMdwz8=;
	b=2HwDsBOQvS/7yx4RcHNhZDAquzAUSJXg9FNwTQO4qh+6TFBn4mgyoIhB20ZM1ziEh5tm
	 W+4eAFYeYpCpr/lTRXroR/dwUrrDMohy0yqYnRPlb4G9hPVxVCmDqwfFvHTYy3RO6To5D
	 Myrb7eWWnH/Jpwm3D2izz/A55rUug5pKVg6PwCpnhZDDbMruFqqI1kFgVBZpUx3omXLjR
	 v6pXREjjrcSZJOigA0hc7UsDpGjQSiCO7WQwpjq5kjkvsOybHnzVlW1rwlIT2WTalkjqm
	 FhVVdMljM5CQu4G+HcCKqNOsCJArFXqMZ4J0qB48wNxX5Juml0ob2/M+whHqwWpm/gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=myEVMmKw;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E94606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 22:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E94606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=myEVMmKw
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso112139196d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 14:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795819052; x=1796423852; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iEr0kQ4IeGcJH330EgRIkitNnTYVol4HxWsHcWMdwz8=;
        b=myEVMmKw+B38R3qxXfW41biPhl2zBksqCZwmRWM5tVysVxkE56oPQjFVGu6RW3zskb
         ez4SNtvJqJSHT1lN/oUCh88rmgwkN64O4YIV8PAASDjLYVZjauEm6cu894ntJYehCgPb
         pufgTtBcQsgV2I8Bj++XZsaGADbwO1B75MZ7NY0i7NxYaBzPU+kwvo72ma4lEdIP3bB3
         qgi+7P9YoqJU6sNXGuv72WOPyN4/id9oRSEjwjFl/6nZ1sg2nwj7K5Ms9VGfU/YfgpuP
         LaP3vTHQyaUapJYf/js/JAUoHsDvhRN0o/M+mZAXQGkpkVKGbSDEAP570sJbMRKfnLtD
         dsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795819052; x=1796423852;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iEr0kQ4IeGcJH330EgRIkitNnTYVol4HxWsHcWMdwz8=;
        b=miK6e4yS72wDKZwRlu0D1yv1kp7MgD0OAPHFk43X+PItXL7Tc2IrsqB+MKW/Q5xGWw
         3MlKy8G4SlanhMH27kt6zpg6/eFboZvK4C0SQPdCa425omgK5oNQ3OyO9A2m6KOPQbmC
         Vzy2S9ZVluCpvj+AVm77K9X0b3JzyvDw3PV3qY3ALEWpL1o8DGya7EFJYSS4phDBrIp5
         6OzkSpa7jP89bO0tz1mNW7s+kfNh/B9t/a3zvFbQe7XulmGFSlXScX7L6pXzlTkq8iPr
         5eADgtDcE7lyWeBAxoSPJ/gWfI9gCGKbDlatSyQ6H8mtp2AaDyGSEh90pgPkDzJpJ++M
         8/Cw==
X-Gm-Message-State: APuU4Z9UNgGdNJ8ExC4Boh8WiI0UuOqemFAM2KeBzncWiqOfk/z6a082
	rg037QrzlLurdxL9JEt2XvMutp6fNEC6OgL/0DXUyrOiS8Ql7F7iuPCGR+sxOQ==
X-Gm-Gg: AZFdTZdFTKDGE2UbFbCjpuUl+mMU5P4IuJAk9XbzQgLtSQtIyQmxEeyeKOhcezG3aXA
	gVpfc6MdxUpUT+gBTLFN8u5P8LYlU9smP1w7GKGlo/NWQa7vKDC/fA584b+7gd20Ia87OD9WCjz
	BMzMhDdpOqGcdEb3wiKM1lZuvtrc6HUspkA8xsUjNQd/lKkzbtr+57IbYs1Je0shdCjvUmiiddk
	4GLl7EgKySaC5ZwkocWu6AGs7KWoDShayDszzwLU1m5+7JT5KRaMhlKtvcu5xNVGRVmR8RJwu9K
	vQIxamArVn06KL0hXhfJQTqKe29Ezbtw5TFBzGYkjVAyFaKchBYH+x2mvfhwptHQIiUXxvyGjhC
	/cs3QdG2XeZIiBNDOLb1PJ/Iun9oHPTy3vti/AuFzQeOvdI0E7RoCJmX7/ENfYvE6Y2ghSfUAly
	rpiI/TVTgQNpCedeHzTKi+U91FJdg7NBfy85J7ynUIVJflP7RywYWSI1yUZM9MqjXR0E0E7UmUk
	hRQSMXOpVP71pxnLIiO3UNKvDrUpRS+WKj9jaeSSjI/8LlGAhB21qHZgmJqbod15d2E2RCsSHsr
	XKzGDAVm6gGiKDhxfhiJ+JAzSjV/
X-Received: by 2002:a05:6214:528a:b0:91f:171b:e02b with SMTP id 6a1803df08f44-92134b3fff4mr453883376d6.35.1795819052261;
        Fri, 27 Nov 2026 14:37:32 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-41-210-70.compute-1.amazonaws.com. [3.41.210.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a15b99sm226893726d6.38.2026.11.27.14.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 14:37:31 -0800 (PST)
Message-ID: <6b0a062b.d2b3e211.33913b.48ea@mx.google.com>
Date: Fri, 27 Nov 2026 14:37:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4032598053346183550=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dickson.wu@certik.com
Subject: RE: Bluetooth: SMP: keep pairing keys private until pairing completes
In-Reply-To: <20261127-bt-smp-n-v1-1-e123c04c15be@certik.com>
References: <20261127-bt-smp-n-v1-1-e123c04c15be@certik.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4032598053346183550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1224864/

---Test result---

Test Summary:
CheckPatch                    PASS      1.64 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.55 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      19.92 seconds
CheckAllWarning               PASS      23.71 seconds
CheckSparse                   WARNING   24.80 seconds
BuildKernel32                 PASS      20.64 seconds
CheckKernelLLVM               PASS      20.83 seconds
TestRunnerSetup               PASS      484.33 seconds
TestRunner_l2cap-tester       PASS      14.20 seconds
TestRunner_iso-tester         PASS      15.78 seconds
TestRunner_bnep-tester        PASS      3.15 seconds
TestRunner_mgmt-tester        PASS      85.07 seconds
TestRunner_rfcomm-tester      PASS      4.43 seconds
TestRunner_sco-tester         PASS      5.46 seconds
TestRunner_ioctl-tester       PASS      4.53 seconds
TestRunner_mesh-tester        PASS      4.48 seconds
TestRunner_smp-tester         PASS      4.35 seconds
TestRunner_userchan-tester    PASS      3.24 seconds
TestRunner_6lowpan-tester     PASS      4.42 seconds
IncrementalBuild              PASS      32.48 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1248

---
Regards,
Linux Bluetooth


--===============4032598053346183550==--
