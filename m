Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795388105;
	b=jvt3uXZWU4dbN//4gD/MG7POXwgles1EawmpxMJS6zKNzleXrq0hJF/J2IuIu6nTbqSl
	 AK7OcXuBehlvl9JU5PmE8J+GiDu5rE0Pm7EfcWOqTLtNN9Hg84qpFZ3qtraT18ZrfdiUy
	 iC6LISSg6xzJce3nZBWwraA81oAZRH6hb7JVvceONU+u4bCOaFyztqqh5xyuPU8BNMHuB
	 Tskn8QG8/zqNhiS2ZByel1R12BnL35C5BMYhMlbQBjOaibVTeUs8ccIN33hAFmzG3ATfX
	 10FzcwyorrHgp8NeKfAcoMBkGPwOGAzvBwyRSgCKQpiIwY+eT/4x5ujv0L00n1gnYfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795388105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=CQ+yCPfZ4FDjV9EHD5w8FL/yu2ZRqFujvi9Qm5ieG8M=;
	b=znb5k0IknISrhM4zGA0HfNP0CpaOsIJs7lc37pNwJ4SnWyfPucrSSTrfflHZqnvtdvdg
	 eW6SsY5IDgt9sTjEEky714rgWw4SiIjG+kiW9KDLaCCOj9EplVa1mk0ZM4SsMeOdy+1Rq
	 yCqvwn+QrGpQlcgCNh9FEYVSaXFsU3ZJiKy0ll1A9AIsuWILL1BGKxBMb/COLGAkVHl/f
	 UYFqHvmQgWE2ZCBeqkD8vNF6F7AZcZIyObjksvuHZgZbpu8HXEV6A51nFRjpKGwRBk3HV
	 T4zCzt1VYWzb7GxlKXeE1o9zLbNwfqcFqP3J+OCXEaw+0RiUXmw7qhcUWnou+iUg7HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vTbjn8UJ;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54538606A31D
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 22:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54538606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vTbjn8UJ
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-55ade1de0b4so34343821cf.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 14:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795388103; x=1795992903; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CQ+yCPfZ4FDjV9EHD5w8FL/yu2ZRqFujvi9Qm5ieG8M=;
        b=vTbjn8UJ7H8xl3TWdmP8nP1iapUPlm0oZBTLResWX4oBUnCYIQnSSJ75vaH5d+wh+G
         6jlLLyfCUZZzq1QMFRgliJ093PPJQu7zJDTTDff3P2zi8/ELGJhGEMBfLH6zv6GIL14r
         iQpYL2mrlzAvtRznEDueuPLBxY+trI4LZ/XNXK5hOHfPSLSCzP2gUeuZ3TUP4C2VbjQU
         XLtrKNkjuXJAPQTY7MUT0p3iX03+U8CAxsgoUYVbhAPh0PUfCXsWhRLely0BABX+qlCf
         UXoMOFwP0NVa98ewxeCrVfc2yOub9pym6LTPOw1ofawd1sVKT5RbunGEYgeyNl4JRPyh
         KUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795388103; x=1795992903;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CQ+yCPfZ4FDjV9EHD5w8FL/yu2ZRqFujvi9Qm5ieG8M=;
        b=APW1aAtIlQYQw5CAlE+8EzGGYFC42+0U3FhpuquBfdDQpYBq2CkYo5omNsYgxrQlyz
         Zqx06VzdLnGnuugbdKHuqShyLvnVFG+tADc6Uxjlz5eknvqwTNnGvxA/WcGns5llafHJ
         nBqSwbccogukLYyyMowG24oDBXU8xIYzWfj9hb0MB+ncKPD0dvGelebo/+7qBfUzLz6P
         YJmRP6dQIErul1cHgLY5w9bBzmS4nMiAQiFslYsgtBWR/w/du15erCWfFBKBvs7zNSXw
         JgWtj+G2BSXTFlOwrigBr3C91ilxwFUXgIycyf20/T/pdOt8CeXLTjfntoMMM8hbwfaX
         egdw==
