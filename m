Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FDB1DF261
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060091; cv=pass; b=DcmCn+R4VKc32fW8PF6MQfiMtw9C3zZJDGeEsr3bmx1WFjlhogK/vOkrd2JQsP4kggmB4Q4LB2ZnKUHj0l0YGoJwaGeHWFhrR+ZckZsbHjOygRCAmk2HoY2mYArb2xLidCho1vq7SXcb1f0Mjf0rzYORclY7E8EffF02QVwAwhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060091; c=relaxed/simple;
	bh=po4PnaiCgaMch0lnCJSxVMqfwUQhA5ZMgR/J+bwZEKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6mLNAI/6MQzVrHpJqdASW7ySTUtZNuyiuteQ5NKjeUNMQjYYFywRtvphoDwAYgbXPjt70LuAbe6pJyJyjgwXNTT4v0J/C5LCXqMy2o3MBJzq1an9SR50/wXoab98zdL5TzbyBMRbNA9wo4rhftgOmH5vvgToYe3OIZmnRMZdIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByBr3kqN; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByBr3kqN"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651b4d09141so11164602d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 12:48:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777060089; cv=none;
        d=google.com; s=arc-20240605;
        b=GtluVaNCNIem23FQH2iPDGZCEo7XaPd6wdnPlcaNWtTIrAYZCDIJL8UEPuHVEuu8FA
         v0BFBbVsiTEaKXCgDDIIHX2dpvD5FH9PN/4N2Ita5V6IovNcNjYjnA5hLeLCqE35zCb3
         3af6hznGqRL8sEYAagcVtKJOfP/TuWkrbocIrgic+uBNj3pzsdkJ8nkcxQv488gcxG5c
         8a5rH4uqk4yBsrXexZB6sGfPmLIxV8hx2t+nDfBpsL2YRqfDuuUkNcIAHgxo5Ab88I5f
         6VeQ9kkuPQYpBjnuICUa1o29upBJjTGQtN3egMQi0WkROPqq2LpkOmSO4hBFRCbWpXbC
         XSAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xw0ah93fqgdCasT1Yd1P/eO3pcya9SWmHCEVOlySNwM=;
        fh=ObwbkWD4vsvZXVqBRH2QQ75Yi43uhqioBqjSQ+/rmAA=;
        b=XGrhPxDDLLtgIIaNke0ktChAOySWFioBKZm7nnvzRvo9WBez4WO19BoVuQnWp5x6L+
         wiPXp22ao8Dozv43C0eobe2/58lUM86t1qDKXK4+iCLSuLN42BlOV2L44uT5GcTddwIu
         +R9CFLyJi3FOCBnZPvkF6MajQA+ZS8MQRQXMVn677Ws1O0NIDnOj/MzuhqnmGoPIkFWx
         QtpuffG0jxpNPMxDxk76jOxYLZZvDY3GJ7GkC0RsHpCJEzbxMlt/6PGuhFoj+q1O/Uk9
         1YVxINrqICOEqMuDg18gRDn+HRAuHUX51NL+QA2dM6/H/JZCNwolcIVInOa9rpxVvpnl
         +lVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777060089; x=1777664889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw0ah93fqgdCasT1Yd1P/eO3pcya9SWmHCEVOlySNwM=;
        b=ByBr3kqNTU/oxNNRZEKKeaPC9bsTed37hcsJYz2PKUeGIOryGWqp6StcYvvYd1mL1R
         hj20YA/Q2aoGUV9kHVt3vkJDe6EaTzcmoLt9DUxbbxfFhWrBDgajHLQ4+e/v63TYn3id
         txTAAxn9r0vAie72/90IoxUrspJtOqFNmJ8bNWOOTi61FfqNYnVs/T7xMUyGQcvNuGHg
         pmHF9dScQcsMCwfKk9Qf+mEw83/8doLanMQurZ1bHWNgGYKeGDDl3ax8AeVbJCbJUGiI
         K21bcwR05oUAfMKd2d3cpwVpmaE1PMvbpUY8ItcIgk859wUBF3F6+8aixKXezeS52KI1
         /YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060089; x=1777664889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xw0ah93fqgdCasT1Yd1P/eO3pcya9SWmHCEVOlySNwM=;
        b=arHRyJV42xHiJS6eGJUPHpp4/g1/4GP46lM6X4DxuUzCYMlw3++OiKgUb6wRM8PbFn
         epLaiEIjkz7RCzautSPkAFxBfhP6yL1qf6v3fTvtOd5j2vKpvy4DPAcLvFFJrreWZsdt
         UV8YRyTOENhLd5N/7JXH7Xej8/BoAadQd891bX431e5hABNK5zE9VE/GFyyDF5/gjOWR
         Wy79F8OvCwpQ2rAEYWOQb8tOboQQPX+FwASD/LERF67ABA8DOArVtqjheW9rl7cNUYZH
         LVVaE6Vu1Hr8dCnwTdOyzp6KlcewIMt7RGwOAngcXCQGnmRRjgrGPbOgsiIQhenRmvlb
         aRvw==
X-Gm-Message-State: AOJu0Yz33F3QYJbAs0HRGp4Hn5OQKPVSdal0ZU+BqWpTB/2bH/ayW+Yx
	hPQDcUOWJ1K/oTpok9h2OP/PDigvnH3ZXrkNlkivkMZFjQjv3h1bXKYLc1U2Yj7E0nnWV5Sw7S+
	mP0WwVvSSVzxxIxcW+rTQVzTiyaWnXFE=
