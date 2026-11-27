Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795819511;
	b=b7FjbfcAgDHixjSgCxeh7MdF4CjGJuhwKIFzsdqwp63k686xtc+/M82UeELO0cH1VCYG
	 T6cDWkYI6LqtCpJoH4u+jDhayEE6kkml4fE2nNsH+7coPIza1cviiZOKZV9sX6HbWAf4m
	 I1eqB6JQ+dwe/UWOIxD25OWfocqqrIanAS0TOOW6ZYQGh8pvWlczt24rqeiluFsSzZQVL
	 4l5af36m04X8oM7XXe3qEYfAakVc1tRrYi/NKph4CjRDfcu71PV7w+IX4l6BnTuEmkk2g
	 f8OgCNUJ3JhIp3uXx139MfXq64v2xVmS1Wb/30Xl0tht7431ROGmmckK5Nd63psfl5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795819511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=LDw3wVc+23YV5VvE1MLLIrJOoWeG+A7jfdl53rl+OiA=;
	b=EJ50yK6VDrzebWdKPSXejbkrTU4uDU7VvAq8kisk+AOL4XqULo5YwqP4vU293nNO83l8
	 H3w3R/bbR7pag3vwiYQZ0Jp4Z1CeftuyiUR/dQeKOtc6eNRkXQd1BH7NDSr6dG89R96Z1
	 xY8vI2MkXpgHPsJeqraQqBiMLPmLui0w4+5+p1jxiNzZe2q8scLKGhO9d5gT/zV/cVdbW
	 laUi1fVf16M/dWiHJtu32bTJh4ijsGa/SHI0yPRyFFhIy2xu3l1qwqHbGEI9eAc4YaQRo
	 iQwq/S/z5rYkrDwfOSbu0RW8mgi9LTXYAdqAUQAnJzBstSfDz78drDA2AtkrVxET2fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MmSzxa3E;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BF2606A31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 22:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58BF2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MmSzxa3E
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-949680e6d83so769116285a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 14:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795819510; x=1796424310; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LDw3wVc+23YV5VvE1MLLIrJOoWeG+A7jfdl53rl+OiA=;
        b=MmSzxa3EoKOJbZMc8YZ04DGNrbH4TtMI6LsELqbOyAV38CirhzHOUNDO2WvRtCjNb+
         Bk7eGnJClsD2fKx8iLjroNkUBspvdlqANA4GKy47Mzzjb7HLURV7TOz3IxQ110DaRyb7
         oHwtRESoXveA7Cl8cG1PNSM1RgyUboE83QDJznjM1dSDFTIvYZtzIsNqz2VWX1cV9Xu7
         B1mMn9Rx7/WhngIzPxNiWPP5UbYBcExi0TyRWQu/iq6lkB9X2qYmkAOnp/vUP1lQkNIA
         vRdkUFO7j1XFu3YTlFtkBI4QPqSKWa4O98W7agPzN3Qe/7dYWQpDqk8IEdeBzWvrPSNA
         0RfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795819510; x=1796424310;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LDw3wVc+23YV5VvE1MLLIrJOoWeG+A7jfdl53rl+OiA=;
        b=zPdpDg0Wv6BTihcfA1DLKOFmFwEFnsgquUTdLOQf54HpiXxupLz/L8rSnzqyfIn/2H
         aiNtXqC4Ma6SwJS5w+HkMICYK5L4D3RYwHS5Xt4mYBq0nDBt5HOyRDidRp+BYZ1P+bwI
         Drix57DG1x+xDRUVBUfSYxDe81n7fN2jHD6khqEjQQhCjog30C34eGv/8LnbUVvylst/
         aqP1a0ON3I4rdzDiAFxWtCJnuSq3BF1yztM9nlSbnGVounVQ/SP0R0j/V9p6kHVt9+Rb
         PNquf4Fr9FUAXDyDO6/Jxyr1FpX7UaXdhaxu0DTo47x3dwmEKtm/DzeGm8kc0Lo7rJ7K
         VmXQ==
