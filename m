Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5515886B
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720527921; cv=none; b=CtpqRCZh6wf7NUKjnn78gsCLfSan4KWVtwFqCCs1dkYV5dbXD1lJU4KKrpZ3dRUXA/j+G3tfw0G2jud5py5a8MbRYpafAp5TRdXZBbc8CzkcofNkV3uGK9jxFQ9KGD5isIkt0EF94uxXp/OVxeEwk21mYd99n9W04IWnGJqo+pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720527921; c=relaxed/simple;
	bh=zWwhdFUkeZ4+XXB6HDYOZD1T/blosG/lTrivV6wfQgY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kKRBGzurYsQmBpS1vIIHy1Hna8AaJcrjrfy2K5ZiqU6fVMj2HlODzHIhoPRe9lRFKx8d1SeY2dGiTX9+Mq045Ei6ure4Vkujo12yzPvrPvGlSRMUadUcTmsCrBJboWmydM/7NeV49rBoKWOrqNH5Eeo6FENLoyZBfmSQ+Dd8psE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Btmi7r/B; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Btmi7r/B"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-64b0d45a7aaso48187637b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2024 05:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720527919; x=1721132719; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zWwhdFUkeZ4+XXB6HDYOZD1T/blosG/lTrivV6wfQgY=;
        b=Btmi7r/Bx5o4veuQWkaJO2ipmnGaQVyB7elV8BX6iiJQj6mBYHNBTG1zwA5CwUBrme
         pg+gHTMiPFfzh3QgjszxMGBf3HoT4g/0NuKkF+4xVfDWh5z292V9jaRKrGtdvqGDfAYp
         zbzqLQA33rRTD7/LLmIZPxVUvKhPpyH+BuND1uVHUl9JpsHmw5Ci5C2r4HkFz69sB7iK
         rZ6WtBGw+VDup3IWmCK+jGUdeczWTZGPZH6RGVjrMAX0vrtTjaEysOO6mtZYRh50+Dqf
         SGESyUq/jFzSfWpIIixGnJIcDbAUlxZsKAy2cOSz/S/WRq0565GKkJM+AdmoW63tFtaL
         f+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720527919; x=1721132719;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWwhdFUkeZ4+XXB6HDYOZD1T/blosG/lTrivV6wfQgY=;
        b=ctHhka+b1FbvwCeheYqHnbVWs7kXfFq5b8vfwh8INbapii04M+BYHKGUboNCP2Qo+n
         I3vmgak0fWit6XmGZc2IcKknHD28ZCy2PA+/K2HC4jPZOBNHpV4geGSr3WDezPcZn27A
         Z9n2QZ991icVYGYEwaKchHZtDrpw1k7pXfoTsH0xJbtNDw6QRpFHw+aq5lpTsySR/dn5
         Ue2bbU0o31EI+R5QQR0kxRrjwX73mNw2q285/M/RXX4S+SyUjItnGTWNxVE+pxnP3KX3
         0CysXXlAIh7OCYtdDUF/0xwjAPFNfrJSDV6QS3lX0HvZSvWzHIUka+WCr+aC1qsP8VLr
         wgBg==
X-Gm-Message-State: AOJu0Yy70cTJtD4Xmjxpv1cdK63+1gl7vze14XnKmm2f43D0mpJd1CEZ
	YAwoEq6Wy/f6ooXyPluU9FNQwrkv4yM0TFF38TYKOA8BE4GZudnNLefwWQ==
X-Google-Smtp-Source: AGHT+IGE8cq6KnQzkh8EzBOdD6uDeE/nmt0Hdq087KfQvm6aPLBAcS1vY234Rpqn3C5CGIqAGqQKJQ==
X-Received: by 2002:a0d:c387:0:b0:615:10f8:124a with SMTP id 00721157ae682-658ef154170mr27690547b3.29.1720527918571;
        Tue, 09 Jul 2024 05:25:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.220])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b26b74sm9848911cf.18.2024.07.09.05.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:25:18 -0700 (PDT)
Message-ID: <668d2c2e.050a0220.19182.35d5@mx.google.com>
Date: Tue, 09 Jul 2024 05:25:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6410888309099196192=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: Bluetooth: hci_qca: use the power sequencer for wcn7850
In-Reply-To: <20240709-hci_qca_refactor-v3-1-5f48ca001fed@linaro.org>
References: <20240709-hci_qca_refactor-v3-1-5f48ca001fed@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6410888309099196192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sm8650-qrd.dts:208
error: arch/arm64/boot/dts/qcom/sm8650-qrd.dts: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6410888309099196192==--
