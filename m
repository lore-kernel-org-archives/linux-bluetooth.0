Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4C2EEE61
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187542; cv=pass; b=XfGAuYbNoftkG/rNn60rc269K6rA/hzQPsGNfQj4oxCH4+vFWNWPrdRzRMHxVybA/5GEqBBlBKv5JKiIkTeoDHIghA9lNItxyPmsKiPeeZqSlJaZDEJ6B9dncdNK3+W664vVIVI7f82V5kEPnsyYrCAIUw8Tk2BFypNfa589F/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187542; c=relaxed/simple;
	bh=qbOJp0VX2LMKEXJeKgcX17GpJdbBMm0qD8gKZStEdpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iE66FuDRzI2upSeVcMxQ9moVq60G3xuqpIzn14QTUjgeGK1O0dPppMOwt4FF4r6jBy88nH9kZ1WiwomtX97/fL03lpHbTyBC4Lus9mu5ugN0sTiYZ+ONlF0bfHAjEw873yVSQBkjblovhIjap04Rz7Ct9fCKOYKQ7SsLawmQbQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6jYDD2Y; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6jYDD2Y"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-855a66e5b5dso33329337b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 07:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788187539; cv=none;
        d=google.com; s=arc-20260327;
        b=mB7rOqdQZ5WfDu3YfL7wltj2aziwI+hF90XAQwrPuL8cnZ//9vZqxGqH7CSSBwDrUw
         vh6m9uhV2+EDDtO1fVo5fLHBIcnrAUQTd0YMxWtG+CQ2CjcOk+ELseupyQNJkbjNGzIX
         lbmQTzxo0nfQc4mo1lBmpf29+om+vFA7q36TsKdZS6T5DBI5PbpcfKUrPsP8eqA7RtLj
         AC+BJdyAxjBrw76MTIpCHww5cqhzC83FEmLbhingxVlYp57uOOY1z951IxphBghibSsA
         A6X7zuPyeV/NaKrFge4GmQr57wWD9gIOcyiGX8R8jeAParMiV8JHgienEIvBIM+GVXpo
         rWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RVLtozrH39neRgLW8PjSo2e5+JswE+noT3tYrRTsTuo=;
        fh=mE/YVa4MsftuBnzRAHbmzV6g26gSnOYC3IjG6mghdb4=;
        b=dprwqWMeDaEccHDvGSIwLh7LAAjw2JfZ4jWAKNZdBmft7q6gzn54a4n6mxp83YKb7k
         gwCeyN8japchdPqy8StXEwm8NOYDlYObbziS4NM6tXGHuT/u0mebgLnWpqj2pULdsXWS
         tj/vVpbFHEvooZUYmVvhYY2OFrGXda+P6oY1hG18xv0RwNdtBjRjrehLLahqCgtolmHi
         GzzqkQqXro3evuZ8vcQjIIOB1ovfNyiksHSmKaLNcsYNWRJyukPLsW+IxnT9V3J+FNB6
         /s6oPfMDCgF8FiVfETSHLj5Mp5RLdbx+OL1VVcl+hnDAkC8B6ENRaxGpxqy+xtEq2V2a
         GsVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788187539; x=1788792339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RVLtozrH39neRgLW8PjSo2e5+JswE+noT3tYrRTsTuo=;
        b=j6jYDD2YJhXULi+JKDck5QKbWnP2rdTdWyLveClNdCwVcn2VCXQUN1HlhQePbGqIxU
         q8kN/N2GERjdBMKi1uv2jFYHbIaih1JJSu8haBK7eJ9GiUx3eXZTRXvAXX3V+clAGH4J
         yTrh8fikjdELOxRVGr41+HIyGt5ZG1fUCzldxebrjuc+utZTlhGTxznqZkq/q7l4Bg8s
         +pbkAPFSqGgB518wf9TPK7Q1MdPSN0mqw1FJ62/p9TRYXNV4Gi4Uy3QAr840ENo8V97S
         NhoYx5YhiK8nHWzE3Vw+HIKpJ0YgWRGqJgDwz02ZzAsefCcC0kAy7f3sTnK0QkW0wAUN
         XiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788187539; x=1788792339;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RVLtozrH39neRgLW8PjSo2e5+JswE+noT3tYrRTsTuo=;
        b=VpyIGoJWymbRPGFEav0f8LKiu/8IIKABEzlwtmtYyPoVaNGabzpgX9dkpS7zm5kWxT
         /0FZM1h8Ava0r2QudqeoHYfSscragq4LxLoCxvq7UeIYYiFVyWBIGuWC9SigDpB1vxbc
         b2/nVbqLXNaGPCOXdowcMP3WyPs/+HK4QYarebzLpX4YQi7tZiL4bo4950MZiAKo99RH
         TAYAJl9uiXUELKHry6WvEpE8RrshyT9XK47Fje3l2xwGaP1RWzT/yhg5Km173I4xbehC
         sfA3yjkrbAWJvWxOn2rRvs9NO8DQxFrh00xzz58vRit5rONMLmJxUkSw/c9TFx64TeWq
         HCzw==