X-Gm-Gg: AeBDiev0hXzMonjZ71ztD7JnKLXpDnN0VuWq6sxUKmNJscAcUeCnmeh/hMh1o9XO0nU
	cFdK2v4NYljWHDFbVsAuLcbvFzdm5OnOWo10kxmK/79gy4CbnnbyycyH/wfXCtmT/FM5Ku/LYdz
	y9A3ADzgYe06rZ0UTfK0qo2huWDgHsWzv25myz+6qJTQYeuwnKjDpGI+Jjq3oePh7tVirVeHjtP
	lOdaUnKfKZMgClhUsDJdPoTEX2wsG6XPO2t7ybf54U5U8h74NJT6raexBAA6ovBy5ft4GFA7/2o
	lxbB3t/EzFK5GQVlr3MJI5nHm3hhEFSjTbipP1taEhLUX18qiVPTJGOHS3RZVY4koiAwMQlIBxd
	ut0wv
X-Received: by 2002:a53:5a04:0:b0:654:3fdc:7b3d with SMTP id
 956f58d0204a3-6543fdc80e1mr9099899d50.29.1777060088707; Fri, 24 Apr 2026
 12:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5d33658e20fc0ad4cfe80df185d31fecad66fcf.1777059145.git.pav@iki.fi>
In-Reply-To: <d5d33658e20fc0ad4cfe80df185d31fecad66fcf.1777059145.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 Apr 2026 15:47:57 -0400
X-Gm-Features: AQROBzDL_PBFs8AHw7GMhRRIhw96Y_bVsgI1r1Ck3GapL7tmfsia333VJnyPspU
Message-ID: <CABBYNZ+DhKq9_1kW0Xt6NgDPjMnAVjNXs+DPk-zbVFkhfDR9Uw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: deal with MT7925 invalid ISO RX packets
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Apr 24, 2026 at 3:38=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> MT7925 produces empty ISO packets for Handle 0 when RX is active:
>
>   > ISO Data RX: Handle 0 SN 36734 flags 0x00 dlen 0 slen 58  #851 [hci0]
>   > ISO Data RX: Handle 0 SN 36734 flags 0x00 dlen 0 slen 58  #852 [hci0]
>
> The driver should filter these out before passing to hci_core, otherwise
> it will printk "Bluetooth: hci0: ISO packet for unknown connection
> handle 0" errors.

Aren't these rate limited though?

>
> Filter out by adding hdev->classify_pkt_type
>
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  drivers/bluetooth/btmtk.c | 13 +++++++++++++
>  drivers/bluetooth/btmtk.h |  8 ++++++++
>  drivers/bluetooth/btusb.c |  1 +
>  3 files changed, 22 insertions(+)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index ab34f1dd42bc..9ba58cc9720a 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -1568,6 +1568,19 @@ int btmtk_recv_event(struct hci_dev *hdev, struct =
sk_buff *skb)
>         return hci_recv_frame(hdev, skb);
>  }
>  EXPORT_SYMBOL_GPL(btmtk_recv_event);
> +
> +u8 btmtk_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       /* MT7925 spams invalid ISO packets during ISO RX */
> +       if (hci_skb_pkt_type(skb) =3D=3D HCI_ISODATA_PKT &&
> +           skb->len =3D=3D sizeof(struct hci_iso_hdr) &&
> +           hci_iso_hdr(skb)->handle =3D=3D 0 &&
> +           hci_iso_hdr(skb)->dlen =3D=3D 0)
> +               return HCI_DIAG_PKT;

Not really following you here, why would marking it as a diagnostic
packet make it any better? In fact I do think this needs to print
something to the output if the firmware generates spurious packets and
have it fixed in the firmware asap, silently discarding the packets
just makes the issue undetectable, which I don't think really helps
users.

> +
> +       return hci_skb_pkt_type(skb);
> +}
> +EXPORT_SYMBOL_GPL(btmtk_classify_pkt_type);
>  #endif
>
>  MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index c83c24897c95..e573b21cecf7 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -222,6 +222,8 @@ int btmtk_usb_setup(struct hci_dev *hdev);
>  int btmtk_usb_shutdown(struct hci_dev *hdev);
>
>  int btmtk_recv_event(struct hci_dev *hdev, struct sk_buff *skb);
> +
> +u8 btmtk_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb);
>  #else
>
>  static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
> @@ -306,4 +308,10 @@ static inline int btmtk_recv_event(struct hci_dev *h=
dev, struct sk_buff *skb)
>  {
>         return hci_recv_frame(hdev, skb);
>  }
> +
> +static inline u8 btmtk_classify_pkt_type(struct hci_dev *hdev,
> +                                        struct sk_buff *skb)
> +{
> +       return hci_skb_pkt_type(skb);
> +}
>  #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a0a7da498466..7479928eec4b 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4245,6 +4245,7 @@ static int btusb_probe(struct usb_interface *intf,
>                 hdev->reset =3D btmtk_reset_sync;
>                 hdev->set_bdaddr =3D btmtk_set_bdaddr;
>                 hdev->send =3D btusb_send_frame_mtk;
> +               hdev->classify_pkt_type =3D btmtk_classify_pkt_type;
>                 hci_set_quirk(hdev, HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_=
CONN);
>                 hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
>                 data->recv_acl =3D btmtk_usb_recv_acl;
> --
> 2.53.0
>
>


--=20
Luiz Augusto von Dentz
