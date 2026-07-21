Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40473976A9
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643789; cv=pass; b=a+W5vpyDMzpwQg92tB6oW6CNyEkxXfh8aFTNqOCggw/WG6YzFhpg7Ogy11ZNIFLIXIFKs7geCI8IRE/Ik2vscSCEp+DJI2bRcjd0g7+8WBT6/4yVwWUXcrQ4xT1rSlBC7U4xZBluCl5azldZNUHMxyjgqIN/cbRtW1VCT9TLyEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643789; c=relaxed/simple;
	bh=+uP6RODyJ1w+lh3sNUMBK73br0e2XzV6wU27hKhRZeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zu9mZKUTwM5Hbq+sv8yiFRw5SxO1xZpTbACL/VXCczxBvAse6i+UU8FoEM7yme2E14j1I2Y40hBe09JcLYlGvhMGGc2OcYPzFcEj5p3np7kMWxIbHr9fqzSAa92k9R1JxFG09ypok6KoBUND/VstYkirQCTOBLkC9dwY3qQf8Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMORtbYv; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMORtbYv"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-80cebd41372so105579637b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 07:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784643787; cv=none;
        d=google.com; s=arc-20260327;
        b=s6EXw0+rtKXrUpLts1mNJpTPBwejiyJoB9YhTaeS/FsHBnC/Arez517h5lWZ0ol8rT
         dCbt+4b1eYpYHpMp3u2IvjKdwiTbr/+tyKETjMMc51JNs+ziXvigOFkrxvuE05ODBwjj
         DuIAiDXZ7ShkZaOKU1F2ExPx6Gj605lbxLkJYyNvj/VUEjRM8GJAzSls9C5RiaWHpISH
         +frR+JicCU8JWJVDRBUNgjWZhQDP1l4IGBcXBS9bjkPA/XbW2UWAbBWT7eFTALqBKRrj
         EFhYcW0NzYnCBcxXXwenSFXGZ/LYO9Yz1aRLNXRz/qgjvZR/dNR7GLXCymXUC7+JJu2W
         ITqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8E33owZra3iWA1DttrvFl1DQFau5A39b2eJSW7Ms1jA=;
        fh=NpnlYs8kCHHkQEX9lj0fobHYWOcy19ezRLn6INaCLtw=;
        b=fX8BOANQBzQHO9i+a+DBBfOQ7ujJhU7663B2IbkviVz6oMRcwioX2U2HRyhzdE2ePp
         B/X2Rd1mPpEW8EwGHbSy59sootGcqoEgc1HncIAZGIAnnHKVD721UEPUtHPk+/HJ4xkF
         dqOSMqwFt0VtMDWJ754MvT2xY0YppHFp359ptMSX+/2VtG468Ood/xXOhaguEWkkNC92
         uoNx4xAS0o6thVhKlA5k68RUzlPfqX0CBGy+koMnDNyvsoM1je7/xywhKl4auBKgi/E3
         Nrdz8/P6q4hFGPGnyLrk9xdPTEkA/7G+IwnBZpIQIx/tpf5owF5wSKG0A8uecYlncvfv
         mFAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784643787; x=1785248587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8E33owZra3iWA1DttrvFl1DQFau5A39b2eJSW7Ms1jA=;
        b=iMORtbYv5dv8wiZX0EyJ1O29iW+gQFe7bB3IRyUzowbE2bd2NdQpRV6aXIlli4B+vr
         6B3YaV3uCXE5+oSqhHzav96dpbUaCeCcRdmcASQw7K7M4wVfBxjQNdZzHRN9HSyTRXlG
         ioJFfWSapBo447hhHWDPz1xumvyWnRXDdqucoiQ09gB46In8yzYXp/beP8cwkfck1co4
         87YElagJz+x46a03/RK2myNgDUU2R5GNfveveqEDsMafrrI7S+iJZntDy6ngwaeuoyXH
         nmztU1SIHu1yh2FOLe3Bbt8LE2voBTE3a6EEE7kcYK2FIt54BrFKzmFpUGYstQ0ULA+8
         1W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784643787; x=1785248587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8E33owZra3iWA1DttrvFl1DQFau5A39b2eJSW7Ms1jA=;
        b=hWP9jgYFwE2noNDpzocIpgw8VkeitgDkww0KRBfhA1lPWIKFOyoGpq1WQ4f8F3eWkL
         vzE2zqOBq+qji4KIC+fdibl34kHhjfzSKf+Iv9qo5lcqX3DOdsJUhyf1lTUYZvrGa+lH
         +24SYAYZGovVKh+X0XVFZEgZNQdG97Qypaw1LfG1q/p91NpUYKRvHofs9HtBBxNnysP1
         z1LI/RWsKXUQm15VpHkcpl35iaBg38n7CFgBhDSpVN6ITKDlb84g6nCxjEFTcfUSUZBa
         1FOtI91Dy8g5Luamd+oaNOEmncix55OlKPcUX4+EqXMmEwtwmU2I8f3cxmnywdWIDbnr
         Dp6A==
