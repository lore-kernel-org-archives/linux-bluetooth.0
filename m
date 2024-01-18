Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE09525601
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594354; cv=none; b=JTr/G+72keP2Gsa/aW171qUV4xtB7wB4zdFohH5y+S/BGaAGXya5+8RpH3T8q6tLWmU4ajezMoZaWCTVUktsXrsit6Uvq+xQvIeQUTWUljuadyGHridaNRGRst930Dw96Lt5EHtUiRGIaV+nGv84GY77lIxTZRrURTURgl//5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594354; c=relaxed/simple;
	bh=7hOvvhgjDxFU+7YBIHu18SdAKyTDVjfMXAV4GRXEhf0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=vAahGBdtavSQeMRTA1FiiMFdYGRrnJresGxhJUl431p+O6ixim5V62KHArXM01FKU1+LjBpq2nDRExej2ZWLvWO7MYZYntNXQVR2PniEHeaVBCBSESMVGf5MuzdUK5kSnZe0LeErOWXYLNCfxgpFZJDMlxVTee6oet81vLv7tQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGgrJ60O; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGgrJ60O"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so10727184276.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 08:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705594352; x=1706199152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P9hZ00FuvjomAxbCz5iGFgtTUw8XjHFqA+smlgd1q2M=;
        b=aGgrJ60ORy9BdlBQQikUK2QNme2Na++MfKf2+o1ngCo8yGF3rkmkPFg0vuZN34Rfjd
         4P7ZVpWYYdHRak636FppY7cqKFmj6ViLcPAs7G8b357/6yESlohkYI4SkeIpWScq1XOV
         mnX0FwqyrgV2krVK8aUiGOILp3NMmZ93SNZc9OYf8M9pObHrp4T3tLueaJ8h0/xKIx9Q
         UFEydpCQ3mRGwGsDNtz8U1Mluozhz+pdbhbomzPfBDUZWxkHu7N6u8p0f7OAtBJBJYyT
         hpp10rYJ6oDvA1Rq7dzAxwAw8xB73SxKhUWBxNVgdZr0tZj716A/L0hnEbFth44jmAN4
         SwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705594352; x=1706199152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9hZ00FuvjomAxbCz5iGFgtTUw8XjHFqA+smlgd1q2M=;
        b=JPe/cXLs0Z36a15eKuYpPZmsBrVETAEvSYQlRC/QqzIibG63QqiJfMxfb/IpBAExjA
         tfgkRdCn0V42+82J4ceQJ2J5aqB7q8jy4qlH8cvmf3/xjTqzp1i2IYjXU6VgeFI60Pd1
         ASsjeLj7vqoXTbZSkUiG9n2mb3SySR2+I8cNVe/t3/yCNuYhhj9gcJpLpwup/Zh2qGmL
         x/OuRpHwqExM9IGAbWen8xr0yYk8rcFntOB6/TuE0qS1wLiWZnWO2wuzeMlzzfXfC/TZ
         ajLoexCyex75ZdQR9+3GssEGZP8pt2RDUS9K0IXM06PBlGzENcEY1SXdFYfsXOYBfPow
         C7rQ==
X-Gm-Message-State: AOJu0YyVCMrEZ9ixlAfAqzcuQikBmhYmfLvn1ElZdQeLc9BmppYdMgbx
	6QFhMN8jhflSDnJuCmEsjQtzpSVb3MXFe+0MNXkn8n1UkyA8T1aj8PosRcS7Nezyf7IBr60elrB
	1wHG0Wi/g+MGIj5Nj219+c42LHtAHIF/eF0o=
X-Google-Smtp-Source: AGHT+IHMFspci5xJi196WPYYnEp7XcBUFXoLYsEx1qLdXvnP8AtxRLPUj9Z8myzIYeAWI5yaeyKLO+k8tlg4dFSxYyI=
X-Received: by 2002:a25:ab32:0:b0:dbe:d3ef:d54b with SMTP id
 u47-20020a25ab32000000b00dbed3efd54bmr800340ybi.93.1705594351899; Thu, 18 Jan
 2024 08:12:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com> <20240116-autofoo-v1-4-626f6b54bd06@gmail.com>
 <CABBYNZJUhmVUNGTsqspc3S802pDwikFf2YOPupESD1m5T-GsJw@mail.gmail.com> <CACvgo505kkEr+SZV587XCGoaFKYo=17zgbvHLrv=UJLp5JRLiQ@mail.gmail.com>
In-Reply-To: <CACvgo505kkEr+SZV587XCGoaFKYo=17zgbvHLrv=UJLp5JRLiQ@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Thu, 18 Jan 2024 16:12:20 +0000
Message-ID: <CACvgo5064TQ5qwNiBgpc5BcdnHWoD7xEc45ZyR_PcexKwubR2A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 04/10] build: remove dummy {conf,state}{dir,_DATA}
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 08:39, Emil Velikov <emil.l.velikov@gmail.com> wrote:
>
> On Tue, 16 Jan 2024 at 18:40, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>
> >
> > This one seems to be causing some build regression, when trying to
> > apply it breaks the builds.
> >
>
> Thanks for the quick feedback Luiz.
>
> Would be happy to help but need some details:
>  - configure options used
>  - autoconf, make, gcc(?) version
>  - the error log
>

Just went through all the patches and they apply and build just fine.
Both in terms of "./bootstrap-configure && make distcheck" as well as
the Arch specific configure options as seen here [1].

Any pointers about the issue you're seeing and the platform in
question would be appreciated.

Thanks again,
Emil

[1] https://gitlab.archlinux.org/archlinux/packaging/packages/bluez/-/blob/main/PKGBUILD?ref_type=heads
