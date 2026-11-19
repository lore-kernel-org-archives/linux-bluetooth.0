Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076166;
	b=MkGQq5MX6ZMb9F713TKpAA45GjK1x6sDPgBI8c+SXnnaMh+meEGptgN8zAKLRdjkHqFE
	 bVZhBc3438cE18qOP4it1Nu5h5j/AwENyHAw+UQTpqkDdknWfY33+2br3LccB31yjEFMp
	 +P0qyMMq0UVgiyAGO1FLs/JR+iL9zruMQLy6L9KWri/KCO2LB17BwLUEwOfC7bYt74OS0
	 IcD5yRYKeO8DuKwiFw8xB9bYtb2eO6pscrhqrZbKVyZvT4uLJFqSCcjWd8EEpO8k2FF69
	 hbu0E7G0jFwWHhWgvZBHMDxm0HW14e4YW4oHmNuhIECj/N7m8do6QRf/K6Xhn3fivUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=BZ9H5snkwJb/+Ni1nb16eFRhRj5fXiXzK9UaYt8JxxQ=;
	b=IlborQX7AErXtHnvFUSi0Fk21V7YM/f6GlGXqDh+gEGnvgCFwycIKSd8rQ/OGVxE2gfR
	 k4vDks06e9IJXxfU1kh0mV4SWJtr1ytMlUS1vY7CIW4vJshwl4pqCRrkwS7eQEf18u52H
	 qwloVz6HnyqCvz+c8LJmmh/Q1y5JASjKhnse1rgtIUsVL9s64pe72K4roR6Xj+IkW807Y
	 qC7tJaB0SLDHvnPKkjUnoiQ9/dAJDGeWVI2byzqKjF+AS/l2+I61muEK9jNrwDZ/6+lFT
	 oPSimxF3F5a6LBbCgxecT3nnEV4LPHgZIhG61inHkXyYGNweXcTjOOaQzzRe7a8bcxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g0O0ZKv7;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44626606AEDB
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 08:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44626606AEDB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g0O0ZKv7
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b9c51097e2so891817b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795076165; x=1795680965; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BZ9H5snkwJb/+Ni1nb16eFRhRj5fXiXzK9UaYt8JxxQ=;
        b=g0O0ZKv7OUvqWsm8Mes5uuhpD5szM2UghSYmPlflHSzftpPMicqRh3+J9UfQOqWCgQ
         60EE7u5LEsNk0Y5XINDqwXC4mSbQTn+CPXu3FM0md6vBCuHMZWXKDQ4EeKHnhgo9Th8J
         L44W4rvyUBCpndP8CrQumViwwdJJxgdq+Dx3urg1ssiHZUKhz/xyeIDHfl/nmmLwYvkR
         siOCQrPmftVADsO3OeO9q12hMriMILEWwGwdfNklsjYJsLjyKpRpKXxKtw7OdV5SvL2H
         NiWgfM5zeFURl87Q6HvD2YWLRPyKqTR28/tPdk623DrHZfmNY24iqcZ7y7xJOLe5+hxj
         akhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076165; x=1795680965;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BZ9H5snkwJb/+Ni1nb16eFRhRj5fXiXzK9UaYt8JxxQ=;
        b=dWNx7Jy+plgKa9rsMlXcreKyb8cT+h1wbJs7adXu2NEoS8BDfQo9Dq0TdWWzoWe3yj
         +WAFHU2WT00gm2nxLXFOPkgNo4C66etcEely/C8h/4iVMFL84iCRQP2d/e9t3fI9xp7r
         SIBXw6g8bRlukx9Z8HdyNpOG8cuBZjQj9U9EoiZLW6aGVDMbDVHhQDyBi6j4e8bIuxOj
         CS7Vq8ckxSjUmV8Y/Mvg+yEAv4z2+MhX9DH3+Tj38JNsc+1T7IorESYYKSBtWXeD3YkH
         7pvWLgFjRscWVbV+LgM9gp6prhsoxklOvJBPSIV/RUstLs58gFLon2fnp4yc4+qo44VF
         /Y+w==
