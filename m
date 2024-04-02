Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388DC13473D
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072653; cv=none; b=ck80ZbO1pGEjBMoFLTBt0s7q6KhebzQVdrHrxV+/IvY+SOM0+pIlGBt0t4eFEdn7fScvQ0VdRa8jnZVoFEQIoG9IltDIbYhze7XZVVr+Yv4CJiMOe3isszDg0Sebj/U6Frk4BxQcXvnRBj7gnQc5Rw4z+Clp8q297HzGENcUtUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072653; c=relaxed/simple;
	bh=/4Yb0Tr/13iCVGpalfYLqYFZRSt6fhRXcWuwsCmHqaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Os7x07hY+WP4Sn3/Ap8faPoIlOAiWWRvl0WLw9QRiV5KvSayQHAxdaRr89ZbaC4apQLKMyw/zI/BbrSK6fkY9UESGdrQ3bjPKnh17gka1LZdM4dTJeaZU9ZXTJi2ZCmo9HHcCopMx+UHClEVhbjCv9qa9iN9qm9dzU3OI38fhfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jROpaUsf; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jROpaUsf"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d700beb60bso90526791fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Apr 2024 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712072649; x=1712677449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kt/QD9PQdh65+FTke1a9sc/rZRWLCZ8Xm2JVNub0x9c=;
        b=jROpaUsfNcawD2QhVLpDQi4jBHlsJ9E2JiorrO3ew7sq6sKVL9SKQKFpjuXojqQ56d
         R/HgT6L/auLYcxci2kNsKV3YN1L0VkX18LCrpROuZoCAfLZS7gFX7rS56f2VRYWBcyp/
         H/wMJCsXx4FzE3jm5JFuCHQzzRSzUr0rN8E0EFwzXAwosMVfDkAqGLYHfKYuNOqSTwjr
         ngJEFvtaLjBt/XyK4Z8pjYux31wXOa05ySM/a6Q9uk5lt3aiP7+mYUspp+W12/Rk3C6+
         QZHTAGTdcQYRb4jfCuEKmJIkOm+QnW8prAdqwHBtN2Qr2dRdy96u8ioGlsvUmVcMGjz0
         1QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712072649; x=1712677449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kt/QD9PQdh65+FTke1a9sc/rZRWLCZ8Xm2JVNub0x9c=;
        b=rdA6sF0K1J+Vshqgf6cCVEljTBfKFY5CLCepDaOMkrJn8f/hSEFNOLe2QcOBBUhjcW
         WmFGqRqvBap3yLXXLWp+hSWajS1JWPTuRiN7b3YseDmzgGdb/0E7KU8SNc5IErSr6x1p
         oPbCJut2cxuAtsYUh5ApNwjg9+0J2BACz2WmSrqyfNZ9Ex5XE1TvxTt4KtE4OB3EAepI
         rWL1f9WV7cVLN96J5QS1UKvhFZ6XcRDMul7nuER/C10payuoPgtBkEVQDN4Z0jmPfxRo
         cSAQWE4klZ3gjm+xwumpUuLE2JKvKP5HYlEKpg9nBuIQ0xSATbyTMOw38KgDL3twHyJO
         Xqfw==
X-Gm-Message-State: AOJu0Yxme+qSPhZREg/KvIXCgfxESqWc2Y/qciI2hlf9MKGJ98NIWpnr
	pjd525EQIagBeF3DLf/02ybwc1GOcBSjCbEzWFS2yZG52mCcwLQEyBQG0MqtYwmEkhUvLF2WwIs
	mYAtKSjKU9nqQIV/Xujs8P4XObJQj2znU
X-Google-Smtp-Source: AGHT+IEzmKENCuUzkeaDPnbQiYojKvgBeG0AAnfEFP2KkuyF1P56fWyYo37sypDZWdDnHpbDixLkTKRBzPhxQrW8sU8=
X-Received: by 2002:a2e:3c0c:0:b0:2d6:f5c6:e5a1 with SMTP id
 j12-20020a2e3c0c000000b002d6f5c6e5a1mr1771715lja.12.1712072648976; Tue, 02
 Apr 2024 08:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402113931.3164-1-iulia.tanasescu@nxp.com> <20240402113931.3164-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20240402113931.3164-2-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Apr 2024 11:43:56 -0400
