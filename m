Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1106117CA17
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536645; cv=none; b=KS1vwHV0CBf+J8V/Hf/EbFwqc7snxECuCndQFBn8lldZD9L22iiNLBw+hPNhi3lUgwFOjFYOsqG25Pfi1Iu3XfFk2R2cDVzPn/7bkAgoVKmy5GDDCngV1G3mkT2VOCozRHgRnMkufJ7BHBHPntP2an/i5wN9HnIgPcu6j4DfzFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536645; c=relaxed/simple;
	bh=36XtsfB/Y/+r/p4PcJpXDCd1enWQ5otOmMPW+JGUpDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1FD3z8KI6zVO+1ckTpoeS5nwaLb7AXz0Y2s973i4R3OEobd/cNbOoKVD0IN0vMlPeCyPO5DTX7c/oIgxTfAZs+8bMS7Rafx39zRtXkVXUykAE8Ela32mN/Te8KbsMA1orD+Rj23t/4LbbmRQuvIFbtQ7c/UIpfkL50Wgcu3xSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=PuC9zSuv; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="PuC9zSuv"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73044329768so822261a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1748536643; x=1749141443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJbHX8UWtBwYvowVAn6Pcv/J1e4Yt0eXJegAoG1XhWA=;
        b=PuC9zSuv8gBLVg5UWkbiVhbOpUD6rMAttLSsopnGAxGGAMkIhGNFBhlz8Nav9iFY36
         TNY0FEO4KcQGdWofGyTHJIMPQcGbOZaK0pVwg9m5rgTPzm4EizY0bTaJ1DUCHTizLbPI
         xulEfZtZQ2vfYOMV0M00bw0mEB2oXFVuncmphL5+mJ0+E+IQboxk8JHDhI3TYpFUlRSI
         j/HYd2K43KzeB6XSDK3j6rWFH7wiL4I3PI8aH0l1YkpvsUkt0FgtstCi8G65ApML21XV
         6ggMqf27Mg9bax3Ff0SVLSekEkPIHnZ+nHJK6Ys6eG3mA53DD2HaXM4m+12DItNSz1u+
         pieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748536643; x=1749141443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJbHX8UWtBwYvowVAn6Pcv/J1e4Yt0eXJegAoG1XhWA=;
        b=jdH8fuHT6r3pSDkFTczjLxU94t139mIqLCu7RWdUDd25hPTTjR7yzleYTa7LQ8KqVi
         pbZGgfALKsT9eraZng/zW6ESevpOd4IclB3JAq0j2UPamIMS0iwN32jCiaFPTKg4bxYK
         7SEV4Hbp+r585XKe//7D9FiPj1ofRaxXY8ER+bRKRow3e/ZAnPcwi8eH6j4aR//10tJD
         piwmya9gEk0odlatpuvdS3wqgdISQ0BwUg2hPtE8Tyi7Fgk7TRB4Px7iITToBKUMvLeL
         aziS8/KLruFQCnHUJqogMyHoNNHEuHvVL4XT/WDmAAQPvax0rCUYUFg1uBbaon2pCAzO
         mmsg==
X-Gm-Message-State: AOJu0Yy0L//l8Ld6fq1Ba6SD+UCmDZFcYRrmiEoLPoYKc5rY10ASg+Js
	3kdE+8fSQhVM0IjOLaX2qPmVDxE7izWbgy+hIv9sMAZ8flCCLEAMJqCFwyCU+I69a4816SqCUq0
	l2935OIg=
X-Gm-Gg: ASbGncsOuJAIeKctR6K+D4qwNitJdA6qrs5BbIaizuna+kF1JeXYC4P62r0oghUMHql
	ltljnqC1mqwcLCzMbryggybTSI1d3PHxO7R9rF4ZnGvAXC6kQobww9eYQK0C3nS3YNl2wHhaBis
	q+6hO2QBYclASbLMW90h5/fNRgiC0JxD8FO7aMz86DWgLMBRP8Tfj9Or0rrRWbtcm5B0EL1uiva
	RSXarFctgKeutRs6Z0C9X1394BbYIQRH9IGc3t9nzy6nsUbu9A+1UdhBzvusdclNn/QwXw23z37
	nn1MdjrB6J/TGfMi5qjZZ+cSyfvLbQ1O/3KsnNBsChAD6rhv3T+NDzUp6dY2PCe0UMQNeFFgbHb
	el1ssC9NrEYXXIyzhbO8=
X-Google-Smtp-Source: AGHT+IGi9zW66xHGV0ooQgA4CE2RM/TMhTeayWKMwz8Z/b5BCfRRoPEIHimSNVfOYav1Uk6Qofw95Q==
X-Received: by 2002:a05:6830:6589:b0:72b:940a:a7c9 with SMTP id 46e09a7af769-73670a605c7mr15249a34.27.1748536632389;
        Thu, 29 May 2025 09:37:12 -0700 (PDT)
Received: from localhost (104-48-214-220.lightspeed.snantx.sbcglobal.net. [104.48.214.220])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-735af85614csm291924a34.26.2025.05.29.09.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 09:37:11 -0700 (PDT)
From: Steev Klimaszewski <steev@kali.org>
To: quic_chejiang@quicinc.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org
Subject: Re: [v2] Bluetooth: hci_qca: Drop unused event during BT on
Date: Thu, 29 May 2025 11:37:11 -0500
Message-ID: <20250529163711.475128-1-steev@kali.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20240821105027.425783-1-quic_chejiang@quicinc.com>
References: <20240821105027.425783-1-quic_chejiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have been looking into a long standing issue on the Thinkpad X13s, which has a
WCN6855 where every so often would get the following error in dmesg output:

Bluetooth: hci0: unexpected event for opcode 0xfc48

I don't get the message super often, 11 times since 16 April, though I do not
know how many reboots happened in that time.

I noticed you wrote this patch 9 months ago, and I've applied it locally and in
my testing, with it applied, I cannot get the unexpected event anymore.  Looking
in patchwork, it says this patch was superseded, but I can't find what its
replacement is.

Does anyone know if this patch just fell through the cracks?

-- steev

Resending due to the previous reply having an empty subject, I am not sure how
that happened as the subject seemed to move into the body of the email.  Sorry
for the noise!
