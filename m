Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1C212F98
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526037; cv=none; b=g7etCvpLwFeP1zNaIuMkP9YtahOdZi3p2vbsmrBMRCyQYJAYSICVH+gW9VHaP7W1mCzDGnQQsF5KPAVU/Dr7kOxllsQCfCJR5a0se3Q9lcsTRO3Ye2VNU1oNRURBUlnaJIM8kuyw7pk40qk3B5aV2LrL2xwldVezZFSchRAKdys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526037; c=relaxed/simple;
	bh=8VeN1uoPnovVivOnCvY41WMjTOXmqrpSAJWiHtNGAXk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m8kDXbWiUTzIFR7Yci9AMPreTQWTTGXqHnd47iQ5VUzbupcZlfXvCRyP/SfFSPHln40ghuOTkHl1Bw4673z2s6mrdo70BLgDuwalASz6JNN4VGirzWgYxhARfkjuOgSLqv2WbM3tePv+6Af388IgzKcnx3xcChF06+4tCoM12Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXZgSZl8; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXZgSZl8"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7bcdcc89715so186248885a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 08:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736526034; x=1737130834; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8VeN1uoPnovVivOnCvY41WMjTOXmqrpSAJWiHtNGAXk=;
        b=MXZgSZl8dd1yUUSw/Bu6NyH3tvF9fAqt4awp3JwPfwVvOqQOVXxNMq78oJ2nKn9Y6s
         9UYdCV9MjuX1dbe9k1y0FnCExNpPkrvXq4Nodw7xPYcaEHjC5p7wWjHHxhQ3bN78LqYb
         QPf1WQOSQQqragRf8IljT3lL5QPhJEcO/87hRxdC9ka2275E9HjZNv0uL3mjRvtG31Lt
         SHBG85Vy15D2Esck5K+ClVERBUWgbZQXFVHWlyvq0v9yar/A5SEmUPlD2bcIqUntwP6c
         hA9s8AUV3A9VR3a3I1kI0QcyxYLZ5ucvpaasebbHkRnc2RSSYTDKiDdiaoXbUKLlBKQK
         Ni4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736526034; x=1737130834;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VeN1uoPnovVivOnCvY41WMjTOXmqrpSAJWiHtNGAXk=;
        b=AUXcVIo+zvtWxMnYK/aMCl2Kz3Cr5qje2ZYFHlpeFvqLUEwOwRHbjhKC3VnWKTwwRq
         6p1yVQCwJfNJxQB1ijizWs6j7ljWeaMEUElRum4COrTMMLT3RHir14ziGiT4oHKbNbuH
         77BYQj/90qHcrfIGu+sv3DoK4RiWKwpKDaF+fAQ/KBvF217GuT8FAw8Gs4nLTltegnbt
         hdXuPBZSuAHK6IdCA4AJJ4Soqjm6bjzExjrvfoyxbxFQ67oifjscY0AkCJ/SVFMi7Ojc
         /eOZY3CPzilvkSsoVb4FxwqswhvDkUGc9CoAH0Dr6vVQAWAh/IKxRdWF9FCkt9g4ab7h
         vUqg==
X-Gm-Message-State: AOJu0Yy61B7lpszGKlocTOJJd4WSNSp+0C2uWwfvQI3VA11Bl4RGM8uQ
	77vEwFoL3UcWzn5rgWIxUxsPeY/F2GkOccQLRcWcY4PouuLagdu+BOqG2A==
X-Gm-Gg: ASbGnctctGbs6t+9/AiClmLBIuSPKZk7bQaeR2G8B/Z9YxI80qRpmInCJAva89zRaP7
	p7SIKBnOlZI8m0MS/kh+yRTf09mXZz6219sFWLXkt0zLOmVMQ5+XHKQW2ZhSVfwmG/1mr+kS/Rt
	d1MaM4nOOT6NHEg0KpACghhxAravqkoy6PiiDtorqVggUIwfOp6FqLx9Tp0+QbLCyBOUEP+wGKH
	yHJIeLEyM+u0ukHq2BPS/A5ADgQ5Cr7dnhCBLYmOpz9EBAUt33VRgae5QYa
X-Google-Smtp-Source: AGHT+IHwsAB+oY7Wqjs1vSv4uteJ0GXHbxoBuUl2GwKMjNIyMbgxKggMYf7KPTzh32z/mnc+ZsNwFw==
X-Received: by 2002:a05:620a:2496:b0:7b6:7970:6522 with SMTP id af79cd13be357-7bcd97b8847mr1171221285a.40.1736526034612;
        Fri, 10 Jan 2025 08:20:34 -0800 (PST)
Received: from [172.17.0.2] ([20.42.49.85])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce328128fsm186656185a.61.2025.01.10.08.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 08:20:34 -0800 (PST)
Message-ID: <678148d2.050a0220.1f6994.8fef@mx.google.com>
Date: Fri, 10 Jan 2025 08:20:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3256834192768141750=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] build: Fix --disable-asha
In-Reply-To: <20250110155132.2647060-1-luiz.dentz@gmail.com>
References: <20250110155132.2647060-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3256834192768141750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: profiles/audio/transport.c:48
error: profiles/audio/transport.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3256834192768141750==--
