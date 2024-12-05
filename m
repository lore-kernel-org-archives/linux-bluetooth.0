Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672A921C165
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409576; cv=none; b=P9BLQmL/X/SZoRPH7lHFESL8GH3yCHEz2KxuWYD5kWf1MPs0o+mSwN0ibPiX5f5Z7brIn/7ManB8O2eZarEJ1jIKccrrV/ulMYKXWXFUq7CmWwRzKJ2aNx2EanzgUZda6JeUhdEs9PzzKW8W8YuBrM77w+WkEy9q0zLKL35w8JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409576; c=relaxed/simple;
	bh=gr5Qx5URHM2d8vP3SS1HO/xKRAAUiYGEUc8d2S3QPA0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XIf3lZXt5sGGvEqi9fDd3R8MQRJJHvInFzpGdz+By2urYVxxjk50bFYXKr3kurAJxOTR5kSGbTirIR2TKZD82p2LV/vqMzJ6FpEDDAhDA6KS0V1Z15B20N5Q58GbKnipu2x5NWvx5JZyWy1lk+ds4hrHB41mKIKRfBbnxW1jF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpTDHwLw; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpTDHwLw"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d889a1f7a6so9588036d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Dec 2024 06:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733409573; x=1734014373; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p76sSHX641rfM7HMXnuabOwdOMIj8SYRWqAZvMuYrSw=;
        b=bpTDHwLwZ7Y4PW8sPzmKg+jSeBuQNJzOOUK5tNxwfYOP5vUMGDTKtDJy5uKZCmoMy9
         z5aY2rgs/h2A0eUdane8VNMoqLvlBh17Zpx89x7S0ZlZbiY5gZzEQfaPTfI+a35LVhjL
         dtuTY95StUW3qppXADS8kgRLZPKwlTqm4zJdf0lkamwRUhEJzNfX/SUHk8lXawWznu8X
         9GowVaCeMKtU4EmWM9DK9gEwhQfsK8S6YfsIeVs0GpjY0iFNnCwgOAOZPyPKkist9x+b
         mpu//DbWPQ+6achIry91T+tpySFBCnVdgXfPVBBbvdsum9kUdI3ktKiro7221gdSxzNJ
         pYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733409573; x=1734014373;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p76sSHX641rfM7HMXnuabOwdOMIj8SYRWqAZvMuYrSw=;
        b=jxVv5Vdb8OejmZPPfhpDkxPkOBrm1Obr4bmRvayGg3MuoxDG9jUYz1Hf7GzmNWjI5X
         awRuSfnrazO+inmbDx8VRK8eRURHpCVeptIly3vKRG66Cd6F0rzuKhZ3JM6G1l3LdkpG
         G+hYto69bc793xTGnqzE6BjVNyMfoO593wGL8hsyEVzYUp4nPYTAcKyf6aQHa/fIVqY/
         YBFOm9VJW7rMPcttU5n/O14mZFctkXvfT9JaJeGCegIgId410R0vw7peZmm+KzPkXigS
         208fB25qkJNte88Dkcath50YjDCJ040/TyXZTHb5QuD+a7SYRTz0+07Y0WH1eQNdL+aI
         L/7g==
X-Gm-Message-State: AOJu0YwtWcsmtjWwLz7Qwau2Bs9+3wOHLuI8vK/x0HwkPrHMk3LS+kdi
	L+3AfUuG9bzCS+g10TdDaqmhwZWKlVInxGvYLZYqO+QXsY3qaVDDOLx9IQ==
X-Gm-Gg: ASbGncvFageQIGY/y1BxacE5kGSW/eXAyyjPJVSj7rtPSoc+1VDeVXuxFmqVgviGKY1
	2vk2AYiuhsd2p8/5YZlEG3Jfh5PzOn3WRHeXnjQJqDBH9BHzBGXZgU+GvVvWqiTSKV9lVc5KgCR
	/pB5Va2zpQwUacVpdBw3ZZ5VM+p71kb0bL+Rd/R4hIBy8xG695fSMWcIO2TDvCbSRHCoBbX2XcX
	l2IGJ/yXg8YFcNS+ESyO6WBUysWAia8ycAwwskSqavmQA0tNwtvfak=
X-Google-Smtp-Source: AGHT+IGO/WVBB40AIfJeaqSCsCn6SFo8iVQaW3N5eNmZgvrzOMVhv362OCJMAVtHv2lm31V+9I48gA==
X-Received: by 2002:a0c:c582:0:b0:6d8:a3f2:4be with SMTP id 6a1803df08f44-6d8b736ed63mr127086956d6.20.1733409573006;
        Thu, 05 Dec 2024 06:39:33 -0800 (PST)
Received: from [172.17.0.2] ([20.161.78.10])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da66da32sm7096706d6.2.2024.12.05.06.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 06:39:32 -0800 (PST)
Message-ID: <6751bb24.0c0a0220.ed189.277d@mx.google.com>
Date: Thu, 05 Dec 2024 06:39:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3068031096381442839=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, fiona.klute@gmx.de
Subject: RE: [BlueZ] Leave config files writable for owner
In-Reply-To: <20241205133233.1738092-1-fiona.klute@gmx.de>
References: <20241205133233.1738092-1-fiona.klute@gmx.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3068031096381442839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=914938

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      20.36 seconds
BluezMake                     PASS      1575.41 seconds
MakeCheck                     PASS      13.16 seconds
MakeDistcheck                 PASS      157.64 seconds
CheckValgrind                 PASS      212.99 seconds
CheckSmatch                   PASS      270.97 seconds
bluezmakeextell               PASS      98.39 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      835.62 seconds

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


--===============3068031096381442839==--
