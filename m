Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C442E567D
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Mar 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195360; cv=none; b=NUJHbBvWK8F2dvZtRPYiB3gvWKx0xNf3APLApyqTOmsdXJuJpWsmtUUw9Syc79MwIDJsSZDAIfIXMJEKh1MGCiU5v2qkPjkqc9+83f50vVCTC0Kz1pbJVt881jRI7xet7QqXjViRhEwpcp1c0ezcMojzFhxdMSE2pKgQm5jtc/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195360; c=relaxed/simple;
	bh=vIf4lpEMTuOb2i7lI2zH6ho3f6bk/mWsRu2usy0LjGE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=f4nBL+I/9hY4IXK3lcp4UDo8+hRLVsj4JLCSPynB5gR+6MkczpzjoqVuSrYG3pL+Y8yovWOK10Yhhw323PBe0HVPQk+X2iiRnEWQnYP/JPMccSbcI1+0b0fWg4QChFBGIwROTsCixOfmsuU+TI0FemD6P1aiyDtD2vb3k7JdprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQmdEQrt; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQmdEQrt"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e89c11fd8fso86480586d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Mar 2025 09:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741195357; x=1741800157; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rNAM5dxIh2JG9mdYOLDXipYvttp7FDmq1URY+xblmos=;
        b=DQmdEQrtr/bm/97YbihGYErjr9a8Tc5d9Us7LL6SLQmCm0P6Qby4mRnmwhoqPfJ/by
         /Te7ozmdK7U659IOftyWw7fMeMbIlq6MNf8VsGqUKPL3TQgaTKJPxZZ9VmuYD+5sCie1
         i6J9P9xs13Dw7NgrIfCvTNMsZAbalZTkAo1QKclc5hMl93IcFCwb18AOjeov4UtL/nCW
         QUZYXMs0SmSNZO0R2sY3mBLzfGb0/sKBq1c96eyVzU8IWfMivUcMH90nIoCkrqhdWYVO
         BCyASo86Q6WHkziTuL6mYvgLPPvWeV7bE9fKNrGAFPh+ZM0ez3B2W+Ugm7EXuyNQcIpI
         jojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741195357; x=1741800157;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNAM5dxIh2JG9mdYOLDXipYvttp7FDmq1URY+xblmos=;
        b=CrqafoPqJmEUcJ18xXdlLT8dx2J/8vDIXrw7yj4xrdSF1g+Utph6QkcdyfTacL+XXC
         4XzpyLmhCGE7ObEhzjfQLSq6OI4762QJnCxK4w0F5Lh8mVIg+rBE9RhrhFMCwPZ05Qng
         hTHJ7PRsYZGxQsk1Y9BKR452YB3zEe9QeaCzAquUUlytIpGSmpMU33w36YWc5KJUCD4e
         TrrQ737YKjP5iP1tMsr6AiJ+/9fkQpGIuhmtIkpc1LFYv5dnQGDWaNn6Q6TgOvmzlfJW
         W416QV78tebvU/lLzRdNUX37XoLgFfAQe9f0UEJmLox1yeRFOdATLRZKwUhZyq17yROc
         JtCw==
X-Gm-Message-State: AOJu0YxNNRRa4bIQZBoJyPT+Y2Vkdx9+30Z8izsK8C7hRdbMm1RbZpvT
	Yu22HyKu3R/bjJI1IBND+3q9+/1IbWbEwMq97VeEui6q6Q//YM6YdWzspw==
X-Gm-Gg: ASbGnctVh6mcJ4hYD58WGF6AQtFoT5ORFErGIidZumg6uvi4neUbUb1Xqh+ZfXNaRgR
	qJHBhrrCKIpdJKlrrHKdWf+C+9Qh3WhrSgQ6zMsIO2N99k2XLWhxrBtyDOPS/8vQZBm5/1M/vyK
	Yc3Vsz7pdxh4PB7cEF4KRq23ygGviamtidUnksn0NLQFEPAQh1uMg05iubIjBmeqHvByAmVh2JO
	j6mgbi5uqGm/z2UBAb4vMco4Im1tOZOZjG2zV/AMU5oBO+a8cCxXCEFuQQS+dGnqFtKZsdKnq/R
	jjmcDgcblwZG9dH3riUYwRM/OdUoMqFLVwUMM4jUSrOqSw0mopZH
X-Google-Smtp-Source: AGHT+IFYlhBB9gPYjt3CJc18QlahkSGhUsev7aNgZnbNRRntZ7oLGbj7tgSiOSAJTeZC6j1TxhjOiw==
X-Received: by 2002:a05:6214:3002:b0:6e8:9b26:8c5 with SMTP id 6a1803df08f44-6e8e6cd19a0mr64488006d6.10.1741195357324;
        Wed, 05 Mar 2025 09:22:37 -0800 (PST)
Received: from [172.17.0.2] ([20.102.212.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8e9a007f2sm9040186d6.5.2025.03.05.09.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:22:36 -0800 (PST)
Message-ID: <67c8885c.0c0a0220.2ee539.4931@mx.google.com>
Date: Wed, 05 Mar 2025 09:22:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3067249935298073750=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/3] btdev: pass sent SCO data to bthost
In-Reply-To: <1b2a8e408573624a7b5e5e792c7e89c8315811e3.1741190102.git.pav@iki.fi>
References: <1b2a8e408573624a7b5e5e792c7e89c8315811e3.1741190102.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3067249935298073750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=940626

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.47 seconds
BluezMake                     PASS      1583.23 seconds
MakeCheck                     PASS      14.16 seconds
MakeDistcheck                 PASS      162.66 seconds
CheckValgrind                 PASS      219.55 seconds
CheckSmatch                   WARNING   287.84 seconds
bluezmakeextell               PASS      99.66 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      875.85 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:450:29: warning: Variable length array is used.emulator/bthost.c:628:28: warning: Variable length array is used.emulator/bthost.c:826:28: warning: Variable length array is used.tools/sco-tester.c: note: in included file:./lib/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth.h:237:31: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3067249935298073750==--