X-Forwarded-Encrypted: i=1; AKwUvBzcTDVNCKoXn3W7HX0h7+eU6pmoShfBnQjKy7ASJG7w4M07l+TnCQ810V893Ls4iddjWJcA2MCGxKrFbsO71P4=@vger.kernel.org
X-Gm-Message-State: AFuF++l1P9En01TK20w511Vr+HeRN1mhkjN8YKy0jV0wuIHfNSJVA9SV
	x4AXPKuvmWE9EdLel1/Jrwtux4P7b9Puochg45jN341eDUHSxp7WHsqgLSuLv0gwD6xmOF7cboO
	Fzr2zOpvO+1v83R+/y2j3eZX0yEVTOMubLSmMSj8+u+wD
X-Gm-Gg: AYBFou0t+4J/4/ys8ZN7Pv//cvHUKLMFvAy4HMsW2b69St0iuBa3CkYaS/QtNRWRyLo
	iiPSIUC/fxYOh03Ae0pta/gzsKP/dGvVzWrzMg1PIkVnFiYsGM2+ILBZeBzv2WITlKcq4BNJUJy
	3HwD22gsvpyrdgk+Qbt1jApGrhD/HKdASgEkM0TwCHxSw5QTuW2BCwQBBIanlDaLG2Eif1QmVwT
	8z4P5QipLY2jLS53Fhnc3HYNcLYRjMUL2RhaCLoJupdgafCZ+M8523X+RhlCXPdb/2cj5iJ3ruX
	t7l663ao6BrHCzJjFlTg+VIsdxcr5+kVgDlvtlyPTFSRqDi1iQ7x220w6j5e7ZNtSIKBRkEHjPs
	+kYJXdng+3F/TXEpD/40u00dgs4ip
X-Received: by 2002:a05:690c:a7c2:b0:861:a2ae:8c6b with SMTP id
 00721157ae682-8686ed6a3fcmr6820867b3.2.1788187538628; Mon, 31 Aug 2026
 07:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-btusb_qcc2072-v2-0-5c0e0c9dd98b@oss.qualcomm.com> <20260830-btusb_qcc2072-v2-2-5c0e0c9dd98b@oss.qualcomm.com>
In-Reply-To: <20260830-btusb_qcc2072-v2-2-5c0e0c9dd98b@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 31 Aug 2026 10:45:26 -0400
X-Gm-Features: AcwNN1V7-zSmKY1NVmiP59HwK3AG6VH9IaDhN1hfEwr4SM2KUCQkAIlSJHxsQps
Message-ID: <CABBYNZLOBVHNvn1=56C-FHc64i5s7SAx3akL5Q3w4oUuekonUw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Bluetooth: Add generic support for vendor HCI packets
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Mon, Aug 31, 2026 at 1:04=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> The virtual HCI_VENDOR_PKT (0xff) has been defined but never used by
> the BT core. Now, there is a requirement to implement it, as follows:
>
> For Qualcomm multi-subsystem BT chips, the transport wire carries both
> BT-HCI and PERI-HCI frames, where PERI is a subsystem in the chip, take
> the upcoming QCC2072 as an example:
>
>     Packet type                 BT-HCI indicator   PERI-HCI indicator
>     -----------------------------------------------------------------
>     CMD (Host -> Controller)    0x01               0x31
>     ACL Data (bidirectional)    0x02               0x32
>     EVENT (Controller -> Host)  0x04               0x34
>
> Implement HCI_VENDOR_PKT to generically support vendor HCI packets:
>
> - Log them in btmon as they appear on the wire.
> - Allow userspace to send/receive them over HCI_CHANNEL_USER, gate RX
>   with the new socket option BT_RECV_VENDOR_PKT, off by default to
>   avoid regressions for existing applications.
> - Add hdev->recv_vendor_pkt() to handle them in hci_rx_work().
> - Add hci_send_vendor_frame() to send an HCI_VENDOR_PKT frame.

