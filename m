Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4487E74070
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728843; cv=none; b=sNRJhoYElXzGybhIkT8JWHpUu/V2rUu62OqcGmaohl/NdAiAyOybcIthFFnt5JxQTiweah4n3AS9vsQMEUmYHy5Nnp8pcRLtHc7sTNjjenw5LJn86aQlKIOmDJSWbaYc//Yp9unjP0zZZDOjuMC45qKm6LY7O1/E5RiDmFffwBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728843; c=relaxed/simple;
	bh=Q/8tGUqFiJvufvwTawjat9Udob7S+I+e/fBBwxQhefI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=X/6ncBsjJwgot9Ej3tEcUF/q7lI7IyOlA32TFH4CxOUNTXDEa4hqyOnMlkB5FPC+83qMc8+T5RWo7/00M6xpiL93Vd3k+jgBH9IzIm/9o1KsZOjorZ6I0YvLjBOYE/oMaxxK7aGbh3GyH78fN4sfkmt/FshRlUYG14koMaKsV44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdBbl0EK; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdBbl0EK"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d35f1dfda2so1710462b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718728839; x=1719333639; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/8tGUqFiJvufvwTawjat9Udob7S+I+e/fBBwxQhefI=;
        b=TdBbl0EKn+/z9BcBrYlRPaLG/xEjxHQG0gMe3Z+OIu7OCcgOHYf1iPw2Uzho8st65R
         GXLuQuTNvGKU1ATcnTrHDcmYebBWcSESTcTbRtnzpusgt4xXUk+nCBzgB36wItvmfapL
         QpW4K2cwA2JGOx0+4s+0xm2sVaX3uiBqrVornp7kHb34YYj6jLGoQNvGZUHpJ3/5Z1Eq
         sGX4OUlabJRuySprY3MSKy7ftk66s6iyoopC2Ur+NlPyC2ju9G2lzO6BeycSPYUIY2cU
         nT7L5E1kPUZMXtAn0oHsCymjh0ex1zVxEt/jzVdyataJTuJDd7I8eOYbIn00AtruJcLh
         B2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718728839; x=1719333639;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/8tGUqFiJvufvwTawjat9Udob7S+I+e/fBBwxQhefI=;
        b=N3K5gfZOB11gDb1XR8NTR9ha1JsfZ/fcGwAdCk4BAWFmGTwO+z14xJy13ABWZGhJdN
         NK4lOPXFb77C30aINRXEJqXFPFVv1qr7ptjjavv7EAbVoT3m8ye6yIVv5vboWiBb1wB9
         B07fXKs8G408j2P/gdLf8xQ6N5h6HU8Z/4/cD/a/ryngi35mED18iKhT2/LdhGFBiUAl
         i6UtQomoEiBTGEI5oRzb3ZK4nwHUbJXgrCfbbip98UrWQGqXu5y2LXhZ22BVFQUl2Mqc
         +PoJ8zUmozMzebWabQsqId2WR5Iom80iqPgZcClEpWOgaYHFWWZb4rZ6I/PU8AFzBy9Q
         Sc5g==
X-Gm-Message-State: AOJu0YyPa02kO6Hj3jxh723MepAEliHW35Ubrns90cI0rO2x2n4Cy/ew
	3U0b5h1ZBJqKvE6n8ddrYxAmgxZSzh6Ih19TgnAbPctpUNNjBH/3lkvZ/A==
X-Google-Smtp-Source: AGHT+IFL2kvqAXAXjIZN33ES6OQhus/7ypsZl9elQNABGfZ/IvU9UzJPMMoY8jKEwlriJtLGVGwagg==
X-Received: by 2002:a05:6808:bc5:b0:3d2:250e:470e with SMTP id 5614622812f47-3d51b9e3750mr379068b6e.18.1718728839047;
        Tue, 18 Jun 2024 09:40:39 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.91.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe6bb2esm529425185a.135.2024.06.18.09.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:40:38 -0700 (PDT)
Message-ID: <6671b886.050a0220.24140.096e@mx.google.com>
Date: Tue, 18 Jun 2024 09:40:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5292582517039113609=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, meartzheast877@gmail.com
Subject: RE: Patch
In-Reply-To: <CAFSktxaxM1KFViQUpr6SQV54=MpdPWOZpb41vTRk1UHtLfv9fw@mail.gmail.com>
References: <CAFSktxaxM1KFViQUpr6SQV54=MpdPWOZpb41vTRk1UHtLfv9fw@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5292582517039113609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: client/player.c:5142
error: client/player.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5292582517039113609==--
