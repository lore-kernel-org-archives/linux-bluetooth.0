Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8EC569F2B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884366; cv=pass; b=Qr7btYF4q+3FGoCSgusx/p+L+j7r4e7Bc+KH3J0YOwlvTB+6O2Ag40KSq2yOy6j+sCyzI13Ky27lALU5w4NGnFY5G1eZ8A7A7A7weAltsOFkrBaQqxMxEfO2TSul6d4cGCxErUoFvsuRy8Y65WzuuOSBmeG1euO7WOC9dEp8wNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884366; c=relaxed/simple;
	bh=dsNy5E62ndz3h+qbuS7nYprWDjwraJSA2yBtmDeb7Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDJKh78LEnDSJYtjMaUvN3p+QuXEXNplPIi/l5fFuQAJ2yecoXGcoc00YQpdJe4K9UrWPwO8tv27c5usW/Rf+/cNbDeHCZI9IN9zpAlCK5DbAKENREKIG8PlEYamr0YYzOWeKvb9uZETqXdD0QteXh2ptLZKvCbXKyxlD/ahYQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx1MSBmO; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx1MSBmO"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-871c8a36fe3so52025807b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 09:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788884362; cv=none;
        d=google.com; s=arc-20260327;
        b=F8p57ZHMhzSY9Ohraabdtluf6VzzUp52tkBGUVDq37A2gVaITIiJNQKr1Pm+uH/oF3
         xYrs/d+j+ScatQUI37MOqIY8zfdQGzYElFEmEmRj3ZImSm8lVb2ngiw/KaQAxZddKRnD
         gFQepC9/I09nuaCUOTlGPSdgaZ6WgMCIp61+l9Mu4H9w4zqLAK6TBW76yHeWO4+IfiHD
         dXobTL5lzdWH4JX1jcNHZwaFXJxrpAWQbYW3QlnzEOpPfHRhp3CkPXjYnHhr3OyWtQ3x
         uMkiZITgTC9SOKIB92LEml/MRZ8DIUOnxOg3BmaZrjGlmTpYrX4bSIWqnV1m7PAVfXrj
         mc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A1Olkt78fx/PgEAric9aCqTfcglqhobDjWfWKPKtMEQ=;
        fh=v8qNITDVk4dy6uNt6vzYRG/gT/akNm2p3lhHuf44k9k=;
        b=VW1+bq5XoyGWSvSWpKo5PhAQG+DuQnJFAw2ftL5491U100iF8/jAB+RjFn6j7z1AZQ
         vfbnXF2EOyz99wnjRDnizb2l7q65BCnMO//G/DDDV2FvT5TC88EYOUGwX5tUITMMa8m9
         cxrbOLNlJ/1RPyi/EevWew20J/eZZ0Qus7YZVQXaMbqejK66Ao8fPY8uRxF+bCWi7v4Q
         ZnJ+55+RZjV+cCdCG6GcN7faG0wh0ywRSVrFRqhrZZOpSzc1d2zU+fbMFRtAYfZ8Wdyf
         nD3rfY7P/ghpwm63PrcvaT24Vu9ujsAXcX/rSyEtOiyWl33ZgbuyjuEr3XAc8XYJ5VJ9
         iiAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788884362; x=1789489162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A1Olkt78fx/PgEAric9aCqTfcglqhobDjWfWKPKtMEQ=;
        b=Mx1MSBmOpNyKKN3dYWu1qI5atjRwjEiHxJF3N75OvDItodH/jhkFhQRkhedHtNdMob
         vlehsMPdPrbzyq5/iw30oBGjlkpccrZPToALgiTFtV4afH4HVzG8a9Q+kIQQgsA4oziN
         fLCUhupqfU9hoY9RKQcSs4wWPJ9pvHG88RHApcuKDlz1J2CrAVgQansilGXLOENE4TID
         BKUVyt4uoGfPhxrMI6rTtbNmk+qXyucsRkl9x+wgHPctoWFL++1rZoy2xYxMahNK894Y
         2h5xaj0Bh5cF82nxUVKeQUI6vfSu2d48qov0aeuuQ68lNGcblpZtqRsmBcLaYD5NnZ+F
         doLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788884362; x=1789489162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A1Olkt78fx/PgEAric9aCqTfcglqhobDjWfWKPKtMEQ=;
        b=Nrm6BUsxqz20SCGQwRvH8ssTL+0qIBzBvW35M239od8y+hN2Q1NTsvqSSbVa3PIrUB
         5kCIUQ0SIqQRYkZtZxEKpqL6tkThXCEZAXh5djdMsRGVeH6Z8815TcDaUZpmysjf9aes
         aDtNlKqkTuk11iIClEVt+nDKCPM7WcII6mE2cVZP6qvEzlKStcMP8xJF+s/+R5//AJpi
         td948/Xw/9cDoLCg5IRlklkJz7e9a9Ojah9NrcyHer7erzsOvEsPQeM9KmBKd++yGCF/
         G2Hy/+t5BhT58UgWoQfs1+ir3t2y86iD7Kbgc+GpBceMFTW5slp5KT+5WwfLNM6nt9wP
         KroQ==
X-Forwarded-Encrypted: i=1; AKwUvByBGXvTcDIx36hr6QNcylcfDu1dBlNHOPO62tt3vRZjHXNK6BnOwAQW9qcT+P53rsBHVeXPNZFYZR4FsIqLQrQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mkCQyYfVuyX3N8EwoTABLlelOv3y5k5s1NbXfA1eEd7ICiMyJg
	j9YBlDXwGRlPdxoB+33S+ZmD8fLwg5A58ghtb9i/wZStzzTrbxP+Qn3aiRWBfyMHa2FXrTgwpAx
	gLyCkagHCaL+lmog5wpw1gy0BfR+oGU0P6CQagCDqnA==
X-Gm-Gg: AYBFou1oeDL4RkFrY75QHdOJ0V6jEilehFZp6NdLDIjZAn9jk9z7Qgwk2xElvG2t3Dm
	ZH5+Nx3hP9JK3OJdcJbPj+NnPzrWgdbmywZ7KT6Sn0Vwc3DvIQdjofGwnph0/85PkL4inM27Dtl
	8PVUqBJfJ9bSb+x9mZgCP36V6gtyt15s6eMpYfWKga9uWjmqplIUOBxLHSroS0jgxsPSvx9XKNe
	WzAIH4tlFNxK0XOe5lQmOZmJIlnJqTa8rlnV6A5p+kI/KBV2jBCABzCVsir22PHAz5oXw/5qy8R
	qZJf5rEKBIHag+ZFZKDY5n20QlT9sJn8nM3SDqXJ6RPkCeSa+qnpy55qg6mE1rZUEek/FdXmtB1
	pdzzYPQLX63Jzv35pGzkUim63mJKPDJQoB76I8qotrg==
X-Received: by 2002:a05:690c:d91:b0:873:5bb2:6c1c with SMTP id
 00721157ae682-8735bb26f86mr82656857b3.35.1788884361631; Tue, 08 Sep 2026
 09:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908075517.661675-1-hildawu@realtek.com>
In-Reply-To: <20260908075517.661675-1-hildawu@realtek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Sep 2026 12:19:08 -0400
X-Gm-Features: AcwNN1XP5ZeB1ND29AvPiXAoFETj_wqWxWscHYE8Bzndl-FDs_ENYrY_X__EnXk
Message-ID: <CABBYNZJ3rt9J8PS7w7XAWPZrhL61usnCBqQSJdWdbst9rmDD8g@mail.gmail.com>
Subject: Re: [RESEND PATCH v7] Bluetooth: btrtl: Add firmware format v3 support
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex_lu@realsil.com.cn, 
	jason_mao@realsil.com.cn, zoey_zhou@realsil.com.cn, max.chou@realtek.com, 
	kidman@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hilda,

On Tue, Sep 8, 2026 at 3:55=E2=80=AFAM Hilda Wu <hildawu@realtek.com> wrote=
:
>
> Realtek has introduced a new Bluetooth firmware format, firmware
> format v3. This is a Realtek-internal specification; the format
> differences from v2 are documented inline in this patch.
>
> This patch extends the btrtl driver to recognize and parse the new v3
> file format, including:
> - New signature string and subsection ID definitions
> - Extension of btrtl_device_info to store v3-specific metadata
> - Logic to extract and load firmware data out of v3
> - Maintains compatibility with the existing v2 firmware format
>
> The RTL8922D is the first IC to use firmware format v3. The firmware
> binary (rtl8922du_fw.bin) payload is approximately 267 KB (0x40a7c
> bytes), and on a typical boot the full sequence from rtl_load_file() to
> rtl_finalize_download() completing takes average ~483 ms.
>
> The following is RTL8922D log as expected fw format v3 output:
>
> [    1.838104] Bluetooth: btrtl_read_chip_id() hci0: RTL: chip_id status=
=3D0x00 id=3D0x3e
> [    1.838331] Bluetooth: btrtl_initialize() hci0: RTL: examining hci_ver=
=3D0e hci_rev=3D000d lmp_ver=3D0e lmp_subver=3D8922
> [    1.838571] Bluetooth: rtl_read_rom_version() hci0: RTL: rom_version s=
tatus=3D0 version=3D0
> [    1.838821] Bluetooth: btrtl_initialize() hci0: RTL: btrtl_initialize:=
 key id 0
