Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F234402C
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897375; cv=none; b=A+5RRIqhHXzZI3w2XrJIVjGeRfrCoXkfLXz+lnGDXsxUhB49HNLUz0YkRlauTzu4bpX5QKnv/BVqTTa76bBzjFXNXK39w50SoYuJ97+AXEnqErc5nR1HgatdlzMUvtZQZ57ks2aZ5fo5S3Pbdw52Kfp+rmh3N9UD7PWxR0r0ASk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897375; c=relaxed/simple;
	bh=4yk435/A3HZidCggcM9qkNdBygfybUubpr6H2A6TxoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kaRshajSnsCi1TRTa6TaUlN+IFEY9XBu9k/vERwiJkk0u2mxK1IiuUwB1R+zi83q27oe8iD8E6B9emoW7dDwT9BtSEQ+8c//AI563DRriEN13BQ4WEysMt1j2ve+9nKHTiMNX3zDT8OoWWothuCq6P0Xmu4jansPTQttjYF3atQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMhtmHI/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMhtmHI/"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37a415a22ecso34007281fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 07:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765897371; x=1766502171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNlA3l3A/zOzvpH6BQMFMpBNPheEsHPcxJnQgMpaBmw=;
        b=RMhtmHI/wRau1Mx+DpeD0a1lHK/bO9FTLlMa9hAzyjFvHljT5qM+dXGwsqGFEiRMHw
         6BTGjAmOh4Fvgt9i2uOW7maC+PgZQvM9bRvEOaGoWFeD5Xm+zndSzxX+wrSyNUXaO41S
         HBBfvqrqiJLawG/EYVX/kUawjsa6gGAhA36FAvzLS5lm6pdHvOQrfOPK/8OQr9sm690s
         BR1FFtKGJNG9ot5nbdrq9p/7O0IB992kMR0p9u2rsjSFwqd6iG0Pq+IxPZYuGIlg6zwc
         bxYdIrL2Tf9ARLWxrSuAXTCzmDlrsUPbkDHYa4sOkfRCjcDQElK5qKciRIt0flPV+fLP
         s93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765897371; x=1766502171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DNlA3l3A/zOzvpH6BQMFMpBNPheEsHPcxJnQgMpaBmw=;
        b=BOFLw5jeFdIxSKgeLojtQXCWB6Wif3whZf/SfKokBHXG1XaMnMiHBgHuHyR7ZHXfgp
         qXcntCRMH2vC96BAAjJ92P4Qb9fq5rZ1hIZLFl5Pgo9Oj1O9DUWctjLnMlnyrbGaovdc
         VUZfKYiiMT39urn0R5hmGvxeBkj5KnZt3JFgP7aspoO6uJ4GxSaXnZkrAIbLRctbZ08+
         mibxFjny9twV445UBqenktmSpqTmCEsgkxclDe/FCQKfk5RHIx8i3taks2zDdKZUdj4c
         ZOAfNGytG9eAwylTJkeTmEbWFey8QBtQCKpScIR5pdg/SDOhqn7HvPaxyhp3XSX9s1qw
         6fgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXccaZEF4s+nVX/MBQEKaP9/o9xe1S5tfO7DbA8bgf1OCOG9gMeU4CLujOe4cc+b0DQ/X0Y25idCmrLjmLTxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8UR8QBp7SiLoehbiwe5ZNlpBPHgzIZ+2YR9Hi2oj1sJUjmoR6
	uGzBtlPfIkzcCglEAGz+edf2ZMlMpRe00mnixO8s3pEltWo/fFD8crbEA0xUH+b40PNUUZdY4C1
	fMLlUN/lLkQaVxW0Mwg7mR6cAA1pQUiU=
X-Gm-Gg: AY/fxX630Psg2tJ8P7WB8m6FFgy/D5ew0DbXIZ/xgTiobtkYXMKZsO4e3WSy6HQ8kcM
	9obcoR/1o+Ktxrv0y2tEay10rmJVpvF2q4N+ZheebT8LkLRWRc67de1hw6LFoHHG/04VASZbW7H
	XnxXZoRXtXpVqqzrT32hHJDTf9DgJDEi7A4/nAzjzebWUO8SAQCWgVGkk7af166Vb+5RjYSvBNG
	kMDxp/8RpgVG9eEFZJ396DB8BzvoLAS0i2/RlqK4jrNS5QFTPBs4IIM7eJSRqWYYRuOWqUF/ZU8
	D8tY
X-Google-Smtp-Source: AGHT+IHdT8zgO/vNBzu1kWVUy26MTdwRJtNQU16nsKu+GhTdgmpSUZRMKQpEp/fvE+ENB8t7Bb6IgLiwQ33FkuMIzRU=
X-Received: by 2002:a2e:a549:0:b0:37e:6a62:1279 with SMTP id
 38308e7fff4ca-37fbfb28058mr53226901fa.10.1765897370756; Tue, 16 Dec 2025
 07:02:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216092011.111208-1-ssorensen@roku.com> <20251216092011.111208-4-ssorensen@roku.com>
In-Reply-To: <20251216092011.111208-4-ssorensen@roku.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 16 Dec 2025 10:02:37 -0500
X-Gm-Features: AQt7F2ovUGpSIXe5A8KuD9hHtyn9uV9Zq7ULu5bHi-magJTPisYhTHuBa934cX8
Message-ID: <CABBYNZKREQ60p3fm3BBu1u0E5AHwoAE=rnq2pKgjLXKUDWg7VA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: mgmt: Add idle_timeout to configurable
 system parameters