I don't find this one very useful, as btmon already supports handling
vendor events:

{ 0xff, "Vendor", vendor_evt, 0, false },

This will complicate things because some drivers might label packets
as vendor while others might inline them as an HCI vendor event. From
the spec's point of view there is no generic HCI vendor packet, so the
PERI approach really stands out as a non-compliant solution because it
uses reserved opcodes.

> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
> Previous version:
> https://lore.kernel.org/all/20260722-support_vendor_hci-v2-2-132b506460a4=
@oss.qualcomm.com
>
> Changes since previous version:
> - Change BT_RECV_VENDOR_PKT type from int to u32
> - Rename macro and enum from *_RCV_* to *_RECV_*
> - Improve the commit title and message
> ---
>  include/net/bluetooth/bluetooth.h |  6 +++++
>  include/net/bluetooth/hci.h       |  1 +
>  include/net/bluetooth/hci_core.h  |  5 ++++
>  include/net/bluetooth/hci_mon.h   |  2 ++
>  net/bluetooth/hci_core.c          | 44 ++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_sock.c          | 53 +++++++++++++++++++++++++++++++++=
++----
>  6 files changed, 106 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index b624da5026f5..f9b380060976 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -251,16 +251,22 @@ struct bt_codecs {
>  #define BT_ISO_BASE            20
>
>  /* Socket option value 21 reserved */
>
>  #define BT_PKT_SEQNUM          22
>
>  #define BT_SCM_PKT_SEQNUM      0x05
>
> +/*
> + * Control receiving HCI_VENDOR_PKT over HCI_CHANNEL_USER, off
> + * by default to avoid regressions for existing applications.
> + */
> +#define BT_RECV_VENDOR_PKT     23
> +
>  __printf(1, 2)
>  void bt_info(const char *fmt, ...);
>  __printf(1, 2)
>  void bt_warn(const char *fmt, ...);
>  __printf(1, 2)
>  void bt_err(const char *fmt, ...);
>  #if IS_ENABLED(CONFIG_BT_FEATURE_DEBUG)
>  void bt_dbg_set(bool enable);
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 1641d879dbda..0145f629cdd5 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -393,16 +393,17 @@ enum {
>         HCI_RAW,
>
>         HCI_RESET,
>  };
>
>  /* HCI socket flags */
>  enum {
>         HCI_SOCK_TRUSTED,
> +       HCI_SOCK_RECV_VENDOR_PKT,
>         HCI_MGMT_INDEX_EVENTS,
>         HCI_MGMT_UNCONF_INDEX_EVENTS,
>         HCI_MGMT_EXT_INDEX_EVENTS,
>         HCI_MGMT_EXT_INFO_EVENTS,
>         HCI_MGMT_OPTION_EVENTS,
>         HCI_MGMT_SETTING_EVENTS,
>         HCI_MGMT_DEV_CLASS_EVENTS,
>         HCI_MGMT_LOCAL_NAME_EVENTS,
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index c12cd6873f65..b26004a05368 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -23,16 +23,17 @@
>  #ifndef __HCI_CORE_H
>  #define __HCI_CORE_H
>
>  #include <linux/idr.h>
>  #include <linux/leds.h>
>  #include <linux/rculist.h>
>  #include <linux/spinlock.h>
>  #include <linux/srcu.h>
> +#include <linux/uio.h>
>
>  #include <net/bluetooth/hci.h>
>  #include <net/bluetooth/hci_drv.h>
>  #include <net/bluetooth/hci_sync.h>
>  #include <net/bluetooth/hci_sock.h>
>  #include <net/bluetooth/coredump.h>
>
>  /* HCI priority */
> @@ -641,16 +642,18 @@ struct hci_dev {
>  #endif
>
>         int (*open)(struct hci_dev *hdev);
>         int (*close)(struct hci_dev *hdev);
>         int (*flush)(struct hci_dev *hdev);
>         int (*setup)(struct hci_dev *hdev);
>         int (*shutdown)(struct hci_dev *hdev);
>         int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
> +       /* Receive HCI_VENDOR_PKT */
> +       void (*recv_vendor_pkt)(struct hci_dev *hdev, struct sk_buff *skb=
);
>         /* Handle HCI_EV_VENDOR; return true if handled, false otherwise =
*/
>         bool (*handle_ev_vendor)(struct hci_dev *hdev, struct sk_buff *sk=
b);
>         void (*notify)(struct hci_dev *hdev, unsigned int evt);
>         void (*hw_error)(struct hci_dev *hdev, u8 code);
>         int (*post_init)(struct hci_dev *hdev);
>         int (*set_diag)(struct hci_dev *hdev, bool enable);
>         int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
>         void (*reset)(struct hci_dev *hdev);
> @@ -2395,16 +2398,18 @@ static inline int hci_check_conn_params(u16 min, =
u16 max, u16 latency,
>         }
>
>         return 0;
>  }
>
>  int hci_register_cb(struct hci_cb *hcb);
>  int hci_unregister_cb(struct hci_cb *hcb);
>
> +int hci_send_vendor_frame(struct hci_dev *hdev, struct iov_iter *iter);
> +
>  int __hci_cmd_send(struct hci_dev *hdev, u16 opcode, u32 plen,
>                    const void *param);
>
>  int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
>                  const void *param);
>  void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flag=
s);
>  void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
>  void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb);
> diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_=
mon.h
> index 4b2a0af4ed58..7710688c0d30 100644
> --- a/include/net/bluetooth/hci_mon.h
> +++ b/include/net/bluetooth/hci_mon.h
> @@ -45,16 +45,18 @@ struct hci_mon_hdr {
>  #define HCI_MON_CTRL_OPEN      14
>  #define HCI_MON_CTRL_CLOSE     15
>  #define HCI_MON_CTRL_COMMAND   16
>  #define HCI_MON_CTRL_EVENT     17
>  #define HCI_MON_ISO_TX_PKT     18
>  #define HCI_MON_ISO_RX_PKT     19
>  #define HCI_MON_DRV_TX_PKT     20
>  #define HCI_MON_DRV_RX_PKT     21
> +#define HCI_MON_VENDOR_TX_PKT  22
> +#define HCI_MON_VENDOR_RX_PKT  23
>
>  struct hci_mon_new_index {
>         __u8            type;
>         __u8            bus;
>         bdaddr_t        bdaddr;
>         char            name[8] __nonstring;
>  } __packed;
>  #define HCI_MON_NEW_INDEX_SIZE 16
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 88df159d3393..2663654cdf60 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2911,16 +2911,18 @@ int hci_recv_frame(struct hci_dev *hdev, struct s=
k_buff *skb)
>                             type =3D=3D PA_LINK)
>                                 hci_skb_pkt_type(skb) =3D HCI_ISODATA_PKT=
;
>                 }
>                 break;
>         case HCI_SCODATA_PKT:
>                 break;
>         case HCI_ISODATA_PKT:
>                 break;
> +       case HCI_VENDOR_PKT:
> +               break;
>         case HCI_DRV_PKT:
>                 break;
>         default:
>                 kfree_skb(skb);
>                 return -EINVAL;
>         }
>
>         /* Incoming skb */
> @@ -3047,16 +3049,50 @@ static int hci_send_frame(struct hci_dev *hdev, s=
truct sk_buff *skb)
>
>  static int hci_send_conn_frame(struct hci_dev *hdev, struct hci_conn *co=
nn,
>                                struct sk_buff *skb)
>  {
>         hci_conn_tx_queue(conn, skb);
>         return hci_send_frame(hdev, skb);
>  }
>
> +/**
> + * hci_send_vendor_frame - Send an HCI_VENDOR_PKT frame to the HCI drive=
r
> + * @hdev: The HCI device
> + * @iter: iov_iter carrying the frame
> + *
> + * Return: 0 on success, or a negative errno on failure.
> + */
> +int hci_send_vendor_frame(struct hci_dev *hdev, struct iov_iter *iter)
> +{
> +       struct sk_buff *skb;
> +       size_t len;
> +
> +       if (WARN_ON(!iov_iter_is_kvec(iter)))
> +               return -EINVAL;
> +
> +       len =3D iov_iter_count(iter);
> +       if (!len)
> +               return -EINVAL;
> +
> +       skb =3D bt_skb_alloc(len, GFP_KERNEL);
> +       if (!skb)
> +               return -ENOMEM;
> +
> +       if (!copy_from_iter_full(skb_put(skb, len), len, iter)) {
> +               kfree_skb(skb);
> +               return -EFAULT;
> +       }
> +
> +       hci_skb_pkt_type(skb) =3D HCI_VENDOR_PKT;
> +
> +       return hci_send_frame(hdev, skb);
> +}
> +EXPORT_SYMBOL(hci_send_vendor_frame);
> +
>  /* Send HCI command */
>  int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
>                  const void *param)
>  {
>         struct sk_buff *skb;
>
>         BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
>
> @@ -4051,16 +4087,24 @@ static void hci_rx_work(struct work_struct *work)
>                         hci_scodata_packet(hdev, skb);
>                         break;
>
>                 case HCI_ISODATA_PKT:
>                         BT_DBG("%s ISO data packet", hdev->name);
>                         hci_isodata_packet(hdev, skb);
>                         break;
>
> +               case HCI_VENDOR_PKT:
> +                       BT_DBG("%s Vendor packet", hdev->name);
> +                       if (hdev->recv_vendor_pkt)
> +                               hdev->recv_vendor_pkt(hdev, skb);
> +                       else
> +                               kfree_skb(skb);
> +                       break;
> +
>                 default:
>                         kfree_skb(skb);
>                         break;
>                 }
>         }
>  }
>
>  static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 070ca388f9ac..4b328fa8dff4 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -224,22 +224,26 @@ void hci_send_to_sock(struct hci_dev *hdev, struct =
sk_buff *skb)
>                             hci_skb_pkt_type(skb) !=3D HCI_SCODATA_PKT &&
>                             hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT)
>                                 continue;
>                         if (is_filtered_packet(sk, skb))
>                                 continue;
>                 } else if (hci_pi(sk)->channel =3D=3D HCI_CHANNEL_USER) {
>                         if (!bt_cb(skb)->incoming)
>                                 continue;
> -                       if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT &&
> -                           hci_skb_pkt_type(skb) !=3D HCI_ACLDATA_PKT &&
> -                           hci_skb_pkt_type(skb) !=3D HCI_SCODATA_PKT &&
> -                           hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT &&
> -                           hci_skb_pkt_type(skb) !=3D HCI_DRV_PKT)
> +                       if (hci_skb_pkt_type(skb) =3D=3D HCI_VENDOR_PKT) =
{
> +                               if (!hci_sock_test_flag(sk, HCI_SOCK_RECV=
_VENDOR_PKT))
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
>                 }
>
>                 if (!skb_copy) {
>                         /* Create a private copy with headroom */
>                         skb_copy =3D __pskb_copy_fclone(skb, 1, GFP_ATOMI=
C, true);
> @@ -385,16 +389,22 @@ void hci_send_to_monitor(struct hci_dev *hdev, stru=
ct sk_buff *skb)
>                         opcode =3D cpu_to_le16(HCI_MON_SCO_TX_PKT);
>                 break;
>         case HCI_ISODATA_PKT:
>                 if (bt_cb(skb)->incoming)
>                         opcode =3D cpu_to_le16(HCI_MON_ISO_RX_PKT);
>                 else
>                         opcode =3D cpu_to_le16(HCI_MON_ISO_TX_PKT);
>                 break;
> +       case HCI_VENDOR_PKT:
> +               if (bt_cb(skb)->incoming)
> +                       opcode =3D cpu_to_le16(HCI_MON_VENDOR_RX_PKT);
> +               else
> +                       opcode =3D cpu_to_le16(HCI_MON_VENDOR_TX_PKT);
> +               break;
>         case HCI_DRV_PKT:
>                 if (bt_cb(skb)->incoming)
>                         opcode =3D cpu_to_le16(HCI_MON_DRV_RX_PKT);
>                 else
>                         opcode =3D cpu_to_le16(HCI_MON_DRV_TX_PKT);
>                 break;
>         case HCI_DIAG_PKT:
>                 opcode =3D cpu_to_le16(HCI_MON_VENDOR_DIAG);
> @@ -1863,16 +1873,17 @@ static int hci_sock_sendmsg(struct socket *sock, =
struct msghdr *msg,
>                  * since that gets enforced when binding the socket.
>                  *
>                  * However check that the packet type is valid.
>                  */
>                 if (hci_skb_pkt_type(skb) !=3D HCI_COMMAND_PKT &&
>                     hci_skb_pkt_type(skb) !=3D HCI_ACLDATA_PKT &&
>                     hci_skb_pkt_type(skb) !=3D HCI_SCODATA_PKT &&
>                     hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT &&
> +                   hci_skb_pkt_type(skb) !=3D HCI_VENDOR_PKT &&
>                     hci_skb_pkt_type(skb) !=3D HCI_DRV_PKT) {
>                         err =3D -EINVAL;
>                         goto drop;
>                 }
>
>                 skb_queue_tail(&hdev->raw_q, skb);
>                 queue_work(hdev->workqueue, &hdev->tx_work);
>         } else if (hci_skb_pkt_type(skb) =3D=3D HCI_COMMAND_PKT) {
> @@ -2012,16 +2023,17 @@ static int hci_sock_setsockopt_old(struct socket =
*sock, int level, int optname,
>         return err;
>  }
>
>  static int hci_sock_setsockopt(struct socket *sock, int level, int optna=
me,
>                                sockptr_t optval, unsigned int optlen)
>  {
>         struct sock *sk =3D sock->sk;
>         int err =3D 0;
> +       u32 opt_u32;
>         u16 opt;
>
>         BT_DBG("sk %p, opt %d", sk, optname);
>
>         if (level =3D=3D SOL_HCI)
>                 return hci_sock_setsockopt_old(sock, level, optname, optv=
al,
>                                                optlen);
>
> @@ -2045,16 +2057,33 @@ static int hci_sock_setsockopt(struct socket *soc=
k, int level, int optname,
>
>                 err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
>                 if (err)
>                         break;
>
>                 hci_pi(sk)->mtu =3D opt;
>                 break;
>
> +       case BT_RECV_VENDOR_PKT:
> +               if (hci_pi(sk)->channel !=3D HCI_CHANNEL_USER) {
> +                       err =3D -ENOPROTOOPT;
> +                       break;
> +               }
> +
> +               err =3D copy_safe_from_sockptr(&opt_u32, sizeof(opt_u32),
> +                                            optval, optlen);
> +               if (err)
> +                       break;
> +
> +               if (opt_u32)
> +                       hci_sock_set_flag(sk, HCI_SOCK_RECV_VENDOR_PKT);
> +               else
> +                       hci_sock_clear_flag(sk, HCI_SOCK_RECV_VENDOR_PKT)=
;
> +               break;
> +
>         default:
>                 err =3D -ENOPROTOOPT;
>                 break;
>         }
>
>  done:
>         release_sock(sk);
>         return err;
> @@ -2127,16 +2156,17 @@ static int hci_sock_getsockopt_old(struct socket =
*sock, int level, int optname,
>         return err;
>  }
>
>  static int hci_sock_getsockopt(struct socket *sock, int level, int optna=
me,
>                                sockopt_t *sopt)
>  {
>         struct sock *sk =3D sock->sk;
>         int err =3D 0;
> +       u32 opt_u32;
>         u16 mtu;
>
>         BT_DBG("sk %p, opt %d", sk, optname);
>
>         if (level =3D=3D SOL_HCI)
>                 return hci_sock_getsockopt_old(sock, level, optname, sopt=
);
>
>         if (level !=3D SOL_BLUETOOTH)
> @@ -2148,16 +2178,29 @@ static int hci_sock_getsockopt(struct socket *soc=
k, int level, int optname,
>         case BT_SNDMTU:
>         case BT_RCVMTU:
>                 mtu =3D hci_pi(sk)->mtu;
>                 if (copy_to_iter(&mtu, sizeof(mtu), &sopt->iter_out) !=3D
>                     sizeof(mtu))
>                         err =3D -EFAULT;
>                 break;
>
> +       case BT_RECV_VENDOR_PKT:
> +               if (hci_pi(sk)->channel !=3D HCI_CHANNEL_USER) {
> +                       err =3D -ENOPROTOOPT;
> +                       break;
> +               }
> +
> +               opt_u32 =3D hci_sock_test_flag(sk, HCI_SOCK_RECV_VENDOR_P=
KT) ?
> +                         1 : 0;
> +               if (copy_to_iter(&opt_u32, sizeof(opt_u32),
> +                                &sopt->iter_out) !=3D sizeof(opt_u32))
> +                       err =3D -EFAULT;
> +               break;
> +
>         default:
>                 err =3D -ENOPROTOOPT;
>                 break;
>         }
>
>         release_sock(sk);
>         return err;
>  }
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
