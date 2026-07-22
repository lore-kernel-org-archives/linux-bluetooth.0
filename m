Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A26146E004
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738797; cv=pass; b=b3zkTav1imrprL9xjjJWiQppD1SbgnQ4OCMbAsMrpxonxYwQWC2DQ6tZ6vAWP3bASaCehZoiitTUtSCe2FZCS/VUYKTAK0GAGQqw+IO8nYajtEjThQX6OazPF02zUl3NsVOAADEnfXWxx/5DuHO2jEGlYEOzyQEUTfVsIt7O8F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738797; c=relaxed/simple;
	bh=jQzAVrWYLtnz943Xs75AqjdtBelXKD71lTCp+VFsnqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPwl4klNMAeC/6yAELXwvDt+838kC7CrDOIqVCccgPFte3GcvRhit3xjav906d78qLGyNHHd320454NYrrnzuryzNVO2ELBHht47cBuCrRIxXgwjpYA2LU+wXOz4ZnvQQ07E0zEJqVg2YoIhSXJQhweIWTy1bXI5LBXMyWMoQug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/Idcr4i; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/Idcr4i"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8114a4542b2so77693557b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 09:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784738782; cv=none;
        d=google.com; s=arc-20260327;
        b=FSJhBh7iSqs0gOg5+fuYsYkbuoNcjA2GCRorG8PnkLxdW8gbeCT6rZc7lb/iZGcHFI
         hSgEdCdhKh4Yoxqfzw2hpMNupN0ibDWG7zldDpIgjBh6oGgwLIMpAMqr3FdUCaIirWbX
         xAXX/8rwcnp09iNQBjTVoGdJGVclv4LcsY5Cvc6YhG0e9l8+zmuSVfUgYvc6e7wpDNIN
         w7cjnYFmkKyJKQW/nnDZSMeYgUvW5kmi/sZsmVyS6x4aAfZOORsCpgUlVcPo+tLgM3qr
         5UXuWv/dEOEyxz5nAR+MXg3L0OMFV0smk44cQrNNYJdjA+EhV+m2USkXWXF7cMH5bty/
         F8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1273gcvQiYUp4kj3l6DBKJ9KyBgHVf+Jg2f6eRvOTUs=;
        fh=pk4ImQ/EceVPvOUxGQRn9fh+zlJQ2/EKUNKnnfMQG4I=;
        b=MjAuR05mtIKKYVATqFF/K+lP9nIHU5agYnnA68b2h2cw63ikTTcnqQOFosXoV2huuT
         7praOKtr3+kZo09/Ontns/QX7mN9dognm9Ziv/IuMgoXnvWmhixUM1aneeYD++56ymw/
         ZZZ9GTY+qweMYMywrveo4cr8mvc/v6EooQtjI3AwhhpnRoRtAL4VHKGKcKyfk1o2AcUT
         /q/PEPifki9dyrnbszafMf0luB2wl4jcT7Vc6JCfJ4htdgo4N23iqhXHdM9xHa2Mh5VE
         A5kL19Z8LMfXXpNrPPZ+g8mMv2p366hRwbR8f6NZUU7CACmYFJ867NdFbiYM5P/+cU5I
         uTyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784738782; x=1785343582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1273gcvQiYUp4kj3l6DBKJ9KyBgHVf+Jg2f6eRvOTUs=;
        b=P/Idcr4icDtbA+lpMa87PJyFi1YJLqajkm45Sz1zYKzArpWz6wjdiqlFxRvumWFhHa
         oxFKxMAub0MbjsifNzJhHQP2+IkQa6diN3yxowHDfPO4FLlIA/pTleyiiFkH06zYJsRR
         VfPDkJnR+iw2FjKcEUWgW3yICsnxA3cUrYvPncA73O3YmHpOY84vhhSwx7lMp6ShoQwN
         ZwHCGONjDqhdY1ckSPDy6rQLqMiy8tcbhowP9+jQVRgctHmP6kRxJU4MlIUIyu8EjNX5
         2BQKvBGCQSjkbMUroQxEHi/Pf+vwfBhSgu7NPAp99XAHLJ/GRPOFZp1LwyGLpkaHAHiZ
         EUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784738782; x=1785343582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1273gcvQiYUp4kj3l6DBKJ9KyBgHVf+Jg2f6eRvOTUs=;
        b=BW0IaeSdhtVFczT9X5b/97912q5F8C22PmMvAZWR6DJA1Xxb63WsbjF+9XWjMxhAZm
         nFD602E5csMssoQynwBjWzesUrlZHWVZVn2p/qIojR8VQ+qoIsenCUKrAC9esnWPJuhE
         5GoLXBoAH3V21o0ka8sIjb6fhQBYAU7j/O1ofAp4BoWNTLafvlOHWJ4vVt6yILBuumX+
         58arKQc9nOFheZNouax4VB5+RomElgzqNAb26pIstQbxMiWW+J7XTUBcSueQHsualDP8
         Q5PHd3M9g33JSMHiR6SZqIqJa7Ry109vSvV6vh9UrrtTWTA3YDoN+4dTABvl4gEEY1TR
         uaVw==
