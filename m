Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793199444;
	b=pMwvBXG/nPlywq18UUM2PcQcQ57nFm48oAKW4xq5Dw+j30mLKxoUU/WIbPfq5T/0hvih
	 aQNueI7hIy5uAuuWEQnbPP0dbQJH+XYLEmeENHHa2a+7EVPfFdx21U3YuPdyeGtmo2igk
	 bs3YfcFjHAHzCHQ3zSiO1YHyHQbTOkA31HyJfArgPlcmdNC/SCzp2Voz0Ztd7DaUQrS5a
	 fHrUGki7FuI25hDVKEAZ71AIWHxT1iGz0bxAA8sEZMPlLF7ZIrAhq326BeGNHNjKkPy2d
	 TmCgsNWscGNAtkDIflC6opTFFgwmoD9NiW8OEyj+YHEW5TT6+wtUFNiQ3yNV/QZHYrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=HkdJq15PeTOeOIwo/oNTuxDSywz7Ta3febRygWDp2/s=;
	b=WZ+Y3iZ6mwLRIlazd3T0NI+HmXdzqAKHzA0rdc/mO4oZppDsk0Mjal7XLerbM5Nkpc57
	 73ocQwYd53q+xG54Ld713sNlDBHm4kcaH6Zae4miD5UlL4/ZNqeC5mRMXNZgts+LZyeTd
	 gDuAkfIBBegbAgJAvjhd98Pp+2N3W54zmQB3Eb6Io97o1Q86uliRXPmLeCExpI4guKgsR
	 3ZGIA1qb2RaRAflKtAFadzZmw7ch7xjExNOARoHnsV08+ieCSLkLWqHJgzgLmt6qwrEyh
	 I3hrDa1Mw7GwBep86v9JXOrgsSDjxe5uFx6QHfjCGj6TLRIQdUCCeObWDFjteXQv6GQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NnXByW3d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BE3606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 14:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80BE3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NnXByW3d
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b118bea471so7724677b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 07:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793199443; cv=none;
        d=google.com; s=arc-20260327;
        b=NFX0y87x6ayAZOstjcLKnosEVSRf4pj7qCEckXvAxV3tQoASsiRL3V3+oTdqZlO8C0
         ZoeVKzV4MSE9qtrCK29TLCBNwsBJcyJH6DMtn+qfnk0uOY3f9oJ+2iwBvX7DMx+A19Qx
         58jmJUJdZGXSsPjqj3P9W52h3sshSu1UeazrU7Ddgz3+EQxIDqv8F9WKNgaa3+C5bfKS
         4Wc3ns3Ng+tCsAvvpP0DhJfffg/B7r+ul+Nqi6wZzdqPu/z+ZExPh3IT/WpDFCo7SNp7
         wzxndo+Ct1D4jbQRS7U1biTAfXOaQ8iifU4wScN3U7ccbhLDJ/VR3ucN1iQUH1i0UhxI
         jOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HkdJq15PeTOeOIwo/oNTuxDSywz7Ta3febRygWDp2/s=;
        fh=bAf3uaujpCfZ+gfuJE9eD1gL5QYFdHZrAlQVfG7eWXo=;
        b=OF+V73PTlyTZF+GiCDMwCoD04UN9I+ciL/rfJw0sGCpRWvJ1dhqGuD+hkOQSTvr/+Y
         ANPjqakFYrytM/9f5735O0mQiNbvb3VoaMtSCBpcZOW4X89y2Ct/ujDaEs/opcCb88bn
         t34FtWVxc32e0OOMIJiZB6jfqHxO6ixVs2eO0BYwo2r7NbfwScP7mkXloym3T0V5JiUl
         rNPl9Q7T55XWzEc58xZy9lhTpuyUUSkKuWA8gB/nle7TjWMH8eK11X0gHQn+QsTmWSDv
         bqNRdPwXcTZ86zekT8r2YRKhYeOtUPDELkqqctmn1Y4Ihusk6NIWuSOF8JShNei5gzNu
         yWtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793199443; x=1793804243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HkdJq15PeTOeOIwo/oNTuxDSywz7Ta3febRygWDp2/s=;
        b=NnXByW3dLz3DZF4C3CaeNZ+pF/bMFDYI5ZgDtr+yMAwCtES4d+14t970NrsE41YPO/
         TMGhDAVnxvQLJZGZVc2Q4lzjeYurF1VRHecBn+PaXFKGsbi6tAE4JG+KtFS3t8IX/WR1
         R6cOx6lD46tA3lVqimf5J6YKArt1mocMs/SMeVxkAu44Qjv/1LXGn+wRh+LZm0JwaVKJ
         RdwjUN+APhJ3amqn8sAydRSsG2FoU6Q8u9fr9Z5cNQZ1poVmOe0vWsNrdCe4yYfvunvz
         qxU6/zOrwrDw12IuS3HPu6+vtJBWZ3RiBMUvTjmh9I+70VJBjWOKU35mmDUijB1QGWuy
         hqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793199443; x=1793804243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HkdJq15PeTOeOIwo/oNTuxDSywz7Ta3febRygWDp2/s=;
        b=W6+UUJ5eyyFn+71ThAN0Y5eE9exi1tJetzDUNqPfIuaexDQWU4iE45HIY0LrnV/2L8
         3qrAgc6O/yCsBahlceiwOvrQS5gJVKgJjn5aYNxAHh0oEMPPOmpqD2Sk0YkVRLo9UlWL
         Pw+TPaOwjElUb7MADjnZrHn8dSrcC6iAdbwi3z6Px2u2CCQDhNH5WC4wyFQZDK+kEUJl
         czhgNdHdTHz3DEhZagasxhwd03asUYrUBcRAX3BfqF2d3ppzp0DrcNmS7W3mz/ovoLiX
         1NC/7RQgcBVIRbAiGRrBW1QwDUATDV2FA74WE04uM8fhxwaoPR1hUZBrnSgwkTGR4lb0
         /v0w==
