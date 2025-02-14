Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A4E2690DA
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555986; cv=none; b=iuhna51a/7QUwiS9Q//IRamHc8kyFm8fM32sQ8q9W0LiQfv0SBzwRVXeiEU/m7S/tU4D1LtEi+b1OJjiCpdC541fmBIAjmfUrNHImmEmJLFzj5qt8HqP+0vDrvzRpXJk5NMuNJbCZ+LG47dRHFjW21dcI+s1WNbqTlcWvZTKSLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555986; c=relaxed/simple;
	bh=rmWNiCnkNRyaFycyRUk0tB+Ckuoz+9p3l5DJh5PH5sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qwIGbfu5QwAPlOcqxEyuQmaOsC3wT2S0un/f0KZX0dqmcOvnloYBH0/xhJwNJvADpx0dXeHsxHkEoI4fs89cB5Nysma58VwYOMuhVeSYMEgxlsKAHY0wpB/DRctHqIEvl0GUiz09cMhA21AM8aT0W0dXdbBoB4jwQit1+pB5LTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDEnniIR; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDEnniIR"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e479e529ebcso1798669276.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 09:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739555984; x=1740160784; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rmWNiCnkNRyaFycyRUk0tB+Ckuoz+9p3l5DJh5PH5sU=;
        b=TDEnniIRf8bDVde+W0ZgZybG5XTMbT12SeogNO74ANsqNkye4LKED1a56YGfntykPM
         +WcbZyCXvB7xkA+c8ojG3Qe/C8WPZA3LPVsaXzL8rJrOmwGwYlbUrmUbFQTOEYGfc88f
         rj+u5jpKwHIpI4Ll0Y+dvGZ0FbtIoZFOMYP6v6q/af8jxt6EG53KIRFm/zcj7eSpbrZ4
         VQ6A+Aol3EysdoiSk6ZiM7Ftpg5g5k9vOBReDlv6UItUQjvuaNxy+rE5iSvudbChiO8m
         L7qVV+vEJ6KrcEkY7sm9FqT7M+Oc2DQKyqFradnCNTsHJsNIW1SGG/iP/bY3k29U8VuY
         m2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555984; x=1740160784;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmWNiCnkNRyaFycyRUk0tB+Ckuoz+9p3l5DJh5PH5sU=;
        b=rYojF909FeTBaCqVklQhL71ugwsAEZHJY/6Es6XUJMEbL/84TgeyD9EpLzsNdCuRTl
         TC2wISeO0Bttn4aKUWbgCQxdn2KvrndRrNh0uW5Hi7AP/DxXzs+5iV9jkfP2qCW0PRaJ
         8QIuk6EvnCxHQS+Y6dqJK5mKwyDL7emxoj+3OGJ27wqpmYOeVRpHnOZxhC5trNrmXn3R
         tYq7Q5txmkp/J9R2vpVJBEU3bci5ayB51DhMnuJd3HGSxcUI7Oj+Zwv2rYyCDt9/AJMu
         YhVNVyALSyW+w4/XiCx6xGxh1x7kVOgNj1CModLoOUhNowk7hMSGP2zMNkztkmHbThqe
         4E9g==
X-Gm-Message-State: AOJu0YxuxjVKR0w1v6yOoKBsgHYp59ZAH9uGSNZ5Dsg3Yt9ybavj2tCf
	TWFxTDit/ZZE3RTR0LJLkBOF+MVo7hUiuNotOFGKbOG+e57ybYoIx6BkkSfkvDGuotQZFVbxqEv
	rBWWhAtSOYLTxGSh1hv30mTw0dp5fVzQL
X-Gm-Gg: ASbGncu3pojO9XXPnRGmFQlmjuZ6BXkBIaaa0QmEtaDSEtC+8iOAxcs68cp2RNjvZYg
	kUNBMF42pct7U3gu/NqfYYkfo0PVX+GbIquywbG56pFD3jgwBvAlEsxEL3P+7uHD179/4QgrY3A
	==
X-Google-Smtp-Source: AGHT+IEGqL0AP8Gd0xT6Vv3M0I/e/XkNbW0Qgsnj3JyQMnx+EXE4JkoTelJEz3yQwEc5977hOJ66MTd3t5JUYKg5vu8=
X-Received: by 2002:a05:6902:1285:b0:e5d:bc63:dbbf with SMTP id
 3f1490d57ef6-e5dc93207c5mr252229276.43.1739555984408; Fri, 14 Feb 2025
 09:59:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214153711.887794-1-luiz.dentz@gmail.com> <67af70df.630a0220.120429.66a7@mx.google.com>
 <CABBYNZJqkSkG+1oNhn4_Gff_YzCLDbF-Qbo-UBvu_pYpqMEaWw@mail.gmail.com>
In-Reply-To: <CABBYNZJqkSkG+1oNhn4_Gff_YzCLDbF-Qbo-UBvu_pYpqMEaWw@mail.gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Fri, 14 Feb 2025 18:59:33 +0100
X-Gm-Features: AWEUYZmXQQlOahHynkt_fIrUMOUPK4cNxljiVB_EutU_GlpYrpPNxZseTmeN9y0
Message-ID: <CAGFh024t1q8DRN9hDPfygKkupGmSt1n7EZFrdEskpjwTmkN+TQ@mail.gmail.com>
Subject: Re: [v1] Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Looks like these errors are due to fa4d477ab535 ("btdev: Broadcast
> EXT_ADV packets based on its interval"), if I revert it passes all
> tests, so something is not quite right with it or we need to fix
> iso-tester. It seems you remove scan_ext_adv from
> cmd_set_ext_scan_enable_complete, I suspect that is the reason since
> it probably no longer pickup things immediately which makes a lot of
> tests very slow.

Hmm... OK, I'll look at it over the weekend and I will try to fix it.
Maybe I will have more luck with setting up a proper testing setup
this time.

Anyway, It's strange that this was not caught by the CI:
https://marc.info/?l=linux-bluetooth&m=173945291115583&w=2
