Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA5390615
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919026; cv=pass; b=dXdKhAUsRgNrKPw72MKX4z8rWuMNHfFLSWa05cXQCT6XZHOfaSjROJC7IMvMKoy/hadv4t2MKxePXgy3h/a75EdKOdnYSZAqROmc1GfbR1H8zGfZaXG42t49kJGspPvblSxNH0JaHmB+Ax5StQjFAZp2yz9XD/aSfpuSawojjRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919026; c=relaxed/simple;
	bh=UPoRJHRGXfuoVslXMljSZcqX7KniyHy2YozLsV4EO48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBKyvXxlgk30bh9SKLkcTAh2KnRs9crIzm/KY7XsmI04TbipLcbf0K5mIt+lok4pe094c7jvdBd38X2WLn3mmiG4UMFrE1vDnTAJyU8NpZrJv6GHqOZY+xfhIbOgvX6prBf/cVjLY6v44TvKTE0hIcnJjdZhGU/ZcoUAJTvf6JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9QmLai9; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9QmLai9"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6793ff3d53dso2637143d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 12:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791919021; cv=none;
        d=google.com; s=arc-20260327;
        b=A7tcl+vwxZtYygIiJXCgacZSqvkmGi/3ZuEV7Xv/6Ix6oqDjwslHUHfHT6yfJDf8n4
         Yqk/60x+be/Buu8+WoOPoWgVX6RPFecgoZLa4+OOJ6V3dpuWqrAsPjiCLiwkE2HRNDrn
         xsNeIKOm4974kpRR9rfkAmYVg/OAONXKLb6MGuO7BjMSrHM+hIllYmIgZq/ORpQ3sgAR
         o8mcZIAd8EPmqXoPMHbz7hSKla4eq8NX1YvfiiOwEPLkdtM0Fd+4CWY+gDke56xnaF7u
         VNR2nAoejuO/LPxSk52rq36qsEbiHe9TozE55W9lRXKIrIdEd9uBNy/pmuBGhj2dgUhj
         DpGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s66ELT6EZxL+jZhurEsVo618WwtudQ9B3QiJ1JdG7yw=;
        fh=7JbCnhKSsYs7hy5E1fIgeFzYx0OGrGkdbpqWufMz8GM=;
        b=fxg1LpsYxOOfiu+w3AJ8pmgBClfhzCDYP2t3Mu6L/VeZQHVU01Lrq9up9/wQljM9gp
         zwpHujV39kV2jpDpPCJ+s3txXvz8L/3cvrnKsewB7uej512AJsPBCd3xjYjvldrmSn57
         FDXnlQ60JGyPhEnd7JeMBAO0QPo9BeOo/lm5iYtX/7luPzlhbADN2WU35je19+/OyKrm
         ClAxgq973NUXsf7+nBMNcD6aI/XAt7qPSakD7/CTLg6v9VT41SnApg9Zus7v6xdHCSH9
         tSuuk7zSQjeuZf7cnx5pBK3DBIngE2a/zGg8A7jUpYXtMtVTQqOglFiXEJah8ckhCz8r
         5qhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791919021; x=1792523821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s66ELT6EZxL+jZhurEsVo618WwtudQ9B3QiJ1JdG7yw=;
        b=F9QmLai92uVtXciG83o5bnkwbbzFawIGL86hJzizWKee8nOEnCLQV6Ml+USbO5THlz
         zC8M8Ne5MV2eR0zXLCczzDEC6tRAT7L0z8gpWhGu3c7FP/M2DSRNfMdMlYtPyOqkG7Uk
         QauosjxvrHRURXmX+BagVkDlXXCibl2w9GDN9uXjcKovJby7RxHBgUrzvmGPDn5jktyx
         dlliTAwnDsuk6ARXVtRjDrLsR9rH0jTc4B0ggGvmdyo3nZXFwHWr8q1wtWi4uuAe7HOi
         GlW7oRD18Y+cz20rX1X+GrUALvYhgL7xsAtLvFuX79TdLGH17zHTE/lBFHgxoDSgqQfP
         nHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791919021; x=1792523821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s66ELT6EZxL+jZhurEsVo618WwtudQ9B3QiJ1JdG7yw=;
        b=KkYDxAAueBTT3CmYHoDPlH7VQxJmeCgYv7EK4UgjIJaAmi92i9JJP92BzI1ZZwujCZ
         9W4AnBj+EbvzUpN3mGAm8XKe9xkoBp3lSCS+HIz3MO3AAORRgcUJHlk0wOHztaffON0X
         VBvYApOV8ViGBOBVnqv1OK0wiLdfE/ND7nMEQEw+5Sh234PDDxb+nfu9x4zYrPgExg8P
         v3Pp/JTkZdCoBIbPrwh/bX1Wali/F8YNQeX5mWWXfLydAORn+dz+PGSUw3SFW0qit+Wl
         bN/AhsNVClLVZFFeiiygEetS669KjTjiJU6gBPilSSwwN+7S3bnasmFYG3tVAf/CsH3m
         RQRQ==
