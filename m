Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202B146A77
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301604; cv=none; b=iS94OQ+JnRczfpSbRGeJ7wdiSPQr++/4xovNJAjPRegsu7G3H7BBNcGASRiSZFYcM6x1tdxEf+Nuds4a3ouvT1oDd3hZzDTeuD/bj33EsDOwk5l4rwByZ+dAIv+YH3dIbf+Wdgr/LChuznHQCUFJ5886S/B8aQb6NG0hI7BY21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301604; c=relaxed/simple;
	bh=KQ+bgIYCeKBgOUkKP2xyBAw/NLvGdx/I4d0rWEKXj+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIzC1zKCKI/emherwVL1ltdtXKnu13hDsZJik+5ViZS7M3uWk4c6LEZ14dkcUVHAA2kVUq5WZ0UmIho9utJHHIhCar+gnP2/BLLxBCXRxyotT69O8znVJfxyJe8QxgsubJYujBDpyrkRnsw8AbbGDCE7YSjMrNGqoqUMvI6lA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0rsJxb7U; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0rsJxb7U"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so63030041fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719301601; x=1719906401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ+bgIYCeKBgOUkKP2xyBAw/NLvGdx/I4d0rWEKXj+8=;
        b=0rsJxb7UBpR6EOihYrq/U4qGTIBHLt+gopun2WskxiK0+S8lyYi/u9wNVkkrB1n4mh
         fgzbLQbGRG2NPvEX+HBLLtjXuvxoOyNsdl4XBK0pfzQLo6BwOJ00evtQWi6XkNmKkgTe
         CkBOCEzxWqQvH7O8cQ0aqznUUOuCDKtir7o6z4uREQp8jPm7g1x8dNKh6361p4FYu4Op
         S0nJ6YiAU68j+fufB88cgX+P1lxohz2EDA5vrjc6zQLkFAtmIs9j2f2LLjBBv5ezF7IM
         2odWDGhIGZEdra399MEIZ8/MpCKFG3Q0T+VFv8/fg5FmrVVvkSNLLuTK7ng8metpYW9g
         TKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719301601; x=1719906401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ+bgIYCeKBgOUkKP2xyBAw/NLvGdx/I4d0rWEKXj+8=;
        b=f2fGKQxy3ClXLxEbrvBYj/1Tysn1FZisayUhe1MopMOffWM4MGbebT+A41tRyjxMrN
         eJCWtk5J0DbhzsVGAqgoahc9PIyogl+17cuSXRWtxkKNiEXznz0oPoydQsczr6bQWRxc
         yEGSBxguIxbsafaAugwb3whdh4hiGZdcClT9T4UGtZZ1GvKG0/AcbUh2dPLK/7ZHhfzy
         7R1WnO67BaIbFw/8frTFy124yYNp+c99jcsppplRID9lHR5+W8e5dfmN9UfmI8pUau3Q
         8CRq6HLjrkW47Cj7tSQFZhiV8clVyr00umim5vb6pyHjfafGy4+8B108wwCJaTrbGUCX
         cLZg==
X-Forwarded-Encrypted: i=1; AJvYcCW+EChTOkYa9yGJxAgxXVtjdPYrv5Of1eSwvq1iUDiCAlCnXS7G2dUHAA92vg60B9ynih8fvdvkc4rIaUBPaCcuP8UL/aKOhd2hxVry66yq
X-Gm-Message-State: AOJu0YwrojgEomPi2RDlmsa+MHpK5RzEf1jccs1cjoHT1mtGlunR5Gyx
	3SuKqiXLkxgzNk+34iFxtxtL0RRgGQMEgaZhojckHjrf7367TaLXd8TEjNKQy3vgtzx56fKJPgU
	gi3UpRdTtZ3jqEkOB+LtPDrtlgZXoTKgh2taIG1Z5Q1ND37CY
X-Google-Smtp-Source: AGHT+IG6PgHGYuAX1AUyV5EN7lc8tN5mHh/JuzzOgzPg5xDcTQ/uVLhTBQ3XbjpqG/bv4wQ2T+6h8Bru5fI5/SHFG0U=
X-Received: by 2002:a05:651c:154b:b0:2ec:61b5:2162 with SMTP id
 38308e7fff4ca-2ec61b521d6mr35790581fa.25.1719301600609; Tue, 25 Jun 2024
 00:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl> <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
 <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com> <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com>
In-Reply-To: <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Jun 2024 09:46:29 +0200
Message-ID: <CAMRc=McZ+hrXyNESmf4pFX9+uDnc4AKsuO9X8AJsVgCfQVLd9Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:20=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> >
> > Neither of these has clocks that need to be driven by linux. The only
> > user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't exist
> > before so no commitment was ever made.
>
> This might make some laptop users unhappy.

Like I said: without upstreamed DT bindings, we have never made any
commitment about the device properties. I doubt anyone will complain
though, I haven't seen any DT with QCA6390 with clock properties yet.
I wouldn't stress it for now.

Bart
