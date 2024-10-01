Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D341C8FA3
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792523; cv=none; b=WWMQa/8LrpL5/kh7SOoFcDecz3feniD7RYdf2UIq+xWhzMveNK/jjWDcSU1JG9gStwkZzSWTq3Zm9sAtVFRWwUZps/7X02ZGnpVfWc7F42YijvTxZ8SVB/lcjK54W2CxgvopU1QFBjWo+J3Kc5cjDIfYvhGS3OLbAuex5LJcBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792523; c=relaxed/simple;
	bh=Db1kB7ycyzpZljki2Gk9wSNOp1NHjZ2GRdbMW4YQU2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQAK8C5WJiu9h0A49DYB/a0wDxz8USG0bAzHhc1Pgak08kFXFJ5HCRvfK7G+qFWWvzq8odvL97o4YArQngUHI5AHdlII6YBItx34nTyCO1IGLHQs547MFQRdi0G8AUGMT/glClgh/XMe1Fi5XFndxSKHjjOsvQAIoG1ORjAsOUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMvtTmA5; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMvtTmA5"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fabc9bc5dfso40498271fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Oct 2024 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727792520; x=1728397320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4wEeqdSCGPaD16pfAlI7SBfTC4xBI3hiQhgSc81/04=;
        b=bMvtTmA5ta5s5Xicq5ziCsve1aHhcDlrgNopYBEW/VdXaF5Ocy9lmp4iLzbalzLAUw
         RbCAoDE1bjAGQ2msogczJlFjClk2GQlUfmxbjpT+U3nO9iKv9kKRXdoBey00MQNChRjp
         G00NcjYbF+7mJ2l9YlROgEeShmV2qN4LIpP6dDuppRFmzIBX6onHZamaJ0kjMQo6SotG
         GL6ox1kKuDhAjeBrcbui974aucYmEd/bE6kSPp104RIIhdEOtAAgxNydMAKyhAdCQweq
         7TAalkktnwk+/ruAva9SdeXg2Am4xNhFLNsnwT64ccmZT4gP6sOQ5O1S0l/7GtAqqr8J
         Cq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792520; x=1728397320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4wEeqdSCGPaD16pfAlI7SBfTC4xBI3hiQhgSc81/04=;
        b=pz226t7aLQSdmLqiZgHgZ+4nAMnF1Wgj/qiZiy9IZCPojVou1WNpMnJYWzON53s0PP
         I9N1zccvq6LdCerJmoASWYwrS9P47u06HMpkwbbE0duRMRf9YKLfNQr5S8FopRcEtR09
         8nCzmAVwPl9QBgY5kPIrE8kKCUaoXtCnwz1xdB/KWJxqz2DHK6NmXqy5Jfc3sV7hTbq4
         rFFalDL9jB0rYJuEztiWliAmJ78nhKA0neKJfCWw+ryKQW/d2zcYinmr2O2venTBKLTw
         eeQfuhAtOwOpZhEOvjYfJMlQTrKdREuqVf/nj0FrqNB7AGTx13pIvYT8BkFJsb1iYOw6
         zIbQ==
X-Gm-Message-State: AOJu0Yx8T+S3rMsvR1rbOFRPJrFWoovD0LQLGmcaIqR8l/GyOJLLBpLX
	RHgsLQa5QnokoJZTNgmxVT2R0c4Z30UVVBgdyMYx+GD0iZZuCjj2Jyoa34xDyCsdB5EwYNnBbPS
	Z6EexFd5xEB3VrUgH31J6j5WqAZqp0w==
X-Google-Smtp-Source: AGHT+IFEqLdNUj4pjs8GymKT86q8TWkMmUG0PMgxcTeKVdQMAq9pQPTN3yag7fSZprOhec82W0sum2LunGxRyNUvQUY=
X-Received: by 2002:a2e:d1a:0:b0:2f7:5d73:92a3 with SMTP id
 38308e7fff4ca-2f9d3f7bbdcmr67786261fa.24.1727792519423; Tue, 01 Oct 2024
 07:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001104451.626964-1-kiran.k@intel.com> <20241001104451.626964-2-kiran.k@intel.com>
In-Reply-To: <20241001104451.626964-2-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Oct 2024 10:21:46 -0400
Message-ID: <CABBYNZ+1DnC3OQQ6ozMx7wCtWNS1sG8y+N6V0d30-SHToB8xZw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] Bluetooth: btintel_pcie: Add recovery mechanism
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Tue, Oct 1, 2024 at 6:29=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> This patch adds a recovery mechanism to recover controller if firmware
> download fails due to unresponsive controller, command timeout, firmware
> signature verification failure etc. Driver attmepts maximum of 5 times
> before giving up.