X-Gm-Message-State: APuU4Z8DuB11w4cDOTCuMxUoKtLuQxkBfzOREVd6m5g67R+YWv6zV12o
	HT680ACehLwJafCPh/unFKjkv/bbwGkBClwmMxgWYOnireaJjN/h6gRP6qgdSQ==
X-Gm-Gg: AYBFou3q0oRBOGQYa8Wo4ot1Q9PHnRzPYMNIqxRo5MqfFS43bzoLQqIRbc5W+85qYC5
	rZvtKOj3If6r20K6DTPq3hQeIFLoEEkSDU1+TbQUGdV5n02UBsXs+aY8C5ilXcJJsRU85iSLqXm
	OC3W5EMwR9Q7O2btWcvq2C4K9KHJfhG2GFwyY8RwH/1HON7YY/fg0rphnxAMXlLJHodixCW3BDe
	bOgtzbP+Hhbh+/Qx71JZewEw9zG1aL2ljZjyba3Nn9OWyk4n7lPu1uK+rHnRbiuYUFZy6Wr1Pfh
	Zt9PnlqiQi0AuIEBdr6xtTf4pASCqswpxJa70f0yDLe/l2FJmdzq7UFRyCYcMOwsU/hlk21HfVK
	FgX12bGNCwBv2r9tvSS8LkcHUC1DP3VSBJyBHzGo682vv5B9sr3FR2Ez6od5xkBkT02CH8tymVW
	gmA8uRqHwAdx3qk3c1lZ/vKy7RFhziP4iSeGvZjtLj8msH/cWD5fWFlOQijfB2QZQgbBtlh2Z9h
	CHIV2jmGRhI0uNiL2UlPBhvvnxpTEzWnv6P1CtdxXRn6uGxRG6JbXgQh6Perw==
X-Received: by 2002:a05:6a21:699:b0:3f9:ffde:7cb5 with SMTP id adf61e73a8af0-3fe98af1267mr5114180637.86.1795076165462;
        Thu, 19 Nov 2026 00:16:05 -0800 (PST)
Received: from [172.17.0.2] ([4.242.52.213])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde534a452dsm1321839a12.19.2026.11.19.00.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:16:05 -0800 (PST)
Message-ID: <6afeb045.67c1d1c3.367b9c.7b62@mx.google.com>
Date: Thu, 19 Nov 2026 00:16:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4145603694319245823=="
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
To: linux-bluetooth@vger.kernel.org, rdunlap@infradead.org
Subject: RE: docs: ioctl-number: update entries
In-Reply-To: <20261119053514.255348-2-rdunlap@infradead.org>
References: <20261119053514.255348-2-rdunlap@infradead.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4145603694319245823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1215698/

---Test result---

Test Summary:
CheckPatch                    PASS      5.16 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      2.42 seconds
SubjectPrefix                 FAIL      0.74 seconds
BuildKernel                   PASS      23.62 seconds
CheckAllWarning               PASS      27.53 seconds
CheckSparse                   PASS      29.31 seconds
BuildKernel32                 PASS      23.72 seconds
CheckKernelLLVM               PASS      24.80 seconds
TestRunnerSetup               PASS      554.23 seconds
TestRunner_l2cap-tester       PASS      15.08 seconds
TestRunner_iso-tester         PASS      11.37 seconds
TestRunner_bnep-tester        PASS      2.83 seconds
TestRunner_mgmt-tester        PASS      84.68 seconds
TestRunner_rfcomm-tester      PASS      4.03 seconds
TestRunner_sco-tester         PASS      5.10 seconds
TestRunner_ioctl-tester       PASS      4.30 seconds
TestRunner_mesh-tester        PASS      5.13 seconds
TestRunner_smp-tester         PASS      3.99 seconds
TestRunner_userchan-tester    PASS      2.90 seconds
TestRunner_6lowpan-tester     PASS      4.05 seconds
IncrementalBuild              PASS      33.40 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/1158

---
Regards,
Linux Bluetooth


--===============4145603694319245823==--
