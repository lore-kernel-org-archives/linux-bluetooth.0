Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795368245;
	b=nQTJYrTWa5hrDqwAuUhvgKKxvrfsGUVCzJ1acGnpb7eojrpnQxEzTreZOctMSyR4zAW3
	 DhyKWs3z8vkpKYxKTGKIIOS8/OdVPKm8XXU4YjbEFFM5Kv/NHyoHhOSan7OMYVngfgFHu
	 /7ymoSEJSnNUnmYo8sVf69zhF9nKfFtKol7I7oJkjfhP3jxUzm/vhv0OINAWMT+UHQpx2
	 TRr5xUpkWyd0UgnmNOYRpc1JdGPfLmkij3rJGun3rrRfk4HkDfrVmrxPI6klrXLTuy9El
	 TLaBEqw9mdGAZ9Hy4ysa+pl22PVW8tE5VFBhJjFexvSEPkzZynLAlnOrPd3V8PBMELA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795368245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=1Uzyak45n8zXaofhlMA2L/m3DjZGIuhGwP9F4uAmiGY=;
	b=tWe8euS+XFNQ1GgiKbxqJbGr7YfWNIgIToBtmsqWFTftej9Wa8pbMPWS+/JTCSImmycy
	 JB/siLlYFYpOTVYJag5sGeSxiMraJmeXi+uI5QL5yvNi+ZsciSQgjhogfFAnNt8bIR+Nw
	 t67bEc/bDP+CW3JaGDYAW58J7JUebfTdlxg4hG4ZmBbD8Y6CZYSV6FTkQXNZ6B4hSAe8w
	 4b1RejjThOtKMjLLnBeWcWM0r2q8oiXeiOk0VPI6cFIEC5XGz4akHtbYRZVC0Cht5ES7e
	 rG3xX1m1rBj3oGrGM44wW74Gap7gMX5DJVwWQJ6YfMRRKqMKr1ekF2F2YsL9eAXWiQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="O4I9/Ots";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0287606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 17:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0287606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O4I9/Ots
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3282db206d3so7729438eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 09:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795368244; x=1795973044; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1Uzyak45n8zXaofhlMA2L/m3DjZGIuhGwP9F4uAmiGY=;
        b=O4I9/Ots7BVOZLRRYEdQs5KZJkofIuYvA9aYFLQUC8YrFSiRT2F4HSTN/FWRuZV7OO
         K+1JXOQGgQXOL6gzqwYEw7bydBh429q8I8XQ3b8r5AJTLiCrP9ZgC1n9XzXlZo8DWQhm
         nl7drmUDM/1b1cLzX8NV9RjdtebbB9f54kJ6IAxb0qAg/cMn6JJM4be1VcLBmavj6A/x
         X9XwPZdB4nKVCGYqHbr2xWdmYDL1UKPv/V9qlAhS7SMYGPpSZ83d/T/x+JgfNObT4TDL
         kX3yJmnRj36cvqL6tONYFnK7ItcZzacub2HhnB1iGhmufG0A3I6urtA3BlfG5WT2f3rj
         xOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795368244; x=1795973044;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1Uzyak45n8zXaofhlMA2L/m3DjZGIuhGwP9F4uAmiGY=;
        b=zk2H5csX9vrqmgXauLACkPe7liKjfDkke8EPrY+ewfADC/Ms1hadM1/3REU6GqRIpd
         F5TUD3An1hs3qouRJxS01j2xLK1Y+SYlsGrdtDU7Djbhwwk+p3T6EhnTcZgVpm/c5j1o
         QOHe3Eia1Vy/Obqv3Uk7TiIScffEbZjp7AbrQ6FeKhaXGVlwzynTj18oDinsOVzLijKS
         i8cseECuJneP8sHuJowmiv4NGK8zb2Ix2QndsYZ9LKz6uEFdHLsDT1GM9n7roAgWiR18
         iIaXUdaWWm/wg0mo29Ldd8BVq/zHpR4iCiOxRmDvDGbMw06NXKuTB9b+2wHMyPpbVZ6Q
         HecQ==
X-Gm-Message-State: APuU4Z/8bKg4PYaw7h+adBJRtTDJOQBvwQqCFR/FNO/779cZkMHCz5uE
	9Jbkwjrr4xvB9xs6tUUXJcJwMMFDgyXVUPsumG0SijRp1xPa/jgWa0K1UtcnCQ==
X-Gm-Gg: AZFdTZcnCSc4TQuhTUUzy09qPTqTd7wa67qmRxTjH4LjoqqYOynyeOhO+zBv90wMvhw
	UqOjuDwBi43/jttG6LdqMkrUsiQHRDL2MFswsw8CWKDvgkCyZ5kuzkUvpYxRV+BiXYKGD3f0OVg
	XdeJ1BWRjTVDQifFbahw9bLbV1m2L6dx8DuoCKw9VRCHm1A6MnEgnFHuEMLiaMcEA8KaZM9lKXG
	po+QOLz9LdzZMC+mWLg327V8ysvpZpzxpMKmZiwryejOxAaRaQLpY2wZvF4yxrzPFe7fvUfOtyF
	mxdVdjkNxW+xeQ8rAsPP4pqucD3xfkfR9e5QVnTQJG+Ph7593CoeZw2dN9iblcZHMfiJ4LKL9Rn
	2qzEubv+AYcWeFv8AMuHDsRqRe8RVocbc4DaoGQ2CTrNNyTAM1IzVQnvRTAJ8wOOicUmif72A+P
	qmNyCE3RP+O4Xoqqj8Zxi8vxVnNgdAY+HnT+AqzgNKd+vnougyMu6DbGNKUAaC+GUtZrK//cVcv
	XIiWR3iQYP3f4ocYZziRbysa2VouowM/5HCV3UcbvXQJxi57HZOg1AbzZiSw+LNgv6Fq9cygNVI
	i2puiy8=
X-Received: by 2002:a05:7301:6582:b0:374:e25e:a533 with SMTP id 5a478bee46e88-38570154017mr17462485eec.35.1795368243999;
        Sun, 22 Nov 2026 09:24:03 -0800 (PST)
Received: from [172.17.0.2] ([4.242.196.192])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3856456e6c6sm25506853eec.2.2026.11.22.09.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:24:03 -0800 (PST)
Message-ID: <6b032533.7fe52121.2867c2.72cd@mx.google.com>
Date: Sun, 22 Nov 2026 09:24:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6051830833720551449=="
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
To: linux-bluetooth@vger.kernel.org, leicheng.dev@gmail.com
Subject: RE: Bluetooth: RFCOMM: Fix slab-use-after-free in rfcomm_dev_add()
In-Reply-To: <20261122-fix-rfcomm-dev-add-uaf-v1-1-cac5354752ed@gmail.com>
References: <20261122-fix-rfcomm-dev-add-uaf-v1-1-cac5354752ed@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6051830833720551449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218544/

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      23.53 seconds
CheckAllWarning               PASS      26.76 seconds
CheckSparse                   PASS      28.97 seconds
BuildKernel32                 PASS      23.55 seconds
CheckKernelLLVM               PASS      25.75 seconds
TestRunnerSetup               PASS      557.75 seconds
TestRunner_rfcomm-tester      PASS      6.73 seconds
IncrementalBuild              PASS      22.05 seconds



https://github.com/bluez/bluetooth-next/pull/1179

---
Regards,
Linux Bluetooth


--===============6051830833720551449==--