X-Forwarded-Encrypted: i=1; AHgh+RqoFvo3/zupS7sN0HggoFCZZ9HGFI0gCANELNf3Bj10DCTLA+U4mAVGxjc/grRq38xD83RFBifHR8RVR8hI5Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnTM26WdorC3xVOw2oSKIe9CFK24T3BG59pwrfFLD/1qkMhGoG
	HnJRupSCMXePHsA/hZ711V3HhPWxpDB4f0S9bZgOu0AFb402jFCiI3joKPTJ9ajQ98sSKtK3FzK
	Ju9nMrd84v9VjTuFs4pjxdGYhAwe2NPtYo4Hs8VQ=
X-Gm-Gg: AR+sD13nynAggTdS8PT3kZJB+UvTGevjoejdSQbc1qcpB+IXTPmMVVoOMxCbNHUGJtI
	j55ZXc31VWNRa4zrzRxZEP4BALuGMIORCYmEK8mRUjIAi3qvJaJ4EGReDsrvHvOzXwVBPBtpNQP
	p2q8Iiq5Y7qO/tBFbyqAmkUG49jQCRJI7btBwQIUP2BgUqJjx7Zf5BPkNKOKNhNiYgbtR0bP7L8
	1MNJk3fXf/cTI7YXWdAETC3Xn4WL530GY1qhW/elSmyQVHvBmY1XSMUBRtjRfTdGnTsj8jnEFrJ
	ZpbmrzonsetkB3C916RNnJDl7zBS1T+cfWSKislUk/b9u3HXwdJuexE+
X-Received: by 2002:a05:690c:7248:b0:81c:c77b:3546 with SMTP id
 00721157ae682-81ef276b455mr70757027b3.21.1784738782037; Wed, 22 Jul 2026
 09:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722-support_vendor_hci-v2-0-132b506460a4@oss.qualcomm.com> <20260722-support_vendor_hci-v2-3-132b506460a4@oss.qualcomm.com>
