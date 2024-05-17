Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4148433A6
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715971199; cv=none; b=SMu8+llen+l85eXZTO62lb6IcVL6PWwLhcNz+gLLSMati32ok2MWGHbJ5ucFZYkwNPanhr9wpISl+WBZ9wcoNZGAsoyba994SpHTCxH/Jd8Lhj2/HBIFP/Wmql3x22uj+hHuu4yYW6Ay2M7EyIRN9hJN73srikM0WtR8jx1AuEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715971199; c=relaxed/simple;
	bh=JlAeTKD0+EV/EwvTZfncjcpuXgOagKQREc6m+G6rqqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i71MrKE2CJflc+/qhppnmajdWorh3kAEdOx+0jRVk9TgsUYHXsdGDv+vGConHE4VPEDbscUNxEILlrgnbdjmg9egzUTSBiJIaNkJ18Eg2DgaFlb5nkdgTHZObnnIv3N09Fny2fq73WiyRJ+WgZ66RUko/9RKwVTC0PW0Be+/yTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=G13nnSmn; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="G13nnSmn"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5231efd80f2so2502768e87.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715971195; x=1716575995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JlAeTKD0+EV/EwvTZfncjcpuXgOagKQREc6m+G6rqqM=;
        b=G13nnSmnSkwbKS2EbfPTmGAsXr+M0hG65FuP951x850QOLimEUoqcwuVZEu8AUq6Hc
         IMlkp5mEg4SdC6GzLO0vKXYXKGbd1z43jHES7bjvINp+LSY9Ex2IYcjO2t+avTXuac2q
         cQb2i6kZxQHJlb8Bl7sjDhAin6yRZJ2jvpIv3fU7z/867kV0oUXl72rWxsGeXtGgGe4t
         56dJm6L3o9Ki+dtFXaI8ljSJegtw2a8670pDPdbU2aj3sPJfGOR5YR5s3g14JR/4n9ED
         BnG4tAicwljBaIFfVWSRhk8UMdoKJ/8cj+406Js/smgFdbPWyCJ3Z8RjI5Sx9cH5DmOq
         VmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715971195; x=1716575995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlAeTKD0+EV/EwvTZfncjcpuXgOagKQREc6m+G6rqqM=;
        b=amN38dSVd5IuWdFKGvxs36nRA3cMYOuuvGI9Wz7C1vGVrYKv6m6bBNlOs6ZKumB2O0
         A6ACwYXAhp/m9iW2Zv4n3XU8z3TNfT6prtsj/Guz38gQ31C1frdoWSGHekJheZVGYgKp
         v45s/OUsE8C2sGDUekDJlga9JH6DkyIIia/sJrTGuqojKK1yM4gU7WoSWPUJ8wR6hv6V
         OGSPoLkqaf4jmRGi+7xFRlUOileCTHxzk4AEZcM0DduHmUS0fe35/pAad1QWMzkUBDeY
         u4kvE07jeEm/NsxFgfxcKozfkWDwsC02QDgq5fAy3HxWAxx4P84KQRjppBotmJDgTe35
         hOBA==
X-Gm-Message-State: AOJu0YyogDpwpzU+z1h/NURungHqqz/eNaoSTUkSeilCu7A2Y3iXY6YL
	DlQDsACahuz3tRt72TXq+Pz/mMisyj5V3VzP5XBeQkSTfS6MaY/2Qawha2ZsWS6nhPpTMwy6mU+
	1kt2E79fzFzI2JWRazCA8Ec8yR3h/8zrgQgdytr6iZLr8LDO5/Ss=
X-Google-Smtp-Source: AGHT+IHtk3tTDzN3O2CuhiolSywAEN/Va/Ob7EOnF1A5gERCMC5uQwHokw5d6Oph9jWHtwYaxfg5A8LBhrXAXuUO62k=
X-Received: by 2002:ac2:59cf:0:b0:523:88e9:9cd2 with SMTP id
 2adb3069b0e04-52388e99ddemr5736624e87.67.1715971194832; Fri, 17 May 2024
 11:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516193836.228281-1-arun@asymptotic.io> <20240516193836.228281-2-arun@asymptotic.io>
 <CABBYNZLriw3OMX_oNA84FohCp20i0zeskZn9MZGOD5qg=EaPEg@mail.gmail.com>
In-Reply-To: <CABBYNZLriw3OMX_oNA84FohCp20i0zeskZn9MZGOD5qg=EaPEg@mail.gmail.com>
From: Arun Raghavan <arun@asymptotic.io>
Date: Fri, 17 May 2024 14:39:19 -0400
Message-ID: <CAN03qa_TgFEA7hCXKH1JfUMCBkotqLHkrX=W1+p-UvakRGiv7Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ,v6 1/5] src/shared: Add initial implementation for
 an ASHA profile
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey Luiz,

On Fri, 17 May 2024 at 10:23, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
[...]
> This is not quite right, we can't depend on libbluetooth since that is
> GPL also both adapter.h and device.h, or any header that adds btd_
> APIs, are probably only meant for use in bluetoothd internals, usually
> that means that the connection setup, socket handling etc, needs to be
> done at the plugin side and then attached to the bt_asha instance as a
> pure file descriptor then you can manage it via io handling.

I'm not sure I follow how the code is meant to be structured. Is there
any documentation or something I can read up on?

As I understand it, you're saying anything that relies on btd_* calls
should be inside profiles/audio/..., and not in src/shared/...

In this case, all the GATT bits will need to move back to
profiles/audio/asha.c, and there's not much left in src/shared/asha.c
that would be useful, which would leave things similar to v1, where
everything was in profiles/audio/

Cheers,
Arun
