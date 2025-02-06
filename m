Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F102922258B
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Feb 2025 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738877698; cv=none; b=pbgtAbEcdfGPgzPESg3Av+WVO/fLK8erdiEtiEwAvLj7ahI+0sk50TQr9SOrpWc/QsvKXY0qls3nA4dFQGQNiEuHYY7YLvmSAxUStJj06s/bffzMNj66ND8Wo8iozVek+1l2epSlbLctFnXxdBd7fnTICoX8DC7LXek46lhCqXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738877698; c=relaxed/simple;
	bh=syVSSRgjaasTjgZ7anZrx7r8KywGBan56461AHUzL/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ow3o7Ciepq47qa33u8/cBhWtJ7eKtdFfSVorRrYrkwxW4NSflCeYuHovJIWEuPXQUZQ+ffw6j3cuvs9lCRxidHVdUr6CNklmqfs6lX5rzBsp5aqU+cLUVGoP3HnbTJwRqB/FAr95UFSU4aWumU+wlsnVOn4iIxr3eY/iZOlqCRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=AmnnCLWe; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="AmnnCLWe"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-543cc81ddebso1626954e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Feb 2025 13:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1738877694; x=1739482494; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AVzmrN4WDzwJvosdHTHncOGAyyEILmW17oHtkC76N0w=;
        b=AmnnCLWe60VLKMPbH3twGyZSkefM03j9SYmmOSB4qFKukW/RgAKnzYeeU1zKqf/191
         ePMktVlfQWdvaQJDO8sCffT0xcHDcDLvacNhPY+9ZUhJZdJHCFbMqFbta/ikRWAb2c09
         yLKaQ2VISJZ3KLHFaUMr27WTgQEBmn4TDVNs7TceSX2A9UN6furypE8L6uqqNwKyfrVV
         DlD7vt7cFn1rATxAUL29SJskIuDDsoYiGzW3OV/cTv6pIBZLzRpr7UAJVAoas/CVUbAi
         kq2t4XpAfSfA7sdBLmf4NA1UQrF9nacUWs9gLi+tLYh0eA5t2nuOOH8UgNJEXnVOtxyp
         j1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738877694; x=1739482494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVzmrN4WDzwJvosdHTHncOGAyyEILmW17oHtkC76N0w=;
        b=eiFa9IbZ4sH5WzNOGRQfrvoTzjapvSxd8ipR8N2iGZkG2bdNe/tSVDh//dvfZOhslw
         o07HLXiuAje+M1BpUK/S4wxmJDcNotCf6CmdSCHQGb6vFOYHbj91Fe+tizMb0HmvzY2O
         Ab/xrw2TXSxoYJ4i9OfsGcKcsqm/fPJv4zsQwoS6/G+51fwYtWbWQ2r7a/d5XXl3Oqu1
         aaOiy4A9biNLJTmytgAY1eI0p6cZprkElQoIw9hnwwQl5TMbUv2U7QXkuSjs0CeQPyrY
         FkYpT/LJ2W9Rl/Xo27YHWzlSRHLUkZxufudAr7CjhR7HObrFe0BGKM/g5AcHcsq/HeeS
         IZhw==
X-Gm-Message-State: AOJu0Yym1w/JpPPlHkJ+fwiFBPtgNLnd62XYdI8hMgjMyXlaqO0MuTQB
	p53viHeaVVM2U/0ZoUbYT73R7AK7OJdjZmHMH95MSrXVa6qw449L8xvy5ru20WoVD8xRfdJ3Hqu
	fbBzmf4q/4IbiPQkMRNI8NXowm+omyV/zYu0vwLh4ggP4PbNp
X-Gm-Gg: ASbGncvVp0EIbdqt985h9XIv95/vaSPHhhr3kpLXhu+vyenrprTyNVnRuWz6LJ6mceK
	tl3sVdQs8J/v59Y4YbtMyKOBCUf1WHtlq/xpGkmrBkN/c6UazUA5bPaxjUk2NFrtdUmR8xmY=
X-Google-Smtp-Source: AGHT+IHPSAo1RlSd/eCWEX36nzVAqv48ADreBHrUpv1l8s6xW93f6QRDYWRHUm0zaQHy4GYxhWv4tsK10LjmzPK/ZoM=
X-Received: by 2002:a05:6512:70a:b0:544:1214:8b79 with SMTP id
 2adb3069b0e04-54414ae0d9dmr108545e87.34.1738877693781; Thu, 06 Feb 2025
 13:34:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206132548.363559-1-sanchayan@asymptotic.io> <20250206132548.363559-2-sanchayan@asymptotic.io>
In-Reply-To: <20250206132548.363559-2-sanchayan@asymptotic.io>
From: Arun Raghavan <arun@asymptotic.io>
Date: Thu, 6 Feb 2025 16:34:18 -0500
X-Gm-Features: AWEUYZl1vRhMYzA6v-QLcKIipi-YVHerhdLcq4q-1X7zV8jJB2zvz7_yzjw6LP8
Message-ID: <CAN03qa9Kv=T=LRzuSZ0PyLXrSRciUNuStmxVDvLh8PFKz0UA5A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/1] shared/asha: Add support for other side update
To: Sanchayan Maity <sanchayan@asymptotic.io>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Feb 2025 at 08:25, Sanchayan Maity <sanchayan@asymptotic.io> wrote:
>
> ASHA specification requires that the status of the other side be
> communicated with the start command. The status is also updated
> if one of the device in the pair is connected/disconnected after
> the other.
> ---
>  src/shared/asha.c | 170 +++++++++++++++++++++++++++++++++++++++++++++-
>  src/shared/asha.h |   6 ++
>  2 files changed, 173 insertions(+), 3 deletions(-)

Acked-by: Arun Raghavan <arun@asymptotic.io>

Cheers,
Arun