Typo attempts, that said repeating the same process 5 times seems very
arbitrary, we should probably attempt to reload as fewer times as
possible e.g. 1 and only for specific reasons like a timeout, etc. I
wouldn't retry on signature verification failure since that probably
would just cause the same problem over and over again.

As for redoing the setup, perhaps we could have a MGMT command that
attempts to setup the controller once again, that way we can trigger
the command from userspace to retry the setup if for example the
firmware file is updated, etc, or you want to manually trigger a setup
for validation purposes.

> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c      |  14 ++++
>  drivers/bluetooth/btintel_pcie.c | 109 +++++++++++++++++++++----------
>  drivers/bluetooth/btintel_pcie.h |   2 +
>  3 files changed, 91 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index fed1a939aad6..c14ec6c6120b 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1252,6 +1252,12 @@ static void btintel_reset_to_bootloader(struct hci=
_dev *hdev)
>         struct intel_reset params;
>         struct sk_buff *skb;
>
> +       /* PCIe transport uses shared hardware reset mechanism for recove=
ry
> +        * which gets triggered in pcie *setup* function on error.
> +        */
> +       if (hdev->bus =3D=3D HCI_PCI)
> +               return;
> +
>         /* Send Intel Reset command. This will result in
>          * re-enumeration of BT controller.
>          *
> @@ -1267,6 +1273,7 @@ static void btintel_reset_to_bootloader(struct hci_=
dev *hdev)
>          * boot_param:    Boot address
>          *
>          */
> +
>         params.reset_type =3D 0x01;
>         params.patch_enable =3D 0x01;
>         params.ddc_reload =3D 0x01;
> @@ -2796,6 +2803,13 @@ int btintel_bootloader_setup_tlv(struct hci_dev *h=
dev,
>          */
>         boot_param =3D 0x00000000;
>
> +       /* In case of PCIe, this function might get called multiple times=
 with
> +        * same hdev instance if there is any error on firmware download.
> +        * Need to clear stale bits of previous firmware download attempt=
.
> +        */
> +       for (int i =3D 0; i < __INTEL_NUM_FLAGS; i++)
> +               btintel_clear_flag(hdev, i);
> +
>         btintel_set_flag(hdev, INTEL_BOOTLOADER);
>
>         err =3D btintel_prepare_fw_download_tlv(hdev, ver, &boot_param);
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index cff3e7afdff9..a525c15c47b0 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -75,24 +75,6 @@ static inline void ipc_print_urbd1(struct hci_dev *hde=
v, struct urbd1 *urbd1,
>                    index, urbd1->frbd_tag, urbd1->status, urbd1->fixed);
>  }
>
> -static int btintel_pcie_poll_bit(struct btintel_pcie_data *data, u32 off=
set,
> -                                u32 bits, u32 mask, int timeout_us)
> -{
> -       int t =3D 0;
> -       u32 reg;
> -
> -       do {
> -               reg =3D btintel_pcie_rd_reg32(data, offset);
> -
> -               if ((reg & mask) =3D=3D (bits & mask))
> -                       return t;
> -               udelay(POLL_INTERVAL_US);
> -               t +=3D POLL_INTERVAL_US;
> -       } while (t < timeout_us);
> -
> -       return -ETIMEDOUT;
> -}
> -
>  static struct btintel_pcie_data *btintel_pcie_get_data(struct msix_entry=
 *entry)
