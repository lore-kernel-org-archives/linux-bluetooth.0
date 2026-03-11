Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646F884A35
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261027; cv=pass; b=axx55VuEDDIJaL/rZWYN1/cduhQILVq4MAiBispIE0BobQlAjrUJBhQBciQ+Qz26W9DbImi8/rIUsRr9AFz4BJbJ6vNpf/QiTp9UF6YndtDx0B3EIAz7tbhmzMQzyweoah3kIQRN6vOA7yDyt692zQN+VU5PCSYbTbfTmbBUdVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261027; c=relaxed/simple;
	bh=IZRlb/PMUG/biullq38h6CiDYgiacisGigsJLnCFxDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvBKLSr+jmwqo0rAKcTeYXXpxZlV/wSe0MFNHnDgiLVnZYu6p5o4RoAIVZMhmM0jgD+NrTQMOg9iEP8o+sq02GRpkQupbPlGwalOvY33oV/PgRwieiNuCErkWBYxvHdtwpkf1pPx57ROCwX2eAwQPJOmbXmxsdFpW/UoOllN4SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcOxu9pL; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcOxu9pL"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ca1ba0089so308948d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 13:30:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773261024; cv=none;
        d=google.com; s=arc-20240605;
        b=dIc/2ghJshS3LCk7zjwTUDrC8VXpmsXzlrOmWNhM/BHGpW6IKyTHG9ipc1i6TdncQq
         aMW9UQas/ggqdIFhhFM9BnMpBIm9sBYTCCLLXmGOv9yqrKdiCri16JFbV4fKsX3nxmt8
         3/PqI5KzMKLlp3ZHFr9mnT4MB2qnN4g5QSV0FQLUjIvrq4VJHdeVHKSgHdroVO3Hi42W
         zfCjYqv9vzfRi5gOvU+Tvex4utrhTIY2kTKW8uXZbsYSt8nPVZsS3M6b/+iQLx15boQu
         wJqIDPDgB5QDoQfWl71pOnB+DftHhaoIQ5ki2WKEpyz01foRfhoQlY4vu5VFlZ9PukH/
         wq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wrBC4eGerC5iBks3iPBe/a3HFNjyY5bmBnP4MGWDSN0=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=dlBKfWB5+ugwixZziYWv4c2C33rgi1uYVrKPkumNQZnNB7/vdEJfnVHyXBxSigYCQb
         92LLH5jUm8ly5boh+CFdZRIbmLxXBfhKtKxN84u1mLI7DNTR1fc0rmOxUs98EZblUQF7
         iN8BbxKRLJoONLEgdieoCyJHs+yTnA24XCb+LkIXybgoqJ87bbMnYts/q4AZWxdqO+Oc
         d/kktTUmmWl8k8qX6NAZZz+3nSAsKL961+gbKyKUHE8h9/v0sR70p9JMhOkWhc20SUrG
         mD7PW2A8fge8G1Ty3jYSHuecgMbCC4pUnVDWt2SYaLpZuznSambuKRT4a3HGSLGhcSwE
         Litw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773261024; x=1773865824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrBC4eGerC5iBks3iPBe/a3HFNjyY5bmBnP4MGWDSN0=;
        b=UcOxu9pLvXwT9OlLIsC6CpKbyMP75QcWwl9lF80kdN/Q8noIa9ymozRueq5krrl+Ly
         dHTCduMnhPtE1Mg1zKR3WcQTNs0LS5e53sdU4TU/YywTJQQOvgtR4iPu7olvpFKhF+4R
         SESat+EXjSd4n2rB0Ad6NKuagUY99/lite06xOlR/cKjGMB4wU6i4AGHvMDfp/mnekm+
         gvKadJo2K/S+Au2n7caRKxwC8iaPZTpHMjkcwnoB3Rc7LWgBTvCW/zR5ujec2xOIolcF
         oiR8FTKkmxoxpfsRC7tWf0ff504V6vTnWUJCu5qEWytAzx11BWi6aISwQzcSKGAZuslQ
         WGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773261024; x=1773865824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wrBC4eGerC5iBks3iPBe/a3HFNjyY5bmBnP4MGWDSN0=;
        b=rJTEsGld61WPFVpY62fUMJ7HHVhJDbqPR9ucDx0gJdfLDLtr/C9u/OCUzK/eIja+O+
         FP7eNFfmm6rl8DEv+PcUIzJPfc6b7Rq+if+XclGIaNv9X62KkD6m8KjOUVeQvPeAEXZT
         BEqkf6IKRCPLCprJWz5yT+MRWKglQeee0ipyYqKFgeb99Bfx7u9jA3yhViLRPuc5lvGf
         6F0sC5TtH23xyovLdFaZoNl/rba6wCa69WGgp03tIFWpdWPHKTrFl85kAzvRoq1suEdm
         7Y7E18NH5b/i0F15h9FT5WRA/GQHRJNitSba29gdhCIdtgU3g3bGVCzd42OZwDPwkfv7
         f7fg==
