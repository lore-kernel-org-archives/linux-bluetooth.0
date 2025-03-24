Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B325FA1B
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826130; cv=none; b=dkM7AHSKjAcvxSmlgqCzTCCOB9HZ6lZNHvSTXZNkSlBneCMmPxPFPA/ffvGmtcsoDM/WaZLeYEUPtNsNN92CHQYxam2ugVE3ke+9huv5iq+6DWvNuk3rGPdKJq3b2xdL0m16uQ/ToJtU/A/2mZMM9pHnv9yH021PL3aGrLJ1rbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826130; c=relaxed/simple;
	bh=j95kRRU+dj2MLhdBQVJdnMXF7h3go8vrxbb8di3YtRA=;
	h=Message-ID:Date:Content-Type:MIME-Version:to:from:subject; b=eX2dNt4PbLOupdjkN5JUp5UU+QhIImg35Nr59bmG79c5TaEHOxcdood5SJVb3U9bzymxZOpIq/nzoexG1vn4sg+N1kSIEmYJPjtkhF8IaFXDCqB7CBso9jTFK4w6xV3+jEFDpbPGHD6LnTXKQRjvlJPppqwKC2/rP4eQh2+mAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDCe8mT5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDCe8mT5"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-227b828de00so20144175ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 07:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742826128; x=1743430928; darn=vger.kernel.org;
        h=priority:importance:subject:from:to:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j95kRRU+dj2MLhdBQVJdnMXF7h3go8vrxbb8di3YtRA=;
        b=QDCe8mT5d0xoYuBOEQEphcPUu+hO+isxjpEkR8TknkcyCfd7v/cawnPxSYNpRFOPWw
         tvq0Db5Ox0cpZRlKUIPh3IkP/fBH8x26RvG7BYWcz9nVy3qgYiS3W/Op9bz1VVOawZEy
         6aYDjOd74ghgLPam93uF/LaO54Q1RuGByeWNd34TG5ZeqiNOZinSmJEHghq0WhlesW5B
         0oNbFTuPLjP4JC/4ojpwVvblUGFVX8PiwJ7/FMkKrL/Tm3QuQU5XW8KNDcSrHpZY8rMX
         b5x15VMpGAK+7H6H2M6MeAeKauRArbS1OaPpR2a5PnLcqJNKZLvKX3gbVpTZUfMQToqy
         bnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742826128; x=1743430928;
        h=priority:importance:subject:from:to:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j95kRRU+dj2MLhdBQVJdnMXF7h3go8vrxbb8di3YtRA=;
        b=FseuD0M2beyr2NHA9CqQ1IBBeNyCSK6gb7rwSv7NxTjLYQMvlmTU+N3TW3rv3UiRgU
         dbfQpiMQrKm8ru8OQ6KwArrqJw0B0w5byv4DY+la3WiOwD+Dswz4zMCet8VQcJzE/0b8
         jyj4BkmqVIdYlY329xG999Q7Q4bGqrnl5uS29AZDBSFeHJdwxsmOFl90hhhztat8zmke
         8z24hMY8ywW+J1alQlfl/Iba+JpIKKfKszrBU1HFGvhQ29Jd8zIQn1HYsCXavSj/3GCd
         vu8zdArC55C016GUY1H2pKwCaysBmowz8hLgWOmOzSoH6LbkPNm/2Wdb8Z2HzHmIUOL4
         SDgg==
X-Gm-Message-State: AOJu0Ywhvn/Gz6ApXEtGp37NT25qkZSF1+SMW6fWAVnq3MlEaBi1gxi4
	Vkzp+SJu06JddKFzraxTsY6hNwIHG8kOmCi+rWQIfV8cBDHl7m3oPj8IJENP6wg=
X-Gm-Gg: ASbGncufYXwjHvv63My3kfib4JezQInTzU58QoYL/XYOhXOOksX+IT7leStJaLgpsPE
	EOLwLhWWChzUxvwJR0++PZj0Y3FDtkymvU0QGdN3aC+0FTaqI7vo6/00mEYVdX+W+g7SfU/+U4U
	C3AisU8jeyqJNp0G4cWQMre+carj28+SfWONcznAncn/DqMElGsZJwTOYuhv8TGV49WFc9hN1zb
	ioxj4J6Zorv/PpuXK6BxwswTy1N6Dx/734G5sAPfRxq7Kn2XviFrR5KGJsrBgPcW8r6gR5moMas
	3CncPKygmJj49MosEbt1WwOIEqbppQhh86JJGUmcFNMnw7SqchGZ5az+K15sCyBLH2tC3feC6Fh
	7d5l4kK0bW+wSzA==
X-Google-Smtp-Source: AGHT+IHs5CnPVVyE2VQ+KMjDByV5/6s/FEQc3dgmoEtP0ygS58zyPatVNB6jfrbu1XvKg0vLuhAmAg==
X-Received: by 2002:a17:903:18e:b0:224:376:7a07 with SMTP id d9443c01a7336-22780d7c801mr172374615ad.13.1742826128337;
        Mon, 24 Mar 2025 07:22:08 -0700 (PDT)
Received: from [172.22.17.136] ([43.133.63.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da668sm71408735ad.188.2025.03.24.07.22.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:22:08 -0700 (PDT)
Message-ID: <67e16a90.170a0220.690ff.dadc@mx.google.com>
Date: Mon, 24 Mar 2025 07:22:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1023673231645859221=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
to: Dear Customer <linux-bluetooth@vger.kernel.org>
from: Dear Customer <eliashossin2110@gmail.com>
subject: Shipment 850830869576324925410 has reached the final destination checkpoint.
Importance: normal
Priority: normal
X-Mailer: X-Mailer GalaxyExpress [v1.5]
X-MimeOLE: GalacticMessenger 2.x

--===============1023673231645859221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Subject: Successful Renewal of Your McAfee Subscription for 4-Year

Dear Dear Customer,

We are pleased to announce that the renewal of your McAfee subscription for the year 4-Year has been successfully processed. Thank you for your continued partnership with McAfee. Your loyalty means the world to us.

Renewal Details:

Product Code: AQBR-9691-6556

Service/Product: Webroot SecureGuard-ABC

Amount Due: USD319.10

Please note that the renewal fee of USD319.10 will be processed within 12 business hours and credited to your account. You will also see this charge reflected on your next billing cycle.

If you have any questions or need further assistance, our customer support team is available to assist you at 888-350-2394.

We are grateful to have you as part of the McAfee community!

Warm regards,
McAfee LLC.
(c) 2025 All rights reserved.
--===============1023673231645859221==--
