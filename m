Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9F342177
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545418; cv=pass; b=jDkYgT08PIvUceVi7O2FWKVqUMpAR1q8ENGhB+FRRKUqbFIK4wNWWPY9EE8bWz7b5SCOPUWbkcU9gtUilEDueG4hD5hv1aZBnYi2+A2/Y3GHFhYmi10CwnHFqVfZ6TVLiNlMT5LDUaRRnMGPtqtQeqDdFu0P3Y0GtYliqL8HIgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545418; c=relaxed/simple;
	bh=XpGGKH0+jHnbkTx4XXcFRGePkyMxcMWfvg1wX52P9i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3jYAZUXlMq425vV7ietz2lrFRsmp3KvS7nmbha1NIAwwgVbzzjewWVXPk+2xWGBrndnMD7ncJv+7Q7F9kC0xY4bXZHdAYI0EBqsA3t7u5blOu9gwn4xwKgLkVuTOS2M/GHQggWZjzjJI/vOvNNKhXHnoFaQ6pp4/gBHmFDWbp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JogsVsu7; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JogsVsu7"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64edf260b49so1576434d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 10:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774545415; cv=none;
        d=google.com; s=arc-20240605;
        b=LUAZRYHOdz03pxeIdA3zVFvSy4fyfXWjyB1adDQlIDT8WITJrQLELKzm4JlG+lburI
         NjgfYJ4xNlv6mwAieG4ECJcLmUrJZ0T4aiS+jq+OPlIjFSpyZRDPA+7xsS3yLSSTTKQl
         7drMdCycSJJrYQ9LhGzuWAt61bJeDXIFnWhzL522GPrW/Rk3KXim0b86xiSKb/RDGsvy
         AZishaDZEWx9J2e/0GwYMTwlFCjNUUUYsAXQFAuJ5GiHkZqZVG97xoNbPPeksYo6te6M
         EG6bXCstp+O97a034eGRmCN5Y8lp7NGMlvFtSn/n6j8q6VQiZ+kDqB9S8dkkoZ67wTM/
         kuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/out/Pg+eC1Z2v3A8N9eV3ek0NeKXkekWp4rHbti2gk=;
        fh=0gNuo3HbqiW99Xlq627bxqC6UuzxHZi2Fi7U0nP15cI=;
        b=iR9UAhIamMF1k8V41GdoGzyo0a20m8B6BwxUj0MaMdLZ7ZQw9G0WW4ZEyTHOCENisU
         cW71GKL3/PVEKNRowEVBMaJvbiDa/2Wj1pF6TYMpqMwQuZ96pcloc3k8bNLxFxl54+pi
         b2xCj9b7EnZaBMO8cZz6lAgnqFTR3Fdnw97MqTNf6oYls0ZZ08T5H1ErV7Picr2M9cLJ
         5toVGyfjpcJZMKcKU4sqRCv+TBXq575BcEJAf+P2sKpiSzNyK6tQ/yT+nOjvkcQZV7Wl
         OgcQ1zMoYUgHgG66RRA+q1UPsAgsmBoNkSSDYd3Qh4Da37GRhGKPuckfAPUtEqwqfM2H
         54iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774545415; x=1775150215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/out/Pg+eC1Z2v3A8N9eV3ek0NeKXkekWp4rHbti2gk=;
        b=JogsVsu7i8eoTAcPkMYZxq8iRuU9W5GExeU4BeqUdF3cFYYhnmmpLsZ8qjDk/oeQRy
         xQgdOWpWRTH8I1GtLqsFqlCU8IRbTi/PLYm1xli9c5RBWeOmkEUhwfCaF3ZlxRS74m8K
         S03o2p9J7HGzWmB2J+WNIcsPaip5Kmi+SkTfHrJkwrq2dlqKzKyGvsoqRsUdXMX3mJhr
         LIDA5hJy3hppoPFuN6HBKUGOPwvrbpPVAw4zMzAg6S3tY0NXk4+bjVrn1Bgyc2Ciwc/t
         4wyvkK7GMv8FA1xHlBhjKKuufSeW/HPtjU63qIjDOD3tcsT4UqtmqVsf2tPp8R9HaeRv
         uJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774545415; x=1775150215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/out/Pg+eC1Z2v3A8N9eV3ek0NeKXkekWp4rHbti2gk=;
        b=kvX/4YnLFTvgZQhLl3PXPwImakpiA4aDm2VO+QYmdKiPmwV0VfuGfqU7d8iRW1s9KA
         luSfl9SRnznGUMDUtOKJJg3jz2fKglMuMamzsUuXII9+oNffC0FfFBITknCNlH7gmqZe
         iMKAGsnIrAqRpHb+r9zgbi4fIm2AG4r70/SJJRx5LV3yBET14MJpctQ3+KDN0397sr0Z
         goJ7dJLhQiMiemqXxALBQPFrRkTlNMtfRuZymYpW70qZ3UP5bfVLHnLW8XFVjGhe2lGE
         idRveJXikrYAgCIbbKUNnblnzIqrkAer8hu/QTzWH9/V0laJuXNBvGTODlu4RtQOqlyr
         w/NA==
