Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4108F36EA9F
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773944188; cv=pass; b=fJDWzzZsu41bHjbuuD++FDM9PsZuXQNMyHZ1RIwAwKDS50cC8AeB7VIaV2nnftiFZjpOrA1fzcXAhC6RLdXNG+dDE2xg8h6Ngkx2odS0h7skzRISDeflFY834L7sJd8WC99HVY+W3MT0o3xjbLjkd1/04aLM/mOioIXPdXCU7v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773944188; c=relaxed/simple;
	bh=P3NDAgx6xNsTbwbbYw2hKGRdwP3I5f+Fq3KHalSd4dE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hA7qn8LqHSkscaZVXgdtRxaleDBC1tQK36kgXl1+MpMKXqcKgQM1hbo0Ucj0hgr3CUpuAFMffzhOtXDrl1pKAyCca8eoH7nvaeeTLvEPHGj1cE7GdAmr0R1xj6Nlxwf2x010jk/cI7YBZSvszthBORStDLEW69SIEDBiiTUfcI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZJt95yV; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZJt95yV"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ad9fabd08so1001071d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 11:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773944186; cv=none;
        d=google.com; s=arc-20240605;
        b=ZjqkEvgbcJZUzVnU5p97yAQTuIfn0DlV0J7zHmwJGaYbJB4JO/V9goRx6zlE0Kn8ir
         MrYTVbAgLVONEpor/2EooX7PKnOMuNDM156IESQt4tmkazGFRbnWQTb7MUBNPfnmz7lJ
         7X0SGeHh9e4dCDHicVjC5hgnyE1/1MPv08rAuzVRidWomwUwofpLXcMWhHpw9Y/nNS3t
         Gx1q+W40l/VoK6MzN19p2in4nw3pZ3YDVBr+ZwWrSKCx3QnNbvo2ZsA0XUZwF4WZYCM3
         Em+mS5RF2amfEzaKCGhnQ7N+N3sRxrJ5NY+BOBtiHFLKoxUSpJZlXyMMcGzD3LjhYqRR
         NWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V0xPoDNSumQ/Zq8nYny7A+LxHxVOobX/PsEPA7eYzWI=;
        fh=nHh+hsOePOe0lFIyPstZ6/GlCRWAQa6XkXL/mqDy5x0=;
        b=gQ71oQvvkFKuEC+gEy6kcLpJibl3mqrb27II9Z8ng31EQ4fsaJEFZIO1g0QdRl8Rsl
         D4YbotfJZ8Rl565KsTEVV/2cpRSjBhml2L3zoqNRrpY2hhDpRyJGK2UQMUJFjHa1uOU5
         aQb9qfKsObefXivbBTkGkl2nUqgLu2CZ9P7nbCcOKlYatnWJtXb+ucMfwG1E4bSAIpXT
         usUwwa6OEeheA7/1eZHJxWGEX1gb5cEEHWeiirNu3ZiUV0hyvnzq2xXXQiv7rkdAeUo1
         yt0FD+PRNM1y0SCjLfwP0zYaPCPgQHOI1+JyIMxbpE5tqTG6Po5CWfAuP0EwqIeNKLA2
         MSJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773944186; x=1774548986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0xPoDNSumQ/Zq8nYny7A+LxHxVOobX/PsEPA7eYzWI=;
        b=TZJt95yV/X4E+a5P461HxuYP05a5gKdb/C8cfAJT9bQfHsCcUbVQCHtNCz5BO6WidW
         1YvgBNFeM62Dt9QeuRxrrNmLbU5WhtsvNB24H5UPeTVQP9TjPqPxsDjO/pUuws1eQq5A
         sXrw7pvbFSqugmj7zFa5WGgGEhoGhF4bus3zeHDg/vAN4T4Sc+Ubnj43wpADxvJ3L7RK
         hW4GWNv2hs+DjiO0d2CgyxA+tVPzAZG3DTpn+RounmNGJG+J9Ybhzf99LdoW4UDW70QO
         AGstt3eyQtgdoSfBk9ERFhSAvIIVm0w3Mshn3LHM7odr1AIQStyOl8sfMjj+OdisR1sQ
         WJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773944186; x=1774548986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0xPoDNSumQ/Zq8nYny7A+LxHxVOobX/PsEPA7eYzWI=;
        b=fe8QZKniQ+KPkX+HIIu4DT+rXLYlSDqOhIthRTistz1urY8d9SRZFxmYHpJvXwYrlb
         3NmaQyMhJCxWR4ktZ0VnMZtDK+FnkRbXvdbGHks2JaaWVZEI6qbWo1Qwm0D+VJqKOaaq
         26EExwSzQQ7HSpxO8RAG3OLCpeWPL95sF9bYTqXwgVdLzMUgIdRxxHbEqQil+cBekhCa
         hQ7ynrZPNNrl2YwcmsYLLbCLrXKTcjl0ecbkDqsel3ZrYqKD1vB8/pGb+MwsUezAxcps
         au84ejpbUUtC2WsFX+zMyZ1SXknlHnEN82FgvDXOOSiOZbxEltAxZA2OpmV8GS29Ej9o
         WxIA==