X-Gm-Message-State: AFq9FYJotq15JeW3c3ww+jkENvscU16DlgpX/IwOeH/G+wLAesFhyt0m
	y9wKILl83ASXw00aXvrQGw+YADUh7UmQ8ievE2VcCWJRXiVZki5LLwqnwROxriwUFFnc62+R6C7
	t/AZYXlUaS+8rnZyipWMt7VBf34aMuI4=
X-Gm-Gg: AYBFou3YtJ7/uV8U2aglYrW5kjKcmKAfFFQ5hRG5tUbQLBKBEYwPbZSQ2LJyGmdjV+I
	UCZXROQmb9Elz2BVAUszZARO757bmelIPfFhfIW5v/6kqHTHD7Fsvgs2swn7mxX5gP4q/qVvnrM
	Z7bMfDM9OaiU4P+VTZVdgsjKemSa2JpOZHTKZVlIVGYdevcBh/SEMi/X+oFUYQzKIogTm508/k1
	S/nyDTR1sWDj8GhLWwkO5jo30BsnxQ+kRzkRPF0ngbaYYGV6f+4pNHrdhIlpqaw/8Q4xI06QkRk
	obvvw+ZJDByYajv99Yv6aFxBhTCB10UcHSEvuMGtZpro2uJLrJ56/iWv0xda404+VHpgl0pQ2GL
	SzawmEwECsP/Uxd69ITuMN48tkrZwD3vIz41LC9RlqbaIsVd6m/SCk9S4ugqR+TZVlvDoOL2op2
	3bUH4iJVUKEIjwhMo09pbk
X-Received: by 2002:a05:690c:289:b0:873:5c7b:c10b with SMTP id
 00721157ae682-8b1b5b914admr14387097b3.67.1793199443482; Wed, 28 Oct 2026
 07:57:23 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013032742.497402-1-cochcoder@proton.me>
In-Reply-To: <20261013032742.497402-1-cochcoder@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Oct 2026 10:57:12 -0400
X-Gm-Features: AclHuK-ZpgUIA6SAE6L6fo2z8JJRtIA-USfWE7ISwEnjob9Wt4Uny0X2zEJyuiA
Message-ID: <CABBYNZJpEQt=Oef8W01EfM=LoNQCKoWkvK3roDNFm2oW666_XA@mail.gmail.com>
Subject: Re: [RFC PATCH] Bluetooth: btusb: use shared ACL buffers for TP-Link UB500
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Mon, Oct 12, 2026 at 11:28=E2=80=AFPM Kyle Pepper <cochcoder@proton.me> =
wrote:
>
> The TP-Link UB500 (2357:0604) reports a dedicated LE ACL pool of 27
> bytes by eight packets and a BR/EDR ACL pool of 1021 bytes by six
> packets. Sustained large-SDU LE CoC traffic exhausts the small pool,
> although this controller accepts LE traffic through the larger ACL pool.

Are you sure that is the case, or did you just assume it because it
worked? Those are 2 different things, it maybe the at LE pool is not
actually 27 and the firmware is reporting the minimal rather than
maximum for example.