X-Gm-Message-State: AFq9FYI+9Hez0ZoKbr6406PBLbkf2Eq4D1GRm+Jq9CMT6xHMbcNlzUA+
	U4i0ZWq7Fq72N5XJ7CFJrIuNx/Ole4izshmbzsXLhYXFe5TZvCm5xiDFK2x/pB932RvnHcMsaQD
	oHAymdWokfRQ0PIsiHSyD7gMi4/22il8=
X-Gm-Gg: AYBFou19mXPzcyhsOjO/IUHzCSCM5fGvJm3UtSGJAGle0zHGilZNxf5hh7yjXl52mAZ
	3O90WuKaYA/BhBoLYmwW4Xpz9mDzEwM68yfvw1UACSHzG6qNvFpXWM0w35/xTKuu4IS36la0o1B
	+KgIWn7e7JsWVQ3Nl78lyhp3DbpHSr6nQycjxWEJYWAlDKxhTK1bg0NooWS5c5GyE10V0P33HHz
	yM4+JXw7LV3Q7mlGDolmSrLVPQderDYcspypWqXEYYnNHvE1WurnjJ69khJvzIvcFfH7Zn7rHGe
	7DVsuxyBKlVZGPstz7RvBEkJbosMD+1MCcLk8AxlJLUqJO2apsEx8G4sS1lW4TQmK86pi4dk0UL
	6CipnnOM2l6h/BX0DHPdi3CsI4LqVuXdrOztXLgs=
X-Received: by 2002:a05:690c:f02:b0:896:5874:6d0a with SMTP id
 00721157ae682-8b07eddcd70mr41771987b3.40.1791919021368; Tue, 13 Oct 2026
 12:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013182627.81957-1-ajay.k.v@intel.com>
In-Reply-To: <20261013182627.81957-1-ajay.k.v@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 13 Oct 2026 15:16:48 -0400
X-Gm-Features: AclHuK8Zaly0SCPtdFP4VkjPv0IgbUO2uUhzgZHLggsWuzCcNNcVSrdWKYtJb5k
Message-ID: <CABBYNZLgOHiL77ZQEXEnX=JuXeVGa_LFAuz4q3tjPhuazWyiZw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] Bluetooth: btintel_pcie: Add initial YoYo debug support
To: Ajay KV <ajay.k.v@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com, 
	kiran.k@intel.com, linux-kernel@vger.kernel.org, marcel@holtmann.org, 
	stable@vger.kernel.org, chethan.tumkur.narayan@intel.com, 
	lakshmipathi.k@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ajay,

