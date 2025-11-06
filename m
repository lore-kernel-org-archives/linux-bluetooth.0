Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6902DA776
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 23:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471466; cv=none; b=d8tb3NxQiXyBzsMGbntIc99XWL6dt6KdnOWiCM2B9dsqkdCbq+r5a3MZMPQM075DSPCRVrJkgrhMBqbzOJPrz1clzdGfY9JJYsFWSDPh5pfzlKOVvNanRD0b+jw1GcmQueT8BAP7rYR8S0A2wgU3EJIt5FYUtyiJkQhB5cz/3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471466; c=relaxed/simple;
	bh=isck9n05weddQV2IgA2nRgJIepJyax4M4AB9R8KV5fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3/PMFHJEHsLFNj0ms8mrkvo2gLz0j3rNqmYJC6yaCM34AMhjnlP1SdJzCz9soNa185mK0wzqZg9zX/2EkPSlV21KmJH/w4n6HNkc+jFLdDEztaqgJt3XBURtyfABodSkkTqTnlWEQOkSRKkwyJM8dzQBcqfTz6sYhTUpOrlU7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhJdrCoM; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhJdrCoM"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-36295d53a10so1438291fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Nov 2025 15:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762471463; x=1763076263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Usc7xcA8nQpcfi02Fccb3Kd4HlhNCvE/Ro5bzO3Oxwo=;
        b=XhJdrCoMSpJ3dh0sdLDgvLdMCadODsVwPB8uemIoz3+0DnKSBNkI5xB4+MZa5ARvdz
         6p3JnQe5MUbxAmsYN9oANkDlHxDIRnQh08H6ETqu6Cjy2Ou5mWOgk51c/AuG7Qff78Ii
         lnU8OsMe6G7ntf5qo5/CrKS+hQsGSdCKr/3RnFa7ycY1jzoGnpTNIpufKizWukpTqlL1
         zYkEEPC/TgH7KNLdtZu/B9HnQICZ9/m/uWn+KqMiRWw930GLzyLtCTUYucVkJa7v4n0c
         txWXRfuoBx6lkyz9KvP+FWEyyj6FBFk/xSqTRXb8wUTkq8S8bNdrcUXUrJKcamFCJno0
         rXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471463; x=1763076263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Usc7xcA8nQpcfi02Fccb3Kd4HlhNCvE/Ro5bzO3Oxwo=;
        b=dVAPKs9qgNitm21N1OFEhTeqhBOS4sxOSmeAXIKzjddJGm0hePrIayLYndmUOPIOMd
         Cx8bN9VoTXVC3W+geq5IYcybxJXtwmS9XyXl9T2JyV+eJ5uw3ZjAaLLpw2Dvtvfdn1M3
         3/3EjwJYrk20c/3SLZqkSU8Ni1K/fpG8jurUP/BBzwybPnt0MBAaHRxhOYZd3bNwIxMC
         hv81q16dhBSckxF4e5RlMFsEBQ4/6bj4dQa3i1CRr+4eBZB8Uw+1M0gcVg9R8esmnAub
         O3fjWUXQsDrAiEE+kqeKOyTZ/4OTvvRZlZ2ev8qt5etNsWPlMuk2Wcp7fPoWYxPQxZVJ
         276A==
X-Gm-Message-State: AOJu0YziO/hgbdPuyfuJl2AIQ0rfwV4xGZ22pljVjipG5tIwySWNCsP0
	la0Ymk2pRO5EDdDjle8XX0YoMkymhDd93QVLIiKdT4POOVnvJUCabfqwYMQeWdn5dkJxO86rWZE
	qjm+dXSAZuOhZg6dxig8R1UIcmZOvPqg=
X-Gm-Gg: ASbGncvoYKDmb+T5nG7hOhldG4HTTjrfaLX34DCLNn++5O7kQyGK1qtO7C0kXRj3vD3
	Qi9f5e64YFzfCBgXtziv32xRcVyuvBZoLyEUhsn1EUTHuDM4a2KBho+14TU2UUmArNPuto/9e8D
	8ShhtolD0/qGVpANGOddIu3619rSAX8PhNtXJjjV4fV3LpnXHMGmleE5pjPurFpdjCjY4IqrZe+
	ipF6+Z7PZiW6K+ptHdsQMjkwBwq6gRZKKysRoOoZ0GHDEjvfN3tk5r/JY1l7nTlu+ZMwg==
X-Google-Smtp-Source: AGHT+IGmTou9qstyzC1ht6J3jo01wyxjD5H/KjYbfDr3DeAt/oQ8t3DDu6ln0g1NM5XzpogrQoBwAefcy7APCOdyFyw=
X-Received: by 2002:a05:651c:41d4:b0:378:e88e:70b7 with SMTP id
 38308e7fff4ca-37a730d93cfmr2763121fa.8.1762471462643; Thu, 06 Nov 2025
 15:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104072222.195729-1-chethan.tumkur.narayan@intel.com>
