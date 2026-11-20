Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185819;
	b=sqQUfWC0gqkE07hhq3pdmElzP6+sZIA0ClVdUAIe3y4nYKJJk4EhXArwOVjq22T0Si8W
	 GKqEPxofxKJ5zS3egz1rS1txEA1/5X0CIdDI7W4TK2MxXFd6rHbO1tqX33HW4gfjDMYEN
	 RWbwy9vDuPUII626rJzh9ZY/itWyFPBUURgvP6OtQX5C7jk0nsrJskho/jvvXLdoMnmip
	 jwdsdhAxrzYknT9GLx72LXsEbLpCIRqDRMdGLD01e2ttSEVXMjv3F097aeB+5Zq1kU5w1
	 k6GfqStvSTrWq5uRRZ0tbcIybGZJlFuw/2WK3QKIyOKbI1HC7QdHHUA811zzYzVwSew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=A50oV/etGjf+ysiO7cjpX7DkMqpLIpDULl7Thj4Mz84=;
	b=28hZAtZnGLlncfIgZ5lJXTH5IEBswQ8cJ3J04ewzZIjhbv//YGIzvjxHFncMiCVJ3D7k
	 RO2CxqHaOrWZjOl7L6f42YD3VC6OM9ywTfQqYHu4y3SqxaSsBS9UAi3YE1r/mc4Fopn4b
	 tipMQV0snYv5f2nip6bF2VyKCN9+uolhAootkjmWStb2FqP/bMfllhRWVAXY+X7e7XUwo
	 ZK+b2I2pX+KkGd+te1P94L+DAnhEmHG4eSGujkAqU7OJ3ohZtmGYNXYC3AKjNOXKNl9I8
	 kZ+/JQFTjlqQ+/SZ2gTRakjwhYhsxNVTxS0BT6Hx+jr8fgFQjSjsJwXq003Qrhxyu2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Bxz/B7z3";
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1470D606A320
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 14:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1470D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bxz/B7z3
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53664b4860bso11258191cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795185818; x=1795790618; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A50oV/etGjf+ysiO7cjpX7DkMqpLIpDULl7Thj4Mz84=;
        b=Bxz/B7z3WS5yfGHwPsABb0d2DUByDZ64PR/u18RhhyZRnnT/Gen0s1CxzPrfzgMAAZ
         1coLUwCY0uI3Y/G5c9RIzPfIzPHbE3PLz6eN3C6hid/9vbmMfvYEKagtQZkIdJMmyUD1
         IVnOjWQKBOvcnqfVGIBM9JL2qoJl8WZVnN2hakyHq27DQKdvaOMmWP1dd+VrASVycEpi
         UnIvKjc43F6VdDo6y1byePLpOjOSk93zww/MHSZRr6t8AjL7F8D+OnWYHtP/sNaVhy03
         QDsnwLFquvTFD0of3MCjtMYwDQPY2hMg/6vMBqke1J7EjR5S2WYv/R5phMVmRnpfA0cR
         rK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795185818; x=1795790618;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A50oV/etGjf+ysiO7cjpX7DkMqpLIpDULl7Thj4Mz84=;
        b=JYBB7pgjD2TQ/ZSmbRzG8YhCsQ+pB0Wlfsy4oxVsqbH8Othx44I/cj4XtcSprt2o4A
         CyIvfun7qb+drPCNz8cSJzPRZ4aiIPDXfXiTt68t3AvJeFFRdBbqxlqkmdPzK3mqYCKa
         cyOF5ecCgzBhAFvToT0J24W+X66SSrw+U541c00P2dKDh24is4pNwyNsvIz72X6NuxOG
         fB8V5JPDzcDU0/Nt3on7xQDoxhx5axfpX17RXifBdQHuGKQkVllEnQte2eEz4DLV2Zvo
         KVx7VEx50nsca+b+p7qjDcvwnYByengf6FgHxHdqs6oR+jrD3POfR76vE/F3mCthzEM+
         HgYA==
X-Gm-Message-State: APuU4Z8lQfvhNVI6ccgK0RYi20QG3UuiIjBxHKqS3ScX0jPZSAd4hGch
	oi+hSl5GQwbNYhAbuW0EPNzO87X2Fc0+aVwIHR4/8eRkXe8wH81TL59inWeT6w==
X-Gm-Gg: AYBFou0YM2xVWM1uL0kYhMVD2t3GLcnal49v9/pU4Z5PEdi/bQzZgIIptMYErpUXJHe
	jJNQlzaZ27XfbJipwSGRsHSwpzSlrVSL23nNNBPcACno4hku/65ceUvsMxe4koEBTPHMePWetF3
	Na+y3oafdTNzxXKRb/pPHlJBjPALPcYyxNlPC+apW2tgOclktIErMds3cpeFrHySAUKC3ZJU8ih
	Tgt5u7ErmdVFHnbRCTAAuwQNu58S5v78+xBtfzlW3aZqQP+iAl9EiO5CjGJ//knK6DHkRWOXdR8
	xX3O66tRIAnD19sA6i6PoSBnySt3/Ot6o4OzE6u01MffuXCnUAbPCfBrQJWzjExXx0i8GVZFDy1
	sIcZA9yrzZ3x5KFNh8STcpRdWhtsm1LijitDPDJKFYgsefqZVuVhEZBUR5gHE7Y/HpnfG9pa712
	9GJbiC5IWTO2d7dfUFdZtMGO8lDEGt1s6MBFTEQq61RVyGjhb7K9hc6+dALGg8DHl/c+PnwpEcm
	zW9NVq/M8mtsBhb/4NI9qYJuEC0eOGuknz3lhsv1CcNGcZkG9DW4tpkfoBL/c2T
X-Received: by 2002:a05:622a:4894:b0:532:9ef1:729e with SMTP id d75a77b69052e-55d7693d3e4mr57995351cf.10.1795185817932;
        Fri, 20 Nov 2026 06:43:37 -0800 (PST)
Received: from [172.17.0.2] ([128.85.190.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349cdfbasm27168616d6.17.2026.11.20.06.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:43:37 -0800 (PST)
Message-ID: <6b005c99.8a6417be.d678f.692f@mx.google.com>
Date: Fri, 20 Nov 2026 06:43:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4813469367854894314=="
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
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: [bluez] tools/test-runner: Fix termination of the emulator
In-Reply-To: <20261120-fix_kvm-v1-1-234e5043b516@oss.qualcomm.com>
References: <20261120-fix_kvm-v1-1-234e5043b516@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4813469367854894314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1217178/

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       FAIL      0.32 seconds
BuildEll                      PASS      16.16 seconds
BluezMake                     PASS      230.98 seconds
CheckSmatch                   PASS      235.70 seconds
bluezmakeextell               PASS      75.81 seconds
TestFunctional                PASS      1000.42 seconds
IncrementalBuild              PASS      232.51 seconds
ScanBuild                     PASS      848.13 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[bluez] tools/test-runner: Fix termination of the emulator

19: B2 Line has trailing whitespace: "--  "


https://github.com/bluez/bluez/pull/2856

---
Regards,
Linux Bluetooth


--===============4813469367854894314==--
