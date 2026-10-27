Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100340;
	b=rZpKSxGCtag6CoMZ+xF2CyO9l1vAoE27K4ZP79Vt/F5eEUgWosiCzqXntPoz+MlSLihz
	 5U/w+bj2yxmpF8NrlNghW6F7bUQnCgLyQlEpoy89pDuvKp0bDewD5yP0giIwtuJypMXYU
	 IO1a+KpsxDEEx2YRbsGDcRSH7cwO/lW9gUUWegTLU49NLFYHKututIP3cnHBZM/Paqmxq
	 QEXbP1deRq6mqhrrwyEBKTygKKbsaOdXna0EeXq5KFPrM8Nl53c95G4S9VSlnFOqzg/fK
	 MlKrsV7KxrS61GTWHrrHHah9AJHdU72q0T8UBh90ZGfXCGhvof3Wbp/2J7wykf7rR0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=9obiJV6/iqW7NFW653bfL2cp4Shx8bwjv++1yy07Yhs=;
	b=kaLfDipBkGUhcsEl+5w8MHi5NcW5Jg3O9s+bHp3BlG9LgbfZwYQlyb3aWrvna2LcOY9y
	 DVLXVJbjFc/AiiI+CQyFovB6j1+iKCGEey45vBlm3lwWbDWXs8lebUkRAupGg6iPneWff
	 GME1mSXmZFA+Xo2D87Wvf9PvfL8p7fr/O1PC+UBsawwRlYe5YxlXGp+jFSApt1fPT6fP1
	 6Y0Y0A/86LxyJVLyQ9fDv/kVqkAkzWwOwPvXQTMQmYtW9tYt2lVRr6zfDfkTdkV2SnXY+
	 v8PNcFJQoxb3gPpyVBvq29zlkX3xSeELedpuKTYQn2zhTQmS2ZFHmT93UmKjBQBgoYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cYuuv1eb;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CC8606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 11:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44CC8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cYuuv1eb
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso7305257eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 04:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793100339; x=1793705139; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9obiJV6/iqW7NFW653bfL2cp4Shx8bwjv++1yy07Yhs=;
        b=cYuuv1ebJvrFLSkFLxUn7ZGu2qCD/vm/DzN3lbYi3h4mVJHFq2e4xWdw1xRD/8AorP
         gpqHtEw9Mwek8BqOJqAjDf2S2BgtoHuFH4GThOLg89ChSANix14jEwjmKgngFGovCfSP
         mPGr449sRx92GGW5YwQ6NAjNwtCXimiFB5xnfPTsWF1AOtcNQJJBCRTi7yYdJnST6ow8
         VDh3t/WrTQO1GZbKFSdxtlhKhexFmNH8+yn0OIWG98n8Wn3xZwKeIHRZYc2Zwqh3JM+e
         3sn+2XcdNs3haaQs8fuhofpSyHU4YGHOi58Pxq6YzrUQ9SNtGgzUSxioPonOZXlsRE0r
         tH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793100339; x=1793705139;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9obiJV6/iqW7NFW653bfL2cp4Shx8bwjv++1yy07Yhs=;
        b=AIHg1ku8EZX5Ft/bmkiUlcB8z8hWcB0j7/3t/E8k8aiD8VX9rqXXlItZvCGH3GxmFz
         C5UocV6uvXUGpYYimB70TQXx37taFiKXK3BMpbQ6K/8JOc1IbgaxJd88po+4F7TDzYw3
         c8yZn1aQB9IN8oO/59q5eNBwZ5xO72d/W6zRyiuzB+PQ9x+/DCN5B3lZl168KRymP2jS
         47RxZC1LvT8O7cydz+JkoZxKNJVdkfaJsCQPxAydvnxo7pFDLJUw3N9ncswWzrjV2Oc7
         yTyScve47t/XHTzZzP7i36DaCYNvtRTfm/cY+xIWNHwCoZ2A7u1yGGrDpVd5TajHr8pq
         WOAw==
X-Gm-Message-State: AFq9FYIkO6OrXISdRiznUAaksWs/AsUHlFiPP8HeCwuaHVHwx18p1MOf
	Nj4C/gRm0wqg1PXCXOxuVdsPrkmcolpWyZAIEGF7O9UORjA6oCxwiYlHplbtmw==
X-Gm-Gg: AYBFou1HKzl7/DQcuc2NMFPGxMqmJkxNsHvIYGBe8hYgq23wqBVA90fyajLVzwIbpVo
	AUjG3gX+4Kv2W+nwjc1QldJgrRN5CkCba1Dj8pa8bFoDPpFfQ9e0JIZCbaPdb77aFrzNP7bYkrF
	a2frlmo8yZR3tosCM6AQi3uY6ohEIYT6cg/J4doMCZ9eS6JDQ3QBuob8+QSlwggbgeG7nKNzDZc
	AJl7gtdo+WhQKZ0KTq3v8GDQ5hQ2nIBP/DWxe9xYGJqGzod+ul/exeBJIvbrTEwgS2ptgEDXRgr
	58TE7Jwy+8jI8ePMqv8RrVCSr8CGE7s8toJ+bfMKpx2C9ndevJZq61OzHWMl7l2sf4CBKFG1FSo
	YpzojYJXxSenG34wiPV9GkM/vP4i6s6PG0A0VQb2DI9uZZEZx3JC+R3DpB3c+sghpfKTCke6KNB
	cFmSmgXHg8S8WwTWF76Y14eqR3dOVYccMfNkfp6+iQLOCdJWU4r/1akaJZTT4KsJD0Hdbh/tefQ
	z3jKj9S86u5zNjAmeY0egVp3aCiVsmpi1cPmZlslROO3GWVfRuXvHW8zTByVQ==
X-Received: by 2002:a05:7300:5bab:b0:360:b8b4:840a with SMTP id 5a478bee46e88-369e866092cmr19956787eec.39.1793100338968;
        Tue, 27 Oct 2026 04:25:38 -0700 (PDT)
Received: from [172.17.0.2] ([134.33.99.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec9276sm56619432eec.25.2026.10.27.04.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:25:38 -0700 (PDT)
Message-ID: <6ae08a32.4b6e150d.3aa805.fd51@mx.google.com>
Date: Tue, 27 Oct 2026 04:25:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2317709143563042702=="
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
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v3,1/2] Bluetooth: btintel: Add TOP silent reset hooks
In-Reply-To: <20261027054408.318002-1-chandrashekar.devegowda@intel.com>
References: <20261027054408.318002-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2317709143563042702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194286/

---Test result---

Test Summary:
CheckPatch                    PASS      2.10 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.48 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      20.76 seconds
CheckAllWarning               PASS      24.85 seconds
CheckSparse                   PASS      27.21 seconds
BuildKernel32                 PASS      22.17 seconds
CheckKernelLLVM               PASS      23.99 seconds
TestRunnerSetup               PASS      443.42 seconds
IncrementalBuild              PASS      21.42 seconds



https://github.com/bluez/bluetooth-next/pull/1004

---
Regards,
Linux Bluetooth


--===============2317709143563042702==--
