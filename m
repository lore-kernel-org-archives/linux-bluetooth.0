Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171933C4547
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184461; cv=pass; b=Y5H8MEx8zqb7a7/ZbsMDt21I/ZRge3TWcEOyFSUVpNeIN+cOqRfKHiKpPfetKdGz/NQv7QTQxewezHNHPdgEZZiOh4VmoB0kuX9LqmaqVVGPAXgT8Ez+MFXJ9o4oOR5VSKj+iVGbbZ/9cpcR41oFM+E9HkVAR6YdRELVSjNUlek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184461; c=relaxed/simple;
	bh=FBBPz6/hHt7NcmNYXWVhRD8td9ij+TdTA7FvkzOHWsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouT9V1JpwO8QQHH3YE9UQmycvPBOUaq5hVEFLZfyhMVRcxfJ9t59J1VXx2UMBWfifogZV/hoIkq1b0tqhcHF946evOZu70YBb36zB9xJaj1DJLM9GDXrfSsi7Ce8OewKMOGldo4AsRp7fMd/OUUL7BsY1hzntQNNTMZkAEi4+WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZygvWxAN; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZygvWxAN"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66771ded50aso4025954d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 13:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785184458; cv=none;
        d=google.com; s=arc-20260327;
        b=LYLs3y0ZGOe2VgC/VKRu+bP2D+I8+05jgYI8m0i0tVvef4CkVaaW6I5Y+BRsz8U3BI
         e2Rs1W1ZjhLMOKNgWozjImuiTnT1OyBYI2NSy16NxGLrmSq+w7hiQluE+mk02GKyiC7m
         YNSrVGh9Eu+5VWlpx2+Rq8mWp1AOONbpiB0ElOfHGqrl4Zt/94wKaLylZv/L6YSsR34O
         +7HTkkC0Si4ayUeq9VEpDx+KhKWcquZ53XphRTCmbZDPQlxYHWxlbszqN9H8LBEZr+tk
         nezn29fqifpyQVSB7q45xHN/xZIXj6+LSJ0aayTy7uwhd3bK0TIqdqxR5MebujpnVOHm
         n7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cCIrtqCaNpnR1S2nITyG+43cXC5HEEAqaMlfAdHwwe0=;
        fh=oT+qLRBCn0MsQwqnuFM43n0Tjo5mj6SBeL++SXvh7C4=;
        b=CLbm5DS/KHAi3DaGTO5IidrnKepnQej7Dw/nbLjLvDkM6V0GCLXNtNnMwYag4nCIH3
         21jiV8rGiBajIDgRTLekREwfKVr38PT7ljphgV/7UUczX2jqj111LHlN+UDfiQnDSkAJ
         nZt+XAX4kkeTdQQ1oQNTPUU79GmBwGz7gqP3vK8o/7JeylssP4GIqioxzXvjewsFJgzi
         HqfnBniFXWEUFOkou7J3PS7oYMgm9+zTV+/euCubW5Z46WAyrgNAELpPc3PrrPMuDFBG
         mUagpNns+yfTX5nrheYUpPME5e6bMRMsUpn2JTey8JQcJ22u4MscPy38lp14WliO8pom
         n3NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785184458; x=1785789258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cCIrtqCaNpnR1S2nITyG+43cXC5HEEAqaMlfAdHwwe0=;
        b=ZygvWxAN34W3Sa2MGc5S/DUdQfYfBRxhtA0SJbiSq1k8dubju/PIblA2XnqO9gLpsc
         zAPUDb5J6V36HKLMh+YL+Iuq82j89zkvF7J43QPhJnhwk5k7J2WPuq22Rfe12F07Wee/
         SKQv22eS3BRf9N+ZSxuZ+RAH9o8VfqQ7ylul9kH3c0g8exrPyKVUGnkrsyjqIaufS7zz
         cX8/cti/AoOOpUcdgyQKzRNlJ6T3AxcqqavvY9uZyiJMuvAdQ+BPK5aGtv5xTQniL7PL
         C9V4StGHt0bTBo/Py91d+oAnGv4YWsW8fCTEYVPHbgOtdwilTrcZXH6JQWNaEkpTCOsG
         b4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785184458; x=1785789258;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cCIrtqCaNpnR1S2nITyG+43cXC5HEEAqaMlfAdHwwe0=;
        b=isdvdr/0ubXgb+mny/3q0vrmsGGYyrdozrbXBSz67UJQ6Yq2NwFUptNZ/dX3B+JNLi
         ZgMTzwlvtCX2X6ZE+wGbuIsQJNBHGxI/O6n6Msxgt4pPfFcxuQc/eVIRdEkrTYdTtvw9
         o99esDs/+xdC41gZ8eMVT/lqZYRoh8ntaDJ931SG0R8nLfxzKfNqnJeCrZ65nQ9UXZXI
         jL1RLueHH8ZHNOXmhzRQgkz6hJyO56bHgfjkKYabU2V10OofZPZsnwdUx7O1NWvNxldN
         1UxYGYof9fwyjyhmyz1kUQ/geQP90wBuUeoBwgUvMcDvKBKrA1Ni1OxlLnI/+Gtz88aZ
         u7NQ==