X-Gm-Message-State: AOJu0YzJisV6lgtzg4tvHaZS/iW8IVQBIuhCvWRSzlvOlFXTDkIiXxbn
	bCgSf2zC86pwD5t5avvlCoaYqTJG+WndO/9OtLVRPamOe6Z1Khd1n/H13PrGS6x+gJ9XFyf3+YN
	NKMvweO27m3ArjwR4H86xHVeYkSFbzAU=
X-Gm-Gg: ATEYQzyF/svpNAFYek9uL+cEEjgyR/8XttzNUyln0YE8l2Lu3b/YfN5JeadbS/xHqcg
	cHXWXrZSsKFPhX5d8min1VIaHqp7Qee01lieVh3ebOtC+tMn1FHscuddubvvvw4yqcWI5yxJsmF
	5Cqj+NQ5ipMIUA8hr6lreWDCZxkhGWAZQtfygzVrifVfXWoWDkmIdZG25XYp35R7/YVwhQ+eUvR
	EX4B+4Op38rRrfEfie4vHBERlh/5t/b1tJFPhGVFsbcgUFN/rRkVBH9Ro0gYQ4NzEHcAXbekqSo
	xQKbwfGcPJT7lmPR15KzYm58g5TXzi3X2mWn0Ot849ccwqcCT6H/4isvQwhzpc7liaSeuA==
X-Received: by 2002:a05:690e:2ca:b0:64a:ce9a:ace2 with SMTP id
 956f58d0204a3-64d657bdd23mr2989039d50.56.1773261024075; Wed, 11 Mar 2026
 13:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773245666.git.pav@iki.fi> <1a4411e9ac1d6b5daa53aac78ca495c2db1b18a4.1773245666.git.pav@iki.fi>