Message-ID: <CABBYNZKSjjpU48COeTz3H6i+WKFr=Zb3D9Eudp5r_puiuaj=dg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: ISO: Make iso_get_sock_listen generic
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Tue, Apr 2, 2024 at 7:39=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nxp=
.com> wrote:
>
> This makes iso_get_sock_listen more generic, to return matching socket
> in the state provided as argument.
>
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  net/bluetooth/iso.c | 75 +++++++++++++++++++++++++--------------------
>  1 file changed, 42 insertions(+), 33 deletions(-)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 42b4495e019e..3fcaef506bde 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -85,8 +85,9 @@ static void iso_sock_disconn(struct sock *sk);
>
>  typedef bool (*iso_sock_match_t)(struct sock *sk, void *data);
>
> -static struct sock *iso_get_sock_listen(bdaddr_t *src, bdaddr_t *dst,
> -                                       iso_sock_match_t match, void *dat=
a);
> +static struct sock *iso_get_sock(bdaddr_t *src, bdaddr_t *dst,
> +                                unsigned char state,

Lets add a name to the enum in bluetooth.h when the socket states are
defined then we can use it here instead of passing as unsigned char.

> +                                iso_sock_match_t match, void *data);
>
>  /* ---- ISO timers ---- */
>  #define ISO_CONN_TIMEOUT       (HZ * 40)
> @@ -233,10 +234,11 @@ static void iso_conn_del(struct hci_conn *hcon, int=
 err)
>                  * terminated are not processed anymore.
>                  */
>                 if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
> -                       parent =3D iso_get_sock_listen(&hcon->src,
> -                                                    &hcon->dst,
> -                                                    iso_match_conn_sync_=
handle,
> -                                                    hcon);
> +                       parent =3D iso_get_sock(&hcon->src,
> +                                             &hcon->dst,
> +                                             BT_LISTEN,
> +                                             iso_match_conn_sync_handle,
> +                                             hcon);
>
>                         if (parent) {
>                                 set_bit(BT_SK_PA_SYNC_TERM,
> @@ -584,22 +586,23 @@ static struct sock *__iso_get_sock_listen_by_sid(bd=
addr_t *ba, bdaddr_t *bc,
>         return NULL;
>  }
>
> -/* Find socket listening:
> +/* Find socket in given state:
>   * source bdaddr (Unicast)
>   * destination bdaddr (Broadcast only)
>   * match func - pass NULL to ignore
>   * match func data - pass -1 to ignore
>   * Returns closest match.
>   */
> -static struct sock *iso_get_sock_listen(bdaddr_t *src, bdaddr_t *dst,
> -                                       iso_sock_match_t match, void *dat=
a)
> +static struct sock *iso_get_sock(bdaddr_t *src, bdaddr_t *dst,
> +                                unsigned char state,
> +                                iso_sock_match_t match, void *data)
>  {
>         struct sock *sk =3D NULL, *sk1 =3D NULL;
>
>         read_lock(&iso_sk_list.lock);
>
>         sk_for_each(sk, &iso_sk_list.head) {
> -               if (sk->sk_state !=3D BT_LISTEN)
> +               if (sk->sk_state !=3D state)
>                         continue;
>
>                 /* Match Broadcast destination */
> @@ -1805,32 +1808,37 @@ static void iso_conn_ready(struct iso_conn *conn)
>                                                  HCI_EVT_LE_BIG_SYNC_ESTA=
BILISHED);
>
>                         /* Get reference to PA sync parent socket, if it =
exists */
> -                       parent =3D iso_get_sock_listen(&hcon->src,
> -                                                    &hcon->dst,
> -                                                    iso_match_pa_sync_fl=
ag, NULL);
> +                       parent =3D iso_get_sock(&hcon->src, &hcon->dst,
> +                                             BT_LISTEN,
> +                                             iso_match_pa_sync_flag,
> +                                             NULL);
>                         if (!parent && ev)
> -                               parent =3D iso_get_sock_listen(&hcon->src=
,
> -                                                            &hcon->dst,
> -                                                            iso_match_bi=
g, ev);
> +                               parent =3D iso_get_sock(&hcon->src,
> +                                                     &hcon->dst,
> +                                                     BT_LISTEN,
> +                                                     iso_match_big, ev);
>                 } else if (test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->flags=
)) {
>                         ev2 =3D hci_recv_event_data(hcon->hdev,
>                                                   HCI_EV_LE_PA_SYNC_ESTAB=
LISHED);
>                         if (ev2)
> -                               parent =3D iso_get_sock_listen(&hcon->src=
,
> -                                                            &hcon->dst,
> -                                                            iso_match_si=
d, ev2);
> +                               parent =3D iso_get_sock(&hcon->src,
> +                                                     &hcon->dst,
> +                                                     BT_LISTEN,
> +                                                     iso_match_sid, ev2)=
;
>                 } else if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags)) {
>                         ev3 =3D hci_recv_event_data(hcon->hdev,
>                                                   HCI_EVT_LE_BIG_INFO_ADV=
_REPORT);
>                         if (ev3)
> -                               parent =3D iso_get_sock_listen(&hcon->src=
,
> -                                                            &hcon->dst,
> -                                                            iso_match_sy=
nc_handle, ev3);
> +                               parent =3D iso_get_sock(&hcon->src,
> +                                                     &hcon->dst,
> +                                                     BT_LISTEN,
> +                                                     iso_match_sync_hand=
le,
> +                                                     ev3);
>                 }
>
>                 if (!parent)
> -                       parent =3D iso_get_sock_listen(&hcon->src,
> -                                                       BDADDR_ANY, NULL,=
 NULL);
