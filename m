Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEA13ECBF3
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506526; cv=none; b=Kt23D9//kVzntgpYEzbRSSPU+hhYIJNKaieeUSSaQYXbc+Rq48rN2up3iemjSM/5rTGRVPNqrXJrDGDndIRwFlMu1BDpRezY8k8Q1W3MRLS+8XClmHzP+slTokEQcCm6Feh2qWp82hYtgkWTp65oEUCSHxtuPxNW3+KNNgGZX6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506526; c=relaxed/simple;
	bh=JuSAqdix6vqSKbwXax4/uaq1hVNOoI6nuTO4ZDVhHhQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=STI5ejMWF7gqoTLS9/LC/P0BRz8adNTW5nuQ7mDDUOULP68oO9emR3UpVZ5WFWvLUcmMBeO+WCo3/l5doz+5qyMsafuqQMfJBPxxTCpxM3OJwIi1OJkl0wRcLooc8G0uP/mMkwmicY3cZefxpaQxktkAm1gwvUDxnSR/Lgy9SFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRIoij7z; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRIoij7z"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-514ae601e01so15252901cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778506524; x=1779111324; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JuSAqdix6vqSKbwXax4/uaq1hVNOoI6nuTO4ZDVhHhQ=;
        b=JRIoij7zwhnTdz0HY9huKvv1b+G9NfjueJuvUpWDd5v51YADVyhZe2FbJGe0jEGDk+
         f/mowHiXDwWzYg4n4zEmJfHmKt8+837UGF9q6uvTF2lXra4G3xWRn34zaS4jbpiudHvB
         Rrw0qS0wTtXrg4Ds2vqxjQ2wGMQqGSKIvy1d4MEz2Mn7NUqiVRnIKcsyQXGtXSOwDAtR
         1CIc4Hc+AwPpzRQercmcKPpGx9ORmOEIt1e9BPE2xHrO8c2EvvIEbJzqqm6ERCjFan6K
         Yyyp79ui27ZsvtoMoS1h0bqp62HRFFJ49g66RI1HoJCT3a7agGTBvtTlobF0379aSm5Q
         bWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778506524; x=1779111324;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuSAqdix6vqSKbwXax4/uaq1hVNOoI6nuTO4ZDVhHhQ=;
        b=qT1EwMzU+rC/8uf3scp91B8Xol87DUOwtcE8zhgjEFSsxNdMfaDRvfFC0HG1cwBYpI
         dVCvdqjuHUd8N5sjp8/Hmsbd9eQiAF4D1cda046NRaTtEg0ibWJYO4CF3otMj6K6PVLI
         ag6Tp215yFMymvXFq5uiuRh9ExczOmGJN5KB4ItNnOZqF2TL+GqZmjT0mfdDfuUqER83
         1u6BLJLGHCmWW7rNmiB1+CkgvD6csDJpGtwFlRnQissD1EMyPfUtlGUsTUVLYCwxIA66
         5GFBSBqC6s7O6uP9qxuwWStHEmPbme3jE2/9efyMhLa1BZaUa3ElgOnvo11IhBQWpYVs
         WqBQ==
X-Gm-Message-State: AOJu0YxAWVzDWSyo7Rc7b31pmtrRp1hW1UbWWimfRdVp70bj7snwn9vr
	7kSpMc8u7F0JTZcoI7YK+SBd/SMK4D7u+rt+Z9zsdqbjEXlYnbFFqyaYYSUjKw==
X-Gm-Gg: Acq92OFXvNq6lcA/D3jzKke5yqTqNrPzPdA9zgIysEmY9ktAXuHrSi6oyCMxB2Dhq9E
	EOar46X4MUOUHedwEnE46qSg/2k6KNmReotJez13DjC2DmT5N4AwJ8utHGO4jfGf6uCLNXcMpv/
	plLXdn5drcc5UBFrBagRi3SepQR6oSpZIE1mFmhVaqJaYGb5ZdQCBDF/lXqH574NKnR61hy3fcP
	Ey+dQBxm6zkrY2q5uMUXNckOTxzNf0luvOkxetjZjs8pwgpJfPlHWFivVFkM1dVCqTZymx/tjKj
	dXXdOtMhu9hB0SOq0viSVtMdU1B/vr9yE78UDRVpg+K45hXzTP9lBel4zbp4i6leFGeYtQWR1p5
	Eu6p0V6xGBDUnrJwLQVgjDpaVPxEmFrixG0DKtxJgqugUZiT3M+DoibO+fb3XbcJKuI5JtdNKmL
	oTh0gzUvdCMutZ3q1VyVIMiJuH/RBaUg==
X-Received: by 2002:a05:622a:5d4:b0:50e:60d7:b272 with SMTP id d75a77b69052e-51461faa785mr319623321cf.41.1778506523528;
        Mon, 11 May 2026 06:35:23 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.158.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-514a956cad9sm56492891cf.9.2026.05.11.06.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:35:23 -0700 (PDT)
Message-ID: <6a01db1b.c80a0220.b7bb0.2402@mx.google.com>
Date: Mon, 11 May 2026 06:35:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3626141627821303405=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,v3,4/6] main: Use _cleanup_() to simplify configuration parsing
In-Reply-To: <20260511132131.1283892-5-hadess@hadess.net>
References: <20260511132131.1283892-5-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3626141627821303405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: src/main.c:205
error: src/main.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3626141627821303405==--
