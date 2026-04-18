Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93925771
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776535063; cv=none; b=LG1RVixr4AwBLXYFweeLg9vz196CPEUaHTfx+xdL3dBjv3bWS3ae5eAGYCNDRKjocoIXUbhsnx0RJ/4qR4/ua/PC4Xw7GzTx0w3+lNv2IgVZi4sSCMRwOPVUHa2ubpoou5xd71z3mENP5p3EzHxEqeYJyLob9o0zmeQiN4XH4go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776535063; c=relaxed/simple;
	bh=3ngg/kW6xqncdL/qQ3l5bBEsMxXsPG8V1eW2+m+kO98=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nQQsT2S7h+clRdua8Hq8Jiql5DUuFb61qoXTQVd6Qkc03HyJ8u4UL00dWVyzvdzfcR/qR3a2RgiMdFXZF4SZQZf/EzQ20VIcQ+9R6lziVY6JG4NUJYfilNY+cpsUl5KaT0TGStqy1BI4Xye2J95+gIMLaAN1hLUHAZ0MyjWHAEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5DKa3UI; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5DKa3UI"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d933da14f0so176860385a.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 10:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776535061; x=1777139861; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=91QXVMt8YFrb57+Hg2sWQMX+tTQEYBWExs5IkNqrNlM=;
        b=p5DKa3UI5YLyrh/SYttUydBGc6m2NxDjve1ZUdFHyd5ULov83OHVhkbEyGy0QpOEYV
         IyTnklCeWKZLMfof2yrF6my1uAMDKqYOQv9BCn2IE0AKC+xyoq2Av4xL+2ChrN9BuAUT
         22hCWRi+mUM6LY2ODjCJQdKQ1U9khg+1er86CYS2tjInQN+R4+NpwHB+itmLwWz8Gu5Y
         XSh6dqxyZ9FHW4ostoRahOlpwZaXUKY464wQrr0EKn9ZMVNjm6S6gGp7ABGJsSLbqiV8
         zLnXcUdPWiZP1sWbuxIA8GCQuWfCvnVI9p03DJKmVUBVrv6paWHnALeZGij4/BfnmpPX
         P/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776535061; x=1777139861;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91QXVMt8YFrb57+Hg2sWQMX+tTQEYBWExs5IkNqrNlM=;
        b=IAdu7oQVpzQRVlWgfb1Svk4po2vjBVdxYJdzESDURE8Qlw/akAU/sDQ+H6s/Ok0gnR
         HkVa3Tq6Xvwq01REYhLzW/v9rG95rEFxs5VvKavN9MhPBJ0yF4ArV+uWAXY8c930GDSr
         XJQq0I7qQxV+bC/7EUUmTOcRe5ixVfANGsN6+BT4O95q9H9wO3y8BCtoZElf1KmzKkP9
         kN5SFtFSLl61fjk6Tf5GKe+n/EXhcexIEeLevW4rSxWk7/aSDNsk4cDkEPt9uKLNMnlb
         hq/M4Jq/0431BFSmTFXA04F4OwymDkO7Saf/bbubKsEDkLqPdEK2EniJmlbdgFmMn2lX
         QBpA==
X-Gm-Message-State: AOJu0Yyg+0ZO24Wrq+p2YdCDZrperPMgnQK6VPUsnWDTFJfqtcz+A4Wf
	dbyOYq04NHbh+Ts7NC4FMI5xcerN5bdlQXoGDqQfFKxibfl2+ls5Wt0W94ixCg==
X-Gm-Gg: AeBDieuyBXhRlDqd0EfdnFgzrUMCu/rwIzQ0zh/NO/f792MYs3axtsdkecCh2hRqmXq
	UDXmEw8L4kUpajeTsdVnsIqaHwMkIBsqSR9vq0ZkGNoY4MFRNdr1Js1UoYIPAEVyiMVLBPliNe5
	r74cCz/xYCqZBntaREhcJkn3yYLOvmuCIsnFYHUmGCU22ETRaHkYvvRSxymf339GcMrPx1rtoD3
	Ea4CQKOzK9ELKwjH4ScEhfAmCLlRW7H9JaYpaOl4auT+l9ort0HGcjeZpUu3Th7Qxiqbyy2SGv3
	jbUTxGSkwMexyNE39O7o1D0YN8/zO9WdjAClvzpF9KYGy5+kBXZMk2P+r1xWABpLzsRSgxKuv9u
	WOlqVzVkdIZQ316koIfy5uwYHqVg1lYJ9MrdoSiF59OvS/XztxkCYfwKGhyNyqrdayE1NczD7BZ
	lb+CKfYotGkP2LeO7krtW2JnliJsbqwwFWXb+XCsZ8cYI=
X-Received: by 2002:a05:620a:bcd:b0:8cf:d88d:c458 with SMTP id af79cd13be357-8e7912c3a6dmr1106179485a.38.1776535060729;
        Sat, 18 Apr 2026 10:57:40 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.223.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69abee3sm383201785a.17.2026.04.18.10.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 10:57:40 -0700 (PDT)
Message-ID: <69e3c614.050a0220.b443.8741@mx.google.com>
Date: Sat, 18 Apr 2026 10:57:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3057190883385893779=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, condorachest@gmail.com
Subject: RE: [1/2] adapter: add DisableDiscoveryOnConnect option for combo chip coexistence
In-Reply-To: <20260418162652.287637-1-condorachest@gmail.com>
References: <20260418162652.287637-1-condorachest@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3057190883385893779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082814

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       PASS      0.63 seconds
BuildEll                      PASS      20.19 seconds
BluezMake                     PASS      607.56 seconds
MakeCheck                     PASS      19.25 seconds
MakeDistcheck                 PASS      234.43 seconds
CheckValgrind                 PASS      275.18 seconds
CheckSmatch                   WARNING   319.17 seconds
bluezmakeextell               PASS      163.94 seconds
IncrementalBuild              PASS      614.25 seconds
ScanBuild                     PASS      906.25 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2055

---
Regards,
Linux Bluetooth


--===============3057190883385893779==--
