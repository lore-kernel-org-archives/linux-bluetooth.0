Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15D730E83E
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750361934; cv=none; b=J1D98ckG5rRuGS5MFcBQ/5OY3DD2V25kqPUb650CpXXhUYOy9HQdaqRjl7M6burgTMsVXM6WKMkUXpXEegh/6SO/h3tuqFb2lI22mgG+2pF/B04aeQMeaz8EmQppqAPdE0zYL7FD2HPZIS0Xnj+VjFTalGiNaMNk6DePFYIbYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750361934; c=relaxed/simple;
	bh=7MnfAhJ098mL3RTJIqT+W90hZ/kXzsgLDVmCVVWRUaE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J9EX+EUD0PvV9JslmlBiFE1wjDzCjF6lDfK2F0WT0b4+n9D/bWrKjNIu7Q/y7D1Ijs/jAFEg48wIJpavxnUtGFlNeZW/x3gEHW2jYYwJvY9LACOf/pycPj0+ga0XwZrCZa+bp5iTzivJMPG3lQn5eMBov/a3rsezDnVz5T8SxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaZgvHMm; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaZgvHMm"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fad4e6d949so5954986d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750361931; x=1750966731; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7MnfAhJ098mL3RTJIqT+W90hZ/kXzsgLDVmCVVWRUaE=;
        b=VaZgvHMmU9S8BnMYjHBN+bUva/A/V1Vn8e1k5Qun/KowImV1b9+KRfVhGE4bZZ+eZa
         eG1G76PzRxSDN3HdjrJxA3qX7V2uV8IOk4P7NuwX9XNF2durOYhMffyChwZtNh8RJHUN
         0ZE7Sl4NHaxlzHt+a1BHixBRReSb1its3/3L7qXfcXEx+CxmqyfN8xmJ9seu+Pydd/3G
         Zn0mhbxP2oe6lRXHhVdFlZFaDSKC8xVZgkdN9CtokR510s5p/XA7xXexAYnxzLHpszAP
         BDX4X4J2CM2HnwSw3seuM5OHd3pmsWjq4ga5v+4ZO/UWr1YMT0rKhVVUeQLQb06YXvwg
         20iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750361931; x=1750966731;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MnfAhJ098mL3RTJIqT+W90hZ/kXzsgLDVmCVVWRUaE=;
        b=oxtPF49kUkUWZjtdkzs5D81Kndfn9JiJXGHgg8m9Zuxd4xW79BVQhJiTnePuIc4BMK
         nQeeRXZ+XIt7omQzyz5TBiMlS3l+9pBoJjrNeDVMk+7TOU5P7FcK4DZ83mvJ1J0Z+Bdb
         YhOOO4NRb7XvWW8TrlzFGwKslYVkGAhu56YNU6kZ+mBA8JqQqn9XFxz90tDwGTjhSBQo
         AXj1lSBIqNU+OWtpYHcqp810VXa2W8lT+guDqSC81bUIsmNRCyNSUgOm43FeWRL0SpBj
         XQLIpuBCEzz3y9g3whF07zqsIrO/t3pPy0PiEQJ3IkgiHawMTlE+vouZJLWV1gTmscFI
         bNNg==
X-Gm-Message-State: AOJu0YxmlJK7Drd2hhIpA9x1XPFT7e7rL8vuAdy/SWAKPuA8yfpyM1Wz
	uQfhMjXMAfluCCICVHD8ml+SujIjPGUBCC+umj+D7TDWQh+GK9yFLuoJ8xiGzw==
X-Gm-Gg: ASbGncua/zpnM9PNjCorSNkRdbwEzog/Luf2rWV6whJBofaw+un2pVAHePl16cU7v2g
	7A/ChzDhuW+182AoaKKb0D/hJEVHxsdF2xsww0hHYJiVefb2kOWPrkLNcP5so1lARDgZiS8fgrY
	hjAiUed+3Byxj65wYvQ8w/hMajMGUQkLeMpc24qmla2Ib6qR5wgAchOOb2Fd8MCFCdINYxf3ovO
	wGY9MHq72KE2NUHJ+wGneFpuLYRQKPDLGviiT3xWVDlrmGHCKS2zDh4a/zxjIOHI/zg8CkS5iRu
	8WxOUGfZpgambCt07D6CPsBVozrrZZwEQ3eQ6xhTToCIgRx1q5MOfIKOtgWvSjbJZBQEVTa3Xq+
	gB/Msjw==
X-Google-Smtp-Source: AGHT+IGjAMrkzc+3c94FuGy7RbzThJ1rpy6fXySOLTa6GzHIq5X5DVUBevx5IppL6LW+owHM/zXf2A==
X-Received: by 2002:a05:6214:5019:b0:6fb:3e25:1dc1 with SMTP id 6a1803df08f44-6fd0a4add19mr7002316d6.13.1750361931149;
        Thu, 19 Jun 2025 12:38:51 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.181.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd09593450sm3336206d6.98.2025.06.19.12.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 12:38:50 -0700 (PDT)
Message-ID: <6854674a.050a0220.304a03.1572@mx.google.com>
Date: Thu, 19 Jun 2025 12:38:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3215608923662511913=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean@starlabs.systems
Subject: RE: Bluetooth: Revert vendor-specific ISO classification for
In-Reply-To: <CABtds-1fKyFYvU1jL9njmhfphU0XytO+F5mBhARAzQip+CK6cA@mail.gmail.com>
References: <CABtds-1fKyFYvU1jL9njmhfphU0XytO+F5mBhARAzQip+CK6cA@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3215608923662511913==
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


--===============3215608923662511913==--