X-Gm-Message-State: APuU4Z9xyKWaDZH8ynStC4GV6kwwqYZsMckSZxTXcIxSJ9iZhpQ6ugfa
	CXDGCu3kLYVjyWSW/pa9ffHx7Wql3fF5kmhKjR0PFosTLh89o0TrG15KtsVImQ==
X-Gm-Gg: AZFdTZekdfryqXsI29U/KCy7ZQ/hQfEMhN4bJeolK2x8v8lmtEDI5/bj1JV5M3eze+C
	wtbL17dWl8SEGyosx7x2NMGxbVS3brfJjcQYmkkAvd+RZgnzunlk1BFxNOK7rRVp62e09UvuRKa
	30Oi7ov2DWwu1wy7iEANAp9r9L/CNJTe6jzbTzZOyBAxkmxLzYMmEaT0uWX//RZanbd+zof9lp4
	L9YkoJbXPwSy0uiEklx7xaEGIXiWNXDV2R9TtKhcfqMQHBI11oBW2tKSECvJ1AhdPU+hbfow+4T
	cWglr3tJ3DcCMaxGj+9b3IRybJocoIJ5taIP1ylQzz5RX2C3tYKR0PZHhj7IIJ8R/+EcZ3BmSMd
	96nDaq3bEMxNaqfh8XDoN38yI3ep3fwZO1QL0xfkdUstZOHjaW3UNwJiPNv6uMpILgnxgVBpr6h
	g9m4dtV1tPGgL2ioY4CE3xn9LQNCHd1VrlpAzGDVo6w+BdzJPqp6lB4hMOfmfu+v+ZtgN4ccRJu
	Pg6UmAOl+crkxSbb7Dr1Kz5Yr0FrCZ3rIB62Lthfab7N9Of8K8iMlf3N1KdNx7qdA==
X-Received: by 2002:a05:620a:f10:b0:949:5ee9:ab27 with SMTP id af79cd13be357-949bab4dee9mr4587039085a.83.1795819510303;
        Fri, 27 Nov 2026 14:45:10 -0800 (PST)
Received: from [172.17.0.2] ([172.203.254.214])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb349db3sm1916239985a.7.2026.11.27.14.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 14:45:09 -0800 (PST)
Message-ID: <6b0a07f5.01acdca6.f5232.b0ac@mx.google.com>
Date: Fri, 27 Nov 2026 14:45:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7850923840711579319=="
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
Subject: RE: Bluetooth: hci_event: Requeue failed name resolutions
In-Reply-To: <20261127-bt-inqcache-v1-1-9610f88a2a49@certik.com>
References: <20261127-bt-inqcache-v1-1-9610f88a2a49@certik.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7850923840711579319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1224787/

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.28 seconds
CheckAllWarning               PASS      35.17 seconds
CheckSparse                   WARNING   37.95 seconds
BuildKernel32                 PASS      31.26 seconds
CheckKernelLLVM               PASS      34.83 seconds
TestRunnerSetup               PASS      746.33 seconds
TestRunner_l2cap-tester       PASS      14.71 seconds
TestRunner_iso-tester         PASS      13.22 seconds
TestRunner_bnep-tester        PASS      3.22 seconds
TestRunner_mgmt-tester        PASS      89.56 seconds
TestRunner_rfcomm-tester      PASS      4.52 seconds
TestRunner_sco-tester         PASS      5.63 seconds
TestRunner_ioctl-tester       PASS      4.73 seconds
TestRunner_mesh-tester        PASS      4.54 seconds
TestRunner_smp-tester         PASS      4.39 seconds
TestRunner_userchan-tester    PASS      3.25 seconds
TestRunner_6lowpan-tester     PASS      4.46 seconds
IncrementalBuild              PASS      29.43 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1247

---
Regards,
Linux Bluetooth


--===============7850923840711579319==--