X-Forwarded-Encrypted: i=1; AJvYcCXzEA2yGPnaxLtmo/j1Fc2V/NBZdXrXlQs6lOeWxFn9oRwpN/bQdRgj5PPNmkLJjcuXquHEU3r3k22IT9qK1AM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybI7fmL6w90RF3DVqCpsORx5w22lkHUtGLVgSZcAEtZAk4qA2p
	tNwy2Iwvd4G8SxYtub/t1WMmSRQ5TGkPL4hdFsIzGmx+RZCUEQioO5APOgbmsG37+0eRtowcAME
	eyIzJ+B7yEfR72VX14KWuCWUsVECc+zUPJaqg808=
X-Gm-Gg: ATEYQzxO7o6nXrcIbadGz6zwlKPV4B7KbEdJQNSV0tQ6JcdM8y7VtdBIV06jhwGiNPu
	sI4jbNxdUAjH0KTG/71fOOZe1vaHN5MlFqBTgviHW35zBk6opUDB3DxplF/zWYVOk8l4TE4QFVy
	qEnl3njqihg3wkMjNOJjNKuF3TqB6EdOJkA7YXB+vr+PG8kWSuELnCL98d18keDMi32K3XzR4th
	4jrLvHILgklknqCgNT57mxNgd2cTcoYpftVijSgo63GzDISJTYMfvoGimsXGno1Y+62QawuTeoe
	jMQcI3/eSwfazv52MyUzZ7rzC+RFjEb3o5e3oBKv2owMEJ0/DiRyc1qK1QF7UAwiSo/Cdw==
X-Received: by 2002:a05:690e:1181:b0:64e:a853:624d with SMTP id
 956f58d0204a3-64eaa6b5ab4mr570729d50.19.1773944186126; Thu, 19 Mar 2026
 11:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abwTQVhyDv0_x26G@v4bel>
In-Reply-To: <abwTQVhyDv0_x26G@v4bel>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Mar 2026 14:16:14 -0400
X-Gm-Features: AaiRm51LXjDBL1K5YN9zay5q9RigStZaGS74diFuXhaaFyaxebuFMaMpVe8bLI0
Message-ID: <CABBYNZJLueWZcdUX2jL9rhKKRCBq01fehh+SgeV_GNVKyXHrig@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hyunwoo,

On Thu, Mar 19, 2026 at 11:16=E2=80=AFAM Hyunwoo Kim <imv4bel@gmail.com> wr=
ote:
>
> l2cap_conn_del() calls cancel_delayed_work_sync() for both info_timer
> and id_addr_timer while holding conn->lock. However, the work functions
> l2cap_info_timeout() and l2cap_conn_update_id_addr() both acquire
> conn->lock, creating a potential AB-BA deadlock if the work is already
> executing when l2cap_conn_del() takes the lock.
>
> Move the cancel_delayed_work_sync() calls before acquiring conn->lock
> to break the lock inversion.
>
> Fixes: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_de=
l")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/bluetooth/l2cap_core.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index a6ce09781083..68bc65b1c12a 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1752,6 +1752,13 @@ static void l2cap_conn_del(struct hci_conn *hcon, =
int err)
>
>         BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
>
> +       /* Cancel timers before acquiring conn->lock to prevent AB-BA
> +        * deadlock with l2cap_info_timeout() and
> +        * l2cap_conn_update_id_addr() which also acquire conn->lock.
> +        */
> +       cancel_delayed_work_sync(&conn->info_timer);
> +       cancel_delayed_work_sync(&conn->id_addr_timer);
> +

While at it we might want to update this to use disable_delayed_work_sync

>         mutex_lock(&conn->lock);
>
>         kfree_skb(conn->rx_skb);
> @@ -1767,8 +1774,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, i=
nt err)
>
>         ida_destroy(&conn->tx_ida);
>
> -       cancel_delayed_work_sync(&conn->id_addr_timer);
> -
>         l2cap_unregister_all_users(conn);
>
>         /* Force the connection to be immediately dropped */
> @@ -1787,9 +1792,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, i=
nt err)
>                 l2cap_chan_put(chan);
>         }
>
> -       if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
> -               cancel_delayed_work_sync(&conn->info_timer);
> -
>         hci_chan_del(conn->hchan);
>         conn->hchan =3D NULL;
>
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
