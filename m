Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B76F31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643753; cv=none; b=ukxTYTLn2t92T6D+GRKdhl6RfAiXBlG3gzmEhT/kVAVJt0tqKvhvH1bAgpENhLqck2rF77hWMTsqTStPgxr2PHlWoNhH1MMFift/s58V0E0IQFUJZ7nNHU0W6DRE6YAuJMP/5u+/KxEd64kswKMLv+8U0CnbWxD/BNi1FcwmDv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643753; c=relaxed/simple;
	bh=zt+xH72XysRPKEJVWtH7FU+lmnSjHcQwLMEulVxnOeY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JlaFBPpWUz5VkPs2Vg+rDLeKFqw15+3dko5+l6X6rQOAKGI81tNe2YY7jJJYbfLr7YmKrfip5J81p96Y1Q0vA0l8I7+8U8ktnJ0XjWQAF02twxGqya5lI5Ubi5JJovmhGp2sZ8KZ9URvpWCFbN9DyU44qi+FPG5o9LpdK3flFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSIqEJ5G; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSIqEJ5G"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fad15b3eeeso16761981fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 03:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728643750; x=1729248550; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zt+xH72XysRPKEJVWtH7FU+lmnSjHcQwLMEulVxnOeY=;
        b=RSIqEJ5GgjFFuh0GHmJg/NB77DdnqcSHwajuBFcxFB0NrZOoPU+Ku1ZnIwOb/bRbGh
         vh1zgCko3HsXBN52oToXUIjNjUl8NbcN7M1ZdN9CW22SJewSmuUBAxZo3BHRQvIb/Psv
         w8310ZgKqNYkcPbnBB/TNQWl1IehzQ9Bo+Nflylc6OZLzi+eYVtC5IpJVz6/0F7FQ8dC
         jQxYqo2WHLacPk0ajqBHOHb1ssMUvsG01M3H5lfawjrjRjrdNG4ud4juHgwYXSTprbG5
         xTl2v0CWFcSaPmBrtUgpfRJimtuuFymqAm3ArCXIZp5CPpeqADSHtth4EMgSzbhOHZbm
         yPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728643750; x=1729248550;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zt+xH72XysRPKEJVWtH7FU+lmnSjHcQwLMEulVxnOeY=;
        b=cPP0zpCCApqkciiGrRkf7HYTZ34HgkSolmD1Ui3mewgd3/I1WftMKpI9xWHACxBfM1
         FIahKMw4MA44zIgJRTRTbA+xduEgJ0oxVTFWpFWzLEXrn4w1jPJOXwShz6FARXKY1gE+
         ETgEdhVJ5LrAoJvBVebQC4uBQwCDXggMj82ARQ7OAPN7S/0aJkqxJNy0cwRnYVSrlmjz
         6Aq1zSJiMEbbdbRBPGum2XPfse0Ie93zsUZ+84uIPI+pHjOtcmRHkpBGSDP3D9jmTBGT
         p1LeF5/sCVWMf0F3pG876y/QPSsDlH24n7hCuT9kuDcg8CjqOpPNQAknDidxb5O7NGxm
         pETA==
X-Gm-Message-State: AOJu0YyEvCOzmQTmdcLnJIQ5PwEZNWLohqnFGM7HfZkPfoBauH/IDipN
	O7uK9ZYNm6/XNpMIOd7OSM5qdGXuYVVQ4YuL0Wm5m3/BVMgtcdUrEdQfeA==
X-Google-Smtp-Source: AGHT+IGIdtwv/vXykderbUoiI4JE3o71HzPIKOUpveLh/c9zNSbHQmkhL73+lpdpLCKudyzssV/iwg==
X-Received: by 2002:a2e:80a:0:b0:2f7:7ea4:2a1e with SMTP id 38308e7fff4ca-2fb327b5608mr8633331fa.28.1728643749852;
        Fri, 11 Oct 2024 03:49:09 -0700 (PDT)
Received: from ?IPV6:2a02:3100:afd7:9a00:c812:cea1:cecd:d47e? (dynamic-2a02-3100-afd7-9a00-c812-cea1-cecd-d47e.310.pool.telefonica.de. [2a02:3100:afd7:9a00:c812:cea1:cecd:d47e])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c9370d2251sm1810529a12.12.2024.10.11.03.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 03:49:08 -0700 (PDT)
Message-ID: <595efd8b-e0fe-4a87-90b1-4b579f3cc876@gmail.com>
Date: Fri, 11 Oct 2024 12:49:09 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
 Kiran K <kiran.k@intel.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Connection issue since 81b3e33bb054 ("Bluetooth: btusb: Don't fail
 external suspend requests")
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since linux-next from Oct 4th my bt speaker fails to connect if I switch it on.
It just hangs trying. Manually connecting it via bluetoothctl works though.
With this patch reverted it auto-connects again.
If you need additional details, please let me know.
