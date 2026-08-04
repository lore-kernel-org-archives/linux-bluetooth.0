Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0DB46AA85
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863580; cv=pass; b=EFtPtpYTyspKySvrMZc6KdruCVQyuCHbPfKCBWw2tuJaRYJVBZXPVB/PXCgccb0qtzASug8Qbtmxljb5LY7f5CwaIFNUlldObaLxA6zaVrn0lbUySHLkH7AeWSyN6gg3UIBCxHXh00hV+MOZ5a7XUhOH9GuaPqB6e+oZpeE0n1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863580; c=relaxed/simple;
	bh=hWOxQobg8ldW59tbLei1oLLiGpx2Ld9GYhoqx0fvAp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udN0Yta552/G6HLvnaMSDV1OEnJt1TqvuvRfUltsnanKSCFXJlRq3nXkDksuxzJQr6EgRUJdKvWksqsGKTrajgBaggpsc9pHcpwHmGLR83p/qfsluNQ6dicemUNYYAGUmiSw2WHu/9KnfYyha2e30fJerEXcUtuwaBqPWnELpxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THY3wBMs; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THY3wBMs"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-668432fe416so20332d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 10:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785863565; cv=none;
        d=google.com; s=arc-20260327;
        b=s3HJdq4zbGYZJWoK+T0/4zBLtXP+PNHcxLh3Z+cv0C1oZQv0DJthKEOtHKUVtQtXZV
         JiRn+/P4vJt/djuPAppT9r+8TdiM/bgHC54sAYNINlRi8jVYup6jRv/wmNKbm1an9Eow
         rkRkWuiktM+fahFowXpJVeyfz4Huk3A0xrz3BMhaWY3zQXWQqamE/OwvdXHETR2v2Di+
         +dUqQ+ynpC8fg9pSe/+jptAcLnXlaBEQVrJPUdrLO5L7tYNOnw5GZM97jbb93JtPyvrg
         MUK2bh9qdOIFq7/ebMRts546OQBBRxfeZWh9zQCmKG6eEzzd5YxxfA+VkpvPoKUxVGH1
         LOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PVTkNYfzNYlAmRE06g5Qd6oywBpWBs0JAsrXYTsIpTs=;
        fh=SM4qslFjbv0F/76iEgPGMkTP1SUzqaz1my3yDRrRFqk=;
        b=EghTE9en8rItyxFFSnHweqvBi64qerLxPSvoGXcn8UKpgtMVPxlzW7szFJwsIpuzDc
         U8AZhX8Zg80SxxlJRG/N7ZOGuKZHocdfHz/8+16zYPIigTjHehP83LL5HgK4tdxPIWNH
         xELngCNXMQkfhpEfKjY1fEX9YxHK2olKxFvcRFdxNk8nRcFKDvT6D98ITDf4BsP/XmsE
         EfOiaThk5gFgey/v+6grw42fQA5iht+uDxk63g+IhdqRDXETdxXRmM6Dgfxc5QUte3zA
         1WPRRGe0aUiXj73C66qHjQvSZqpQyB7/7zRnVcbdU184JhdC2aXrCk0qh4OQStzoS1rY
         5EFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785863565; x=1786468365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PVTkNYfzNYlAmRE06g5Qd6oywBpWBs0JAsrXYTsIpTs=;
        b=THY3wBMsNEQhPOCv6mOnK3mL/k/9kNpHJ/k4QaXsWfQani8m8ijWApRK8Q1qTpxV6Q
         91JNUa8ntEEeyWV9r4cGiC1S7zPiF1L0SN3jeOCk6m6aU2XN4cJCxPsPChXQTJIuusyG
         pBLMJOZ601oGFpOy2fwLYTL5m3qBkeICBMxr9Hd5zU+/s5hZj3RCms2ILI0Sl2IStpvo
         GBIOQeZ552n95Q5USDZXiuTTwaOqbXGt4epwXCjppRZxsiereZodviiNHdRdDJTPJFFM
         MbT+29Sszx4dp7qb2kWZgr2uDHG2aAG6MLC0pvk68zCGGmztLFkPxnMP8LIkQ19j+Y6T
         9V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863565; x=1786468365;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVTkNYfzNYlAmRE06g5Qd6oywBpWBs0JAsrXYTsIpTs=;
        b=Ep6/8BkDkQLtIoj/PZzrG+VppLTIwGouBPQXK0BkezB/WMEsZPfP5GoOxzyXL4mWZd
         7NJMuDD8/zIofQwpeFavKuQP2Sh7at6ixzoahAJHBAg3ciI0anqU6SbH6MfhFeR3mOwC
         m+gB+cwsrh29/o2EZjJh6okBdIANuPOi2yW+82qrd0ePskmlk41rR7yipC9Swt4dH5+d
         qrrz2fgaWHiTyfPPFP8LPrqW5Rs3TmVc5/O/MYswHXyo80l8c1bgdvkcT5Dp7IaJuMKW
         IJ573Be4hfi5aM58aTMW8Fw8XErRMK1lSvEyfMNAvwRZsKeO+8HTikpBjim+/upb8ncC
         Qz8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rov2tZVN31M5zQ7sExRbpWk7Q5GIZMC/FhuOJA8A2kJsbV+Hwda9duQCUatMZv4tEad0J88gUyO+quvMQhgzUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEZtZGD9N9pVfcjar1a6sYx4O/bXbzQ1Y4nmel/LEstfMgaO7S
	xjI6gahC17Jp+F7tJeZjsmtU4xD3F0i/caskDctoO3UZ/YvgdulxbemuUmoH6DtKEMvHrnbis4A
	TLQBojsV5RUlwysZPoEvTjp9MNgB4ezc=
