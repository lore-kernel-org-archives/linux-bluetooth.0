Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB05F219E8
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 Aug 2025 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756602639; cv=none; b=NCk6tEGvCscQDL57o7AhN0CPbTTyLkDRtnfQl9l89CyLKro1D5ld0kBbapqcgGnXVuzqI8gUBTs9+XLSZyA5uf/H5QVNXL5LhiAmorClCks1U4ps89MVL0clQchwBcEdAmzaz0huDhX/TakHHcy5ska8Rm32Z5+bz4dpHyeC8dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756602639; c=relaxed/simple;
	bh=Kh0YIjaY0PIRV5NlcsC8gb4e8yDFTA3hIY4HiQ6fk9Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=n1O9GpIQU/zPCipLaBD0SKYk6XGbl+vJA8Z9oY9UvddxCH+Tva8m8YishvOFw2bjYWzMy5M/fGr7PqnKAQO6v03Z3rGxA812yUjN6MwpiJyoXfzDMKUkNs/VGpYvqv2DewvT5MznZbHFSVrUNApLyAvAyKparn4sT4hkdojFv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD8TFEGJ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD8TFEGJ"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b2d501db08so41373981cf.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug 2025 18:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756602636; x=1757207436; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kh0YIjaY0PIRV5NlcsC8gb4e8yDFTA3hIY4HiQ6fk9Q=;
        b=YD8TFEGJNIeJbSO1j73hLZh5G+3R3a+Q0xZhengop2q13SR/4LgrcOhmI36z4Eqgxg
         5hQ2LtRxMrzFD/v37rEQJR7pVEh9U12l8FoZhzlnjNMYxhC3W7UuJSG3zBkxO+Ma/SW/
         IR4PL23m8gsvzX+aZ/+XY4xvFldKXVz9M3xPzaKWlM8g7ydwacvQ4CgGOQ92FAvyGocy
         wGENZmotVm9AY/xkBF9znDJO7Dl9D31Y0DI/zimzM2FhaZt5tSj+tZi8o7jdqoeiYB4y
         Qzfy54cb9+eRrwTGK/CBIYg+K8OwlWBmVA2ma5QcThYG5wRxx/kpzg1RMq9qMkmmc66v
         ESMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756602636; x=1757207436;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kh0YIjaY0PIRV5NlcsC8gb4e8yDFTA3hIY4HiQ6fk9Q=;
        b=TliATXpwk31Q/d0/1v6ia4pznl/365GS0csFtvbQl+Ap6YZQneqfkFHUY2tVM8R+6/
         IZKQjCyBLUe0pNkurQe7qKNzpJMKLLWqdwJ6c9WZ3lMTW58FyDOk8cY/Huti3yH7+uqz
         tXGb5114bQWcBfaVwZBNYPh8lOiR73J3lEK40BrSHx3su/a0vjneE54MyAdmMUUu9wzi
         8JcdlI1u7sDAzTnM+5ryp6jXU4+GEBqUd+jLVkU4k2o+kQegom3Gv+qMbEU7DJ8NZcq0
         /pmwff2EQCBzUrOL6AsJtoF0J6ZurDu8wbP2NyJd5smhzkZNJ/u6+JiZqelwEjK/4/Wi
         67yg==
X-Gm-Message-State: AOJu0YwBXaCP65aJ7KhFmRhp7+cNiETRKHoX5WW9nYSJbnpAfUWDV2+E
	+IoAaYiqRrfwHH1qNjJcZf8uDzWL3oDj2kzJQtxE1+dDL+dcwCpSv1NzHy+VSQ==
X-Gm-Gg: ASbGncs85WPmFEDepXkOKegllamnuXPa4Sn5y9n11TBTMmqoSXwsvL+PshRCXahrbjb
	jMverul9V49MOisXGzLRXsNbWB5kxIMk8NKt9nI6Na0ijnqxESd+Gl+mxhTYZScH8ampajXQK+6
	XRGPOYo4uLi7JEJaVYv9FIOe6hFpwAjTG34ndKCi5ZQcGw23n4CugSdgFZM7wxXYpxuOxB3Bts8
	Cy1oj9R/fq+XebWCRd9rDPWhun5KVzGQm1QaFKAYSjgZvehkAzfPIeJPgMR8kaz8n/HPrg7vq7q
	PYWwgAvWBrdfyXlkZc5MvueLURi3xrcv8ieuoDgXVNPp2h8A3/IelBITumiQRVdrjnQpPcWwQX2
	uZEgKJzRtmGBFsA1WfrOE1I8MweXB1WKoVsNdzvpz
X-Google-Smtp-Source: AGHT+IEKVDKZb8nEFOb/szuexuD1v0ae3d+yq5gBbmz+UZbt3c3eRnMlKJpz8DOgsuvP5Xh7HwlbLg==
X-Received: by 2002:ac8:5f14:0:b0:4b2:8ac4:ef5e with SMTP id d75a77b69052e-4b31dc8fd61mr39971481cf.65.1756602636299;
        Sat, 30 Aug 2025 18:10:36 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.115.181])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6c8a4fsm39019411cf.41.2025.08.30.18.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 18:10:35 -0700 (PDT)
Message-ID: <68b3a10b.c80a0220.1a375e.e5c6@mx.google.com>
Date: Sat, 30 Aug 2025 18:10:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4824116298935967531=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, elespink@gmail.com
Subject: RE: Bluetooth: btusb: Add support for Mercusys MA530 Bluetooth adapter
In-Reply-To: <a2451dab-004b-4c2f-909e-89b5875eb760@gmail.com>
References: <a2451dab-004b-4c2f-909e-89b5875eb760@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4824116298935967531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4824116298935967531==--
