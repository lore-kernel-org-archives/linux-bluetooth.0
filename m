Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F535CB6D
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797845; cv=none; b=jhZgeM2UF5GNkWi+wsM2vPt8zSeo04YxtciFSJ5XOj4DE0WlD5yH2d7SJJaMlOKogr0p6gEW1tUo4GFQcIfOiD3FupoSPp8cuCPM9NPWsFNQQCUfG3ORJujAawtZW6P9yHh6I2Et8IEz3CmlEQlC6Q3QBCSLi48pmesCQb5F8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797845; c=relaxed/simple;
	bh=fvL5Aq5EZaylFLTAe6GwH7xU0V2ydU6nEzGXwuR9XUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsXpZ9o6PyNk86Cqku0KnWgReHdi1tTAOBAqUCeEP5W/npfUx9Mkc5BmmUhhaK+8yf+OU1EZFcNX70lTHhqD3qMhkKD8+mGSt3KA2/jXh/j0aWi2w47eU6+ju9oMRKh3ocj65DnVGAKjmo4NCfoq+qa/VHWfnOTUBXtil9xoN6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxX5J7Oj; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxX5J7Oj"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64669a2ecb5so1100604d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jan 2026 06:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767797843; x=1768402643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlGENMu3o6cBLcDeYDff2G8dRuXoMZxnkdZNgTS5OtU=;
        b=XxX5J7OjB0WroFzWmR8NHLYZDy6i7Uuph+plwWj5X9SITRrJxS6xQOXURg32LKLcbm
         cDHOAlSY1lrYmwrP4VH8P4vspqezCRdN4LmU1zFDI/3KbfdjC1e4/hRX7YVGpWG+ONRe
         VgpMBG8JF3Adixnzfe0VUg4EXl3jkdjjMySE/7dBDISxF9yfckbFXM31at5xFmY1NOQk
         I58uW1eJ8S0qx9ySAliXdZq1kdiUVkMhnQFqMRIqx1HHuSKXvT/yxW6+MTW0QcSiUADv
         +CNoPfGziGSWSaCV6bhqf5JJDLMhrdy/DqD8juHXT3UvYK1vbfaavM0VXd4Nb2ye7dFs
         B64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767797843; x=1768402643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xlGENMu3o6cBLcDeYDff2G8dRuXoMZxnkdZNgTS5OtU=;
        b=gDZLe1G4eFRGqe3Zo31vcWx2tNlu8C+igfpiMXZeyOMMY6ssCG4vvCQMNRWx04mkFS
         AboeEJoJwebTsV/IUbTxSQJm1+9SG+auefDwr5Pi0W/yeKRa22aGlepNJ+5TJOJN+cFQ
         GKDHMBa3K9hjxNUVi31aiDQzyOv6h+68ZDWkahs97xbo+8WbYJ09PewYsEUp49NT63yM
         gb75X4W7dukeesVDtTeb4ll5Mt8zoDT4TS4u3LIZc1tafkzqYaRcQN7IV8ubVLZXeHgs
         aojcTF2g0wpjrBvbAHwbG4lhgXyeJck0SoCZEILvg5FaM3ZX8uDMNqMsqX/PH3TxZT18
         9rWw==
X-Forwarded-Encrypted: i=1; AJvYcCV4UYb4VVCOzzHMAIlx37EwPQKK5EK1b2TTMWzw2eQoTXZ7YHkw9/k9fLMcdkiIzY6m9cV02XiEYmbOW7/UF3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy50zhhhA1WnWmxC03gzu/ouqrDB5TJtQhdCeoycRMQfXEtBRCm
	ToDEkCOQQogi+kaUCE6ES3A5egA80q46VqPv81avMnmjbZyC2hfqHVtfhTN6Z2frLvcU2lifyqJ
	RXsIwm+iMFWsF903gmEEsOoOjICCuneI=
X-Gm-Gg: AY/fxX74sT5J18o4E1v+9N0Y7OuL1VFFckc+LCwzV0aoZ2qV4ZCHGZD7RXCHmOvrXUk
	6bQAOZUUxFBGgQFq4hjLLDuoxPzvD3WTYLvfKNy3jUSJ8ABUwuFGT03h/G4n4D28+ZpeAeV5zVC
	cqSuIKILQzZH90hw7sHJbxnCnubBG6e32Mp17zhNPouSlW+imHzphEcoOCZKx/7M3rKwP2cE4Ge
	nA1Rullps4sS9hjOASxNZ+4vAMHBKrnAie1S1Fblmwig4Y7fk+jAHFxFP3HfP2wMeCwEF28zBZ9
	JeTlIXhFXcXYvRwp6RsWYhVvCYeC/uhpIi8clrWBy9aJChM2U66t1VJ5fA==
X-Google-Smtp-Source: AGHT+IHjTnt4JomhA1NrENsfN7U9oy8sOR4wHmf0Jm5V6vz/LIZBGXyI/1E3rqPv9Q1OLv5vv8dAFMlfW+nv2Sla2pY=
X-Received: by 2002:a05:690e:1206:b0:63f:c019:23b2 with SMTP id
 956f58d0204a3-6470d2dfce6mr5035512d50.28.1767797843191; Wed, 07 Jan 2026
 06:57:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-mgmt_ext_adv_sid-v1-1-1cb570c7adf7@amlogic.com>