X-Gm-Message-State: AOJu0Yyq6MUDlPSd0b6cN8jWFZrRUq7DfpOkvVUfyTjb4+BCUblie5aU
	3O9IHd2J44SRGRBNJXGALp5XVtWfQBNndUbm3F3DTbJbQX1W/3U48uguqiEVEyPAVLkY8iTKwmS
	gCOxsU6gyLQ8ynG9nxaSmWEw7/HzBBD9GBo3BGm0=
X-Gm-Gg: ATEYQzyNvzCVZAECWYPpJo+p3Tq8FXtgBGC1X6e1yTaGlfT7E8P3ihApYwG/c2qWGSZ
	s88RYummxPBpwzQq9qaX+Di2MAR0Hpz3ZxkFg7THud9OvzX2V2XBZOTnpeRfeh17uhBbOnZfTzs
	dwqpVgtV0V1fifeSWYgudBDzfKrefMEY/QZzBVwvtiM0KxL8J2wZ0dP8pTn4enu+hCcKvzhRgsF
	Mtgl7cxe5JkKetpKOEYnXJqi1tdmivPepl802kLQgAbrQOmC3IWZ9xyl2iFR1aGyoeKb84JOB9c
	GWstW3MMu49I8RQo0yxNV1kABkicMV5ur3CyDp3Ux9Ph245Se1q6xYCs8qjFiDXfHs1IcZjgdZp
	/52v+
X-Received: by 2002:a05:690e:b8c:b0:64f:b8af:3595 with SMTP id
 956f58d0204a3-64fee1d9a44mr1868046d50.17.1774545414483; Thu, 26 Mar 2026
 10:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <798ca355ce0144488610929e6c13e383.security@1.0.0.127.in-addr.arpa>
In-Reply-To: <798ca355ce0144488610929e6c13e383.security@1.0.0.127.in-addr.arpa>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Mar 2026 13:16:43 -0400
X-Gm-Features: AQROBzDkB_gnah06z1tnOE9musoqsKMA1N7J6IXrdXzfGTUIESodA9_4JmsUdpI
Message-ID: <CABBYNZLzVwa=Jq2GFJ96G0JCFEQjyY6yAEfrHsuwBXGmfEiyaw@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: hci_event: move wake reason storage into
 validated event handlers
To: Oleh Konko <security@1seal.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"marcel@holtmann.org" <marcel@holtmann.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oleh,

