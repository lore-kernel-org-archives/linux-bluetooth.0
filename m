Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF32153505
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 May 2024 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714739015; cv=none; b=KdxSO6zzsUP36zhPsUjexPBmJjFyhzJCGy1LF167SHDYjIDqnDemQbORFAd4ziA+CW/2P5GaLW2rV2mRKTsN0gAEs6Pb08nuf+Nvci3v2pTICRrLggFxqJztgOUKUp02PsV2/huRZbJQ+CLf+65Jz5MMWzn7/49IZKKPfyiaBcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714739015; c=relaxed/simple;
	bh=bXJBkjauX0U7dTYSO7RkmwON2a+mKxrXYjXvN6wBBCs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KWfzDyfcKQFuhhK8Jwc8BYCQAA3ekt52eWGREDhY7a/t/o3DJWYJAVIa88EMOoSpjXKcKtf5Rw+W4PtGGMV2gAGLyVYGjl2tmhGYhdmcC/X0K5+cZ9HauXT5EY5CM8fOIaJZc3k1S9uAA7D9Tr1mY/pYOyOW9c+5+vwbb/yU+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnTiMG5W; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnTiMG5W"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de596c078c2so9085231276.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 May 2024 05:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714739013; x=1715343813; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bXJBkjauX0U7dTYSO7RkmwON2a+mKxrXYjXvN6wBBCs=;
        b=dnTiMG5WYSWi4Q6yvhjKBJagVKFKXoGoyfflOngAmKXdhYqjhQgetydSSGdCtoshra
         wW4tEmBuea7luTTyVtZHQo0wMJQpeYFr5isXDTjoFRhcdXocOXOHihfPO2ApegH1NQr6
         5vp52To6lzHungvHSrmE0hEkwBPe/wvNF1wXx+re1RW3XulknPEKqE6DFZ1WEMzeZmcW
         RD/nQxVTL0t8kX0bt+GnEBP/R3QtSgXab6RgRmnhsXWST0D/3AuNcH1n+S5bWTbDKghe
         WEYlwgq0+AIABgbD4Jr3EwPGtXwZcKEuQJA6TtNkCuPy966hebOK7TvyUHnlvCabs25u
         udUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714739013; x=1715343813;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXJBkjauX0U7dTYSO7RkmwON2a+mKxrXYjXvN6wBBCs=;
        b=eJNze9kuE9v+ttv6CH2GgTNZXAzB0exJavY7KJdlyQnSheYy/6xzJTmD5oC0bKHh+p
         WrUQCdR07L6uFzuOh91YHzFVepBfuA0ko4UwByQ0QMFXaaFg+VxZ6fRUuvZUGg0b9dOd
         Mo4s3qHXDbGMr22IzWKoNmM+iFXyUUOEpilxfcfMZcULivIq3GjpgGcpThr2cqNfeXI7
         +VKR3s3RLpjTqkQitmeLXVjBI6mx0Dzkm4+76ywlkpLGGu6vSKkvh6x8c2nH1uRfuUwO
         l30OPXuJjMDdTSmVId2L56qGTV67qA/WFsx5Y9rg8HxaS1D6AeGaPi4JFZ+aOfTVMpD9
         JQ/w==
X-Gm-Message-State: AOJu0YyC0CQGhbpiV00ZvurRH3bup/pUu4c8JYwq6ZZF6eFY3lGAQEEg
	lnSM71sfnUx0W58MzCSYrrSZUzlJkTxlZDWxDOw7uMBTVFtN/MHYYZmAQx71
X-Google-Smtp-Source: AGHT+IHCdoTjO70jC5NtBu5SsrxUusmUayWDqyh7El85a7BV/ZpJoCltD7SAnBsiTw/xu3q/0ST42Q==
X-Received: by 2002:a25:99c3:0:b0:de5:852f:6afe with SMTP id q3-20020a2599c3000000b00de5852f6afemr2751011ybo.30.1714739013149;
        Fri, 03 May 2024 05:23:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.112.113])
        by smtp.gmail.com with ESMTPSA id y138-20020a25dc90000000b00dc6c58ae000sm622083ybe.16.2024.05.03.05.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 05:23:32 -0700 (PDT)
Message-ID: <6634d744.250a0220.16008b.2758@mx.google.com>
Date: Fri, 03 May 2024 05:23:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6320772733951785035=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_nakella@quicinc.com
Subject: RE: [v1] bluetoothctl: fix for gatt unregister-includes option not working
In-Reply-To: <SA2PR02MB78204D928243E903066D5678921F2@SA2PR02MB7820.namprd02.prod.outlook.com>
References: <SA2PR02MB78204D928243E903066D5678921F2@SA2PR02MB7820.namprd02.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6320772733951785035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: client/main.c:3060
error: client/main.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6320772733951785035==--
