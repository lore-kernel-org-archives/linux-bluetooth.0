Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589303;
	b=4nR59jEFv9FqfwbGCc7NrrL622Kf5cuUcvQG5A6FKdY08cdU0IzMIWhiiOKFieM4B9y4
	 NWwJvXxnhnsVAxd1ElSIT1oZ8rwdKLFannSEm7YYQdwJrJNggYOO3yYFOQlc2h1oH25oi
	 VUnMod4wbvOS85BpxzAVN2Mkg/NnRNkG9eOxYi6TVewOB/Kf7Eu3Tyyu4C5G7nkOwkJEd
	 8hCapYtGoq4/9pP6EgDEQvNbV328NpfjeQgiApSrqEZt2nHEhsQsWsZrKiLjYmHseKEtt
	 6HeM0fHWI0oviMmyWmqzY/ram8/EpwjLvokNXjiZRbaIDGOuua3j6bcbecMWfQgWgZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=McLeS1PilJbJLEL7SUk/6jkqA0dOGmd14cP91HzEva4=;
	b=ix5xk360FNamR3gkUGmztBeLTU764YguVHVhsSzXkcscMPghw+sLIFrkxpYjoQhTB0GU
	 5EBBCGz6WGK9ARPdRWTQlBZV2lQ+ewiwzVV9QVVFcHo4UvXiPLxYjATk6TGSxChjfSUj4
	 aQAr3L1TQS1Z9yeEtwymrdO+vHJPeIaYrEAjSsG6YUZ+cY9ar9QYRBdY3sBEMx6O9uLur
	 WJrffKA4O742vi0Z8RuIGS2dOcBRNtF0GymSqAr79gwER6yvXtsOEihzPNHeulkbp/6CP
	 y+ehZZrXSIDkIFVZ09/42eh/T7gLUenustUnjUwHmAdVeb6Ndcr1CiOCodELEMOvc2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X7LmGZH5;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455D606A330
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 17:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E455D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X7LmGZH5
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e977109392so7126615ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 09:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794589302; x=1795194102; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=McLeS1PilJbJLEL7SUk/6jkqA0dOGmd14cP91HzEva4=;
        b=X7LmGZH5PQ/SE5KrKAc9wky40juoLw2aQrBWVu+YvtQehOe7uNKM/aYBxe2lwVeh6F
         oxqLJEp0+oYUmkhKWMZUmivU791FZ9YpMdy6jBOSShOSqfTeSA4ncLFNIxE5nBZoA3Y/
         f325cM28hzUSOtzKcvNlK/z6CI5LYF31Wlr6+cJ+wrAELVkv4UTlIeJJwuPD79sJ+tPQ
         iRtD35gpGO+vuu4Y0bmeksyy6LwmGQLkkvBazEfkdLQdTylOpJchUGyEWLqMvwMivwlC
         nGsWd9PxLpkTYzVLe21ZGSBeqaoZ2MnXfIaBw+ZO/J/91goMIcjLzt/pRVCJP4pX2sXQ
         RzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589302; x=1795194102;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=McLeS1PilJbJLEL7SUk/6jkqA0dOGmd14cP91HzEva4=;
        b=KAU3L50ks6ZRCVLs3ZoE80H6k7xLFDEqsp20A/YtvbctF2l09FqhWbrsURh0A71Mxv
         PI5q+tJR0V7dGqHquqF5ouz/DZRoi72W19aD1l27glibXSIQW97adEUDQVtTFFU+mOJq
         ljWJH8oNp/1yAA4sKYJVs9a4zGnY9+Mb19kj9zhfsk+w73lTKs6zYNzfZ649YQjgG1Sy
         YYU4gvhOohwzmiD9+L4xR8R6Uh9cnjOjbEJgUnyExZnJPNPP6wJQ62i/QxbUEtwQrZJT
         a0jBgTq6a7P+kWsRRs6LBap8Ir60U6JX1CP4EgU/Y3a+yvVG4wllryCDWTNh4DSVD/wO
         q2Lw==
X-Gm-Message-State: APuU4Z9N2t1EkKX2uCS9FfqwOWO50C2+Y3lKSY0ZziBIv4wOJmiVGi1Q
	Q9dvdKraO1Wt/MEtIaZWiALecWnVSMfbusbfaLeQcofYwR7n4bgUNyg7VP46Cg==
X-Gm-Gg: AYBFou1M786+xSjyASKgCWztHDs6hTNLLmg4j27v0ZPi3SFbUVVgnhROkFe1T0/5CT7
	qKCmK+oKwYBdurUf64I/aBn+N66X3yjGT7AY3HvsMm319868jZrGd37xDbrkff9UNpPJPZvZNiE
	ESO5AeBry3Gs0krunY9aoPM8yIYMXc3oabsGsJkDNim182RuifF9/RyP4sJ+vzwF2TzhIox71Iz
	VXN/bi7FhbzehqdOjmIgOMbfSJfsBMrjjThBTpMO3ZDZEUXKpSczA2dzTBQCV/SMxFFeByGsMCB
	4qagdoG8iqxY1y/z8BWSrIAD8gAXdMDCIti+UoyNHCNFuApj8FXiIYDlGVa9wX6qvY+Ya0zhiml
	zp7iHsVI9bFf5GqZ0lmfuIKsZnL4y7/IbZIqdo7HCfxsZ09PoYXaf+3zaOGHRqomi46IMvoRl2A
	GwcDlWOAJQ/t8AtaFkz19ZTCAH+TdkX7idyioSl98+ZdZl4KPSpjzhkBV9XyeGPhtpyFKEpCR36
	7zqaLW3wST4o0W24L/GZZ1XbwXDC+4I9Zk8h8ezggehvoI9JRh0gMPGYoUXddhaIVJMHMCpZyTg
	JJ/VjUiVWmAi1xEQf2rScKQeJodBElnkIMIzJA==
X-Received: by 2002:a17:903:22d1:b0:2e9:84f2:3738 with SMTP id d9443c01a7336-2ee0d65dbf1mr30470705ad.6.1794589302067;
        Fri, 13 Nov 2026 09:01:42 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-24.us-west-2.compute.amazonaws.com. [3.42.157.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f8d4612sm13470165ad.57.2026.11.13.09.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:01:40 -0800 (PST)
Message-ID: <6af74274.fbff920f.bb9db.e649@mx.google.com>
Date: Fri, 13 Nov 2026 09:01:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6062375122931532209=="
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
To: linux-bluetooth@vger.kernel.org, paul.cercueil@bootlin.com
Subject: RE: [1/2] Bluetooth: hci_bcm: Drop CONFIG_PM guards
In-Reply-To: <20261113142600.74004-1-paul.cercueil@bootlin.com>
References: <20261113142600.74004-1-paul.cercueil@bootlin.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6062375122931532209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1210616/

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
VerifyFixes                   PASS      0.05 seconds
VerifySignedoff               PASS      0.05 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      20.30 seconds
CheckAllWarning               PASS      23.18 seconds
CheckSparse                   PASS      24.60 seconds
BuildKernel32                 PASS      20.48 seconds
CheckKernelLLVM               PASS      20.77 seconds
TestRunnerSetup               PASS      486.08 seconds
IncrementalBuild              PASS      20.61 seconds



https://github.com/bluez/bluetooth-next/pull/1129

---
Regards,
Linux Bluetooth


--===============6062375122931532209==--