On Thu, Mar 26, 2026 at 11:06=E2=80=AFAM Oleh Konko <security@1seal.org> wr=
ote:
>
> hci_store_wake_reason() is called from hci_event_packet() immediately
> after stripping the HCI event header but before hci_event_func()
> enforces the per-event minimum payload length from hci_ev_table.
> This means a short HCI event frame can reach bacpy() before any bounds
> check runs.
>
> Rather than duplicating skb parsing and per-event length checks inside
> hci_store_wake_reason(), move wake-address storage into the individual
> event handlers after their existing event-length validation has
> succeeded. Convert hci_store_wake_reason() into a small helper that only
> stores an already-validated bdaddr while the caller holds hci_dev_lock().
> Use the same helper after hci_event_func() with a NULL address to
> preserve the existing unexpected-wake fallback semantics when no
> validated event handler records a wake address.
>
> Annotate the helper with __must_hold(&hdev->lock) and add
> lockdep_assert_held(&hdev->lock) so future call paths keep the lock
> contract explicit.
>
> Call the helper from hci_conn_request_evt(), hci_conn_complete_evt(),
> hci_le_adv_report_evt(), hci_le_ext_adv_report_evt(), and
> hci_le_direct_adv_report_evt().
>
> Fixes: 2f20216c1d6f ("Bluetooth: Emit controller suspend and resume event=
s")
> Cc: stable@vger.kernel.org
> Signed-off-by: Oleh Konko <security@1seal.org>
> ---
> v5:
> - add __must_hold(&hdev->lock) and lockdep_assert_held(&hdev->lock)
>
>  net/bluetooth/hci_event.c | 90 ++++++++++++++-------------------------
>  1 file changed, 31 insertions(+), 59 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 286529d2e554..cb27037eeef5 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -80,6 +80,10 @@ static void *hci_le_ev_skb_pull(struct hci_dev *hdev, =
struct sk_buff *skb,
>         return data;
>  }
>
> +static void hci_store_wake_reason(struct hci_dev *hdev,
> +                                 const bdaddr_t *bdaddr, u8 addr_type)
> +       __must_hold(&hdev->lock);
> +
>  static u8 hci_cc_inquiry_cancel(struct hci_dev *hdev, void *data,
>                                 struct sk_buff *skb)
>  {
> @@ -3111,6 +3115,7 @@ static void hci_conn_complete_evt(struct hci_dev *h=
dev, void *data,
>         bt_dev_dbg(hdev, "status 0x%2.2x", status);
>
>         hci_dev_lock(hdev);
> +       hci_store_wake_reason(hdev, &ev->bdaddr, BDADDR_BREDR);
>
>         /* Check for existing connection:
>          *
> @@ -3274,6 +3279,10 @@ static void hci_conn_request_evt(struct hci_dev *h=
dev, void *data,
>
>         bt_dev_dbg(hdev, "bdaddr %pMR type 0x%x", &ev->bdaddr, ev->link_t=
ype);
>
> +       hci_dev_lock(hdev);
> +       hci_store_wake_reason(hdev, &ev->bdaddr, BDADDR_BREDR);
> +       hci_dev_unlock(hdev);
> +
>         /* Reject incoming connection from device with same BD ADDR again=
st
>          * CVE-2020-26555
>          */
> @@ -6403,6 +6412,8 @@ static void hci_le_adv_report_evt(struct hci_dev *h=
dev, void *data,
>                                         info->length + 1))
>                         break;
>
> +               hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_t=
ype);
> +
>                 if (info->length <=3D max_adv_len(hdev)) {
>                         rssi =3D info->data[info->length];
>                         process_adv_report(hdev, info->type, &info->bdadd=
r,
> @@ -6491,6 +6502,8 @@ static void hci_le_ext_adv_report_evt(struct hci_de=
v *hdev, void *data,
>                                         info->length))
>                         break;
>
> +               hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_t=
ype);
> +
>                 evt_type =3D __le16_to_cpu(info->type) & LE_EXT_ADV_EVT_T=
YPE_MASK;
>                 legacy_evt_type =3D ext_evt_type_to_legacy(hdev, evt_type=
);
>
> @@ -6834,6 +6847,8 @@ static void hci_le_direct_adv_report_evt(struct hci=
_dev *hdev, void *data,
>         for (i =3D 0; i < ev->num; i++) {
>                 struct hci_ev_le_direct_adv_info *info =3D &ev->info[i];
>
> +               hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_t=
ype);
> +
>                 process_adv_report(hdev, info->type, &info->bdaddr,
>                                    info->bdaddr_type, &info->direct_addr,
>                                    info->direct_addr_type, HCI_ADV_PHY_1M=
, 0,
> @@ -7517,73 +7532,29 @@ static bool hci_get_cmd_complete(struct hci_dev *=
hdev, u16 opcode,
>         return true;
>  }
>
> -static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
> -                                 struct sk_buff *skb)
> +static void hci_store_wake_reason(struct hci_dev *hdev,
> +                                 const bdaddr_t *bdaddr, u8 addr_type)
> +       __must_hold(&hdev->lock)
>  {
> -       struct hci_ev_le_advertising_info *adv;
> -       struct hci_ev_le_direct_adv_info *direct_adv;
> -       struct hci_ev_le_ext_adv_info *ext_adv;
> -       const struct hci_ev_conn_complete *conn_complete =3D (void *)skb-=
>data;
> -       const struct hci_ev_conn_request *conn_request =3D (void *)skb->d=
ata;
> -
> -       hci_dev_lock(hdev);
> +       lockdep_assert_held(&hdev->lock);
>
>         /* If we are currently suspended and this is the first BT event s=
een,
>          * save the wake reason associated with the event.
>          */
>         if (!hdev->suspended || hdev->wake_reason)
> -               goto unlock;
> +               return;
> +
> +       if (!bdaddr) {
> +               hdev->wake_reason =3D MGMT_WAKE_REASON_UNEXPECTED;
> +               return;
> +       }
>
>         /* Default to remote wake. Values for wake_reason are documented =
in the
>          * Bluez mgmt api docs.
>          */
>         hdev->wake_reason =3D MGMT_WAKE_REASON_REMOTE_WAKE;
> -
> -       /* Once configured for remote wakeup, we should only wake up for
> -        * reconnections. It's useful to see which device is waking us up=
 so
> -        * keep track of the bdaddr of the connection event that woke us =
up.
> -        */
> -       if (event =3D=3D HCI_EV_CONN_REQUEST) {
> -               bacpy(&hdev->wake_addr, &conn_request->bdaddr);
> -               hdev->wake_addr_type =3D BDADDR_BREDR;
> -       } else if (event =3D=3D HCI_EV_CONN_COMPLETE) {
> -               bacpy(&hdev->wake_addr, &conn_complete->bdaddr);
> -               hdev->wake_addr_type =3D BDADDR_BREDR;
> -       } else if (event =3D=3D HCI_EV_LE_META) {
> -               struct hci_ev_le_meta *le_ev =3D (void *)skb->data;
> -               u8 subevent =3D le_ev->subevent;
> -               u8 *ptr =3D &skb->data[sizeof(*le_ev)];
> -               u8 num_reports =3D *ptr;
> -
> -               if ((subevent =3D=3D HCI_EV_LE_ADVERTISING_REPORT ||
> -                    subevent =3D=3D HCI_EV_LE_DIRECT_ADV_REPORT ||
> -                    subevent =3D=3D HCI_EV_LE_EXT_ADV_REPORT) &&
> -                   num_reports) {
> -                       adv =3D (void *)(ptr + 1);
> -                       direct_adv =3D (void *)(ptr + 1);
> -                       ext_adv =3D (void *)(ptr + 1);
> -
> -                       switch (subevent) {
> -                       case HCI_EV_LE_ADVERTISING_REPORT:
> -                               bacpy(&hdev->wake_addr, &adv->bdaddr);
> -                               hdev->wake_addr_type =3D adv->bdaddr_type=
;
> -                               break;
> -                       case HCI_EV_LE_DIRECT_ADV_REPORT:
> -                               bacpy(&hdev->wake_addr, &direct_adv->bdad=
dr);
> -                               hdev->wake_addr_type =3D direct_adv->bdad=
dr_type;
> -                               break;
> -                       case HCI_EV_LE_EXT_ADV_REPORT:
> -                               bacpy(&hdev->wake_addr, &ext_adv->bdaddr)=
;
> -                               hdev->wake_addr_type =3D ext_adv->bdaddr_=
type;
> -                               break;
> -                       }
> -               }
> -       } else {
> -               hdev->wake_reason =3D MGMT_WAKE_REASON_UNEXPECTED;
> -       }
> -
> -unlock:
> -       hci_dev_unlock(hdev);
> +       bacpy(&hdev->wake_addr, bdaddr);
> +       hdev->wake_addr_type =3D addr_type;
>  }
>
>  #define HCI_EV_VL(_op, _func, _min_len, _max_len) \
> @@ -7830,14 +7801,15 @@ void hci_event_packet(struct hci_dev *hdev, struc=
t sk_buff *skb)
>
>         skb_pull(skb, HCI_EVENT_HDR_SIZE);
>
> -       /* Store wake reason if we're suspended */
> -       hci_store_wake_reason(hdev, event, skb);
> -
>         bt_dev_dbg(hdev, "event 0x%2.2x", event);
>
>         hci_event_func(hdev, event, skb, &opcode, &status, &req_complete,
>                        &req_complete_skb);
>
> +       hci_dev_lock(hdev);
> +       hci_store_wake_reason(hdev, NULL, 0);
> +       hci_dev_unlock(hdev);
> +
>         if (req_complete) {
>                 req_complete(hdev, status, opcode);
>         } else if (req_complete_skb) {
> --
> 2.50.0

https://sashiko.dev/#/patchset/f0d72bf42b33441991665b23e293c879.security%40=
1.0.0.127.in-addr.arpa

Seems valid to me, so we probably need to call hci_store_wake_reason
in more event handlers.

--=20
Luiz Augusto von Dentz
