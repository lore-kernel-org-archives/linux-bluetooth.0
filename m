Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4379D3F0750
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525943; cv=pass; b=L7c7MAYwwpvQtIliZQj83nepeRLmRETB30Nlv4QRjJ4ew7dP0ffAedIDaC9p+5XJt+v6V68XSDVB3OZ/cJ8g4jmc0L5by4kvqR6JtoUNTst1rWJpNEEy/R2CbFu3ig3ONL0W+XoIl+8DTn73PzqZKXg8Y//TopIOsEcAjUhcqNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525943; c=relaxed/simple;
	bh=S90ycy4tRH3QBjth/kijjGG9ODJd1eKt3mDGuCPoosM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rd4G4BGTe4P3sF4oniDJQPpUP+TznxMyxz0r3+5rfm74Avz8+s81qFkBCfYTl5KqCBWeehpiRQBxbymtJ6UNQO8DcbBOZkhgfjkBPhcZDfkb7I3QLVfX1UDkk+Q88sYzyrNgYgyA4Af8QAMlsUGS+IP4gxFeDDbQxhaC3lm9UDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auzOVGOA; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auzOVGOA"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81062fdeaf5so34406867b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 12:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785525941; cv=none;
        d=google.com; s=arc-20260327;
        b=brnjwLVXCxdBVOCv50R8k2tcy9m0XyMBzR/J9a0KbPwNvkfXoSrzY605zsLs+zfQzO
         CTz8Rpxo1z5QLpp9OhNDQWeFxvFH7XHaf4IRtvGlSFRvN8F33xifJfx7HtEMzSTsRRv9
         FWxZSOeh7eEL+RLlFsrtrLewdxJWrq+/z2URCqzwt8wwBIzBXW9u1nptdm3+oFLiTJ5j
         wxLmvspalUYrXiO5//J8i3tLdeSiie1If0WzQLRl3wNNwmEBR6GOSntWsX3ea27/URMt
         U0ZsdA5l1H4WPssx83h5M1cAqzMCf4wn//ZCX7Ze1WPPGMErCo+Ipgf5csJZfApeBjqM
         5OlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1xyf0jo2vh/33Eaju6Dp4kAQ5RCw7As82K7kpTj1cNo=;
        fh=IX8aHAoifl9oVDsHvI21IN44BbFTiELLgSzH/biJvEs=;
        b=OCuJfXOaj5Z04cJbWbdSwyEx/+iSaVg9FhTaNYc4UGj/gegtHrcBYy+J9SKC4Nmi1A
         J7AUH/P1/Tr83q3YSr2egkVyWKTyVUqtmnHJB3lAc2QbN6EK4tk3QncWGDD1UA8WWjuE
         190MYKOl5Xo2jQ3BONfoAEvA20B28RYXDuO0LYZX4OB9/1s9uhnonMf31gfBz8Vvun5Q
         IbspOUoxPrh1I9KXR6Pu32DMqGBfcT6h5HZc04zzy3AOBr6C01obnDsnPjsxYu6qC9HW
         ZPYHm80+w4G2Kpu81wf4ScLjcH4rAZdZ4TyYyuHMznE6aRDf9/psruixBEQKIlScHd2P
         nP6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785525941; x=1786130741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1xyf0jo2vh/33Eaju6Dp4kAQ5RCw7As82K7kpTj1cNo=;
        b=auzOVGOA0298lQ844/qAkyKB008ya+mPcFOSXvqhrX8r56sZwTnL3GPTDf37TD601b
         gsftHkLs4W7kPRbUtCrSYztt5566NPjofTUh87ED2l+lNr6LeW3wEFjMs8CNyM2aiso5
         0s1TwxSYyKsP+rZQBfD2RT0zmUxsf91uR0rY8fRuN80tkHQgIUzeQkcCk7Kbd6g26R3m
         M5g/skEHqjwTcSRnMlD5fzR86Tsh8B5zz9dFWYRhIdAY+gRiOpBgp/gtpCbek+0aMuAO
         MhMgrsYENm0Crd571rql9ZjP1lvnCp+1fEU70I7ZPUBq7bYd2d+aPoMP61kj8YIh2mlt
         lVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785525941; x=1786130741;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1xyf0jo2vh/33Eaju6Dp4kAQ5RCw7As82K7kpTj1cNo=;
        b=KtLQ9Fzw+OslGy9gcpuVBR8AqRyHL9eEK7JdEmR4mIQn9b3CxEKMt/UTHcztODjN5+
         HHmuBcfYwt6QDq9xM7IOskw2GlWUm6VHTMgbsqYyU8m/woqOf7/O6Ca2hStnYKsnPJLW
         YQgLhQQ/KMzE7k0y1qfZ4xga7yYfaJOZrfIWu5F7lMWRM2K1KcTKYV4W1PfppxPFfqIr
         L2GsgRxItvl8foDSVMe+XXyCpTu9Nhh4tTStWhCFh8W2u/7sFBlhxzlvj1drfp8tMPOM
         G3w1zE/8zs8VUt8tjbxLHRu2MnuG5F9XWKJp0gRZRjMzziwpY69ZCy5buhSbIyq8DkST
         56AQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBjJOk3wEOvlTbXTtXpz82b0ocrNmqy7BQI3JqUEaaWEiziHQwPS5+leu6yH1AnQh/mrPuGo7Kbt6J0kHuc1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYDc+TMRPciJT7uy3c/pzNhFmbMOjRbwsdUlhaBpA3YjrV3l9m
	4g1lUviGHaqTLZjr6TWMcAgOfXgdtWQgixZqjNaG+JJ3LmWEF8Y2IW9luqTQZ4FtOhe3vp5qzU+
	/Jh9x8diS5XpEwVG0uUmSI13Wz4vFEvk=
