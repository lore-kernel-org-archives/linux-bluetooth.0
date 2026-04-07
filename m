Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D8525C80E
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569274; cv=pass; b=SDIr/x70pEKx4qc5NNGK4xthnucfIFTFTnrkjR7lBuOaCNF2UxU5vsS9ZYGR4qp3PpUAVO1qFzAnA/pzo+X6IyUb4x9LTjI3vQLzBDVmwNb/tWJHDIcUV7Yvbkn0h99BMbh+jGxW28Agk0r25/MEHqd2f21VKpJdFlqFc468EFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569274; c=relaxed/simple;
	bh=LRZ5hVwhom1Ev34WQmfOX4SnFiCZuFXFmOdeDfsbWdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaQcaduhtGJiw+PeaDxQQl+dEH0HMmnzYUlTH2qyUoIAKQZ6FoFeDtNzUDBYoqwj9cEvxifWWEYa3R3TE1z8HSJMTtnwYqMalAh9acug/r5lqA5QgS0E58b2MiwfviJzZqZGCXzU/BtmpUOIWbdZD2IMNCvVu1jX38aF/pvUbxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPGjlP+E; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPGjlP+E"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6507a833e68so990202d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 06:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775569271; cv=none;
        d=google.com; s=arc-20240605;
        b=IVnXDIchoJ1l5YUwWCpT2VbyVGo4NuZeUYMiRdpkVec3m+l+uXvTaEzplioa2Ltmdf
         Lh0WxsmiVWLPw0UhV4wtgq+uuV1Comgf4tfxDgWQ+AFUvTv9603zf6owEVXdE1FlZ3VS
         BZUNArNNB9lRtZpKE0/oGzNaLHeljbOxqw4AAj9PvDHcRvmc7yeo0+5ZCkHENrYZ63X5
         L0DCtZO7SyBcvJ6m3ta/0+TpXfqSf8jo7rTVQ5Rjna7EFhNc7ZgHqVXKOlOw08tWTj6O
         4L99Noaqc42XbZIYPekjqBd6ifWyMonGGROZUqmREtziDHpLfNWa6Xy/0n5rchZ8rZrQ
         uL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K6+qhHS9U2NR5KN/+3DgIjEjwrsUhOTdOACQA1DQXNk=;
        fh=a7qzjeDyBZhumgzgyPBFBnFINIdavdtrw2HgFxkq83E=;
        b=dh1hJGY2OvHMPVVGk1dFu2G2pWuWygH1r7FP9v9LdGIFlKHvFgWYqdnX2Ytd3Hp+7f
         hJsxJHBdnVFow4xz+EQ5PhbpMuJxR613BWUEnJ1EGbcqjwlIJ5aNYyHv1zcNs7PK9q5j
         eUcgTy+oW0qRmF/TUtPWL24WSzSakZjUIgBvNmH1Pwor2UHjlYhv+HKqqvygvJKFmrAC
         0/J0zP6bin7n4mDsDbgDYrciAENjYxputCrI6fUuKTPNw7BNhKorb8VEKxsChpQUDk5n
         Aw/7fBmH5AbaI/p6Pd1cgS0G5x+yGHWmdKE8w8UEApS8OgXHeoGaYaOBhPlzXsC7inDm
         YNSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775569271; x=1776174071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6+qhHS9U2NR5KN/+3DgIjEjwrsUhOTdOACQA1DQXNk=;
        b=NPGjlP+Em9/B7FeLU5R5rF2Haq3Qamo10rYh6dtpsy42uglXzg5HgCE1COof/1Ggqo
         kO5SW568JmGlzIsrao72duqmSqlEpPAM3qbX1Zsw0bz/Tfsj7sXtDQtMxC2gmPLt2lEf
         aOQpBYZlGfnlHmeFHJXjWi2X5jPGgChBRcccqz4vc8apIrh8qYuqK/3xRFPfCsqthBVw
         DS5FA/+nWsilyx0NzKH3rS2VLpg8MvtzL1QNb+mowiWDNu7pJ2mG+FUWwBr3KYZqY0hD
         8b/RyEVDXV7hboHZdy9eZ8QxK2lhH3JuawGfM9HiE/jSn9eehWlXG2VQ8Q+DMLV1MHj3
         V1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775569271; x=1776174071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6+qhHS9U2NR5KN/+3DgIjEjwrsUhOTdOACQA1DQXNk=;
        b=bk61mZ0wijiMJjIRF8fPn0K+DOt5jp6reB3rEUK6e6BjgBFyOdN1BHZNPfli0n/wHV
         CzNdFLvSmIqWnf5FRs8041a+YxfuzAzQi/5Bq1EchIrZVONvZHcVO11Mgi8YFQ4AkZDJ
         zRbsCwyj0+bTO+zdlj1vLzjXw+li/AGyRTPsLzLKpHQrlToIBWM/OpERnREm++qcgb3m
         qmeQvwqZtfpZb8kbsYOuOZw9U6EYzAeUJcTQmFJBaLPmGe7ze24WK7hHCADOcU9LAJHn
         /deaSLzAgzXOtv0vGYEjLrdC0JoFLtWgyShfWZABtbYnEgdOHNoOxNeNAr+sfhyWmbHQ
         xfpw==