X-Gm-Message-State: APuU4Z9odbzX+FuofWMjLOxqkDvGohclVQsIJv9dmmcGwOBkVgdWpOL7
	VwCi1PqLUPT0ce7hlRgWCkF65/jjN61AQuTGaf2icBZaNoq5Qrjbo+tKGDsNvgRV
X-Gm-Gg: AZFdTZcAz9EtUMA3h/dPw285RzJ7wQCERj2xoM2YZ1kk6JF7+9aY4oQyELjWd+GoEzX
	NiyWfOrKsggL3A6O9my7L1S8FU/NEvAYLhw+h8gQ31p+CpA8y6tKJ5XUYbNBh2vYY/VsC8ETkxx
	HAtx3igLekQbknxpEQCDJ1InnfyrOjq9O2WZPVSnXVE+YbRKhIi6o3I7YprS/F0NQHxUz7TK1If
	MbvLr0tSIEYWsUfLEvqGu/eNB75aF23wxlAF1pzQ/lFzBr2Lv14z2gzn1wGpcFPxAn/T4Ei3GAD
	e97J1/QzYw8Iif1/TwVp5ocTEu5p9Yj2YgwItujfvi39dzIV976WnEmvyb+edOjN8JmWkaDztYC
	I3ybzo4PIRc+hI/8GEbJpYYrUpU5WCEP1BlmUSnbfGEeGVRnH9Y893xWUZvSGoiqfluutYRFI+1
	4RIN9SiGLrH5uMq3rD6ZZuHsDHbxDi/Iace5P8FFQrvgtLWwgE4OR1JAKWLdczO4XEGGfKbKvfZ
	3/q1gmN31yg2N9POlCqH697jrjINhrbm4HI/0VrZA1ghS3fksNXuzioO4BRQApbaQ==
X-Received: by 2002:a05:622a:5512:b0:535:1d90:ebcd with SMTP id d75a77b69052e-55d76a6f9ecmr190422521cf.27.1795388103557;
        Sun, 22 Nov 2026 14:55:03 -0800 (PST)
Received: from [172.17.0.2] ([135.237.130.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788506b0sm82637511cf.17.2026.11.22.14.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:55:03 -0800 (PST)
Message-ID: <6b0372c7.8830561e.3502e8.367c@mx.google.com>
Date: Sun, 22 Nov 2026 14:55:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4390444833509484923=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: Bluetooth: hci_sync: Don't announce a broadcast from an NRPA
In-Reply-To: <20261122200935.2778839-1-simon.mikuda@streamunlimited.com>
References: <20261122200935.2778839-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4390444833509484923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218945/

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.95 seconds
CheckAllWarning               PASS      36.23 seconds
CheckSparse                   PASS      39.00 seconds
BuildKernel32                 PASS      31.43 seconds
CheckKernelLLVM               PASS      34.48 seconds
TestRunnerSetup               PASS      769.34 seconds
TestRunner_l2cap-tester       PASS      15.17 seconds
TestRunner_iso-tester         PASS      13.45 seconds
TestRunner_bnep-tester        PASS      3.26 seconds
TestRunner_mgmt-tester        PASS      89.69 seconds
TestRunner_rfcomm-tester      PASS      4.67 seconds
TestRunner_sco-tester         PASS      5.71 seconds
TestRunner_ioctl-tester       PASS      4.75 seconds
TestRunner_mesh-tester        PASS      4.57 seconds
TestRunner_smp-tester         PASS      4.43 seconds
TestRunner_userchan-tester    PASS      3.30 seconds
TestRunner_6lowpan-tester     PASS      4.51 seconds
IncrementalBuild              PASS      29.91 seconds



https://github.com/bluez/bluetooth-next/pull/1190

---
Regards,
Linux Bluetooth


--===============4390444833509484923==--