X-Gm-Gg: AR+sD12C+j7Si9HOudT8MVH+yurij5FD7CwfBLMEazmkBW9Lhxy9jZRxer2t1FQ35Ia
	mVqWF1I1Vr1p4LcGYxc5tnSnuAUXytIp6dlEDdKyWj1eug4s3PfSR1vWNufy3XW93tMIf8EZTRk
	zBDseuRC9fkPs3KvvINFC92YqXlFyM/Yi9cabr9aK1N3znnpj6j+aUo9A6lBBqXOlenjokkv21G
	qn/9FYkAKieSkBb/O6FNQ2OrvP9gPlJ0egnEJ2/Dos4vHKpEH/WyQCXec5irzfVN6duUX+ovWb0
	9Odh0okNUeTnsBF10PakL0HDG8HTqJc0mvQGObNEbwbFHKCMaWs6kh/5DfQvwad+7jG+0qira5d
	suzCE0T84JAx3e9B/3XeNk4H2rkmNn5uQ8gxMuisVfJ5m/ts=
X-Received: by 2002:a05:690c:4:b0:81e:ba92:b253 with SMTP id
 00721157ae682-81fcbbd3c32mr27835567b3.4.1785525940950; Fri, 31 Jul 2026
 12:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730104103.2080325-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260730104103.2080325-1-nicoyip.dev@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 31 Jul 2026 15:25:29 -0400
X-Gm-Features: AUfX_mx8MIL0Vdvol_s4EExI8VXU0ClgTTiBoG80mkHApZhzKzpw4sRIz1VA3kM
Message-ID: <CABBYNZJx46usjp0_snfRQ7pvWrxPE8NZqSyqyM0rMEsoHgZnow@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: hold conn for LE timeout work
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chengfeng,