>  {
>         u8 queue =3D entry->entry;
> @@ -248,10 +230,47 @@ static void btintel_pcie_reset_ia(struct btintel_pc=
ie_data *data)
>         memset(data->ia.cr_tia, 0, sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES)=
;
>  }
>
> -static void btintel_pcie_reset_bt(struct btintel_pcie_data *data)
> +static int btintel_pcie_reset_bt(struct btintel_pcie_data *data)
>  {
> -       btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG,
> -                             BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET);
> +       u32 reg;
> +       int retry =3D 3;
> +
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_RE=
G);
> +
> +       reg &=3D ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_ENA |
> +                       BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT |
> +                       BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT);
> +       reg |=3D BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_DISCON;
> +
> +       btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
> +
> +       do {
> +               reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC=
_CTRL_REG);
> +               if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_STS)
> +                       break;
> +               usleep_range(10000, 12000);
> +
> +       } while (--retry > 0);
> +       usleep_range(10000, 12000);
> +
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_RE=
G);
> +
> +       reg &=3D ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_ENA |
> +                       BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT |
> +                       BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT);
> +       reg |=3D BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET;
> +       btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
> +       usleep_range(10000, 12000);
> +
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_RE=
G);
> +       bt_dev_dbg(data->hdev, "csr register after reset: 0x%8.8x", reg);
> +
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_BOOT_STAGE_R=
EG);
> +
> +       /* If shared hardware reset is success then boot stage register s=
hall be
> +        * set to 0
> +        */
> +       return reg =3D=3D 0 ? 0 : -ENODEV;
>  }
>
>  /* This function enables BT function by setting BTINTEL_PCIE_CSR_FUNC_CT=
RL_MAC_INIT bit in
> @@ -263,6 +282,7 @@ static void btintel_pcie_reset_bt(struct btintel_pcie=
_data *data)
>  static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
>  {
>         int err;
> +       u32 reg;
>
>         data->gp0_received =3D false;
>
> @@ -278,22 +298,17 @@ static int btintel_pcie_enable_bt(struct btintel_pc=
ie_data *data)
>         data->boot_stage_cache =3D 0x0;
>
>         /* Set MAC_INIT bit to start primary bootloader */
> -       btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
> +       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_RE=
G);
> +       reg &=3D ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
> +                       BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_DISCON |
> +                       BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET);
> +       reg |=3D (BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_ENA |
> +                       BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT);
>
> -       btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG,
> -                                 BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT);
> -
> -       /* Wait until MAC_ACCESS is granted */
> -       err =3D btintel_pcie_poll_bit(data, BTINTEL_PCIE_CSR_FUNC_CTRL_RE=
G,
> -                                   BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS=
_STS,
> -                                   BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS=
_STS,
> -                                   BTINTEL_DEFAULT_MAC_ACCESS_TIMEOUT_US=
);
> -       if (err < 0)
> -               return -ENODEV;
> +       btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
>
>         /* MAC is ready. Enable BT FUNC */
>         btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG,
> -                                 BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_ENA |
>                                   BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT);
>
>         btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
> @@ -1376,7 +1391,7 @@ static void btintel_pcie_release_hdev(struct btinte=
l_pcie_data *data)
>         data->hdev =3D NULL;
>  }
>
> -static int btintel_pcie_setup(struct hci_dev *hdev)
> +static int btintel_pcie_setup_internal(struct hci_dev *hdev)
>  {
>         const u8 param[1] =3D { 0xFF };
>         struct intel_version_tlv ver_tlv;
> @@ -1467,6 +1482,32 @@ static int btintel_pcie_setup(struct hci_dev *hdev=
)
>         return err;
>  }
>
> +static int btintel_pcie_setup(struct hci_dev *hdev)
> +{
> +       int err, fw_dl_retry =3D 0;
> +       struct btintel_pcie_data *data =3D hci_get_drvdata(hdev);
> +
> +       while ((err =3D btintel_pcie_setup_internal(hdev)) && fw_dl_retry=
++ < 5) {
> +               bt_dev_err(hdev, "Firmware download retry count: %d",
> +                          fw_dl_retry);
> +               err =3D btintel_pcie_reset_bt(data);
> +               if (err) {
> +                       bt_dev_err(hdev, "Failed to do shr reset: %d", er=
r);
> +                       break;
> +               }
> +               usleep_range(10000, 12000);
> +               btintel_pcie_reset_ia(data);
> +               btintel_pcie_config_msix(data);
> +               err =3D btintel_pcie_enable_bt(data);
> +               if (err) {
> +                       bt_dev_err(hdev, "Failed to enable hardware: %d",=
 err);
> +                       break;
> +               }
> +               btintel_pcie_start_rx(data);
> +       }
> +       return err;
> +}
> +
>  static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
>  {
>         int err;
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel=
_pcie.h
> index 8b7824ad005a..f9aada0543c4 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -23,6 +23,8 @@
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT            (BIT(6))
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT           (BIT(7))
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS      (BIT(20))
> +#define BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_STS      (BIT(28))
> +#define BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_DISCON   (BIT(29))
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET            (BIT(31))
>
>  /* Value for BTINTEL_PCIE_CSR_BOOT_STAGE register */
> --
> 2.40.1
>
>


--=20
Luiz Augusto von Dentz
