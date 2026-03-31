Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260D3DFC60
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964234; cv=pass; b=ib1XoCQLhbr5nbgjipAcJgLzEtpW9vEkdZi2OCTzou2X/VeRmw0tsAKawTnM+XRH0KpylD8qFLiGrO17nDXlghTSGar1/EzYpGYJhlebothu5yh32lCIVK+bEGGlN+VL58mAzjKdKJDnAE5Ja9ijPu4as6ydaVBpFQzHcgvtAqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964234; c=relaxed/simple;
	bh=YzUdJ8s51EVo8h04NjczD2Of7rwCACK4ORr3lOV6onw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSFgnYjMGS6DRv4yHdTjHc4vcNUNDaLogHuq6POiqxu9PTJSkWMNhZ16DGtAJluhcZ7rEh0VUo+BtbTkViEB/lSeKXYqmOe2Jsp6BPsPXXn7uYQGU6VPX+P1CQstWdrRpEPf4ioxu2lUvXB19beAdgX5Y4CSoOLdsztHJJa0Gqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuCMOZnC; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuCMOZnC"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ef161129bso6964219d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 06:37:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774964231; cv=none;
        d=google.com; s=arc-20240605;
        b=Q2e67gtskt/6jsFIK/rt/4P6X79LTBcizhzLsnC6PouYwUYN93zbpF2l4KIe7A4Y3u
         8TNSk10jE4YNGfqjayHPSnFWfmuNKsAlzH8leot3r+eNp0zYmtR1fwC4Vj88P2NZUqRB
         A4y+Ph0XhpxM+eJ8EHdrEpYTn1DPImCCvYFKHZ4UvGJg9DTk4Xk4P9FHASyr6dR2c/Lv
         LHnrdIsgAtb76L6ZGblV0JOwx3uli268YGV6yDhoVE0k1d+dK1OIoZ4WdMEokVqGLCcz
         Cq+uTWmR/m+01gqduHq9Aqi6nzsGcWe4HLstp2MJ406cu1hSJ/oaQFf3egcQxj37OfG/
         8Qcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OL5MbFIQIM+t92yp+O2PTJMYEG6GU15NK8hnNdvQ8NQ=;
        fh=i0y+9IgFFMFZ4E83IBXbKVpbUb7cU8ndOG/QWjnUZBw=;
        b=CP5AIaPutwwzGnZu/fPMZCtJSUMPEN/GmlaOFFklI+5c+p2Sk5O/2C0h2xcq3vuFOZ
         gG4YhgMn5JL6fxkCz4FudcFWvoTlla2bEuszy9RkHEL2enNz2+5wdd90EsjjlosGlAdj
         fKREDKs+WcFgkeS27IJUuiiRbrqMg/ZRh26yGtajy+cRCyIuZReTqnBsj7AIteEB1KKE
         ja3qxjzvZO0OeMCJ7khVfGzFN+GNTJxpxGVyIZjmqKAAtJmbG+d/tbW49iHV/4Osz2V2
         yYadg/01u+sT3NnRqtoK/3Tzvy/2mktTHycnQNsQCoa2TZFbdxIN0nvwbvA3Xf5iYMdN
         rd5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774964231; x=1775569031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OL5MbFIQIM+t92yp+O2PTJMYEG6GU15NK8hnNdvQ8NQ=;
        b=IuCMOZnC2gRgrmfp2Emf9qfCliLYC16YwzdVEDIKdgr4SN2PSvu3APcRVhEUoNzeks
         fFNiMJ+F1/WXYFODo9pxGpmR4azAk9SIAwh513GMVyVcqULiuT0WqCd8cqZ3sns4FN3J
         f1yUwNMWFBXE9Fo7Q5nhMM93/M8WlUs06eV3n+VWpGnXKGp6VLeVNBdcXG4Kw5Uf2ZG1
         1iKQZVKsV6ERifRMrAAc0LpaZvWQzQ81jPEdcTZZQR7LsqDP5fpw7XmenCMn88gXNd7A
         1sk5pXMqanGoYR8AxEYAPASHFHUHw5BoUbDY3XKeEHohaiuQ1YvjV7qWVyeFTpsqVO/6
         5wLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774964231; x=1775569031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OL5MbFIQIM+t92yp+O2PTJMYEG6GU15NK8hnNdvQ8NQ=;
        b=ExQHDWWk7TpRuM5G1wHT11AxLSuxlOLlIHnf9xQw1A0c6U6+bbaFFCiUMOc9cXgIMN
         1hJiKhv95Wowyg1jFXH49q1n19nMTaFC+bZUOO/OZCIUoR9ae4KPnk9mtI6NsST77BHG
         tCxP0d/mCxpEz1EFtlA0xBihuJRVk2rA5ssX/QXQ52JDDXdNds5iDUWI9TSdF7x8LPSL
         OZEucbgi4s1/grQGFRCdoAwcl4BTxPN8q6JoiduYsUJK75oRJ7Gk5tcyXkcJPdfxv7y3
         PijH7WwyVGOZhm5BuxTeE0qQjOMXIOd2rMAlU6OGOp2hGhpAOJEWkeIEU0v11B3tLjaK
         Nu3g==
