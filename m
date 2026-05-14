Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D777F347BA9
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778782915; cv=none; b=NGu/2Rglrepkdd41PHj1NBTqnlOgduMVVFKKqvOSyqwInkMzn1q6+f/TdkkBliXWu/O3UgEObCl6NZhAeCWJ2zrDH6PU/XjdRFfkvhl9SfhugZSQXrRv5NNOMde2npXZ/W55wtutJgL8k90rFGEqY2UHByLgP8ljbtFAdqx2OSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778782915; c=relaxed/simple;
	bh=NGtfuIyBOHQ05iVkh8k7G8w8cO3exgAXDBFvgkcU6+Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Fp8mFojOYX/iurqqNRFEIA2Y7sPOtYem7ZFMwrjKVrVMGjYAog1PQ/ocC73Ck6y7FhVW26h8lZLCguiSukPtsMCJuHVrqINH0H2rRQpjPY5hnPnNzAvhc9EsNF3P6HJETs1RXlZWiSLQ0Lh2YTxBHDTsB16IhSsh7yJ3SkbzNjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mONy/U+l; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mONy/U+l"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8c92737a8d3so7387236d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 11:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778782913; x=1779387713; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NGtfuIyBOHQ05iVkh8k7G8w8cO3exgAXDBFvgkcU6+Q=;
        b=mONy/U+lXtQQ0Buxl/awlPpevgtGDJUwHuZgfYK3Hc8qKepWNdOvhUHEc+/EkdQ5tT
         tO8T0TbCqEWIUhQVJ9LJWDfjGAriLZ794Vz5vyCHgsAbGTzCUvRNZkGJWW6s1jJBA4JJ
         EV/BsnZL5qc+pNVc9yB7LykwdvjbKhYyBzAX2SAW9eP/d4famFfpKLsQBgqmBMf03jbe
         vG0JlY4gyinJ/1zTFc97new0PXcYPSB7KPZPENdIt7hcq3S+1+xiSEAoVDHUAwoVB4Er
         k++5AwKTP+QDSOUKtEEyievrPP/AJfd9nDMI4EyWR5AV3nncfEcICfeL3+zZc0Fo+vsK
         82tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778782913; x=1779387713;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGtfuIyBOHQ05iVkh8k7G8w8cO3exgAXDBFvgkcU6+Q=;
        b=sp3rfZRmQHArfXz6T7DKiZlNpZfbMYd/ljuMJAigzOyV/mBzQhD9qvYyLsyerIUfbt
         OWaayZPnUh4wYx/bkQAqpe/a5XlmFKmSaIDtPxQmUPJSBYdErPu92qWQy4fzcHKcpwKd
         vl7M6Lwt3w3KfmYx+k6pEu5d5RfN0oaTTD5aXmeao1W8b7sud5zorEAc9cEoRAKX3CMx
         AiimrPcK/gES661n9i1XUvR+OtMcOqc4K2/ijG73osABF6S/PTHOWJDHuIQEszJvhG9R
         73Q06UUG0u4nHo9Fs+byMPH/2ll04IvX1dXoBM10Dheg4htW26NYuTY1xvORt4wPOE7U
         gOmQ==
X-Gm-Message-State: AOJu0YwgtOFaBDMSEqGs2xAu4yoK8cJbngPclVyKlzTFOT44YSx7S8/p
	+5olgH29AyIx8cnng+a+CrzbPKV/ENYzGBlrpM50UruhbVuuODOFxDOTvAGoug==
X-Gm-Gg: Acq92OFyHxHNkj8Ftb2tw/DqTdjMKYJfCrywpjd6p0X0a3ZnWN7fgKQdeMHTM2flTbm
	RORh7+Ecc8TCWHaMMtTdm5bVK+1JnLtbUfH2PqSLFKVxq/ze6If9mFTJ42ofxgzxjFDukdGx6rF
	Xgv3GgsPsq7aDE8MTQ/9z/wr6wNlyAcLQJB20meyCMR5sNoEkV8FAkXZ6bPFO1GRmOYNp+zX8yC
	J3zTL1jkXxDaGdB3in2PnlyppzsSNyFPoku6aC7HgxfcGIOelOaAr/xMGwaBsr/n0XfBNEh3xGW
	YMpiOOQlYaLrwPzP3qmycR5AGl7Z91E8TxAHcY+ZlXu8BZeKv9Mfx13kebk9YSZmkHSAcjoC/Wl
	n41cvBuVUBpSm1zYGeov13ME8co70tNPTnUmomNIM4xdrmZlCVa3DkQX677MnxkBT8ZNKQqtogH
	6p3OxKqtllGzi7klsQQrhVrg6LIFjh
X-Received: by 2002:a05:6214:3c98:b0:8ac:7d2f:c7e0 with SMTP id 6a1803df08f44-8ca0f657973mr14282526d6.23.1778782912827;
        Thu, 14 May 2026 11:21:52 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.123.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90b3d0bdbsm28932046d6.24.2026.05.14.11.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:21:52 -0700 (PDT)
Message-ID: <6a0612c0.143d05a0.1cc117.72f3@mx.google.com>
Date: Thu, 14 May 2026 11:21:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4309052093116078783=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shivamkalra98@zohomail.in
Subject: RE: Bluetooth: btmtk: Fix FUNC_CTRL parsing for devices with zero-length payloads
In-Reply-To: <20260514-bluetooh-fix-mt7922-v1-1-499c878af1e5@zohomail.in>
References: <20260514-bluetooh-fix-mt7922-v1-1-499c878af1e5@zohomail.in>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4309052093116078783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btmtk.c:717
error: drivers/bluetooth/btmtk.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4309052093116078783==--
