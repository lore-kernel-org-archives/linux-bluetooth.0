Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A183911AA
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789412561; cv=none; b=BwtRyoH8FYbJvXCUwjRfMx8Owi2Dp9Fv0HdQISmSHnwMyTzcKKvl+7PfuXQyqiomvS0Y2MguCHvZEUqr8Cth+xw7pfQSOw1geKR6e76mE1quQ/v9UbdFS7O/YrUHAbn4kofvGNNsYiYd76IWfMBjUYYvl9VC9wkEeMBaSxvIccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789412561; c=relaxed/simple;
	bh=FSYgXnZ6CBpjPCIKj39b+b2g4vbwAY85+oahBgC2hB4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XDDXZabPuOv89YJAu2NE/Wc3bnzRa00ilPlYG4Aa7ywZRMf4BSP5uvYa+SQ178WNs4UePqeQgbP/SZazo0MayD/L/FFk0UIfEocqDWEefcDuuGe/c5xPSyAWGtLJgoO/Hs/uoBmqR3rzNVAMUCETfiKsy8wYDTsB7b39glM2/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVCIqeTd; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVCIqeTd"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939eb3249c1so304045485a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 12:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789412554; x=1790017354; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ubBkWZ5G/ABAV2EpnAGK/xQRQ+G8OlTu7sgnoDUpiP8=;
        b=dVCIqeTdGoAgtKyS6nXxN1YEXCIAbsq8f73tqboGufBE5PgIlSQlcs6ka56SRaDBbn
         XJWRytGHb9Cc165oLSJw5wM8rpwFoiTIhfXelBp96cU5UQeJzXWxIFHbfnwnvDX0/z1R
         aVm8mBzDEad2I3VPVQqqQMOfKVCFi2DU9sTYNvpOv+L8yM1nEXAoGgx+sm89aeyKZ+F+
         PBv1QWXa7A2ikuD/04MgwTN/GmtuN/8vZ6Effg6uXWdNO+/bd0ZVcRw1GyjxFKIgjlzw
         3Wtu07tI1fbZ2UqQRjUlOr+gF2KiZ0/x38AtNYZQ5LoWuHYFCesGdEJiMnBjjkkndE8P
         3QHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789412554; x=1790017354;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ubBkWZ5G/ABAV2EpnAGK/xQRQ+G8OlTu7sgnoDUpiP8=;
        b=bmjhD06zAQ4+FBq0kZRN/QrL1KwLr6RkqYY6B419TlAhsz9HAI6nqgXeYeaTYIskxk
         LeW3WjiDyWnRkwxU1T2xyec/ew1GOH1wAMMx9DbKhOBq1ov62BKi8ukkgeXat2G7Gacb
         mApMf2xtBBUm6SkPtNae/nJExv+ZI4j5G7mwsjc4KOJFjP5uXGSa5ck9MoXP0MnNLUPF
         7Hzwj4V3Diw4jlHL+fl2rQR6QjdvyRZNyVHqJeDXqMdW1w3VN2B9E0CuiamCngepCnja
         Ar3lNVHnNccEIo6y03H1mrQIHXoNe4b/2t5TZ4++WnV3l5K4nPqhuhrkaEesybOc5Wgu
         Zblg==
X-Gm-Message-State: AFuF++mTdtLVCkhBQ+oULV2j3dKSdEN8xj1qTOo4Un53ZbcpTODHMdl2
	b54BGKca99fNY8NUQbYNbmgMK5JtMY0eYuTcsu6su4mi8yygucre68MctKNO/Q==
X-Gm-Gg: AYBFou3hU2/sTndqiqH6ehFegpzm4hXHAu6YdB3wiK7RY00V4/+IzSqLSmO/b807QQ+
	vjzP4ep0Ie4ixMXtlEdo1GZJqAVJb91jBJYMsB2wU2CsU7lROwR3zfSKOlzsjp3pK5JtqvLNzXL
	16D5Ss2b8qxvocFS2QIMXakPiqCPO44ORYnG7OZP+5xQmC/aS01gdJJw3uSeiiSUZt206z4OdUl
	AbuQsXuLfY4IFxWb7fyTt/qPZu0jFLsx7k6jnX9VLZIrUSlOl/BHnLPTsAx4vWgF+vKLqeFbRXE
	gvD0B5tmzAfsXkh5LZuhE+ip+bEU/eKr5woBm35Rh9vR83QAMJUz0dlfTARDVChy3syg8aoc4Bn
	wDt6HnBkMgXqkA3FkZN6h25m+0nILpfcC8IGCPTkZRogVDvHJ3mIQ8UOMets7auiOWvZAfaJ9FL
	e3y0wi9//rw/Dy+N4p8MpZLwKXkEbgNTAitEY6TIk0XPiR35xajE11ixVXkPiypgOwHruvDjKOj
	p10v0G3KKmLPefH
X-Received: by 2002:a05:620a:1d0c:b0:939:bc7c:15c8 with SMTP id af79cd13be357-93a29a97b1bmr625444185a.45.1789412554297;
        Mon, 14 Sep 2026 12:02:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.151])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e809fd0bsm1049109885a.33.2026.09.14.12.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 12:02:33 -0700 (PDT)
Message-ID: <6aa844c9.85560941.3633f5.cd81@mx.google.com>
Date: Mon, 14 Sep 2026 12:02:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8470184761602297916=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jhs730127@gmail.com
Subject: RE: [BlueZ] gatt-database: Fix freeing wrong client notify IO
In-Reply-To: <20260830154054.25086-1-jhs730127@gmail.com>
References: <20260830154054.25086-1-jhs730127@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8470184761602297916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] gatt-database: Fix freeing wrong client notify IO
   Pull Request: https://github.com/bluez/bluez/pull/2456
   Created:      2026-08-30 18:24:16+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============8470184761602297916==--