> Add an explicit HCI quirk and enable it only for the tested USB ID. When
> set, treat the LE buffer as shared so the existing HCI scheduler uses
> the ACL pool. Avoid inferring this from buffer sizes globally because
> other controllers may have legitimate separate pools.
>
> Assisted-by: OpenCode:gpt-6.1-sol
> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> ---
> Submission review notes (not part of the commit message):
> October 12 N8/UB500 no-quirk trial opens CoC, completes START, DLE
> and 2M, but sends no audio frames and logs two watchdog stalls. The
> host advertises MPS 23 instead of the baseline 512; peer MPS remains
> 168. Firmware pool semantics and simultaneous BR/EDR/LE accounting are
> not established. Keep the quirk device-specific and this proposal RFC.
>
>  drivers/bluetooth/btusb_main.c |  7 ++++++-
>  include/net/bluetooth/hci.h    |  7 +++++++
>  net/bluetooth/hci_event.c      | 22 ++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_mai=
n.c
> index 71d8dccb2..5e1fb26ab 100644
> --- a/drivers/bluetooth/btusb_main.c
> +++ b/drivers/bluetooth/btusb_main.c
> @@ -70,6 +70,7 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_INTEL_NO_WBS_SUPPORT     BIT(26)
>  #define BTUSB_ACTIONS_SEMI             BIT(27)
>  #define BTUSB_BARROT                   BIT(28)
> +#define BTUSB_USE_BREDR_ACL_BUFFERS_FOR_LE BIT(29)
>  #define BTUSB_QUALCOMM                 BIT(30)
>
>  static const struct usb_device_id btusb_table[] =3D {
> @@ -872,7 +873,8 @@ static const struct usb_device_id quirks_table[] =3D =
{
>         { USB_DEVICE(0x2c4e, 0x0115), .driver_info =3D BTUSB_REALTEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
>         { USB_DEVICE(0x2357, 0x0604), .driver_info =3D BTUSB_REALTEK |
> -                                                    BTUSB_WIDEBAND_SPEEC=
H },
> +                                                    BTUSB_WIDEBAND_SPEEC=
H |
> +                                                    BTUSB_USE_BREDR_ACL_=
BUFFERS_FOR_LE },
>         { USB_DEVICE(0x2357, 0x0607), .driver_info =3D BTUSB_REALTEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H },
>         { USB_DEVICE(0x0b05, 0x190e), .driver_info =3D BTUSB_REALTEK |
> @@ -4748,6 +4750,9 @@ static int btusb_probe(struct usb_interface *intf,
>         if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
>                 hci_set_quirk(hdev, HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED);
>
> +       if (id->driver_info & BTUSB_USE_BREDR_ACL_BUFFERS_FOR_LE)
> +               hci_set_quirk(hdev, HCI_QUIRK_USE_BREDR_ACL_BUFFERS_FOR_L=
E);
> +
>         if (id->driver_info & BTUSB_INVALID_LE_STATES)
>                 hci_set_quirk(hdev, HCI_QUIRK_BROKEN_LE_STATES);
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 1641d879d..d39a64663 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -375,6 +375,13 @@ enum {
>          */
>         HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
>
> +       /* When this quirk is set, LE connections use the BR/EDR ACL buff=
er
> +        * pool instead of the dedicated LE pool reported by the controll=
er.
> +        * This is required for controllers that expose an unusably small=
 LE
> +        * pool while accepting LE traffic through their shared ACL pool.
> +        */
> +       HCI_QUIRK_USE_BREDR_ACL_BUFFERS_FOR_LE,
> +
>         __HCI_NUM_QUIRKS,
>  };
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index c055d16cf..9936f6365 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1227,6 +1227,24 @@ static u8 hci_cc_pin_code_neg_reply(struct hci_dev=
 *hdev, void *data,
>         return rp->status;
>  }
>
> +/* Use the shared ACL pool for controllers whose dedicated LE pool is kn=
own to
> + * be unusable for sustained large-SDU traffic.
> + */
> +static void hci_le_use_shared_acl_buffer(struct hci_dev *hdev)
> +{
> +       if (hci_test_quirk(hdev, HCI_QUIRK_USE_BREDR_ACL_BUFFERS_FOR_LE) =
&&
> +           hdev->le_mtu =3D=3D HCI_MIN_LE_MTU &&
> +           hdev->acl_mtu > hdev->le_mtu && hdev->acl_pkts) {
> +               bt_dev_dbg(hdev,
> +                          "LE buffer at minimum (%u:%u), sharing ACL buf=
fer %u:%u",
> +                          hdev->le_mtu, hdev->le_pkts,
> +                          hdev->acl_mtu, hdev->acl_pkts);
> +               hdev->le_mtu =3D 0;
> +               hdev->le_pkts =3D 0;
> +               hdev->le_cnt =3D 0;
> +       }
> +}
> +
>  static u8 hci_cc_le_read_buffer_size(struct hci_dev *hdev, void *data,
>                                      struct sk_buff *skb)
>  {
> @@ -1247,6 +1265,8 @@ static u8 hci_cc_le_read_buffer_size(struct hci_dev=
 *hdev, void *data,
>         if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)
>                 return HCI_ERROR_INVALID_PARAMETERS;
>
> +       hci_le_use_shared_acl_buffer(hdev);
> +
>         return rp->status;
>  }
>
> @@ -3939,6 +3959,8 @@ static u8 hci_cc_le_read_buffer_size_v2(struct hci_=
dev *hdev, void *data,
>         if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)
>                 return HCI_ERROR_INVALID_PARAMETERS;
>
> +       hci_le_use_shared_acl_buffer(hdev);
> +
>         return rp->status;
>  }
>
>
> base-commit: 964430c038967fd06643e866f68115664e1a1bd1
>


--=20
Luiz Augusto von Dentz
