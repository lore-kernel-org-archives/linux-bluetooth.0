Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521354;
	b=Iu1mEcyyGKJMeBLEVnGLh2e3j5ZQmmZJSw5y1C9cUuYToq4yi7xC/BBE1iWFAHdzeoWh
	 YdfG/awNU8tpUkTPwgC7rwI9Qwg48BLO8oDPYxGkEgAuvr54zArKU4U3PdqC0aWl/teAV
	 vPBERmPXgSZX18L6hc0EpDB9AH+vGfNt77djoCJxNuBwp2g9RBWWaRE8Do6UkopwfRtlY
	 Qj9QmD7bWGy7jyWR86OrQOXNhcjSYUHEsoAUCpJ8QoXqpDck2uO8HmTghuQ8PNpvAx1IR
	 RiA2up/nn0K8t/LwySXePhUKT+p8P9DwlXk79Nwy1CPZ+6SzRIBm63N5fCtNX/uvAzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Nb0IJrNmRpQZtC/y1+0O1qMeN/vJRNRlcJBF+XwJ4Bk=;
	b=zz95MHJ343YL+nnH6qNFu6f5FQxgdqUBJONhVpwNEpXTIfkYMRG6ex33F8N2lTd34P+m
	 wQRFjsNSU8lpZpYK+sLF7NauMDfIyh/vu7WFo57nXT9BDcbiWV3VaVymg9UW0GeFKgMwi
	 1UYP97FRLEiXaSts8JVQVv7nNFa0dJD6TqlfZP9rdEDaa+QDv3+bapMAaa+MClFrYOHII
	 ibrcxy/rIwUwdozwEphZqK3qHSO3w1sq6U/y0jwLpEdidD3oWdt3kcdQhQjhgS9srlWjP
	 Ej1FFUbaC54cbSUV57G4nyt7wDjLgpTm+WcTpcCD1EF0Kdsh22z8tkjkd4RuZZl1ZZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=0Egx6ufB;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD552606A335
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 11:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD552606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=0Egx6ufB
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4ac08f4a0b2so3141944f8f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 03:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795521352; x=1796126152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nb0IJrNmRpQZtC/y1+0O1qMeN/vJRNRlcJBF+XwJ4Bk=;
        b=0Egx6ufBYiZCX2t6sVRsLchthWat3O9WetzcDD3s77VPkZx6/XLb/sU38dWOutbxFF
         E2GwbAPw2DhsGuVeHTOTkqR60yblHd6iX/CxhtNpXCbfT8++GQwV+M7xT1C8gtFzlX9Q
         lP3v34qw5U/KJm8sHqBOpOWO7XWJ7Rmeh+GQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795521352; x=1796126152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nb0IJrNmRpQZtC/y1+0O1qMeN/vJRNRlcJBF+XwJ4Bk=;
        b=CBlLeP4RdXq1bhdwUw8Lx/8hbNmqmWYfOCY70HlKfx+WlOIYJF6EMm/M3Pz/PIkSQK
         KQXyMpO3E8Ob5PuDCHUSRYeeBUeUzlt+jnbjOLKl0v2FIrhOqQzAgOedckP+MQnbbY5G
         Qlga3mKRTRYHNCy6JnjwjVu73TXZ7BbMbb3rIGTZFuVneE20KoJr6jxvVoAUvzUcQhIA
         KKjobp73u5eIfFpbUnIjlaqX9CA0cKIFQ/mY2Wux4oTTpuZZ9C99tcTHuZf7DGgXZlg/
         v/9f5b3Upo85XDcCTbrP93is/LR01IAXiZOKB4nzASRniUWC0scSohNc2VQSZJKghkKO
         Qg3w==
X-Gm-Message-State: APuU4Z9BydzZ1WF3CwDEbEO40s2aL4aKklPNpk9Xegsk2C8o9fXdUbQK
	ehQQvK4BW/QPiTBiMW02V8iDNJON8oo5bpC/x7ee4aon8lhXjOTjhZ3NvqEEK/rEbTJv608YAIc
	gSvaG
X-Gm-Gg: AZFdTZcsSYZB2KqkHQRVhNlwloDguH38EPZSmnWTHWJAgKCFXoFBq0/WnWx6mWSGPgq
	mHWzIoMMqyP9hzFOsO84eqfdCjhjKOpmEGhpEzaQftXFlw/OczEISge6phBhnvYmB9KhErYq/ot
	KU3/3ngzUqjDNuA/tG9KmUDhl8Y7OG4UnJZg0g0z4g+KDQcPkW9CJyEdgbiJlKI7GKtKxxh7wGV
	O7pp+yj3/jdcu0gvIHz6S93c8U8C3ALt2wDuB2OdA1lXce6JLlHsNLsZERyo0AXOFtS2K/q0RFY
	P8jHmg5pKqw2U9+lU5eyGY1it3e8y0e1pyUUEMkOZNCMhHaSRhwBS2Wan9ffdaP/gvx90eEhBMb
	OMhatGMofjLP+SuqTK+rSw3nuQtQszCCuJcgZ3g7PfgKBKbGWt53zQVNNi9eC8F8ppv8bq7ApPp
	8RMXzKsbK5CAwkkSVFhVHwGF1QJv9ULvEh5xFT7Z6BIMb8Gu80pOgg/2p+VKdS5CKY/Rx0q8qVk
	+bT7INDKBmvwn3Gmw3Hk2o/PitFjci2Q9gSf4HTr5K45BlAEzCg1G8GQ3MQEeDtQ2jNj7oWbTk4
	HpUw1cY7rU6feTQXJXGtc+oCx1DzYgIMMrmXG9gnkW83I14kGg==
X-Received: by 2002:a05:6000:2607:b0:48f:bb92:c5a7 with SMTP id ffacd0b85a97d-4abb0c5d665mr28482405f8f.9.1795521352152;
        Tue, 24 Nov 2026 03:55:52 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110d56sm26566210f8f.40.2026.11.24.03.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:55:51 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Don't report a cancelled PA sync as failed
Date: Tue, 24 Nov 2026 12:55:45 +0100
Message-ID: <20261124115545.1890095-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122201519.2859075-1-simon.mikuda@streamunlimited.com>
References: <20261122201519.2859075-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please disregard this patch.

I tested it only on a 6.18 based kernel with one controller (Synaptics).
On bluetooth-next the patch is not right, and with other controllers it
can misbehave, e.g. a listener may get no report of the timeout at all.

Sorry for the noise.
