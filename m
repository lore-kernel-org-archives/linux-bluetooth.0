Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8014930DEA6
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781113983; cv=none; b=YAdobdqAw5dSMc9AffiAraS3k9YEE2F5kBYDlYxx9h+4WFhORKl8R6NVgpXuUAqOFTGHMk4MQqUIc2nUBeM2D8I/Uaa2fQ9ZKdDZwnoWBbjL6P21ja02YcvqFkaMmPZpGqbPI1rIeYHqXq/W2HCjmRT6WsFcbZk1GdbPTcJ+isM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781113983; c=relaxed/simple;
	bh=JOBLQzW6+iLuNUpXuholYXKAPzkzJZ/5KwzVTjFbqD0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m218l8jFYk79+nP35EZRtRLwUJsIGu0tZC4Db6MD6jHv3H7xFCV2jFZq8fJUeC1I4Ydm8rbz52Qh0wZJ+eGPhNMBxqt/lhvme7irA5pj2MNYRqv3jBWoXMdLl+P1F9GwTOUQvWNuTjwnOEb++4qOGLM10Rfk/wAmQuN8mVU+WYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQ2wNeiR; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQ2wNeiR"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4864abba33fso88798b6e.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781113981; x=1781718781; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JOBLQzW6+iLuNUpXuholYXKAPzkzJZ/5KwzVTjFbqD0=;
        b=qQ2wNeiRiTJnBhVILcLuIVoyZoBPoCgWnAzOOQ4KbiOiY+2+rT3oaa3R2kNZdnMfpU
         r08hDi7q6VSDZxD/OyOiSGvgiUUTM7gUcFXDty8t4fR5NIbCs/pefF2PULRoD5ZYKzw2
         7g1tJEGWdQQZN6IypQrNv82lIeH7rEDTU9I5f/6Aty1xt2d11qekeUQv9n2cot4D+Gfc
         5ICS8hH50JsWnkl4NleQIVAaoxs3EFWQx3J8QHxBj7lJFZQfmhsG02/dOs+Y59/G0Sar
         rHTp5FnXAKQ5DmcBY4fxW0VE9xxXi62KRN3scygiIu5LJsnQiZ8tSKSAahJnYvs46b21
         nuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781113981; x=1781718781;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOBLQzW6+iLuNUpXuholYXKAPzkzJZ/5KwzVTjFbqD0=;
        b=iy9FcCybaYX7F/cP5uQ1RYIlDK7vse8fm/gfUqIy0oHByJK9pC1GPuEq/YHbeIKcmx
         4CleAItzVYUdaTWVWjxtZcROl+frp9qTgorYFrHLqHnj9d6s1kTJs14MIHpWEnXm68OL
         1i6Qt2zQ5V1w6ogtZVUSo801BTvKi0OX28Kwfb+/jLUApwHX52mwZCFG7BcKxYj2ySXY
         2hPiK05qD0wUi2BV1rOAU+oOoFURzgX5yy7HMDZ31qjRxTHWYmCfPpYauOtNyvtW7guk
         VzG5258Ang05CnInjpXFplnrZXwfsyjTWq9kFCY57gbeFbMLmCkpybs8Im8SrXWtP3iQ
         FB/w==
X-Gm-Message-State: AOJu0YxskAxVF7He1EaG/y7dbpdHWfh/zLtH6M10Nj1Hn7mXY8YTVa9i
	wYLwxPsLqW5jtNtDGeo2UYgNkoKx2TbHD9HT7qrqubk3tMC8hlYvjdF/Na1ewQ==
X-Gm-Gg: Acq92OGpX2X9uNY1/gxHapNT9yI+Ctcrr3vPhFVRjmpxJZe+gGE4qM/RnYK21yN+h6i
	7Bx5dV40yLipWVgB8uFdNklW5nH3eW6s/ROSRzfG6HzQWv8pRsa+ciGf5q7SL86pWqiZ64OoiZo
	U790vcYRf/E6CDeMu32d33LxEug02p1yj1XBrC6DwIXmWk3zI/ZnTIYI+VzXbv/vsi1TgbyrB50
	jGCt4GpQU0bucIaofZXcSoVr188SkiV++0+5ALTbmsaDc+uonpAeB/7JCyPZlCXcOnTTxN3O7Em
	vhSltx2mtLpNUVD4wUbtAUmxHVAUgYZBmaDmeUVbDqEOZFJE3zmFOzf4LKzB9s7ejwHtyhR83hf
	EJ5vZ5Et8YVBw4aNO2+cJxsbQdUw+yKtVoCXAz2e4Eu5dfhU5hyJT3WBFH5bWUUGOBhONQU76pR
	CA56SwCpVWj8N5UyGKBerWEVt8kjaS555dOau5NIAaeQ==
X-Received: by 2002:a05:6808:30a6:b0:485:5a40:553a with SMTP id 5614622812f47-48692d132f9mr11454675b6e.13.1781113981404;
        Wed, 10 Jun 2026 10:53:01 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.138.193])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e78e7f9csm17235348a34.17.2026.06.10.10.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:53:00 -0700 (PDT)
Message-ID: <6a29a47c.9a7ca0d9.f5a6d.a689@mx.google.com>
Date: Wed, 10 Jun 2026 10:53:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3011994356516075613=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Separate coredump work from RX work
In-Reply-To: <20260610162544.240444-1-kiran.k@intel.com>
References: <20260610162544.240444-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3011994356516075613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:1457
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3011994356516075613==--
