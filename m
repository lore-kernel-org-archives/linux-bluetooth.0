Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A6233EA
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786107; cv=none; b=ChK+CdxBHpo8hgEtT+yIQG8nO3vJ78j6Pdb7bzVf0x1MCPqTMMNAJunclK/YVwIDpGUKCUChDNv+Mryr0WlpMBzGGZxMHAhJbJvoZdwaQvzkcD1th1lA7nIPlKEhUtr+RVSlFVllG6zDdNHiN0Hf4dJyK/3JOQQwYXdhx5TBz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786107; c=relaxed/simple;
	bh=H5L7D7Gb3hEqFC1ty+0Wkhj1Os45SU3jp7eUxjdN5fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLR2magm4GHCyBami0lAiAeDOTeJ8hC3rddk2Q+dAicjaU5oWS0WtNJBAFHRevvPGxel1MuInLidmp2i9HhBFnW6fqNuPoPUhKP6cjQz3tDLI9cRCA6AUlft3JhvMP1VtdMncKzG48bA/r9PFgKEwE5SxpngN9GyMGbVIm9PLkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOR14L+I; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOR14L+I"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso12347771fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729786103; x=1730390903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKLp40869ik60YURiDrpqyE1Y9PFA9hHVtT8Yc79WD0=;
        b=AOR14L+IFMekScsl/XogQvIIDPsnSS4mEfBAY3xYjWvhbBqv/VbgJqxHLbdOsVGPQO
         tvwXItFi7OTTZdkj2QbpIFnNVP9ccA6DlphAQ8eyCHcyCc41uzfaERADPPxrABVLL344
         EsU/08ihOMBSDkjC66+/83AUhabRifpPmEZz9Kam6y259LvTgeoQ1ITK3j/DVnBH1Ca4
         TC2UzLbth2CvjJXUwqJQ+I3HtUpC47jA29owGsR0YNxA3j6HXUFzjEOsVPV3cvBu2DqE
         DWzPQ3I0lcuHeAhCo04i+CcowsGyQdzgvoyR5Df34nlqONlsXPfo2SmJF2RAn/fWXrRi
         LSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729786103; x=1730390903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKLp40869ik60YURiDrpqyE1Y9PFA9hHVtT8Yc79WD0=;
        b=NLLI911IpSUUfAOtgBhkYxuex2GCd5zSip3RArA3pzej/O39IkgBa1pDmzb7nmyKfB
         y89amyASzaw/xqI23IpkYXlpSiKcPF7PftNtzPsWpzQzHAlPxlyly4c2stJ2r16Bi7SE
         BiKEQCM3NDzn3719a9l+gD5x9U/xQRwHS/AufKcwyof518vDukBnwRa09TnQqKjP99vQ
         Y1bRaHgHuuvR4VT+B/nniI91OhKZOjWnidV2BbI6dx++4LPQev466Ee/hm++/MJKt/8W
         Xvu/ta9ABtb73K7tNIZc+652HqFA82O+F/zh0fFQRLfG0b9pgkvPmrrCQzZvu1+JzaXQ
         zOhg==
X-Gm-Message-State: AOJu0YwiyZJc825TCn7iR224bKDwxsCAPcmhK62CFqc1KqT9X2SuPlou
	rvCdD5sgnFCfSssW1FTiuqbluOjIwTn9jPl1db1fdtUD6srpxDQ7RYXasdkDkVsz3VoB+JAuMSz
	KQ7MXYIVHYD9gMVxw4YPACb68v3E=
X-Google-Smtp-Source: AGHT+IFZD8FWf5x/PzIcsrdxkCBeO2q2YEft/7RvVe9T3hzso31gaRE+3K+NowqniCBmryRMGyJRS2xm5Os3x3L/ec8=
X-Received: by 2002:a2e:742:0:b0:2fb:5c20:43e0 with SMTP id
 38308e7fff4ca-2fc9d3792b8mr33034951fa.15.1729786102967; Thu, 24 Oct 2024
 09:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022141118.150143-1-hadess@hadess.net> <20241022141118.150143-8-hadess@hadess.net>
In-Reply-To: <20241022141118.150143-8-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 24 Oct 2024 12:08:08 -0400
Message-ID: <CABBYNZ+aMaDp0BC6F0yG+mJU9hgkeNtbOxNwYx1D7Yj3rU8bzw@mail.gmail.com>
Subject: Re: [BlueZ v3 7/7] client: Fix --help hanging if bluetoothd is not running
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, Oct 22, 2024 at 10:11=E2=80=AFAM Bastien Nocera <hadess@hadess.net>=
 wrote:
>
> Exit after printing all the main and submenu commands.
> ---
>  client/main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/client/main.c b/client/main.c
> index f60bef1a6d3a..f5ed9f9f5297 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -3193,6 +3193,8 @@ int main(int argc, char *argv[])
>         assistant_add_submenu();
>         bt_shell_set_prompt(PROMPT_OFF, NULL);
>
> +       bt_shell_handle_non_interactive_help();
> +
>         if (agent_option)
>                 auto_register_agent =3D g_strdup(agent_option);
>         else
> --
> 2.47.0
>

Having some thoughts about how to do this is more clean way, perhaps
we should do this as part of bt_shell_run and then introduce .run
callback to bt_shell_menu so it is called as part of bt_shell_run,
under the .run callback the menu can place e.g. DBUS connection setup,
etc, but before it reaches that we can check if it just a help
pending.

--=20
Luiz Augusto von Dentz
