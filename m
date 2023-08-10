Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBCAC04A6A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Aug 2023 17:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjHJRtv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Aug 2023 13:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbjHJRtu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Aug 2023 13:49:50 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248132702
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 10:49:49 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9a828c920so18225371fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691689787; x=1692294587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k11h4+qmWoGG7O8Mpz3JtheSLDOmr0/23ERanTkk4Gc=;
        b=pzT/HbZHq2h4DfbctiIViXe1nquYS2NVBaN3TdistHDcLQvML/RbC6Zb97TEKU1Dr+
         IP6ehb9uWYe06mt/RPU4SbIbNJ0ldUGeLPJU49YDr3u2TmkKLXDvede7KT27SpfMSoIJ
         ckAEFmL1POhl4MxpO47/Mrl5aC0lhWyAUi1qtiSGKeXSD68HZAEhryf5RKWDoujSMPrU
         2tcQ3ycb+eeX8rM5zy8O49SiJdRC53lMEBbUZkI2vlQBx0CCJ40MuaKa/nBLqkEv9z9M
         MObRv1ruwqTyVJP9/rWjMRrz1jXZfRdqQX0azfOisL8hqJt90UVmuC/aadvgHG4sNTp3
         AHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691689787; x=1692294587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k11h4+qmWoGG7O8Mpz3JtheSLDOmr0/23ERanTkk4Gc=;
        b=gOfVLcMrTbCVOoTZzc0szbBBYWFYCYagSTlQkIJar5Ml3JQMyQDyLzHgsA6AnYSeXI
         RxlvNfcHE8P5q9Dbm0+V4k+R7+rSE73f26Soef5RvBxer2shuoAfje7Su6/4U5hkcbtg
         ioqNKgf/IBTjXWlX99Iq+K2bA9djoGSB0EReVUHHBNUgrnD1odHwlFa9686Jw/kmn6YE
         L+oHIoZpIAPPbE5UgRR6KB+H/Y/EhGTw8mxSEMgPm/j0qjgP+LpRtqRVGe+Rg6YF220J
         vCiNbVlLO8h1I5AzJUQb2LX7aSqcSgTPGpnTvIo2pIqpRlaj4Q3yqydSVD2Xi0BA07hg
         wVPw==
X-Gm-Message-State: AOJu0YzclKvOsIu+rGoDYfn8s4StYhyFVsGUTuxchWerLqW1ks70qnyK
        506L4Du5p814ENg/XWfX27sovMVdRLwyBpgX5td9l8oo
X-Google-Smtp-Source: AGHT+IERG5b3huOUs5/9+ACouauEgC4CmOkFGXAyPMu1xD3FpECyuBJKl0R64KyFfeCwRPsBNq855R+CETqtBJHW4lQ=
X-Received: by 2002:a05:651c:10d:b0:2b5:81bc:43a8 with SMTP id
 a13-20020a05651c010d00b002b581bc43a8mr2383727ljb.0.1691689786928; Thu, 10 Aug
 2023 10:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230810145653.1780-1-lokendra.singh@intel.com>
In-Reply-To: <20230810145653.1780-1-lokendra.singh@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 10 Aug 2023 10:49:34 -0700
Message-ID: <CABBYNZJogALR3GwcR4CmsmjuhQaCytAHghgcaBLLeiu+QT+Zww@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btintel: Send new command for PPAG
To:     Lokendra Singh <lokendra.singh@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com, luiz.von.dentz@intel.com,
        tedd.an@intel.com, kiran.k@intel.com,
        Seema Sreemantha <seema.sreemantha@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Lokendra,

