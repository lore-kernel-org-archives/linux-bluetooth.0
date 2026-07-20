Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3D271A94
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557838; cv=pass; b=TEql3hya0PyVE5c0zJrddaIkqbK0GVGYET28uGqnaGewjrDF8argflXKa2/0wiBOJcV1FIGkx7v3KY2DAPJ5bFWAMKYkcTirvM3ljEgHGhOYeuOCE/x0HKjiIYcYb83YIYPQeOhSfB7pzGoUm+h911Qs4LnObrshMud+3dlHnoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557838; c=relaxed/simple;
	bh=45K4lJma4392td62qmSupkyHO69qP5Ifx/4/dUIdvKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evTk0yQjTloHfupORGD1oF4Er4oC4IF3WxGarr9pksF6G16m5wMoyErxEwFodB7RsdnBTj5XKEM2fo1/TRIWu+xMD9iGqwWc4xz9lziKmBHyRZzVgFaIfFbb6sEK90OG2EpHl1bIEp4QRjhslsmcZ3sBsGAPoFBisyCyKG3Qfs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAJfmBWW; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAJfmBWW"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81eef95653fso26858677b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 07:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784557835; cv=none;
        d=google.com; s=arc-20260327;
        b=icgs4L+Gbe3LpDSjQ+aJ8Dt6fYpvCSrYJlMhXi0E6nZdUPyk9c95ECO/kw/FbhUefW
         MThXb5XnmEPbnne8Bo7lOeuKqCZ+Rv6sEgxVfopwAWod9rjy32avIvEXB/sSgebyNEOD
         UhtrZSVGmwmtq8BAnlcqv0Xi0gLDbovMZkATMOnlD22yGXqkJb8Pb3dymNeE3rH9l6KS
         1XhUcLehLsxozOrfeHc6cWU0LsIinTZ3Lh3qwpV4OibaVxd8ykb4vEmkc/bEr+fmu+Ot
         Q9j8Uv6YDIcRO8f94jOCqTZ7odeZIPIi52W2I2Z/6uL6f0VfhH4CsMzZLa0O6dNBt4Ns
         C19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=P+gYxwu2dC0wyoeROcMNSSnq+lsj/W2+lTl/1ugXVVU=;
        fh=iOwESzyNWrwSORAD6RfzfuwnS+jhoB3zLFSW4r6wAuE=;
        b=FJ1KEsKZIq2ogbh1787MCtASgIbRn4pmDf3mC/OO9HP5+iXjry8vXYcQQZiSRxXoTH
         9Epvo/wngC9o2gCTx0l/zNFgezgHnqd8aKQZ1z6n7B7TC1KcTXpm2qNTisNDmzO0RDVa
         4Wj9YE8MVDbnp7dZHdX7fDWeWbQRfMJjNfyZrNgBC8RQQLkz5n/UV73q8qn+3uWdH3hs
         hlsylr3uq3aVyAnWkXq3+7bbQZvbrpu9hyKfTvKtdScOwB/CYlAyaR8ArojudvariioU
         7/Dclk+v2s2BNx+3wcMQ8CfW1oRTNC2OArv+FfMs6eTPPczV9CqqJ0kmX9doN+7TBZy9
         bFGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784557835; x=1785162635; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+gYxwu2dC0wyoeROcMNSSnq+lsj/W2+lTl/1ugXVVU=;
        b=MAJfmBWWv7Mh0NiQGjDZrgpA8U4ovFdP/Dut++Bn8aMrhdlO7CQPheiuymZZeB45F7
         P8/wffFUwSyDg15rnl63hnQWAQYQLwH9qyhDKeFTtmsJJD6SOFvxfPcig6xdMk+gInnY
         tQU8q3MfV068oWnPdyecf7pvEis90N8y+SSccud4j1h++a7lMsm/kL8sNEky3XNeMpTv
         IWA+l5+zjOMJ6IdgZXMtKk/7D6riEqFOhDwTkmV8lS21x7RjdAR9Ke7oQHB8kp+v3UNd
         pI9KvuWm2jBsRVD/VCOvsKR4vDnwfKxiTEBDJmOtBhCjapB7O0ye72RBHIX5HlYKGMMO
         kNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784557835; x=1785162635;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P+gYxwu2dC0wyoeROcMNSSnq+lsj/W2+lTl/1ugXVVU=;
        b=XkAcZCCyP6QYJRSEvfs1MCmsgLadvliA/6tTO4xt2ZDV379LjdkNdIXheiZ1NvfuOW
         aKLmoBG3N00/K4gCB13PjvouzqaKlTFrobWIWwdvU+9YGeauX2yjpjRgGFwQQruI8hHM
         Y683i5TVMqhNkY9hUg3ShSgjNuTrVDvykwWbUxlqiq+U2auoK09Fhrff8jPH4uxg+olG
         EA8pKmNZOYJKndDeYgdxkNmIjcC7Aw6ON0zxmqGAQJcLYPYMtRtfKuJJzhnlVegnocPK
         xv3k8VRLaPRbYGvTwKWY5uNzvZ/NEr3W3EHKWbfkRpihm9A6MPfHcmLf15e+v+2ERm09
         FGWQ==
X-Forwarded-Encrypted: i=1; AHgh+RrnXN+QP4YeC5B0IS44ctNlwHdM1BWIAg0WWAPv/G7sc+vuFDPr03WAkTA9bUJKBb/wzQ4rslwV/LWoWIuB8ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YysPjnPRdvGru8QiRN99vnbSay2FtjeZ6P3JVRc78ynlVvPKfl6
	YoU+frNA+CrQOAM4mWv07C9sMRQ053LNeDfycFpwxDeO0e0AASkk6OKATxE/jkGjpxltC7DnY4/
	stnzCICMiAFK4z5rZr3ItgpcIEQzAhtg=
X-Gm-Gg: AR+sD13gytYF1UA1ucHn3yHLepWmFtNDE6jla8kjcH6a7CaKHbCSeoKXyFQrAGPXWK6
	9K8ulAO0wx7pbizofNgijakoXqL5P23cwi1oKWr01QlpVZnwJiI6qumw4NSheAxLpgWHKMa65dj
	Q7rYwDEVDcAY4P2yLOcAEomb7mb703Sl3BOms4J3Ndu7dWIM6Ppi+BPPJge3VUxBVjRfO7O7qFo
	MNhbArUjJh72tvI5k/3YmHC57xsq4Ed9C8NQsyPD0wgl5cNEEC17jcpToCLa108h10G5ubOICXd
	hXuwEJOn0Xqo5fZODXlkOclRTsz3nttFZ855az1n9bHqJBAR5aNXuCA7
X-Received: by 2002:a05:690c:6a0e:b0:814:4e7c:752e with SMTP id
 00721157ae682-81ef260174cmr51240667b3.53.1784557835024; Mon, 20 Jul 2026
 07:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719-support_vendor_hci-v1-1-764523a4ca3d@oss.qualcomm.com>
In-Reply-To: <20260719-support_vendor_hci-v1-1-764523a4ca3d@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Jul 2026 10:30:21 -0400
X-Gm-Features: AUfX_mxmfrnXE8x-_Xj8G1ROHd7E8QhQPFEQjKnRdkwgZNuO32txmrwbZ8KDDf4
Message-ID: <CABBYNZL_H2iRAshF-RCX41jbt0jots5i5W=aUUJC_wEN6wzp=w@mail.gmail.com>
Subject: Re: [PATCH RFC] Bluetooth: Add generic support for vendor HCI frames
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d6b11a06570bbf6a"

--000000000000d6b11a06570bbf6a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Mon, Jul 20, 2026 at 1:14=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> For Qualcomm multi-subsystem BT chips, the transport wire carries both
> BT-HCI and PERI-HCI frames. PERI is a subsystem on the chip. Take the
> upcoming QCC2072 support as an example:
>
>     Packet type                BT-HCI indicator   PERI-HCI indicator
>     --------------------------------------------------------------
>     CMD (Host -> Controller)   0x01                0x31
>     ACL Data (bidirectional)   0x02                0x32
>     EVENT (Controller -> Host) 0x04                0x34

I would say this was fine, but you actuall need to reclassify these to
0xff and then use an extra byte for the vendor opcode. Btw, you said
you could define H4 headers like this? The spec defines either:

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core_=
v6.3/out/en/host-controller-interface/three-wire-uart-transport-layer.html#=
UUID-1cf959bb-57a0-e782-4324-a9bc4ee3f134_table-idm13359018144714

Or

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core_=
v6.3/out/en/host-controller-interface/uart-transport-layer.html#UUID-838818=
75-5fbb-c366-400f-055ba726f70e_table-idm13359015052542

We end up defining vendor 0xff because it is at the end of the range
which is probably safer.

> To generically support vendor HCI frames:
>
> - Show them in btmon logs as they appear on the wire.
> - Allow userspace to send/receive them via HCI_CHANNEL_USER, with a
>   socket option to control RX, defaulting off to eliminate regression
>   risk for existing applications.