On Tue, Oct 13, 2026 at 2:26=E2=80=AFPM Ajay KV <ajay.k.v@intel.com> wrote:
>
> From: Ajaykv <ajay.k.v@intel.com>
>
> Add an optional YoYo firmware configuration path to the Intel PCIe
> Bluetooth driver. Read DBG_PATH and ENABLE_INI from
> ibt_bt_dbg_cfg.ini, and load intel/ibt_debug_yoyo.bin only when YoYo
> is enabled and host DRAM routing is selected.
>
> Introduce a runtime context and bounded TLV-stream validation helper.
> Initialize and clean up the context with PCI probe and removal, while
> falling back to legacy debug behavior if optional YoYo data is missing
> or invalid.
>
> Runtime validation of the complete P1-P3 series produced:
> [    3.286504] Bluetooth: Core ver 2.22
> [    3.297359] Bluetooth: HCI device and connection manager initialized
> [    3.297373] Bluetooth: HCI socket layer initialized
> [    3.297376] Bluetooth: L2CAP socket layer initialized
> [    3.297384] Bluetooth: SCO socket layer initialized
> [    3.332848] Bluetooth: YoYo: configuration loaded and validated
> [3.360857-3.361712] Bluetooth: DBGC1-3: each 16 x 256 KiB (4 MiB)
> [3.361715] Bluetooth: MDBGC DBGC1-3: each 16 x 256 KiB
> [    3.397439] Bluetooth: hci0: Device revision is 0
> [    3.397442] Bluetooth: hci0: Secure boot is enabled
> [    3.397443] Bluetooth: hci0: OTP lock is disabled
> [    3.397444] Bluetooth: hci0: API lock is enabled
> [    3.397444] Bluetooth: hci0: Debug lock is disabled
>
> Signed-off-by: Ajaykv <ajay.k.v@intel.com>
>
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index d5eb2568af2e..7d933755b291 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -14,7 +14,7 @@ obj-$(CONFIG_BT_HCIBTUSB)     +=3D btusb.o
>  obj-$(CONFIG_BT_HCIBTSDIO)     +=3D btsdio.o
>
>  obj-$(CONFIG_BT_INTEL)         +=3D btintel.o
> -obj-$(CONFIG_BT_INTEL_PCIE)    +=3D btintel_pcie.o btintel.o
> +obj-$(CONFIG_BT_INTEL_PCIE)    +=3D btintel_pcie.o btintel.o btintel_pci=
e_debug.o
>  obj-$(CONFIG_BT_ATH3K)         +=3D ath3k.o
>  obj-$(CONFIG_BT_MRVL)          +=3D btmrvl.o
>  obj-$(CONFIG_BT_MRVL_SDIO)     +=3D btmrvl_sdio.o
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 3a555aa50c87..e28f527d6d29 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -203,6 +203,103 @@ static inline bool btintel_pcie_dbg_to_wifi(struct =
btintel_pcie_data *data)
>         return data->dbg_path_cache !=3D BTINTEL_PCIE_DRAM;
>  }
>
> +/* Name of the optional INI file used to override the default dbg_path
> + * (data->dbg_path_cache) and yoyo ini settings.
> + */
> +#define BTINTEL_PCIE_DBG_INI_FILE "ibt_bt_dbg_cfg.ini"
> +
> +/* Loads optional "DBG_PATH=3D<value>" and ENABLE_INI=3D<value>
> + * overrides from BTINTEL_PCIE_DBG_INI_FILE
> + * and applies them to data->dbg_path_cache and data->enable_ini.
> + *
> + * DBG_PATH accepts BTINTEL_PCIE_WIFI_DBGC (0x06, default) and
> + * BTINTEL_PCIE_DRAM (0x01, legacy); an invalid or missing entry leaves
> + * the cached value set by the caller unchanged.
> + *
> + * ENABLE_INI accepts 1 (enabled) or 0 (disabled); an invalid or missing
> + * entry leaves data->enable_ini unchanged.
> + */
> +static void btintel_pcie_load_dbg_path_from_ini(struct btintel_pcie_data=
 *data)
