Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF86D126BF1
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833068; cv=none; b=YEBPG1fFjg6hdG5hB3j3MWe1gWnJ2oBTp9h2y0BjvzpKq1fq8fXQQvjfubzTqc39JB9QUiQEZC5n94BzFoBoiT8BfBcy6x2oI7dWJAoDL8gl7y6WqYKVOUZufMg/NSJTNNo/QhlK2Mx33NFf9L6uTCI43bPdt5xVh96EIu+/luY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833068; c=relaxed/simple;
	bh=jszfshz0x9EoOQsa1GGV2OrwVGHNM7HSR+9xvFqgSfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FE8u79WdQwmY4wCXYl2gmyVvAtZF+EbAnFUqWqSCN05B++1iJX01ZyureJxeuct5tDfEllZR8us4FcpdJuM2xnvLcsIfbuN/7WY4DOuJ8ytnDd2CcAHS6MV22oAxK8SHEGSII9uwWSj4u5i73DpiZfLfVmBlwhgNqNHA6EiUmeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTHSX5D/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTHSX5D/"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-378cffe5e1aso11680621fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761833064; x=1762437864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfbjntlItcH/vTTwVy/20ZT630/OjLbEE11Eq22PFHg=;
        b=OTHSX5D/dWosXN80VSLSdAjlO7dvH9gHv89n65zdM3ohhaYtgyT42FOqdpQveJ/zdv
         Aihwtq3B3LBfTCQ2hviUUBlLVP4etoJCCDiNUmDrmdXfIODf64sUQFs+LfRcBT8Alhir
         gtRdyJPmY7MLoBG6u4icgMGl27cQ0MPZP5lq+hHuLsY7Mhh673Kpb/NBqPBdw/t/r9Dm
         FSjBTlMK0KB17Ic24qGpHfXMqCd2ttD/wnTf9shWPLaUWIlcxjHwe+wsUmG8yrnvKWwM
         BNFH5UiktADbTss5qsR2PglXpsQq7ipPtKlSN0FOnrMi0CPHc7GMRQ7v0h3kt+oJatay
         uRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761833064; x=1762437864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfbjntlItcH/vTTwVy/20ZT630/OjLbEE11Eq22PFHg=;
        b=jo/pHFUYMGGY4v18zzisXyoexzMG699TaTl/XK1pP78gDO4qimNmzVfSW/2fmBGnt8
         THm3VflrW9Xclii5y9YQ+9ubB7aBdMgk2GO6S7X16xQDs7E9Ugx4mWNS2qsG4ZwPkSkx
         MQUcM7qCZsrnYE0XXugtQUzf2Qu11W5lpRTQpTLya0yZs8KTRmJYUuSmDl2ZbVfrErrp
         rEbnci+mzCma8giniFuvx0xwDgh9nOLk69xTIDCccNaRlZ9vySy2+UGyuTO7EpXapbs0
         8giBPMYWaQDzFXRa5Sp6gAKmAjc1Y06XltmO/4DICxF26JTFl+iGdyUIL5zw9w6frAI0
         160g==
X-Gm-Message-State: AOJu0YwoRhhP7139Mcw9I2t43cT/oIMBpA3kEajPP6Whvca0Og8JQPr1
	B3mEPJMt3TFyGLjEpmW6f4pM3jV7JM3Whbyew+OhvLnttH5Z+drE1RkH64Z24gRb3mEeqqoMpYJ
	1SBXmMIodJ6Rz472LSZXuvGlWqIPYmc4=
X-Gm-Gg: ASbGncscYpng+UTXiKIq4PXoIzVwb48Calph5OepR3QTczWov/Gspil08odeuwBnC05
	pqztT6nxt/+f4WGtgqrUTlcGitZmCDfo3osagRI7qK2jBoQazHwagLs3jLkv//e1spf4rmbpsQK
	pDvToGNVH5f+MhGYOSyWuXewsKyIcesYBsaou+TyQnfpbA+J2ShQg5+viMVLCBaKxdDaFsbRCrL
	6QzH2SE4DhovVHL1TiFWFNFysSh7bRCzluVx3fDGGgmma01dSH0mKLYXMA=
X-Google-Smtp-Source: AGHT+IF9uQS0yUqCHYF0Vp3KG9M9hsRmNvDu0clnWdQ0KaMQ5tOKXr1+tDjN21iifAvM+t1Uhguka9g5KzJsS/P4uqU=
X-Received: by 2002:a2e:a805:0:b0:36a:a87c:d139 with SMTP id
 38308e7fff4ca-37a052ed3c5mr18147581fa.42.1761833063607; Thu, 30 Oct 2025
 07:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030134856.2726882-1-mahesh.talewad@nxp.com> <20251030134856.2726882-2-mahesh.talewad@nxp.com>
