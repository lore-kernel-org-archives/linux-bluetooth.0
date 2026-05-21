Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CE11CB31D
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 04:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779337672; cv=none; b=RJCjaq6B6pbm4eAaw6SdJEnanpg14S3SKnbihlZoQB1eiIevQZltM9bdXXN8d4KzmdR43v8II3XttOxlL2jqUJ7LaoejY6wCHivj3TZcGUpqbZS+qKrecIo/ciyx0j9/oBmrpImHGeXzPqTR1aQdl7hLOsZzQUU1OqLKD/rNrxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779337672; c=relaxed/simple;
	bh=1oQuO0u/owkoscNhyQU0LQ03rYdk0T+n/zzqf15YXIk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ASXcMlGlq1U0H9RssnzKr6zO9jwka1tWd6bE4BUaUuWJFsoe5niuQCbSAvb9NAVbOn4QZCMYK5fNsSX/SgOXgGz29OEQs5+VfL7VLyut2KMyCZJC78sTHxEcYgTxDfUaP7pUt02bXb/TzsWQM+V0wwNiNx5ldxvYGHAX5NPSmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJFVs3cI; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJFVs3cI"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d75bfb259so35058861cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 21:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779337670; x=1779942470; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sQxa9k9B/Q5KM8yhf3gKTWQr35L8abe07El5YMDucq0=;
        b=hJFVs3cIUIRmqQGxoRRGMcH+A4wxesLxHEFVZS9935IUAOFWCyQI0QsdXJbVRGOwpQ
         ox7Jy+c/BviNuu1h06kImHuPmWgKgdH4axZOV7Ja0+K1IK/iW8fYWE7T46vLbO4JKnWV
         Clj8Ou0xG/MnQyG+lwpXuLO9u1xRTyAm+1q1QfYhjz18BW2Lz49xd4glfci9dJGsXDzr
         zPh6EpXXW0UamPTlmB/zFhhxlZqnDr/228OyGwd41TktuvzaNafbKYqdP1C92I0Vd3/Q
         JtLkmcChN/OEQP+nu6GjU2CH6R3Y3Mvuu6dJrQRewfsNW9/UNuZ7xcJiU5YbUEgzPgpN
         0Zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779337670; x=1779942470;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQxa9k9B/Q5KM8yhf3gKTWQr35L8abe07El5YMDucq0=;
        b=Y6HDDjXkcZYoAQakOjKC8ROGq9onalE9fdvKwOGaRvqR5jHmKTJgY8mpPfuMdgA4nY
         6p3zT9IU80ekWSgpl9zR9YM0k8zD/9Sa1cgZc9HolZySd6XubGoMdL5G8sXgh3QaR59D
         ozA1YhEwmIfO7B2G3RkVaNvyWKORMcwEZ27CrYE8qIzCmavsGD/qwdHiRmJ+YgbRqolK
         5KpsFkWTkND0Ti7ih1/qHcTIV3qZMuFzTErUgnhQjuChozjcG0O30OgL3B14HjebPYmm
         wxGpp2VEExCM/rVipNET9Nb2Ct6z9pSxLwcY3BN6+2LHfLryHxKS+w+M6hKVq0Ewu1D6
         3krQ==
X-Gm-Message-State: AOJu0Yz6own2zPS5fYpnjoWDNOje0sf/layJ76BeQR96M6tly/tmWHgv
	mRVJEdZEZ69QN5HpEluuc6bbl8NTqvlZwvRNfqkSxpD7X0wA2NSWtk/zMWE4Gg==
X-Gm-Gg: Acq92OGo5NRigV6KEkp4ANAJl5XeIqjfR+Pw+Y2Wmfaif1f2jqMdPD3SadSt2p5O7uV
	gKNxxX7Re4SjLlFmG5bA9v7o3J8daaWXz4lb0aRytg/EYwia31RjU3TDZxbommOX/VdoGrlmCbY
	GszhJwYUFQboL4Ws109ehVJ1dKqfOb+B2voNPk+2lJFHkRuABvdcEm0VIZD2ZIDZxzSNO2Ywmxs
	mTD78o/+mckS7G80heiYYeCZJZc0+Olr63EilxB2wtHgdpms6csgtSgZgN4zml/Zs0/bNZq6UiJ
	5U+GGNcYZ0NW3/WYTgo00JEpresYk7+Xtn0FlJnwIlSbeiqbm7affvjmOKmKhioMAFQy41K4899
	RMY5FmD9mnjUTrma8IyO7AcHINEvZ1g+lHTz9BK25/o83dROYZLNONVfnhWJBYjz6IEhyTzliJz
	PFKnN0DlPawHDWddniJmetD06Lr9Gcr6HpEr09AdppdA==
X-Received: by 2002:a05:622a:40c6:b0:50b:1e5d:992b with SMTP id d75a77b69052e-516c5607745mr19370091cf.54.1779337669708;
        Wed, 20 May 2026 21:27:49 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.38.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5168c968930sm120241971cf.0.2026.05.20.21.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 21:27:49 -0700 (PDT)
Message-ID: <6a0e89c5.5c7f968c.78fd2.c398@mx.google.com>
Date: Wed, 20 May 2026 21:27:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8908815828548436821=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: Bluetooth: L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn
In-Reply-To: <20260521023055.3272712-1-oss@fourdim.xyz>
References: <20260521023055.3272712-1-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8908815828548436821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098397

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.59 seconds
CheckAllWarning               PASS      27.76 seconds
CheckSparse                   PASS      26.46 seconds
BuildKernel32                 PASS      24.69 seconds
TestRunnerSetup               PASS      530.44 seconds
TestRunner_l2cap-tester       PASS      374.90 seconds
IncrementalBuild              PASS      24.34 seconds



https://github.com/bluez/bluetooth-next/pull/226

---
Regards,
Linux Bluetooth


--===============8908815828548436821==--
