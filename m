Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057373;
	b=G9Ebn5123d1Wrro6QkWExCahMVHBvMiYcJu50DG3gSmpJFDGhIZaUva9DLnbD1aDdPxQ
	 sg6DWNsZS5yI8YIyRVB3DI3sr6lFm/Sn/4pbZZhEwDNz+ZVNfjwl+Alk+Ekiq2FfAGjM1
	 XWvXOhKT7WrlsiA8EFc/NIzmDmJtnuQsWtGH03dGCJZ/CIn4RBYj+Ky2c7M4nsFHd3PwS
	 A/pqa4Bm3t8iVSPZmcGIX44P2e3js3eECBWC4xp4u1hdNIStzQK1d0xOcN/e4emubqhdR
	 Tq5Lkw2MMhumc8omj5cd+5/DopCcA4XCPP5KvrTuH8hfhj+/7+jFIDoKv3zpPzMjXRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=hMGAblPi0haJKEshMVAEeY6LuLic4k2PRSFp6e9OOj0=;
	b=WGw0rAHd8aNrvS9HK0lkomKY8hoIFXZVyIQ+2KvzPp7IFlo24cjFMh3YYUFytvdL/jl1
	 fEJZphVrHephnTqwY2dV7DEXLkPIDauJ0vZKJcP+bT+B1x4yFdfKxd0sjsOaJFzaQY474
	 oGhH1NyyF8BqLvfoFYlJpRf5ZmfZbypQxinkb9Gog1hxPBr62ViIlMrdgaG9nOGdb2Lfw
	 Qzf7eCgD7raTu2/byA8cZwm59eOXKWdfEBUjTR74Zs6V3KZqyx3eGh5hcTmxDChde7aYJ
	 e+wgHUpdN1zxVx3yGJNyG7znl+RVjN8/JFeXHKdQaP0sh2g79Vr6asxyDtCBX28MKsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eXm+ucTu;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92155606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 23:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92155606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eXm+ucTu
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1846bc43c28so3872076c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 16:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057371; x=1793662171; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hMGAblPi0haJKEshMVAEeY6LuLic4k2PRSFp6e9OOj0=;
        b=eXm+ucTutmuaKavd+nZTP4ayAPCBABHZSpwyDLk+msHnzIwF7go7/SIC22J1dZMJfM
         Gb2xbD3qxw9gpNKX3nGKm64r0LWZEPXYx6sBFOMpFjE5Ur46zDnEVd5P95SsQAZmc+O8
         2jvQikz3cNz7HowSGrDect0WX8xIvSkNLcn2qnGyqKJ8KaFqf0Q///U2MgQuu1ZyRfLM
         xwS9Si2WioogyoW3sN7qNmvy3Bs3RytRrcxs0q3OYr8EjdoXxc7lztZxg2Bd730P+pbi
         kwXFXE02sfEIAXLVxOUVwYp4AqCzlYq91u567yZDqcDLyg+H1pIDgG/8URtqjgWFuRL4
         AiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057371; x=1793662171;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hMGAblPi0haJKEshMVAEeY6LuLic4k2PRSFp6e9OOj0=;
        b=aNttibpYXcx1cMODqwjEChH/s2BywQAaFRgjROGWYXRRsKNMix9SudvsY3DOpZgsvy
         Ib2Ia/UP80fEy8qSSt34Vai/j7cxH0HERb+B2ez85NCpSWXwhZUcm/2YEZMMdTjDvG3k
         4jwVJKKB1ROd36JjBe4DyZsM6XgGdZC1RW0Vdd4g4s7fm5fbW9gSwBJqS7DuOFh0SQo+
         o4FOdcozar43FA3zu+0zljWJnwriEvUkzUOGP86WeJ4eRZmbghLXkk4vsxbZnVg2ZF+O
         bXofw+6wxYVKWrFtz3bzkNk9tfq53QCOf19LlDqdtMW9XEQH6UeIThqCnmMYUuOeZNhQ
         xlEw==
X-Gm-Message-State: AFq9FYLIiHdzmZJa0lp61aAoFyhCPnBlpM8K8tKG+uz1aIjIQw1PHIvW
	fJjasfmGM6FM9L4zLPyLSjZOzcYJ99J0GMclhr4POPWUkEgKzgPnSQuXSfKS1A==
X-Gm-Gg: AYBFou1fup5snWfi620aWASL79ocqN7NLCIHSs0/B1VuUO+R1UVX10VlF4H2gJAMjoR
	siXXeiP8pVuEdTkBq5+dMFQ6DW66+6Ibax4OarxQrcOgZvGGDky3emB1f+r7QRfYA33pVhiA65J
	CAKUufxj8g4dr+qNiSmG9Tugc0oRiujnF5qomCYqFT7vmACs8RfEl94okI5o+JAil7HQv5x2ZQb
	EGmPwwi4Bebi/ZIrKrALHrCylQ0VBXxRzL31stYjiGIqaU4FbVlJdYsyjIDnYr+8AooI1wlORLn
	mblkEPZndPnc4BOzmc1m3eaZnPl8vvezE4zHqxbNzICg4BHZUYkp/asEKzorxIuRuOGYGUL6t3T
	YydzqvQ7E6HSzIqcwG4LdKWZrAsp61rrcBTFZl+n4eEP6vx9prGkq9vKNbHPKUDdvhDgNvLS2T2
	v/MjJZn48biCjXQAIQ62FcCHAH8rJDGpqeBytwnVMpDFYe6YTFDVUeFWREIb0V7CtO9mO9Ms0Py
	DIv+EnrpJ68sJxX04a2w+rSTfqw1yEOLrSLSXj4TKfnC7cIDjm7ODCtE8+exRw=
X-Received: by 2002:a05:701b:42cd:10b0:187:ec67:2fc5 with SMTP id a92af1059eb24-1993702567cmr12548262c88.32.1793057371043;
        Mon, 26 Oct 2026 16:29:31 -0700 (PDT)
Received: from [172.17.0.2] ([13.71.226.100])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19a3736d16fsm27352568c88.12.2026.10.26.16.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:29:30 -0700 (PDT)
Message-ID: <6adfe25a.5bfb57e8.3be28a.603b@mx.google.com>
Date: Mon, 26 Oct 2026 16:29:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3024278532952872106=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: bass: wait for PAST listener readiness
In-Reply-To: <22736ec1d4ec6288aaf4c62642c65910dba6c591.1791750393.git.pav@iki.fi>
References: <22736ec1d4ec6288aaf4c62642c65910dba6c591.1791750393.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3024278532952872106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       bass: wait for PAST listener readiness
   Pull Request: https://github.com/bluez/bluez/pull/2662
   Created:      2026-10-11 22:41:45+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============3024278532952872106==--
