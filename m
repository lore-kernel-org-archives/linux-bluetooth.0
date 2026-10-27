Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136211;
	b=cmCXfej+ska035OZUKWa9jdCnRe+KP3bdRq58Im5b2+yLr29UyVzkqWFQmQTxmlRkChF
	 MUHOn2lQKr360ae28p9UtaMjvJ8IilkWbi7N2UWlneaAs/Vg5h2U5RQ8N2i8Y7vaIE8/u
	 rdXu2Hz3KX7CtMBtAlleD+rhOyC5lBRKfiJOGk5lj51jjQhkv4Mta9n/XPdeNMG6sSlFU
	 3/lOwDMEOQ4Xsy2vHfPtiAtB/cacxQYj03OqSkkgooH8pLSeA76ouPQFztvXEpiu7TBnP
	 QfrLadYHvdUWpiUgj0hjlGKtjEa7WNFXEfZ6xd3Ifj3IbUlcXJ0bQIhGL+sYXJPfgOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=C1UGZkxqTdeEhnZkVr1Gw4iO79CwTvqVS/gCj6RGlGs=;
	b=5UZ4CCfBvc3LR8P7mnmDI7Hiz+Vj6de0+cZoq0hlgVTeJGo/4xMmb1rMRFLGK4Key8Tz
	 jkFcS+xsZgpnzcLRk6jMzZpwQ/3dlS1u+s96f8qMpY+QR9J8o7yOIGhdwTp+Yjh4KzdXR
	 r4G8OA2NbND4zx27H5sDpmUhT8lOI3U1ot/6FkmkVUUeF3kBJP+/h7SyPe45sOlOvwW38
	 z6WguKno2bpEWC0IsJFAEdZi8ThTFjQ7zMBN6HrSwNMohW4UWPLqYSQGrenw+BbI3klCH
	 1E3jq+KKvZPUbUsFxrxNqCxiSxEqeqIqYwdXRNMA70m4KGel6vS+bGKdK1E+6T5hVpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z8gSXZyP;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C6B606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 21:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05C6B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z8gSXZyP
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15dd124bbe7so469651c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 14:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793136210; x=1793741010; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C1UGZkxqTdeEhnZkVr1Gw4iO79CwTvqVS/gCj6RGlGs=;
        b=Z8gSXZyPJn6ThDcXwtag20niEbTi+7iSU7h3/V0v4U/1n+sR3jpJwuoyILAsIVPHqy
         /tCILoTwDxA1lz8M/kzaXgaZOz4KaeGRlqwV6BYD7Gv9nx7UDMddg8BWCbLwOZAr3MaC
         nfu9rAP0xsGOMder4w4Hf5GdPEO4LLjiufnsF0f+ly6+WNRf7x7FBlZUNWfTFbb8JOYw
         BoBfNCHfzFpVmDTh5E1eb0dzjIJohXxahpa/afDBTEmWJTRcwRH5NNTDAXjNyUhaL99E
         JwTS8ngcQrJScJuni7kNZRSLqsO2uuLtcYkhXFYameBy9RmKuWjoLX7GEOajQn+Nhz1c
         CrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793136210; x=1793741010;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C1UGZkxqTdeEhnZkVr1Gw4iO79CwTvqVS/gCj6RGlGs=;
        b=yM3/H4dSUTggOJhKvT4ZUr5t9CeRKIk9HMItixaQ69olWsKpO3VlKarsiDfjsTeAgR
         wakRM1CToM5Q4lB+54ykhKjOLydiV9c7ygTvdRScOfwu7g1XHW5BrGyPmaLxS5v2FvGk
         tqtL6eH5vARzxijWMepspdvrArLkkWvXYAX8KcmE0jCV82HWpz/BX6nzzeKzR5kLnIrI
         8rijMYwXnWLwV4yNJyYwMwSEdgO+ZIAtqcKaQQf0qIjntxEb0mmn+b6P5+4SH2w1CfYw
         jJtkKKcP0sv8veOXI8fC5HqzNd5jHZ4CfISl6jnfekFO/iUDU1b0MVS3Udlk0+Au9Pi0
         K0jw==
