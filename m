Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F2726FDB6
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549600; cv=none; b=s8UwCk4n8ggKYg4UnCTWGdwsrCij6etCswnUMu87a55RQTIMVj06o/Cj9YTkS2CPqkX42506SFbLa/UDvzmpZHOnlxK1gUKhxrqzBa6BG9qziFUhtz4K/FUjsVLxmWFgXKJ6uwhYzsxXXMrvvNRnX6UShpDWfEp8j1Sw0TzHeI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549600; c=relaxed/simple;
	bh=H1vMWY3hUhmJj5Li+fUrFWo580iHj1xmmXCLiWaLbmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDwENLbvAaiSO+xLDdQ2C0/B20rq99aph2p+XTjHsEW/3EPgOXiMcjvTHdaESL/wXHssU8QXGg1B6IGc8NelqzzPNo7oZhhl0K0iE5RQmkttfNrNZHjk+RZ9mhYBT1mzQcEmDHLNGSgugtAMWQiccb/b3uM7C0lMw/CUHSmsl+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDHf1dZg; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDHf1dZg"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3635bd94f3eso33661941fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758549597; x=1759154397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+4c6uQUQzP2K2suk9JDiaGQqofpgz2uEQqAHaDrZK8=;
        b=nDHf1dZgKc9jHnyTZni7kA4ZVgbzHGKeiH3wIkICgFH4tUNu4tbh6l6P4UXQgvqNv0
         9JiwPFypEtAPmxVFDG/9/nnZUvCOmTTeXhTlKMsyPliwDE0HkU4BvnwmS7VrB0N2a2+n
         vGqgFfu15zDhuBE2WXY9Ua5f4LnQZerIIeAxKM6/qQvmaNgRFGLKv1428fdM0sdO4qsg
         bbLXSZFjjfQ+5B17EmgEvZG22q4E61W/5nhXbh5PNKfQoZcvwoPwjh/bySzKHHd9xVSG
         Wewu62VutonVcfEMYOvd70YdBgu5Wz2vZCPwIGmFytYzMMj3r6WWaC3AtxwngA5dhzZv
         KlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758549597; x=1759154397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+4c6uQUQzP2K2suk9JDiaGQqofpgz2uEQqAHaDrZK8=;
        b=wGS2Xzc37HUdUSaDxulC5eG4sKk6MaAbeqk4dnp98pz2Fbwo9C46XHPomyyWDiQVFl
         0/PbCZlI8T6frrOvzh6a2MdhEacDv5sOscGTsrbXdREm4kIW9V57yHFas7N7gA+ZUI1t
         aMVS8F8vBfhcV341fBU19JcTUm2SeyiOiZ/pVveraR2ndDUOt5+8/ngSjiAs5wI9vcvN
         OV75DB3s9Fdutoy5GTPwBNa+0Y6DmHfdeLMfeG3RveHWRPtd8ctyH00Bj6JuDTIB7hUF
         E1Xn/kwYJvuq9wynDEnGM1Z5I326q7sHVB8TygtIpDLZGGeAleVbxxDEIO59Fz+X9Q6D
         CKVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6mxZ0AqSh+/TIUdChbKo22LxhggHtb9BxQ7BLpZyyLwRJ228LqDTJX2g3ZO4Rxj5YMJyVE19/fl4wFjZoisQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2onW+seiHm32KCw3ifz8PBpJiFa4MmWGbkfAUqKfv9OQs9+5F
	v6hVAMLk3Epd+ub9LnGyCsB+kK0U7E+E04apsOwTISPKjg9IMUXCD7pvZSd8SAID0h5ZeAf+Mw/
	1SZEvgMgLYzm3VIH2H53oDn8mQ7sBN1MhEa8l3XU=
X-Gm-Gg: ASbGncv/wDs0gxbijL5on3O+AjznweQz6L2DMneHu4SrdGuxeeyQyuHjxLw//Su9yVH
	NKikph5VriWXCBUPAIUdpBQ/MoZK6NgZu5/U3bCAM7/oOjKq+x18WOMBznbzcTeolS0JWjeha/k
	fHTGgQvgCKb8vOsr0V0noQ4xQA3j+DLaL0rNLG5VW6jUgS8qR5KdIyoNvw4FP0Ba29yduZ5ME7f
	IZmyg==