In-Reply-To: <20251030134856.2726882-2-mahesh.talewad@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 30 Oct 2025 10:04:10 -0400
X-Gm-Features: AWmQ_blnzkx5bWQ-MYtdfB8FF5AgZjLx11n4cjABz-fhzSX3Wczh4u4BXX9OfE0
Message-ID: <CABBYNZ+ESzoXtEARiVuzw9eyhbHCxkf0Wu6AHFvgdzHmPKDhUw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 1/1] When Connect request for eSco is received,
 if enhanced synchronous connection command is supported it will go for
 'Enhanced Accept Synchronous Connection Request command' else it will go for
 legacy command['Accept Synchronous Connection Request comand']
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, vinit.mehta@nxp.com, 
	sarveshwar.bajaj@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mahesh,

On Thu, Oct 30, 2025 at 9:47=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nxp.=
com> wrote:

You will need to do a better job describing why the changes are
necessary and perhaps have btmon trace as well.

> Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
> ---
>  include/net/bluetooth/hci.h |  34 ++++++++++++
>  net/bluetooth/sco.c         | 103 ++++++++++++++++++++++++++----------
>  2 files changed, 109 insertions(+), 28 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 40fce4193cc1..4f1a38e8f276 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -914,6 +914,40 @@ struct hci_cp_accept_sync_conn_req {
>         __le16   pkt_type;
>  } __packed;
>
> +#define        HCI_OP_ENHANCED_ACCEPT_SYNC_CONN_REQ    0x043E
> +struct hci_coding_format_en_accpt_sync {
> +       __u8    id;
> +       __le16  cid;
> +       __le16  vid;
> +} __packed;
> +
> +struct hci_cp_enhanced_accept_sync_conn_req {
> +       bdaddr_t bdaddr;
> +       __le32  tx_bandwidth;
> +       __le32  rx_bandwidth;
> +       struct  hci_coding_format_en_accpt_sync tx_coding_format;
> +       struct  hci_coding_format_en_accpt_sync rx_coding_format;
> +       __le16  tx_codec_frame_size;
> +       __le16  rx_codec_frame_size;
> +       __le32  in_bandwidth;
> +       __le32  out_bandwidth;
> +       struct  hci_coding_format_en_accpt_sync in_coding_format;
> +       struct  hci_coding_format_en_accpt_sync out_coding_format;
> +       __le16  in_coded_data_size;
> +       __le16  out_coded_data_size;
> +       __u8    in_pcm_data_format;
> +       __u8    out_pcm_data_format;
> +       __u8    in_pcm_sample_payload_msb_pos;
> +       __u8    out_pcm_sample_payload_msb_pos;
> +       __u8    in_data_path;
> +       __u8    out_data_path;
> +       __u8    in_transport_unit_size;
> +       __u8    out_transport_unit_size;
> +       __le16  max_latency;
> +       __le16  pkt_type;
> +       __u8    retrans_effort;
> +} __packed;
> +
>  #define HCI_OP_REJECT_SYNC_CONN_REQ    0x042a
>  struct hci_cp_reject_sync_conn_req {
>         bdaddr_t bdaddr;
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index b872a2ca3ff3..42ffb31839f2 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -762,6 +762,17 @@ static int sco_sock_sendmsg(struct socket *sock, str=
uct msghdr *msg,
>         return err;
>  }
>
> +struct esco_param {
> +       u16 pkt_type;
> +       u16 max_latency;
> +       u8  retrans_effort;
> +};
> +
> +static const struct esco_param esco_param_msbc[] =3D {
> +       { EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d,   0x02 }, /* T2 */
> +       { EDR_ESCO_MASK | ESCO_EV3,   0x0008,   0x02 }, /* T1 */
> +};
> +
>  static void sco_conn_defer_accept(struct hci_conn *conn, u16 setting)
>  {
>         struct hci_dev *hdev =3D conn->hdev;
> @@ -778,36 +789,72 @@ static void sco_conn_defer_accept(struct hci_conn *=
conn, u16 setting)
>
>                 hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp), &c=
p);
>         } else {
> -               struct hci_cp_accept_sync_conn_req cp;
> -
> -               bacpy(&cp.bdaddr, &conn->dst);
> -               cp.pkt_type =3D cpu_to_le16(conn->pkt_type);
> -
> -               cp.tx_bandwidth   =3D cpu_to_le32(0x00001f40);
> -               cp.rx_bandwidth   =3D cpu_to_le32(0x00001f40);
> -               cp.content_format =3D cpu_to_le16(setting);
> +               if (!enhanced_sync_conn_capable(hdev)) {
> +                       struct hci_cp_accept_sync_conn_req cp;
> +
> +                       bacpy(&cp.bdaddr, &conn->dst);
> +                       cp.pkt_type =3D cpu_to_le16(conn->pkt_type);
> +
> +                       cp.tx_bandwidth   =3D cpu_to_le32(0x00001f40);
> +                       cp.rx_bandwidth   =3D cpu_to_le32(0x00001f40);
> +                       cp.content_format =3D cpu_to_le16(setting);
> +
> +                       switch (setting & SCO_AIRMODE_MASK) {
> +                       case SCO_AIRMODE_TRANSP:
> +                               if (conn->pkt_type & ESCO_2EV3)
> +                                       cp.max_latency =3D cpu_to_le16(0x=
0008);
> +                               else
> +                                       cp.max_latency =3D cpu_to_le16(0x=
000D);
> +                               cp.retrans_effort =3D 0x02;
> +                               break;
> +                       case SCO_AIRMODE_CVSD:
> +                               cp.max_latency =3D cpu_to_le16(0xffff);
> +                               cp.retrans_effort =3D 0xff;
> +                               break;
> +                       default:
> +                               /* use CVSD settings as fallback */
> +                               cp.max_latency =3D cpu_to_le16(0xffff);
> +                               cp.retrans_effort =3D 0xff;
> +                               break;
> +                       }
>
> -               switch (setting & SCO_AIRMODE_MASK) {
> -               case SCO_AIRMODE_TRANSP:
> -                       if (conn->pkt_type & ESCO_2EV3)
> -                               cp.max_latency =3D cpu_to_le16(0x0008);
> -                       else
> -                               cp.max_latency =3D cpu_to_le16(0x000D);
> -                       cp.retrans_effort =3D 0x02;
> -                       break;
> -               case SCO_AIRMODE_CVSD:
> -                       cp.max_latency =3D cpu_to_le16(0xffff);
> -                       cp.retrans_effort =3D 0xff;
> -                       break;
> -               default:
> -                       /* use CVSD settings as fallback */
> -                       cp.max_latency =3D cpu_to_le16(0xffff);
> -                       cp.retrans_effort =3D 0xff;
> -                       break;
> +                       hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ, s=
izeof(cp), &cp);
> +               } else {
> +                       struct hci_cp_enhanced_accept_sync_conn_req cp;
> +                       const struct esco_param *param;
> +
> +                       memset(&cp, 0x00, sizeof(cp));
> +
> +                       bacpy(&cp.bdaddr, &conn->dst);
> +                       cp.tx_bandwidth   =3D cpu_to_le32(0x00001f40);
> +                       cp.rx_bandwidth   =3D cpu_to_le32(0x00001f40);
> +                       cp.tx_coding_format.id =3D 0x05;
> +                       cp.rx_coding_format.id =3D 0x05;
> +                       cp.tx_codec_frame_size =3D __cpu_to_le16(60);
> +                       cp.rx_codec_frame_size =3D __cpu_to_le16(60);
> +                       cp.in_bandwidth =3D __cpu_to_le32(32000);
> +                       cp.out_bandwidth =3D __cpu_to_le32(32000);
> +                       cp.in_coding_format.id =3D 0x04;
> +                       cp.out_coding_format.id =3D 0x04;
> +                       cp.in_coded_data_size =3D __cpu_to_le16(16);
> +                       cp.out_coded_data_size =3D __cpu_to_le16(16);
> +                       cp.in_pcm_data_format =3D 2;
> +                       cp.out_pcm_data_format =3D 2;
> +                       cp.in_pcm_sample_payload_msb_pos =3D 0;
> +                       cp.out_pcm_sample_payload_msb_pos =3D 0;
> +                       cp.in_data_path =3D conn->codec.data_path;
> +                       cp.out_data_path =3D conn->codec.data_path;
> +                       cp.in_transport_unit_size =3D 1;
> +                       cp.out_transport_unit_size =3D 1;
> +
> +                       param =3D &esco_param_msbc[conn->attempt];
> +
> +                       cp.max_latency =3D __cpu_to_le16(param->max_laten=
cy);
> +                       cp.pkt_type =3D __cpu_to_le16(param->pkt_type);
> +                       cp.retrans_effort =3D param->retrans_effort;
> +
> +                       hci_send_cmd(hdev, HCI_OP_ENHANCED_ACCEPT_SYNC_CO=
NN_REQ, sizeof(cp), &cp);

I would recommend moving this to hci_sync like most commands are
submitted nowadays, I'd also recommend splitting this into 2 functions
instead of one very long.

>                 }
> -
> -               hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
> -                            sizeof(cp), &cp);
>         }
>  }
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