In-Reply-To: <20251104072222.195729-1-chethan.tumkur.narayan@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 6 Nov 2025 18:24:10 -0500
X-Gm-Features: AWmQ_bkUEbUxHXux98i0a0NzVNQ32SBLhzxf4GWwkx1u9XhUvzO8zfjjpKvEJD0
Message-ID: <CABBYNZJS3ewQ5EZN+7iZqS1BwUjC+j3GjT9xfy=vNWWf_K21vg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Introduce HCI Driver protocol
To: Chethan T N <chethan.tumkur.narayan@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chandrashekar.devegowda@intel.com, kiran.k@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chethan,

On Tue, Nov 4, 2025 at 2:10=E2=80=AFAM Chethan T N
<chethan.tumkur.narayan@intel.com> wrote:
>
> This patch adds the infrastructure that allow the user space program to
> talk to intel pcie driver directly for fetching basic driver details.
>
> The changes introduced are referred form
> commit 04425292a62c15 ("Bluetooth: Introduce HCI Driver protocol")
>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 59 ++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index b0ad3c759ef5..7b47002fba75 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -19,6 +19,7 @@
>
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> +#include <net/bluetooth/hci_drv.h>
>
>  #include "btintel.h"
>  #include "btintel_pcie.h"
> @@ -2360,6 +2361,63 @@ static bool btintel_pcie_wakeup(struct hci_dev *hd=
ev)
>         return device_may_wakeup(&data->pdev->dev);
>  }
>
> +static const struct {
> +       u16 opcode;
> +       const char *desc;
> +} btintel_pcie_hci_drv_supported_commands[] =3D {
> +       /* Common commands */
> +       { HCI_DRV_OP_READ_INFO, "Read Info" },
> +};
> +
> +static int btintel_pcie_hci_drv_read_info(struct hci_dev *hdev, void *da=
ta,
> +                                         u16 data_len)
> +{
> +       struct hci_drv_rp_read_info *rp;
> +       size_t rp_size;
> +       int err, i;
> +       u16 opcode, num_supported_commands =3D
> +               ARRAY_SIZE(btintel_pcie_hci_drv_supported_commands);
> +
> +       rp_size =3D sizeof(*rp) + num_supported_commands * 2;
> +
> +       rp =3D kmalloc(rp_size, GFP_KERNEL);
> +       if (!rp)
> +               return -ENOMEM;
> +
> +       strscpy_pad(rp->driver_name, KBUILD_MODNAME);
> +
> +       rp->num_supported_commands =3D cpu_to_le16(num_supported_commands=
);
> +       for (i =3D 0; i < num_supported_commands; i++) {
> +               opcode =3D btintel_pcie_hci_drv_supported_commands[i].opc=
ode;
> +               bt_dev_info(hdev,
> +                           "Supported HCI Drv command (0x%02x|0x%04x): %=
s",
> +                           hci_opcode_ogf(opcode),
> +                           hci_opcode_ocf(opcode),
> +                           btintel_pcie_hci_drv_supported_commands[i].de=
sc);

Do we really need to print out this information with bt_dev_info
rather than bt_dev_dbg? If you left it just for debugging maybe we can
completely remove it, in fact what I think is missing is the sending
this sort of traffic to btmon to decode, that way we don't need to
keep this sort of code in the kernel.

> +               rp->supported_commands[i] =3D cpu_to_le16(opcode);
> +       }
> +
> +       err =3D hci_drv_cmd_complete(hdev, HCI_DRV_OP_READ_INFO,
> +                                  HCI_DRV_STATUS_SUCCESS,
> +                                  rp, rp_size);
> +
> +       kfree(rp);
> +       return err;
> +}
> +
> +static const struct hci_drv_handler btintel_pcie_hci_drv_common_handlers=
[] =3D {
> +       { btintel_pcie_hci_drv_read_info,       HCI_DRV_READ_INFO_SIZE },
> +};
> +
> +static const struct hci_drv_handler btintel_pcie_hci_drv_specific_handle=
rs[] =3D {};
> +
> +static struct hci_drv btintel_pcie_hci_drv =3D {
> +       .common_handler_count   =3D ARRAY_SIZE(btintel_pcie_hci_drv_commo=
n_handlers),
> +       .common_handlers        =3D btintel_pcie_hci_drv_common_handlers,
> +       .specific_handler_count =3D ARRAY_SIZE(btintel_pcie_hci_drv_speci=
fic_handlers),
> +       .specific_handlers      =3D btintel_pcie_hci_drv_specific_handler=
s,
> +};
> +
>  static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
>  {
>         int err;
> @@ -2386,6 +2444,7 @@ static int btintel_pcie_setup_hdev(struct btintel_p=
cie_data *data)
>         hdev->set_bdaddr =3D btintel_set_bdaddr;
>         hdev->reset =3D btintel_pcie_reset;
>         hdev->wakeup =3D btintel_pcie_wakeup;
> +       hdev->hci_drv =3D &btintel_pcie_hci_drv;
>
>         err =3D hci_register_dev(hdev);
>         if (err < 0) {
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
