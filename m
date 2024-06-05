Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A8917559
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jun 2024 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623795; cv=none; b=hGaWJ6+voxYi1pru8oo/lwyrK6BGPLAtZu3UK7RA+AAqqmMqBLvAczKxyJbJnhxzGZ6pzCsVG073CR9LWRjiuZAOmbYbr9ZpnbcG26bP/pWqsSsdwaYhNS1jpeDMgL9hVGHsjNhAfWWAEYGltuykyItvkMMt39g2ycEPePOz/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623795; c=relaxed/simple;
	bh=QoXRPSsedGQD69BCZ2Nv/SeoeEMasD5DC045lp+T0/8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P/yImxTv2H0H4wpsm0rlu9jNuhrRrXB08CPx0yKFuCz5hF0vd2aoztPV/Gr2Sf79UEsKPUjQSulS+w+pzXMv+7H+ZbDvdm2Os3bs1x87B/PJ/Ihhdmzu3lW6LBUKRKs3LYn6lYM+NSHG5calWimurdOPx53WnUy3dTzxIIp7g+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMe9V5gA; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMe9V5gA"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44022c9433bso1169471cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jun 2024 14:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717623793; x=1718228593; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FagD27VUEmZaJ4aHFVqUufXDXYdVSylhiVminNZPjHs=;
        b=bMe9V5gAWMWcJbnSNF2QHotx1oBMjyZvquqxDPa3RFEur2uOPbQNi+tBKVNJSkYATC
         kkQtLMNW4bEsyoV6fRLNeGTyWHVfv6mD7S0V8ls1jiizBodj4xHzloem89krgdE9p6Qz
         +y5ylkEzeXso9Xv4Do/DyImctemRAc6j7SSwZRjAYnIRY45ZtarjLaYvzkIDugk8hsOG
         BuLT2O4tb25n11FmGmvjCD5efnp6zQ16mf8YYs1n4vwAH3ow2mBa5zBZic6KnlNRnOJc
         pFUQFb6coNsi5bQYzBh6RllEpbKUW/5ncD+9efhr5NOh9zJWwUM3PYBPIRQInCbfpqSS
         8z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717623793; x=1718228593;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FagD27VUEmZaJ4aHFVqUufXDXYdVSylhiVminNZPjHs=;
        b=NXH+GoC2vyNm3brwu2X03qr3PqMzq/CLT6Kta6satobZ6ZCA9scu3xh1YJsytKLgIX
         5Y3nezOAf8KoDdUrjYJQ6xZBRz+ji7KjbHIFRZrnQasTidLV1kwxNdbAcZ93FOlXLvzr
         D9YoGG3dKjO2RJOzNVxaweZ4riQ2TZawQsDQrflrBZKihCn6wthzNhJQqBzor/BUp+B4
         Zj0JPAhb/JWZBIiKktXr8tOdsSFDxvtUJeuilvdR3gDmPuqAeiCSa4fymY7V7wu9D494
         +315QqiYexQQHF2paAWhJc4TTzxafkmjsnGCeJf0QUREXaRkFHljGd81IAVk2ZpBvaYl
         +4Rg==
X-Gm-Message-State: AOJu0Yz/xfjIOfL4k7lWr3MbAEEzFkygW3/4+3iglAzIh+tdbHaRjmwn
	rOhh7ozqKGrwcjlMsSnxTeK2C10CfMO6UnW31ugPWDeWo6kNqq4fUyAJU+2b
X-Google-Smtp-Source: AGHT+IGNesfR9jwS57pqp8qk7USXx7mLxF6P7kBzDbWLtZN/giHijttlyk8QLAyGRQ+ZnauHiYFmTQ==
X-Received: by 2002:a05:622a:153:b0:43e:9eb:d714 with SMTP id d75a77b69052e-4402b658737mr36723111cf.54.1717623793088;
        Wed, 05 Jun 2024 14:43:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.208.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038ab3484sm150551cf.52.2024.06.05.14.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 14:43:12 -0700 (PDT)
Message-ID: <6660dbf0.050a0220.82fe3.0247@mx.google.com>
Date: Wed, 05 Jun 2024 14:43:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5626125654521142921=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] transport: Fix not always being able to Acquire when linked
In-Reply-To: <20240605195610.534491-1-luiz.dentz@gmail.com>
References: <20240605195610.534491-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5626125654521142921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=859222

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      25.78 seconds
BluezMake                     PASS      1716.00 seconds
MakeCheck                     PASS      13.53 seconds
MakeDistcheck                 PASS      182.51 seconds
CheckValgrind                 PASS      253.03 seconds
CheckSmatch                   PASS      356.44 seconds
bluezmakeextell               PASS      122.46 seconds
IncrementalBuild              PASS      1477.12 seconds
ScanBuild                     PASS      1036.21 seconds



---
Regards,
Linux Bluetooth


--===============5626125654521142921==--