> [    1.838825] Bluetooth: rtl_load_file() hci0: RTL: loading rtl_bt/rtl89=
22du_fw.bin
> [    1.843021] Bluetooth: rtl_load_file() hci0: RTL: loading rtl_bt/rtl89=
22du_config.bin
> [    1.843317] Bluetooth: rtlbt_parse_firmware_v3() hci0: RTL: key id 0
> [    1.843325] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: subsection =
(f000:00), chip id 62, cut 0x01, len 0000c704
> [    1.843342] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: subsection =
version: c5900782
> [    1.843347] Bluetooth: rtlbt_parse_config() hci0: RTL: config file: rt=
l_bt/rtl8922du_config_f000.bin
> [    1.843363] Bluetooth: rtlbt_parse_config() hci0: RTL: config file: rt=
l_bt/rtl8922du_config_f000.bin not found, use default
> [    1.843366] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: subsection =
(f002:00), chip id 62, cut 0x01, len 00034378
> [    1.843417] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: subsection =
version: 2b84a8b2
> [    1.843421] Bluetooth: rtlbt_parse_config() hci0: RTL: config file: rt=
l_bt/rtl8922du_config_f002.bin
> [    1.843647] Bluetooth: rtlbt_parse_config() hci0: RTL: config file: rt=
l_bt/rtl8922du_config_f002.bin found
> [    1.843654] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: subsection =
(f000:00), chip id 62, cut 0x01, len 0000c704
> [    1.843658] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: skip, key_i=
d mismatch (1, 0)
> [    1.843661] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: subsection =
(f002:00), chip id 62, cut 0x01, len 00034378
> [    1.843664] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: skip, key_i=
d mismatch (1, 0)
> [    1.843672] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: subsection =
(f000:00), chip id 62, cut 0x01, len 0000c704
> [    1.843674] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: skip, key_i=
d mismatch (2, 0)
> [    1.843676] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: subsection =
(f002:00), chip id 62, cut 0x01, len 00034378
> [    1.843678] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: skip, key_i=
d mismatch (2, 0)
> [    1.843680] Bluetooth: rtlbt_parse_firmware_v3() hci0: RTL: firmware s=
ection payload total len: 0x00040a7c
> [    2.293192] Bluetooth: rtl_finalize_download() hci0: RTL: Watchdog res=
et status 00
> [    2.293957] Bluetooth: rtl_finalize_download() hci0: RTL: fw version 0=
x2b84a8b2
>
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> Signed-off-by: Zoey Zhou <zoey_zhou@realsil.com.cn>
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
> Resend V7:
> - Due to a CI apply failure caused by the patch being based on an
>   outdated bluetooth-next HEAD. No changes to the patch content itself
>
> V6 -> V7:
> - Fix smatch warning in btrtl_free(): move the NULL check on
>   btrtl_dev to the very beginning of the function, before any
>   dereference, instead of after it has already been dereferenced
>   multiple times (Reported by kernel test / Dan Carpenter)
> - Revise log message to use "subsection" terminology for clarity
> - Add informational message when a config file is not found
>
> V5 -> V6:
> - Add missing parentheses around the entire is_v3_fw() macro
>   expression to avoid incorrect evaluation with the logical NOT
>   operator on legacy firmware types
> - Add NULL check on ic_info->cfg_name before use in
>   rtlbt_parse_config() to avoid NULL pointer dereference when
>   a crafted firmware specifies FW_TYPE_V3_2 on legacy chips
>   without configuration
> - Add bounds check to reject patch_image_len < 4 before reading
>   the image version, preventing an out-of-bounds read
> - Propagate the return value of rtlbt_parse_config() and abort
>   parsing on failure instead of silently continuing without
>   the required configuration
> - Fix a race condition in rtl_check_download_state() by setting
>   the REALTEK_DOWNLOADING flag before issuing the check-download
>   command, instead of after, to avoid missing the completion
>   event
> - Split v3 firmware parse/download logic into new btrtl_enh.c to
>   keep btrtl.c size manageable
>
> V4 -> V5:
> - Add independent support for RTL8922D section
> - Introduce macros to improve code readability
> - Document firmware format v3 and its differences
> - Align implementation with reviewer feedback
>
> V3 -> V4:
> - Rework skb->data access and add clarifying comments
> - Fix latent issues
>
> V2 -> V3:
> - Address coccinelle warning
>
> V1 -> V2:
> - Add missing symbols
> - Resolve build warnings
> ---
> ---
>  drivers/bluetooth/Makefile    |   2 +-
>  drivers/bluetooth/btrtl.c     | 223 +++++++---
>  drivers/bluetooth/btrtl.h     | 109 ++++-
>  drivers/bluetooth/btrtl_enh.c | 811 ++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btusb.c     |   3 +
>  5 files changed, 1088 insertions(+), 60 deletions(-)
>  create mode 100644 drivers/bluetooth/btrtl_enh.c
>
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index e6b1c1180d1d..29cfbe046365 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -22,7 +22,7 @@ obj-$(CONFIG_BT_MTKSDIO)      +=3D btmtksdio.o
>  obj-$(CONFIG_BT_MTKUART)       +=3D btmtkuart.o
>  obj-$(CONFIG_BT_QCOMSMD)       +=3D btqcomsmd.o
>  obj-$(CONFIG_BT_BCM)           +=3D btbcm.o
> -obj-$(CONFIG_BT_RTL)           +=3D btrtl.o
> +obj-$(CONFIG_BT_RTL)           +=3D btrtl_enh.o btrtl.o
>  obj-$(CONFIG_BT_QCA)           +=3D btqca.o
>  obj-$(CONFIG_BT_MTK)           +=3D btmtk.o
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index d29813331603..c58eb509702b 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -22,6 +22,7 @@
>  #define RTL_CHIP_8723CS_XX     5
>  #define RTL_EPATCH_SIGNATURE   "Realtech"
>  #define RTL_EPATCH_SIGNATURE_V2        "RTBTCore"
> +#define RTL_EPATCH_SIGNATURE_V3        "BTNIC003"
>  #define RTL_ROM_LMP_8703B      0x8703
>  #define RTL_ROM_LMP_8723A      0x1200
>  #define RTL_ROM_LMP_8723B      0x8723
> @@ -33,16 +34,14 @@
>  #define RTL_ROM_LMP_8922A      0x8922
>  #define RTL_CONFIG_MAGIC       0x8723ab55
>
> -#define RTL_VSC_OP_COREDUMP    0xfcff
> -
>  #define IC_MATCH_FL_LMPSUBV    (1 << 0)
>  #define IC_MATCH_FL_HCIREV     (1 << 1)
>  #define IC_MATCH_FL_HCIVER     (1 << 2)
>  #define IC_MATCH_FL_HCIBUS     (1 << 3)
>  #define IC_MATCH_FL_CHIP_TYPE  (1 << 4)
>  #define IC_INFO(lmps, hcir, hciv, bus) \
> -       .match_flags =3D IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV | \
> -                      IC_MATCH_FL_HCIVER | IC_MATCH_FL_HCIBUS, \
> +       .match_flags =3D (IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV | \
> +                      IC_MATCH_FL_HCIVER | IC_MATCH_FL_HCIBUS), \
>         .lmp_subver =3D (lmps), \
>         .hci_rev =3D (hcir), \
>         .hci_ver =3D (hciv), \
> @@ -50,7 +49,8 @@
>
>  #define        RTL_CHIP_SUBVER (&(struct rtl_vendor_cmd) {{0x10, 0x38, 0=
x04, 0x28, 0x80}})
>  #define        RTL_CHIP_REV    (&(struct rtl_vendor_cmd) {{0x10, 0x3A, 0=
x04, 0x28, 0x80}})
> -#define        RTL_SEC_PROJ    (&(struct rtl_vendor_cmd) {{0x10, 0xA4, 0=
xAD, 0x00, 0xb0}})
> +#define        RTL_SEC_PROJ_V2    (&(struct rtl_vendor_cmd) {{0x10, 0xA4=
, 0xAD, 0x00, 0xb0}})
> +#define        RTL_SEC_PROJ_V3    (&(struct rtl_vendor_cmd) {{0x10, 0xA4=
, 0x0D, 0x01, 0xa0}})
>
>  #define RTL_PATCH_SNIPPETS             0x01
>  #define RTL_PATCH_DUMMY_HEADER         0x02
> @@ -75,34 +75,6 @@ enum btrtl_chip_id {
>         CHIP_ID_8761C =3D 51,
>  };
>
> -struct id_table {
> -       __u16 match_flags;
> -       __u16 lmp_subver;
> -       __u16 hci_rev;
> -       __u8 hci_ver;
> -       __u8 hci_bus;
> -       __u8 chip_type;
> -       bool config_needed;
> -       bool has_rom_version;
> -       bool has_msft_ext;
> -       char *fw_name;
> -       char *cfg_name;
> -       char *hw_info;
> -};
> -
> -struct btrtl_device_info {
> -       const struct id_table *ic_info;
> -       u8 rom_version;
> -       u8 *fw_data;
> -       int fw_len;
> -       u8 *cfg_data;
> -       int cfg_len;
> -       bool drop_fw;
> -       int project_id;
> -       u8 key_id;
> -       struct list_head patch_subsecs;
> -};
> -
>  static const struct id_table ic_id_table[] =3D {
>         /* 8723A */
>         { IC_INFO(RTL_ROM_LMP_8723A, 0xb, 0x6, HCI_USB),
> @@ -337,6 +309,7 @@ static const struct id_table ic_id_table[] =3D {
>           .fw_name  =3D "rtl_bt/rtl8852btu_fw",
>           .cfg_name =3D "rtl_bt/rtl8852btu_config",
>           .hw_info  =3D "rtl8852btu" },
> +
>         };
>
>  static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev=
,
> @@ -371,7 +344,34 @@ static const struct id_table *btrtl_match_ic(u16 lmp=
_subver, u16 hci_rev,
>         return &ic_id_table[i];
>  }
>
> -static struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev)
> +int btrtl_read_chip_id(struct hci_dev *hdev, u8 *chip_id)
> +{
> +       struct rtl_rp_read_chip_id *rp;
> +       struct sk_buff *skb;
> +       int ret =3D 0;
> +
> +       skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_READ_CHIP_ID, 0, NULL, HC=
I_INIT_TIMEOUT);
> +       if (IS_ERR(skb))
> +               return PTR_ERR(skb);
> +
> +       rp =3D skb_pull_data(skb, sizeof(*rp));
> +       if (!rp) {
> +               ret =3D -EIO;
> +               goto out;
> +       }
> +
> +       rtl_dev_info(hdev, "chip_id status=3D0x%02x id=3D0x%02x",
> +                    rp->status, rp->chip_id);
> +
> +       if (chip_id)
> +               *chip_id =3D rp->chip_id;
> +
> +out:
> +       kfree_skb(skb);
> +       return ret;
> +}
> +
> +struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev)
>  {
>         struct sk_buff *skb;
>
> @@ -391,14 +391,14 @@ static struct sk_buff *btrtl_read_local_version(str=
uct hci_dev *hdev)
>
>         return skb;
>  }
> +EXPORT_SYMBOL_GPL(btrtl_read_local_version);
>
>  static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
>  {
>         struct rtl_rom_version_evt *rom_version;
>         struct sk_buff *skb;
>
> -       /* Read RTL ROM version command */
> -       skb =3D __hci_cmd_sync(hdev, 0xfc6d, 0, NULL, HCI_INIT_TIMEOUT);
> +       skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_READ_ROM_VER, 0, NULL, HC=
I_INIT_TIMEOUT);
>         if (IS_ERR(skb)) {
>                 rtl_dev_err(hdev, "Read ROM version failed (%ld)",
>                             PTR_ERR(skb));
> @@ -427,7 +427,7 @@ static int btrtl_vendor_read_reg16(struct hci_dev *hd=
ev,
>         struct sk_buff *skb;
>         int err =3D 0;
>
> -       skb =3D __hci_cmd_sync(hdev, 0xfc61, sizeof(*cmd), cmd,
> +       skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_READ_VENDER, sizeof(*cmd)=
, cmd,
>                              HCI_INIT_TIMEOUT);
>         if (IS_ERR(skb)) {
>                 err =3D PTR_ERR(skb);
> @@ -449,7 +449,7 @@ static int btrtl_vendor_read_reg16(struct hci_dev *hd=
ev,
>         return 0;
>  }
>
> -static void *rtl_iov_pull_data(struct rtl_iovec *iov, u32 len)
> +void *rtl_iov_pull_data(struct rtl_iovec *iov, u32 len)
>  {
>         void *data =3D iov->data;
>
> @@ -461,6 +461,7 @@ static void *rtl_iov_pull_data(struct rtl_iovec *iov,=
 u32 len)
>
>         return data;
>  }
> +EXPORT_SYMBOL_GPL(rtl_iov_pull_data);
>
>  static void btrtl_insert_ordered_subsec(struct rtl_subsection *node,
>                                         struct btrtl_device_info *btrtl_d=
ev)
> @@ -632,6 +633,7 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hd=
ev,
>         }
>
>         *_buf =3D ptr;
> +       btrtl_dev->fw_type =3D FW_TYPE_V2;
>         return len;
>  }
>
> @@ -677,6 +679,22 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev=
,
>         if (btrtl_dev->fw_len <=3D 8)
>                 return -EINVAL;
>
> +       if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE_V3, 8)) {
> +               struct btrtl_enh_ops *ops =3D symbol_get(rtl_enh_ops);
> +               int ret;
> +
> +               if (!ops)
> +                       return -EINVAL;
> +
> +               if (ops->parse_firmware_v3)
> +                       ret =3D ops->parse_firmware_v3(hdev, btrtl_dev);
> +               else
> +                       ret =3D -EINVAL;
> +
> +               symbol_put(rtl_enh_ops);
> +               return ret;
> +       }
> +
>         if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE, 8))
>                 min_size =3D sizeof(struct rtl_epatch_header) +
>                                 sizeof(extension_sig) + 3;
> @@ -797,8 +815,8 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
>
>         BT_DBG("length=3D%x offset=3D%x index %d", patch_length, patch_of=
fset, i);
>         if (patch_length < sizeof(epatch_info->fw_version) ||
> -           patch_offset > btrtl_dev->fw_len ||
> -           patch_length > btrtl_dev->fw_len - patch_offset)
> +           check_add_overflow((size_t)patch_offset, (size_t)patch_length=
, &min_size) ||
> +           btrtl_dev->fw_len < min_size)
>                 return -EINVAL;
>
>         /* Copy the firmware into a new buffer and write the version at
> @@ -813,11 +831,12 @@ static int rtlbt_parse_firmware(struct hci_dev *hde=
v,
>         memcpy(buf + patch_length - 4, &epatch_info->fw_version, 4);
>
>         *_buf =3D buf;
> +       btrtl_dev->fw_type =3D FW_TYPE_V1;
>         return len;
>  }
>
> -static int rtl_download_firmware(struct hci_dev *hdev,
> -                                const unsigned char *data, int fw_len)
> +int rtl_download_firmware(struct hci_dev *hdev, u8 fw_type,
> +                        const unsigned char *data, int fw_len)
>  {
>         struct rtl_download_cmd *dl_cmd;
>         int frag_num =3D fw_len / RTL_FRAG_LEN + 1;
> @@ -827,6 +846,13 @@ static int rtl_download_firmware(struct hci_dev *hde=
v,
>         int j =3D 0;
>         struct sk_buff *skb;
>         struct hci_rp_read_local_version *rp;
> +       u8 dl_rp_len =3D sizeof(struct rtl_download_response);
> +
> +       if (is_v3_fw(fw_type)) {
> +               j =3D 1;
> +               if (fw_type =3D=3D FW_TYPE_V3_2)
> +                       dl_rp_len++;
> +       }
>
>         dl_cmd =3D kmalloc_obj(*dl_cmd);
>         if (!dl_cmd)
> @@ -840,15 +866,15 @@ static int rtl_download_firmware(struct hci_dev *hd=
ev,
>                         j =3D 1;
>
>                 if (i =3D=3D (frag_num - 1)) {
> -                       dl_cmd->index |=3D 0x80; /* data end */
> +                       if (!is_v3_fw(fw_type))
> +                               dl_cmd->index |=3D 0x80; /* data end */
>                         frag_len =3D fw_len % RTL_FRAG_LEN;
>                 }
>                 rtl_dev_dbg(hdev, "download fw (%d/%d). index =3D %d", i,
>                                 frag_num, dl_cmd->index);
>                 memcpy(dl_cmd->data, data, frag_len);
>
> -               /* Send download command */
> -               skb =3D __hci_cmd_sync(hdev, 0xfc20, frag_len + 1, dl_cmd=
,
> +               skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_DOWNLOAD_CMD, fra=
g_len + 1, dl_cmd,
>                                      HCI_INIT_TIMEOUT);
>                 if (IS_ERR(skb)) {
>                         rtl_dev_err(hdev, "download fw command failed (%l=
d)",
> @@ -857,7 +883,7 @@ static int rtl_download_firmware(struct hci_dev *hdev=
,
>                         goto out;
>                 }
>
> -               if (skb->len !=3D sizeof(struct rtl_download_response)) {
> +               if (skb->len !=3D dl_rp_len) {
>                         rtl_dev_err(hdev, "download fw event length misma=
tch");
>                         kfree_skb(skb);
>                         ret =3D -EIO;
> @@ -868,6 +894,9 @@ static int rtl_download_firmware(struct hci_dev *hdev=
,
>                 data +=3D RTL_FRAG_LEN;
>         }
>
> +       if (is_v3_fw(fw_type))
> +               goto out;
> +
>         skb =3D btrtl_read_local_version(hdev);
>         if (IS_ERR(skb)) {
>                 ret =3D PTR_ERR(skb);
> @@ -884,6 +913,7 @@ static int rtl_download_firmware(struct hci_dev *hdev=
,
>         kfree(dl_cmd);
>         return ret;
>  }
> +EXPORT_SYMBOL_GPL(rtl_download_firmware);
>
>  static int rtl_load_file(struct hci_dev *hdev, const char *name, u8 **bu=
ff)
>  {
> @@ -891,7 +921,7 @@ static int rtl_load_file(struct hci_dev *hdev, const =
char *name, u8 **buff)
>         int ret;
>
>         rtl_dev_info(hdev, "loading %s", name);
> -       ret =3D request_firmware(&fw, name, &hdev->dev);
> +       ret =3D firmware_request_nowarn(&fw, name, &hdev->dev);
>         if (ret < 0)
>                 return ret;
>         ret =3D fw->size;
> @@ -918,7 +948,7 @@ static int btrtl_setup_rtl8723a(struct hci_dev *hdev,
>                 return -EINVAL;
>         }
>
> -       return rtl_download_firmware(hdev, btrtl_dev->fw_data,
> +       return rtl_download_firmware(hdev, FW_TYPE_V0, btrtl_dev->fw_data=
,
>                                      btrtl_dev->fw_len);
>  }
>
> @@ -933,7 +963,7 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
>         if (ret < 0)
>                 goto out;
>
> -       if (btrtl_dev->cfg_len > 0) {
> +       if (!is_v3_fw(btrtl_dev->fw_type) && btrtl_dev->cfg_len > 0) {
>                 tbuff =3D kvzalloc(ret + btrtl_dev->cfg_len, GFP_KERNEL);
>                 if (!tbuff) {
>                         ret =3D -ENOMEM;
> @@ -949,9 +979,25 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev=
,
>                 fw_data =3D tbuff;
>         }
>
> +       if (is_v3_fw(btrtl_dev->fw_type)) {
> +               struct btrtl_enh_ops *ops =3D symbol_get(rtl_enh_ops);
> +
> +               if (!ops)
> +                       ret =3D -EOPNOTSUPP;
> +               else if (ops->download_firmware_v3)
> +                       ret =3D ops->download_firmware_v3(hdev, btrtl_dev=
);
> +               else
> +                       ret =3D -EOPNOTSUPP;
> +
> +               if (ops)
> +                       symbol_put(rtl_enh_ops);
> +
> +               goto out;
> +       }
> +
>         rtl_dev_info(hdev, "cfg_sz %d, total sz %d", btrtl_dev->cfg_len, =
ret);
>
> -       ret =3D rtl_download_firmware(hdev, fw_data, ret);
> +       ret =3D rtl_download_firmware(hdev, btrtl_dev->fw_type, fw_data, =
ret);
>
>  out:
>         kvfree(fw_data);
> @@ -1021,7 +1067,7 @@ static int rtl_read_chip_type(struct hci_dev *hdev,=
 u8 *type)
>         const unsigned char cmd_buf[] =3D {0x00, 0x94, 0xa0, 0x00, 0xb0};
>
>         /* Read RTL chip type command */
> -       skb =3D __hci_cmd_sync(hdev, 0xfc61, 5, cmd_buf, HCI_INIT_TIMEOUT=
);
> +       skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_READ_VENDER, 5, cmd_buf, =
HCI_INIT_TIMEOUT);
>         if (IS_ERR(skb)) {
>                 rtl_dev_err(hdev, "Read chip type failed (%ld)",
>                             PTR_ERR(skb));
> @@ -1048,6 +1094,9 @@ void btrtl_free(struct btrtl_device_info *btrtl_dev=
)
>  {
>         struct rtl_subsection *entry, *tmp;
>
> +       if (!btrtl_dev)
> +               return;
> +
>         kvfree(btrtl_dev->fw_data);
>         kvfree(btrtl_dev->cfg_data);
>
> @@ -1056,6 +1105,14 @@ void btrtl_free(struct btrtl_device_info *btrtl_de=
v)
>                 kfree(entry);
>         }
>
> +       struct btrtl_enh_ops *ops =3D symbol_get(rtl_enh_ops);
> +
> +       if (ops) {
> +               if (ops->free_patch_images)
> +                       ops->free_patch_images(btrtl_dev);
> +               symbol_put(rtl_enh_ops);
> +       }
> +
>         kfree(btrtl_dev);
>  }
>  EXPORT_SYMBOL_GPL(btrtl_free);
> @@ -1063,7 +1120,7 @@ EXPORT_SYMBOL_GPL(btrtl_free);
>  struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>                                            const char *postfix)
>  {
> -       struct btrealtek_data *coredump_info =3D hci_get_priv(hdev);
> +       struct btrealtek_data *btrtl_data =3D hci_get_priv(hdev);
>         struct btrtl_device_info *btrtl_dev;
>         struct sk_buff *skb;
>         struct hci_rp_read_local_version *resp;
> @@ -1074,8 +1131,9 @@ struct btrtl_device_info *btrtl_initialize(struct h=
ci_dev *hdev,
>         u8 hci_ver, lmp_ver, chip_type =3D 0;
>         int ret;
>         int rc;
> -       u8 key_id;
> +       u8 key_id =3D 0;
>         u8 reg_val[2];
> +       u8 chip_id =3D 0;
>
>         btrtl_dev =3D kzalloc_obj(*btrtl_dev);
>         if (!btrtl_dev) {
> @@ -1084,8 +1142,15 @@ struct btrtl_device_info *btrtl_initialize(struct =
hci_dev *hdev,
>         }
>
>         INIT_LIST_HEAD(&btrtl_dev->patch_subsecs);
> +       INIT_LIST_HEAD(&btrtl_dev->patch_images);
>
>  check_version:
> +       ret =3D btrtl_read_chip_id(hdev, &chip_id);
> +       if (!ret && chip_id >=3D CHIP_ID_V3_BASE) {
> +               btrtl_dev->project_id =3D chip_id;
> +               goto read_local_ver;
> +       }
> +
>         ret =3D btrtl_vendor_read_reg16(hdev, RTL_CHIP_SUBVER, reg_val);
>         if (ret < 0)
>                 goto err_free;
> @@ -1108,6 +1173,7 @@ struct btrtl_device_info *btrtl_initialize(struct h=
ci_dev *hdev,
>                 }
>         }
>
> +read_local_ver:
>         skb =3D btrtl_read_local_version(hdev);
>         if (IS_ERR(skb)) {
>                 ret =3D PTR_ERR(skb);
> @@ -1185,11 +1251,18 @@ struct btrtl_device_info *btrtl_initialize(struct=
 hci_dev *hdev,
>                 goto err_free;
>         }
>
> -       rc =3D btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
> -       if (rc < 0)
> -               goto err_free;
> +       if (btrtl_dev->project_id >=3D CHIP_ID_V3_BASE) {
> +               rc =3D btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ_V3, reg=
_val);
> +               if (rc < 0)
> +                       goto err_free;
> +               key_id =3D reg_val[0];
> +       } else if (lmp_subver =3D=3D RTL_ROM_LMP_8922A) {
> +               rc =3D btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ_V2, reg=
_val);
> +               if (rc < 0)
> +                       goto err_free;
> +               key_id =3D reg_val[0];
> +       }
>
> -       key_id =3D reg_val[0];
>         btrtl_dev->key_id =3D key_id;
>         rtl_dev_info(hdev, "%s: key id %u", __func__, key_id);
>
> @@ -1233,6 +1306,9 @@ struct btrtl_device_info *btrtl_initialize(struct h=
ci_dev *hdev,
>                         if (!ret)
>                                 ret =3D -EINVAL;
>                         goto err_free;
> +               } else if (btrtl_dev->cfg_len <=3D 0) {
> +                       rtl_dev_info(hdev, "config file %s.bin not found,=
 ignored",
> +                                    btrtl_dev->ic_info->cfg_name);
>                 }
>         }
>
> @@ -1243,7 +1319,7 @@ struct btrtl_device_info *btrtl_initialize(struct h=
ci_dev *hdev,
>                 hci_set_msft_opcode(hdev, 0xFCF0);
>
>         if (btrtl_dev->ic_info)
> -               coredump_info->rtl_dump.controller =3D btrtl_dev->ic_info=
->hw_info;
> +               btrtl_data->rtl_dump.controller =3D btrtl_dev->ic_info->h=
w_info;
>
>         return btrtl_dev;
>
> @@ -1514,7 +1590,38 @@ EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
>  MODULE_AUTHOR("Daniel Drake <drake@endlessm.com>");
>  MODULE_DESCRIPTION("Bluetooth support for Realtek devices ver " VERSION)=
;
>  MODULE_VERSION(VERSION);
> +
> +
> +int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       struct sk_buff *clone =3D skb_clone(skb, GFP_ATOMIC);
> +       struct hci_event_hdr *hdr;
> +       u8 *p;
> +
> +       if (!clone)
> +               goto out;
> +
> +       hdr =3D skb_pull_data(clone, sizeof(*hdr));
> +       if (!hdr || hdr->evt !=3D HCI_VENDOR_PKT)
> +               goto out;
> +
> +       p =3D skb_pull_data(clone, 1);
> +       if (!p)
> +               goto out;
> +       switch (*p) {
> +       case 0x77:
> +               if (btrealtek_test_and_clear_flag(hdev, REALTEK_DOWNLOADI=
NG))
> +                       btrealtek_wake_up_flag(hdev, REALTEK_DOWNLOADING)=
;
> +               break;
> +       }
> +out:
> +       consume_skb(clone);
> +       return hci_recv_frame(hdev, skb);
> +}
> +EXPORT_SYMBOL_GPL(btrtl_recv_event);
> +
>  MODULE_LICENSE("GPL");
> +MODULE_SOFTDEP("post: btrtl_enh");
>  MODULE_FIRMWARE("rtl_bt/rtl8723a_fw.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8723b_fw.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8723b_config.bin");
> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> index a2d9d34f9fb0..061f8efe122d 100644
> --- a/drivers/bluetooth/btrtl.h
> +++ b/drivers/bluetooth/btrtl.h
> @@ -12,7 +12,30 @@
>  #define rtl_dev_info(dev, fmt, ...) bt_dev_info(dev, "RTL: " fmt, ##__VA=
_ARGS__)
>  #define rtl_dev_dbg(dev, fmt, ...) bt_dev_dbg(dev, "RTL: " fmt, ##__VA_A=
RGS__)
>
> -struct btrtl_device_info;
> +#ifndef kzalloc_obj
> +#define kzalloc_obj(obj) kzalloc(sizeof(obj), GFP_KERNEL)
> +#endif
> +#ifndef kmalloc_obj
> +#define kmalloc_obj(obj) kmalloc(sizeof(obj), GFP_KERNEL)
> +#endif
> +
> +
> +#define RTL_VSC_OP_DOWNLOAD_CMD                        0xfc20
> +#define RTL_VSC_OP_READ_VENDER                 0xfc61
> +#define RTL_VSC_OP_WRITE_VENDOR                        0xfc62
> +#define RTL_VSC_OP_READ_ROM_VER                        0xfc6d
> +#define RTL_VSC_OP_READ_CHIP_ID                        0xfc6f
> +#define RTL_VSC_OP_COREDUMP                    0xfcff
> +#define RTL_VSC_OP_CHECK_DOWNLOAD_STATE                0xfdcf
> +#define RTL_VSC_OP_WDG_RESET_CMD               0xfc8e
> +
> +#define FW_TYPE_V0             0
> +#define FW_TYPE_V1             1
> +#define FW_TYPE_V2             2
> +#define FW_TYPE_V3_1           3
> +#define FW_TYPE_V3_2           4
> +#define is_v3_fw(type) ((type) =3D=3D FW_TYPE_V3_1 || (type) =3D=3D FW_T=
YPE_V3_2)
> +#define CHIP_ID_V3_BASE                55
>
>  struct rtl_chip_type_evt {
>         __u8 status;
> @@ -103,8 +126,14 @@ struct rtl_vendor_cmd {
>         __u8 param[5];
>  } __packed;
>
> +struct rtl_rp_read_chip_id {
> +       __u8 status;
> +       __u8 chip_id;
> +} __packed;
> +
>  enum {
>         REALTEK_ALT6_CONTINUOUS_TX_CHIP,
> +       REALTEK_DOWNLOADING,
>
>         __REALTEK_NUM_FLAGS,
>  };
> @@ -130,7 +159,79 @@ struct btrealtek_data {
>  #define btrealtek_get_flag(hdev)                                       \
>         (((struct btrealtek_data *)hci_get_priv(hdev))->flags)
>
> +#define btrealtek_wake_up_flag(hdev, nr)                               \
> +       do {                                                            \
> +               struct btrealtek_data *rtl =3D hci_get_priv((hdev));     =
 \
> +               wake_up_bit(rtl->flags, (nr));                          \
> +       } while (0)
>  #define btrealtek_test_flag(hdev, nr)  test_bit((nr), btrealtek_get_flag=
(hdev))
> +#define btrealtek_test_and_clear_flag(hdev, nr)                         =
       \
> +               test_and_clear_bit((nr), btrealtek_get_flag(hdev))
> +#define btrealtek_wait_on_flag_timeout(hdev, nr, m, to)                 =
       \
> +               wait_on_bit_timeout(btrealtek_get_flag(hdev), (nr), m, to=
)
> +#define btrealtek_clear_flag(hdev, nr)                                 \
> +               do {                                                    \
> +                       struct btrealtek_data *rtl =3D hci_get_priv((hdev=
));      \
> +                       clear_bit((nr), rtl->flags);                    \
> +               } while (0)
> +
> +struct id_table {
> +       __u16 match_flags;
> +       __u16 lmp_subver;
> +       __u16 hci_rev;
> +       __u8 hci_ver;
> +       __u8 hci_bus;
> +       __u8 chip_type;
> +       bool config_needed;
> +       bool has_rom_version;
> +       bool has_msft_ext;
> +       char *fw_name;
> +       char *cfg_name;
> +       char *hw_info;
> +};
> +
> +struct btrtl_device_info {
> +       const struct id_table *ic_info;
> +       u8 rom_version;
> +       u8 *fw_data;
> +       int fw_len;
> +       u8 *cfg_data;
> +       int cfg_len;
> +       bool drop_fw;
> +       int project_id;
> +       u32 opcode;
> +       u8 fw_type;
> +       u8 key_id;
> +       struct list_head patch_subsecs;
> +       struct list_head patch_images;
> +};
> +
> +struct btrtl_enh_ops {
> +       int (*parse_firmware_v3)(struct hci_dev *hdev,
> +                                struct btrtl_device_info *btrtl_dev);
> +       int (*download_firmware_v3)(struct hci_dev *hdev,
> +                                   struct btrtl_device_info *btrtl_dev);
> +       void (*free_patch_images)(struct btrtl_device_info *btrtl_dev);
> +       int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
> +};
> +/* Symbol exported by btrtl_enh.ko for symbol_get/symbol_put */
> +extern struct btrtl_enh_ops rtl_enh_ops;
> +
> +
> +
> +
> +
> +/* Internal functions shared between btrtl_core.c and btrtl_enh.c */
> +void btrtl_free_patch_images(struct btrtl_device_info *btrtl_dev);
> +void *rtl_iov_pull_data(struct rtl_iovec *iov, u32 len);
> +struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev);
> +int btrtl_read_chip_id(struct hci_dev *hdev, u8 *chip_id);
> +int rtl_download_firmware(struct hci_dev *hdev, u8 fw_type,
> +                         const unsigned char *data, int fw_len);
> +int rtlbt_parse_firmware_v3(struct hci_dev *hdev,
> +                           struct btrtl_device_info *btrtl_dev);
> +int rtl_download_firmware_v3(struct hci_dev *hdev,
> +                            struct btrtl_device_info *btrtl_dev);
>
>  #if IS_ENABLED(CONFIG_BT_RTL)
>
> @@ -148,6 +249,7 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
>                             unsigned int *controller_baudrate,
>                             u32 *device_baudrate, bool *flow_control);
>  void btrtl_set_driver_name(struct hci_dev *hdev, const char *driver_name=
);
> +int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb);
>
>  #else
>
> @@ -157,6 +259,11 @@ static inline struct btrtl_device_info *btrtl_initia=
lize(struct hci_dev *hdev,
>         return ERR_PTR(-EOPNOTSUPP);
>  }
>
> +static inline int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff =
*skb)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  static inline void btrtl_free(struct btrtl_device_info *btrtl_dev)
>  {
>  }
> diff --git a/drivers/bluetooth/btrtl_enh.c b/drivers/bluetooth/btrtl_enh.=
c
> new file mode 100644
> index 000000000000..2b4cbc1c69e0
> --- /dev/null
> +++ b/drivers/bluetooth/btrtl_enh.c
> @@ -0,0 +1,811 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  Bluetooth support for Realtek devices
> + *
> + *  Copyright (C) 2026 Realtek Semiconductor Corporation.
> + */
> +
> +#include <linux/firmware.h>
> +#include <linux/unaligned.h>
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include "btrtl.h"
> +
> +#define RTL_VENDOR_WRITEB_TYPE         0x00
> +#define RTL_VENDOR_WRITE_TYPE          0x21
> +#define RTL_VENDOR_REG32_TYPE          0x20
> +#define RTL_CHIP_7090A                 62
> +#define RTL_WRZM_CNT                   48
> +#define RTL_WRZM_ADDR_A                        0x00403BAC
> +#define RTL_WRZM_ADDR_B                        0x00400018
> +#define RTL_WRZM_ADDR_C                        0x00400014
> +#define RTL_PATCH_V3_1         0x01
> +#define RTL_PATCH_V3_2         0x02
> +#define IMAGE_ID_F000          0xf000
> +#define IMAGE_ID_F001          0xf001
> +#define IMAGE_ID_F002          0xf002
> +
> +#define DL_FIX_CI_ID           0
> +#define DL_FIX_CI_ADDR         1
> +#define DL_FIX_PATCH_ADDR      2
> +#define DL_FIX_SEC_HDR_ADDR    3
> +#define DL_FIX_ADDR_MAX                4
> +
> +struct rtl_vendor_write_cmd {
> +       u8 type;
> +       __le32 addr;
> +       __le32 val;
> +} __packed;
> +
> +struct rtl_vendor_writeb_cmd {
> +       u8 type;
> +       __le32 addr;
> +       u8 val;
> +} __packed;
> +
> +struct rtl_vendor_read_cmd {
> +       u8 type;
> +       __le32 addr;
> +} __packed;
> +
> +struct rtl_vendor_read_rsp {
> +       u8 status;
> +       __le32 val;
> +} __packed;
> +
> +struct rtl_rp_dl_v3 {
> +       __u8 status;
> +       __u8 index;
> +       __u8 err;
> +} __packed;
> +
> +struct rtl_epatch_header_v3 {
> +       __u8 signature[8];
> +       __u8 timestamp[8];
> +       __le32 ver_rsvd;
> +       __le32 num_sections;
> +} __packed;
> +
> +struct rtl_section_v3 {
> +       __le32 opcode;
> +       __le64 len;
> +       u8 data[];
> +} __packed;
> +
> +struct rtl_addr_fix {
> +       u32 addr;
> +       u32 value;
> +};
> +
> +struct rtl_section_patch_image {
> +       u16 image_id;
> +       u8 index;
> +       u8 config_rule;
> +       u8 need_config;
> +
> +       struct rtl_addr_fix fix[DL_FIX_ADDR_MAX];
> +
> +       u32 image_len;
> +       u8 *image_data;
> +       u32 image_ver;
> +
> +       u8  *cfg_buf;
> +       u16 cfg_len;
> +
> +       struct list_head list;
> +};
> +
> +struct rtl_patch_image_hdr {
> +       __le16 chip_id;
> +       u8 ic_cut;
> +       u8 key_id;
> +       u8 enable_ota;
> +       __le16 image_id;
> +       u8 config_rule;
> +       u8 need_config;
> +       u8 rsv[950];
> +
> +       __le64 addr_fix[DL_FIX_ADDR_MAX * 2];
> +       u8 index;
> +
> +       __le64 patch_image_len;
> +       __u8 data[];
> +} __packed;
> +
> +static int btrtl_vendor_write_mem(struct hci_dev *hdev, u32 addr, u32 va=
l)
> +{
> +       struct rtl_vendor_write_cmd cp;
> +       struct sk_buff *skb;
> +       int err =3D 0;
> +
> +       cp.type =3D RTL_VENDOR_WRITE_TYPE;
> +       cp.addr =3D cpu_to_le32(addr);
> +       cp.val =3D cpu_to_le32(val);
> +       skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_WRITE_VENDOR, sizeof(cp),=
 &cp, HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               err =3D PTR_ERR(skb);
> +               bt_dev_err(hdev, "RTL: Write mem32 failed (%d)", err);
> +               return err;
> +       }
> +
> +       kfree_skb(skb);
> +       return 0;
> +}
> +
> +static int btrtl_vendor_read_reg32(struct hci_dev *hdev, u32 addr, u32 *=
val)
> +{
> +       struct rtl_vendor_read_cmd cp;
> +       struct rtl_vendor_read_rsp *rp;
> +       struct sk_buff *skb;
> +
> +       cp.type =3D RTL_VENDOR_REG32_TYPE;
> +       cp.addr =3D cpu_to_le32(addr);
> +       skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_READ_VENDER,
> +                            sizeof(cp), &cp, HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb))
> +               return PTR_ERR(skb);
> +
> +       rp =3D skb_pull_data(skb, sizeof(*rp));
> +       if (rp && !rp->status)
> +               *val =3D le32_to_cpu(rp->val);
> +       kfree_skb(skb);
> +
> +       if (!rp || rp->status)
> +               return -EIO;
> +
> +       return 0;
> +}
> +
> +static int btrtl_vendor_write_reg32(struct hci_dev *hdev, u32 addr, u32 =
val)
> +{
> +       struct rtl_vendor_write_cmd cp;
> +       struct sk_buff *skb;
> +
> +       cp.type =3D RTL_VENDOR_REG32_TYPE;
> +       cp.addr =3D cpu_to_le32(addr);
> +       cp.val  =3D cpu_to_le32(val);
> +       skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_WRITE_VENDOR,
> +                            sizeof(cp), &cp, HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb))
> +               return PTR_ERR(skb);
> +       kfree_skb(skb);
> +       return 0;
> +}
> +
> +static int btrtl_vendor_write_reg8(struct hci_dev *hdev, u32 addr, u8 va=
l)
> +{
> +       struct rtl_vendor_writeb_cmd cp;
> +       struct sk_buff *skb;
> +
> +       cp.type =3D RTL_VENDOR_WRITEB_TYPE;
> +       cp.addr =3D cpu_to_le32(addr);
> +       cp.val  =3D val;
> +       skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_WRITE_VENDOR,
> +                            sizeof(cp), &cp, HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb))
> +               return PTR_ERR(skb);
> +       kfree_skb(skb);
> +       return 0;
> +}
> +
> +static int btrtl_wrzm(struct hci_dev *hdev,
> +                     struct btrtl_device_info *btrtl_dev)
> +{
> +       u32 val;
> +       int ret;
> +       int i;
> +
> +       for (i =3D 0; i < RTL_WRZM_CNT; i++) {
> +               ret =3D btrtl_vendor_read_reg32(hdev, RTL_WRZM_ADDR_A + i=
 * 4, &val);
> +               if (ret) {
> +                       rtl_dev_err(hdev, "WRZM: read[%d] failed (%d)", i=
, ret);
> +                       return ret;
> +               }
> +               ret =3D btrtl_vendor_write_reg32(hdev, RTL_WRZM_ADDR_B + =
i * 4, val);
> +               if (ret) {
> +                       rtl_dev_err(hdev, "WRZM: write[%d] failed (%d)", =
i, ret);
> +                       return ret;
> +               }
> +       }
> +
> +       ret =3D btrtl_vendor_read_reg32(hdev, RTL_WRZM_ADDR_C, &val);
> +       if (ret) {
> +               rtl_dev_err(hdev, "WRZM: read (part2) failed (%d)", ret);
> +               return ret;
> +       }
> +
> +       val |=3D 0x10;
> +
> +       ret =3D btrtl_vendor_write_reg8(hdev, RTL_WRZM_ADDR_C, val);
> +       if (ret) {
> +               rtl_dev_err(hdev, "WRZM: write (part2) failed (%d)", ret)=
;
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static void btrtl_insert_ordered_patch_image(struct rtl_section_patch_im=
age *image,
> +                                            struct btrtl_device_info *bt=
rtl_dev)
> +{
> +       struct list_head *pos;
> +       struct list_head *next;
> +       struct rtl_section_patch_image *node;
> +
> +       list_for_each_safe(pos, next, &btrtl_dev->patch_images) {
> +               node =3D list_entry(pos, struct rtl_section_patch_image, =
list);
> +
> +               if (node->image_id > image->image_id) {
> +                       __list_add(&image->list, pos->prev, pos);
> +                       return;
> +               }
> +
> +               if (node->image_id =3D=3D image->image_id &&
> +                   node->index > image->index) {
> +                       __list_add(&image->list, pos->prev, pos);
> +                       return;
> +               }
> +       }
> +       __list_add(&image->list, pos->prev, pos);
> +}
> +
> +static int rtlbt_parse_config(struct hci_dev *hdev,
> +                             struct rtl_section_patch_image *patch_image=
,
> +                             struct btrtl_device_info *btrtl_dev)
> +{
> +       const struct id_table *ic_info =3D NULL;
> +       const struct firmware *fw;
> +       char tmp_name[32];
> +       char filename[64];
> +       u8 *cfg_buf;
> +       char *str;
> +       char *p;
> +       size_t len;
> +       int ret;
> +
> +       if (btrtl_dev && btrtl_dev->ic_info)
> +               ic_info =3D btrtl_dev->ic_info;
> +
> +       if (!ic_info)
> +               return -EINVAL;
> +
> +       str =3D ic_info->cfg_name;
> +       if (!str)
> +               return -EINVAL;
> +
> +       if (btrtl_dev->fw_type =3D=3D FW_TYPE_V3_1) {
> +               if (!patch_image->image_id && !patch_image->index) {
> +                       snprintf(filename, sizeof(filename), "%s.bin", st=
r);
> +                       goto load_fw;
> +               }
> +               goto done;
> +       }
> +
> +       len =3D strlen(str);
> +       if (len > sizeof(tmp_name) - 1)
> +               len =3D sizeof(tmp_name) - 1;
> +       memcpy(tmp_name, str, len);
> +       tmp_name[len] =3D '\0';
> +
> +       str =3D tmp_name;
> +       p =3D strsep(&str, ".");
> +
> +       ret =3D snprintf(filename, sizeof(filename), "%s", p);
> +       if (patch_image->config_rule && patch_image->need_config) {
> +               switch (patch_image->image_id) {
> +               case IMAGE_ID_F000:
> +               case IMAGE_ID_F001:
> +               case IMAGE_ID_F002:
> +                       ret +=3D snprintf(filename + ret, sizeof(filename=
) - ret,
> +                                       "_%04x", patch_image->image_id);
> +                       break;
> +               default:
> +                       goto done;
> +               }
> +       } else {
> +               goto done;
> +       }
> +
> +       snprintf(filename + ret, sizeof(filename) - ret, ".%s", str ? str=
 : "bin");
> +
> +load_fw:
> +       rtl_dev_info(hdev, "config file: %s", filename);
> +       ret =3D firmware_request_nowarn(&fw, filename, &hdev->dev);
> +       if (ret < 0) {
> +               if (btrtl_dev->fw_type =3D=3D FW_TYPE_V3_2) {
> +                       len =3D 4;
> +                       cfg_buf =3D kvmalloc(len, GFP_KERNEL);
> +                       if (!cfg_buf)
> +                               return -ENOMEM;
> +
> +                       rtl_dev_info(hdev, "config file: %s not found, us=
e default",
> +                                    filename);
> +                       memset(cfg_buf, 0xff, len);
> +                       patch_image->cfg_buf =3D cfg_buf;
> +                       patch_image->cfg_len =3D len;
> +                       return 0;
> +               }
> +               goto err_req_fw;
> +       }
> +       rtl_dev_info(hdev, "config file: %s found", filename);
> +       cfg_buf =3D kvmalloc(fw->size, GFP_KERNEL);
> +       if (!cfg_buf) {
> +               ret =3D -ENOMEM;
> +               goto err;
> +       }
> +       memcpy(cfg_buf, fw->data, fw->size);
> +       len =3D fw->size;
> +       release_firmware(fw);
> +
> +       patch_image->cfg_buf =3D cfg_buf;
> +       patch_image->cfg_len =3D len;
> +done:
> +       return 0;
> +err:
> +       release_firmware(fw);
> +err_req_fw:
> +       rtl_dev_info(hdev, "config file: [%s] not found", filename);
> +       return ret;
> +}
> +
> +static int rtlbt_parse_section_v3(struct hci_dev *hdev,
> +                                 struct btrtl_device_info *btrtl_dev,
> +                                 u32 opcode, u8 *data, u32 len)
> +{
> +       struct rtl_section_patch_image *patch_image;
> +       struct rtl_patch_image_hdr *hdr;
> +       u16 image_id;
> +       u16 chip_id;
> +       size_t patch_image_len;
> +       u8 *ptr;
> +       int ret =3D 0;
> +       size_t i;
> +       struct rtl_iovec iov =3D {
> +               .data =3D data,
> +               .len  =3D len,
> +       };
> +
> +       hdr =3D rtl_iov_pull_data(&iov, sizeof(*hdr));
> +       if (!hdr)
> +               return -EINVAL;
> +
> +       if (btrtl_dev->opcode && btrtl_dev->opcode !=3D opcode) {
> +               rtl_dev_err(hdev, "invalid opcode 0x%02x", opcode);
> +               return -EINVAL;
> +       }
> +
> +       if (!btrtl_dev->opcode) {
> +               btrtl_dev->opcode =3D opcode;
> +               switch (btrtl_dev->opcode) {
> +               case RTL_PATCH_V3_1:
> +                       btrtl_dev->fw_type =3D FW_TYPE_V3_1;
> +                       break;
> +               case RTL_PATCH_V3_2:
> +                       btrtl_dev->fw_type =3D FW_TYPE_V3_2;
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       patch_image_len =3D (u32)le64_to_cpu(hdr->patch_image_len);
> +       chip_id =3D le16_to_cpu(hdr->chip_id);
> +       image_id =3D le16_to_cpu(hdr->image_id);
> +       rtl_dev_info(hdev, "subsection (%04x:%02x), chip id %u, cut 0x%02=
x, len %08zx"
> +                    , image_id, hdr->index, chip_id, hdr->ic_cut,
> +                    patch_image_len);
> +
> +       if (btrtl_dev->key_id !=3D hdr->key_id) {
> +               rtl_dev_info(hdev, "skip, key_id mismatch (%u, %u)",
> +                           hdr->key_id, btrtl_dev->key_id);
> +               return 0;
> +       }
> +
> +       if (hdr->ic_cut !=3D btrtl_dev->rom_version + 1) {
> +               rtl_dev_info(hdev, "skip, ic_cut mismatch (%u, %u)",
> +                           hdr->ic_cut, btrtl_dev->rom_version + 1);
> +               return 0;
> +       }
> +
> +       if (btrtl_dev->fw_type =3D=3D FW_TYPE_V3_1 && !btrtl_dev->project=
_id)
> +               btrtl_dev->project_id =3D chip_id;
> +
> +       if (btrtl_dev->fw_type =3D=3D FW_TYPE_V3_2 &&
> +           chip_id !=3D btrtl_dev->project_id) {
> +               rtl_dev_info(hdev, "skip, chip_id mismatch (%u, %d)", chi=
p_id,
> +                           btrtl_dev->project_id);
> +               return 0;
> +       }
> +
> +       ptr =3D rtl_iov_pull_data(&iov, patch_image_len);
> +       if (!ptr)
> +               return -ENODATA;
> +
> +       patch_image =3D kzalloc_obj(*patch_image);
> +       if (!patch_image)
> +               return -ENOMEM;
> +       patch_image->index =3D hdr->index;
> +       patch_image->image_id =3D image_id;
> +       patch_image->config_rule =3D hdr->config_rule;
> +       patch_image->need_config =3D hdr->need_config;
> +
> +       for (i =3D 0; i < DL_FIX_ADDR_MAX; i++) {
> +               patch_image->fix[i].addr =3D
> +                       (u32)le64_to_cpu(hdr->addr_fix[i * 2]);
> +               patch_image->fix[i].value =3D
> +                       (u32)le64_to_cpu(hdr->addr_fix[i * 2 + 1]);
> +       }
> +
> +       patch_image->image_len =3D patch_image_len;
> +
> +       if (patch_image_len < 4) {
> +               rtl_dev_err(hdev, "subsection payload too short (%zu)",
> +                           patch_image_len);
> +               ret =3D -EINVAL;
> +               goto err;
> +       }
> +
> +       patch_image->image_data =3D kvmalloc(patch_image_len, GFP_KERNEL)=
;
> +       if (!patch_image->image_data) {
> +               ret =3D -ENOMEM;
> +               goto err;
> +       }
> +       memcpy(patch_image->image_data, ptr, patch_image_len);
> +       patch_image->image_ver =3D
> +               get_unaligned_le32(ptr + patch_image->image_len - 4);
> +       rtl_dev_info(hdev, "subsection version: %08x", patch_image->image=
_ver);
> +
> +       ret =3D rtlbt_parse_config(hdev, patch_image, btrtl_dev);
> +       if (ret) {
> +               rtl_dev_err(hdev, "config parse failed (%d)", ret);
> +               goto err;
> +       }
> +
> +       ret =3D patch_image->image_len;
> +
> +       btrtl_insert_ordered_patch_image(patch_image, btrtl_dev);
> +
> +       return ret;
> +err:
> +       kvfree(patch_image->image_data);
> +       kvfree(patch_image->cfg_buf);
> +       kfree(patch_image);
> +       return ret;
> +}
> +
> +int rtlbt_parse_firmware_v3(struct hci_dev *hdev,
> +                           struct btrtl_device_info *btrtl_dev)
> +{
> +       struct rtl_epatch_header_v3 *hdr;
> +       int rc;
> +       u32 num_sections;
> +       struct rtl_section_v3 *section;
> +       u32 section_len;
> +       u32 opcode;
> +       int len =3D 0;
> +       int i;
> +       u8 *ptr;
> +       struct rtl_iovec iov =3D {
> +               .data =3D btrtl_dev->fw_data,
> +               .len  =3D btrtl_dev->fw_len,
> +       };
> +
> +       rtl_dev_info(hdev, "key id %u", btrtl_dev->key_id);
> +
> +       hdr =3D rtl_iov_pull_data(&iov, sizeof(*hdr));
> +       if (!hdr)
> +               return -EINVAL;
> +       num_sections =3D le32_to_cpu(hdr->num_sections);
> +
> +       rtl_dev_dbg(hdev, "timpstamp %08x-%08x", *((u32 *)hdr->timestamp)=
,
> +                   *((u32 *)(hdr->timestamp + 4)));
> +
> +       for (i =3D 0; i < num_sections; i++) {
> +               section =3D rtl_iov_pull_data(&iov, sizeof(*section));
> +               if (!section)
> +                       break;
> +
> +               section_len =3D (u32)le64_to_cpu(section->len);
> +               opcode =3D le32_to_cpu(section->opcode);
> +
> +               rtl_dev_dbg(hdev, "opcode 0x%04x", section->opcode);
> +
> +               ptr =3D rtl_iov_pull_data(&iov, section_len);
> +               if (!ptr)
> +                       break;
> +
> +               rc =3D 0;
> +               switch (opcode) {
> +               case RTL_PATCH_V3_1:
> +               case RTL_PATCH_V3_2:
> +                       rc =3D rtlbt_parse_section_v3(hdev, btrtl_dev, op=
code,
> +                                                   ptr, section_len);
> +                       break;
> +               default:
> +                       rtl_dev_warn(hdev, "Unknown opcode %08x", opcode)=
;
> +                       break;
> +               }
> +               if (rc < 0) {
> +                       rtl_dev_err(hdev, "Parse section (%u) err (%d)",
> +                                   opcode, rc);
> +                       continue;
> +               }
> +               len +=3D rc;
> +       }
> +
> +       rtl_dev_info(hdev, "firmware section payload total len: 0x%08x", =
len);
> +       if (!len) {
> +               rtl_dev_err(hdev, "no matching firmware section found");
> +               return -ENODATA;
> +       }
> +
> +       return len;
> +}
> +
> +static int rtl_check_download_state(struct hci_dev *hdev,
> +                                   struct btrtl_device_info *btrtl_dev)
> +{
> +       struct sk_buff *skb;
> +       int ret =3D 0;
> +       u8 *state;
> +
> +       btrealtek_set_flag(hdev, REALTEK_DOWNLOADING);
> +
> +       skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_CHECK_DOWNLOAD_STATE, 0, =
NULL, HCI_CMD_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               btrealtek_clear_flag(hdev, REALTEK_DOWNLOADING);
> +               rtl_dev_err(hdev, "write tb error %lu", PTR_ERR(skb));
> +               return -EIO;
> +       }
> +
> +       /* Other driver might be downloading the combined firmware. */
> +       state =3D skb_pull_data(skb, sizeof(*state));
> +       if (state && *state =3D=3D 0x03) {
> +               ret =3D btrealtek_wait_on_flag_timeout(hdev, REALTEK_DOWN=
LOADING,
> +                                                    TASK_INTERRUPTIBLE,
> +                                                    msecs_to_jiffies(500=
0));
> +               if (ret =3D=3D -EINTR) {
> +                       bt_dev_err(hdev, "Firmware loading interrupted");
> +                       goto out;
> +               }
> +
> +               if (ret) {
> +                       bt_dev_err(hdev, "Firmware loading timeout");
> +                       ret =3D -ETIMEDOUT;
> +               } else {
> +                       ret =3D -EALREADY;
> +               }
> +
> +       } else {
> +               btrealtek_clear_flag(hdev, REALTEK_DOWNLOADING);
> +       }
> +
> +out:
> +       kfree_skb(skb);
> +       return ret;
> +}
> +
> +static int rtl_finalize_download(struct hci_dev *hdev,
> +                                struct btrtl_device_info *btrtl_dev)
> +{
> +       struct hci_rp_read_local_version *rp_ver;
> +       u8 params[2] =3D { 0x03, 0xb2 };
> +       struct sk_buff *skb;
> +       int ret =3D 0;
> +       u16 opcode;
> +       u32 len;
> +       u8 *p;
> +
> +       opcode =3D RTL_VSC_OP_WDG_RESET_CMD;
> +       len =3D 2;
> +       if (btrtl_dev->opcode =3D=3D RTL_PATCH_V3_1) {
> +               opcode =3D RTL_VSC_OP_DOWNLOAD_CMD;
> +               params[0] =3D 0x80;
> +               len =3D 1;
> +       }
> +       skb =3D __hci_cmd_sync(hdev, opcode, len, params, HCI_CMD_TIMEOUT=
);
> +       if (IS_ERR(skb)) {
> +               rtl_dev_err(hdev, "Watchdog reset err (%ld)", PTR_ERR(skb=
));
> +               return -EIO;
> +       }
> +       p =3D skb_pull_data(skb, 1);
> +       if (!p) {
> +               ret =3D -ENODATA;
> +               goto out;
> +       }
> +       rtl_dev_info(hdev, "Watchdog reset status %02x", *p);
> +       kfree_skb(skb);
> +
> +       skb =3D btrtl_read_local_version(hdev);
> +       if (IS_ERR(skb)) {
> +               ret =3D PTR_ERR(skb);
> +               rtl_dev_err(hdev, "read local version failed (%d)", ret);
> +               return ret;
> +       }
> +
> +       rp_ver =3D skb_pull_data(skb, sizeof(*rp_ver));
> +       if (rp_ver)
> +               rtl_dev_info(hdev, "fw version 0x%04x%04x",
> +                            __le16_to_cpu(rp_ver->hci_rev),
> +                            __le16_to_cpu(rp_ver->lmp_subver));
> +out:
> +       kfree_skb(skb);
> +       return ret;
> +}
> +
> +static int rtl_security_check(struct hci_dev *hdev,
> +                             struct btrtl_device_info *btrtl_dev)
> +{
> +       struct rtl_section_patch_image *tmp =3D NULL;
> +       struct rtl_section_patch_image *image =3D NULL;
> +       u32 val;
> +       int ret;
> +
> +       list_for_each_entry_reverse(tmp, &btrtl_dev->patch_images, list) =
{
> +               /* Check security hdr */
> +               if (!tmp->fix[DL_FIX_SEC_HDR_ADDR].value ||
> +                   !tmp->fix[DL_FIX_SEC_HDR_ADDR].addr ||
> +                   tmp->fix[DL_FIX_SEC_HDR_ADDR].addr =3D=3D 0xffffffff)
> +                       continue;
> +               rtl_dev_info(hdev, "addr 0x%08x, value 0x%08x",
> +                            tmp->fix[DL_FIX_SEC_HDR_ADDR].addr,
> +                            tmp->fix[DL_FIX_SEC_HDR_ADDR].value);
> +               image =3D tmp;
> +               break;
> +       }
> +
> +       if (!image)
> +               return 0;
> +
> +       rtl_dev_info(hdev, "sec subsection (%04x:%02x)", image->image_id,
> +                    image->index);
> +       val =3D image->fix[DL_FIX_PATCH_ADDR].value + image->image_len -
> +                                       image->fix[DL_FIX_SEC_HDR_ADDR].v=
alue;
> +       ret =3D btrtl_vendor_write_mem(hdev, image->fix[DL_FIX_PATCH_ADDR=
].addr,
> +                                    val);
> +       if (ret) {
> +               rtl_dev_err(hdev, "write sec reg failed (%d)", ret);
> +               return ret;
> +       }
> +       return 0;
> +}
> +
> +int rtl_download_firmware_v3(struct hci_dev *hdev,
> +                            struct btrtl_device_info *btrtl_dev)
> +{
> +       struct rtl_section_patch_image *image, *tmp;
> +       struct rtl_rp_dl_v3 *rp;
> +       struct sk_buff *skb;
> +       u8 *fw_data;
> +       int fw_len;
> +       int ret =3D 0;
> +       u8 i;
> +
> +       if (btrtl_dev->project_id =3D=3D RTL_CHIP_7090A) {
> +               ret =3D btrtl_wrzm(hdev, btrtl_dev);
> +               if (ret) {
> +                       rtl_dev_err(hdev, "v3 WRZM failed (%d)", ret);
> +                       return ret;
> +               }
> +       }
> +
> +       if (btrtl_dev->fw_type =3D=3D FW_TYPE_V3_2) {
> +               ret =3D rtl_check_download_state(hdev, btrtl_dev);
> +               if (ret) {
> +                       if (ret =3D=3D -EALREADY)
> +                               return 0;
> +                       return ret;
> +               }
> +       }
> +
> +       list_for_each_entry_safe(image, tmp, &btrtl_dev->patch_images, li=
st) {
> +               rtl_dev_dbg(hdev, "image (%04x:%02x)", image->image_id,
> +                           image->index);
> +
> +               for (i =3D DL_FIX_CI_ID; i < DL_FIX_ADDR_MAX; i++) {
> +                       if (!image->fix[i].addr ||
> +                           image->fix[i].addr =3D=3D 0xffffffff) {
> +                               rtl_dev_dbg(hdev, "no need to write addr =
%08x",
> +                                           image->fix[i].addr);
> +                               continue;
> +                       }
> +                       rtl_dev_dbg(hdev, "write addr and val, 0x%08x, 0x=
%08x",
> +                                   image->fix[i].addr, image->fix[i].val=
ue);
> +                       if (btrtl_vendor_write_mem(hdev, image->fix[i].ad=
dr,
> +                                                  image->fix[i].value)) =
{
> +                               rtl_dev_err(hdev, "write reg failed");
> +                               ret =3D -EIO;
> +                               goto done;
> +                       }
> +               }
> +
> +               fw_len =3D image->image_len + image->cfg_len;
> +               fw_data =3D kvmalloc(fw_len, GFP_KERNEL);
> +               if (!fw_data) {
> +                       rtl_dev_err(hdev, "Couldn't alloc buf for image d=
ata");
> +                       ret =3D -ENOMEM;
> +                       goto done;
> +               }
> +               memcpy(fw_data, image->image_data, image->image_len);
> +               if (image->cfg_len > 0)
> +                       memcpy(fw_data + image->image_len, image->cfg_buf=
,
> +                              image->cfg_len);
> +
> +               rtl_dev_dbg(hdev, "patch image (%04x:%02x). len: %d",
> +                           image->image_id, image->index, fw_len);
> +               rtl_dev_dbg(hdev, "fw_data %p, image buf %p, len %u", fw_=
data,
> +                           image->image_data, image->image_len);
> +
> +               ret =3D rtl_download_firmware(hdev, btrtl_dev->fw_type, f=
w_data,
> +                                           fw_len);
> +               kvfree(fw_data);
> +               if (ret < 0) {
> +                       rtl_dev_err(hdev, "download firmware failed (%d)"=
, ret);
> +                       goto done;
> +               }
> +
> +               if (image->list.next !=3D &btrtl_dev->patch_images &&
> +                   image->image_id =3D=3D tmp->image_id)
> +                       continue;
> +
> +               if (btrtl_dev->fw_type =3D=3D FW_TYPE_V3_1)
> +                       continue;
> +
> +               i =3D 0x80;
> +               skb =3D __hci_cmd_sync(hdev, RTL_VSC_OP_DOWNLOAD_CMD, 1, =
&i, HCI_CMD_TIMEOUT);
> +               if (IS_ERR(skb)) {
> +                       ret =3D -EIO;
> +                       rtl_dev_err(hdev, "Failed to issue last cmd fc20,=
 %ld",
> +                                   PTR_ERR(skb));
> +                       goto done;
> +               }
> +               ret =3D 2;
> +               rp =3D skb_pull_data(skb, sizeof(*rp));
> +               if (rp)
> +                       ret =3D rp->err;
> +               kfree_skb(skb);
> +               if (ret =3D=3D 2) {
> +                       /* Verification failure */
> +                       ret =3D -EFAULT;
> +                       goto done;
> +               }
> +       }
> +
> +       if (btrtl_dev->fw_type =3D=3D FW_TYPE_V3_1) {
> +               ret =3D rtl_security_check(hdev, btrtl_dev);
> +               if (ret) {
> +                       rtl_dev_err(hdev, "Security check failed (%d)", r=
et);
> +                       goto done;
> +               }
> +       }
> +
> +       ret =3D rtl_finalize_download(hdev, btrtl_dev);
> +
> +done:
> +       return ret;
> +}
> +
> +void btrtl_free_patch_images(struct btrtl_device_info *btrtl_dev)
> +{
> +       struct rtl_section_patch_image *image, *next;
> +
> +       list_for_each_entry_safe(image, next, &btrtl_dev->patch_images, l=
ist) {
> +               list_del(&image->list);
> +               kvfree(image->image_data);
> +               kvfree(image->cfg_buf);
> +               kfree(image);
> +       }
> +}
> +
> +
> +struct btrtl_enh_ops rtl_enh_ops =3D {
> +       .parse_firmware_v3    =3D rtlbt_parse_firmware_v3,
> +       .download_firmware_v3 =3D rtl_download_firmware_v3,
> +       .free_patch_images    =3D btrtl_free_patch_images,
> +};
> +EXPORT_SYMBOL_GPL(rtl_enh_ops);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Realtek Bluetooth firmware v3+ support");
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 61c18402911a..637693c9915e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2934,6 +2934,9 @@ static int btusb_recv_event_realtek(struct hci_dev =
*hdev, struct sk_buff *skb)
>                 return 0;
>         }
>
> +       if (skb->data[0] =3D=3D HCI_VENDOR_PKT)
> +               return btrtl_recv_event(hdev, skb);
> +
>         return hci_recv_frame(hdev, skb);
>  }
>
> --
> 2.34.1

Sashiko is flagging quite a few problems here:

https://sashiko.dev/#/patchset/20260908035627.579073-1-hildawu%40realtek.co=
m

--=20
Luiz Augusto von Dentz