> +{
> +       const struct firmware *fw;
> +       const char *ini_file =3D BTINTEL_PCIE_DBG_INI_FILE;
> +       char *buf, *cursor, *line;
> +       bool dbg_path_applied =3D false;
> +       int err;
> +
> +       err =3D request_firmware_direct(&fw, ini_file, &data->pdev->dev);
> +       if (err < 0) {
> +               BT_ERR("%s not found (%d), using dbg_path=3D0x%02x ",
> +                      ini_file, err, data->dbg_path_cache);
> +               return;
> +       }
> +
> +       buf =3D kmemdup_nul(fw->data, fw->size, GFP_KERNEL);
> +       release_firmware(fw);
> +       if (!buf)
> +               return;
> +
> +       cursor =3D buf;
> +       while ((line =3D strsep(&cursor, "\n"))) {
> +               char *eq;
> +               char *val;
> +               uint parsed;
> +
> +               line =3D strim(line);
> +               if (!line[0] || line[0] =3D=3D '#' || line[0] =3D=3D ';')
> +                       continue;
> +
> +               eq =3D strchr(line, '=3D');
> +               if (!eq)
> +                       continue;
> +
> +               *eq =3D '\0';
> +               line =3D strim(line);
> +               val =3D strim(eq + 1);
> +
> +               /* Accept "DBG_PATH"/"dbg_path"
> +                * case-insensitively as the key.
> +                */
> +               if (!strcasecmp(line, "DBG_PATH")) {
> +                       BT_INFO("Read DBG_PATH from %s: '%s'", ini_file, =
val);
> +
> +                       /* base 0 lets kstrtouint accept "0x06", "6", etc=
. */
> +                       if (kstrtouint(val, 0, &parsed) =3D=3D 0 &&
> +                           (parsed =3D=3D BTINTEL_PCIE_DRAM ||
> +                            parsed =3D=3D BTINTEL_PCIE_WIFI_DBGC)) {
> +                               data->dbg_path_cache =3D parsed;
> +                               dbg_path_applied =3D true;
> +                               BT_INFO("WRT dbg_path accepted: 0x%02x",
> +                                       data->dbg_path_cache);
> +                       } else {
> +                               BT_ERR("Invalid DBG_PATH=3D'%s' in %s, us=
ing dbg_path=3D0x%02x",
> +                                      val, ini_file, data->dbg_path_cach=
e);
> +                       }
> +               } else if (!strcasecmp(line, "ENABLE_INI")) {
> +                       BT_INFO("Read ENABLE_INI from %s: '%s'", ini_file=
, val);
> +
> +                       if (kstrtouint(val, 0, &parsed) =3D=3D 0 &&
> +                           (parsed =3D=3D 0 || parsed =3D=3D 1)) {
> +                               data->enable_ini =3D !!parsed;
> +                               BT_INFO("WRT enable_ini accepted: %u",
> +                                       data->enable_ini);
> +                       } else {
> +                               BT_ERR("Invalid ENABLE_INI=3D'%s' in %s, =
using enable_ini=3D%u",
> +                                      val, ini_file, data->enable_ini);
> +                       }
> +               }
> +       }
> +
> +       if (dbg_path_applied)
> +               BT_DBG("Loaded dbg_path=3D0x%02x from %s", data->dbg_path=
_cache, ini_file);
> +       else
> +               BT_ERR("No valid DBG_PATH in %s, dbg_path=3D0x%02x", ini_=
file, data->dbg_path_cache);
> +
> +       BT_DBG("ENABLE_INI effective state: %u", data->enable_ini);
> +
> +       kfree(buf);
> +}
> +
>  /* Helper function to allocate and setup a debug buffer group
>   * @data: driver data structure
>   * @buf: pointer to data_buf array pointer
> @@ -4097,10 +4194,25 @@ static int btintel_pcie_probe(struct pci_dev *pde=
v,
>         data->boot_stage_cache =3D 0x00;
>         data->img_resp_cache =3D 0x00;
>         data->dbg_path_cache =3D BTINTEL_PCIE_WIFI_DBGC;
> +       data->enable_ini =3D false;
> +       btintel_pcie_yoyo_init(&data->yoyo);
>         /* FLR can be invoked by echoing to debugfs path, so explicitly
>          * initialized
>          */
>         data->reset_type =3D BTINTEL_PCIE_IOSF_PRR_FLR;
> +
> +       btintel_pcie_load_dbg_path_from_ini(data);
> +       if (data->dbg_path_cache !=3D BTINTEL_PCIE_DRAM)
> +               data->enable_ini =3D false;
> +
> +       if (data->enable_ini) {
> +               err =3D btintel_pcie_yoyo_load_and_parse(&data->yoyo, &pd=
ev->dev);
> +               if (err) {
> +                       BT_WARN("YoYo is not configured (%d)", err);
> +                       btintel_pcie_yoyo_cleanup(&data->yoyo);
> +               }
> +       }
> +
>         err =3D btintel_pcie_config_pcie(pdev, data);
>         if (err)
>                 goto exit_error;
> @@ -4128,11 +4240,14 @@ static int btintel_pcie_probe(struct pci_dev *pde=
v,
>         if (err)
>                 goto exit_error;
>
> +       data->yoyo.hdev =3D data->hdev;
>         bt_dev_dbg(data->hdev, "cnvi: 0x%8.8x cnvr: 0x%8.8x", data->cnvi,
>                    data->cnvr);
>         return 0;
>
>  exit_error:
> +       btintel_pcie_yoyo_cleanup(&data->yoyo);
> +
>         /* reset device before exit */
>         btintel_pcie_reset_bt(data);
>
> @@ -4173,6 +4288,8 @@ static void btintel_pcie_remove(struct pci_dev *pde=
v)
>         if (current_work() !=3D &data->reset_work)
>                 disable_work_sync(&data->reset_work);
>
> +       btintel_pcie_yoyo_cleanup(&data->yoyo);
> +
>         btintel_pcie_disable_interrupts(data);
>
>         btintel_pcie_synchronize_irqs(data);
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel=
_pcie.h
> index 3030b4e8b750..0a4e508d0beb 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -6,6 +6,8 @@
>   *  Copyright (C) 2024  Intel Corporation
>   */
>
> +#include "btintel_pcie_debug.h"
> +
>  /* Control and Status Register(BTINTEL_PCIE_CSR) */
>  #define BTINTEL_PCIE_CSR_BASE                  (0x000)
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_REG         (BTINTEL_PCIE_CSR_BASE + =
0x024)
> @@ -737,6 +739,8 @@ struct btintel_pcie_data {
>         u32     boot_stage_cache;
>         u32     img_resp_cache;
>         u32     dbg_path_cache;
> +       bool    enable_ini;
> +       struct btintel_pcie_yoyo_ctx yoyo;
>
>         u32     cnvi;
>         u32     cnvr;
> diff --git a/drivers/bluetooth/btintel_pcie_debug.c b/drivers/bluetooth/b=
tintel_pcie_debug.c
> new file mode 100644
> index 000000000000..0e933f4ec376
> --- /dev/null
> +++ b/drivers/bluetooth/btintel_pcie_debug.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Intel Bluetooth YoYo Debug Framework
> + *
> + * Copyright (C) 2026 Intel Corporation
> + *
> + * Runtime-configurable TLV-based debug collection framework for loading=
 and
> + * parsing the optional YoYo firmware configuration used to enable debug
> + * regions, triggers, HCI commands, and configuration sets.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +#include <linux/unaligned.h>
> +#include <net/bluetooth/bluetooth.h>
> +#include "btintel_pcie_debug.h"
> +
> +/*
> + * Parse the optional YoYo firmware TLV stream and validate each record.
> + * This is the entry point for the runtime debug configuration payload.
> + */
> +static int btintel_pcie_yoyo_parse_tlv_buffer(struct btintel_pcie_yoyo_c=
tx *ctx,
> +                                             const u8 *buf, size_t buf_l=
en)
> +{
> +       const struct btintel_pcie_tlv_hdr *tlv;
> +       const u8 *ptr =3D buf;
> +       size_t remaining =3D buf_len;
> +       u32 count =3D 0;
> +
> +       while (remaining >=3D sizeof(*tlv)) {
> +               size_t tlv_size;
> +               u32 type, len;
> +
> +               tlv =3D (const struct btintel_pcie_tlv_hdr *)ptr;
> +               type =3D get_unaligned_le32(&tlv->type);
> +               len =3D get_unaligned_le32(&tlv->length);
> +
> +               if (len > remaining - sizeof(*tlv)) {
> +                       BT_ERR("YoYo: tlv %u truncated (len=3D%u rem=3D%z=
u)", count,
> +                              len, remaining);
> +                       return -EBADMSG;
> +               }
> +               tlv_size =3D sizeof(*tlv) + len;
> +
> +               switch (type) {
> +               case BTINTEL_PCIE_TLV_TYPE_DBG_INFO:
> +               case BTINTEL_PCIE_TLV_TYPE_DBG_REGION:
> +               case BTINTEL_PCIE_TLV_TYPE_DBG_TRIGGER:
> +               case BTINTEL_PCIE_TLV_TYPE_DBG_HCMD:
> +               case BTINTEL_PCIE_TLV_TYPE_DBG_CONFIG_SET:
> +               case BTINTEL_PCIE_TLV_TYPE_DBG_BUF_ALLOC:
> +               case BTINTEL_PCIE_TLV_TYPE_DBG_PRESET_OVERRIDE:
> +                       BT_DBG("YoYo: valid tlv type 0x%x len=3D%u", type=
, len);
> +                       break;
> +               default: /* Log and continue, do not fail*/
> +                       BT_DBG("YoYo: unknown tlv type 0x%x len=3D%u", ty=
pe, len);
> +                       break;
> +               }
> +
> +               ptr +=3D tlv_size;
> +               remaining -=3D tlv_size;
> +               count++;
> +       }
> +
> +       /* If no TLVs were parsed, the YoYo binary is considered invalid =
*/
> +       if (remaining || count =3D=3D 0) {
> +               BT_ERR("YoYo: trailing %zu bytes after tlv stream", remai=
ning);
> +               return -EBADMSG;
> +       }
> +
> +       BT_DBG("YoYo: parsed %u tlv's", count);
> +       return 0;
> +}
> +
> +/**
> + * btintel_yoyo_init - Initialize the YoYo context
> + * @ctx:   Pre-allocated context (typically embedded in driver data)
> + */
> +int btintel_pcie_yoyo_init(struct btintel_pcie_yoyo_ctx *ctx)
> +{
> +       if (!ctx)
> +               return -EINVAL;
> +
> +       memset(ctx, 0, sizeof(*ctx));
> +       INIT_LIST_HEAD(&ctx->region_list);
> +       INIT_LIST_HEAD(&ctx->trigger_list);
> +       INIT_LIST_HEAD(&ctx->hcmd_list);
> +       INIT_LIST_HEAD(&ctx->config_set_list);
> +
> +       /* set it to true after successful TLV parsing */
> +       ctx->enabled =3D false;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_init);
> +
> +/**
> + * btintel_yoyo_cleanup - Clean up the YoYo context
> + * @ctx:  YoYo context to clean up
> + */
> +void btintel_pcie_yoyo_cleanup(struct btintel_pcie_yoyo_ctx *ctx)
> +{
> +       if (!ctx)
> +               return;
> +
> +       ctx->enabled =3D false;
> +}
> +EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_cleanup);
> +
> +/**
> + * btintel_yoyo_load_and_parse - Load ibt_debug_yoyo.bin and parse TLVs
> + * @ctx:  Initialized YoYo context
> + * @dev:  Device for firmware loading (typically &pdev->dev)
> + *
> + * Uses request_firmware_direct, since the YoYo binary
> + * is optional. On success, sets ctx->enabled.
> + */
> +int btintel_pcie_yoyo_load_and_parse(struct btintel_pcie_yoyo_ctx *ctx,
> +                                    struct device *dev)
> +{
> +       const struct firmware *fw;
> +       int ret;
> +
> +       if (!ctx)
> +               return -EINVAL;
> +
> +       ret =3D request_firmware_direct(&fw, BTINTEL_PCIE_YOYO_FW_NAME, d=
ev);
> +       if (ret) {
> +               BT_WARN("YoYo: failed to load %s (%d)",
> +                       BTINTEL_PCIE_YOYO_FW_NAME, ret);
> +               return ret;
> +       }
> +
> +       /* Sanity check firmware size */
> +       if (fw->size < sizeof(struct btintel_pcie_tlv_hdr)) {
> +               release_firmware(fw);
> +               return -EBADMSG;
> +       }
> +
> +       BT_DBG("YoYo: loaded %s (%zu bytes)", BTINTEL_PCIE_YOYO_FW_NAME,
> +              fw->size);
> +
> +       ret =3D btintel_pcie_yoyo_parse_tlv_buffer(ctx, fw->data, fw->siz=
e);
> +       release_firmware(fw);
> +
> +       /* File Corruption / TLV validation failed */
> +       if (ret) {
> +               BT_ERR("YoYo: tlv parsing failed (%d)", ret);
> +               return ret;
> +       }
> +
> +       ctx->enabled =3D true;
> +
> +       BT_INFO("YoYo: feature enabled and configured");
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(btintel_pcie_yoyo_load_and_parse);
> +
> +MODULE_DESCRIPTION("Intel Bluetooth yoyo debug framework");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/bluetooth/btintel_pcie_debug.h b/drivers/bluetooth/b=
tintel_pcie_debug.h
> new file mode 100644
> index 000000000000..b0b94c2a169d
> --- /dev/null
> +++ b/drivers/bluetooth/btintel_pcie_debug.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Intel Bluetooth YoYo Debug Framework
> + *
> + * Copyright (C) 2026 Intel Corporation
> + *
> + */
> +
> +#ifndef __BTINTEL_PCIE_DEBUG_H__
> +#define __BTINTEL_PCIE_DEBUG_H__
> +
> +#include <linux/list.h>
> +#include <linux/types.h>
> +#include <linux/device.h>
> +#include <linux/firmware.h>
> +
> +/* External YoYo binary file */
> +#define BTINTEL_PCIE_YOYO_FW_NAME      "intel/ibt_debug_yoyo.bin"
> +
> +/* TLV type codes */
> +#define BTINTEL_PCIE_TLV_TYPE_DBG_INFO         0x1000005
> +#define BTINTEL_PCIE_TLV_TYPE_DBG_BUF_ALLOC            0x1000006
> +#define BTINTEL_PCIE_TLV_TYPE_DBG_HCMD         0x1000007
> +#define BTINTEL_PCIE_TLV_TYPE_DBG_REGION               0x1000008
> +#define BTINTEL_PCIE_TLV_TYPE_DBG_TRIGGER              0x1000009
> +#define BTINTEL_PCIE_TLV_TYPE_DBG_CONFIG_SET           0x100000A
> +#define BTINTEL_PCIE_TLV_TYPE_DBG_PRESET_OVERRIDE      0x100000B
> +
> +/* TLV header */
> +struct btintel_pcie_tlv_hdr {
> +       __le32 type;
> +       __le32 length;
> +} __packed;
> +
> +/* Debug header common to all debug TLVs */
> +struct btintel_pcie_dbg_hdr {
> +       __le32 tlv_data_version;
> +       __le32 domain;
> +} __packed;
> +
> +/* Address/value pair */
> +struct btintel_pcie_addr_value {
> +       __le32 address;
> +       __le32 value;
> +} __packed;
> +
> +/*
> + * struct btintel_pcie_yoyo_ctx- Runtime state for YoYo debug configurat=
ion
> + * @enabled: Whether the loaded YoYo configuration passed validation
> + * @region_list: Parsed debug-region entries
> + * @trigger_list: Parsed debug-trigger entries
> + * @hcmd_list: Parsed HCI command entries
> + * @config_set_list: Parsed configuration-set entries
> + * @hdev: Associated HCI device; NULL until successful HCI registration
> + *
> + * Stores the validation state and parsed TLV data for the optional YoYo
> + * firmware configuration.
> + */
> +struct btintel_pcie_yoyo_ctx {
> +       bool                     enabled;
> +
> +       struct list_head         region_list;
> +       struct list_head         trigger_list;
> +       struct list_head         hcmd_list;
> +       struct list_head         config_set_list;
> +
> +       struct hci_dev           *hdev;
> +};
> +
> +int  btintel_pcie_yoyo_init(struct btintel_pcie_yoyo_ctx *ctx);
> +void btintel_pcie_yoyo_cleanup(struct btintel_pcie_yoyo_ctx *ctx);
> +
> +/* Load and parse the external .bin file */
> +int  btintel_pcie_yoyo_load_and_parse(struct btintel_pcie_yoyo_ctx *ctx,
> +                                     struct device *dev);
> +
> +#endif /* __BTINTEL_PCIE_DEBUG_H__ */
> --
> 2.53.0

There are quite a few issues flagged by sashiko:

https://sashiko.dev/#/patchset/20261013104416.26143-1-ajay.k.v%40intel.com

--=20
Luiz Augusto von Dentz