To: =?UTF-8?Q?Stefan_S=C3=B8rensen?= <ssorensen@roku.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Tue, Dec 16, 2025 at 4:20=E2=80=AFAM Stefan S=C3=B8rensen <ssorensen@rok=
u.com> wrote:
>
> While the configurable system parameters allow controlling the SNIFF
> mode parameters, they do not include the idle_timeout parameter
> responsible for enabling SNIFF mode.
>
> Add the idle_timeout parameter to allow controlling the idle timeout
> of BR/EDR connections.

While the implementation seem quite simple and elegant you will need
to first update the MGMT documentation:

https://github.com/bluez/bluez/blob/master/doc/mgmt.rst#read-default-system=
-configuration-since-118

And it is also a good idea to implement proper decoding for the new
option in btmon, but it doesn't seem we currently decode its
parameters:

https://github.com/bluez/bluez/blob/master/monitor/packet.c#L16577

I'm fine if you don't have free time to introduce decoding for the
existing opcodes we can leave it for later, but that would be great
for debugging purposes.

> Signed-off-by: Stefan S=C3=B8rensen <ssorensen@roku.com>
> ---
>  net/bluetooth/mgmt_config.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
> index c4063d200c0a6..4ec6c008cb7e6 100644
> --- a/net/bluetooth/mgmt_config.c
> +++ b/net/bluetooth/mgmt_config.c
> @@ -11,6 +11,12 @@
>  #include "mgmt_util.h"
>  #include "mgmt_config.h"
>
> +#define HDEV_PARAM_U32(_param_name_) \
> +       struct {\
> +               struct mgmt_tlv_hdr entry; \
> +               __le32 value; \
> +       } __packed _param_name_
> +
>  #define HDEV_PARAM_U16(_param_name_) \
>         struct {\
>                 struct mgmt_tlv_hdr entry; \
> @@ -29,6 +35,12 @@
>                 cpu_to_le16(hdev->_param_name_) \
>         }
>
> +#define TLV_SET_U32(_param_code_, _param_name_) \
> +       { \
> +               { cpu_to_le32(_param_code_), sizeof(__u32) }, \
> +               cpu_to_le32(hdev->_param_name_) \
> +       }
> +
>  #define TLV_SET_U8(_param_code_, _param_name_) \
>         { \
>                 { cpu_to_le16(_param_code_), sizeof(__u8) }, \
> @@ -78,6 +90,7 @@ int read_def_system_config(struct sock *sk, struct hci_=
dev *hdev, void *data,
>                 HDEV_PARAM_U16(advmon_allowlist_duration);
>                 HDEV_PARAM_U16(advmon_no_filter_duration);
>                 HDEV_PARAM_U8(enable_advmon_interleave_scan);
> +               HDEV_PARAM_U32(idle_timeout);
>         } __packed rp =3D {
>                 TLV_SET_U16(0x0000, def_page_scan_type),
>                 TLV_SET_U16(0x0001, def_page_scan_int),
> @@ -111,6 +124,7 @@ int read_def_system_config(struct sock *sk, struct hc=
i_dev *hdev, void *data,
>                 TLV_SET_U16(0x001d, advmon_allowlist_duration),
>                 TLV_SET_U16(0x001e, advmon_no_filter_duration),
>                 TLV_SET_U8(0x001f, enable_advmon_interleave_scan),
> +               TLV_SET_U32(0x0020, idle_timeout),
>         };
>
>         bt_dev_dbg(hdev, "sock %p", sk);
> @@ -122,6 +136,7 @@ int read_def_system_config(struct sock *sk, struct hc=
i_dev *hdev, void *data,
>  }
>
>  #define TO_TLV(x)              ((struct mgmt_tlv *)(x))
> +#define TLV_GET_LE32(tlv)      le32_to_cpu(*((__le32 *)(TO_TLV(tlv)->val=
ue)))
>  #define TLV_GET_LE16(tlv)      le16_to_cpu(*((__le16 *)(TO_TLV(tlv)->val=
ue)))
>  #define TLV_GET_U8(tlv)                (*((__u8 *)(TO_TLV(tlv)->value)))
>
> @@ -191,6 +206,9 @@ int set_def_system_config(struct sock *sk, struct hci=
_dev *hdev, void *data,
>                 case 0x001f:
>                         exp_type_len =3D sizeof(u8);
>                         break;
> +               case 0x0020:
> +                       exp_type_len =3D sizeof(u32);
> +                       break;
>                 default:
>                         exp_type_len =3D 0;
>                         bt_dev_warn(hdev, "unsupported parameter %u", typ=
e);
> @@ -314,6 +332,9 @@ int set_def_system_config(struct sock *sk, struct hci=
_dev *hdev, void *data,
>                 case 0x0001f:
>                         hdev->enable_advmon_interleave_scan =3D TLV_GET_U=
8(buffer);
>                         break;
> +               case 0x00020:
> +                       hdev->idle_timeout =3D TLV_GET_LE32(buffer);
> +                       break;
>                 default:
>                         bt_dev_warn(hdev, "unsupported parameter %u", typ=
e);
>                         break;
> --
> 2.52.0
>


--=20
Luiz Augusto von Dentz