X-Forwarded-Encrypted: i=1; AHgh+Rq0VQ2WzaACz9+A5zTZWO/j1Fmsj6eLbVrfIAMvUoXiG4V+0KpYDln/UzQoOaCQe2pjcX5Qu3O0zuJ/svjABg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyAcP0pRglwmEYMOhBdYnK5vDtAu8+lC8q1G1vvxNFKNhy+6vL
	54fdAJ1shdIlZvDylJB8Z2DQ1o59+NmsY3fJmfIKKL3HI06RYJU5azTSxU8Yk7y9VACGVQ/tiAr
	XUhCwboRU/au4aAA2Uo8tD/dO89kugDU=
X-Gm-Gg: AR+sD12H/8xlVYE7H/xCTlBEAoT546B1beh7grM+Wl/nWJDvBF59eak8N7YBcOz/7IK
	o4hfBWGbg3gU53obnOlOgn640gGZCCBViOelyJBVdnfFvsMVER7+LBRCYOLQLmYKhTNPD9l3xOO
	Sx+AUAOcHTttOEs+YnYVyDFBecFhUCpcz2aYGh6ZDXTIJZxJl7o7rNyr/RIg2mjRnJYD4cfw9bO
	xoe1PMHR4OGEHF8E7lBnEouVXLj9lr6/wP6DQeiTKAWqAFVIp+g2YjYkaSW0jJNWWePGr6Rq43S
	Tim9hyj7EZlUrvEJ9sCeVfbg6Sem5eFa9VcL8SAt2KmdQB0Lc5AHiiHcAFE=
X-Received: by 2002:a05:690c:d8d:b0:81e:cda5:5149 with SMTP id
 00721157ae682-81ef252c29fmr56047407b3.28.1784643786644; Tue, 21 Jul 2026
 07:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719-support_vendor_hci-v1-1-764523a4ca3d@oss.qualcomm.com>
 <CABBYNZL_H2iRAshF-RCX41jbt0jots5i5W=aUUJC_wEN6wzp=w@mail.gmail.com> <0c5a924f-7382-407b-a0f4-dfd7dfe0d5e6@oss.qualcomm.com>
