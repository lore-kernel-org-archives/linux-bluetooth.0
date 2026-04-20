Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45783C342B
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776712656; cv=pass; b=YZyI+hAkiunJHO2gcVZ+bOx1cxsXsEYrzO+yv2uzncv7OBpGmvxWOJRULoSJKzfUPFpIkWdzDj0Lxchdv1EuA/By0d9ncdUl2ratbx28QrdUMEKqt3PBbYkBQB/mkbVe39yb0DgKMFxeVO/ZfOTfe/6U9ZoHXiYiYHd+UWor49c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776712656; c=relaxed/simple;
	bh=e/y0Pfu4Dq1Q5qmvf4rLxAev2cdUMuF47zxeKhZGvt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8sv3m1pl7DUFXVvUCW25G7YMUIWV0STRcUsvTY8RnAnsflxXghz2TElRnOT/5REKd8a64nUYUMIROXveFjaukApwhzk9twTrJP2t9b7z5qR0Rx9VX7ISL5frz6UYcj1rX+A5Si6clIt5m/04TXbIcindAbzK1/PFEwUhx+IHNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxVivFAV; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxVivFAV"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-650789b22e3so3896907d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 12:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776712654; cv=none;
        d=google.com; s=arc-20240605;
        b=Re8uhSoUPvZM9IRyjFBL3bE8OxMLmQj7e0CEbaSeR4dwlRRzRyVMggYeuFADmBxJ30
         WCqxMTJJAu11D8+mjWu3LZhVwbAb3JIw7qjv67mvuuXyfkIWxSsJLaIr0K8mUQT9YmQz
         V3qnVSovpJgrLkvxZ8/xb+v2bKHCKcLI3F+zmU6b4MuVtIMbkhZw53E63Fcqim5gFn1p
         KGt+Bg53nwV4MuKdGWzkVUqEnqNzGiUWb1RAkaAu4zwcItpOL/mAdZoyMLDgAQI90x5Y
         Ky37yHo4TazltFPuq+X9LYt//3FX6dpfdi+mXExiwtUaw1VbsDZBnyXEWaqOxyTtGk6L
         A7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LqId3eMMe5rDOg5MnTzpXj8ZIYTviI3UDAXasv1bsS0=;
        fh=hKqOnwLCl8SgX35Wtfz0k7Z43vvjyngXfQ9y70kb/8Q=;
        b=Eo+rYr3Qic7H7mcpojYtmLn42G3/v4g25Sm8JMLxif2ivxguQWV9gyaV1DbcC6zcVF
         0K47tRnkTER/Ea8NYMOOLJ9PWch5h0r8r6cGriYloFxrh7i7ACeX+6oyaKLF8mGJ+RmV
         ez76msT23IjoWtbIjXgylfywTV+icl2DibqtQ2IYmXrBARn0W7DT0hGnf2uOKvDMUBf/
         wU3ZwnHkPLdss5fiS1p3M9k85pDuzY9n6hYZ/SeCvv6AgRtGnJKHFpvuTV94REL6J/Ak
         f2ovgIeEwW2Zyx/tlrlJb/BJhthdlyFFgL6qer9FwFINCWkSrAFFCkJymPo68RqcaP9P
         xhCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776712654; x=1777317454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqId3eMMe5rDOg5MnTzpXj8ZIYTviI3UDAXasv1bsS0=;
        b=bxVivFAVnVq3IZw7WMoc9EZ4j7+Tu7LRD4xSgq5a4WgVGFApHCYG1lz0ALCigOpICa
         LTRmdtTR8s0BMyFbxrLG2DTe7BK2V+/zq10lP+9RRjyu0psSKK190AG4xYlm2Ay0Es+0
         v7kt+5NwGDvPRch/rlWv7ZYcYSBH3+i9mW/WQpnFwQW5nX7HaMJfCh3yfro4LLgpPUwP
         sHmD0uctoueWDNogP6i+AZtuWhLHsh78VM0iurdaT5EID7H+/nbnVYuTfLpvnf1iIY6l
         CXug1L5JsDmvUlV8C5sUKMWGDDVtiY/w8rsj1s71ORPgnj0DMAEpWQWcPo+rA3yGjj/k
         XzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776712654; x=1777317454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LqId3eMMe5rDOg5MnTzpXj8ZIYTviI3UDAXasv1bsS0=;
        b=kvIdIzeG6Sb3dTHdF02wn39Gl/v2Bb9Mh9BTywnJPhEjJv4B6AchcyegcZvVRTIkY8
         +NlIKd4mby+urjt8zj5DEc2VH0px0CHPBXAANlOlXoFfjeSwiqLHqZQzqBpdC4PlJEbl
         sF3CwTW8n+tJ4EEeT0jOHrVVEqLHV0ssZZKlVg3rH5dRZPY4iqNTJMQ3AAryeAXISP1f
         /+TRN05MiFs6/ZoLTDIVwbUDInujf3eXvfu/iSUsCT5Mvh+mIw/07vuuXO37q2T5Ju7p
         0VkosrXZ48wKxx8IEVMwxZlYYBV4JnicoIjx7P5LGwo6GySjcAntroYkdr69kmatBNhl
         NlKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/kH/a1AeuCQ4n4Se9KEYH4PAl2wyNXWa0YzSuW/TYdn/Kt+DjaT8/Xc+17e0Oj8ld1OklTvJRNCRmXGqi2A+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4CA7Qdird5OOBxsMw5yWCjAecDLs7k+PWeHWCLiAz/i52pXW
	tlfGpphyd70BbiSxHCu4/2mJ2NPFW19Xa6EEAr/76rIepbR+g8Wob1Amn4cnVWlqsSTH6tZr7eB
	rhYomxahOsgBBU1QlUeSDTgTh2x52McY=
