Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461534;
	b=uw2s5KHihh3g176JcV3KrMGKhva0frduhhGziElg32F1GhA0HmuLEku0QKVNtjfUprrT
	 1Qys6Bgak4bOzoHA2aZVBWTC10vn+44jBMpf3eCGsSnihYa2MMAIwufH3sFSSxJR1Cs4C
	 7CwWofP6GiXy1AxKqpqHWDuAgK1F/uWhByP6usmpvDjtAfrOpWMDbM1lqsA6MKFnNcAl2
	 zCMy8gLemYnaTLHM5s5tC5UO58VPun+FdpvMPSBs+a6Tiu+Wjm/DFB44DFMYSMSKU7sjV
	 qnc1BSHJBRE48pfmX2O1kMKcF/UOGYV3irB7xHgjNw+bwQPaJsfnSh5h9nwoB0YhZqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8bdUIArMEVujVxSnFXg7ASEB4w5yQy9UWzwj4XRgu74=;
	b=J+psMFVWJ5nnwprTeOjE6IN0m32iJMIZMLtRlawqdHr/tHZXQI6A6A8PhG7oFvMmO5yd
	 V20bAd6uhpvG8vhBV4p7rivAbWIfG1VynZAHoClnm0Vif+ElQdEA32/2SFfDdqyC6SnZK
	 4GLh23ovmxqHse0poqoMqiMTc8of83jndQvDzULyjZtbUqguFRMP9Ed+WzwqwOd5ey7jL
	 DlGSXWye8dD/752ihewkKvTWUo+fMv82nbDTazRXR8bq0SRd7zdq/eCjiBFf5R0+ovY1r
	 ZRUcm1Mp4mRzCh53XpYgrURIYThNxbFGTOHwacYj7hABsXGi37UPUyhrpYs5cz/rATA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KiVa2YK+;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A1A606A327
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 05:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37A1A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KiVa2YK+
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso1556276a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 21:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794461533; x=1795066333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8bdUIArMEVujVxSnFXg7ASEB4w5yQy9UWzwj4XRgu74=;
        b=KiVa2YK++8rPL+oDHtSbC6BXxg610PnN71TSFaCQMwH/7WEm10m1RZKAFK1g6LlMnF
         nbW+3+RfwUzWgD+d6i7L22JK/N87HiZPTpPbDhnjfMEXA275IkjSlNYSE769FL48ANrF
         PCwNR1nnrfDKWG6Qss/5VxsBk+quH/Vrp0dgBeDX00ZpaSFCG9QNHGeV104Kd3nDZnrq
         rIGJf+jMY9hu8xvTm2bCqEQ9Zu95m583Q6IM7pNuxVQloMQncqpbK0FzAV7m2dnF1Sn2
         V3T1MDFPqTorXyMwm0h6FM1WEguLp6ryEKiPydHS3SGwqqe/+h99W1Tbzu4IALH1exFm
         iwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461533; x=1795066333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8bdUIArMEVujVxSnFXg7ASEB4w5yQy9UWzwj4XRgu74=;
        b=WifYoSd16srL/slczf6xYxguYHJKBfkPhtrhEoIP7wWtsPAEQvEhaPNDfhaolcXBqz
         f1s8RuckNSg4D/x72IJ+7e9HA6ammZA2BMdVjGPNW+781cBW0wlk4nxjkX4B6lZeOb8f
         yuVc7+Odm5vwUmCej7vNLKVfXBU32yDSwpVUu28EtVe4HqOTUrFlom5Xi4ZXCV05mp16
         UYWNp9qWOpIDrnY94wrp4FX86oVYL/gtmWr1BUH/4+Cz6l0bd/31de/zyRdSti7HvL6j
         KAHQOtzsM0onctbaGwn6IQWKKEUcn85X3WPgUpFSmawGEG7EFWqmsrgTcN7rs9hKfKDx
         m+RA==
