Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6067916DEA8
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109962; cv=none; b=sDa35SnlCm+kvG8xRKuerZXFtS9laSF7qfJnfxa0X5p8JHL8hmKk0WdN68Z6Wt5ATFLEPrWS16ZNXMY2CJWsHbp/vq0BX+ECim+n0BvRlJ0pnA6u92EZDGM7w8TEu3Dqnwe/RgJpwcE/M2P5G4A6SnxX/tkcHXpFUKK35h4j/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109962; c=relaxed/simple;
	bh=JZEDr1P1ISIbIel3iXeTZo509y7m/m/f70iEKi3ERRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgjGvTjtM1OObQcNIIMxbFeSBCWWgSRo00kTG0bWgEdz5coNXZLpNVbODvo1jgeHHUVJvcSN/g56lv7WN6vN4O1tU2rNJB7iX+TcRCMCJ2tuuxDsnx3y5vZ7G50cM5SYnMU2YLY6udVOg9FXhZnQx69wU+lUGUo8cgMgEP8xVfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1FPGSO+; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1FPGSO+"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e0a0cc5e83so41310811fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2024 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715109959; x=1715714759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZEDr1P1ISIbIel3iXeTZo509y7m/m/f70iEKi3ERRU=;
        b=e1FPGSO+bMaA5c+9ls2yhdtybA6s4cyzgwIdKbZJhC49dzY6GzCfPEdUv9r5AHwAA9
         U1LNETOcqTBotch+/IUJojk+kZEhSocJLMDfveYkc9XJlWLBJDIiiX1WWXATToW2Puzq
         mkJ7saJUU0twUduPeLdPY+7Ed8e80RazA3dCx5/YvrFUQOC9bh0lYXGvEQ/rCdVKIknU
         21YtxpNVcvcf3csSHfpeENxWLcl7uBkI/82O5SjTSjxNp4CjXShXEjmGxJo7ARQ2fD6N
         MIs1H04MpuqYlRTrxNuy36Vl74Zb6W7p3XeEupKOyk6W116HRPO/ID0x0IZY0V8gSHjK
         Ca6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715109959; x=1715714759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZEDr1P1ISIbIel3iXeTZo509y7m/m/f70iEKi3ERRU=;
        b=XrfAf4jYNiLAkGOnAAbYV8HHl1x7ym+qBwzQxrUOBsIWvD82OajbTYXkKR/lc6mdQu
         2sjPur/0PHLsqIxyStQQ7tph3Ks8vpXTCuSvKENzdh+xk+ocLXdI2zHaS5f1vgLUW0Um
         kmBIvN9wn2kJa8A/gdd44yo0kO6NAftoaSOVg8EzJYrH4i8IkEtpU40G4FbnIGbrF3r9
         91wKxM+IcwB8MBXcDIByTnwOhBDdQdyIjBU2B7/z8ui5P5+BTBaW028uV/spYvQdMWfr
         LpRVzM32eZWH18o5IPYSJT3EJJqU09r+kkWXlkKOLBjFeWLRYgOBB+Y/yPXW1rj9Q1ax
         WoCA==
X-Gm-Message-State: AOJu0Yza56MQlEfLGvQ7MVrVqATcZeEflI5pbn+CS6ZSYdxEA7zbGaeO
	qQ/UFPbr0F3Tj9ZGKZPcYpY0iNuYh4lN7uSkBPYuJP/xBcBJeDiS8ZNY0JBZbfZKD/eiT//cGdk
	wIBQA/GFwGMJDiF8ZXWUyhnEpLAUuDQ==
X-Google-Smtp-Source: AGHT+IHE8rKRM+gyTGI5rI3bP5LsGq9ijBCmgLgDoY7mXgJeq+jnbf9zhqeHf+NTmskqyXH6D4TlKgRcPxqMbiujooE=
X-Received: by 2002:a05:651c:617:b0:2e2:be7a:e497 with SMTP id
 38308e7fff4ca-2e447cac611mr2316081fa.49.1715109958550; Tue, 07 May 2024
 12:25:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507143639.539863-1-luiz.dentz@gmail.com> <663a497d.050a0220.99cab.8529@mx.google.com>
In-Reply-To: <663a497d.050a0220.99cab.8529@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 May 2024 15:25:46 -0400
Message-ID: <CABBYNZJ8NDv64Unsa=-j_RJhpCGBBtJf9Vvn2Fq9Vvc9OsHmwg@mail.gmail.com>
Subject: Re: [v2] Bluetooth: HCI: Remove HCI_AMP support
To: linux-bluetooth@vger.kernel.org
Cc: Sungwoo Kim <iam@sung-woo.kim>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sungwoo,

On Tue, May 7, 2024 at 11:32=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D851=
233

Can you try reproducing the problem with the above change?
