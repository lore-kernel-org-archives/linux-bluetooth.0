Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EA01DE2AE;
	Tue,  8 Oct 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396770; cv=none; b=dbmpmeEv/kttJJbxXMOYRS35v+g01FAOCfYWIBOjog4DOy+NGydyG1RCDmt9NrnHop6UcGgQibSGzZF4BY7VJc21/Va43tshFmL55H5QHApMnRLNyoDTcIPgWOnYBmcUR5C+jhFFD9zWoAoxin+NsCY64ca+06R8uJ4HFM/C4x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396770; c=relaxed/simple;
	bh=VN+23OGSRe3TLXKsTZXjE0+pZHihoPb280D7ZXFQgTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJKlI4NGj4dtQefeLdhcO0vXc73m/cuKrI3rOylnFxQ7jR20V263XZLtyZ+WY2WGGjFKgOjoK0cy4EHEnK4akLdI5AMfQ+tH9EbOSxQdg1GI4F+K+5BY2f0yWO5OD+4JWFeZVJvfFc8OYaV5vk/RotCu1RzX7k0g+fm3E9PTmc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wc3D3wf0; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc3D3wf0"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fad6de2590so85620361fa.0;
        Tue, 08 Oct 2024 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396767; x=1729001567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2B0fzHptHo71AcgtfObGHnQOdYmdH7Q5eKq0oziWRJQ=;
        b=Wc3D3wf0r+IcuRr/d+gCM+12HeOnMqE5ztYLb8c8dryVVPwjcZxIQoGtjPEpa/dtCo
         BMoe26H2YNm/3+NH49ZLD+nPeZ2A08+2f9A1/uHJP6/XbZfrNbxIurZ+B67gqvgb+oKH
         6slGeOCwSdaKz6GbIi/dZmr8jO1/RmXDK+CuFaorwfgMB87Wbmb+ZMKJy2mQ3ft+JDjm
         Se6kDCZPGDmZsLNKvJnLXLlaicGkVnesKOIAY2nqnCTyDhzfMZqWl2wlB2DTTEeNpM3z
         daOuSYp0tjXsZ2bQDO1MqEpo69C6SBqoMePlZ+lwyLsePgHRreGFJvZj8MDBnGV1v/7M
         2SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396767; x=1729001567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2B0fzHptHo71AcgtfObGHnQOdYmdH7Q5eKq0oziWRJQ=;
        b=FdQderyDolzXuE4JbW/ALDylzpTeBQ/jHZImshRKZxhJ9ZAVoHH1uNjEhbcEIUQ5Mo
         zR5BgDbhjzqLWXdanYvk9++7U/mZuRxqlYGb6jHroyL7wfXELOKjiOKteDFMYlDH+RNr
         8k4YqGqCpgJN41u/7f00uJbsfuMh8zf8zdo6fHAq6FibzXe4vnci1sYg7jKkQD/3nnhg
         THlZsBG83EbUDl6bmwlfls9LhB+tHN9ik2NfrzrijNCh63ATBRHtti1LQeb0bSIzaRoW
         GS4BjsZiD3Za6zsu87lpQoWpidxuSA9U9joOTzFnt95nofmcer848Oaa9GWi6YFnfWSt
         qJWA==
X-Forwarded-Encrypted: i=1; AJvYcCUERq24W38+CnBGA+3neUmZAi5xnx4DHdpLAhwWT3pX2xyc3QiC/NZFvE+3R4aMqzUB7HXOANZpkho375XO@vger.kernel.org, AJvYcCVbjY8vZQOLDZA9APOFBJZH9vGhxQfQY4JkB3/r1gBlOfeDo+N0kPKLI20ts9NHCKQPbnMrglV9Xj0+ZVx5gio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTWlRIqU1WtJcng5MSGruq/NWIWNHETLjuSN+36zqN/OS5mKdk
	c9gyA5TKy3LcreJGsWKZSkYt00GW9AG+MQqwNha40wd3Q/CM8X4Y39u9oP3+XpRhUxOchofKoAc
	9jKwMrX6vQqgsWFKa8hgKmfjz0qQ=
X-Google-Smtp-Source: AGHT+IHDEuVIECQhFAK12xvKwiUsRet4wNR898rcskXU+FN8rTIKwotfuCKGQ39nYWUcQMf6Xl1CuuwDZ43nP4L17Z8=
X-Received: by 2002:a05:651c:1a0c:b0:2fa:fdd1:be23 with SMTP id
 38308e7fff4ca-2fafdd1bf8cmr52226571fa.28.1728396766967; Tue, 08 Oct 2024
 07:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6703b264.050a0220.49194.0502.GAE@google.com> <tencent_29BA32BBF933AC9EDA1B074B621BEF259308@qq.com>
In-Reply-To: <tencent_29BA32BBF933AC9EDA1B074B621BEF259308@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Oct 2024 10:12:34 -0400
Message-ID: <CABBYNZKiNBxqZbS7hcBrpiwHRRwAe9gXvHWNvi63qBfykR=SVg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_core: remove acl hdr handle error message
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com, 
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Edward,

On Tue, Oct 8, 2024 at 6:47=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> Syzbot reported a uninit-value in hci_rx_work.This is because l2cap didn'=
t
> execute the corresponding connection request to call l2cap_send_cmd() or
> l2cap_do_send(), and ultimately called hci_add_acl_hdr() to set hdr->hand=
le.

What are you talking about here, what these functions have to do with
a local handle variable?

> Therefore, when calling the thread callback function hci_rx_work() to cal=
l
> hci_acldata_packet, hdr->handle should not be used directly.

It is not being used directly, the handle is a local variable which
get assigned:

    handle =3D __le16_to_cpu(hdr->handle);

If what you are saying is that there is no guarantee that skb->len >=3D
HCI_ACL_HDR_SIZE then we probably want to replace skb_pull with
skb_pull_data.

> Reported-and-tested-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D6ea290ba76d8c1eb1ac2
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/bluetooth/hci_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index d6976db02c06..20605a7f3f4e 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3791,8 +3791,7 @@ static void hci_acldata_packet(struct hci_dev *hdev=
, struct sk_buff *skb)
>                 l2cap_recv_acldata(conn, skb, flags);
>                 return;
>         } else {
> -               bt_dev_err(hdev, "ACL packet for unknown connection handl=
e %d",
> -                          handle);
> +               bt_dev_err(hdev, "ACL packet for unknown connection handl=
e");
>         }
>
>         kfree_skb(skb);
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