On Thu, Aug 10, 2023 at 8:18=E2=80=AFAM Lokendra Singh <lokendra.singh@inte=
l.com> wrote:
>
> Added support for the new command opcode FE0B
> (HCI Intel PPAG Enable).
>
> btmon log:
> < HCI Command: Intel PPAG Enable (0x3f|0x020b) plen 4
>         Enable: 0x00000002
> > HCI Event: Command Complete (0x0e) plen 4
>       Intel PPAG Enable (0x3f|0x020b) ncmd 1
>         Status: Success (0x00)
>
> Signed-off-by: Seema Sreemantha <seema.sreemantha@intel.com>
> Signed-off-by: Lokendra Singh <lokendra.singh@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 28 +++++++++++++++++++---------
>  drivers/bluetooth/btintel.h |  8 +++-----
>  2 files changed, 22 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 633e8d9bf58f..d2c93b88c527 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2401,7 +2401,7 @@ static void btintel_set_ppag(struct hci_dev *hdev, =
struct intel_version_tlv *ver
>  {
>         struct btintel_ppag ppag;
>         struct sk_buff *skb;
> -       struct btintel_loc_aware_reg ppag_cmd;
> +       struct hci_ppag_enable_cmd ppag_cmd;
>         acpi_handle handle;
>
>         /* PPAG is not supported if CRF is HrP2, Jfp2, JfP1 */
> @@ -2409,6 +2409,8 @@ static void btintel_set_ppag(struct hci_dev *hdev, =
struct intel_version_tlv *ver
>         case 0x504:     /* Hrp2 */
>         case 0x202:     /* Jfp2 */
>         case 0x201:     /* Jfp1 */
> +               bt_dev_warn(hdev, "PPAG not supported for Intel CNVr (0x%=
3x)",
> +                           ver->cnvr_top & 0xFFF);

If this doesn't change the functionality I'd recommend using
bt_dev_dbg so we don't warn users for no reason.

>                 return;
>         }
>
> @@ -2434,24 +2436,32 @@ static void btintel_set_ppag(struct hci_dev *hdev=
, struct intel_version_tlv *ver
>         }
>
>         if (ppag.domain !=3D 0x12) {
> -               bt_dev_warn(hdev, "PPAG-BT: domain is not bluetooth");
> +               bt_dev_warn(hdev, "PPAG-BT: Bluetooth domain is disabled =
in ACPI firmware");

Ditto.

>                 return;
>         }
>
> -       /* PPAG mode, BIT0 =3D 0 Disabled, BIT0 =3D 1 Enabled */
> -       if (!(ppag.mode & BIT(0))) {
> -               bt_dev_dbg(hdev, "PPAG-BT: disabled");
> +       /* PPAG mode
> +        * BIT 0 : 0 Disabled in EU
> +        *         1 Enabled in EU
> +        * BIT 1 : 0 Disabled in China
> +        *         1 Enabled in China
> +        */
> +       if ((ppag.mode & 0x01) !=3D BIT(0) && (ppag.mode & 0x02) !=3D BIT=
(1)) {
> +               bt_dev_warn(hdev, "PPAG-BT: EU, China mode are disabled i=
n CB/BIOS");

Ditto.

>                 return;
>         }
>
> -       ppag_cmd.mcc =3D cpu_to_le32(0);
> -       ppag_cmd.sel =3D cpu_to_le32(0); /* 0 - Enable , 1 - Disable, 2 -=
 Testing mode */
> -       ppag_cmd.delta =3D cpu_to_le32(0);
> -       skb =3D __hci_cmd_sync(hdev, 0xfe19, sizeof(ppag_cmd), &ppag_cmd,=
 HCI_CMD_TIMEOUT);
> +       /* HCI_Intel_PpagEnable_CMD - opcode: 0xFE0B
> +        * ppag_enable_flags - ppag mode
> +        */
> +       ppag_cmd.ppag_enable_flags =3D ppag.mode;
> +
> +       skb =3D __hci_cmd_sync(hdev, 0xfe0b, sizeof(ppag_cmd), &ppag_cmd,=
 HCI_CMD_TIMEOUT);
>         if (IS_ERR(skb)) {
>                 bt_dev_warn(hdev, "Failed to send PPAG Enable (%ld)", PTR=
_ERR(skb));
>                 return;
>         }
> +       bt_dev_info(hdev, "PPAG-BT: Enabled (Mode %d)", ppag.mode);
>         kfree_skb(skb);
>  }
>
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 2ed646609dee..01e87f68fab0 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -137,11 +137,9 @@ struct intel_offload_use_cases {
>         __u8    preset[8];
>  } __packed;
>
> -struct btintel_loc_aware_reg {
> -       __le32 mcc;
> -       __le32 sel;
> -       __le32 delta;
> -} __packed;
> +struct hci_ppag_enable_cmd {
> +       u32 ppag_enable_flags;
> +};

Lets also add defines to command opcodes so we don't have to add
comments on what the opcode means around the codebase.

>  #define INTEL_TLV_TYPE_ID              0x01
>
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