X-Forwarded-Encrypted: i=1; AL+hErF6lqmCOn9AC7ZZpLXnUblrNIksSoNy/lN/sVUBhA81fakXjeVbU3kL6Umy3TOgUac8iRjmp7ctZlGEhzCAfmg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8abw8yEzbwz8IHEdxDPWBYSo1j/zl7JCqizoiDgRZQjAClt9gt
	yFQRtOK3JITKz0qxV4V3gDdDsSTseqw0t38TFHERKxp3M6YBn6izUXl2
X-Gm-Gg: AYBFou2zL5MF2Q9Wh1QXz6DbBO565XJ1Vs3L8PPtdsORUsKPYnohNCPKdh+LFwDx0Lo
	E9uZiDVSLkOyqX2pTfhVRGZAR5Y06R8Ue6XeQhSl/0qFrLQSb1S1nl85/IXY44It6svUxqk8Olj
	MsNlYN7q9kP94FeAR6E3faKF98m4B7QlLUohgJu2SYCY9KvwUvUmTxMwdlRgT6PpCAbjqgE8Qed
	gJJ08p7jeA5MGGRIokuHviBp9KXPc2/KWWmL5mzOPrJU18R679rA21WGYkw480KlCeZNc4+arq9
	lXpiIt3Ru3iB1quIAZhB9VRJG7ZqRBikAH0Rlfy9rC4Dvw6WkOedSMbNhQ9OJh1Gw40N9pvwMEU
	zb0VzoE1A4zdSMbjv2MBU3Eu0y/yihXb88mkdY3uIAXeExwEWISO/zILKamoOVmWZ1D9FsuvH2j
	Aa8IU2BR8ROnzWH7KEJK66mqIAk0CCF4WuizREOkgsrr9Z55CbsFpVabNIRw8ND+69GqMyiDzH2
	uKwEJjGTQLJQtg+0T/i+pOzBrY8sedXtlM3ZisnjWV6bXhiV+2tpY4WugCJeEX6aOAdeWRg5wkO
	94irlyBM2EUxEiCKG2TOy++JmHb3b2SevJBV9eGyAI6YVPTvy35dNYN0gD8dI3UStQJCBeXrsw9
	0KPcOTvZMolpLmZ8m
X-Received: by 2002:a17:90b:33c6:b0:3b0:9e2c:9b61 with SMTP id 98e67ed59e1d1-3b182ee21e0mr4536093a91.35.1794461533487;
        Wed, 11 Nov 2026 21:32:13 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b181b9419bsm3600558a91.0.2026.11.11.21.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:32:12 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Michael Zaidman <michael.zaidman@gmail.com>,
	Rishi Gupta <gupt21@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrej Shadura <andrew@shadura.me>,
	Johannes Roith <johannes@gnu-linux.rocks>,
	linux-input@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] HID: hidraw: Encapsulate struct hidraw and make hidraw.h private
Date: Wed, 11 Nov 2026 21:32:08 -0800
Message-ID: <20261112053208.1397505-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261016-test-hidraw-base-v2-0-153f67a20cad@gmail.com>
References: <20261016-test-hidraw-base-v2-0-153f67a20cad@gmail.com>
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

Hi Benjamin,

On Fri, Oct 16, 2026 at 03:41:47PM -0700, Dmitry Torokhov wrote:
> This series cleans up internal HID core and hidraw header boundaries.
> 
> First, internal HID core declarations and unused symbol exports are
> moved out of include/linux/hid.h into a private drivers/hid/hid-core.h
> header. Next, a hidraw_instance() accessor is introduced in
> include/linux/hidraw.h so HID drivers that only need the hidraw minor
> number for naming or debug logging no longer dereference struct hidraw
> directly. After converting the drivers and dropping unused
> linux/hidraw.h includes, hidraw.h is moved to drivers/hid/hidraw.h and
> struct hidraw along with its internal buffer and list structures are
> made private to drivers/hid/hidraw.c.

Gentle ping on v2 of this series. I verified that it still merges
cleanly onto next-20261109. Could you please take a look?

Thanks.

-- 
Dmitry
