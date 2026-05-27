Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE456282F0C
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 05:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779859094; cv=none; b=pMM7DkPOQWK/vUy3ZImC5WjEEHZ882GX/bpQI6knpu+/hROOhDenLLB17X4Tnboui7igGGmiUvbNPqD4x69ORZZ/ZEtuLEbjWZc48oFZQr2nrNOThmQY2qYLUhWSIp9O7gR2tQe+5c04ZO3b2zExO6Ny0WVp5sfb8T7pQTc+nGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779859094; c=relaxed/simple;
	bh=a4AHPcspWRXRpwIp/1kvg29HkxGqT3z5y8I2grHxK5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iioMtwkbBJ8QwkR6hWmc3FVxG8Hn+Dr4WVi/+TwGovCcwb/ChECH41Cl0PmVjtl+0Rkmi6RsB8QmYaPhheEjVUkqvWADS4EmH40mVtzk2fRnydtkMJ7Y41siycIMfgcG4dQIQjlqT1rWrMTA/yCBy24bAPH/xmNjwpbvesf/nY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URESoi6s; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URESoi6s"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82faf871346so8557513b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 22:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779859093; x=1780463893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4AHPcspWRXRpwIp/1kvg29HkxGqT3z5y8I2grHxK5E=;
        b=URESoi6svm1eDHgWYxDCmmKfDRG6UmsOWndVbRB/pva0Lls8QzZaj9F1KPSfeiiaDz
         pRz8RPwTEWuNE4UQZnDfAtvZ72Xh0xTcOo62qc26Q5GpVJFOakoLWYROWB+efeyDluQt
         aR6SpxEt8gqxZveLtsaWHSl7bjI12lwRJXUzvC6h0SI6O8f5mkEjt+63O681YgmaDXvT
         i8PxJIZ88BQ+O5yBZKW/qsI7EwnIXlQmMSlZkPP9HBaK1OD5y8MPWoAdsWarzVcx0qjX
         LWYDuUjhWCQnSZK0F1UHvGwIOlFj84E48QDKDw6p4ISzHJVUxvkQ3j6aqLwkTO08Ilri
         aUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779859093; x=1780463893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a4AHPcspWRXRpwIp/1kvg29HkxGqT3z5y8I2grHxK5E=;
        b=rrziiBenpHKB0odiX+maDjxgkrTsExnTZi8jjUsxYBeMEsOuZYsIVLiVFIKnh0QyUJ
         lJBF1hUFREzL3hB519jOfYwxJxODwHFj99+v7ruENqnotJjX1xA3QXCNUO3OPynJu8g3
         fgb0h7kQrAsC4Nb9nsTe5xIl7ES7+vEMezA1Gc16Jov60eY2tQCrtE1tNBMWTTPROo94
         3a/pRVEr5X1Ut2rV8Pn22CU5mhrcwNRkHQIoYVIb7qNvw5JLHmXt7q+8IfOLTN/JbbRf
         kui38Ak+oPdb6sSHTUkXDJqXnB+ys0H5OOcfJw+adxx8roJewfENedCesSO3G94Wf35a
         VRhw==
X-Gm-Message-State: AOJu0Yxt9UisWD6IJCMlxsKNP8nuCUAolir859iRYJSEFx7XmeMxSiSp
	M4otduXWqIjyadf94BNBxU5/jDhGTuWnw3a6vroCTZ9mebE/rAUBSCLY
X-Gm-Gg: Acq92OFrZXecBwNW/0FN1zDz/Uq7zJvXm4+K9EIaoRK2HyiAdFioCit9kbpHHqsJc93
	L+xGQq/8+cyAizGx+/EiLzS10NG72XaagCehAMmITHcVFSvNjA20FI9w5WvdjTwMNZDEXTwpram
	7NueW/Du6B94NxS58NKMyVVIHlVCJmpuCloebOOqkdQRqOqWSRkcqqDnms3vJobr4LayH/rcnCF
	t+l5ovEaVKkfVBS/ZgQvelzRqzE1NHs38ETwCvjTlkQUtyQuDx6zzey3P1xubmi/O7vnrR7rD+l
	cmZey4jLuSBOsni7JYlGBs9lT20As8A4wDzfQMxpY+rxnF2Yd1RHef+fYmrTaC63WZfAx3TZCHs
	FndKc7xNsCaozqPTdyEAkXr4OPzBOz3RtGjCoe6Z6IA+Fhn1FDGKgCpv3QT/t5FJeKxMQ3xKUPc
	Hi6cmQ0E/tDmbZjld/A6XqPqwAet3NGJU15tM4I5mI266AgE6i1XhxadcSf5nFHmk2FxvRFKl3C
	i7GolEQwEYtNX/31SfWtO4b13AfDM3kM5sB32oIrgk8b3AWrNdwtaUgGTBwO6FheuVtbBMZkPlR
	m1h9wC5Y8qMht+A=
X-Received: by 2002:a05:6a00:2d25:b0:82f:5051:f024 with SMTP id d2e1a72fcca58-8415f5dcc6fmr19865612b3a.27.1779859092898;
        Tue, 26 May 2026 22:18:12 -0700 (PDT)
Received: from codespaces-78f0a7.2t4prynt4dlezbzls5ze3dxsqg.rx.internal.cloudapp.net ([4.240.18.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6eb031fsm1146897b3a.16.2026.05.26.22.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 22:18:12 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: pmenzel@molgen.mpg.de
Cc: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Bluetooth: L2CAP: fix heap over-read in l2cap_get_conf_opt
Date: Wed, 27 May 2026 05:18:07 +0000
Message-ID: <20260527051808.47220-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <51761fe5-2244-457b-bf60-060e43f0cbd1@molgen.mpg.de>
References: <51761fe5-2244-457b-bf60-060e43f0cbd1@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review.

> By any chance, do you have a reproducer?

No standalone reproducer is available. The issue can be triggered by
a malformed L2CAP configuration request where opt->len exceeds the
remaining buffer, i.e. a crafted packet from a remote peer.

> I always wonder, if Linux should log a debug message or even warning.

Existing callers generally handle malformed configuration options by
silently aborting parsing, so I followed the same pattern. Adding a
BT_ERR() on -EINVAL could be reasonable; I can include that in a v2
if preferred.

Regards,
Muhammad Bilal