X-Gm-Gg: AeBDiesBmhHd8KkWb26YG1Lzh7P11JjZDCoCPKVLtwtEHZdealOEHy/Wajs6pG1RFBE
	I8OMjISbot8wXe/Z3w5np413WqHwXbp+wr7h4aC+jwUzUNkehDPaSdYBQiKbjHXw8Vbmz3e8P8P
	fCp/a7KeHF8mkNTqHs/FokNGsrbQwPSb8ag2cxi4cDKl5xOQ1Q0jL2dOtiG/hRMAmCLOkYD5kOx
	ZzXaxUYihXLwGvrMsHPI0ybVJDRL78iMwG+7ibRcItDly8cBCa8TQwzQGfnCoL8w88Wlp8DTSKx
	56AxiZL7lov30bKP8slrVffAHj+VC5ujXpztzrmZEYi0i5OvUMEw3tx2+th3Q9M32MNmlT5jCwK
	Alg==
X-Received: by 2002:a05:690e:4141:b0:650:2ff9:d656 with SMTP id
 956f58d0204a3-653108b5176mr14907504d50.29.1776712653576; Mon, 20 Apr 2026
 12:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418000138.1848813-1-michael.bommarito@gmail.com>
In-Reply-To: <20260418000138.1848813-1-michael.bommarito@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Apr 2026 15:17:20 -0400
X-Gm-Features: AQROBzB7p2eqNslJGxxV9DmwoYgd1f6Ag_8dEyj71H75g_Ar-pjlqehIUD42okY
Message-ID: <CABBYNZKP-Rwumw0c7FHEsL5e6XpFZCBA-O2avNujtYgRHeVZhA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: virtio_bt: clamp rx length before skb_put
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Soenke Huster <soenke.huster@eknoes.de>, 
	"Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Fri, Apr 17, 2026 at 8:01=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> virtbt_rx_work() calls skb_put(skb, len) where len comes directly
> from virtqueue_get_buf() with no validation against the skb we
> posted.  The RX skb is allocated as alloc_skb(1000) in
> virtbt_add_inbuf().  A malicious or buggy virtio-bt backend that
> reports used.len larger than the skb's tailroom causes skb_put() to
> call skb_over_panic() in net/core/skbuff.c, which triggers
> BUG() and panics the guest.
>
> Reproduced on a QEMU 9.0 whose virtio-bt backend reports
> used.len =3D 4096 into a 1000-byte rx skb:
>
>   skbuff: skb_over_panic: text:ffffffff83958e84 len:4096 put:4096
>       head:ffff88800c071000 data:ffff88800c071000 tail:0x1000
>       end:0x6c0 dev:<NULL>
>   ------------[ cut here ]------------
>   kernel BUG at net/core/skbuff.c:214!
>   Call Trace:
>    skb_panic+0x160/0x162
>    skb_put.cold+0x31/0x31
>    virtbt_rx_work+0x94/0x250
>    process_one_work+0x80d/0x1510
>    worker_thread+0x4af/0xd20
>    kthread+0x2cc/0x3a0
>
> Reject any len that exceeds skb_tailroom().  Drop the skb on the
> error path; virtbt_add_inbuf() reposts a fresh one for the next
> iteration.  With the check in place the same harness runs without
> BUG(); the driver logs "rx reply len %u exceeds skb tailroom %u"
> and the device keeps running.
>
> Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer overflow in=
 USB transport layer"),
> which hardened the USB 9p transport against unchecked device-reported len=
gth.
>
> Fixes: 160fbcf3bfb9 ("Bluetooth: virtio_bt: Use skb_put to set length")
> Cc: stable@vger.kernel.org
> Cc: Soenke Huster <soenke.huster@eknoes.de>
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
>  drivers/bluetooth/virtio_bt.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.=
c
> index 76d61af8a275..157e68b6e75f 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -227,8 +227,15 @@ static void virtbt_rx_work(struct work_struct *work)
>         if (!skb)
>                 return;
>
> -       skb_put(skb, len);
> -       virtbt_rx_handle(vbt, skb);
> +       if (len > skb_tailroom(skb)) {
> +               bt_dev_err(vbt->hdev,
> +                          "rx reply len %u exceeds skb tailroom %u\n",
> +                          len, skb_tailroom(skb));
> +               kfree_skb(skb);
> +       } else {
> +               skb_put(skb, len);
> +               virtbt_rx_handle(vbt, skb);
> +       }
>
>         if (virtbt_add_inbuf(vbt) < 0)
>                 return;
> --
> 2.53.0

https://sashiko.dev/#/patchset/20260418000138.1848813-1-michael.bommarito%4=
0gmail.com

All seem like valid comments to me, first one is odd to me thought,
never would have though that skb_tailroom wouldn't be enough to check
if using `skb_put` is safe.

--=20
Luiz Augusto von Dentz