X-Gm-Gg: AR+sD11mnSjJ1Z2d0pO8TEAZg8rLB1Vs7ZwTCrjvE1BmFt7dcsRJCBjPn5UH3s3NQdv
	0ax+3d3/AlsAGtRMkIuf6V5bPllb22AVk5sejZGXiz9Ii88YYQU9APa2tTvyyuOK6Kznksrp+Vg
	wExP7q66fZfd79dxtFDPxL6MbtvPzGV+kT5CJ+e51jrduOCYP3EDmnYpISVlHJWyrntEBoxq2Oq
	KlCG73aa0SL0wIni705QbotCFZq2/MYpyMeMlaWR5LlnIlglSiEcYrrP0tPdIuAowNgD/NcEERu
	KnY48vAodunfIJtWjhr4qXK0U+0vgmt+PsHaw+jfswN2+Cc8d5RGcGOVomjjCac4+YjeWNc9rmT
	cwVNvbKClcrTjPxCEwOfte+S3CTfFucVDNDI=
X-Received: by 2002:a53:a44e:0:b0:667:f20a:4cc8 with SMTP id
 956f58d0204a3-6699ad93aaamr117346d50.51.1785863564366; Tue, 04 Aug 2026
 10:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801145430.3560911-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260801145430.3560911-1-nicoyip.dev@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 4 Aug 2026 13:12:33 -0400
X-Gm-Features: AUfX_mwH7csUONkr6gK5pGwtK6jAUjfdx0TUm4TbZ6bng-ZzDdlQ0byFFuui6_Q
Message-ID: <CABBYNZLH_cZ_4Q+9zEOzJ78tXuVAgRk9QAP8hFyPHTqdOeUYzw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_sync: wait for directed advertising completion
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chengfeng,

