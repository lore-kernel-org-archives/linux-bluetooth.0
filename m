Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A746C851
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791935917; cv=none; b=EZULWic4FZ9zCvjzBqIHcDoXWdrYkH93xxm8L3usbY7WawnXPC/gCG3XY5bvPjxpngDQMFbEsUP23dOdcqIPowj4qORpVL9nDcIhv6V3cxYA0G/ivgZbG+3Xt3ljO/z1DeQgAr5pZwRCT00EhWBlfbkYwQHmXWTd8zAckidG36k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791935917; c=relaxed/simple;
	bh=vQHh3ItxF2HU5e83BpdZUW/skFAKPN2CMIoY27o61do=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Kin56vD8P+9WY4AbXIMmRv0mjl8fhnkUe9VEVHicbX3/UDNpNK35CKkKWlEh0Bcp1RO3K45kS077MmeZyEgTAABmJeo4T0fusNTwKcP0Y//UkZN+ae5pTTuuasgYM6JuY1jmq9Xj22Imy5ltWcy/jeu4s2CMkdyQgr0fmxEoluQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0qTimBE; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0qTimBE"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-504db7f7870so2524657b6e.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 16:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791935915; x=1792540715; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ltbzgl0ps/jcsF2UXxLXXTMLdoB9dZb+rsO3mp1yQBU=;
        b=V0qTimBEmU5xALXmxqHREPm/Lnxz5pOdVw5MKGBjT022Yj3yA2UY0EzXnsDXm/rTBq
         LwZdw5/2rT/eWgDoFAggB0zSkfPqqMrP/34Xe1o57kxsmIqGqXK9trtnWzSM9xyO7Qp1
         KIQijAbaaew38EEem8XJK4yBamlvpkEEFfl7AKl3O7KhoXWOo3y3kW9O4I0ll/XSGYAP
         cPIELVHxqw8nHoMdGphd9PXZWAU7c5DdLnkzH3hKuBksPj4/Q/BzHURFi71HkchGKBUH
         gZEilEbL8JJS6+PF9jbJW6m+6BfwZ5uQqNI+tL5tpC+tbHsrZpWiA+klfxik0+Ie5kO6
         BmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791935915; x=1792540715;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ltbzgl0ps/jcsF2UXxLXXTMLdoB9dZb+rsO3mp1yQBU=;
        b=1Fwok358rmXjUylwEXWv0JOpYiu9DYWhSThdF8z1PNLI+T7Zb+kNPr90bra+yvxpJM
         72H65IKAi9SKax7ocj5OTj3M4NxWi1pP969KkBtNRZkJuUkk6pl4DP9+mahthqcWnTc3
         UNnrzj8MVNY4fSVtjCT9ZFHo3c4lAX5d3k6SJFNuzWkJs+TX04+lachrDXob2Og9vyu0
         /boqYeAPvu3kdLNQaEWrlYVhYtqUidBevGliFgvRpcJY8GmIQWCxLbXNuVzQt4X5fOOw
         b/wU5gQ9XZb/GBlf0SsZDoW7sfq59Xao4a6tPZ8v3pNduIqVruLrB2T1FzLMVxhEGEQ0
         cHyA==
X-Gm-Message-State: AFq9FYK2r8bzHzMr+ty59oEod7MqF1lS37roSXWHY2BWDcxUdKNae2ds
	bcLb/CZyC3c0Ucy/NRVb/9S0f7paziNgkO7EDLwcztiYrVCHIcNVzgb3fMJmrw==
X-Gm-Gg: AYBFou1ReVWfx8FKfGRlMIn8oC6C0pBnsdZrS811EiFd7ufd68RTJPACPM0KnHhAqp8
	MEQzCuRgNyiquLyI+5SvF9ujwC6lzgroQZNI4YJ/UwK06N7gqYzNYZ/bNSszMWKUaP1eUeirbDA
	sCFjRht3D75i86W662Mi0n3PS+pcRCAciiJVbFkN2KgZuDJDCs/Gs+815ytH/z7dfiumV2mAE5v
	1k4BXI2c08nIesI8YvzTbofSyy2ylYp4r1GiQrHSR1nRegRpTqDOiJNMvJydHUnRCCMMuDyJihh
	a8SAtkHnDFj0bNoWj8uF/KFiMMsm81crCzOxomaqPRtIgojxBUEcWjTrSP0kLAeZK7cLekf9A/J
	Ceu/rPy98SDtHbqYy0mGjH48SzM55MHnvJlqc7vs7IWvMFZYMdPW/ixNZtSl0rmOM4Dae8WSO7o
	vpRkBwER6T0pnZNAcSJqGjrT6frz/CF3vt6typ/SOawHTTJOp1I1HfQIYzr6+9LvQpDlHsp2MQQ
	xBk6iHv33KL2KUp
X-Received: by 2002:a05:6809:1d9:20b0:4b9:a829:f015 with SMTP id 5614622812f47-52bb6f85182mr821265b6e.33.1791935915116;
        Tue, 13 Oct 2026 16:58:35 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.19.50])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c0c5fe7d0sm15375634b6e.2.2026.10.13.16.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 16:58:34 -0700 (PDT)
Message-ID: <6acec5aa.31957b85.3ca339.89f5@mx.google.com>
Date: Tue, 13 Oct 2026 16:58:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0684131054541501978=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [v2] asha: allow LE 2M PHY on the audio channel
In-Reply-To: <20261013222355.511390-1-cochcoder@proton.me>
References: <20261013222355.511390-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0684131054541501978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1185114/

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      17.11 seconds
BluezMake                     PASS      248.84 seconds
MakeCheck                     PASS      13.59 seconds
MakeDistcheck                 PASS      127.85 seconds
CheckValgrind                 PASS      211.19 seconds
CheckSmatch                   PASS      220.73 seconds
bluezmakeextell               PASS      77.29 seconds
TestFunctional                PASS      1008.99 seconds
IncrementalBuild              PASS      256.48 seconds
ScanBuild                     PASS      907.77 seconds



https://github.com/bluez/bluez/pull/2674

---
Regards,
Linux Bluetooth


--===============0684131054541501978==--
