Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC7326D69
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 01:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767662188; cv=none; b=erPOWBIi5TyjB/Gc5OeeWBDZPX9UF1JlTjKAcGns4LsA8Loqoz0C0MLBTKLdVtO/0lUrtUhYe8GAOISt2xOn5ztaaxORgpeYUcD+nxns4P9MYOIdsHd7NRxnou5XX+UQ6L5ChzW031ywqy7hmosizhSxUtPIm4m1tasuVOP8Aoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767662188; c=relaxed/simple;
	bh=eX01C+oRDaaR9CMuhQzzR3Uz9cgsMlsp/QoxpsD+Huk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UPDNuJ6mK5hZt7P9pgHWA3Go4jtY70jiIX+NP3Z+8cqNKNxmpfrGzIfhq6eVfUOb75L5iLZ7i6/dWbIkr5MS1VuxhmSK0885osCC/QMPobpRwlLD24cQDt5tO/3YiAP8TH7mKHVnbBF0KtavFLBaGUY9RUscTOc3Ub7f5eLaAFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJJTIRYm; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJJTIRYm"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c0f13e4424so47543385a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 17:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767662186; x=1768266986; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eX01C+oRDaaR9CMuhQzzR3Uz9cgsMlsp/QoxpsD+Huk=;
        b=fJJTIRYmzjiwEzjxv3QNiJwbNz565y3yHe4NfmMvWB5+kFPddayH+mdp/s5wmagalL
         JUazO66py4ugHO74o1WDjf4UFX/9Fura1Rlb3qCoGRGTgSBWOc7xJZ4lMIfYwDr4AvK3
         ZgbCOonwKWLvwR3tiGTc8jS07OfRcEA0CLEeX+5dI85ams3UMVpny+dsH5iApWvW8vZ3
         CDTLV8Rs7WExJKWQ/35kjC5uVH0rUhWBnSPoJBw+Ng9uFEqQ/3e8VsXeymQS4WAq6rRn
         LFZkd9lsnVw6a54LqQgbwiS1gV21hq12vuQvWI8acIV8L/4Gf312ts5HQG4NHsFHePXX
         sO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767662186; x=1768266986;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eX01C+oRDaaR9CMuhQzzR3Uz9cgsMlsp/QoxpsD+Huk=;
        b=DtSwj3z678Ow6bKFtrBZpTqzBQDbwEEvFI9ZkeOkuiM4DEnvYWuIovy3ExnU20q70Y
         aJVK/Pj0ejSJfBHHsMRoWQo63BVoXvKNVh8v0SO8lh4AWEh90Yl/woRFe0SGT6vuIVb1
         QXh3E8CvUGCWUg8Jx8KP+jpU0uWuGEjcTcDsxFyECqX/aU919Y+feFLO5+JEKN5ERayG
         HnHxDoZUW9y6G3LIwrPRtanFfhyrXa3QprKesJdpjY5tbbzQjx6B/M7p0A5Lk+KNG4/x
         5vuK2uKZKr/FXUhFoE0ktBKuASkzImKyP7jFWMZNIQET567hVeY6PW2AHybwlr7r97Lh
         LhfQ==
X-Gm-Message-State: AOJu0YwZH1VDHqFDSImFYTQRluV/zYmqsPaevY/2sU+RXfSoG6R6TsIw
	2LTDczOWpxuDvVon03ZceTRyE0fw+ahmilKKOeLRe4XNe+r6BaPMKVqbkD+grtRq
X-Gm-Gg: AY/fxX58nNwe9cagflBO2C/gfWNlPoHYPXdW0Z+YwHLTMYzlIhWJHdpQ1Y++HoP7vxy
	Nofd2zncCzDHdio0AgV8cdM12nGETFIDzYxbYkJdt/DsjeHmeUBb6i+lZOeHHEczxsj3CAGKicv
	oV6ZsF1n1K/RKCeaRekRyqvEDlyMUJGPBKrGe7h32omW6KEln1KmIgwG5LEVr8yOkMBXwUmuvYF
	JOxbmHJlac04hm91Rfg0Qe2CkGabtDGbf+OBhcqir6c68dOwgEjaSZZYL9H3J7GLnhjucoSbEly
	ddAfLJonu3gBzFNvNFfhgTjqLaYzE+USQV0MA7rNXZ5NOkVC+gJ9aQl0EHRRtVhX71rvDeMpPGh
	AnOkR7ZysjLqvRyMH1gHE+kDed30QKRRZJXXzx4+uZJ+rZVB2Xt47jzhAx+owT/gh+3r/sIPMql
	SLarQnnx9W9B+hGTp0LQ==
X-Google-Smtp-Source: AGHT+IG6Xe+0/0/nfezzdU0IsPBVYwa3soJnOkpSXz7x1a6iw+k9+NnPUmrsnp9sqtXGyWi8aaUywQ==
X-Received: by 2002:a05:620a:414a:b0:865:916b:2751 with SMTP id af79cd13be357-8c37eb37296mr212989585a.14.1767662185999;
        Mon, 05 Jan 2026 17:16:25 -0800 (PST)
Received: from [172.17.0.2] ([135.232.232.83])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f53c422sm68046785a.46.2026.01.05.17.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:16:25 -0800 (PST)
Message-ID: <695c6269.050a0220.be4eb.9f9d@mx.google.com>
Date: Mon, 05 Jan 2026 17:16:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2278760718179522712=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com
Subject: RE: power: sequencing: extend WCN driver to support WCN399x device
In-Reply-To: <20260106-wcn3990-pwrctl-v2-1-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-1-0386204328be@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2278760718179522712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/qrb2210-rb1.dts:235
error: arch/arm64/boot/dts/qcom/qrb2210-rb1.dts: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2278760718179522712==--