X-Gm-Message-State: AFq9FYIsrh+B8hpIWFvzUCeyDh7kZD7dh49trcOfmaEG5XJrVPSAw6MZ
	+Nb15cjlwzpdh4TNcy+oP0wazfI0vaW3LEnAbRAz9vygthv3cK5qPfYgzhtRbA==
X-Gm-Gg: AYBFou1qh2bTrPzIS/S3za6QTjwLab0fA1NNOpcZk6et0oH8ua6uz81XVtE5Aq2H1Jf
	7pfk/BDMrYnBDwj0aCEs7Oq3IpVKH71JFGTT1/VrYciJbMvWMhRBuAmvak2NX+Tkj2N+zXvH3fQ
	Sse2/YntCpj0i9be+JaKm572Uulz5UeEOvb7V+OqQnz0ZCuU2zhx3PpgG2/OM+FM7h4OZlyH9ik
	QGVN5qyBBYLIJyuI3PZareWXGDDhM93HVUCTbWchbtXrqU13yllXU/EMQaP3cICAaBHRphXOWFh
	yGuPmbpMQg6zkt9RDhS4qZY0mVOVWDeu+nOJvHiq8JMLLRrmJwLUNxH2nVPr7AQ7k+ZQnkJJx+N
	p5kU1GX30z19ZCuTM66AFPrZtEbDFHFb5CHZI224vjjcPLdAJQxNctXKUEBkL3gMmAca6tCkcxE
	Dd07oFzv07XLYbd6WdDrzq8dj/olr2JIsV/0kbS1J7LMPQlVps/Hh2OpAuv7kxfwQClEIuE6Q+t
	TKOnOfjsKECn2R2+syWS5yiG9gzPxuFfYB9rvV/MtZEogZ/D90MxrOlQq4=
X-Received: by 2002:a05:701b:2515:b0:151:d6e5:596b with SMTP id a92af1059eb24-1a6cc90e86cmr544502c88.9.1793136209906;
        Tue, 27 Oct 2026 14:23:29 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.89.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6d98c93d7sm811277c88.13.2026.10.27.14.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:23:29 -0700 (PDT)
Message-ID: <6ae11651.77c88264.3cc773.1efc@mx.google.com>
Date: Tue, 27 Oct 2026 14:23:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7926738918170396717=="
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
To: linux-bluetooth@vger.kernel.org, dfrancio@gmail.com
Subject: RE: Bluetooth: Disable LL Privacy on Intel JfP (8087:0aaa)
In-Reply-To: <20261027164359.460369-2-dfrancio@gmail.com>
References: <20261027164359.460369-2-dfrancio@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7926738918170396717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194809/

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.44 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      18.84 seconds
CheckAllWarning               PASS      21.80 seconds
CheckSparse                   PASS      23.69 seconds
BuildKernel32                 PASS      19.15 seconds
CheckKernelLLVM               PASS      21.55 seconds
TestRunnerSetup               PASS      419.32 seconds
TestRunner_l2cap-tester       PASS      13.74 seconds
TestRunner_iso-tester         PASS      10.99 seconds
TestRunner_bnep-tester        PASS      2.77 seconds
TestRunner_mgmt-tester        PASS      82.56 seconds
TestRunner_rfcomm-tester      PASS      4.03 seconds
TestRunner_sco-tester         PASS      5.02 seconds
TestRunner_ioctl-tester       PASS      4.14 seconds
TestRunner_mesh-tester        PASS      5.02 seconds
TestRunner_smp-tester         PASS      3.93 seconds
TestRunner_userchan-tester    PASS      2.90 seconds
TestRunner_6lowpan-tester     PASS      4.00 seconds
IncrementalBuild              PASS      21.33 seconds



https://github.com/bluez/bluetooth-next/pull/1008

---
Regards,
Linux Bluetooth


--===============7926738918170396717==--
