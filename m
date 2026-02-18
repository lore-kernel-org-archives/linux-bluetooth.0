Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095933D51F
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408049; cv=none; b=acVbrSltgAfPaEg4t0Qb1Yoz5G7o19jsWARZB/ddZ63d40wpvVoyfxstepo5hVFts2a+sWKNdriy4hO/DS/0cWRAV3/3EB284AfjzlfeMRwNMb3R5z2d8PrdQseygkY+bUT2I8DTXU8zRMCvreWb3PXtzwqAh1tj/E/IdpBHqCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408049; c=relaxed/simple;
	bh=faw2v2FJafMaNoX/gJTsfw9myt4oynm+VW6XsQBFnV0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kpk52WQpU05pF3GCyr1TAAUMizdp4fkCxqyUYsIXkdzoUkF0OdsxDw81ioaM1/nLdOibEZKtKahGd2WeF/NXLDs/r9JFnN74MPr6TGC7HUAKu6BWBTo/RGMaLNMtyJ1ozIpZ0wlej8J+kl8jAczgZp05npBJeXQ47Eq9z+eW4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVysZZmz; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVysZZmz"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-124afd03fd1so7718914c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 01:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771408047; x=1772012847; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xzoJ+ibn+44EHj5bJJXVZr5m+aZByaoieJdjy3MYmbE=;
        b=MVysZZmz6TlV/t/yGkCIOIBPPXXkXRi9fl7Q0Fa2M+w/xcZYlgOne8+Gk3hrHjOPoc
         GdSTaelr74gfL7Zrx1O5Vh7akvXAo2XpPt9VVCtprVWmJgpHfnDsw7cElMCNXIJg9oHU
         pNvzzM9akWVuM5lxPGlCWKm4CSE15Eht3ESsZQKp3adHU0WJUy3/TLb1m2idLEG8d2Q0
         fOCLrKHA7ipaI0czbfLp25VGOapjf7jXVJwlY/uU1sjGVvZkyeG8EFQXIrySFW0b0IyD
         5D4ZVKaemWgAFT2h/WTHB3NCbv3d0ghRNOdEgThivOyywxFTXh9WqXovgQrXTSmdEi2x
         kqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771408047; x=1772012847;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzoJ+ibn+44EHj5bJJXVZr5m+aZByaoieJdjy3MYmbE=;
        b=JMG5KGKKzcbt3/f8qfLMwoPG+uTcIxxpe6giqxi9ixJP8Q5rA5qZYv64T9sUQYScFs
         zlsUhWMG8NRkxk+PFMZwcSKdwI2aFWsufPFVl8tASBDOpAOHq/W8RNspoqY7a35xLMWd
         VQKbkJu3ZAV9F6pKJBw8vCUo5dD15JQHOzPe4x/pE6Bs16gNqxzl4trH1++qK9S8Kkhu
         h+jaBEyywhbi37ufykhBl9H3CgrYsJ3YxLllkYDYkV3KY7rBqHv8W9pbOiWxUtpA5NgP
         fP99cP1Eo3kyLmvMeopIy3T6XzQNcK6fPcsMl9Dqhhw1DXvI2vuE+MaFxATkgOucx1Oi
         OwKA==
X-Gm-Message-State: AOJu0Yw4DvFu1+rnSV2RB2ypvq/cY/MrQ/27XpUWy/n312F8pmAM1vTm
	njGzNhFDJHAWUjpjkNK/vr3PFuutTt27ydgaO6cYUPn4L+FNqAHqq8lANIBGtboL
X-Gm-Gg: AZuq6aIzImgn4euAi3c1V26uaa3v8D9VT+kuN8z/KY2RoCJwc3MnRQVmrnEvw6kHxbc
	QV5ccyFbWhygoISXTrbc26cuzgNZtWyucVSGMJqEr9rWxK/JLm6Mnx81D52p9pP8+1tNsuNcnpM
	L5cnneyVV5yxeCc6f1ZhMYixwRZOQzIRw0w3HefWXejXX8OCqN0m18eZtKIzEOcUydqjO1DY7MO
	h6MztKPcqDPSkYUtHDUWi9jFaGupWS6nbVn0ooI4TtM3Gp54imXU2S/earIzHXtCuhvnxs8z8XC
	duhHmfSl3bRQ00mYNzmS14EcUv7Jl7qdttPHVmYlQunzpRNTuXH5kvzo/Lslb/O93QiJl1mV8iL
	lv8Qzg3f2y4/xiva7W1TEvfCsS4q4iZ5DJo5tEJWojHEQSgqZu59kJk/Ntw+MhF7Leq7c1rw4dy
	zuoQi3gNG53serA5QKowOvovEv+9cc0g==
X-Received: by 2002:a05:7022:914:b0:11b:c1fb:89a with SMTP id a92af1059eb24-12741bb7981mr6623393c88.32.1771408046771;
        Wed, 18 Feb 2026 01:47:26 -0800 (PST)
Received: from [172.17.0.2] ([52.159.229.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cbc900sm21347989c88.14.2026.02.18.01.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:47:26 -0800 (PST)
Message-ID: <69958aae.050a0220.25ed7c.ac04@mx.google.com>
Date: Wed, 18 Feb 2026 01:47:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5840996539084319496=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v3] client/btpclient: Add GATT support to get Device name
In-Reply-To: <20260218085206.498756-1-frederic.danis@collabora.com>
References: <20260218085206.498756-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5840996539084319496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1055133

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      20.76 seconds
BluezMake                     PASS      648.63 seconds
MakeCheck                     PASS      18.57 seconds
MakeDistcheck                 PASS      246.29 seconds
CheckValgrind                 PASS      299.91 seconds
CheckSmatch                   PASS      361.77 seconds
bluezmakeextell               PASS      184.36 seconds
IncrementalBuild              PENDING   0.44 seconds
ScanBuild                     PASS      1033.91 seconds

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


--===============5840996539084319496==--
