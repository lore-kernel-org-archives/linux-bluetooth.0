Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794625428;
	b=g3WUlcqtUAXWAWtsFInolKncesT6cS4bmTWcVDfwmAqd9MSE5isC1mhe0yZUhZad1A9v
	 MK4PqBb8y2e5dd2j8XjzojEfro9po4DGjzHYgVG4CuA0vYg94IuoEM7F4c/8PGEAYzQKJ
	 I91CP5DNixb5hoTKca/8S6qDMOSc896QpggfYYDV4HQxXAYFLaNK4XUdsDlyE6JuQa05h
	 7UUPr8R5y+ogHdnSEseMTUv3UVNLXVpy1pDkS2uPxqikE6uG2HPv1Yk1JookeYjnxnDGO
	 MuuheB1U5OiK4lMOYmDS3wgURr8NSrYVgKr8XiBePjqUveGu0EKuPjg9OMIYTraI8mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794625428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=W8gUpsyufHgY2Fjrcn+L6DwfpIJZrO4EVPA1wzaidpg=;
	b=yr48bMth5T7UhM+JCXlFGJUsza10mkdgHD4Poz86q1lhqZeIDVVevVg2bByh9HIOUTm+
	 vreUHEiwyd6jEN5uMSqK0XwPAudgD3C/kYb37dQCx8Zi6LQdw6TamHjTo/nkbML+G5J4C
	 RYsZbG+xRBbryq28dL2KAc40DgJlDhO2jtVnMSVvrNAaDrV8s64m0Ix6kZ5M0lgKEqVZv
	 sFxluHKA+VTwjYeFa6JcEO/1isjC76wV/tfLjzVPZ/ZXfekfMxJj2RwQi7qs4SG0INGYf
	 kU0gKY50zGUQZHaDAKVorrIyb81LR7MnJ1FazJbAWUyeNtYM1Xdd6AV+mbT6n7RQoTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EqMbbn4Z;
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24587606A332
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 03:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24587606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EqMbbn4Z
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67921b515a7so1784890d50.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 19:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794625426; x=1795230226; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W8gUpsyufHgY2Fjrcn+L6DwfpIJZrO4EVPA1wzaidpg=;
        b=EqMbbn4ZenQB1x8/25YjzcdUzBlOo8mhK5D/IzYz2uysbedGp/w68NGdLpoKrUw0gL
         mraO7k6Zihlb5Ueme0XNVMtYqiiykAmMEC+wLqGzl1RiH4GU1yLTmm+W1+h90R2J2sfg
         8m5C4xe+li/hrnJLY1vmMWOB2oDVztv1KxJoB9cvjadSGmfgrCHeZwL63EuvMfDeAlTX
         4+rk8MQUMQWxWc5wOZZkwXHYxxc7r4Lo+ooiorXMg6IdPxv5nV9rkE3PfgidmXA9aq21
         9LPv57GY8gcd4ETLdl2YSmzZkPWKOA6t2mg1wJNCZRMdX9g87q0qw8IbpmWGlgMpmGS3
         oWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625426; x=1795230226;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W8gUpsyufHgY2Fjrcn+L6DwfpIJZrO4EVPA1wzaidpg=;
        b=TCmF/7rhHV1JzrWhn++6qwqWOBuLbYoVGNP75Qm0Yn3nhCIQyJY8R8owzVBV9V3CYg
         KZnm6fWawwTX6spOzpCphyXFL6IZUqaBLNa0EtQJIiCXmBe/axWqELVidjvur404Du0l
         GLe2CFKmAIMFePLGJyRK9HBPFNUy/idWvzX5vVSwsBIhyicLacgqXOROpl0wAq61/y+B
         bIFJr8fjrjcMBjhu7Y7vynDOrQPoKfW3meFDB95SGSMVZemL1J7QertLFRkg3C7bMZ2A
         5z21ekGLKXmQxYFhwgk/jlxu5BKlD8IRxON+/49uobT65M4OCbi2Y5ZslZT9dnLPtOlb
         s3MQ==
X-Gm-Message-State: APuU4Z8qOgJDpbBNeteJlrzSP6xTl1ztDRwDSXyXfF20G3kp/ThhyUPW
	XOG5A7Ge763tc16Dujc6jA9kI1qeXqeOVhnOHxEX5fFbXp8vWDlGFMwKHYtUkg==
X-Gm-Gg: AYBFou0i7ac36LHblQ3Z9QCPcUqhRBMnp3RUxexZvuN2MBX6/x7eS9q5mAhw58JBKtN
	QlDd6MsOhSv1OWI96366M3a+UtMuaPT/bRTAkIJ42z6ay9OM1XEvl4TZjuFEOS2F9n3+MTPi4OX
	lNVu2kNpRnkIFOH8ObMbrnfhAd0162KUuxfGxqoUbINkywPVyc1tmDIMDaDbl10QeF1/TXdYlGy
	RclXEEP05vqEvRI9i/7odXKnslfISTsCLIgwTioyCYhV2iozauPXr6zkcXcmqwVjk+RdA6JfeFn
	lDfmejzIj6qJdlSynP9dW2NU6NEGehvrTXBkh9hOmw8IXrvoyFI9pJAl5m5eAKiTUB/qft8B6fV
	OM80I4xVtxlKyuaJg8nHLNTaalq8mF2zn11yIqg1lr3+1L/01WytlstcvquIWQ/NJaWUlBP8RT2
	AfLt33tUU4zEtKUAoIM/0lFlO6tvHLUELV+I1K7uxChpiD2bKphbPQg+RLXDbuupfOG9Ceoej/7
	7IG8mpdBUbgQVzANIdflN8TPsTG0+hwrsAbKRnIrM4DB0fFnkpWEoHM7yEBhNirFZ/Z9LAFbS50
	QHn2G3Q=
X-Received: by 2002:a05:690e:4193:b0:679:96af:e306 with SMTP id 956f58d0204a3-67d896ac3e0mr2439395d50.56.1794625425895;
        Fri, 13 Nov 2026 19:03:45 -0800 (PST)
Received: from [172.17.0.2] ([51.57.144.37])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a6210ffsm3743961d50.20.2026.11.13.19.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:03:45 -0800 (PST)
Message-ID: <6af7cf91.c5715e09.2d142b.9e06@mx.google.com>
Date: Fri, 13 Nov 2026 19:03:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4899400016458842787=="
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
To: linux-bluetooth@vger.kernel.org, hex@freenixos.com
Subject: RE: Bluetooth: btintel: Don't log unsupported debug features as an error
In-Reply-To: <20261113222024.1123279-1-hex@freenixos.com>
References: <20261113222024.1123279-1-hex@freenixos.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4899400016458842787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1211023/

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.68 seconds
CheckAllWarning               PASS      31.77 seconds
CheckSparse                   PASS      34.01 seconds
BuildKernel32                 PASS      28.16 seconds
CheckKernelLLVM               PASS      28.60 seconds
TestRunnerSetup               PASS      672.61 seconds
IncrementalBuild              PASS      25.86 seconds



https://github.com/bluez/bluetooth-next/pull/1132

---
Regards,
Linux Bluetooth


--===============4899400016458842787==--