X-Forwarded-Encrypted: i=1; AJvYcCWQ5yzxLocCZ+4DxefmU5W+wnUIaG19+TZJco7VQjdpYMQnUNVvIo07or3aXlEqwgw6GnjMPhwuZrkQATXpZXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1LusEwUGqS2nlnVM8ZWAb2qNbtKmaZYZJQDQuGjzo9nponniu
	rWAsGiG+wwkw1+tT7e1fA5q5ZeovwhJTBRtvaA8dqvC7l3OJyiYUqZ96gAcw0err3romfgFjnqb
	HRbNWH2mXyTiRDuPhawdSzjJStmAPBJo=
X-Gm-Gg: ATEYQzwQXzDJIkYzzd1QgjPbZThPIaMcAG6/c0/DDLzhiZIQgvHEJqhLnr078YiSL1W
	MsxyrTjILKXXPQh/psrVG5yNECzoS2ASaR+J7xv1ocrUdMQ1cclxsYlVccyADS7LiAJrxFWovZf
	/2/bykB3N/lHKk/ba0WCNzIpON8yKFFfHwBhe4QEbryHdG5WHX50ESbnH7I7wYJ/3tWEoUZTQzh
	jYNANHZbPpi/ejFPoU2Z3OUa/LBti0AWGZ1uyErP7f9X+RQj4e+xeLezLW4EEdWR0yxLASrebjo
	mRej6OMcGx4hKC/e4LkSHj1dWpE0DhjfZPspOIysSZvqWNqcaTIDFq0TZGc5ARVTRMYedg==
X-Received: by 2002:a05:690e:b44:b0:64f:fed9:caaf with SMTP id
 956f58d0204a3-64ffed9cc90mr16082097d50.31.1774964231033; Tue, 31 Mar 2026
 06:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331055032.1883139-1-hkbinbinbin@gmail.com>
In-Reply-To: <20260331055032.1883139-1-hkbinbinbin@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 31 Mar 2026 09:36:59 -0400
X-Gm-Features: AQROBzCQzpWBjVjJ90mJZrYY1knxOxVJmSPxSH4bRdq_cvrVbzO32WZ3J7Bc05o
Message-ID: <CABBYNZJTEGuMJzKfpO5ZsKhsJYAqrh43JYtt+58ui83umMPY5g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: fix OOB read and infinite loop in hci_le_create_big_complete_evt
To: hkbinbin <hkbinbinbin@gmail.com>
Cc: marcel@holtmann.org, gregkh@linuxfoundation.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hkbinbin,

On Tue, Mar 31, 2026 at 1:50=E2=80=AFAM hkbinbin <hkbinbinbin@gmail.com> wr=
ote:
>
> hci_le_create_big_complete_evt() iterates over BT_BOUND connections
> for a BIG handle using a while loop, accessing ev->bis_handle[i++]
> on each iteration.  However, there is no check that i < ev->num_bis
> before the array access.
>
> When a controller sends a LE_Create_BIG_Complete event with num_bis=3D0
> while BT_BOUND connections exist for that BIG handle, the loop reads
> beyond the valid bis_handle[] entries into adjacent heap memory.
> Since the out-of-bounds values typically exceed HCI_CONN_HANDLE_MAX
> (0x0EFF), hci_conn_set_handle() rejects them and the connection
> remains in BT_BOUND state.  The same connection is then found again
> by hci_conn_hash_lookup_big_state(), creating an infinite loop with
> hci_dev_lock held that blocks all Bluetooth operations:
>
>   Bluetooth: hci0: Invalid handle: 0x6b6b > 0x0eff
>   Bluetooth: hci0: Invalid handle: 0x6b6b > 0x0eff
>   ... (repeats ~177 times)
>   Bluetooth: hci0: Opcode 0x2040 failed: -110
>   Bluetooth: hci0: command 0x2040 tx timeout
>
> The value 0x6b6b is the KASAN slab free poison byte (0x6b),
> confirming reads of freed/uninitialized heap memory.
>
> Fix this by adding a bounds check on i against ev->num_bis before
> accessing the array.  Connections beyond the reported count are
> cleaned up with HCI_ERROR_UNSPECIFIED to prevent the infinite loop.
>
> Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple=
 BISes")
> Cc: stable@vger.kernel.org
> Signed-off-by: hkbinbin <hkbinbinbin@gmail.com>
> ---
>  net/bluetooth/hci_event.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 286529d2e554..ebd7ae75b133 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -7085,6 +7085,12 @@ static void hci_le_create_big_complete_evt(struct =
hci_dev *hdev, void *data,
>                         continue;
>                 }
>
> +               if (i >=3D ev->num_bis) {
> +                       hci_connect_cfm(conn, HCI_ERROR_UNSPECIFIED);
> +                       hci_conn_del(conn);
> +                       continue;
> +               }

https://sashiko.dev/#/patchset/20260331055032.1883139-1-hkbinbinbin%40gmail=
.com

Actually we might want to consider that all BISes failed if something
like this happens, so perhaps we should break and terminate if i !=3D
ev->num_bis


>                 if (hci_conn_set_handle(conn,
>                                         __le16_to_cpu(ev->bis_handle[i++]=
)))
>                         continue;
> --
> 2.51.0
>


--=20
Luiz Augusto von Dentz