X-Forwarded-Encrypted: i=1; AJvYcCVo8dbGw5SNvRoVf4iQmEKEfzXO7iVfjQw7EOvaEDjQ5s+kED3dipgmRnMC2/22kmHMOT2gAZwhHGsgXPDv+rI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+RaQUBKJzOKY/x6I+NqaQQ7GRsWeFFXUnOkQeSTM2gjr4/aZo
	CYmOCEiH8sSeWQuMCJfmxt/bQyAr1EmmKB2YJO9Izi+l2cWtMed3yr2GiwVbyIUbGO7M+E1CPaF
	5Ts8ldNd3FcsDwSw6ZuQ68fJXC40SYZU=
X-Gm-Gg: AeBDietZLGQnmGGe6d3Uqa4s1LQ1lHau5njyKe6nk9fC0YMC/wVgXR3MNB8AVzATwfK
	2k3istEDh/H7AhBQkJeSJfoWSmqY9K40VsTC2r+71u7rGVfNaI3txuXcUUuN2GvLybVEuJ/EkdT
	HL8lF7njUy90KgggT3XWji4npYuTPTPkvzmDfu7qj/tpWlxy8SjGdvfZJ1lJNgN/YBZO5L86vWu
	gPYPgXRrLWqt7wgRjd6NaJ28rKAMkAm6lu1z8K+3f6Q5Re1Z9bF83tmWcOgMqCYMqtrXM4n+z0Y
	LUVSzq82V/pg9fVp6SsRkYH8vdn4dKhcrpXXpi4sIlDeNJ5rdxSJVaDKXDtcBFPtwwVO5w==
X-Received: by 2002:a05:690e:4397:b0:64c:b81d:2cb7 with SMTP id
 956f58d0204a3-6504881bc03mr10964580d50.39.1775569270543; Tue, 07 Apr 2026
 06:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-brcm-prio-v1-1-f38b17376640@gmail.com>
