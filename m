Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B2213245
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751922812; cv=none; b=VYgjxyYxrmZgTgbrDAaG09jT4YDHTD1RnjsC9uTKRke8z2c4BbOXuieY7LNK06dUQcDLSvuINS1vZdCzZvSwTst2daZzy4czEUZorsVZlhQu3jp26SKgV12sIHPjpcabV2WZl39eEygqQI61VXWNe95l+hOZnjT5rP0II/k+A4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751922812; c=relaxed/simple;
	bh=ibyZY4TGh0Pz7rBLewmwVvmAauPcnDH99jeeRWyGdWA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PpCblI0iEP1KKjzEXDpKMZVEsjBcQHy8DXPbaBm8KSH+aV205esj+UEg1efTXgHY5VEKLSoLIYLG/xTD1wtJ02MfjmPCj631gDfZRtqyfToZGRe37vPDBfC2A7swI1DyXh0ErEW+yggHXrm9TZVrZpsnkvQzcGFiJ51/n9RzdY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TD8G8/yA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD8G8/yA"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-749248d06faso2964456b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 14:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751922810; x=1752527610; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ng5onmsRj8BmJ0Z/UgZcKzFKtiATPo/GwzFPLezinzc=;
        b=TD8G8/yAOZATAXABGYtEkKeJvu/95zs6rtBQwVp0uL/Ga0fFaDDJTRWSkU8hZjyr9m
         yNRPMa3r1L1zzwlyf+zogyR3+pzoxH0u6U1uQZbr2Ml1jgi8SoUVcYASU19uajTrW+Ka
         782NmLYiR7nDgn2i5xz8YLOf1kfB/cE44uI8+7MkLKBsnXKsCyxypBIvdFlt4wZ8a7Bh
         4dNKiHikHjJqnjfFRP6gSLrrPnLuImza2vKOcDNn1ecrWn7saoZwy2IrLxyIGkR/CAoF
         lIBUaqftqgD9busoKIRKv9xqeB+r/i4nbiFZm+RJLLrulNH8VPXIQd0vDyFMz7GqYCdM
         zAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751922810; x=1752527610;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ng5onmsRj8BmJ0Z/UgZcKzFKtiATPo/GwzFPLezinzc=;
        b=PkPMR4zfkH3/a4U6ekR/rG+sIOAr7daGYHlthLE0dUzVW11o2N328Xef4Tq1DoNkv7
         QwyWYg6+Bkc1xhIIL5hYB3Y9MfuoLY5xsdYVBWGNGSCI0wQ24KaFd6UVJJtw6euvYSqP
         wuP6TPxVyG9Nt36ZAwDFBwEo1gGVS+5O7wehmWLONVyAIoVXcNQJBSlcfnvJO9xe12w9
         KnMYijykoXVJrsoAG4x4ZhXhjdYDdSRvUqK1QJaoUHELR12UYoivy0kGRFEYymuqwU0N
         4wsGZVOP58BJUtuDP5u2kbw2wdP1FzalePMzW8BeKI4CVnBtxCRuarUX7gywBZoOakR2
         fQRQ==
X-Gm-Message-State: AOJu0Ywei5B7+JceZ7BgSh178b4aSS3buqWaOQ7TsX/0lmxehp8x5esN
	81X2jQ6mtsK4v6PrF7HndaEbTU2hl4wVenKlUtMelWrXI+ISXqbjq0eH925Aog==
X-Gm-Gg: ASbGncsz17pAwapsOCDHDwY9riUZMQphxto+eYFxq627swzyrYMdDkf/nm+YzrDBDbN
	BIt/3xLFy1qpf+GhHfjFe0U6XFlMrzww5lw3E02Wqva+UBiNXAg2hkrYCfFsN1FGb2J499R/mJz
	6jFlqg3+Xu+Ocmg8e7xd9f5aMznqtkgHvkUIACuC5rSZYl57kk4bc/ioDQE+Fe7H7H+t6q8n8f/
	qsiuWTymALvDP90o7kvUJ/Kqj8ccKO+hn/mHLDeMm2F4qtR2zVWxns1sTJNmDV5xixxmr1dDQh5
	8kMS8/zdbBm756Vx4eDq/nIQMJGISnq+aOau1pfeEiDeLD1aw/kfN+ZnKG37NhX8Zr4vPlxEBi7
	Yvy8=
X-Google-Smtp-Source: AGHT+IEaArbcko9wVlX8h7kz3c3N5uxp006TaUF2qqyIZWPnqyOYcLk56kO/aiGFFPfnUxBiGQ/Xqg==
X-Received: by 2002:a05:6a20:72a9:b0:220:25c4:1881 with SMTP id adf61e73a8af0-22b44594a0fmr978056637.39.1751922810072;
        Mon, 07 Jul 2025 14:13:30 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.246.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417e842sm10274745b3a.79.2025.07.07.14.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 14:13:29 -0700 (PDT)
Message-ID: <686c3879.050a0220.49f6c.b58a@mx.google.com>
Date: Mon, 07 Jul 2025 14:13:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7780158444935033779=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] doc: Add org.bluez.Device.LE and org.bluez.Device.BREDR
In-Reply-To: <20250707195324.2615368-1-luiz.dentz@gmail.com>
References: <20250707195324.2615368-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7780158444935033779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979806

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.09 seconds
BluezMake                     PASS      2622.21 seconds
MakeCheck                     PASS      20.57 seconds
MakeDistcheck                 PASS      182.93 seconds
CheckValgrind                 PASS      233.59 seconds
CheckSmatch                   PASS      302.65 seconds
bluezmakeextell               PASS      126.84 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      906.52 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7780158444935033779==--
