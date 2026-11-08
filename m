Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794150386;
	b=nE7MQGb8ZeDY6+A/9Bd+KTDg+CGJEl5CDHEEouD3OJ5wRR3zGunaFe2U9A/bicjgtnVO
	 kGInX+5FrR4TPFcenwBAX0+0IH7r84AU5rXaDcaGaMOLQ8xTauZom+/xs6ONuRApWjIxd
	 X5vAh5h2NYuiGJFRWp4xMva/05mSwpIwZCzr5h9gb1Xh1hI8P8yZH5WRcoaddFMdCn1ZT
	 mh62/Y74T+R3is3ossaJfyybymeEg8Hai2TqFPWjYRuh66m9qRzsa3FGFajqZsps9Tuna
	 o/qkExqycTP7VenzOw7lpS5YBxIvtcbKNZaW/elvQSoOROOTlhce7P7ZbM/zZEQblWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794150386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=D/tJQXlVVbetAelX6q7qelQT/QVzJFHkeE+4A0ZlL+w=;
	b=ynqeqm4D/2V8G5gPKThAUjXRYbfDZTLM/Wv3TEqerK4OCGPrJCYIsL+b3gLY/heqpuTv
	 VMShTAG/CWvbHGcX9J4DYubHahbrORFEbVVpaWf4JNOs4vSmO2XBNvG7IRcJl2/v/jl9i
	 aM2YkfwcEdHKFVq6sEQsUk8H8RvixfCtPElbnjDoQmtDSSTNXuQI2h274Xg6YnAy7rzUR
	 IgLzIIAem/o1n27HKhTxmEVANJs1S7DTtWv9iF3cJCwaiDIv+hiocKM5ryOeh8/1edi1m
	 ILZrLlmo1bjMVTedw6oRnDCUjZY9yb4Gq8EiiBiXvzCmBOheo0pe8Z0wZSIzj4Sab4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DxajFyPR;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE962606A31C
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Nov 2026 15:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE962606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DxajFyPR
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3704d30b84fso156607eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Nov 2026 07:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794150385; x=1794755185; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D/tJQXlVVbetAelX6q7qelQT/QVzJFHkeE+4A0ZlL+w=;
        b=DxajFyPRBvN4uuOZ50j16rnBIjaIYQIi+YLm/yQzEfuo/cA5a7480+UDW//jUOiUwI
         YvoLH40GaCrEBxlAd66Em1WTJkRwlOVo1NSyhEJMBU7n5QZnTf0FMJLM5izXZCn2VlDb
         YxBlb/04y+IpOEGvsoTH09AAygT7YbUYCOr6Qk5TlYJZ9Q/tv/X+KWBVwnwXk+Nysnhj
         H5z/nIBp8J0E+JbG566ztgbnByqFSOKcJqvHx3tDIdiGUtHFotNRqIoITBiRSTMvo8aH
         GzpIcBQQsGV0DeMjL1jTXfugsPSo27uXYcywkpzpiPmaZ13G0rEFWSkMahxznQ/mD3Vl
         t05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794150385; x=1794755185;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D/tJQXlVVbetAelX6q7qelQT/QVzJFHkeE+4A0ZlL+w=;
        b=gHFY3JJYTIBkDxhDmwxT/4sWyQrAsP9xG9jwPAs1C2amA8qZvmjUUnaH6HdJeK3+7v
         3h+nM6n/PeKIRvAtqvWRWY092cnGIFJhgVFcIMeZYz4HQOhMxLo3V53MYlNsXZEgMzjW
         P3ct3KxIV8n+3/LWovM9NChKoqcv7KlOr23+eGedp0Dy+T+tlxe+21xG8rast+cQKHdD
         FLrTWb6mVQp9kkSFhRKEyLBA1N8NGuqU5Qj6m3qPBgGgWmUXhK2/l7ImyZvSbvfWJpQL
         q3S62xjenwxvbsNqzN4EHxFxpAc2whJSh0+yMdYUPO/8XawMyLsHdiEN5625NWbd82Gf
         QxVg==
X-Gm-Message-State: APuU4Z85qmAy3SXZSJkbFBRlt+Rmsobw+r8SIrrdggpV3F4XqlguZp6K
	kJRSKPRbCU+fkI3agY+xrK6nEavVn4m9crj+VRQUkooFr5Ta/q5GHtI3V5TXbQ==
X-Gm-Gg: AYBFou3Q1/QtBJGnAyk3qxaekwmcI+hl51qaDw0sp0uOm7m2WOIP0Lg3AIRwWzIOCMI
	gx/48hFP/TTT+G8MgtoGyBGDG+34SWHTzBGHAhn1HYccr2UhKHD0gAds4YuIoOpkJwubEY8XZEN
	7OHLz70x47UI+3j9kIV8QA33H6iNjRYKa1wPqfFXMdH644ARzUQ8ZbyZJBt1zAYkBsq3J+HlSfi
	GQbVTaLuK3yfVJm2zB9lNlhJOmiQmVUJtZqKq3nVqfy9vIIl7p3oAYc6TB1zGXgTbUNlE0xwzur
	OsuJngxG59JW0sf+Z5YQQPLozC94nE3zljR6uleVH5m2fnLYdnmjYS1pimG8TU43TXJx3WyrKZx
	EXaMothmb4u5x6e4thd0jA1UOX1UKFSnEvFnLEwKVwb4XMSmMqoJLkgFKvYBGbMAb3bQIZWYl9h
	Sd04E7PkNSa4gjJ0C+W+BXl9iadeT6+6U0/lgDDld7lPcPgCIqdl6S0EazsRS5ODNsGPiW1+Eon
	EwBW6QFdbg+wNuOzXMSJTXyJvGDzpGYciz1hjD8jYEPHvXzLJIrNXb0Wl4dDRk=
X-Received: by 2002:a05:693c:88d4:10b0:372:79a0:e8a3 with SMTP id 5a478bee46e88-37279a0e94emr2947207eec.1.1794150383468;
        Sun, 08 Nov 2026 07:06:23 -0800 (PST)
Received: from [172.17.0.2] ([172.184.247.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d6088sm6804208eec.25.2026.11.08.07.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 07:06:22 -0800 (PST)
Message-ID: <6af08fee.4b6e150d.1488d8.445f@mx.google.com>
Date: Sun, 08 Nov 2026 07:06:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2962952625747855794=="
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
To: linux-bluetooth@vger.kernel.org, turbine.bmw@gmail.com
Subject: RE: [BlueZ,1/2] smp-tester: Expect the identity key in Pairing Requests
In-Reply-To: <20261024112527.249473-1-turbine.bmw@gmail.com>
References: <20261024112527.249473-1-turbine.bmw@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2962952625747855794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,1/2] smp-tester: Expect the identity key in Pairing Requests
   Pull Request: https://github.com/bluez/bluez/pull/2708
   Created:      2026-10-24 13:28:12+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============2962952625747855794==--