In-Reply-To: <0c5a924f-7382-407b-a0f4-dfd7dfe0d5e6@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 Jul 2026 10:22:54 -0400
X-Gm-Features: AUfX_mwCBav23XEZkLVHWhF3Pl53P_3n7WJOkV4UZ2Ady6960GqNyx6hKzbfYNM
Message-ID: <CABBYNZJbyfqLGNdXedi4+ZDNW0VNsiChaOTEb02Rz4rYd6UyNg@mail.gmail.com>
Subject: Re: [PATCH RFC] Bluetooth: Add generic support for vendor HCI frames
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Tue, Jul 21, 2026 at 4:52=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> On 7/20/2026 10:30 PM, Luiz Augusto von Dentz wrote:
> >> For Qualcomm multi-subsystem BT chips, the transport wire carries both
> >> BT-HCI and PERI-HCI frames. PERI is a subsystem on the chip. Take the
> >> upcoming QCC2072 support as an example:
> >>
> >>     Packet type                BT-HCI indicator   PERI-HCI indicator
> >>     --------------------------------------------------------------
> >>     CMD (Host -> Controller)   0x01                0x31
> >>     ACL Data (bidirectional)   0x02                0x32
> >>     EVENT (Controller -> Host) 0x04                0x34
> > I would say this was fine, but you actuall need to reclassify these to
> > 0xff and then use an extra byte for the vendor opcode. Btw, you said
> > you could define H4 headers like this? The spec defines either:
> >
> > https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/C=
ore_v6.3/out/en/host-controller-interface/three-wire-uart-transport-layer.h=
tml#UUID-1cf959bb-57a0-e782-4324-a9bc4ee3f134_table-idm13359018144714
> >
> > Or
> >
> > https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/C=
ore_v6.3/out/en/host-controller-interface/uart-transport-layer.html#UUID-83=
881875-5fbb-c366-400f-055ba726f70e_table-idm13359015052542
> >
> Hi Luiz,
>
> Let us label this approach =E2=80=94 which multiplexes the vendor indicat=
or under 0xff =E2=80=94 Solution A:
>
> virtual HCI_VENDOR_PKT (0xff) + vendor indicator (0x31/0x32/0x34) + body =
per indicator
> I did consider this solution =E2=80=94 let us discuss it in the section b=
elow.
>
> The PERI-HCI indicators (0x31/0x32/0x34) are defined by the Qualcomm Blue=
tooth Extensions
> specification for the USB (Bulk Serialization mode), H4 UART, and SPI tra=
nsports. They have
> already been deployed in several generations of commercial multi-subsyste=
m BT chips.

I know you probably don't want to change the format between the driver
and controller=E2=80=94that's fair if it's already in use=E2=80=94but that =
doesn't
mean it's valid to use them as is outside the driver's scope.

> > We end up defining vendor 0xff because it is at the end of the range
> > which is probably safer.
> >
>
> I am not sure that fully holds here:
>
> First, vendors likely reason the same way =E2=80=94 "end of range is safe=
r", Take Qualcomm as an example:
> it already used 0xfb/0xfc/0xfd/0xfe as internal indicators.

You can use that within the driver to controller transport but not above th=
at.

> Second, current transport drivers already use 0xff in ways that break tha=
t expectation,
> as shown below:
>
> 1) bpa10x uses 0xff as the wire indicator for HCI_DIAG_PKT (0xf0):
> https://elixir.bootlin.com/linux/v7.1/source/drivers/bluetooth/bpa10x.c#L=
72
>
> 2) btmrvl remaps its wire vendor type 0xFE onto 0xff to carry Marvell ven=
dor events:
> https://elixir.bootlin.com/linux/v7.1/source/drivers/bluetooth/btmrvl_sdi=
o.c#L797
>
> 3) hci_vhci uses it for the handshake that creates the virtual hdev:
> https://elixir.bootlin.com/linux/v7.1/source/drivers/bluetooth/hci_vhci.c=
#L462
> https://elixir.bootlin.com/linux/v7.1/source/drivers/bluetooth/hci_vhci.c=
#L523

Actually this reinforces my point that vendors should just multiplex
using 0xff, otherwise this will multiply. Still, I don't think this
proliferates outside the driver, so my comments hold: we should just
use 0xff to communicate vendor packets. That way, tools like btmon
understand it is a vendor packet and we don't need to build multiple
tables to express the domain of types each vendor uses.