On Thu, Jul 30, 2026 at 6:41=E2=80=AFAM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> le_conn_timeout is embedded in struct hci_conn, but queuing the work
> does not hold a reference to the connection. hci_conn_del() uses
> cancel_delayed_work() because synchronous cancellation would deadlock
> when le_conn_timeout() itself calls hci_conn_del() while holding
> hdev->lock.
>
> This leaves the following interleaving possible:
>
>   CPU 0                               CPU 1
>   le_conn_timeout()
>                                       hci_conn_del()
>                                         cancel_delayed_work() =3D false
>                                         hci_conn_cleanup()
>                                           put_device()
>                                             kfree(conn)
>   hci_conn_failed(conn, ...)
>
> The callback then dereferences the released connection. KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in hci_conn_failed+0x232/0x250
>   Read of size 8 at addr ffff8881180e8e20 by task kworker/u33:1/111
>   Workqueue: hci0 le_conn_timeout
>   Call Trace:
>     hci_conn_failed+0x232/0x250
>     le_conn_timeout+0x23e/0x2c0
>     process_one_work+0x61b/0xf50
>     worker_thread+0x45b/0xd10
>
>   Allocated by task 115:
>     __hci_conn_add+0x1758/0x1b90
>     hci_connect_le+0x523/0x780
>     l2cap_chan_connect+0xfca/0x1bd0
>     l2cap_sock_connect+0x310/0x530
>
>   Freed by task 110:
>     kfree+0x149/0x330
>     device_release+0xc8/0x240
>     kobject_put+0x14d/0x280
>     hci_conn_del+0x561/0xe70
>     hci_abort_conn_sync+0x3e3/0x800
>
> Take a connection device reference before queuing le_conn_timeout. Drop
> it when the callback finishes, when queuing fails, or when cancellation
> removes a pending instance. If cancellation races an executing callback,
> the callback retains the reference until its final access, avoiding the
> use-after-free without waiting under hdev->lock.
>
> Fixes: 980ffc0a2cec ("Bluetooth: Fix LE connection timeout deadlock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/bluetooth/hci_conn.c  |  8 ++++++--
>  net/bluetooth/hci_event.c | 25 ++++++++++++++++---------
>  2 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 1966cd153d97..501a2dd2543b 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -723,10 +723,13 @@ static void le_conn_timeout(struct work_struct *wor=
k)
>                 hci_dev_lock(hdev);
>                 hci_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
>                 hci_dev_unlock(hdev);
> -               return;
> +               goto done;
>         }
>
>         hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
> +
> +done:
> +       hci_conn_put(conn);
>  }
>
>  struct iso_list_data {
> @@ -1267,7 +1270,8 @@ void hci_conn_del(struct hci_conn *conn)
>                         hdev->acl_cnt +=3D conn->sent;
>                 break;
>         case LE_LINK:
> -               cancel_delayed_work(&conn->le_conn_timeout);
> +               if (cancel_delayed_work(&conn->le_conn_timeout))
> +                       hci_conn_put(conn);
>
>                 if (hdev->le_pkts) {
>                         if (!hci_conn_num(hdev, LE_LINK) ||
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 741d658e9630..e1e6b5092ce8 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1566,10 +1566,13 @@ static u8 hci_cc_le_set_adv_enable(struct hci_dev=
 *hdev, void *data,
>                 hci_dev_set_flag(hdev, HCI_LE_ADV);
>
>                 conn =3D hci_lookup_le_connect(hdev);
> -               if (conn)
> -                       queue_delayed_work(hdev->workqueue,
> -                                          &conn->le_conn_timeout,
> -                                          conn->conn_timeout);
> +               if (conn) {
> +                       hci_conn_get(conn);
> +                       if (!queue_delayed_work(hdev->workqueue,
> +                                               &conn->le_conn_timeout,
> +                                               conn->conn_timeout))
> +                               hci_conn_put(conn);
> +               }
>         } else {
>                 hci_dev_clear_flag(hdev, HCI_LE_ADV);
>         }
> @@ -1614,10 +1617,13 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci=
_dev *hdev, void *data,
>                         hci_dev_set_flag(hdev, HCI_LE_ADV_0);
>
>                 conn =3D hci_lookup_le_connect(hdev);
> -               if (conn)
> -                       queue_delayed_work(hdev->workqueue,
> -                                          &conn->le_conn_timeout,
> -                                          conn->conn_timeout);
> +               if (conn) {
> +                       hci_conn_get(conn);
> +                       if (!queue_delayed_work(hdev->workqueue,
> +                                               &conn->le_conn_timeout,
> +                                               conn->conn_timeout))
> +                               hci_conn_put(conn);
> +               }
>         } else {
>                 if (cp->num_of_sets) {
>                         if (adv)
> @@ -5771,7 +5777,8 @@ static void le_conn_complete_evt(struct hci_dev *hd=
ev, u8 status,
>                         }
>                 }
>         } else {
> -               cancel_delayed_work(&conn->le_conn_timeout);
> +               if (cancel_delayed_work(&conn->le_conn_timeout))
> +                       hci_conn_put(conn);
>         }
>
>         /* The HCI_LE_Connection_Complete event is only sent once per con=
nection.
> --
> 2.43.0

We might be better off removing the le_conn_timeout completely and
just make hci_le_create_conn_sync -> hci_le_directed_advertising_sync
wait on the connection complete directly rather then using yet another
work that can then race against the likes of hci_conn_del.

--=20
Luiz Augusto von Dentz