In-Reply-To: <1a4411e9ac1d6b5daa53aac78ca495c2db1b18a4.1773245666.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 11 Mar 2026 16:30:13 -0400
X-Gm-Features: AaiRm532OsvUugTzezvXDUerPNbcI65MU4p0dxn4K8Z5LDwYW2-JdbfCowQqnwo
Message-ID: <CABBYNZJ8wEaZi3cGB3Dogo5xtHV8brY76J7tRdNpLozaVn36LA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] Bluetooth: produce HW TX timestamps for ISO from
 LE Read ISO TX Sync
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Mar 11, 2026 at 12:18=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> For ISO packets with HW TX timestamping enabled, retrieve ISO send
> timestamps via LE Read ISO TX Sync. Specification allows retrieving the
> timestamp only for the "latest" sent packet.
>
> Report SDU Reference time as the timestamp, as this is the value
> relevant for userspace send synchronization.
>
> Due to overall poor description of the timing features in ISO-over-HCI
> transport in Core Specification v6.2, it is ambiguous what packet the
> command actually reports, so timestamps may not be assigned to the
> exactly correct packets, user applications have to deal with it.
>
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  include/net/bluetooth/hci.h      |  2 +-
>  include/net/bluetooth/hci_core.h |  3 +-
>  net/bluetooth/hci_conn.c         | 53 +++++++++++++++++++--
>  net/bluetooth/hci_event.c        | 79 +++++++++++++++++++++++++++++++-
>  4 files changed, 131 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 89ad9470fa71..b536587a909f 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -2138,7 +2138,7 @@ struct hci_rp_le_read_iso_tx_sync {
>         __u8    status;
>         __le16  handle;
>         __le16  seq;
> -       __le32  imestamp;
> +       __le32  timestamp;
>         __u8    offset[3];
>  } __packed;
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index c82cec45a9a1..5d530349c2a4 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -272,6 +272,7 @@ struct adv_info {
>
>  struct tx_queue {
>         struct sk_buff_head queue;
> +       struct sk_buff *iso_last_tx;
>         unsigned int extra;
>         unsigned int tracked;
>  };
> @@ -1630,7 +1631,7 @@ void hci_conn_failed(struct hci_conn *conn, u8 stat=
us);
>  u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle);
>
>  void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb);
> -void hci_conn_tx_dequeue(struct hci_conn *conn);
> +void hci_conn_tx_dequeue(struct hci_conn *conn, bool last);
>  void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
>                             const struct sockcm_cookie *sockc);
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index a47f5daffdbf..342747a7c225 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1232,6 +1232,9 @@ void hci_conn_del(struct hci_conn *conn)
>         skb_queue_purge(&conn->data_q);
>         skb_queue_purge(&conn->tx_q.queue);
>
> +       kfree_skb(conn->tx_q.iso_last_tx);
> +       conn->tx_q.iso_last_tx =3D NULL;
> +
>         /* Remove the connection from the list and cleanup its remaining
>          * state. This is a separate function since for some cases like
>          * BT_CONNECT_SCAN we *only* want the cleanup part without the
> @@ -2388,6 +2391,20 @@ struct hci_conn *hci_connect_cis(struct hci_dev *h=
dev, bdaddr_t *dst,
>         return cis;
>  }
>
> +static int hci_conn_le_read_iso_tx_sync(struct hci_conn *conn)
> +{
> +       struct hci_cp_le_read_iso_tx_sync cp;
> +
> +       if (!(conn->hdev->commands[41] & 0x40))
> +               return -EOPNOTSUPP;
> +
> +       memset(&cp, 0, sizeof(cp));
> +       cp.handle =3D cpu_to_le16(conn->handle);
> +
> +       return hci_send_cmd(conn->hdev, HCI_OP_LE_READ_ISO_TX_SYNC,
> +                           sizeof(cp), &cp);
> +}
> +
>  /* Check link security requirement */
>  int hci_conn_check_link_mode(struct hci_conn *conn)
>  {
> @@ -3156,6 +3173,18 @@ void hci_conn_tx_queue(struct hci_conn *conn, stru=
ct sk_buff *skb)
>         struct tx_queue *comp =3D &conn->tx_q;
>         bool track =3D false;
>
> +       /* Check for HW timestamping */
> +       switch (conn->type) {
> +       case CIS_LINK:
> +       case BIS_LINK:
> +               if (skb->sk &&
> +                   (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NOBPF)) =
{
> +                       skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
> +                       track =3D true;
> +               }
> +               break;
> +       }
> +
>         /* Emit SND now, ie. just before sending to driver */
>         if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
>                 __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SND)=
;
> @@ -3214,7 +3243,7 @@ void hci_conn_tx_queue(struct hci_conn *conn, struc=
t sk_buff *skb)
>         skb_queue_purge(&comp->queue);
>  }
>
> -void hci_conn_tx_dequeue(struct hci_conn *conn)
> +void hci_conn_tx_dequeue(struct hci_conn *conn, bool last)
>  {
>         struct tx_queue *comp =3D &conn->tx_q;
>         struct sk_buff *skb;
> @@ -3234,8 +3263,24 @@ void hci_conn_tx_dequeue(struct hci_conn *conn)
>
>         if (skb->sk) {
>                 comp->tracked--;
> -               __skb_tstamp_tx(skb, NULL, NULL, skb->sk,
> -                               SCM_TSTAMP_COMPLETION);
> +
> +               if (skb_shinfo(skb)->tx_flags & SKBTX_COMPLETION_TSTAMP)
> +                       __skb_tstamp_tx(skb, NULL, NULL, skb->sk,
> +                                       SCM_TSTAMP_COMPLETION);
> +
> +               switch (conn->type) {
> +               case CIS_LINK:
> +               case BIS_LINK:
> +                       if (!last)
> +                               break;
> +                       if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_N=
OBPF) {
> +                               kfree_skb(conn->tx_q.iso_last_tx);
> +                               conn->tx_q.iso_last_tx =3D skb;
> +                               hci_conn_le_read_iso_tx_sync(conn);
> +                               return;
> +                       }
> +                       break;
> +               }
>         }
>
>         kfree_skb(skb);
> @@ -3283,6 +3328,8 @@ int hci_ethtool_ts_info(unsigned int index, int sk_=
proto,
>
>         switch (sk_proto) {
>         case BTPROTO_ISO:
> +               info->so_timestamping |=3D SOF_TIMESTAMPING_TX_HARDWARE;
> +               fallthrough;
>         case BTPROTO_L2CAP:
>                 info->so_timestamping |=3D SOF_TIMESTAMPING_TX_SOFTWARE;
>                 info->so_timestamping |=3D SOF_TIMESTAMPING_TX_COMPLETION=
;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 286529d2e554..f2aade36a39e 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3777,6 +3777,81 @@ static inline void handle_cmd_cnt_and_timer(struct=
 hci_dev *hdev, u8 ncmd)
>         rcu_read_unlock();
>  }
>
> +static u8 hci_cc_le_read_iso_tx_sync(struct hci_dev *hdev, void *data,
> +                                    struct sk_buff *skb)
> +{
> +       struct hci_rp_le_read_iso_tx_sync *rp =3D data;
> +       struct skb_shared_hwtstamps ssh;
> +       struct hci_conn *conn;
> +       u32 offset;
> +
> +       bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
> +
> +       if (rp->status)
> +               return rp->status;
> +
> +       offset =3D rp->offset[0] | (rp->offset[1] << 8) | (rp->offset[2] =
<< 16);
> +       bt_dev_dbg(hdev, "ts %u to %u", __le32_to_cpu(rp->timestamp), off=
set);
> +
> +       hci_dev_lock(hdev);
> +
> +       conn =3D hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->hand=
le));
> +       if (!conn)
> +               goto unlock;
> +
> +       if (!conn->tx_q.iso_last_tx)
> +               goto unlock;
> +
> +       /* Report SDU synchronization reference as the timestamp. This va=
lue is
> +        * most useful for userspace, as it is the Time_Stamp field in se=
nt
> +        * packets. See Fig. 3.1 and 3.2 in Core v6.2 Vol 6 Part G Sec. 3=
.
> +        *
> +        * Unfortunately, the ISO-over-HCI transport is poorly described =
in the
> +        * specification.
> +        *
> +        * The HCI specification contradicts itself which packet timestam=
p is
> +        * reported by Le Read ISO TX Sync: "scheduled for transmission" =
in Core
> +        * v6.2 Vol 4 Part E Sec 4.7 vs. "transmitted" in Sec. 7.8.96.
> +        * The specification is also unclear on what these words mean.
> +        *
> +        * We assume here it means "transmitted", and additionally that
> +        * "transmitted" means the last packet reported in Number of Comp=
leted
> +        * Packets.
> +        *
> +        * The specification is also unclear what sequence number is retu=
rned by
> +        * this command. We assume it is a sequence number assigned by th=
e
> +        * controller. These are equivalent to the controller clock, so t=
hey are
> +        * useless for generic Host (which we are) with no direct access =
to
> +        * controller clock.

Interesting analysis. I thought the sequence number for NOCP must
match the sequence number set by the host when sending the packet, and
its sole purpose was to be able to fetch the hardware time. Did you
observe something different? If the sequence number had to synchronize
with a clock, the host would need to generate empty packets even when
there is nothing to transmit. This would consume power and memory
solely to keep the sequence number in sync with the clock. I don't
actually understand why NOCP was even used with ISO if the intention
was to use sequence numbers like above, at very least NOCP should have
been updated to carry the hardware clock and other timing information
directly rather than using another command that consumes even more
system power and memory.

> +        *
> +        * Userspace application that handle these timestamps must then b=
e
> +        * prepared that the ISO timestamp is reported on the wrong packe=
t
> +        * depending on controller. Actual packet TX must rely on backpre=
ssure
> +        * (monitoring packet completion via COMPLETION tstamp), and the
> +        * timestamps are useful only for aligning the playback of multip=
le ISO
> +        * streams.
> +        */
> +
> +       memset(&ssh, 0, sizeof(ssh));
> +
> +       /* SDU Reference =3D BIG/CIG Reference - Time_Offset */
> +       ssh.hwtstamp =3D us_to_ktime(__le32_to_cpu(rp->timestamp) - offse=
t);
> +
> +       /* The value may be 0, but skb_tstamp_tx() does not allow reporti=
ng zero
> +        * HW timestamp. Offset by 1 ns as a workaround.
> +        */
> +       ssh.hwtstamp +=3D 1;
> +
> +       skb_tstamp_tx(conn->tx_q.iso_last_tx, &ssh);
> +
> +       kfree_skb(conn->tx_q.iso_last_tx);
> +       conn->tx_q.iso_last_tx =3D NULL;
> +
> +unlock:
> +       hci_dev_unlock(hdev);
> +       return rp->status;
> +}
> +
>  static u8 hci_cc_le_read_buffer_size_v2(struct hci_dev *hdev, void *data=
,
>                                         struct sk_buff *skb)
>  {
> @@ -4224,6 +4299,8 @@ static const struct hci_cc {
>         HCI_CC(HCI_OP_LE_READ_TRANSMIT_POWER, hci_cc_le_read_transmit_pow=
er,
>                sizeof(struct hci_rp_le_read_transmit_power)),
>         HCI_CC_STATUS(HCI_OP_LE_SET_PRIVACY_MODE, hci_cc_le_set_privacy_m=
ode),
> +       HCI_CC(HCI_OP_LE_READ_ISO_TX_SYNC, hci_cc_le_read_iso_tx_sync,
> +              sizeof(struct hci_rp_le_read_iso_tx_sync)),
>         HCI_CC(HCI_OP_LE_READ_BUFFER_SIZE_V2, hci_cc_le_read_buffer_size_=
v2,
>                sizeof(struct hci_rp_le_read_buffer_size_v2)),
>         HCI_CC_VL(HCI_OP_LE_SET_CIG_PARAMS, hci_cc_le_set_cig_params,
> @@ -4509,7 +4586,7 @@ static void hci_num_comp_pkts_evt(struct hci_dev *h=
dev, void *data,
>                 }
>
>                 for (i =3D 0; i < count; ++i)
> -                       hci_conn_tx_dequeue(conn);
> +                       hci_conn_tx_dequeue(conn, (i =3D=3D count - 1));
>
>                 switch (conn->type) {
>                 case ACL_LINK:
> --
> 2.53.0
>
>


--=20
Luiz Augusto von Dentz