In-Reply-To: <20260107-mgmt_ext_adv_sid-v1-1-1cb570c7adf7@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 7 Jan 2026 09:57:11 -0500
X-Gm-Features: AQt7F2qhSo4nrnNS5S4zj0Jx6WYkEx_FVwcpIMkrACSlquB2R40vf7Q2LUdC8jk
Message-ID: <CABBYNZ+a32Y9VM-XsECBjTwN_bXaPxuYALBL_6S8b+s1vQ8EZw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: mgmt: report extended advertising SID to userspace
To: yang.li@amlogic.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Wed, Jan 7, 2026 at 3:48=E2=80=AFAM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> Add a new mgmt event to report the SID of extended advertising
> to userspace. This allows userspace to obtain the SID before
> initiating PA sync, without waiting for the next extended
> advertising report to update the SID.
>
> By providing the SID earlier, the PA sync flow can be simplified
> and the overall latency reduced.
>
> Link: https://github.com/bluez/bluez/issues/1758

This is a new API so it can't possible fix the userspace issue above,
there is clearly a bug when sid is set to 0xff we shall not proceed
until it is resolved.

> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  include/net/bluetooth/hci_core.h |  2 ++
>  include/net/bluetooth/mgmt.h     |  7 +++++++
>  net/bluetooth/hci_event.c        |  3 +++
>  net/bluetooth/mgmt.c             | 13 +++++++++++++
>  4 files changed, 25 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index a7bffb908c1e..81ef3e94e3af 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -2469,6 +2469,8 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr=
_t *bdaddr, u8 link_type,
>                        u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
>                        u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_le=
n,
>                        u64 instant);
> +void mgmt_ext_adv_sid_changed(struct hci_dev *hdev, bdaddr_t *bdaddr,
> +                                    u8 addr_type, u8 sid);
>  void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_ty=
pe,
>                       u8 addr_type, s8 rssi, u8 *name, u8 name_len);
>  void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 8234915854b6..7ee38ebaccd8 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -1195,3 +1195,10 @@ struct mgmt_ev_mesh_device_found {
>  struct mgmt_ev_mesh_pkt_cmplt {
>         __u8    handle;
>  } __packed;
> +
> +#define MGMT_EV_EXT_ADV_SID_CHANGED            0x0033
> +struct mgmt_ev_ext_adv_sid_changed {
> +       struct mgmt_addr_info addr;
> +       __u8    sid;
> +} __packed;

I rather have a new device found event, or somehow embed the SID into
the existing one.

> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 467710a42d45..f4463e71b424 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6519,6 +6519,9 @@ static void hci_le_ext_adv_report_evt(struct hci_de=
v *hdev, void *data,
>                                            info->rssi, info->data, info->=
length,
>                                            !(evt_type & LE_EXT_ADV_LEGACY=
_PDU),
>                                            false, instant);
> +                       mgmt_ext_adv_sid_changed(hdev, &info->bdaddr,
> +                                                     info->bdaddr_type,
> +                                                     info->sid);
>                 }
>         }
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 5be9b8c91949..4e0f8c43e387 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -208,6 +208,7 @@ static const u16 mgmt_untrusted_events[] =3D {
>         MGMT_EV_EXT_INDEX_REMOVED,
>         MGMT_EV_EXT_INFO_CHANGED,
>         MGMT_EV_EXP_FEATURE_CHANGED,
> +       MGMT_EV_EXT_ADV_SID_CHANGED,
>  };
>
>  #define CACHE_TIMEOUT  secs_to_jiffies(2)
> @@ -10516,6 +10517,18 @@ void mgmt_device_found(struct hci_dev *hdev, bda=
ddr_t *bdaddr, u8 link_type,
>         mgmt_adv_monitor_device_found(hdev, bdaddr, report_device, skb, N=
ULL);
>  }
>
> +void mgmt_ext_adv_sid_changed(struct hci_dev *hdev, bdaddr_t *bdaddr,
> +                                    u8 addr_type, u8 sid)
> +{
> +       struct mgmt_ev_ext_adv_sid_changed ev;
> +
> +       bacpy(&ev.addr.bdaddr, bdaddr);
> +       ev.addr.type =3D link_to_bdaddr(LE_LINK, addr_type);
> +       ev.sid =3D sid;
> +
> +       mgmt_event(MGMT_EV_EXT_ADV_SID_CHANGED, hdev, &ev, sizeof(ev), NU=
LL);
> +}
> +
>  void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_ty=
pe,
>                       u8 addr_type, s8 rssi, u8 *name, u8 name_len)
>  {
>
> ---
> base-commit: 030d2c0e9c1d68e67f91c08704482ad9881583eb
> change-id: 20260107-mgmt_ext_adv_sid-7ea503e46791
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>


--=20
Luiz Augusto von Dentz
