Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795485953;
	b=vzKuFms18Y2KfIBwv+HA7+rIsd8PgmZXmn57B/Z5boVoex2jBl/ifCZYrOaJuPFHDH10
	 5kEVgcclye7wa7vV4CH/5R2rYXkBncPjsSy+nXqZVvqTfB1gJjhsVDhe/UTL+azIBsClU
	 JaroL54IfWi5PGWvoHxcsxzKKiQySSHM77YjXG+lM3rdmX0CWztIVQA038KsvPsA7sHvk
	 V+0Bq6yYP/IQdh44d08QdqHbgxdLjqHbFrBite6rwsrl9k0iulk12ejG6FdtcgvlwnkPH
	 JmIPkrInIoIcEgZ3Eyapt40+X65dDtHYrsSgythiL6lgAnUOfiiTGcuJ2A+URb7E2Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=eOVfU6Gn6cHFq69/CV3AN7Sdn6BgMeNg8BRWJNo8OJ8=;
	b=N6+kVp+/Y6kEfv9dVEdmAvPiDn1Og/kuqj1O+mCA3qF/10qpeeKg/QJ3nY4+kgmVEMG0
	 Csp9d8xnlh8Q+6+Z54mqHVgH7zFr+W5vqAQ66LzIwYwjHU+M8UGsw9+kaoRPbZu4yMZOo
	 /9DDAvdOdL7v3QfzQc2LmTEdUHEXZe+bVxjcatOZIokcib4CtsisnYR6dffvZAFobN1ic
	 5QbNNaTKKkGB/w3ovMB9ro7bTBLmVpSjAQ5Fstc2vguFNRQUDitgSL3wo9aYssjlknn75
	 AJTKeU1WB36Yc1Zc7GgzYpASV1yk1dZWv0enwMvg807ZG6hD1AIE86b5D74A1bu9Isg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MXkhIqSm;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11AC606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 02:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F11AC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MXkhIqSm
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-9211efaca89so48951286d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 18:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795485952; x=1796090752; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eOVfU6Gn6cHFq69/CV3AN7Sdn6BgMeNg8BRWJNo8OJ8=;
        b=MXkhIqSm0gmA6IVffZqX/zQnoxc6h00QSa6hY6cVkX8dEDgXlvXVnC19chjLHqMK3F
         sl5KdsgCE8gkfE95wfsko09iz71FNyME+ajBHim3PikwW+QszH2BGZqPFaNFfd9yHow7
         lpDM3toXf0llB5EHxHK8SMtAMl0qgWwYIVVYPJQCcSx/gvRJIQYzp3D9qaw44C31knys
         17DC8YUJtlkoHLtfCNlk8dJjdM1y7rGafTzwFamuOrB8pUZpmJfq7djqpQQQMPV7z/51
         nFeEEWJ1EpTxkCn7cYMTD3dsOTPL538zl2YrQl/ltK/t78K1YujqmDZxjThvsBOaFRKp
         KdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795485952; x=1796090752;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eOVfU6Gn6cHFq69/CV3AN7Sdn6BgMeNg8BRWJNo8OJ8=;
        b=KCQ0G5l8Z3E6BoYua+opK1MjZzr9mOJwMb7+ZXAiHGvMXUdW/8iBaGcJAZwzpUCIMc
         0IKflHiLxGeacNzltf5iIz5NVlGjh9EhZi6gZqosURHeCakpnlgN6Bnc+Hj32p4fEGnN
         xRSK9diGACnT6gi/AtRWjGkAZUt8YcD10E4SHAwUddr4NAPr8qFwm+MUy/Lhmw2xhwwb
         KZpGaE1KIqvlPJvhEg9YH43BixzfCpSrSNzSW6VpXnXG2RU8q6NXjbl+Jyr+7SzDJsd7
         qDvMkUlOlWVkXrtWWwbjkhsGierIHXsvWIOfDG9AF2hH/iVvoA19VLnRRjDOcmvVxj7x
         ovRg==
X-Gm-Message-State: APuU4Z9ooNVymhI/sHK+IIFwIuGn7wYYkSVktGtbqyDgYIG31z3W11au
	vmWTBX1uvTcpYR3t0GOYbCmDuGxbMOIIFaueknpMHMvusrkBy7zDqmA5muduJQ==
X-Gm-Gg: AZFdTZfIqYxOC1RDIngjtT/nLb53cHVj9vO5xNnpjEr5pyZfQTYPDJDTzODabqGaaOa
	laoSNhW8P4velHAik+jY3w0955w3V/2xKV8iXNcKmIX/oSDodJDdWHgDp2dIiZSn2T5ggI2tQDK
	LCMb1Yw1yb11PK+vbRYjgXn6RNzyhSOPVPMU8LqAodHjQkmGhMOdB67x6xsBax1COe+S/1VHHJR
	4ecnwTxDKdaWlC3KjMCwQ+tODzIlLArZkGEoBMMs2gq/r/6TShWl6jznY+RBtNNsEyC2g/hCkDz
	UXhfPO52ZL/AGQLjKYKLuoXMCMvVqfs0PWKJTRojtQdK1NtvNVrAoNzPocX3lAtq0sGeCoteKWV
	2VtH9/+/jIfwtdyCFb1yR9zA5HmIirAxH1N9+Mj5ClvAHqweqI7FbCH73Jz8rSB2O763z3LayY5
	VEl1UkbSIXGy+S48DlDVhZcTk7rTwkCfTf/b4KEygKzTqUQkNz/dIq2DDKKHWNtRe1xBd9DEVTT
	PHYID91aIL58RcsjKew9mhpwi2jgP0powJCk7H361MXj/7ldrONS35Ug7KQqoNu
X-Received: by 2002:a05:6214:4308:b0:921:227e:e2d7 with SMTP id 6a1803df08f44-92165db1498mr31257996d6.43.1795485951940;
        Mon, 23 Nov 2026 18:05:51 -0800 (PST)
Received: from [172.17.0.2] ([172.172.203.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921366d853esm114663666d6.27.2026.11.23.18.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:05:51 -0800 (PST)
Message-ID: <6b04f0ff.4f846d36.2e7efd.122a@mx.google.com>
Date: Mon, 23 Nov 2026 18:05:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8138904917024206399=="
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
Subject: RE: [BlueZ,v3,1/2] shared/att: Confirm indications without a registered handler
In-Reply-To: <20261123171241.511211-1-simon.mikuda@streamunlimited.com>
References: <20261123171241.511211-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8138904917024206399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1219879/

---Test result---

Test Summary:
CheckPatch                    PASS      0.95 seconds
GitLint                       PASS      0.65 seconds
BuildEll                      PASS      20.69 seconds
BluezMake                     PASS      311.67 seconds
MakeCheck                     PASS      14.47 seconds
MakeDistcheck                 PASS      147.63 seconds
CheckValgrind                 PASS      356.31 seconds
CheckSmatch                   PASS      318.13 seconds
bluezmakeextell               PASS      100.95 seconds
TestFunctional                PASS      1227.69 seconds
IncrementalBuild              PASS      348.55 seconds
ScanBuild                     PASS      1205.34 seconds



https://github.com/bluez/bluez/pull/2888

---
Regards,
Linux Bluetooth


--===============8138904917024206399==--
