Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D69E111BD
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480782; cv=none; b=bxB3V5DRdvCA7crxk8syEDgeGF3eOyUldh+kif1rCAdrl+EyvyHEGtfdifh3HNVRmLHrKU7S5QzK+RHeKXs0X1RmmZz0wxLnGYHtaDECnwH58Th168GT5DRUkPFoy9ON/T7auZYqZ1d3S8EbnwkiXMjoZQyWR1bzyPJB78wTTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480782; c=relaxed/simple;
	bh=ayfLP2wL2uQNK/PNSUeCthQGxI7VLeoTLz0rJyiTwnM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=OVFZ/JVZ5nL3eSr7/OqB3MlLE90rweN4pevHBy8nORlKJanwMW0ETZNQfvkqFFznj3zuiihPBZo2NWPHj+nTlOVjgdJelRGSpa98VTOIeddFW4h8j9EO+cZGLQsbe4cuA+A4rAlFV3sWsd3PQJLZNxcHn9XvKGwHgZNkLKhABZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzBt9JHf; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzBt9JHf"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e54d40cca2so82368117b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 00:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705480780; x=1706085580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ayfLP2wL2uQNK/PNSUeCthQGxI7VLeoTLz0rJyiTwnM=;
        b=CzBt9JHfE8fjptn45Y8K1ZNssnhEPHqiX55lbHGv1Fs7YxlnU/QBXbfbMcNJC59dZg
         EnLkj0IMvn9zvMt3N2T3Q1DiwmigrfoYlTga7g0UVHrky4cWrDE6+h5qlh0PWkID/TkW
         H88d8LR1GTZUFVy1UWt/U7W//e4IL+3wPSrgcL+btD6MjFLE5gbB161gTBmPUGgYnyhE
         OrpUEsHudPxg/Dx9rBHO2em0ixfXgwEIaUm/y4KYgDutXcZt2CwKyADpnqhvC1FZIdS1
         wPjOXXVmxXsHl7q2nILAEzuf/11ZwRp2uckYwLBYe7i61yeIKzwmQuAPzLPuNRlhX6Dl
         HE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705480780; x=1706085580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayfLP2wL2uQNK/PNSUeCthQGxI7VLeoTLz0rJyiTwnM=;
        b=aZcLWP9T11FCA3KogflMagQzDzNJheG0Y4RFlIaPY1IPDdsO1flGbauOAjNJjhLP1i
         DbKvny+/eDdodh17DOGF5hFPTNrjVSWXvdnQqXIV5xAjeGdQgK+gsdv1jkXKYHYWw9I4
         EY6DxMRLNYbImmH/lS4rZCYOgfSz0sbkfhFgnGQJpYw3WQxZy8HRxkx5tNZDhajXsHkU
         b/178txKAU8keQXy2cZcXqRlatF/Q0oA93uvahYkmDu3TjcuYOWICsBdbxK9xDs0CFUk
         356xyNASZJ7Xva9KE8VpNI0s0G65JaZSk5BbaXaU9SdETsv6x6frVDX2sZucSc0BgDiT
         FCHw==
X-Gm-Message-State: AOJu0Yx9UKdqptT9CoNq2IHEmq/H0vKbjXZkL4W78nZ5jk+EnqyeamE1
	dqmPRgPfucdreXVbVKdLfMytcRH/UIk4BBtlOOPqTLsKXT98pQ==
X-Google-Smtp-Source: AGHT+IGoAE+v4cP8Mt0xa6/yXsrSq5QPLtgy/DNf1ORECpZYJc7dY+aQaPWa3ATIUNt7Stn09SnPLToAwrlNNUbn+k8=
X-Received: by 2002:a0d:df54:0:b0:5ff:4bfa:d74c with SMTP id
 i81-20020a0ddf54000000b005ff4bfad74cmr1703625ywe.6.1705480780472; Wed, 17 Jan
 2024 00:39:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com> <20240116-autofoo-v1-4-626f6b54bd06@gmail.com>
 <CABBYNZJUhmVUNGTsqspc3S802pDwikFf2YOPupESD1m5T-GsJw@mail.gmail.com>
In-Reply-To: <CABBYNZJUhmVUNGTsqspc3S802pDwikFf2YOPupESD1m5T-GsJw@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 17 Jan 2024 08:39:28 +0000
Message-ID: <CACvgo505kkEr+SZV587XCGoaFKYo=17zgbvHLrv=UJLp5JRLiQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 04/10] build: remove dummy {conf,state}{dir,_DATA}
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jan 2024 at 18:40, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:

>
> This one seems to be causing some build regression, when trying to
> apply it breaks the builds.
>

Thanks for the quick feedback Luiz.

Would be happy to help but need some details:
 - configure options used
 - autoconf, make, gcc(?) version
 - the error log

I did run all my patches through `git rebase -x "./bootstrap-config &&
make -j8 distcheck" origin/master` so any regressions are alarming.

OOC: Where is the code for the test bot that reports on the ML? I've
noticed that it flagged some unrelated issues [1], while not honouring
the "Reply-to:" header.

Thanks
Emil

[1] https://lore.kernel.org/linux-bluetooth/65a6a3a4.170a0220.86c5e.e719@mx.google.com/T/#m21808760ae29dae03e415e67c47b045daa461a6a