X-Gm-Message-State: AOJu0YzuQtpK5ABssuQ7XK2x0yB+DLcIx4mK1DmV5ZH7hdZBeTpvX05v
	3bmn5vc4EZiO/iS1ya1y542p2EMs5RLCNQ0FPwJBQHDjmceGxwF7WQyGIuaT51gRUIoemUSV34c
	1I9GGtVPTq2ownMbWwzF2p/gPl5CuMh1W6w==
X-Gm-Gg: AR+sD10tBW/KLwJ29t+j9y3ccFMYPIlIV3WEfqa+67XrGRUkBobKz1j8nJxNcr3Yxgk
	cwBsbWirK+yIq3Dt+gaeMm1GU3SaxvS5NAShoxeGly6U0foPRbnaGW5LKUTFDPPilIMV3Lv7KMF
	prACeMo9e6FicK4WCQ2DPEpM4nqGAiGdKG/es1o3Wa9VBuD99iVlaxfKqmAx6xCi+zNJpeEmUU2
	fXYpgtIjFTG/v20uM0esoOtYqyyECmCZdHeZHtwJS7oyh352G3TRkVQfHKckSrZ1XEYrVFAvyJl
	XIEALcI7dFPp/tuX7BCQTp/cTpESHH6kYhHNMKK+kukhZ1L0WcON
X-Received: by 2002:a05:690e:43dc:b0:664:9233:7093 with SMTP id
 956f58d0204a3-668c7bb894fmr2033874d50.64.1785184457936; Mon, 27 Jul 2026
 13:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722012311.35434-1-amirabudubai@gmail.com>
In-Reply-To: <20260722012311.35434-1-amirabudubai@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 27 Jul 2026 16:34:06 -0400
X-Gm-Features: AUfX_mx_FeKxi-LWxj8NfXkdkS3xxr9PzNpG_lBcR1PwbsZ2uBIfUwHtgp2BwvU
Message-ID: <CABBYNZJk8sgQKjLKet1pp7fXD0uCo1O33WQ8F4LxN23A2S_r3g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Gate ACL delivery on HCI handle presence
To: Amir Abudubai <amirabudubai@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amir,

On Tue, Jul 21, 2026 at 9:23=E2=80=AFPM Amir Abudubai <amirabudubai@gmail.c=
om> wrote:
>
> On some USB devices, the interrupt-IN endpoint can lag the bulk-IN
> endpoint by multiple polling intervals. Early ACL data can then reach
> HCI before the Connection Complete event establishes its handle, causing
> the data to be dropped for an unknown handle.
>
> This issue was observed and the fix verified on the following adapters:
>   * 8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Adapter
>   * 7392:c611 Edimax Technology Co., Ltd Edimax Bluetooth Adapter
>
> Extend the existing poll_sync queue to support independent release gates
> while preserving its underlying behavior. Add an optional gate which
> holds ACL delivery until the HCI handle appears or a bounded timeout
> expires. Anchor both time gates to packet arrival to prevent timeout
> drift from accumulating as queued packets reach the FIFO head.
>
> BT_HCIBTUSB_EARLY_ACL_HOLD controls whether the gate is enabled by
> default. The force_early_acl_hold debugfs entry controls it per adapter
> while the adapter is down.
>
> Assisted-by: OpenCode:openai/gpt-5.6-sol
> Signed-off-by: Amir Abudubai <amirabudubai@gmail.com>

This really sounds like an over-engineered design; I'm not sure why it
couldn't be done by just increasing the number of polls we wait before
delivering the ACL packet, it has been quite a long while we don't
receive any reports of such races still exists. Also, some vendors use
special handles for debugging, these never have any completing event
or anything.

