Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAA8288D1
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Nov 2024 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731144993; cv=none; b=SwhPiA7Xe7W/Md8r6kYtcTJ7+nw+WKS4tixmHjJ62DCTHWUo1GD1n5zH6KPyStYobMf6SevKF9hBn+pMzM+s3d1AfFdENsHPlb8jAKRXFfAj9ixTbdzT6lM1og4gDKsCsi+dv+csmNmB/M9XMrt2sPOD+7j5Cdh8OerqSy2LryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731144993; c=relaxed/simple;
	bh=5K/iUkMT6amq1cim7Ogwzq/wC2cznae6Gp4+eIdYg9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZqOpR8Bx5jyrApZvv5Ejg4M7Y/i/VXgoVsWBghLim0oAdvSfmCkiXzXOc28T9MMAYKuQReOp+1oUvjFr4784d+DXW7HJzchyKdUBS82jDoPlBFO9jHc1/yVNEp4c7gfk3jok4oDJEJN3xEUOVXuPh2ErpMidsSvqk/AVHP5KIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecVbWpsc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecVbWpsc"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43163667f0eso25920285e9.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Nov 2024 01:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731144990; x=1731749790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeUpInz029X2ZJ3eEmn5acabrURQm7oATSgRR5dPvfY=;
        b=ecVbWpscbjbA9M6qbDb+zuQoggQMLFohBLY2c0ytuPXTbR0v7ZPC7/bqhAM2gPDl7b
         izqi5uA0t5616RdyJKfUceF+F75zvaYtQVIURxH9aMMQDq3fAYp3V6UokXXD2f4+Et5q
         Y3LVOJTUcexuhpBiaVZIehlSDEVUWFT3Zlet4o73XVyTOPLxwO73IB7VJMlTkHtOXkHS
         CsoCvhXXt+jrrYJjlRdsUeis3v0RuQNFuIZI0BQHPyjFJnd+uWy58o5q8IaCeNvko5Dl
         0/6Km3vA9VF7tTGtpio9CoM2StcpFOS3+l6Z8h/TuRxVZ72bw7W1M0lH5In0Wd/d219e
         wHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731144990; x=1731749790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeUpInz029X2ZJ3eEmn5acabrURQm7oATSgRR5dPvfY=;
        b=TKHUpltK1gojfEh85oi0ejiev3lNSnsoIIk0+bxi9GPCLFCrWtUPxTrB6cKAWs74uN
         NYfTmblQE52KPaBJKwhuPq9sqNYb3U7+AbkMTtIL/uNXwoIsLIJT5C+0IZfZfr804EFM
         vwXGWWKUT9a0wCbRQpA4QmLkG+MVJVvpAv9TBnzmRK4ft8domqLgGxW+MKku9qylWzEC
         hqYEMLRlAn2otegj2aWa3xr4W50QYbzNYhM5MQC0HnU9IuNLa55F+DvknwNsi9akDFrw
         EGLHBM9f9aC3xcdTgb2QcarGwqqQshvtoCHrzkB7gBv6x+0iuHwGBChw63ifg0nlcIWn
         rfmw==
X-Gm-Message-State: AOJu0Yx++gj3UZM9TcMPBwaxAcrhJZofyOAI9NlINdi63zzDiJsC8Hlc
	JQrjUrizBBqDUirUSKRUWDHC88O4Xr7U0jOce9toiO8OyAPlMX7D+MXOKA==
X-Google-Smtp-Source: AGHT+IFx3JWVJH1WoqPYsc4ToifVzPoX1oNFxxv6TsbkeUUV4PmkIQyMcJBc3QHT4jDjmplxGzdQkg==
X-Received: by 2002:a05:600c:154c:b0:431:6083:cd2a with SMTP id 5b1f17b1804b1-432b750ac47mr42963945e9.15.1731144989736;
        Sat, 09 Nov 2024 01:36:29 -0800 (PST)
Received: from x1cx.uhrm.ch ([2a02:168:4f3f:7:4b00:1bb0:11f:418d])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432b05673d0sm98415375e9.25.2024.11.09.01.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 01:36:29 -0800 (PST)
From: Markus Uhr <uhrmar@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Markus Uhr <uhrmar@gmail.com>
Subject: Re: [PATCH v2] Add pattern matching for service UUIDs
Date: Sat,  9 Nov 2024 10:35:35 +0100
Message-ID: <20241109093535.3523741-1-uhrmar@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240825205817.70066-1-uhrmar@gmail.com>
References: <20240825205817.70066-1-uhrmar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I submitted below patch in August. I'm interested in getting it merged,
but I have not received any feedback on it.

If there are any issues with this patch, please let me know. I'm happy
to work on it if more iteration is required.

Best,
Markus

On Sun, 25 Aug 2024 22:58:17 +0200
Markus Uhr <uhrmar@gmail.com> wrote:

> This commit extends the pattern matching capabilities of advertisement
> monitors with matching for service UUIDs. This functionality was lost
> with bc2ab4b (see #652) and not added with b0656c2.
> ---
>  src/shared/ad.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