We shouldn't need to do this, we should just accept 0xff as the vendor
packet type and then use the following byte as the real opcode (0x31,
0x32, 0x34). Otherwise, if we start accepting vendor packet types
outside 0xff this will get crowded quickly and could potentially clash
with future specs.

> - Add hdev->recv_vendor() to handle vendor frames in hci_rx_work() like
>   BT frame handlers.
> - Add hci_send_vendor_frame() API similar to existing __hci_cmd_send().

Encoding/decoding of the frames should be transparent. I'm fine adding
code to the likes of btmon to decode vendor packets, we already have
something similar for Intel although that uses a vendor event not a
vendor packet (both use 0xff, causing the confusion). The user of the
user channel shall be able to read/write starting with 0xff then
decode/encode the next byte as the actual vendor opcode.

> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
> Hi Luiz
> To address the below concerns you raised on previous
> discussion, and inspired from your suggestion to add hdev callback:
>
> - Not use safer skb helper like skb_pull_data()
> - It will skip sending to the monitor, making debugging much harder
>
> Looking forward to your further comments.
>
> Why hdev->is_vendor() instead of multiplexing vendor frames under a
> virtual HCI_VENDOR_PKT + vendor indicator byte ?
>
> 1) The virtual HCI_VENDOR_PKT isn't used by the core itself
>    currently, and may be removed later.
> 2) It makes full use of the indicator (hci_skb_pkt_type(skb)) space,
>    which is large enough to accommodate vendor frames without an
>    extra layer of nesting inside HCI_VENDOR_PKT.
> 3) It lets userspace and btmon logs see the exact same frame as it
>    appears on the wire.
>
> Previous discussion link:
> https://lore.kernel.org/all/CABBYNZJpdeoZ16bObLRPhng2dfyNeK9ix9_-z_hMZhJ0=
QxTxGg@mail.gmail.com
> https://lore.kernel.org/all/CABBYNZJ0zoVVVxuM48L=3DKm=3D=3DgnrQuskrbjB6q_=
aNV0KEEY3+5w@mail.gmail.com
> ---
>  include/net/bluetooth/bluetooth.h |  2 +
>  include/net/bluetooth/hci.h       |  1 +
>  include/net/bluetooth/hci_core.h  | 13 +++++++
>  include/net/bluetooth/hci_mon.h   |  2 +
>  net/bluetooth/hci_core.c          | 22 +++++++++++
>  net/bluetooth/hci_sock.c          | 78 +++++++++++++++++++++++++++++++++=
+-----
>  6 files changed, 108 insertions(+), 10 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index b624da5026f5..d9870a43a2c4 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -256,6 +256,8 @@ struct bt_codecs {
>
>  #define BT_SCM_PKT_SEQNUM      0x05
>
> +#define BT_RCV_VENDOR_PKT      23
> +
>  __printf(1, 2)
>  void bt_info(const char *fmt, ...);
>  __printf(1, 2)
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 50f0eef71fb1..ac97550cbdba 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -398,6 +398,7 @@ enum {
>  /* HCI socket flags */
>  enum {
>         HCI_SOCK_TRUSTED,
> +       HCI_SOCK_RCV_VENDOR_PKT,
>         HCI_MGMT_INDEX_EVENTS,
>         HCI_MGMT_UNCONF_INDEX_EVENTS,
>         HCI_MGMT_EXT_INDEX_EVENTS,
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index e7133ff87fbf..20a455d90ef3 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -645,6 +645,8 @@ struct hci_dev {
>         int (*setup)(struct hci_dev *hdev);
>         int (*shutdown)(struct hci_dev *hdev);
>         int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
> +       bool (*is_vendor)(struct hci_dev *hdev, const struct sk_buff *skb=
);
> +       void (*recv_vendor)(struct hci_dev *hdev, struct sk_buff *skb);
>         void (*notify)(struct hci_dev *hdev, unsigned int evt);
>         void (*hw_error)(struct hci_dev *hdev, u8 code);
>         int (*post_init)(struct hci_dev *hdev);
> @@ -660,6 +662,15 @@ struct hci_dev {
>         u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *skb=
);
>  };
>
> +static inline bool hci_is_vendor_frame(struct hci_dev *hdev,
> +                                      const struct sk_buff *skb)
> +{
> +       if (!hdev->is_vendor)
> +               return false;
> +
> +       return hdev->is_vendor(hdev, skb);
> +}
> +
>  #define hci_set_quirk(hdev, nr) set_bit((nr), (hdev)->quirk_flags)
>  #define hci_clear_quirk(hdev, nr) clear_bit((nr), (hdev)->quirk_flags)
>  #define hci_test_quirk(hdev, nr) test_bit((nr), (hdev)->quirk_flags)
> @@ -2327,6 +2338,8 @@ static inline int hci_check_conn_params(u16 min, u1=
6 max, u16 latency,
>  int hci_register_cb(struct hci_cb *hcb);
>  int hci_unregister_cb(struct hci_cb *hcb);
>
> +int hci_send_vendor_frame(struct hci_dev *hdev, struct sk_buff *skb);
> +
>  int __hci_cmd_send(struct hci_dev *hdev, u16 opcode, u32 plen,
>                    const void *param);
>
> diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_=
mon.h
> index 4b2a0af4ed58..7710688c0d30 100644
> --- a/include/net/bluetooth/hci_mon.h
> +++ b/include/net/bluetooth/hci_mon.h
> @@ -50,6 +50,8 @@ struct hci_mon_hdr {
>  #define HCI_MON_ISO_RX_PKT     19
>  #define HCI_MON_DRV_TX_PKT     20
>  #define HCI_MON_DRV_RX_PKT     21
> +#define HCI_MON_VENDOR_TX_PKT  22
> +#define HCI_MON_VENDOR_RX_PKT  23
>
>  struct hci_mon_new_index {
>         __u8            type;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 1e324c05af24..c12c180e8293 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2920,6 +2920,8 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_=
buff *skb)
>         case HCI_DRV_PKT:
>                 break;
>         default:
> +               if (hci_is_vendor_frame(hdev, skb))
> +                       break;
>                 kfree_skb(skb);
>                 return -EINVAL;
>         }
> @@ -3053,6 +3055,18 @@ static int hci_send_conn_frame(struct hci_dev *hde=
v, struct hci_conn *conn,
>         return hci_send_frame(hdev, skb);
>  }
>
> +int hci_send_vendor_frame(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       if (hci_is_vendor_frame(hdev, skb))
> +               return hci_send_frame(hdev, skb);
> +
> +       bt_dev_err(hdev, "invalid vendor frame with pkt_type 0x%2.2x",
> +                  hci_skb_pkt_type(skb));
> +       kfree_skb(skb);
> +       return -EINVAL;
> +}
> +EXPORT_SYMBOL(hci_send_vendor_frame);
> +
>  /* Send HCI command */
>  int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
>                  const void *param)
> @@ -4066,6 +4080,14 @@ static void hci_rx_work(struct work_struct *work)
>                         break;
>
>                 default:
> +                       if (hci_is_vendor_frame(hdev, skb)) {
> +                               BT_DBG("%s Vendor packet with type 0x%2.2=
x",
> +                                      hdev->name, hci_skb_pkt_type(skb))=
;
> +                               if (hdev->recv_vendor) {
> +                                       hdev->recv_vendor(hdev, skb);
> +                                       break;
> +                               }
> +                       }
>                         kfree_skb(skb);
>                         break;
>                 }
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 070ca388f9ac..903498e6db3d 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -229,12 +229,16 @@ void hci_send_to_sock(struct hci_dev *hdev, struct =
sk_buff *skb)
>                 } else if (hci_pi(sk)->channel =3D=3D HCI_CHANNEL_USER) {
>                         if (!bt_cb(skb)->incoming)
>                                 continue;
> -                       if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT &&
> -                           hci_skb_pkt_type(skb) !=3D HCI_ACLDATA_PKT &&
> -                           hci_skb_pkt_type(skb) !=3D HCI_SCODATA_PKT &&
> -                           hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT &&
> -                           hci_skb_pkt_type(skb) !=3D HCI_DRV_PKT)
> +                       if (hci_is_vendor_frame(hdev, skb)) {
> +                               if (!hci_sock_test_flag(sk, HCI_SOCK_RCV_=
VENDOR_PKT))
> +                                       continue;
> +                       } else if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_P=
KT &&
> +                                  hci_skb_pkt_type(skb) !=3D HCI_ACLDATA=
_PKT &&
> +                                  hci_skb_pkt_type(skb) !=3D HCI_SCODATA=
_PKT &&
> +                                  hci_skb_pkt_type(skb) !=3D HCI_ISODATA=
_PKT &&
> +                                  hci_skb_pkt_type(skb) !=3D HCI_DRV_PKT=
) {
>                                 continue;
> +                       }
>                 } else {
>                         /* Don't send frame to other channel types */
>                         continue;
> @@ -359,6 +363,7 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct=
 sk_buff *skb)