> +                       parent =3D iso_get_sock(&hcon->src, BDADDR_ANY,
> +                                             BT_LISTEN, NULL, NULL);
>
>                 if (!parent)
>                         return;
> @@ -1951,8 +1959,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t =
*bdaddr, __u8 *flags)
>          */
>         ev1 =3D hci_recv_event_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
>         if (ev1) {
> -               sk =3D iso_get_sock_listen(&hdev->bdaddr, bdaddr, iso_mat=
ch_sid,
> -                                        ev1);
> +               sk =3D iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
> +                                 iso_match_sid, ev1);
>                 if (sk && !ev1->status)
>                         iso_pi(sk)->sync_handle =3D le16_to_cpu(ev1->hand=
le);
>
> @@ -1962,12 +1970,12 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_=
t *bdaddr, __u8 *flags)
>         ev2 =3D hci_recv_event_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT)=
;
>         if (ev2) {
>                 /* Try to get PA sync listening socket, if it exists */
> -               sk =3D iso_get_sock_listen(&hdev->bdaddr, bdaddr,
> -                                               iso_match_pa_sync_flag, N=
ULL);
> +               sk =3D iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
> +                                 iso_match_pa_sync_flag, NULL);
>
>                 if (!sk) {
> -                       sk =3D iso_get_sock_listen(&hdev->bdaddr, bdaddr,
> -                                                iso_match_sync_handle, e=
v2);
> +                       sk =3D iso_get_sock(&hdev->bdaddr, bdaddr, BT_LIS=
TEN,
> +                                         iso_match_sync_handle, ev2);
>
>                         /* If PA Sync is in process of terminating,
>                          * do not handle any more BIGInfo adv reports.
> @@ -2007,8 +2015,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t =
*bdaddr, __u8 *flags)
>                 u8 *base;
>                 struct hci_conn *hcon;
>
> -               sk =3D iso_get_sock_listen(&hdev->bdaddr, bdaddr,
> -                                        iso_match_sync_handle_pa_report,=
 ev3);
> +               sk =3D iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
> +                                 iso_match_sync_handle_pa_report, ev3);
>                 if (!sk)
>                         goto done;
>
> @@ -2057,7 +2065,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t =
*bdaddr, __u8 *flags)
>                         hcon->le_per_adv_data_len =3D 0;
>                 }
>         } else {
> -               sk =3D iso_get_sock_listen(&hdev->bdaddr, BDADDR_ANY, NUL=
L, NULL);
> +               sk =3D iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
> +                                 BT_LISTEN, NULL, NULL);
>         }
>
>  done:
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