On Sat, Aug 1, 2026 at 10:54=E2=80=AFAM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> le_conn_timeout is embedded in struct hci_conn, but queuing the work does
> not hold a reference to the connection.  hci_conn_del() uses
> cancel_delayed_work() because synchronous cancellation would deadlock whe=
n
> le_conn_timeout() itself calls hci_conn_del() while holding hdev->lock.
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
> The callback then dereferences the released connection.  KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in hci_conn_failed+0x232/0x250
>   Read of size 8 at addr ffff8881180e8e20 by task kworker/u33:1/111
>   Workqueue: hci0 le_conn_timeout
>   Call Trace:
>    hci_conn_failed+0x232/0x250
>    le_conn_timeout+0x23e/0x2c0
>    process_one_work+0x61b/0xf50
>    worker_thread+0x45b/0xd10
>
> Remove le_conn_timeout instead of adding another connection reference.
> Have the legacy and extended directed-advertising enable commands wait fo=
r
> the appropriate LE Connection Complete event in hci_le_create_conn_sync()=
.
> The command-sync entry already holds a connection reference until its
> completion callback returns.
>
> Mark directed advertising as an in-flight connection attempt so teardown
> can cancel the wait.  Disable advertising synchronously when that wait
> fails, and preserve HCI_ERROR_ADVERTISING_TIMEOUT for a software timeout.
> There is then no delayed callback that can race with connection deletion.
>
> Fixes: 980ffc0a2cec ("Bluetooth: Fix LE connection timeout deadlock")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-bluetooth/20260730104103.2080325-1-ni=
coyip.dev@gmail.com/
> Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
> Changes in v2:
> - Remove le_conn_timeout instead of adding references around delayed work=
.
> - Wait for LE Connection Complete from both directed-advertising enable p=
aths.
> - Make the wait cancellable and disable advertising after a failed wait.
>
> Link: https://lore.kernel.org/linux-bluetooth/20260730104103.2080325-1-ni=
coyip.dev@gmail.com/ [v1]
>
>  include/net/bluetooth/hci_core.h |  1 -
>  net/bluetooth/hci_conn.c         | 45 --------------------------------
>  net/bluetooth/hci_event.c        | 25 ++----------------
>  net/bluetooth/hci_sync.c         | 42 ++++++++++++++++++++---------
>  4 files changed, 32 insertions(+), 81 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 3df59849dcbe..937c9ba1e6b7 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -761,7 +761,6 @@ struct hci_conn {
>         struct delayed_work disc_work;
>         struct delayed_work auto_accept_work;
>         struct delayed_work idle_work;
> -       struct delayed_work le_conn_timeout;
>
>         struct device   dev;
>         struct dentry   *debugfs;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index b1f911fd4ad6..74bf0686f428 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -687,48 +687,6 @@ static void hci_conn_auto_accept(struct work_struct =
*work)
>                      &conn->dst);
>  }
>
> -static void le_disable_advertising(struct hci_dev *hdev)
> -{
> -       if (ext_adv_capable(hdev)) {
> -               struct hci_cp_le_set_ext_adv_enable cp;
> -
> -               cp.enable =3D 0x00;
> -               cp.num_of_sets =3D 0x00;
> -
> -               hci_send_cmd(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE, sizeof(c=
p),
> -                            &cp);
> -       } else {
> -               u8 enable =3D 0x00;
> -               hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enabl=
e),
> -                            &enable);
> -       }
> -}
> -
> -static void le_conn_timeout(struct work_struct *work)
> -{
> -       struct hci_conn *conn =3D container_of(work, struct hci_conn,
> -                                            le_conn_timeout.work);
> -       struct hci_dev *hdev =3D conn->hdev;
> -
> -       BT_DBG("");
> -
> -       /* We could end up here due to having done directed advertising,
> -        * so clean up the state if necessary. This should however only
> -        * happen with broken hardware or if low duty cycle was used
> -        * (which doesn't have a timeout of its own).
> -        */
> -       if (conn->role =3D=3D HCI_ROLE_SLAVE) {
> -               /* Disable LE Advertising */
> -               le_disable_advertising(hdev);
> -               hci_dev_lock(hdev);
> -               hci_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
> -               hci_dev_unlock(hdev);
> -               return;
> -       }
> -
> -       hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
> -}
> -
>  struct iso_list_data {
>         union {
>                 u8  cig;
> @@ -1121,7 +1079,6 @@ static struct hci_conn *__hci_conn_add(struct hci_d=
ev *hdev, int type,
>         INIT_DELAYED_WORK(&conn->disc_work, hci_conn_timeout);
>         INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
>         INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
> -       INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
>
>         spin_lock_init(&conn->proto_lock);
>
> @@ -1269,8 +1226,6 @@ void hci_conn_del(struct hci_conn *conn)
>                         hdev->acl_cnt +=3D conn->sent;
>                 break;
>         case LE_LINK:
> -               cancel_delayed_work(&conn->le_conn_timeout);
> -
>                 if (hdev->le_pkts) {
>                         if (!hci_conn_num(hdev, LE_LINK) ||
>                             hdev->le_cnt + conn->sent > hdev->le_pkts)
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 741d658e9630..b6b279b5a103 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1557,22 +1557,10 @@ static u8 hci_cc_le_set_adv_enable(struct hci_dev=
 *hdev, void *data,
>
>         hci_dev_lock(hdev);
>
> -       /* If we're doing connection initiation as peripheral. Set a
> -        * timeout in case something goes wrong.
> -        */
> -       if (*sent) {
> -               struct hci_conn *conn;
> -
> +       if (*sent)
>                 hci_dev_set_flag(hdev, HCI_LE_ADV);
> -
> -               conn =3D hci_lookup_le_connect(hdev);
> -               if (conn)
> -                       queue_delayed_work(hdev->workqueue,
> -                                          &conn->le_conn_timeout,
> -                                          conn->conn_timeout);
> -       } else {
> +       else
>                 hci_dev_clear_flag(hdev, HCI_LE_ADV);
> -       }
>
>         hci_dev_unlock(hdev);
>
> @@ -1604,8 +1592,6 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_d=
ev *hdev, void *data,
>                 adv =3D hci_find_adv_instance(hdev, set->handle);
>
>         if (cp->enable) {
> -               struct hci_conn *conn;
> -
>                 hci_dev_set_flag(hdev, HCI_LE_ADV);
>
>                 if (adv)
> @@ -1613,11 +1599,6 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_=
dev *hdev, void *data,
>                 else if (!set->handle)
>                         hci_dev_set_flag(hdev, HCI_LE_ADV_0);
>
> -               conn =3D hci_lookup_le_connect(hdev);
> -               if (conn)
> -                       queue_delayed_work(hdev->workqueue,
> -                                          &conn->le_conn_timeout,
> -                                          conn->conn_timeout);
>         } else {
>                 if (cp->num_of_sets) {
>                         if (adv)
> @@ -5770,8 +5751,6 @@ static void le_conn_complete_evt(struct hci_dev *hd=
ev, u8 status,
>                                                           &conn->init_add=
r_type);
>                         }
>                 }
> -       } else {
> -               cancel_delayed_work(&conn->le_conn_timeout);
>         }
>
>         /* The HCI_LE_Connection_Complete event is only sent once per con=
nection.
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c8d14128c363..714bb1d55926 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -1616,7 +1616,9 @@ int hci_update_scan_rsp_data_sync(struct hci_dev *h=
dev, u8 instance)
>         return __hci_set_scan_rsp_data_sync(hdev, instance);
>  }
>
> -int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
> +static int hci_enable_ext_advertising_sync_ev(struct hci_dev *hdev,
> +                                             u8 instance, u8 event,
> +                                             u32 timeout)
>  {
>         struct hci_cp_le_set_ext_adv_enable *cp;
>         struct hci_cp_ext_adv_set *set;
> @@ -1656,10 +1658,16 @@ int hci_enable_ext_advertising_sync(struct hci_de=
v *hdev, u8 instance)
>                 set->duration =3D cpu_to_le16(duration / 10);
>         }
>
> -       return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE,
> -                                    sizeof(*cp) +
> -                                    sizeof(*set) * cp->num_of_sets,
> -                                    data, HCI_CMD_TIMEOUT);
> +       return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_SET_EXT_ADV_ENABL=
E,
> +                                       sizeof(*cp) +
> +                                       sizeof(*set) * cp->num_of_sets,
> +                                       data, event, timeout, NULL);
> +}
> +
> +int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
> +{
> +       return hci_enable_ext_advertising_sync_ev(hdev, instance, 0,
> +                                                 HCI_CMD_TIMEOUT);
>  }
>
>  int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance)
> @@ -6605,7 +6613,11 @@ static int hci_le_ext_directed_advertising_sync(st=
ruct hci_dev *hdev,
>                         return err;
>         }
>
> -       return hci_enable_ext_advertising_sync(hdev, 0x00);
> +       return hci_enable_ext_advertising_sync_ev(hdev, 0x00,
> +                               use_enhanced_conn_complete(hdev) ?
> +                               HCI_EV_LE_ENHANCED_CONN_COMPLETE :
> +                               HCI_EV_LE_CONN_COMPLETE,
> +                               conn->conn_timeout);
>  }
>
>  static int hci_le_directed_advertising_sync(struct hci_dev *hdev,
> @@ -6656,8 +6668,12 @@ static int hci_le_directed_advertising_sync(struct=
 hci_dev *hdev,
>
>         enable =3D 0x01;
>
> -       return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
> -                                    sizeof(enable), &enable, HCI_CMD_TIM=
EOUT);
> +       return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_SET_ADV_ENABLE,
> +                                       sizeof(enable), &enable,
> +                                       use_enhanced_conn_complete(hdev) =
?
> +                                       HCI_EV_LE_ENHANCED_CONN_COMPLETE =
:
> +                                       HCI_EV_LE_CONN_COMPLETE,
> +                                       conn->conn_timeout, NULL);
>  }
>
>  static void set_ext_conn_params(struct hci_conn *conn,
> @@ -6761,6 +6777,7 @@ static int hci_le_create_conn_sync(struct hci_dev *=
hdev, void *data)
>                 /* Pause advertising while doing directed advertising. */
>                 hci_pause_advertising_sync(hdev);
>
> +               set_bit(HCI_CONN_CREATE, &conn->flags);
>                 err =3D hci_le_directed_advertising_sync(hdev, conn);
>                 goto done;
>         }
> @@ -6847,7 +6864,9 @@ static int hci_le_create_conn_sync(struct hci_dev *=
hdev, void *data)
>  done:
>         clear_bit(HCI_CONN_CREATE, &conn->flags);
>
> -       if (err =3D=3D -ETIMEDOUT)
> +       if (err && conn->role =3D=3D HCI_ROLE_SLAVE)
> +               hci_disable_advertising_sync(hdev);
> +       else if (err =3D=3D -ETIMEDOUT)
>                 hci_le_connect_cancel_sync(hdev, conn, 0x00);
>
>         /* Re-enable advertising after the connection attempt is finished=
. */
> @@ -7184,9 +7203,8 @@ static void create_le_conn_complete(struct hci_dev =
*hdev, void *data, int err)
>         if (conn !=3D hci_lookup_le_connect(hdev))
>                 goto unlock;
>
> -       /* Flush to make sure we send create conn cancel command if neede=
d */
> -       flush_delayed_work(&conn->le_conn_timeout);
> -       hci_conn_failed(conn, bt_status(err));
> +       hci_conn_failed(conn, conn->role =3D=3D HCI_ROLE_SLAVE && err =3D=
=3D -ETIMEDOUT ?
> +                        HCI_ERROR_ADVERTISING_TIMEOUT : bt_status(err));
>
>  unlock:
>         hci_dev_unlock(hdev);
> --
> 2.43.0

Looks like there is a problem when the command generates a command
complete it bypass the custom event matching, so we will need to fix
that first:

https://sashiko.dev/#/patchset/20260801145430.3560911-1-nicoyip.dev%40gmail=
.com

--=20
Luiz Augusto von Dentz
