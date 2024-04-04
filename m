Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C314A8B
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712251429; cv=none; b=es/dgPMzP/jZUKYJsUy8cuSGu/3Npr+pLJVbZ543/OIRAYU61QDtwGyww4JgMb5LUjJXD+NkGSfLUhv/+21ZHOvd5RcUzi+hGF3rpIYkrDb4YKzaTa0piusEy+aoVOZrY022aYcgaBVTItm+2xTyNSsrZjxuMhCBh2VndocDh3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712251429; c=relaxed/simple;
	bh=aXk8GQ8e9/t6QvqkN/T1GzCR4SiMXCYVRE15IgLGCVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXVH6OSRB4sqTL0svezbqh0UGMhcP1SAzxAqRdiydKgJoMnUcXItK3RjokvFtdvwVVip+Yr/DlxvtKgUUBgO7S9SrfG2QsbpAX6250giVUwmyOWmxTnvV6+IaoiLtxAKYQdkfaAme7EtfbZ81CSsh+JBgtuW0WopHmXL+Tdrx6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZNrsi80; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZNrsi80"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d6c220a377so15151711fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 10:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712251425; x=1712856225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dphtDnuqG2CBnaoHx7hObVeKoWyOrQju5EENgq0NXvE=;
        b=kZNrsi80dGxNEJfQqTnrB+gM+rEZUbTl2ligZOQMcpTnlNhkinyg/bnlRqGULNr7Q7
         lYdm3Ezg970mpYrHL8u5bOo13gIyjKZv6fawyGEbYN/5Pk0hA+Pp2veoqwp51k1xjkgg
         etBO2fDe7MhJCkb++D/D5VXMLj64auU3lEjLd2pu8ePz0gp/2rgbHOMmqej5d+Mr+OK3
         5MrpWyfbhDjDpX5cwzS9P+TZniL+fEMGzLAk8d3B1aQwn80bAmsK04KlNzrkuRBtf0EP
         Dvux+AxCOjp+KOyrVYgE3ISVUzFfgVfR6OAIkmlZ7oo1JmHm1sesbe7IWc6OpJGbDuMA
         ywEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712251425; x=1712856225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dphtDnuqG2CBnaoHx7hObVeKoWyOrQju5EENgq0NXvE=;
        b=nhEbqZwUBrudVsH9dGe6JlaS6vow2zcembknPG5FtN8thITM5Ml472xZdjQeTK3y0v
         CGxxcO34YGpenJe9hfBFtQulQypPR+39JU5u5RwGY90PmF48R7NgqsanHWLpLpz+RfwI
         apK0FMmrk/m/Cd8Cj26ZnqaL6oUCMmLNE+1hVSHh4qfWuMoBSEl1tFTcB6uRzqOZ7YJO
         3oCmNXKS0kUG4cpmi/9eDpbFpBnvG5HPYVLXpKYZtzvN0y6hiYhYEofYkNBG3Xj8vYIQ
         bAlK+uZ5JdHXbI8PeL2U5x8DSAV0oUK/0F/qXdpHmns61LwrJB0mUsyiRbSS9kTiQwLX
         ZraA==
X-Gm-Message-State: AOJu0Yzjnv3RNWbdDEHBxSviNXpV2uICTc1lEJZ73w331jmuNychZXvu
	b6EQLLLPdGCeZa2XPqgp0GDSRwmAfZVNRJpv6oXhodVod+FIdXs9NDIzrpvw+oL6IrvpuBo9hFx
	QE90uldMsiXGxKNXonhWG2HupXcBGVXVjmXM=
X-Google-Smtp-Source: AGHT+IHJv2llevTt+D6XFWyh2OZVsmMBTE6Ivjlqdzn0MBKA+PdezSWH5Fr6ubDWT6fphSKb32JzXDotJ3MkZuaGAsg=
X-Received: by 2002:a2e:b994:0:b0:2d8:3e52:66bb with SMTP id
 p20-20020a2eb994000000b002d83e5266bbmr16144ljp.42.1712251425044; Thu, 04 Apr
 2024 10:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404114054.4987-1-mahesh.talewad@nxp.com> <20240404114054.4987-2-mahesh.talewad@nxp.com>
In-Reply-To: <20240404114054.4987-2-mahesh.talewad@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 4 Apr 2024 13:23:32 -0400
Message-ID: <CABBYNZKk_dQefyB33NrWpCVpPAnL_veRfhs0AcA9HOEmEifWXw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/1] Increase autoconnect timeout max from
 16.384s to 20.480s
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com, 
	sarveshwar.bajaj@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mahesh,

On Thu, Apr 4, 2024 at 7:41=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nxp.c=
om> wrote:
>
>  - In current implementation Autoconnecttimeout max value is
>    16384[0x4000] msecs.
>  - Since some controllers need some more time to respond to cmd
>    'LE Extended Create Connection' hence increased this
>    Autoconnecttimeout max value to 20480[0x5000] msecs.
>
> For ex:
> - In some controllers, If we include LE-Coded PHY in the initiating
>  PHY List, BLE INIT scheduler selects the 1M and Coded PHY scanning
>  as an initiator in round robin manner, and due to this available
>  bandwidth gets distributed between 1M and Coded PHY, and this
>  results in longer time taken for connection establishment by
>  the controller.
> - If ref device is advertising at 1.5 sec intervals, with create
>  connection timeout of 4 sec,  the controller gets only 2 opportunities
>  for the connection. Without the inclusion of LE-coded PHY,
>  DUT takes ~3.8 sec for the connection establishment.Hence as described
>  in above point  with the inclusion of LE-coded PHY it is difficult to
>  achieve 100% connection success with the device having
>  adv interval of 1.5 sec.

Have a look at:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D841493

> Hence increased Autoconnecttimeout max value to 20480[0x5000] msecs.
>
> Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
> ---
>  src/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/main.c b/src/main.c
> index f774670e4..081a388ad 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -657,7 +657,7 @@ static void parse_le_config(GKeyFile *config)
>                   &btd_opts.defaults.le.autoconnect_timeout,
>                   sizeof(btd_opts.defaults.le.autoconnect_timeout),
>                   0x0001,
> -                 0x4000},
> +                 0x5000},  /*max val: 20480 msec*/
>                 { "AdvMonAllowlistScanDuration",
>                   &btd_opts.defaults.le.advmon_allowlist_scan_duration,
>                   sizeof(btd_opts.defaults.le.advmon_allowlist_scan_durat=
ion),
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