>         struct sk_buff *skb_copy =3D NULL;
>         struct hci_mon_hdr *hdr;
>         __le16 opcode;
> +       bool is_vendor_frame =3D false;
>
>         if (!atomic_read(&monitor_promisc))
>                 return;
> @@ -400,7 +405,26 @@ void hci_send_to_monitor(struct hci_dev *hdev, struc=
t sk_buff *skb)
>                 opcode =3D cpu_to_le16(HCI_MON_VENDOR_DIAG);
>                 break;
>         default:
> -               return;
> +               is_vendor_frame =3D hci_is_vendor_frame(hdev, skb);
> +               if (!is_vendor_frame)
> +                       return;
> +               if (bt_cb(skb)->incoming)
> +                       opcode =3D cpu_to_le16(HCI_MON_VENDOR_RX_PKT);
> +               else
> +                       opcode =3D cpu_to_le16(HCI_MON_VENDOR_TX_PKT);
> +               break;
> +       }
> +
> +       if (is_vendor_frame) {
> +               skb_copy =3D __pskb_copy_fclone(skb, HCI_MON_HDR_SIZE + 1=
,
> +                                             GFP_ATOMIC, true);
> +               if (!skb_copy)
> +                       return;
> +
> +               *(u8 *)skb_push(skb_copy, 1) =3D hci_skb_pkt_type(skb);
> +               hdr =3D skb_push(skb_copy, HCI_MON_HDR_SIZE);
> +               hdr->len =3D cpu_to_le16(skb->len + 1);
> +               goto out_comm;
>         }
>
>         /* Create a private copy with headroom */
> @@ -408,14 +432,15 @@ void hci_send_to_monitor(struct hci_dev *hdev, stru=
ct sk_buff *skb)
>         if (!skb_copy)
>                 return;
>
> -       hci_sock_copy_creds(skb->sk, skb_copy);
> -
>         /* Put header before the data */
>         hdr =3D skb_push(skb_copy, HCI_MON_HDR_SIZE);
> +       hdr->len =3D cpu_to_le16(skb->len);
> +
> +out_comm:
>         hdr->opcode =3D opcode;
>         hdr->index =3D cpu_to_le16(hdev->id);
> -       hdr->len =3D cpu_to_le16(skb->len);
>
> +       hci_sock_copy_creds(skb->sk, skb_copy);
>         hci_send_to_channel(HCI_CHANNEL_MONITOR, skb_copy,
>                             HCI_SOCK_TRUSTED, NULL);
>         kfree_skb(skb_copy);
> @@ -1868,7 +1893,8 @@ static int hci_sock_sendmsg(struct socket *sock, st=
ruct msghdr *msg,
>                     hci_skb_pkt_type(skb) !=3D HCI_ACLDATA_PKT &&
>                     hci_skb_pkt_type(skb) !=3D HCI_SCODATA_PKT &&
>                     hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT &&
> -                   hci_skb_pkt_type(skb) !=3D HCI_DRV_PKT) {
> +                   hci_skb_pkt_type(skb) !=3D HCI_DRV_PKT &&
> +                   !hci_is_vendor_frame(hdev, skb)) {
>                         err =3D -EINVAL;
>                         goto drop;
>                 }
> @@ -2017,6 +2043,7 @@ static int hci_sock_setsockopt(struct socket *sock,=
 int level, int optname,
>  {
>         struct sock *sk =3D sock->sk;
>         int err =3D 0;
> +       int opt_int;
>         u16 opt;
>
>         BT_DBG("sk %p, opt %d", sk, optname);
> @@ -2050,6 +2077,23 @@ static int hci_sock_setsockopt(struct socket *sock=
, int level, int optname,
>                 hci_pi(sk)->mtu =3D opt;
>                 break;
>
> +       case BT_RCV_VENDOR_PKT:
> +               if (hci_pi(sk)->channel !=3D HCI_CHANNEL_USER) {
> +                       err =3D -ENOPROTOOPT;
> +                       break;
> +               }
> +
> +               err =3D copy_safe_from_sockptr(&opt_int, sizeof(opt_int),
> +                                            optval, optlen);
> +               if (err)
> +                       break;
> +
> +               if (opt_int)
> +                       hci_sock_set_flag(sk, HCI_SOCK_RCV_VENDOR_PKT);
> +               else
> +                       hci_sock_clear_flag(sk, HCI_SOCK_RCV_VENDOR_PKT);
> +               break;
> +
>         default:
>                 err =3D -ENOPROTOOPT;
>                 break;
> @@ -2132,6 +2176,7 @@ static int hci_sock_getsockopt(struct socket *sock,=
 int level, int optname,
>  {
>         struct sock *sk =3D sock->sk;
>         int err =3D 0;
> +       int opt_int;
>         u16 mtu;
>
>         BT_DBG("sk %p, opt %d", sk, optname);
> @@ -2153,6 +2198,19 @@ static int hci_sock_getsockopt(struct socket *sock=
, int level, int optname,
>                         err =3D -EFAULT;
>                 break;
>
> +       case BT_RCV_VENDOR_PKT:
> +               if (hci_pi(sk)->channel !=3D HCI_CHANNEL_USER) {
> +                       err =3D -ENOPROTOOPT;
> +                       break;
> +               }
> +
> +               opt_int =3D hci_sock_test_flag(sk, HCI_SOCK_RCV_VENDOR_PK=
T) ?
> +                         1 : 0;
> +               if (copy_to_iter(&opt_int, sizeof(opt_int),
> +                                &sopt->iter_out) !=3D sizeof(opt_int))
> +                       err =3D -EFAULT;
> +               break;
> +
>         default:
>                 err =3D -ENOPROTOOPT;
>                 break;
>
> ---
> base-commit: 7f02cdbb4cf17df8aa1977eea0cf490c472a706d
> change-id: 20260719-support_vendor_hci-1fbb4449ab8e
>
> Best regards,
> --
> Zijun Hu <zijun.hu@oss.qualcomm.com>
>


--=20
Luiz Augusto von Dentz

--000000000000d6b11a06570bbf6a
Content-Type: image/png; name="image.png"
Content-Disposition: attachment; filename="image.png"
Content-Transfer-Encoding: base64
Content-ID: <f_mrtb9aqu0>
X-Attachment-Id: f_mrtb9aqu0

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
H1KzZk0OHTrEqVOnoPjpIxTXYWnfvj2LFy/m/Pnz1KpVi0OHDrF3717Gjh1b6rIOd3d3nnvuOebO
ncu3337L008/XebrYJml89VXX9G2bVsefvhhgoODee+995g5cyYdO3YkLy+Pf//731StWrVEsVUR
ERG5u/r3709UVBSzZs2iZ8+e5OXlER4eTvXq1UsUnxcREdtxWzMy9u3bR0ZGBvfee+9123Ts2JGk
pCRiY2Oh+AkiTz/9NBcuXODbb7/l8OHDDBs2jBdffPG6fVSrVo2xY8dy8uRJli9fflNjfO655xgy
ZAgxMTEsWrSII0eOMGzYsFILO/r7+1OpUiWrQo2+vr74+PjQqlUr7O3tf/dYvXr1Muoi/PDDD6xe
vZpWrVoxe/Zs40N9s2bNmDRpEgDLly/n4MGDPP/88yWePHJtu/379zN+/HicnJzKre6C5fGuXbt2
ZefOnSxevJjTp08zYcIEevXqdVN9ubu78+STT5KSksLq1autZlOU5vnnn2f//v0sWbKE9PR0xowZ
Q1BQkLF/3LhxPPDAA0RHR7Nu3Tpq1arFjBkzqF+/PqmpqUY7y1h3795NSEgIly9fZvLkyTz00EPX
PXa7du3o2bMnERERHD58uMzXoX379nTr1o2YmBi2bNkCxbN6Xn31VQoKCli2bBnr1q2jUaNGvP76
61ZPnBEREZG7r2bNmsyePZs6deqwcuVKwsPD8ff3Z9asWdeteyYiIn98JvM1z56Ki4ujUaNGFTci
ua7s7GxGjRpF7969GT16dEUP55YsWbKE1atXExISctcLioqIiIht032qiMifX1n+rddzp/6gTp8+
TUREhNW2rVu3QvGSChEREREREZH/ReXy+FUpf5alMEePHqVly5acPXuWDRs20KBBA6sipSIiIiIi
IiL/SxRk/EH16dMHd3d3wsPD+eWXX6hcuTL3338/jz/+OA4O+msTERERERGR/02qkSEiIiIiNkH3
qSIif36qkSEiIiIiIiIifyoKMkRERERERETEZijIEBERERERERGboSBDRERERERERGyGggwRERER
ERERsRkKMkRERERERETEZijIEBERERERERGboSBDRERERERERGyGggwRERERERERsRkKMkRERERE
RETEZjiUtjEuLu7uj0RERERE5AZ0nyoiIqUGGd7e3nd/JCIiIiIivyMxMVH3qSIif3KJiYk3bKOl
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
EREREREREZuhIENEREREREREbIaCDBERERERERGxGQoyRERERERERMRmKMgQEREREREREZuhIENE
REREREREbIZDaRsTExPv/khERERERG5A96kiIlJqkNGoUaO7PxIRERERkd8RFxen+1QRkT+5uLi4
G7bR0hIRERERERERsRkKMkRERERERETEZijIEBERERERERGboSBDRERERERERGyGggwRERERERER
sRkKMkRERERERETEZijIEBERERERERGboSBDRERERERERGyGggwRERERERERsRkKMkRERERERETE
ZijIEBERERERERGboSBDRERERERERGyGggwRERERERERsRkKMuSuyMnJYciQISxZsqSihyIiIiIi
IiI2zOF2O9izZw/vvPMOEyZMICgoqMT+jRs38vnnnzNjxgxat25tbC8oKGDdunVs2bKFS5cu4ejo
SNOmTXnsscdo3ry50e7UqVO8+uqrjBgxgoEDB95wPAUFBTz77LO4uLjw8ccfX7ddWloay5cv59df
fyU1NRV3d3fatGnD0KFDqV69utFu0aJFrFu3ji+++AJPT88yX5fJkydz+vRp42c3NzeaNm1K3759
8ff3L3M/Vzty5AjR0dH0798fZ2fnW+rjz0DXQURERMpq69atrF69mvPnz+Pq6kqzZs14/PHHqVWr
VkUPTUREblGFzMgoKipi3rx5fPvtt/j4+DB48GAeeOABzp49y8yZMzl27Ngt971//37S09OJj4/n
6NGjpbZJSUlh6tSpREZG0rZtW4YOHUpgYCA7duxg+vTpZGZm3sbZ/VeVKlUYNWoUo0aNokePHiQk
JDBnzhx+/PHHW+ovNjaW0NBQcnJyymV8tkrXQURERMpiw4YNfPzxx1SqVIlhw4bRvXt3Dh06xOuv
v86VK1cqengiInKLbntGxq1Yv349Bw8e5KmnnqJPnz7G9kceeYRJkybx2Wef8f77799S31FRUTRs
2JCsrCyioqJo0aJFiTZfffUVKSkpzJkzh8aNGxvbu3XrxowZM/juu+945plnbvHs/svV1ZW+ffsa
Pw8bNoyFCxfyww8/0LhxY9q2bXvbxxARERGRkgoLC/n+++9p0qQJs2fPxmQyAdCsWTPmzZvH1q1b
re7TRETEdlRIkBEeHo63tzcPP/yw1XZ3d3d69uxJaGgoFy5coHbt2jfVb2ZmJvv27WPEiBFkZGQQ
Hh7O6NGjcXR0NNokJSWxd+9eunTpYhViALRo0YJWrVrx66+/lkuQcS07OzvGjh3L/v37WbFihVWQ
ce7cOUJCQvjtt98oLCykadOmPP7449SvX5+zZ88yadIko+24cePw9fVl/vz5AGRkZPDDDz+wb98+
rly5Qp06dXj00Ue59957rzuWJUuWEBkZydixY1mxYgUXL16katWq9O3b1ypcutHYrhYeHk5ERATx
8fG4u7vTtWtXhgwZYnX9r3bixAlmzZpFs2bNmDp1Kvb29pjNZtavX094eDjJycnUqFGDgQMH0rVr
1xteBxERERGLS5cukZOTw3333WeEGABt27bFZDKRkJBQoeMTEZFbd9eDjMuXLxMfH0+vXr2wsyu5
suWhhx6iRYsWuLm53XTfO3bsoLCwkKCgILKzs/nxxx/Zu3cvnTp1MtocO3YMs9lM+/btS+3jmWee
ITk5mcLCQuzt7W96DDdSqVIlAgMD2bJlCzk5OTg7OxMfH8/06dOpVq0agwYNoqCggLVr1/LGG28w
f/58vL29mTp1Ktu3b2fLli1MmDDBqOORn5/PnDlzSEhIoE+fPnh4eBAVFcX8+fP5xz/+wT333HPd
sWRmZhISEsKwYcOoUqUKGzZsYNGiRbi5udG1a1eAG46tSpUqAKxdu5bFixcTGBhIz549OXv2LKtW
rSI9PZ3nnnuuxLETEhKYN28e3t7eTJo0ybjWixYtIiIigu7du1O3bl327dvHggULcHd3p2XLlte9
DiIiIiJXq1OnDiEhISW2JycnYzabb/oLMxER+eMotyAjIyOD5OTkEtuvrTeRmpoKcN0PoFWqVMHP
z++WxhAVFYW/vz+enp54enrStGlTtmzZYhVk3Oj4tWvXvuNvbDVr1qSoqIjk5GTq1KnDL7/8gpub
GzNmzDCCgQYNGvDGG29w6NAhunTpQtu2bfnPf/4DQOvWrY3Co3FxcaSnp/PXv/6VwMBAALp06cK4
cePYtm3b7wYZAFOmTKFevXoA+Pn5MXHiRMLCwowgoyxjy83NZcWKFXTo0IHJkycbfVetWpXly5cz
aNAg3N3dje2ZmZnMnTsXgL///e+4uLgAcPLkSdavX8+oUaOMqZ69e/fmtddeY8WKFbzxxhvXvQ4i
IiIiZbFy5UpcXFzo0qVLRQ9FRERuUbkFGV9//TVff/31DdsVFBRA8cyE8hQfH8+xY8d48cUXjW1d
unRh8eLFpKenGx+k8/Pz78jxb4aTkxMAubm5APTv35/+/ftbtalbty4UL4X5Pc2bN+eTTz6x2la5
cmWqVat2w9cCVhW77ezsCAoKIjQ0lMuXL1O1atUyje3o0aOkp6dz//33W7V78MEHMZlMxt85xetV
3333XRITE5k5cybe3t7Gvl27dmEymWjfvj3p6enGdn9/f9auXXvHZsmIiIjI/4bt27ezceNGxo8f
b3yRIiIitqfcgozg4OBSC2seOnSI9evX//eADv93SMuH+PISFRWFg4MDDRs2JDExEYCmTZtSVFTE
tm3b6N27N4BRr6G8j38z8vLy4JowJSYmhlWrVnHq1ClSU1Mxm81Q/ISXG7l48SJhYWHExMQYy2L4
nVknv6dGjRpQHFJUrVq1TGOzrDGtWbOmVV9eXl4MHjwYwHjCyKZNm8jOzqZevXo0bNjQqn18fDxm
s9kqjLra5cuXtZREREREbslvv/3GwoUL6d69O927d6/o4YiIyG0otyCjQYMGxtKGq1mWclhYlgJc
b7ZAeno658+fp27dujdVJ2Pr1q0UFBQwceLEEvuioqKMIMOyPCIpKYkmTZqUaBsfH8/ly5dp1qxZ
qTU8ysP58+exs7PDy8sLgN27d/Pee+9x7733Mm7cODw9PcnKyuKNN964YV+JiYlMmTKFGjVqMHTo
UGrWrImjoyPvvPPOLY3NEoJY3MzYri6kdT3Z2dl07NiR3bt3s3z5coYOHWrsy8/Px8nJiddee63U
13p4eNzSOYmIiMj/tvj4eObNm0eLFi0YN25cRQ9HRERu010v9lm1alV8fHzYt28fTz/9dIkPv+Hh
4YSGhvLBBx+UOcg4duwYly5dYujQoUa9B4vjx4/z008/cf78eerUqUPz5s0xmUwlioBaLFy4kAsX
LvDFF1/c5pmWLjs7m71799K8eXOcnZ0B+Pe//423tzcTJ040rse1AdD1bNu2jezsbCZPnmy1TON6
Twq5kXPnzgEYfZVlbD4+PlBcHdyy7MRyrnFxcdSrV88YT1BQEBMmTOC9994jLCyMwMBAI1CqVq0a
eXl51K5d2wh5RERERG5Heno6b775Jl5eXlYFxkVExHbdmSkHN9CrVy8SExOJjIy02p6ZmcmGDRuo
W7fuTRXcjIqKwtnZmQEDBtChQwer/4KDg7G3tycqKgqKP6C3a9eOHTt28P/Zu/O4Ksv8/+Ovw+YG
IpshCSpK7gq44b7v+5q5NDW2TJNW1phmZmplkw5TU9ZU37TUzCyyNHJDSDQFVBRcEjWp3BAR2RFk
+/0xnvvnEVRQk069n49Hj+Fc5z7X/blvmjjnfa7l1KlTFv0cPXqUI0eO0KFDhzt0pZaKior44IMP
yMnJYeTIkRbthYWFFtNI9u13xWWiAAAgAElEQVTbV+r15jDg2jUnuGq6CsDJkyfLtT4GV67ZLD8/
nx9++AEfHx9j5Ex5amvSpAlOTk7GPTaLiIhg/vz5FovAurq6wpXdYWrWrMmSJUuM2tu1awfAV199
ZdHPkSNHiIyMvOF9EBEREbnW5cuXeeONNygqKmL27NlUq1atsksSEZE74K6PyAAYNGgQcXFxfPjh
hxw6dIj69euTnp7Orl27yMzM5B//+Ee5+yosLCQqKoqAgIAyRyE4OjrSrFkzduzYwfjx4zGZTDz6
6KPMmTOHOXPm0KNHD1xcXEhOTmb79u24uroyfvz4Uv18//33pf74mUwm+vfvf93acnJy2LRpEyUl
JaSnpxMdHU1SUhL3338//v7+xnFBQUEsXbqU+fPn06JFC06dOkVcXBwAubm5xnHmhTk/+ugj/P39
GTBgAO3ateOrr77i9ddfp0uXLmRlZbFjxw5KSkpK7RhTluDgYPr374+zszORkZGkpaXx4IMPVqi2
KlWqMGrUKJYvX87ixYtp0aIFZ86cITw8nE6dOlG/fn1jjQwzJycn/va3v/H666/z6aef8te//pVW
rVrRsWNHtm7dSnp6Oq1atSI1NZVNmzYRGBhI9+7dr3sfRERERK71zjvvcOzYMUaOHMn+/ftLPd+2
bdsKTWUWEZHfh0oJMmxtbZk1axbr168nMjKS6OhoqlatSuPGjRk9ejR+fn7l7mvfvn1kZ2fTvn37
6x7ToUMHPvroI3788UeaN2+Om5sbCxcu5IsvvmDXrl1kZ2fj7OxM165dGTduHDVq1CjVx+rVq0u1
2djY3DDIyMjIYNmyZZhMJhwdHbnvvvt49NFHS22J2q9fP/Ly8ggLC2PdunU0atSIhQsX8uGHH3Lp
0iXjuLZt29K9e3eio6PJyMhgwIAB1KtXjxkzZvD5558TGhqKh4cH06ZN49ChQxw/fvymO338/e9/
JyQkhFOnTuHi4sKUKVPo3LlzhWsbPHgwtra2bN68mbi4ONzd3Rk/fjxDhgy57rkDAgLo27cvmzdv
pl27drRs2ZKnnnoKb29vtm3bRlxcHC4uLgwbNoxRo0bd8D6IiIiIXMv85cvXX39d5vOLFi1SkCEi
YoVMJeYtKK5ITEzE19e38iqSu2LlypV8++23rFq16pbX0xARERG5m/Q+VUTkj688/62vlDUyRERE
RERERERuhYIMEREREREREbEaCjJERERERERExGooyPiTmjx5Ml988YXWxxARERERERGroiBDRERE
RERERKyGggwRERERERERsRoKMkRERERERETEaijIEBERERERERGroSBDRERERERERKyGggwRERER
ERERsRoKMkRERERERETEaijIEBERERERERGroSBDRERERERERKyGggwRERERERERsRp2ZTUmJibe
/UpERERERG5C71NFRKTMIMPDw+PuVyIiIiIicgMpKSl6nyoi8geXkpJy02M0tURERERERERErIaC
DBERERERERGxGgoyRERERERERMRqKMgQEREREREREauhIENERERERERErIaCDBERERERERGxGgoy
RERERERERMRqKMgQEREREREREauhIENERERERERErIaCDBERERERERGxGgoyRERERERERMRqKMgQ
EREREREREauhIENERERERERErIaCDBERERERERGxGgoyfiP5+flMmTKFkJCQyi5FfscWLFjAggUL
KrsMERERERERq2F3ux3s37+fJUuW8Nhjj9GhQ4dSz2/fvp3ly5czY8YMmjRpYrQXFhaydetWdu3a
xfnz57Gzs8PX15dhw4bRqFEj47iTJ08yf/58Ro8ezaBBg65bR3Z2NqGhoRw8eJDU1FSqVatGs2bN
GDFiBB4eHrd7mXIHzJs3j1OnThmPa9Soga+vL/369aNZs2a31OexY8dISEigf//+VKlS5Q5Wa10u
XrzIDz/8QJs2bbj33nsruxwREZHfhZKSEnbt2kV4eDhJSUlUr16dhg0bMnz4cP29FBGxYpUyIqO4
uJi3336bL7/8End3d4YNG0bXrl05e/YsixYt4qeffqpQf5mZmcyfP59t27Zx3333MWzYMNq2bUtc
XByvvvoqFy5c+M2uRSqmZs2ajB8/nvHjx9O9e3cuXLhAcHAw33777S31d/ToUdatW0deXt4dr9Wa
pKamsm7dOk6fPl3ZpYiIiPxufP311yxbtgxXV1fGjBlDt27dSExMZOHChVy8eLGyyxMRkVt02yMy
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
BwcHhgwZwueff86SJUto2rQpSUlJbN++nfbt2+Pj41PqvCaTiYcffpi5c+fyf//3f8yZM4dmzZrR
rl07IiMjycjIoHnz5ly8eJHw8HBat25tbD/r7u6Ora0tmzdvJjU1lT59+mgLVhER+VOztbVlxIgR
rF69mkWLFhEQEEBmZibff/89np6eFou2i4iIdamUIMPW1pannnqKTZs2sWvXLvbu3UuVKlVo1KgR
Q4cOxdfXt0L9eXt7M3/+fDZs2MCBAweIiYnByckJHx8fHnvssVKLkDZs2BAXFxc8PDxuaT0HgMcf
f5y1a9eyZ88ecnNzqVOnjsV2pLfLvBNLSEgIkZGR5OXl4eXlxd///ncCAwMr3F+XLl2oUqUKGzdu
ZM2aNVStWpUOHTowevRoiykXkydPxsHBgbi4OGJjY2nRogUTJkxg5cqVxjHu7u7Mnj2bkJAQIiIi
uHz5MnXr1uWZZ54ptfvKtTIzM1m1ahUmk4kaNWrQsGFDJk+eXGpL1J49e5Kfn8+2bdvYuHEjDRo0
YM6cOaxYscJiSo+/vz+dOnVi7969ZGZm0qtXL7y9vZk6dSpff/01W7Zswc3NjUcffZQjR46QmJh4
050+xo8fz8GDB4mOjsbe3p5evXoxbty4CtfWt29fbG1tiYiI4NChQ7i6ujJy5Ej69et33XO7uLgw
adIkPvzwQ7799ltGjBjBo48+ipeXFzt37uTQoUM4OzszcOBAixEsjo6O3H///axbt47NmzfTtWtX
BRkiIvKn16dPH2rWrMnGjRv56quvqFq1Km3btmXMmDF3dAc9ERG5u0wl1yxUkZiYWKH1F6xRQUEB
zzzzDCNHjqRPnz6VXY78TsTHx/P2228zffp0i9EhIiIi8vuQkpLyh3+fKiLyZ5eSknLTwQ2VskZG
ZYuJieHy5cu3NLJBRERERERERCpPpUwtqSwJCQns27ePHTt20KVLF2MXChERERERERGxDn+qERnH
jx9n+/bttGzZkgkTJlR2OSIiIiIiIiJSQX/KNTJERERExPpojQwRkT8+rZEhIiIiIiIiIn8oCjJE
RERERERExGooyBARERERERERq6EgQ0RERERERESshoIMEREREREREbEaCjJERERERERExGooyBAR
ERERERERq6EgQ0RERERERESshoIMEREREREREbEaCjJERERERERExGrYldWYkpJy9ysREREREbkJ
vU8VEZEygwxfX9+7X4mIiIiIyA0kJibqfaqIyB9cYmLiTY/R1BIRERERERERsRoKMkRERERERETE
aijIEBERERERERGroSBDRERERERERKyGggwRERERERERsRoKMkRERERERETEaijIEBERERERERGr
oSBDRERERERERKyGggwRERERERERsRoKMkRERERERETEaijIEBERERERERGroSBDRERERERERKyG
ggwRERERERERsRoKMv6EZs2axaxZsyq7DBEREREREZEKs7vdDvbs2cPixYt5+umn6dy5c6nnw8PD
+eCDD3j55Zdp3ry50V5YWMiGDRuIjIzk3Llz2Nvb4+fnx5gxY2jcuLFx3C+//MLzzz/PhAkTGDFi
xA1ruJ5Ro0Yxfvz4273UCgsJCaFBgwa0adPmrp/7bjhy5AiHDh1i6NChVK1atbLLEREREbmhAwcO
8OqrrxIYGKgvdURErNhtBxm3ori4mDfeeIP4+HjatGlD165dyczMZNeuXcybN4958+ZZhBnl1b17
d+rXr1+q3c/P7w5VXjEhISH07t37Dxtk/Pjjj3z55Zf07dtXQYaIiIj8rhUWFrJs2bLKLkNERO6A
SgkyNm7cSHx8PA899BCDBg0y2keOHMlzzz3H+++/z5tvvlnhfv39/cscFSIiIiIif26hoaGkpaXh
6OhY2aWIiMhtqpQgY9OmTXh4eDBgwACLdicnJ/r27cuXX37J2bNn8fLyumPnXL58ORs3buSjjz6y
+AP2wQcf8MMPP7B06VIcHBy4dOkSq1evJioqikuXLtGwYUMmT55Mo0aNAMjLy+PBBx9k7Nix5Obm
snPnTvLy8mjcuDFTpkzB09OT4OBgYmJiAAgLCyMsLIxnn32WoKCgUnWtXLmSiIgIHnnkEdauXUtS
UhIuLi4MHjzYIuQBOH36NKtWreL48eMUFRXh5+fHxIkTqVevXqn7u3nzZpKTk3FycqJbt26MGzcO
e3v7Mu9NdnY2L774Inl5eSxcuBA3NzdKSkrYuHEjmzZtIjU1lXvuuYcRI0bQrVs3Tp06xXPPPWe8
/rHHHsPb25vg4ODb/C2JiIiI3Hmpqal89dVX3H///WzcuLGyyxERkdt01xf7TEtLIzk5mcDAQGxs
Sp++X79+vPTSS3c8Le/UqRPFxcXs27fPaCspKWHfvn20adMGBwcHCgsLWbBgATt27KBPnz6MGTOG
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
R0REROS34uXlVeYXYw4ODtSsWbNcu8qJiMjvU6UEGba2tsyaNYv169cTGRlJdHQ0VatWpXHjxowe
PRo/P79b6vf777/n+++/L9Xet29fI8jgSiiwefNmi2klANWrV2fBggV89tlnREVFERERgZeXF08/
/TSdO3eucD0PP/ww7733HuvXr6dBgwY3DDL+/ve/ExISwqlTp3BxcWHKlCkW5+zXrx95eXmEhYWx
bt06GjVqxMKFC/nwww+5dOmScdzgwYOxtbVl8+bNxMXF4e7uzvjx441pI2VxdXXlkUce4T//+Q8h
ISHcf//9PPXUU3h7e7Nt2zbi4uJwcXFh2LBhjBo1ynhd27Zt6d69O9HR0WRkZCjIEBERERERkd+c
qcS89cUViYmJ+Pr6Vl5FfzIrV67k22+/ZdWqVXd9QVERERERa6L3qSIif3zl+W99payRISIiIiIi
IiJyKxRkiIiIiIiIiIjVUJAhIiIiIiIiIlZDQUYlmzx5Ml988YXWxxAREREREREpBwUZIiIiIiIi
ImI1FGSIiIiIiIiIiNVQkCEiIiIiIiIiVkNBhoiIiIiIiIhYDQUZIiIiIiIiImI1FGSIiIiIiIiI
iNVQkCEiIiIiIiIiVkNBhoiIiIiIiIhYDQUZIiIiIiIiImI1FGSIiIiIiIiIiNWwK6sxMTHx7lci
IiIiInITep8qIiJlBhkeHh53vxIRERERkRtISUnR+1QRkT+4lJSUmx6jqSUiIiIiIiIiYjUUZIiI
iIiIiIiI1VCQISIiIiIiIiJWQ0GGiIiIiIiIiFgNBRkiIiIiIiIiYjUUZIiIiIiIiIiI1VCQISIi
IiIiIiJWQ0GGiIiIiIiIiFgNBRkiIiIiIiIiYjUUZIiIiIiIiIiI1VCQISIiIiIiIiJWQ0GGiIiI
iIiIiFgNBRkiIiIiIiIiYjUUZMhvYsGCBSxYsKCyyxAREREREZE/GLvb7WD//v0sWbKExx57jA4d
OpR6fvv27SxfvpwZM2bQpEkTo72wsJCtW7eya9cuzp8/j52dHb6+vgwbNoxGjRoZx508eZL58+cz
evRoBg0aVGYN1zvmzJkzrF+/nsTERDIzM3FxcaFNmzYMHz4cBwcHiz5yc3P59ttviY2NJSMjg5o1
a+Lv78/w4cNxdHS84T2YN28ep06dMh7XqFEDX19f+vXrR7Nmzcp5Jy0dO3aMhIQE+vfvT5UqVW6p
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
5Enmzp1LcnIyo0ePZuTIkZw+fZqXXnqJs2fPWhy7YcMGMjIyGDNmDH5+fmVeb7169QDYsmVLqeee
eeYZXnvtNYu2jz76iMDAQGbOnEm/fv0ICwtj2bJlxvOFhYUsWLCAHTt20KdPH8aMGUN6ejqvvPIK
GRkZxnHfffcdy5Ytw9PTk0mTJhEYGMj69etZunRpmXU+8MADTJgwAYAxY8Ywe/ZsvLy8yjy2on2L
iIiIWANnZ2dMJlO5js3Pz2f58uX06tWLhg0b/ua1iYjIrbvtERkmk4lOnTqxYcMG0tLScHFxATCC
jS5duhjHrlixgqpVq7Jw4UKqVasGQIMGDfj3v//NgQMHaNWqlXHs3/72N2PEQNOmTYmNjSU2NpZO
nToB8OWXX1K9enUWLFiAk5MTXFmzY968eRb1rVixApPJxCuvvIKzszMA3bp14+mnn2bFihXMmjXL
OLZJkya8/PLLRvBSlgEDBrBv3z5WrFjBnj176NGjB+3bt6dGjRplHj9p0iQGDhwIQMuWLUlPTycy
MpL7778fV1dXNm/eTGJiIq+//jq+vr5GfdOmTWPDhg088MAD5Ofns3btWtq1a8eMGTOMvl1cXAgJ
CWH06NF4eHhYnNfX15ecnBzjHvv7+5dZ3630LSIiIvJHs3btWi5dusSECRPIy8ur7HJEROQGbntE
BlfCipKSEmJiYoy2qKgoPD09jekR+fn57Nu3jzZt2lBYWEhWVhZZWVk0btwYW1tbjh49atHn1R+8
HRwccHFxITMzE66sX3Ho0CGCgoKMEIMrgYed3f/PZnJycjh48CBdu3Y1QgwAV1dXOnXqRFxcnMUf
qvvuu++GIQZAlSpVmDdvHk888QS5ubn897//5ZFHHuGtt97i3LlzpY6vU6eOxeOuXbtSVFTEkSNH
jPvk4+ODh4eHcU/s7e1p0KCBcU8SEhLIysqiR48eFn317t2bsWPHlhqFUhG/Zd8iIiIi1sC8wOf9
999v8d5SRER+n257RAZAw4YNqVOnDtHR0QwYMICUlBR++uknxowZYxxz4cIFioqK2LJlS5nTMswL
U16PyWSiuLjYOLakpOS6UyXMUlJSKCkpMaaDXM3Hx4fi4mJSUlIqPOLAZDLRs2dPevbsycmTJ/nh
hx8ICwsjNjaWBQsW0KBBg+u+1tPT07gGrky3ycjIYMqUKaWONe9+Yl6Xw/xaMzc3N8aOHVuh2q/1
W/YtIiIiYg2WLVuGl5cX/fr1q+xSRESkHO5IkMGVURkhISFkZGSUOa2koKAAgL59+xIUFFTq9ebF
Pq2Nj48PEyZMoG/fvjz//PMsX7681PSWqxUVFVk8LigowM/Pj/Hjx5c69tqFNss7x/NW/JZ9i4iI
iPxexcTEEB8fz/Tp043Rv+b/vXTpEunp6Tg5OZW5m52IiFSOOxpkfPnll8TExBAdHY2vr6/FiAnz
1qyFhYW0bNnyts7l7u6OjY1NqcU6r+Xh4YHJZOLkyZOlnjt58iQ2NjYVGo1RXFzM008/TevWrXnk
kUdKnatRo0YcP378hn2cPn3auAau3JfMzMwb3hPzyIxz585Rt25do/3SpUskJibi4+Nzy8Mgf8u+
RURERH7vQkNDAXjzzTdLPRcSEkJISAiLFi2ifv36lVCdiIiU5Y6skcGVtSAaNmzIpk2b+Omnn+ja
tavF805OTjRu3JidO3eSnJxstBcVFbFmzRoj+S4PW1tbWrVqRXR0tLGgJcDBgwct1nSoUaMGLVq0
YMeOHRb9p6WlsWvXLlq3bk3VqlXLfV4bGxtq1arFzp07SUpKsnguOzubX375pdTIkmvX/ggPD8fO
zo5mzZoB0LZtW5KTk0ttCbZlyxZOnDgBVxYhdXJyYvv27RbHREREMH/+fFJTU8t9Ddf6LfsWERER
+b2bPHkys2fPtvjnySefhCtrhs2ePZt77rmnsssUEZGr3LERGVwZlbF8+XJjJ5NrPfTQQ7z88svM
mTOHvn37UrNmTXbu3MnPP/9M27ZtqVmzZrnPNWbMGP5fe3ceXtO1uHH8mzmGhCBCIkSImOcpqqg5
5qG0plar1ZYqqhRtVVWrNXTkdzsYernGoFzz3BBCYy5qTEhNEUESZM75/ZGcfZ0kiLlH38/zeB7Z
Z5291t7niLXfvdbaY8aM4cMPP+TZZ5/l+vXrbNmyJdtinS+//DIffvghH330Ec2aNcNkMrFx40Zs
bW156aWX7vkYX3vtNcaNG8eIESMICAjA09OT+Ph4duzYQVxcHH379rUo/+uvv3Lt2jV8fHw4fPgw
YWFhtGjRwni6S8eOHdm5cydTp07l6NGjeHt7c/z4cbZu3Uq/fv0oU6YMTk5OdOnShX//+99MmjSJ
ypUrc+7cOTZt2kSDBg0e6A7Bo9y3iIiIyN9duXLlsm2Ljo4GwNPT87ZPfhMRkSfnoQYZzzzzDHPm
zKFixYrGhfqtypQpw6effsq8efNYuXIlNjY2lC1blk8++eSen9ddrlw5hg0bxrx581i8eDHFixdn
wIABzJ4926JcyZIlGTduHHPnzmXx4sWQOQph+PDheHl53fMxlipVismTJ7Ns2TL27t1LSEgIrq6u
lC5dmsGDB1O+2OOc1wAAIABJREFUfHmL8i+//DL79+8nJCQEBwcHWrVqZRGgmB8hO2/ePEJDQ9m8
eTOenp4MHjyYZ555xijXtm1b7OzsWLduHfv376dIkSK8+OKLtGvX7p6PIatHuW8RERERERGRh8nG
ZDKZbt0QHh6Or6/vk2vRU2LPnj18+eWXjB49Wkm+iIiIyEOgfqqIyNMvN7/rH9oaGSIiIiIiIiIi
j5qCDBERERERERGxGgoyRERERERERMRqPNTFPuV/atWqxaJFi550M0RERERERESeKhqRISIiIiIi
IiJWQ0GGiIiIiIiIiFgNBRkiIiIiIiIiYjUUZIiIiIiIiIiI1VCQISIiIiIiIiJWQ0GGiIiIiIiI
iFgNBRkiIiIiIiIiYjUUZIiIiIiIiIiI1VCQISIiIiIiIiJWQ0GGiIiIiIiIiFgN+5w2hoeHP/6W
iIiIiIjchfqpIiKSY5Dh7u7++FsiIiIiInIH0dHR6qeKiDzloqOj71pGU0tERERERERExGooyBAR
ERERERERq6EgQ0RERERERESshoIMEREREREREbEaCjJERERERERExGooyBARERERERERq6EgQ0RE
RERERESshoIMEREREREREbEaCjJERERERERExGooyBARERERERERq6EgQ0RERERERESshoIMERER
EREREbEaCjJERERERERExGooyBARERERERERq/G3DjKSkpLo168fixYtetJNeaI2b95Mv379OHfu
3JNuiuHAgQP069ePAwcOPOmmiIiIiIiIyD+I/YPuYN++fUydOpX+/ftTr16925YbO3YspUuX5uWX
X37QKnMlNTWVjRs3smPHDi5duoS9vT2+vr506NCBsmXLPrJ6r1y5QkhICLVq1cLLy+uR1fM02bFj
B4mJiTRt2vRJN0VERESeQgkJCezcuZNt27bRo0cP/Pz8spUZMmQI8fHx2bYHBgby/PPPP6aWiohI
bjxwkJFb+fPnJ0+ePI+lrvT0dL777jsOHz5MtWrVqF+/PvHx8YSFhTFx4kRGjBjxyMKMmJgYli9f
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
xYoVY9SoUSxdupQ1a9aQmppK2bJl6datmx69KiLyN2RjyrKQRHh4+CNdF0IejXHjxmFnZ8cHH3zw
pJsiIiIi8khER0ernyoi8pSLjo62GHyQE6tYI0NEREREREREBAUZIiIiIiIiImJNFGSIiIiIiIiI
iNV4aIt9ypM1ZsyYJ90EERERERERkUdOIzJERERERERExGooyBARERERERERq6EgQ0RERERERESs
hoIMEREREREREbEaCjJERERERERExGooyBARERERERERq6EgQ0RERERERESshoIMEREREREREbEa
CjJERERERERExGooyBARERERERERq2Gf08bo6OjH3xIRERERkbtQP1VERHIMMnx9fR9/S0RERERE
7iA8PFz9VBGRp1x4ePhdy2hqiYiIiIiIiIhYDQUZIiIiIiIiImI1FGSIiIiIiIiIiNVQkCEiIiIi
IiIiVkNBhoiIiIiIiIhYDQUZIiIiIiIiImI1FGSIiIiIiIiIiNVQkCEiIiIiIiIiVkNBhoiIiIiI
iIhYDQUZIiIiIiIiImI1FGSIiIiIiIiIiNVQkCEiIiIiIiIiVkNBxhNkMpmIjY0lPT39kdeVlJTE
zZs3H3k9IiIiIiIiIo+SgoyHbNmyZXTv3p3o6Og7llu3bh19+/bl9ddfZ9asWY+sPTExMYwdO5aX
XnqJvn37Eh8f/8jqEhEREbFWa9eupXv37vz1118A/PXXX3Tv3p21a9c+kvoSExPp3r07c+fOfST7
f9SmTJlCv379nnQzROQfyv5BdxAWFsakSZMsthUoUABPT0/atGlDvXr1HrSKp05ERAQzZ86kQoUK
NG/eHC8vr0dW18yZMzlx4gQ9evTA3d2dvHnz5vq9f/75J4cOHaJ9+/Y4Ozs/sjaKiIiIPGrh4eGM
HDmS5557jrfeeuux1n358mW2bNlC/fr18fb2fqx1i4g8jR44yDBr3LgxPj4+AMTFxbF7926mTJlC
t27d6Nat28Oq5qlw5MgRTCYTb7zxBsWLF3+kdR0+fJi6devSqVOne37vkSNHCAoKokWLFgoyRERE
xKpt3boVgJ07d9KvXz8cHR0fW92XL18mKCgIT09PBRkiIg/BQ5taUr16ddq2bUvbtm3p0aMHEydO
xMfHh+XLl5OSkvKwqnkgaWlpT7oJAMb0DldX14eyv9sdV1paGjdv3qRAgQIPpZ4H8Xc59yIiIvLP
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
36wSExNvW4eHhwe+vr6EhYVhMpksppUAFC5cmLi4uDu2s2jRoiQmJnL16lXc3NxyeWZuz8PDA4DI
yEi8vLwsXouMjDRefxhsbW1JTU29r/ea7xLcz/vNn5Wzs/Mdz+391JmSksLFixdxc3OjVq1a1KpV
i7S0NCZPnszs2bNp2rRprr+DIiIi8nTYtm0btra2DB48ONvT0TZu3Mi2bdvo1avXfd808vDwIDIy
Mtt287aH0X970H5vTurXr8/27dspVaoUTk5O1KxZ03gtJCSEhIQEhg8fjru7u7HdfDPvdm7tr93u
ySK56Qvmpk9nXudMRP65Htkksy5dupCYmMiqVasgc66bv78/27dvtxhml5aWxsKFC4mLiwNg6tSp
jB8/3iJZLleuHNzyS9o88mPJkiUWdf75558EBwfnqn0BAQHs27eP/fv3G4sbmdWuXZuoqChjtWmz
9evXGwtgmn/hb9y40eJYDh48mKv6s6pSpQr58uVjzZo1Fun97t27iYqKynEEwf0qWLAgFy5csHgS
inkB0luZ/8O6NUAwj1q49T/tpKQkwsPD71pvlSpVcHJyYsWKFUYiT+aQyKCgoNveTchNnampqbz3
3nvMnTvX2GZnZ4evry8mk4nk5ORcfwdFRETk6bB161YqVqxI/fr1qVOnjsWfFi1acPXqVf7444/7
3n+9evU4e/asRf8vPT2dNWvW4OLiYqydllOfKrceRr83q4CAAK5cucLy5cupUaOGxbQS8zSSW/tq
kZGRd52Cm1N/7dy5cxb9q9z0BXPTpxMReWQPYvbz86NSpUqsXbuWDh06kCdPHvr27cvHH3/Mhx9+
SIsWLXB1dWX79u1ERERQu3ZtXF1d6dixI1999RVjx46lXr16JCcns2HDBtzc3IxVkqtWrUpAQAAb
N27k2rVrVK1alZiYGNauXUvNmjWNx4beSUBAAHPnzsXGxibbM7E7duzIzp07mTp1KkePHsXb25vj
x4+zdetW+vXrR5kyZfDz86NGjRosXryYmJgYihUrxr59+zh58uR9nS8nJydeeukl/vWvf/Hpp59S
t25drl69ypo1ayhVqhSBgYH3td+c1KtXjwMHDvDZZ59RvXp1Lly4QEhISLZy5iF/06dPp3r16rRu
3RpfX1+KFClCUFAQcXFxODo6EhoaysWLF+/6XO98+fLRu3dvZsyYwYcffkjDhg0xmUysX78ee3t7
2rZta/E4MrPc1JknTx5atmzJunXrSE5Oply5cly6dIn169dTtWpVY8RNbr6DIiIiYv1OnTrFuXPn
btuHqlatGs7OzgQHB9/3U8vatm1LSEgIU6ZMoXXr1ri5uREaGkp4eDiDBg3C0dERMkfy2tnZsWLF
Ci5fvkzTMA79AAAZpElEQVRgYGCuF618GP3erMqWLYu7uzuXLl2iV69eFq/VqVOHJUuWMGHCBBo2
bEh8fDzbtm3DZDJx48aN2+6zdu3aLFiwgK+//pomTZpw8+ZNfvvtN4sbVbntC+amTyci/2yPLMgA
6Ny5M+PHj2ft2rV07tyZMmXK8OmnnzJv3jxWrlyJjY0NZcuW5ZNPPqFMmTKQOdRtxIgRLF26lEWL
FuHo6Ii/vz89evTAxcXF2Pc777yDt7c3v/32G/v378fNzY0OHTrQpUuXXLWtaNGilClTBkdHx2xT
Q/Lmzcu4ceOYN28eoaGhbN68GU9PTwYPHswzzzxjlBs8eDCzZs0iNDQUGxsb6tSpQ0BAADNnzryv
8/Xcc8/h7OzMsmXLmD17Nnny5OGZZ56hZ8+edx3Ody+aNWvG9evXWb9+PUFBQZQqVYoRI0bw2Wef
WZSrXbs2jRs3ZufOncTGxtK6dWvs7OyMR4qtXbsWZ2dn4z+r3Kz+3apVK1xcXFi+fDkLFy4kT548
1KhRg969e+cYYpCZwuemzr59++Lu7s5vv/3Grl27KFCgAE2bNqV79+5Gmdx8B0VERMT6bd261eif
5cTBwYEaNWrw+++/3/PUDDMnJyfGjh3L3Llz2bhxIwkJCXh7ezNs2DCLG2UuLi689NJLBAUFsWLF
inueHvGg/d6c1K9fn3Xr1llMKyHzqSnDhw9nwYIFrFy5End3dwYNGsShQ4eMp6RknaZD5voWw4cP
Z/78+SxdupRChQrRt29fli1bZlEuN33B3PTpROSfzcaUZRWi8PBwfH19n1yLRERERERyoH6qiMjT
Lze/6/UgZhERERERERGxGgoyRERERERERMRqKMgQEREREREREauhIENERERERERErIaCDBERERER
ERGxGgoyRERERERERMRqKMgQEREREREREauhIENERERERERErIaCDBERERERERGxGgoyRERERERE
RMRqKMgQEREREREREauhIENERERERERErIaCDBERERERERGxGgoyRERERERERMRq2Oe0MTw8/PG3
RERERETkLtRPFRERG5PJZHrSjRARERERERERyQ1NLRERERERERERq6EgQ0RERERERESshoIMERER
EREREbEaCjJERERERERExGooyBARERERERERq6EgQ0RERERERESshoIMEREREREREbEaCjJERERE
RERExGooyBARERERERERq6EgQ0RERERERESshoIMEREREREREbEaCjJERERERERExGooyBARERER
ERERq6EgQ0RERERERESshoIMEREREREREbEaCjJERERERERExGooyBARERERERERq6EgQ0RERERE
RESshoIMEREREREREbEaCjJERERERERExGooyBARERERERERq/FIg4yly1bQuHlbJkz86rZlDv5x
mMbN2/LK6wMfZVOemJn//g+Nm7dl6r9+etJNeWBD3htF4+Zt2Rqy40k35R8jLS2N5oGdaNy8LXFx
8U+6OSIiIiIiIk+cfU4b5y9czA8/z7rjG0e//y6tWjS7Y5njJ04CUKaM723LnDh5CgC/smVy0947
ivzrLG8MHMLNmwm4FSzIssVzb1s2ISGBeQsWs2jxryQmJfHN5AnUqF4113WNGP0xu37ffccyi+b9
wslT4QCULfPgx/cwdO/1ClFRl5j18zR8S/sAcPJUOP3eGATAyOFDCWzVHIALF6Po2acfefLmJWj+
LzQIqEe1qpWpUrniQ23Tf+Yt5OeZs3m2YQDjx35o8doXk75mzbqN9Hjhed58/RWL17769v9YvmIV
AJ98NIomjRtavP7Sq29yJvIvi21OTo54l/Cic8d2tGvTmnSTiTYdupGQkHDb9hUv5sGC/8x8CEd6
706fiSQlJQWPou64urrc937GfvoFF6Oi+GHq17cts3zFKr7+7l+sXbEYZ2fn+65LRERERETkUcox
yMibNy9NmzQC4PyFixw9dhxXVxdq16xhlKlSudJdd24OKcr6lr5rmQcNMm7cuMHoj8bh7OzMzZsJ
lCtX9rZld+4K44vJ33D9+g1SUlKwsbGhnN+91e/lWdw4R4f/PEpU1CVKlfSmTOaxOjo64FHUnRMn
zEHG7cOcrNLS0rCzs7un9uSWS/78REVdIjEx0di2aPEy4+/JyUnG35f9dyXpJhOd2rchX968dO/a
6Y77Tk9Px9b23gf5HD+R8R0o55f9Mzt67AQA/lk+z/CI06xYtQZnZ2cSExMJjzhtEWQkJiby119n
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
vJgzbwE3btykapXKuBUseE/n6lbmERk7QneRN28e4ykrjg4ZT5jYFbbHeBqI2f/Wx8gcRZLDaBsy
R2L8OH0WITt2Mm/BYm7cuMG8BUEUK+ZhhFdZtWjWlCVL/8v+g3/Qs08/405+eMRp7O3t+eD9Ydja
2HDs+AnWrt+Eq6sLE8Z/bDEKZcWqtUz++nvCwzMWIDVPK/HL8sjbzh3bsfm3rWzespX+r75ssT7D
8ZMnSTeZcHV1ofht1hcxymaGT/ny5WXMJ59Tr04t1m/cQlJSMq1aNMPLy5MCrq4AhO4Mo1KF8vx3
1Rpjes2FC1H4l/OjYYP6rNuwie+m/UDTJo1YvXY9J09FGKNzzOfdHCS2btmMGbPmsGz5KqpUqpir
78nNmwnG5+rhUdR4ZPCtzGVOnz7D0mUr6NAuEHt7eyOc275jF25uBXmpd497OgdpaWl3bZ+IiIiI
iMi9uu2IDJPJZNwRzjoiY8igNyntU4qVq9cx+z8LGPjW6zzbMICbNxP4+rv/48+jxwBo2KA+HdsF
8p95C9kasoO6tWvy1cTPyJs3D2fPniMxMRE3t4IULpSxnsXbb71G184diDx7lu+m/UhycjKD336T
9m1b5+pgjPZmhgrXr9/g4sUobDLX+DgT+RdbgrcRvG07R49l3B2/cuUqwdu2G3elT5w8hclkwrN4
sTuGGADhEWdISUnBycnRYng9OSyOSebFsslkwrd0Kezt7Tl79hwJCQkW5wDAzs6OCeM/pmGD+mwJ
3sr0WbPx8vRk4oRPjGk593uuzMeUbjLRpnVL47Gz5kdlpqenU7GCP9WrVsl2LOaRJVl/NvP0LM4X
48dStowv//7PfJavXE1AQF2+nvS5sf+sypYpzbTvJvPsMwGkpKYStmcfCQkJPNf4WX6Y+pVxUf/d
tB8xmUy88dor2abSmM+JOVQyP861bJYgo2qVSpTxLU1qaiqLMp+uY3w2t1kvJScnMvfft09P8uRx
5qfpvxAVdYkundrz3tC3AXixe1fq1K7J8RMnmPz19zRv2oTuz3fGycmRSV9/T2JiEoMHvUnnju2I
uhTNDz/PIjk5hbf696Nf3z4W59k/c2REqxbNsLWxIXhrCNdiY3P1PWnXpjWexYtx5M+j7D9wKMfj
qV+vNpUrVeDK1WusXL3OmI7l4VHUeGTu66++TL68ee/pHOSmfSIiIiIiIvfKxpSb+RMiYujzyhtE
/nWWH6d9bSwu+jRat2ETn3/5FRUrlGfad5ONRV35B50DERERERH5+9FjA0TuQUJCxloadnZ2lPEt
/aSb80hsCd7Gvv1/sHrNOvLnz8eHI4dZhBj/hHMgIiIiIiJ/XwoyRO7ByfAI0k0mypQqme2xwk+L
lavXcejQESpU8GfQgDfwylzg0+yfcA5EREREROTvS1NLRERERERERMRq3PHxqyIiIiIiIiIifycK
MkRERERERETEaijIEBERERERERGroSBDRERERERERKyGggwRERERERERsRoKMkRERERERETEaijI
EBERERERERGroSBDRERERERERKyGggwRERERERERsRoKMkRERERERETEaijIEBERERERERGroSBD
RERERERERKyGggwRERERERERsRr/D1c8be2OpA3cAAAAAElFTkSuQmCC
--000000000000d6b11a06570bbf6a--
