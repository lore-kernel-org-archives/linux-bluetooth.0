Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B6713C90F
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221291; cv=none; b=mcDXJRp5QIjcL0QHlx8voyV2GaYhZ3piiHp9ZI+AMZ4UjeCrs0pSt4ueBxu/sfFjnWFnbIzuSjzqOlrt1GeJ7d7EJnYPDPpqC5sloqFJAIpVV/AoE6q4on065IsDRO7E+Z2blegFjYWmdq/mUxxsERYZPd2QqmcoUDvC15qMyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221291; c=relaxed/simple;
	bh=hj9lbXixfIAJtFsvA7d2DmxpeHDj3+fnKENrmJXAcU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwNS1U1T5/dRq1+SK+CmqxBW4MYZNPr0t7uNbqYKJbi9NnAMYatl9IkgS2/g6rJ+iO7LMEWxKaYCOHpp6RlDKmZqBIeUJGegBHheYnJftd6f+OJIjCrVen8TPITlciyApCtxMrpKxhYLqOdy6aAzTrZmonVocghCfBwYMz+JQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=mofRGMPM; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="mofRGMPM"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f57713684so394828e87.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 19:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715221288; x=1715826088; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hj9lbXixfIAJtFsvA7d2DmxpeHDj3+fnKENrmJXAcU4=;
        b=mofRGMPMkOGEZE411WxiPwKAUsnRri1upl+JBDaNjBcJl1Lo1R+PSwLDHECMr9ozMX
         GfpQCUipWjsCcffWpXY0UD3hpaZAvG9MIb4a6k7WN1XLxR03ELASJc1r6tU/O6/0azCq
         Vlki3CL3Ek0wrocKf+brVb9j9+wd4qcZUoomUxVliVdUqGuudNXxBMgqRQKlpTRciz4o
         0+XxTCo4YKIf4zimhrPLseEF3qwpe2zz6D3IQL2wxBl2BohSbI9wTGTmTZeSFMRhHLQf
         xSDmDVwqept2Gn7iYQNw5anZ9YEonqDCcBTVSkDQbxZHDXS3qGWYfw+KCPQ5iGoayxs3
         3hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715221288; x=1715826088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hj9lbXixfIAJtFsvA7d2DmxpeHDj3+fnKENrmJXAcU4=;
        b=hFCoZAU+KC5TSokam0JOIdA0ahhoi9dQplrJ9JDk0HxmROHAJdrpuLdgz/CakLwPW5
         uVjjWBxUl70hDOETovRxN/KjPcb4iSp1nkXYjtLpWbCWBiZXGWPeWQeYyMfpN/bEZTzY
         TuoWRU9txPiWeq7DJLTiJ8mwB12UEuwazEQidteraFL8RgwLJ4BRNFfAzBFk3KITyket
         owgSppilllIvJHQi5lO49QeMYWQaQwFUTRdaVOwTcdWYjGbQhajJC6ap8sUN51p9r7Aa
         KXTQTbIaOR9G+hP5vnIfx/0kjkFLD3o5yQGRF8kwv3HEMxq05+0HTn9ubyHJhL/ajXwA
         N7jA==
X-Gm-Message-State: AOJu0Yxi72Q0K2iM9tkJIuh9HKiDbUUgU+nK5uoZS06NLkMuCS7aTmVd
	/ZDXL5v0Nmtc/Mf21EAumCutSupiu+7bVC49xcRc65Tf62DWSdexcVF0/jYj8wXrf2IFtifjjbT
	Low7wmwn+sO1JS0KPWuaBM7dnLZy5YErwfh4fXA==
X-Google-Smtp-Source: AGHT+IGYsH6JLqdkFqWG+kSQuBoWV5Q/T/NQZSCh0oIGxRUuzx8eD+1UqTL97z3JHM8p7uHareAG9v5nVJmrOlcWLLw=
X-Received: by 2002:a19:5f5e:0:b0:51d:abb3:d701 with SMTP id
 2adb3069b0e04-5217c276f12mr2389994e87.5.1715221287642; Wed, 08 May 2024
 19:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508154604.276763-1-arun@asymptotic.io> <20240508154604.276763-4-arun@asymptotic.io>
 <CABBYNZKzCe-c-JivKC5gT0P0ZKGwXX9DQeEeZmeDvQS3CpyNTw@mail.gmail.com>
In-Reply-To: <CABBYNZKzCe-c-JivKC5gT0P0ZKGwXX9DQeEeZmeDvQS3CpyNTw@mail.gmail.com>
From: Arun Raghavan <arun@asymptotic.io>
Date: Wed, 8 May 2024 22:20:51 -0400
Message-ID: <CAN03qa85aUiPMrN-eQ-N1ktoWALDba2qcnW4V3NbvMzhNZ4Krw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/5] test: Add a script to test ASHA
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 May 2024 at 12:34, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
[...]
> While I don't mind having a python example I think we are much better
> of adding such support in bluetoothctl, most should already work with
> transport submenu but perhaps we want to add support for gstreamer
> pipeline instead of just a file which would be useful for creating
> A2DP sbc and BAP lc3 streams.

Makes sense, I can take a look at this, but if possible I'd like to
punt this till I get the end-to-end flow working with the PipeWire
BlueZ modules.

Cheers,
Arun