X-Google-Smtp-Source: AGHT+IGs0AHLX6n6CLDcP4YCO6I/OmQsz5nN1h3ZwRRSeGgWD7AKtNDw/Z087eXRJ+lYV3x37aMGP9Vy6sAcFRIdWp8=
X-Received: by 2002:a2e:9043:0:b0:356:839:56f with SMTP id 38308e7fff4ca-3641977f85bmr36797801fa.20.1758549596424;
 Mon, 22 Sep 2025 06:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920150453.2605653-1-luiz.dentz@gmail.com> <20250920133841.38a98746@kernel.org>
In-Reply-To: <20250920133841.38a98746@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Sep 2025 09:59:44 -0400
X-Gm-Features: AS18NWC0-L1f0PIJuerueTI5AN3SwHy3P8mJ3rBlXWlNpu6sUmkyAhtfZMtn3H0
Message-ID: <CABBYNZJ6DcUPHgCrDquW+_q340yxJHfudVDzUFWuXMTFvqPEbA@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2025-09-20
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Sat, Sep 20, 2025 at 4:38=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 20 Sep 2025 11:04:53 -0400 Luiz Augusto von Dentz wrote:
> >       Bluetooth: MGMT: Fix possible UAFs
>
> Are you amenable to rewriting this one? The conditional locking really
> doesn't look great. It's just a few more lines for the caller to take
> the lock, below completely untested but to illustrate..

I guess the idea is to have it open coded to avoid mistakes like
unbalanced locking, etc, right?

> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 1e7886ccee40..23cb19b9915d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1358,8 +1358,10 @@ static int set_powered_sync(struct hci_dev *hdev, =
void *data)
>         struct mgmt_pending_cmd *cmd =3D data;
>         struct mgmt_mode cp;
>
> +       mutex_lock(&hdev->mgmt_pending_lock);
> +
>         /* Make sure cmd still outstanding. */
> -       if (!mgmt_pending_valid(hdev, cmd, false))
> +       if (!__mgmt_pending_listed(hdev, cmd))
>                 return -ECANCELED;

Sure, this does require calling unlocking also when it fails though,
but I guess that is to be expected with this kind of construct and we
could have a variant that does the locking inline in case the cmd
fields don't need to be accessed.

>
>         memcpy(&cp, cmd->param, sizeof(cp));
> diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
> index 258c22d38809..11b1d1667d08 100644
> --- a/net/bluetooth/mgmt_util.c
> +++ b/net/bluetooth/mgmt_util.c
> @@ -320,28 +320,38 @@ void mgmt_pending_remove(struct mgmt_pending_cmd *c=
md)
>         mgmt_pending_free(cmd);
>  }
>
> -bool mgmt_pending_valid(struct hci_dev *hdev, struct mgmt_pending_cmd *c=
md,
> -                       bool remove_unlock)
> +bool __mgmt_pending_listed(struct hci_dev *hdev, struct mgmt_pending_cmd=
 *cmd)
>  {
>         struct mgmt_pending_cmd *tmp;
>
> +       lockdep_assert_held(&hdev->mgmt_pending_lock);
>         if (!cmd)
>                 return false;
>
> -       mutex_lock(&hdev->mgmt_pending_lock);
> -
>         list_for_each_entry(tmp, &hdev->mgmt_pending, list) {
> -               if (cmd =3D=3D tmp) {
> -                       if (remove_unlock) {
> -                               list_del(&cmd->list);
> -                               mutex_unlock(&hdev->mgmt_pending_lock);
> -                       }
> +               if (cmd =3D=3D tmp)
>                         return true;
> -               }
>         }
> +       return false;
> +}
> +
> +bool mgmt_pending_valid(struct hci_dev *hdev, struct mgmt_pending_cmd *c=
md)
> +{
> +       struct mgmt_pending_cmd *tmp;
> +       bool listed;
> +
> +       if (!cmd)
> +               return false;
> +
> +       mutex_lock(&hdev->mgmt_pending_lock);
> +
> +       listed =3D __mgmt_pending_listed(hdev, cmd);
> +       if (listed)
> +               list_del(&cmd->list);
>
>         mutex_unlock(&hdev->mgmt_pending_lock);
> -       return false;
> +
> +       return listed;
>  }
>
>  void mgmt_mesh_foreach(struct hci_dev *hdev,



--=20
Luiz Augusto von Dentz