> ---
>  drivers/bluetooth/Kconfig |  10 ++
>  drivers/bluetooth/btusb.c | 292 +++++++++++++++++++++++++++++++++-----
>  2 files changed, 266 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 4e8c24d757e9..648c0d8b1496 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -56,6 +56,16 @@ config BT_HCIBTUSB_POLL_SYNC
>           Say Y here to enable USB poll_sync for Bluetooth USB devices by
>           default.
>
> +config BT_HCIBTUSB_EARLY_ACL_HOLD
> +       bool "Enable early ACL hold for Bluetooth USB devices by default"
> +       depends on BT_HCIBTUSB
> +       help
> +         Hold ACL packets whose connection handle is not yet known until=
 the
> +         connection appears or a bounded timeout expires.
> +
> +         Say Y here to enable early ACL hold for Bluetooth USB devices b=
y
> +         default.
> +
>  config BT_HCIBTUSB_BCM
>         bool "Broadcom protocol support"
>         depends on BT_HCIBTUSB
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 4d59b28ab30f..a59b0ed91d18 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -34,6 +34,8 @@ static bool disable_scofix;
>  static bool force_scofix;
>  static bool enable_autosuspend =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUS=
PEND);
>  static bool enable_poll_sync =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_POLL_SYNC=
);
> +static bool enable_early_acl_hold =3D
> +       IS_ENABLED(CONFIG_BT_HCIBTUSB_EARLY_ACL_HOLD);
>  static bool reset =3D true;
>
>  static struct usb_driver btusb_driver;
> @@ -956,6 +958,8 @@ struct btqca_data {
>  };
>
>  #define BTUSB_MAX_ISOC_FRAMES  10
> +#define BTUSB_RX_RECHECK_DELAY msecs_to_jiffies(1)
> +#define BTUSB_EARLY_ACL_HOLD_MIN_US    5000U
>
>  #define BTUSB_INTR_RUNNING     0
>  #define BTUSB_BULK_RUNNING     1
> @@ -987,7 +991,10 @@ struct btusb_data {
>         unsigned long flags;
>
>         bool poll_sync;
> +       bool early_acl_hold;
>         int intr_interval;
> +       unsigned long early_acl_timeout;
> +       ktime_t last_event;
>         struct work_struct  work;
>         struct work_struct  waker;
>         struct delayed_work rx_work;
> @@ -1252,14 +1259,100 @@ static inline void btusb_free_frags(struct btusb=
_data *data)
>         spin_unlock_irqrestore(&data->rxlock, flags);
>  }
>
> -static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb=
)
> +static void btusb_rx_queue_purge(struct btusb_data *data)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&data->rxlock, flags);
> +       skb_queue_purge(&data->acl_q);
> +       spin_unlock_irqrestore(&data->rxlock, flags);
> +}
> +
> +static ktime_t btusb_rx_deadline(struct sk_buff *skb, unsigned long time=
out)
>  {
> -       if (data->intr_interval) {
> -               /* Trigger dequeue immediately if an event is received */
> -               schedule_delayed_work(&data->rx_work, 0);
> +       return ktime_add_ns(skb->tstamp, jiffies_to_nsecs(timeout));
> +}
> +
> +static bool btusb_rx_hold_expired(struct sk_buff *skb, unsigned long tim=
eout,
> +                                 ktime_t now)
> +{
> +       return !ktime_before(now, btusb_rx_deadline(skb, timeout));
> +}
> +
> +static unsigned long btusb_rx_hold_delay(struct sk_buff *skb,
> +                                        unsigned long timeout, ktime_t n=
ow)
> +{
> +       s64 remaining =3D ktime_to_ns(ktime_sub(btusb_rx_deadline(skb, ti=
meout),
> +                                             now));
> +
> +       if (remaining <=3D 0)
> +               return 0;
> +
> +       return max_t(unsigned long, 1, nsecs_to_jiffies(remaining));
> +}
> +
> +static bool btusb_poll_sync_should_hold(struct btusb_data *data,
> +                                       struct sk_buff *skb, ktime_t now)
> +{
> +       unsigned long interval =3D READ_ONCE(data->intr_interval);
> +
> +       if (!interval || !ktime_before(data->last_event, skb->tstamp))
> +               return false;
> +
> +       return !btusb_rx_hold_expired(skb, interval, now);
> +}
> +
> +static bool btusb_acl_should_hold(struct btusb_data *data,
> +                                 struct sk_buff *skb, ktime_t now)
> +{
> +       unsigned long timeout =3D READ_ONCE(data->early_acl_timeout);
> +       u16 handle;
> +
> +       if (!timeout || hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL) |=
|
> +           btusb_rx_hold_expired(skb, timeout, now) ||
> +           skb->len < HCI_ACL_HDR_SIZE)
> +               return false;
> +
> +       handle =3D le16_to_cpu(hci_acl_hdr(skb)->handle);
> +
> +       /* Only use the returned connection as an existence snapshot. */
> +       return !hci_conn_hash_lookup_handle(data->hdev, hci_handle(handle=
));
> +}
> +
> +static unsigned long btusb_rx_delay(struct btusb_data *data,
> +                                   struct sk_buff *skb, ktime_t now,
> +                                   bool poll_hold, bool acl_hold)
> +{
> +       unsigned long timeout;
> +
> +       if (poll_hold) {
> +               timeout =3D READ_ONCE(data->intr_interval);
> +               return btusb_rx_hold_delay(skb, timeout, now);
> +       }
> +
> +       if (acl_hold) {
> +               timeout =3D READ_ONCE(data->early_acl_timeout);
> +               return min(BTUSB_RX_RECHECK_DELAY,
> +                          btusb_rx_hold_delay(skb, timeout, now));
>         }
>
> -       return data->recv_event(data->hdev, skb);
> +       return 0;
> +}
> +
> +static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb=
)
> +{
> +       int err;
> +
> +       err =3D data->recv_event(data->hdev, skb);
> +
> +       if (READ_ONCE(data->intr_interval))
> +               data->last_event =3D ktime_get();
> +
> +       if (READ_ONCE(data->intr_interval) ||
> +           READ_ONCE(data->early_acl_timeout))
> +               mod_delayed_work(system_wq, &data->rx_work, 0);
> +
> +       return err;
>  }
>
>  static int btusb_recv_intr(struct btusb_data *data, void *buffer, int co=
unt)
> @@ -1332,14 +1425,31 @@ static int btusb_recv_intr(struct btusb_data *dat=
a, void *buffer, int count)
>
>  static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
>  {
> -       /* Only queue ACL packet if intr_interval is set as it means
> -        * force_poll_sync has been enabled.
> -        */
> -       if (!data->intr_interval)
> +       bool poll_hold, acl_hold;
> +       bool queue_empty;
> +       ktime_t now;
> +
> +       if (!READ_ONCE(data->intr_interval) &&
> +           !READ_ONCE(data->early_acl_timeout))
> +               return data->recv_acl(data->hdev, skb);
> +
> +       now =3D ktime_get();
> +       /* hci_recv_frame() replaces this temporary monotonic arrival tim=
e. */
> +       skb_set_delivery_time(skb, now, SKB_CLOCK_MONOTONIC);
> +
> +       queue_empty =3D skb_queue_empty(&data->acl_q);
> +       poll_hold =3D btusb_poll_sync_should_hold(data, skb, now);
> +       acl_hold =3D btusb_acl_should_hold(data, skb, now);
> +
> +       if (queue_empty && !poll_hold && !acl_hold)
>                 return data->recv_acl(data->hdev, skb);
>
>         skb_queue_tail(&data->acl_q, skb);
> -       schedule_delayed_work(&data->rx_work, data->intr_interval);
> +
> +       if (queue_empty)
> +               schedule_delayed_work(&data->rx_work,
> +                                     btusb_rx_delay(data, skb, now,
> +                                                    poll_hold, acl_hold)=
);
>
>         return 0;
>  }
> @@ -1539,6 +1649,10 @@ static int btusb_submit_intr_urb(struct hci_dev *h=
dev, gfp_t mem_flags)
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
>         struct urb *urb;
>         unsigned char *buf;
> +       unsigned long early_acl_timeout =3D 0;
> +       int intr_interval =3D 0;
> +       unsigned int hold_us;
> +       unsigned int interval_us;
>         unsigned int pipe;
>         int err, size;
>
> @@ -1587,27 +1701,52 @@ static int btusb_submit_intr_urb(struct hci_dev *=
hdev, gfp_t mem_flags)
>         }
>
>         /* Only initialize intr_interval if URB poll sync is enabled */
> -       if (!data->poll_sync)
> -               goto done;
> +       if (data->poll_sync) {
> +               /* The units are frames (milliseconds) for full and low s=
peed
> +                * devices, and microframes (1/8 millisecond) for highspe=
ed and
> +                * SuperSpeed devices.
> +                *
> +                * This is done once on open/resume so it shouldn't chang=
e even
> +                * if force_poll_sync changes.
> +                */
> +               switch (urb->dev->speed) {
> +               case USB_SPEED_SUPER_PLUS:
> +               case USB_SPEED_SUPER:
> +                       intr_interval =3D usecs_to_jiffies(urb->interval =
* 125);
> +                       break;
> +               default:
> +                       intr_interval =3D msecs_to_jiffies(urb->interval)=
;
> +                       break;
> +               }
> +       }
>
> -       /* The units are frames (milliseconds) for full and low speed dev=
ices,
> -        * and microframes (1/8 millisecond) for highspeed and SuperSpeed
> -        * devices.
> -        *
> -        * This is done once on open/resume so it shouldn't change even i=
f
> -        * force_poll_sync changes.
> -        */
> -       switch (urb->dev->speed) {
> -       case USB_SPEED_SUPER_PLUS:
> -       case USB_SPEED_SUPER:   /* units are 125us */
> -               data->intr_interval =3D usecs_to_jiffies(urb->interval * =
125);
> -               break;
> -       default:
> -               data->intr_interval =3D msecs_to_jiffies(urb->interval);
> -               break;
> +       interval_us =3D 0;
> +       if (data->early_acl_hold && urb->interval > 0) {
> +               switch (urb->dev->speed) {
> +               case USB_SPEED_SUPER_PLUS:
> +               case USB_SPEED_SUPER:
> +               case USB_SPEED_HIGH:
> +                       interval_us =3D urb->interval * 125;
> +                       break;
> +               case USB_SPEED_FULL:
> +                       interval_us =3D urb->interval * USEC_PER_MSEC;
> +                       break;
> +               default:
> +                       break;
> +               }
>         }
>
> -done:
> +       if (interval_us) {
> +               /* Allow an event which misses one polling window to arri=
ve in
> +                * the next.
> +                */
> +               hold_us =3D max(BTUSB_EARLY_ACL_HOLD_MIN_US, interval_us =
* 2);
> +               early_acl_timeout =3D usecs_to_jiffies(hold_us);
> +       }
> +
> +       WRITE_ONCE(data->intr_interval, intr_interval);
> +       WRITE_ONCE(data->early_acl_timeout, early_acl_timeout);
> +
>         usb_free_urb(urb);
>
>         return err;
> @@ -2077,18 +2216,22 @@ static int btusb_close(struct hci_dev *hdev)
>
>         BT_DBG("%s", hdev->name);
>
> -       cancel_delayed_work(&data->rx_work);
> +       /* Stop queued RX delivery before shutting down the endpoints. */
> +       cancel_delayed_work_sync(&data->rx_work);
>         cancel_work_sync(&data->work);
>         cancel_work_sync(&data->waker);
>
> -       skb_queue_purge(&data->acl_q);
> -
>         clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
>         clear_bit(BTUSB_BULK_RUNNING, &data->flags);
>         clear_bit(BTUSB_INTR_RUNNING, &data->flags);
>         clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
>
>         btusb_stop_traffic(data);
> +
> +       /* An in-flight URB completion may have requeued RX work. */
> +       cancel_delayed_work_sync(&data->rx_work);
> +
> +       btusb_rx_queue_purge(data);
>         btusb_free_frags(data);
>
>         err =3D usb_autopm_get_interface(data->intf);
> @@ -2114,9 +2257,9 @@ static int btusb_flush(struct hci_dev *hdev)
>
>         BT_DBG("%s", hdev->name);
>
> -       cancel_delayed_work(&data->rx_work);
> +       cancel_delayed_work_sync(&data->rx_work);
>
> -       skb_queue_purge(&data->acl_q);
> +       btusb_rx_queue_purge(data);
>
>         usb_kill_anchored_urbs(&data->tx_anchor);
>         btusb_free_frags(data);
> @@ -2497,11 +2640,40 @@ static void btusb_rx_work(struct work_struct *wor=
k)
>  {
>         struct btusb_data *data =3D container_of(work, struct btusb_data,
>                                                rx_work.work);
> +       unsigned long delay;
> +       unsigned long flags;
>         struct sk_buff *skb;
> +       bool poll_hold, acl_hold;
> +       ktime_t now;
> +
> +       for (;;) {
> +               spin_lock_irqsave(&data->rxlock, flags);
> +               now =3D ktime_get();
> +               skb =3D skb_peek(&data->acl_q);
> +
> +               if (!skb) {
> +                       spin_unlock_irqrestore(&data->rxlock, flags);
> +                       return;
> +               }
> +
> +               poll_hold =3D btusb_poll_sync_should_hold(data, skb, now)=
;
> +               acl_hold =3D btusb_acl_should_hold(data, skb, now);
> +               if (!poll_hold && !acl_hold) {
> +                       skb =3D skb_dequeue(&data->acl_q);
> +                       data->recv_acl(data->hdev, skb);
> +                       spin_unlock_irqrestore(&data->rxlock, flags);
> +                       continue;
> +               }
> +
> +               delay =3D btusb_rx_delay(data, skb, now, poll_hold, acl_h=
old);
> +               spin_unlock_irqrestore(&data->rxlock, flags);
>
> -       /* Dequeue ACL data received during the interval */
> -       while ((skb =3D skb_dequeue(&data->acl_q)))
> -               data->recv_acl(data->hdev, skb);
> +               /* A zero-delay event kick that raced with this worker re=
mains
> +                * pending; schedule_delayed_work() cannot move it later.
> +                */
> +               schedule_delayed_work(&data->rx_work, delay);
> +               return;
> +       }
>  }
>
>  static int btusb_setup_bcm92035(struct hci_dev *hdev)
> @@ -3967,6 +4139,51 @@ static const struct file_operations force_poll_syn=
c_fops =3D {
>         .llseek         =3D default_llseek,
>  };
>
> +static ssize_t force_early_acl_hold_read(struct file *file,
> +                                        char __user *user_buf, size_t co=
unt,
> +                                        loff_t *ppos)
> +{
> +       struct btusb_data *data =3D file->private_data;
> +       char buf[3];
> +
> +       buf[0] =3D data->early_acl_hold ? 'Y' : 'N';
> +       buf[1] =3D '\n';
> +       buf[2] =3D '\0';
> +       return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> +}
> +
> +static ssize_t force_early_acl_hold_write(struct file *file,
> +                                         const char __user *user_buf,
> +                                         size_t count, loff_t *ppos)
> +{
> +       struct btusb_data *data =3D file->private_data;
> +       bool enable;
> +       int err;
> +
> +       err =3D kstrtobool_from_user(user_buf, count, &enable);
> +       if (err)
> +               return err;
> +
> +       /* Only allow changes while the adapter is down */
> +       if (test_bit(HCI_UP, &data->hdev->flags))
> +               return -EPERM;
> +
> +       if (data->early_acl_hold =3D=3D enable)
> +               return -EALREADY;
> +
> +       data->early_acl_hold =3D enable;
> +
> +       return count;
> +}
> +
> +static const struct file_operations force_early_acl_hold_fops =3D {
> +       .owner          =3D THIS_MODULE,
> +       .open           =3D simple_open,
> +       .read           =3D force_early_acl_hold_read,
> +       .write          =3D force_early_acl_hold_write,
> +       .llseek         =3D default_llseek,
> +};
> +
>  #define BTUSB_HCI_DRV_OP_SUPPORTED_ALTSETTINGS \
>                 hci_opcode_pack(HCI_DRV_OGF_DRIVER_SPECIFIC, 0x0000)
>  #define BTUSB_HCI_DRV_SUPPORTED_ALTSETTINGS_SIZE       0
> @@ -4464,6 +4681,7 @@ static int btusb_probe(struct usb_interface *intf,
>                 usb_enable_autosuspend(data->udev);
>
>         data->poll_sync =3D enable_poll_sync;
> +       data->early_acl_hold =3D enable_early_acl_hold;
>
>         err =3D hci_register_dev(hdev);
>         if (err < 0)
> @@ -4473,6 +4691,8 @@ static int btusb_probe(struct usb_interface *intf,
>
>         debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
>                             &force_poll_sync_fops);
> +       debugfs_create_file("force_early_acl_hold", 0644, hdev->debugfs, =
data,
> +                           &force_early_acl_hold_fops);
>
>         return 0;
>
>
> base-commit: 6f55ad8fb0acd861e5c4e526b2272fc71952e1e3
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
