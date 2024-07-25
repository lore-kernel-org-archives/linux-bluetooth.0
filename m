Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FA84D8A3
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939742; cv=none; b=RTVxoD45X4J17J4PHh+PKWZRz2iAFth6rb16Cw5OOvWmUmHFMWIOkgc4jtxvak9jgqICyDi8QyuCK7HxI7NW5Mus8HiuoahMevwwHF9c9eWDEPUBB6+f/w19g9JjQlIbHvLv27XTRqLfNEy+Hm1yO20lP6hB/WxhvoZrGt+CY5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939742; c=relaxed/simple;
	bh=YtMySxkyLmF4BEpR7uyWE/39aC2i8iMpKpQV7jBsECU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRjVH8aLRGU535kulYqtRp8s28+kPa1aiNNyidJUb2oGf2DMdJWg0SGjGgN42R/qIdeBbDNQMMiol7yVbDdvGp57ep7jD4AL/e3btWZZAq9AVYVFu/FsVFBlU/LqVRZCcPrJeCwdjk097tEP64od3mH4wbkekOOpEIFuCmqT3+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gL+pDYtZ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL+pDYtZ"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f035ae0ff1so5150421fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721939739; x=1722544539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtMySxkyLmF4BEpR7uyWE/39aC2i8iMpKpQV7jBsECU=;
        b=gL+pDYtZUXY9r4OQN0iBVcgEhDSXZ3+iRJR9W+ySKd/pmdT41Fc+MkQ7Lnx7kwB3xn
         w71zCkIRAnR9GDa7UEs2GbdR8WJlrM6NGzEUTTtbGaIC0wtCLY+3ogz7NPO/1si+PNWE
         pq6uzLO3EbYaIFBSiRkzjBSXZKjYNO2n+HTFKBz5yeGUBhVtkPz89JOWF/Du1wYZohzJ
         q33TVtybccekvhmJ11jABglXQV7M5VQCGZmWxh8fbK1WGP+y1M8Rr882JdiWvN4VJYjN
         cPW88LwNSSY6gVCxfcPLvvDpDfLfRZ6G0pT0c5mxcyUZbFrIL6bUSX9/C0MLR6sdsICq
         LV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721939739; x=1722544539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtMySxkyLmF4BEpR7uyWE/39aC2i8iMpKpQV7jBsECU=;
        b=HWIa3g8LeC9YZ3J5VI+I+x1r6T+gbV/G+xr/gVkMKy7+4yzr84ZKUvUo1l+QlFcpE2
         RTzUBL/TBSElqPgEDsM2PvYlQqnSOqMzDzU9jOXebyXBTh14SNMmqPCu3hIocdFuAU95
         Ej/eQWVH3LSizCGQl9ZWE6eFgx4/dWLcbrBwsf0IQPiwrYEv7abc2NdWEVgLzVsOQ/3O
         ZKqU5V2ItLL6y9ZCV5F17de9KKo569WIhz05NAGUSpylCB4vDBhFiB1nv7DMpMJXMgGt
         Na9v7m9AxibQe+J/demmUkkTr8cczAY/lcZMmI6eJokD9uLem+QAgHhgxyLQvbVFRhaT
         u/YA==
X-Gm-Message-State: AOJu0YxULQa1ld/FaH5cj7amZkZAfPJqyeIj79p4pGrHjj5CtG2G9eBX
	kQG8D1RCMjGej7bhr6aUkvCTB/yllCSp/89Rq7DmRmewBpcBoK2J4VCEvpYSgTxbQi3bUyCwfOW
	SSCdXlm2Ksh9BmW0ROZTHLs9sC5QHgf7L
X-Google-Smtp-Source: AGHT+IG8JtXgHgktqZBtjeqC/c1eHDVr+xUqd7DDDGVLKEFzTl/8LsV59gsbwjwC9bNokIBbNGP/DEljSesCcPq8b48=
X-Received: by 2002:a2e:8612:0:b0:2ee:7c35:d892 with SMTP id
 38308e7fff4ca-2f03ac4076emr11760281fa.17.1721939738941; Thu, 25 Jul 2024
 13:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org>
In-Reply-To: <27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 25 Jul 2024 16:35:26 -0400
Message-ID: <CABBYNZ+vVFUm1Tb+BvViYMJd6XQczTYPgyO++GGbCcWrkaC4Kg@mail.gmail.com>
Subject: Re: QCA6390 broken in current kernel
To: Wren Turkal <wt@penguintechs.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wren,

On Thu, Jul 25, 2024 at 2:35=E2=80=AFPM Wren Turkal <wt@penguintechs.org> w=
rote:
>
> Hello BT folks,
>
> Just so y'all know, the QCA6390 bluetooth hardware appears to be broken
> at least since commit 720261cfc732.
>
> The KDE and Gnome bluetooth control panels appear to think there is no
> bluetooth hardware. Rolling back to 6.10 appear to function.
>
> I have a Dell XPS13 9310.
>
> I will attempt to capture some kernel logs in a bit.

git show 720261cfc732
fatal: ambiguous argument '720261cfc732': unknown revision or path not
in the working tree.

--=20
Luiz Augusto von Dentz
