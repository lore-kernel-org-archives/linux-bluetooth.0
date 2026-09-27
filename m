Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CBA3BB57
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790472133; cv=none; b=n1dVEgaNL4IJKfXqlNxqVHrZ8y6kynzU+uuJkUbWYOg/XG4vPRQPqayKaWkIQ8+elV+fwIGBAdJoRdpBum37NTwyxFXtP5fbSy8SJlI8ZfjPMGzM/TrdRlvOza5jt7R/zkhnOGXbsaFCKlyhw/wafEhKdq7XrVk795X0SC0ksT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790472133; c=relaxed/simple;
	bh=b9xMfjTD7C/joaK5J4/bPZ3O121IZTM9dDigxRanMG0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=puQr9wHQbZD3sbTHArUzAgS0C9jWChu/zNgu13wfFgltATtsCx8slOjdCdXXl5s+7vXXzkpLBAHAlLgBKXyJuwXKvW0aWY87Lwgitp932RNk4uIrMBzuicTEfQ5vHEn9gUhdH2NxQf+h+397TAs/34MuC0BIA2IBC5Vk/CEEu0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPqiHiiT; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPqiHiiT"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-342773d94a7so858548eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 18:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790472131; x=1791076931; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ck6JN5b4iWrILp2bb31IGImU8S2fO4u/O7QSwVsmkXs=;
        b=fPqiHiiTnbNBxRgdllEE9Wvu0wfLJqfzxFfAJHXajCGiEzfUOa7Yyi7TgidrOUPxQr
         uMkH4ovkHiiOvbpAZyjbxUerQQKCxolm93XbF4pShtZJmbwaJJHaXfA19oXvU61vx0b7
         zKuf2YzPcP/qhyZ54XuZc2h5Ma5coZjiJV1HhDvUfh97s0sLJM+2HKmZbMFxv05Q9ASn
         tbh8og9kKRBspCgQD/QpAJI7+NWCIUttvWRPvV/a4UEslpuDwg5pFjuRXiGqtYiu9yIr
         v/9gr5hG98ElcbpOZGmq4HG1KI50fOpC+1amfndPC33AJ/p/quQsd2T8ePigC+NzM/Kz
         N/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790472131; x=1791076931;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ck6JN5b4iWrILp2bb31IGImU8S2fO4u/O7QSwVsmkXs=;
        b=kM2olQLDyDK+M/hWlpGIPfabS4TmrhUiJiXTHPpQqQVryUQE7eN2p/SqxILUMI3Oil
         adb3xlWW2aTXi6yEAOzxqljdwpdawmHaPVRK8PpFax2kFaisXOvgspwcvyNmIMp23VrE
         8nDgg4qAuetPrZyat0AvoFyDAu1vtQRclE9IGr8lG+8S+hjfgjUMpx8KUZz/PC4jEX9F
         +3EUBNlgOTgXCAOsfJmjyFyrERZMZrSe6ZS2Y0BzK91pUqeYLck9V7WxpsuWastDHywE
         +llPkuLygeEYBNcPtwbBcWro1uvzYB2/jXk568xdDaBsuEvipmJ1jka1T+w0a5yrfLmt
         IF1w==
X-Gm-Message-State: AFq9FYJ5nH87aTcMs0uxaWGMT4Vc2wcBrUrlkaYoMlIjaBVkjhZtnYmy
	1HEYZfLjOaW1oplRaOjhC2bDsuqPN5yF8Nh0Yf8HTdokRf32t8DB7HJ3LknH5A==
X-Gm-Gg: AYBFou1KyOWn9hvamaIMzteAeuu05xCbOw0KnPKgfa0kyeCFkXBe+EXTYuUJRmvLaSi
	IczKDUWBmEw/qYo4vFl8ziuMSt8h2S48cOVxxen0BqFp7PZYiXoC8ydwx4YgZ3DWiHN1ZgjRoFY
	lr6bUZKEmBGGXfLmYQSIw3Y5CGWh/43BeaGHJkFC0D1pkXdB9kZGsUO1TsQA37/umrR8ZVp2a3T
	FCm5vKkTs3vCc8laqRj1BDml2Y08I2iA/kBZd4ZW0HWoz/DLfcA7vrmE+XfjKreDc/99YtQE5/X
	s8ZAgBCGWTx7T+8XDTauBI58q3BLZnuThXdkDKhQ1KMJTQ1zdSfpqVqqoztCgapTkyYPUOlgRme
	7z0TdU9nAcQT3xmZeOAA7sTJHnbtnRHBFiz458WA+bi4KGveDkea95AIyUMcSO3RcEE3dCxFbVn
	8/fk4Rl2bnJyEbCrqhnzRGbXDRnco6L0RsysmY63fC5gPfGUwPonOu7oBiHQxraPlcXRsPTHdPE
	b+t2Wq8tg9WKA+L
X-Received: by 2002:a05:693c:8816:20b0:343:6622:ee15 with SMTP id 5a478bee46e88-3436622efc7mr2692274eec.11.1790472130377;
        Sat, 26 Sep 2026 18:22:10 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.229.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144172d8asm18946747eec.5.2026.09.26.18.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 18:22:09 -0700 (PDT)
Message-ID: <6ab86fc1.80a95698.2528b.b067@mx.google.com>
Date: Sat, 26 Sep 2026 18:22:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2557041131657794053=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dev@grantmoyer.com
Subject: RE: Enable D-Bus activation of bluetooth.service
In-Reply-To: <20260911213253.766659-2-dev@grantmoyer.com>
References: <20260911213253.766659-2-dev@grantmoyer.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2557041131657794053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       Enable D-Bus activation of bluetooth.service
   Pull Request: https://github.com/bluez/bluez/pull/2520
   Created:      2026-09-11 23:16:16+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============2557041131657794053==--
