Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE033C1F57
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374770; cv=none; b=al+DkFCBmeLA2EGrizjUhtiQe0e5eps5fVzjcLhXE+BKVWxAcy6DZEmy/BlIz8MZOlRd3p+TEkSHUgCh57j4BumAr/yK7cDOgqledb11UPdcSb3el0vfQL55ktdCIQaBAuqHSCZLEbP/n5RwcHu3Olgwrk9N6a+th1FDHKLFlPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374770; c=relaxed/simple;
	bh=IzSqZEDBwEYaIiDXRjArJyd5xXr+DsVlp+zakRNHYkI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=d+VaMyihHkuF+ZisHDc7J1UmuDLvt9M0NJCoHRtcApiDFJ6+mV39YJsjL3bwDKC+Bxph/C/ljASJNKmfk4gJCZA8MeEGbPJhBBUU+xWUHoUO0CCd2hoaOoidF06eqdPSwDRSZDKg33p1P4qsAhqjp26z7tMJRfk7Sq0lV8Rdfjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0ECZOZl; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0ECZOZl"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-82374c2d7aeso1753838a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 05:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791374759; x=1791979559; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0hbYQvIP83Rnc11s2bE7eENVsd6xhOO1prAm2RjNCY4=;
        b=E0ECZOZlE6+1bb4ir9BxxgI5zXYggK6eOgp9KfOMV8ALQpzhP6wZ3+FHjBJU6LVqMm
         FJ5qxhYGZTUUmwH6kJcZMhWomZGXm1fZMAf1S03zAok9hmewudToWaQWy3g4ulauuSM1
         ShypiGcFAqan01+VmZ657BVX5GxnMUZATqyM7dZMzjNzAJEwXflOFN32Bp8WQ0qNx9lK
         w16bsuY2tzPzt0HLxbHOQcO562esdFdfHMF5TwmN8oGm5DQIPaxjrEQSYZ1KCI6i38YO
         b6hfC7SF/v9nSyigSlaN+DWVBsPk++EInJ3Y+zs6BFqocGkk6jQwGhrIjWnUj6rECorI
         et1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791374759; x=1791979559;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0hbYQvIP83Rnc11s2bE7eENVsd6xhOO1prAm2RjNCY4=;
        b=LiEbd7/lE4wY9aVw6Vrro7umKXA2nca1ZfEIr4lVLgL9SW1Pca9i4tHd+WXrSgUZmd
         YfwcerV5Dlc5XZ4SYeBlgkXPXOYcBWbTVd80n+rJpljmzfhs+AFaS6cCqNw/pYq2GUKj
         SBqSjMWroTssm2wN9mBgCQKuxnybdabp675jGPb7TDMu/IhPSI0T2XoBRkt0hr4N0IiU
         sYX0ZwTUsyOJj/0E9QxZkJwOzHaWTveEGAhQW+nBXcoQukqJUYmDaDmpwAKG21A9gWjK
         9syF7sNaU5Irk0unU0JxYKaB/kQxPOEohlQ4xxQNgDVnO2V0u+bgvefoAcHuv8CU17ph
         b15g==
X-Gm-Message-State: AFuF++kgvNVin70kEO6J/NJSE5yrhJcO99U4SEV69ehAAkLbTrcZybfM
	QuY+c4XRtlVBqP6WMUqinlp8+rCTyZLDOh1PUWWRqFQtRYKUBAs6scPElROnZfUV
X-Gm-Gg: AYBFou0d+8GfvE2LDGslLMnyErfarxbGfHbRi/NN+ckBdH2JkToMy7o2C4sJxqi3R9h
	Yv8WZZMilAJAytZBPaijhAv3QpQADCxKDFiEyvvObM1+VbxyhIeVYwQ00Eb+PXyVWvp/2x64Hbn
	+5/YIO1Db/x0bP2yDY8gRlEhxiVBqam7DfPv3SEN5zGrndnDNnZ/zo9zC9BwGTZAfgMNuS7Obym
	X2qjLfkdjUUbFm00p8/Y+LFnKtv5zjR9dBLjzqVlu/P5ODrrMjP7G+yfr/y4Qqi8BbbQwI8tsBf
	Rp9SjSf5TAA2nazA2ZEVKPedeYPrr6H0xnj8/NOkaXxZgjKo0zD5UdR1EV0TK+fjFZsML/lxlNh
	y+m+ez1iOPnXxIsVsOzip5n/Ab2v0UVWIT3ZW9Fg+BbDNOV0rVcyEmLHkVVT7BRogDlXfFY3WuR
	eil/w5nrozAHD7gSmOEWk8IWGS/DIrePmvz5oTNwC7fLTC1HpL+3NseKhA3YIE8YauO4SveHtmB
	0VUOpY=
X-Received: by 2002:a9d:7597:0:b0:807:50d:7f3a with SMTP id 46e09a7af769-8280404033fmr3700435a34.30.1791374759497;
        Wed, 07 Oct 2026 05:05:59 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.250.245])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adc70e262sm2409045a34.18.2026.10.07.05.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 05:05:58 -0700 (PDT)
Message-ID: <6ac635a6.965be603.281211.1833@mx.google.com>
Date: Wed, 07 Oct 2026 05:05:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4225820647211866691=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michal.dzik@streamunlimited.com
Subject: RE: [BlueZ] adapter: remove bondable mode hijacking when setting IO capabilities
In-Reply-To: <20260922111249.415422-1-michal.dzik@streamunlimited.com>
References: <20260922111249.415422-1-michal.dzik@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4225820647211866691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] adapter: remove bondable mode hijacking when setting IO capabilities
   Pull Request: https://github.com/bluez/bluez/pull/2566
   Created:      2026-09-22 11:45:28+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============4225820647211866691==--
