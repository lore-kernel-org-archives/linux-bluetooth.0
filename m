Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFBB8F49
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 02:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403753; cv=none; b=XC80N7XaM3f5R38/nVC2T9F+UrJsESdmGkoqaL46/oNuoNe+PQc/y3VjHMPeIVjXGnUitLoib0CxIdOoXTLzdTxC87Ba0Ig3rUkQBa54a5eaxXHSjImSD0goW7VXDG3VNRhSHKFonu2mAMv8/kV7faNHg/yMPMRgH09QGU6KeKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403753; c=relaxed/simple;
	bh=SRnSZG3SI34Q6BLUdaOfXhqFNIZ+zhm6ygrBI09Hlgk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PnV43zXheU7TKJHfVWdHfVDJrv8o21xZUBGTaOhfL+8/oVN3UYL83K6TJ7fIvAmd1PL7I2XLqfOeBAH8LwUrLzwvUXLHGiRYMCvz8UNy6nmhsYfZBWDoEeGgZgH6Yj3ApccKpGy0X/51fj8haofIjxf0XJlIUyF8durcx1AbyGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMNs0qCj; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMNs0qCj"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d918f066c1so25230066d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 18:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734403751; x=1735008551; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SRnSZG3SI34Q6BLUdaOfXhqFNIZ+zhm6ygrBI09Hlgk=;
        b=fMNs0qCj7NQhk8NgNVTnqZ4MfsXJYeMw10aOOtK1ZoKvAFbr6tvRQKcQ6EuAOyKzdt
         fBaECXT+axE5jURSY/++fnWQb0SyqtIHk4UH1q4PJFt5I8XJxQK/h+hSV92IXYoslOol
         73nD5duYyNXb/mRFNkxHh5YJb6LkK1/U209JPP66aqwyfckZguN3Xs0XzNP/G73TW2+p
         awEIRG6rNRatPHmWJ2EtK+wNp6c1ZY9f0OkG1I+uIpkqKPMxMRrurwhosqNa+IZUzonq
         i/NS54yZ7gMig2mSO/Af53SPrscZTg50NNASlxiFdqlkthhNjB5dK/HdatEHqIqnLp8p
         WQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734403751; x=1735008551;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRnSZG3SI34Q6BLUdaOfXhqFNIZ+zhm6ygrBI09Hlgk=;
        b=HXj2vocX9Z7/MCH5XM8MH1MyZYOUfJ+qSf/ccv3vmq0+O18d5oOpwW/aK6uaW5iHjy
         PluYBzZjDkRUTc5F99yqvhOMzRYR5ZeASWcCn43TfT37RD/4xLIP2KKg96QIBI3kUb4e
         clzGfkIH6fWxQDFdGx1jmWzZiNJQpK8t8nobEjqSHp2C7nod3VNLuN80sNySPOtrgXq8
         +p86iIndMEllmhxfMrHbtUJL8GBGQPBVWUopjg00FgA0wDNICCNAiFVMP6Uo35EB3T7Y
         uKPWV/Fup+tyn2IO3ftStRgQe0kN8GJjOw4mryf0lzrtQaXqPBzmMwRetZIo1rLXd5hz
         DnZA==
X-Gm-Message-State: AOJu0YwTky92+fpCqnSDhRwrnVgA9hCr3UIVczpvxs0T/1fIHuIxSDbC
	hs5QdNXLB78sgmk+NRtm6W6SEMTSGu94jhnMiJo3amgmQFLFjbKKOSR8UA==
X-Gm-Gg: ASbGncv6QSLhJTWXd75dD0OXeLaeBvV1ldqQPnVLS79teNTYrwlNeGdc4YzNZUoSYnP
	4mdNB6CcD38NaxXNrRJB1l2fyKVRT5MVL6RLvb1f+LTrctFBw3Q8gKpQ/plgXXA6b7+AqSEQ1eQ
	7kkFA2v0Tzidb+VZ2TOOgmegoHskP+ash6UMqARKds8ptvm+D24uFUE5aQtWRcz+2oBFcTLshR7
	zhX8ZRfmEczi1gHGg8pxnjy5gdD9DEH49saWk2w3gwhn7L3I+rPe21JyHkLUw==
X-Google-Smtp-Source: AGHT+IGFlOyeVVYfCncTH5bmtB5giCs2KEKjce6GtCRw51mutlAykQ04R1QUOELJqYAQJnx6BuPUXg==
X-Received: by 2002:a05:6214:2501:b0:6d8:8f14:2f5f with SMTP id 6a1803df08f44-6dc8ca88df9mr313088276d6.23.1734403750899;
        Mon, 16 Dec 2024 18:49:10 -0800 (PST)
Received: from [172.17.0.2] ([40.67.142.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd257215sm33952336d6.41.2024.12.16.18.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 18:49:10 -0800 (PST)
Message-ID: <6760e6a6.050a0220.59753.b13c@mx.google.com>
Date: Mon, 16 Dec 2024 18:49:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4899411384226036108=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kees@kernel.org
Subject: RE: net: Convert proto_ops::getname to sockaddr_storage
In-Reply-To: <20241217023417.work.145-kees@kernel.org>
References: <20241217023417.work.145-kees@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4899411384226036108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/socket.c:2103
error: net/socket.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4899411384226036108==--
