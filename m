Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EF81990AF
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729459535; cv=none; b=ABshH9GIwjiWY9YB06k9fpeCaHEkR+IHO3K1AyrHynA2pGGwoivighaupUI1dMapiTz7Ky1v1rA23iT5dxTsRaOvTVSJRGrQJPokGv5PoXa6TC14IMuUSTLaPJzUdWOIHkKQQUWVHD0HOGnl5RTEhTXpzyE9A/y1PJTkAthNvoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729459535; c=relaxed/simple;
	bh=XkJsm+YQn9dFOqvyQtmGu4r1jDNh0/lklKP+6iMRiwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+G2+De8JQb1fdgnZ2eme4caReNFkWLpio9Snult9b5/isIiwXwzHD0MEx8h5gwhpq6kknHKWwjMFdstkv2GYRYBSUW+H9MQl3n2ldQv1oD5wtGq9ZJcNM7y8WSyh19BPviHlqgSX/uKBFZUL871122wOVVI9E7FkDBXM6JQ1yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TzH9ZWoe; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TzH9ZWoe"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539fb49c64aso5147777e87.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 14:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729459531; x=1730064331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=86Vxu3y5hRyjW/SN4fiNS5sxS0hzqrFNGJyjGIFIOpg=;
        b=TzH9ZWoe31hmRTJYKG1PZUn+xWLzcYu0EAg1tZMcQSuzIDnrhe0/XqQjk+3B06y+4p
         Mxe5llHwO9VFvmKgZThiQpE4oe9FhQsusob2M0G5L06gydlqH7qZoBBWBL8uxQc/ZQJm
         jnlhLuqj4HgwDzeMe+ng2OJEftaO0I11kFGd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729459531; x=1730064331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86Vxu3y5hRyjW/SN4fiNS5sxS0hzqrFNGJyjGIFIOpg=;
        b=EnNU+dH69mYLc1xauPWFjVq/SMG8s8TbImwg7t7pkcHCRXO3MBDyYbcO2pl5E+g6D7
         p3bWkkhspBrPV4SXQqQzSdJ1ohMlIdkOG/0Mcw7ovz4yn/YjwpSOqEYrj9jfxegy/9mP
         8zYJ30cE7FCFnw+3Zi7ZzrMK2f8gMu35bbmsUK2bc7MPA3mTn/Oqp8mwlkAfr/Jh1ByB
         P6/JrAsdml0ZByoDdZ8oQToW0Lvd/32O91xl6rSVJc74LFsOERPS0xhq2GyI0+jsFXq7
         KajrEbfwqh/s5f+zhuiDc+AtFqTyJUHnlUqQWOeY/1fwXoWRj6sEQGjUaGg6K22hv7V5
         7KDA==
X-Forwarded-Encrypted: i=1; AJvYcCVchXrXUrxsis5/QwIkxkttwNL0sCxKehkeMC6qmyZlJVO9zGHn8TADJW8oYegg0S2/WWp1WPCPTc+8ksSGiAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+QBzadd5e0qpc4+VvudVOrJIt67q5QZmxdwAxea+7B3sY9HRH
	DDNyjr6ST/WdtXvQERyfi4kH8msBboCQtWDj6tJXXnTc0oOYXKpkvj19cp90dti1IlFksL8bSBM
	9jOffNQ==
X-Google-Smtp-Source: AGHT+IGab+o+IQa0PpDNFR6tC3viwUGmvJQHiDA1w2SwkX7xiVgQSq3ORSaCncAcDtvBgJ75wDDVKA==
X-Received: by 2002:a05:6512:350f:b0:536:55cc:963e with SMTP id 2adb3069b0e04-53a154ca15bmr5173639e87.44.1729459531311;
        Sun, 20 Oct 2024 14:25:31 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22420317sm315081e87.122.2024.10.20.14.25.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 14:25:30 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso51206921fa.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 14:25:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5QWhqwMGocFdcA/FMl0njJ6alj8dElDvNhEZViMo5vGnOinXbrV4/JfVLF13F7VG+EW8sMxyPutSGalBUfOA=@vger.kernel.org
X-Received: by 2002:a2e:8815:0:b0:2fb:3881:35d5 with SMTP id
 38308e7fff4ca-2fb831efa0dmr47530391fa.35.1729459528880; Sun, 20 Oct 2024
 14:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016204258.821965-1-luiz.dentz@gmail.com> <4e1977ca-6166-4891-965e-34a6f319035f@leemhuis.info>
 <CABBYNZL0_j4EDWzDS=kXc1Vy0D6ToU+oYnP_uBWTKoXbEagHhw@mail.gmail.com>
In-Reply-To: <CABBYNZL0_j4EDWzDS=kXc1Vy0D6ToU+oYnP_uBWTKoXbEagHhw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 20 Oct 2024 14:25:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3rQ+w0NKw62PM37oe6yFVFxY1DrW-SDkvXqOBAGGmCA@mail.gmail.com>
Message-ID: <CAHk-=wh3rQ+w0NKw62PM37oe6yFVFxY1DrW-SDkvXqOBAGGmCA@mail.gmail.com>
Subject: Re: pull request: bluetooth 2024-10-16
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, davem@davemloft.net, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	Linux kernel regressions list <regressions@lists.linux.dev>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Oct 2024 at 09:45, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> I really would like to send the PR sooner but being on the path of
> hurricane milton made things more complicated, anyway I think the most
> important ones are the regression fixes:
>
>       Bluetooth: btusb: Fix not being able to reconnect after suspend
>       Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001

I cherry-picked just those, but then I ended up looking at the rest
just to see if duplicating the commits was worth it.

And that just made me go "nope", and I undid my cherry-picks and
instead just pulled the whole thing.

The rest of the fixes looked too trivial to be worth me having created
a separate cherry-picked "just the most critical regression fixes"
bt-fixes branch.

IOW: I've pulled the bluetooth fixes branch directly, but sincerely
hope this won't become a pattern.

           Linus