> >> To generically support vendor HCI frames:
> >>
> >> - Show them in btmon logs as they appear on the wire.
> >> - Allow userspace to send/receive them via HCI_CHANNEL_USER, with a
> >>   socket option to control RX, defaulting off to eliminate regression
> >>   risk for existing applications.
> > We shouldn't need to do this, we should just accept 0xff as the vendor
> > packet type and then use the following byte as the real opcode (0x31,
> > 0x32, 0x34). Otherwise, if we start accepting vendor packet types
> > outside 0xff this will get crowded quickly and could potentially clash
> > with future specs.
> >
>
> The indicator is a full u8, the entire [0x10, 0xef] indicator range is cu=
rrently
> unused, and vendor indicators should be deliberately chosen to avoid conf=
licting with
> the BT SIG assignments.

Well you already pointed out vendors are all over the place with their
own packet types.

> >> - Add hdev->recv_vendor() to handle vendor frames in hci_rx_work() lik=
e
> >>   BT frame handlers.
> >> - Add hci_send_vendor_frame() API similar to existing __hci_cmd_send()=
.
> > Encoding/decoding of the frames should be transparent. I'm fine adding
> > code to the likes of btmon to decode vendor packets, we already have
> > something similar for Intel although that uses a vendor event not a
> > vendor packet (both use 0xff, causing the confusion). The user of the
> > user channel shall be able to read/write starting with 0xff then
> > decode/encode the next byte as the actual vendor opcode.
> >
> >> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> >> ---
> >> Hi Luiz
> >> To address the below concerns you raised on previous
> >> discussion, and inspired from your suggestion to add hdev callback:
> >>
> >> - Not use safer skb helper like skb_pull_data()
> >> - It will skip sending to the monitor, making debugging much harder
> >>
> >> Looking forward to your further comments.
> >>
> >> Why hdev->is_vendor() instead of multiplexing vendor frames under a
> >> virtual HCI_VENDOR_PKT + vendor indicator byte ?
> >>
> >> 1) The virtual HCI_VENDOR_PKT isn't used by the core itself
> >>    currently, and may be removed later.
> >> 2) It makes full use of the indicator (hci_skb_pkt_type(skb)) space,
> >>    which is large enough to accommodate vendor frames without an
> >>    extra layer of nesting inside HCI_VENDOR_PKT.
> >> 3) It lets userspace and btmon logs see the exact same frame as it
> >>    appears on the wire.
>
> As noted above, I chose is_vendor() over Solution A. My reasoning follows=
,
> for your reference.
>
> 1) Userspace sees exactly what is on the wire, in the same form as BT-HCI=
 frames =E2=80=94
>    clear and consistent, as shown below:
>   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>   =E2=94=82 Frame =E2=94=82 BT-HCI   =E2=94=82 PERI-HCI   =E2=94=82 PERI-=
HCI   =E2=94=82
>   =E2=94=82       =E2=94=82 existing =E2=94=82 is_vendor()=E2=94=82 Solut=
ion A =E2=94=82
>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>   =E2=94=82 CMD   =E2=94=82 0x01 =E2=80=A6   =E2=94=82 0x31 =E2=80=A6    =
 =E2=94=82 0xff 0x31=E2=80=A6 =E2=94=82
>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>   =E2=94=82 ACL   =E2=94=82 0x02 =E2=80=A6   =E2=94=82 0x32 =E2=80=A6    =
 =E2=94=82 0xff 0x32=E2=80=A6 =E2=94=82
>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>   =E2=94=82 EVENT =E2=94=82 0x04 =E2=80=A6   =E2=94=82 0x34 =E2=80=A6    =
 =E2=94=82 0xff 0x34=E2=80=A6 =E2=94=82
>   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> 2) is_vendor() puts PERI-HCI on an equal footing with BT-HCI, so userspac=
e and the transport
>    driver can reuse the existing BT-HCI path rather than add a separate e=
ncode/decode layer =E2=80=94
>    less effort on both sides.
>
> Could you please give me a clear direction
> Solution A or is_vendor()?

There might be a simpler approach, just consider anything other then
the known packets a vendor packet, so it is automatically stamped with
HCI_VENDOR_PKT then push it back to driver from processing.

> I need it before I can move forward with the remaining QCC2072 btusb deve=
lopment work.
>
> thank you.
>
>
>


--=20
Luiz Augusto von Dentz