In-Reply-To: <20260407-brcm-prio-v1-1-f38b17376640@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Apr 2026 09:40:58 -0400
X-Gm-Features: AQROBzAa16hYCox9YuiofHUqjsYpvs_frFTh54dv3AlFBuE-XJcb0jeBhhoCcSI
Message-ID: <CABBYNZ+OrkJWcbVKkyrpX3HHJr7vGgC92Y=wkf6PPwR9Zr+mOQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add Broadcom channel priority commands
To: fnkl.kernel@gmail.com
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 7, 2026 at 8:09=E2=80=AFAM Sasha Finkelstein via B4 Relay
<devnull+fnkl.kernel.gmail.com@kernel.org> wrote:
>
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
>
> Certain Broadcom bluetooth chips (bcm4377/bcm4378/bcm438) need ACL
> streams carrying audio to be set as "high priority" using a vendor
> specific command to prevent 10-ish second-long dropouts whenever
> something does a device scan. This series adds an ioctl to control
> the priorities and hooks it up for the relevant chips.
>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  MAINTAINERS                      |  2 ++
>  drivers/bluetooth/hci_bcm4377.c  |  2 ++
>  include/net/bluetooth/hci_core.h | 12 ++++++++++++
>  include/net/bluetooth/hci_sock.h |  7 +++++++
>  net/bluetooth/Kconfig            |  7 +++++++
>  net/bluetooth/Makefile           |  1 +
>  net/bluetooth/brcm.c             | 29 +++++++++++++++++++++++++++++
>  net/bluetooth/brcm.h             | 17 +++++++++++++++++
>  net/bluetooth/hci_conn.c         | 11 +++++++++++
>  net/bluetooth/hci_sock.c         |  4 ++++
>  10 files changed, 92 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c3fe46d7c4bc..81be021367ec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2562,6 +2562,8 @@ F:        include/dt-bindings/pinctrl/apple.h
>  F:     include/linux/mfd/macsmc.h
>  F:     include/linux/soc/apple/*
>  F:     include/uapi/drm/asahi_drm.h
> +F:     net/bluetooth/brcm.c
> +F:     net/bluetooth/brcm.h
>
>  ARM/ARTPEC MACHINE SUPPORT
>  M:     Jesper Nilsson <jesper.nilsson@axis.com>
> diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4=
377.c
> index 925d0a635945..5f79920c0306 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -2397,6 +2397,8 @@ static int bcm4377_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
>         if (bcm4377->hw->broken_le_ext_adv_report_phy)
>                 hci_set_quirk(hdev, HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY=
);
>
> +       hci_set_brcm_capable(hdev);
> +
>         pci_set_drvdata(pdev, bcm4377);
>         hci_set_drvdata(hdev, bcm4377);
>         SET_HCIDEV_DEV(hdev, &pdev->dev);
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index a7bffb908c1e..ef3b5433203c 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -642,6 +642,10 @@ struct hci_dev {
>         bool                    aosp_quality_report;
>  #endif
>
> +#if IS_ENABLED(CONFIG_BT_BRCMEXT)
> +       bool                    brcm_capable;
> +#endif
> +
>         int (*open)(struct hci_dev *hdev);
>         int (*close)(struct hci_dev *hdev);
>         int (*flush)(struct hci_dev *hdev);
> @@ -1791,6 +1795,13 @@ static inline void hci_set_aosp_capable(struct hci=
_dev *hdev)
>  #endif
>  }
>
> +static inline void hci_set_brcm_capable(struct hci_dev *hdev)
> +{
> +#if IS_ENABLED(CONFIG_BT_BRCMEXT)
> +       hdev->brcm_capable =3D true;
> +#endif
> +}
> +
>  static inline void hci_devcd_setup(struct hci_dev *hdev)
>  {
>  #ifdef CONFIG_DEV_COREDUMP
> @@ -1812,6 +1823,7 @@ int hci_get_conn_list(void __user *arg);
>  int hci_get_conn_info(struct hci_dev *hdev, void __user *arg);
>  int hci_get_auth_info(struct hci_dev *hdev, void __user *arg);
>  int hci_inquiry(void __user *arg);
> +int hci_set_acl_prio(struct hci_dev *hdev, void __user *arg);
>
>  struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *list,
>                                            bdaddr_t *bdaddr, u8 type);
> diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci=
_sock.h
> index 13e8cd4414a1..95d156ac4cae 100644
> --- a/include/net/bluetooth/hci_sock.h
> +++ b/include/net/bluetooth/hci_sock.h
> @@ -91,6 +91,8 @@ struct hci_ufilter {
>
>  #define HCIINQUIRY     _IOR('H', 240, int)
>
> +#define HCISETACLPRIO  _IOW('H', 250, int)

Nack, not going to introduce an ioctl command for this.

>  /* Ioctl requests structures */
>  struct hci_dev_stats {
>         __u32 err_rx;
> @@ -171,6 +173,11 @@ struct hci_inquiry_req {
>         __u8  length;
>         __u8  num_rsp;
>  };
> +
> +struct hci_acl_prio_req {
> +       __u16 handle;
> +       __u8  high_prio;
> +};
>  #define IREQ_CACHE_FLUSH 0x0001
>
>  #endif /* __HCI_SOCK_H */
> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
> index 6b2b65a66700..0f2a5fbcafc5 100644
> --- a/net/bluetooth/Kconfig
> +++ b/net/bluetooth/Kconfig
> @@ -110,6 +110,13 @@ config BT_AOSPEXT
>           This options enables support for the Android Open Source
>           Project defined HCI vendor extensions.
>
> +config BT_BRCMEXT
> +       bool "Enable Broadcom extensions"
> +       depends on BT
> +       help
> +         This option enables support for the Broadcom defined HCI
> +         vendor extensions.
> +
>  config BT_DEBUGFS
>         bool "Export Bluetooth internals in debugfs"
>         depends on BT && DEBUG_FS
> diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
> index a7eede7616d8..b4c9013a46ce 100644
> --- a/net/bluetooth/Makefile
> +++ b/net/bluetooth/Makefile
> @@ -24,5 +24,6 @@ bluetooth-$(CONFIG_BT_LE) +=3D iso.o
>  bluetooth-$(CONFIG_BT_LEDS) +=3D leds.o
>  bluetooth-$(CONFIG_BT_MSFTEXT) +=3D msft.o
>  bluetooth-$(CONFIG_BT_AOSPEXT) +=3D aosp.o
> +bluetooth-$(CONFIG_BT_BRCMEXT) +=3D brcm.o
>  bluetooth-$(CONFIG_BT_DEBUGFS) +=3D hci_debugfs.o
>  bluetooth-$(CONFIG_BT_SELFTEST) +=3D selftest.o
> diff --git a/net/bluetooth/brcm.c b/net/bluetooth/brcm.c
> new file mode 100644
> index 000000000000..d03d2af5dc7e
> --- /dev/null
> +++ b/net/bluetooth/brcm.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 The Asahi Linux Contributors
> + */
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include "brcm.h"
> +
> +int brcm_set_high_priority(struct hci_dev *hdev, u16 handle, bool enable=
)
> +{
> +       struct sk_buff *skb;
> +       u8 cmd[3];
> +
> +       if (!hdev->brcm_capable)
> +               return -EOPNOTSUPP;
> +
> +       cmd[0] =3D handle;
> +       cmd[1] =3D handle >> 8;
> +       cmd[2] =3D !!enable;
> +
> +       skb =3D hci_cmd_sync(hdev, 0xfc57, sizeof(cmd), cmd, HCI_CMD_TIME=
OUT);
> +       if (IS_ERR(skb))
> +               return PTR_ERR(skb);
> +
> +       kfree_skb(skb);
> +       return 0;
> +}
> diff --git a/net/bluetooth/brcm.h b/net/bluetooth/brcm.h
> new file mode 100644
> index 000000000000..a501f2988a96
> --- /dev/null
> +++ b/net/bluetooth/brcm.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2026 The Asahi Linux Contributors
> + */
> +
> +#if IS_ENABLED(CONFIG_BT_BRCMEXT)
> +
> +int brcm_set_high_priority(struct hci_dev *hdev, u16 handle, bool enable=
);
> +
> +#else
> +
> +static inline int brcm_set_high_priority(struct hci_dev *hdev, u16 handl=
e, bool enable)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +#endif
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 11d3ad8d2551..b2c7414a9c5b 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -35,6 +35,7 @@
>  #include <net/bluetooth/iso.h>
>  #include <net/bluetooth/mgmt.h>
>
> +#include "brcm.h"
>  #include "smp.h"
>  #include "eir.h"
>
> @@ -2775,6 +2776,16 @@ int hci_get_auth_info(struct hci_dev *hdev, void _=
_user *arg)
>         return copy_to_user(arg, &req, sizeof(req)) ? -EFAULT : 0;
>  }
>
> +int hci_set_acl_prio(struct hci_dev *hdev, void __user *arg)
> +{
> +       struct hci_acl_prio_req req;
> +
> +       if (copy_from_user(&req, arg, sizeof(req)))
> +               return -EFAULT;
> +
> +       return brcm_set_high_priority(hdev, req.handle, req.high_prio);
> +}
> +
>  struct hci_chan *hci_chan_create(struct hci_conn *conn)
>  {
>         struct hci_dev *hdev =3D conn->hdev;
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 0290dea081f6..4be6aeeb6bad 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1035,6 +1035,9 @@ static int hci_sock_bound_ioctl(struct sock *sk, un=
signed int cmd,
>                 if (!capable(CAP_NET_ADMIN))
>                         return -EPERM;
>                 return hci_sock_reject_list_del(hdev, (void __user *)arg)=
;
> +
> +       case HCISETACLPRIO:
> +               return hci_set_acl_prio(hdev, (void __user *)arg);
>         }
>
>         return -ENOIOCTLCMD;
> @@ -1072,6 +1075,7 @@ static int hci_sock_ioctl(struct socket *sock, unsi=
gned int cmd,
>         case HCIGETAUTHINFO:
>         case HCIBLOCKADDR:
>         case HCIUNBLOCKADDR:
> +       case HCISETACLPRIO:
>                 break;
>         default:
>                 return -ENOIOCTLCMD;
>
> ---
> base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
> change-id: 20260407-brcm-prio-b630e6cc3834
>
> Best regards,
> --
> Sasha Finkelstein <fnkl.kernel@gmail.com>

The simple solution would be for the driver to set all ACL connections
with high priority since in most cases we do want connections having
higher priority than scanning. That said, we may need to identify
which connections are performing audio versus those that are not. For
the audio connections, perhaps we could use skb->priority to set their
priority (provided userspace sets it for audio).

--=20
Luiz Augusto von Dentz