In-Reply-To: <20260722-support_vendor_hci-v2-3-132b506460a4@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Jul 2026 12:46:10 -0400
X-Gm-Features: AUfX_mxFm-Z1Vm2KdPq50qIn5uzHA9qHKM8px-JoDUm-GHng7JiFudcFpvErY_M
Message-ID: <CABBYNZL7ApV6wzTOLGu4gRxBU_89x+D-JNd27tg0X-sOmXqEog@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/3] Bluetooth: Add hdev->recv_bt_vendor() to
 handle BT vendor frames
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Wed, Jul 22, 2026 at 12:24=E2=80=AFPM Zijun Hu <zijun.hu@oss.qualcomm.co=
m> wrote:
>
> For unsolicited VSE and ACL frames with vendor reserved handles:
> Many transport drivers pre-process them in the RX-path because the BT cor=
e
> cannot recognize them, and cause:
>
> - Impact performance since skb_clone() in IRQ-disabled context
> - Difficult to debug as frames consumed without btmon logging
>
> Fix by adding the hook to process them within stack's process
> context, when they have been logged by btmon.
>
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  include/net/bluetooth/hci_core.h |  3 +++
>  net/bluetooth/hci_core.c         | 33 +++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_event.c        |  5 +++++
>  3 files changed, 41 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 428261591288..12f3720f6cc8 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -646,6 +646,8 @@ struct hci_dev {
>         int (*setup)(struct hci_dev *hdev);
>         int (*shutdown)(struct hci_dev *hdev);
>         int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
> +       /* Return true if @skb was consumed, false otherwise */
> +       bool (*recv_bt_vendor)(struct hci_dev *hdev, struct sk_buff *skb)=
;

This should be probably called recv_vendor_ev or something like that.

>         void (*recv_vendor_pkt)(struct hci_dev *hdev, struct sk_buff *skb=
);
>         void (*notify)(struct hci_dev *hdev, unsigned int evt);
>         void (*hw_error)(struct hci_dev *hdev, u8 code);
> @@ -2329,6 +2331,7 @@ static inline int hci_check_conn_params(u16 min, u1=
6 max, u16 latency,
>  int hci_register_cb(struct hci_cb *hcb);
>  int hci_unregister_cb(struct hci_cb *hcb);
>
> +bool hci_recv_bt_vendor(struct hci_dev *hdev, struct sk_buff *skb);
>  int hci_send_vendor_frame(struct hci_dev *hdev, struct iov_iter *iter);
>
>  int __hci_cmd_send(struct hci_dev *hdev, u16 opcode, u32 plen,
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 90807562e8ed..21ef748e3528 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3830,6 +3830,12 @@ static void hci_acldata_packet(struct hci_dev *hde=
v, struct sk_buff *skb)
>         __u16 handle, flags;
>         int err;
>
> +       /* Header is valid when ACL frame arrives here */
> +       if (hci_recv_bt_vendor(hdev, skb)) {
> +               hdev->stat.acl_rx++;
> +               return;
> +       }
> +
>         hdr =3D skb_pull_data(skb, sizeof(*hdr));
>         if (!hdr) {
>                 bt_dev_err(hdev, "ACL packet too small");
> @@ -3918,6 +3924,33 @@ static void hci_isodata_packet(struct hci_dev *hde=
v, struct sk_buff *skb)
>                            handle, err);
>  }
>
> +bool hci_recv_bt_vendor(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       struct hci_event_hdr *evt_hdr;
> +       u8 evt, pkt_type;
> +
> +       if (!hdev->recv_bt_vendor)
> +               return false;
> +
> +       pkt_type =3D hci_skb_pkt_type(skb);
> +
> +       /* Save the event code before calling into the driver, since @skb
> +        * may be freed once consumed.
> +        */
> +       if (pkt_type =3D=3D HCI_EVENT_PKT) {
> +               evt_hdr =3D hci_event_hdr(skb);
> +               evt =3D evt_hdr->evt;
> +       }
> +
> +       if (!hdev->recv_bt_vendor(hdev, skb))
> +               return false;
> +
> +       if (pkt_type =3D=3D HCI_EVENT_PKT && evt !=3D HCI_EV_VENDOR)
> +               bt_dev_warn(hdev, "consumed unexpected BT event 0x%2.2x",=
 evt);
> +
> +       return true;
> +}
> +
>  static bool hci_req_is_complete(struct hci_dev *hdev)
>  {
>         struct sk_buff *skb;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index ea858391c789..94c02b66bdfa 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -7801,6 +7801,11 @@ void hci_event_packet(struct hci_dev *hdev, struct=
 sk_buff *skb)
>                 goto done;
>         }
>
> +       if (hci_recv_bt_vendor(hdev, skb)) {
> +               hdev->stat.evt_rx++;
> +               return;
> +       }

This seems too early actually, I would have expected it to run after
hci_event_func or within it if ev->func is NULL, that said we
currently assume HCI_EV_VENDOR=3Dmsft_vendor_evt which is probably not
valid, or maybe it is which then screw the whole idea that 0xff is
only used with 1 vendor specific domain, now if we try to squeesh both
a vendor event and a msft event handler their opcodes shall not
collide otherwise the whole thing doesn't work.

Anyway, I had the impression you would be using a vendor packet not a
vendor event, or you use both?

>         hci_dev_lock(hdev);
>         kfree_skb(hdev->recv_event);
>         hdev->recv_event =3D skb_clone(skb, GFP_KERNEL);
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
