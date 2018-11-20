Return-Path: <SRS0=OtUJ=N7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAF6C4161D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 11:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95C420685
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 11:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jF+iyPn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95C420685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbeKTWOM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:14:12 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33472 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbeKTWOM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Nov 2018 17:14:12 -0500
Received: by mail-qk1-f195.google.com with SMTP id o89so2331733qko.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Nov 2018 03:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1PTrCxdEK4pa93TSNJmCKw1xwdme8dS/+6VGxlseTo=;
        b=jF+iyPn4Ch0TXhOix8Skw3Ky+O9UGoNI5jHHkQMKsJee4D4r8e7EYvGUeyd8Hi+5sN
         lLbKaJBFWqNotB97z45SQGGTjF20zg7rq43EM6bGZ/hu5xVOM1WQxz7qtxwhVQNjAnnD
         D6PEDGTZjLgfgJ9HIteKX9CMVgUraRrR2EGf9cgksjIepyVkwXdu3NhemcM4OLORh/Vy
         KW5XH1DSGm5+UzCr3NsC8G4Opy1z3HsuRfVFEwyALG7J9VeiRqVqGFASYJok3Nhm6pIf
         EmCGLQs8AOrUqSbMLnZWfjquqmYaRk/8wgj3s/JDVKYewTCg3qODhWxWRY5kURPDAcGI
         wutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1PTrCxdEK4pa93TSNJmCKw1xwdme8dS/+6VGxlseTo=;
        b=g0v61N5t8/i5hfI8wPZYbo6d0OeonE+hoJTx+RlGc4+XJrwYIpD3Z7HUeP/Y/mQdiE
         hzumIbrMUOvdY+4DLMTaId0pWigFgzNUCZWuCYikP5aWii1X92D527qeyT8BiEF1Avry
         gQhsd9FCd+405cqz78Z2eeEAgH5HG5WbSVXexw7oMokY3JCLf1p3Vi+te2bGihKEdAyg
         H1vEsNZzRz7qvxTgNUSTl0IRnPgJbe/uCWekFPRZXIpemg+kdQyCZ+7n0GeefL9NnnyJ
         Kz2E4Ov+PolZBJFEUDvtrJv1n2BKU49hkwHPaYvNG+JPs1j14Qo9VbPTAEzfJlAN/R/4
         m2kg==
X-Gm-Message-State: AGRZ1gLtd4F7gnF2roReKBtM3B/2/gagrAh75SPynoBKTzMowO8amfia
        gYBxRfycXzDt85JRBJHLnBtVrXIvV7CtNLoSFcMMrQ==
X-Google-Smtp-Source: AFSGD/XnaVTZKf8Mncr+dQOTyNbqV1mDwe7P8s1qWcpWrBWZIFrpZnEVahqtLFIhhWXYI7noITXD8Pllvik5aZgcS6U=
X-Received: by 2002:aed:2a64:: with SMTP id k33mr1537592qtf.102.1542714326081;
 Tue, 20 Nov 2018 03:45:26 -0800 (PST)
MIME-Version: 1.0
References: <1541745429-13105-1-git-send-email-jaganath.kanakkassery@intel.com>
In-Reply-To: <1541745429-13105-1-git-send-email-jaganath.kanakkassery@intel.com>
From:   Jaganath K <jaganath.k.os@gmail.com>
Date:   Tue, 20 Nov 2018 17:15:14 +0530
Message-ID: <CAJzH+botVyUqym5menn+rC2VYOYQ_3Y5-HrrijToBZ0VP4EO0g@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ] btmgmt: Add BREDR PHYs in PHY Configuration commands
To:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Cc:     Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Nov 9, 2018 at 12:13 PM Jaganath Kanakkassery
<jaganath.k.os@gmail.com> wrote:
>
> This basically adds BREDR packet types also in the PHY confiuration
> commands & events and makes the PHYs 32 bit so that it can be
> extended in future. This also add configurable PHYs in the GetPhy
> command wherein only those can be selected or deselected in SetPhy.
>
> This also adds LE prefix for LE phys to make it more
> descriptive
> ---
>  lib/mgmt.h     | 32 ++++++++++++++++---------
>  tools/btmgmt.c | 75 ++++++++++++++++++++++++++++++++++------------------------
>  2 files changed, 65 insertions(+), 42 deletions(-)
>
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index ec6a380..570dec9 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -552,16 +552,26 @@ struct mgmt_cp_set_appearance {
>
>  #define MGMT_OP_GET_PHY_CONFIGURATION  0x0044
>  struct mgmt_rp_get_phy_confguration {
> -       uint16_t        supported_phys;
> -       uint16_t        selected_phys;
> -} __packed;
> -
> -#define MGMT_PHY_LE_1M_TX              0x0001
> -#define MGMT_PHY_LE_1M_RX              0x0002
> -#define MGMT_PHY_LE_2M_TX              0x0004
> -#define MGMT_PHY_LE_2M_RX              0x0008
> -#define MGMT_PHY_LE_CODED_TX           0x0010
> -#define MGMT_PHY_LE_CODED_RX           0x0020
> +       uint32_t        supported_phys;
> +       uint32_t        configurable_phys;
> +       uint32_t        selected_phys;
> +} __packed;
> +
> +#define MGMT_PHY_BR_1M_1SLOT   0x00000001
> +#define MGMT_PHY_BR_1M_3SLOT   0x00000002
> +#define MGMT_PHY_BR_1M_5SLOT   0x00000004
> +#define MGMT_PHY_EDR_2M_1SLOT  0x00000008
> +#define MGMT_PHY_EDR_2M_3SLOT  0x00000010
> +#define MGMT_PHY_EDR_2M_5SLOT  0x00000020
> +#define MGMT_PHY_EDR_3M_1SLOT  0x00000040
> +#define MGMT_PHY_EDR_3M_3SLOT  0x00000080
> +#define MGMT_PHY_EDR_3M_5SLOT  0x00000100
> +#define MGMT_PHY_LE_1M_TX              0x00000200
> +#define MGMT_PHY_LE_1M_RX              0x00000400
> +#define MGMT_PHY_LE_2M_TX              0x00000800
> +#define MGMT_PHY_LE_2M_RX              0x00001000
> +#define MGMT_PHY_LE_CODED_TX   0x00002000
> +#define MGMT_PHY_LE_CODED_RX   0x00004000
>
>  #define MGMT_PHY_LE_TX_MASK (MGMT_PHY_LE_1M_TX | MGMT_PHY_LE_2M_TX | \
>                              MGMT_PHY_LE_CODED_TX)
> @@ -570,7 +580,7 @@ struct mgmt_rp_get_phy_confguration {
>
>  #define MGMT_OP_SET_PHY_CONFIGURATION  0x0045
>  struct mgmt_cp_set_phy_confguration {
> -       uint16_t        default_phys;
> +       uint32_t        selected_phys;
>  } __packed;
>
>
> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> index 9e3a3ca..6922f3d 100644
> --- a/tools/btmgmt.c
> +++ b/tools/btmgmt.c
> @@ -4181,15 +4181,24 @@ static void cmd_appearance(int argc, char **argv)
>  }
>
>  static const char *phys_str[] = {
> -       "1MTX",
> -       "1MRX",
> -       "2MTX",
> -       "2MRX",
> -       "CODEDTX",
> -       "CODEDRX",
> +       "BR1M1SLOT",
> +       "BR1M3SLOT",
> +       "BR1M5SLOT",
> +       "EDR2M1SLOT",
> +       "EDR2M3SLOT",
> +       "EDR2M5SLOT",
> +       "EDR3M1SLOT",
> +       "EDR3M3SLOT",
> +       "EDR3M5SLOT",
> +       "LE1MTX",
> +       "LE1MRX",
> +       "LE2MTX",
> +       "LE2MRX",
> +       "LECODEDTX",
> +       "LECODEDRX",
>  };
>
> -static const char *phys2str(uint16_t phys)
> +static const char *phys2str(uint32_t phys)
>  {
>         static char str[256];
>         unsigned int i;
> @@ -4207,11 +4216,25 @@ static const char *phys2str(uint16_t phys)
>         return str;
>  }
>
> +static bool str2phy(const char *phy_str, uint32_t *phy_val)
> +{
> +       unsigned int i;
> +
> +       for (i = 0; i < NELEM(phys_str); i++) {
> +               if (strcasecmp(phys_str[i], phy_str) == 0) {
> +                       *phy_val = (1 << i);
> +                       return true;
> +               }
> +       }
> +
> +       return false;
> +}
> +
>  static void get_phy_rsp(uint8_t status, uint16_t len, const void *param,
>                                                         void *user_data)
>  {
>         const struct mgmt_rp_get_phy_confguration *rp = param;
> -       uint16_t supported_flags, selected_phys;
> +       uint32_t supported_phys, selected_phys, configurable_phys;
>
>         if (status != 0) {
>                 error("Get PHY Configuration failed with status 0x%02x (%s)",
> @@ -4224,10 +4247,12 @@ static void get_phy_rsp(uint8_t status, uint16_t len, const void *param,
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
>
> -       supported_flags = get_le16(&rp->supported_phys);
> -       selected_phys = get_le16(&rp->selected_phys);
> +       supported_phys = get_le32(&rp->supported_phys);
> +       configurable_phys = get_le32(&rp->configurable_phys);
> +       selected_phys = get_le32(&rp->selected_phys);
>
> -       print("Supported phys: %s", phys2str(supported_flags));
> +       print("Supported phys: %s", phys2str(supported_phys));
> +       print("Configurable phys: %s", phys2str(configurable_phys));
>         print("Selected phys: %s", phys2str(selected_phys));
>
>         bt_shell_noninteractive_quit(EXIT_SUCCESS);
> @@ -4266,33 +4291,20 @@ static void cmd_phy(int argc, char **argv)
>  {
>         struct mgmt_cp_set_phy_confguration cp;
>         int i;
> -       uint16_t phys = 0;
> +       uint32_t phys = 0;
>         uint16_t index;
>
>         if (argc < 2)
>                 return get_phy();
>
>         for (i = 1; i < argc; i++) {
> -               if (strcasecmp(argv[i], "1MTX") == 0)
> -                       phys |= MGMT_PHY_LE_1M_TX;
> -
> -               if (strcasecmp(argv[i], "1MRX") == 0)
> -                       phys |= MGMT_PHY_LE_1M_RX;
> -
> -               if (strcasecmp(argv[i], "2MTX") == 0)
> -                       phys |= MGMT_PHY_LE_2M_TX;
> -
> -               if (strcasecmp(argv[i], "2MRX") == 0)
> -                       phys |= MGMT_PHY_LE_2M_RX;
> -
> -               if (strcasecmp(argv[i], "CODEDTX") == 0)
> -                       phys |= MGMT_PHY_LE_CODED_TX;
> +               uint32_t phy_val;
>
> -               if (strcasecmp(argv[i], "CODEDRX") == 0)
> -                       phys |= MGMT_PHY_LE_CODED_RX;
> +               if (str2phy(argv[i], &phy_val))
> +                       phys |= phy_val;
>         }
>
> -       cp.default_phys = cpu_to_le16(phys);
> +       cp.selected_phys = cpu_to_le32(phys);
>
>         index = mgmt_index;
>         if (index == MGMT_INDEX_NONE)
> @@ -4501,8 +4513,9 @@ static const struct bt_shell_menu main_menu = {
>                 cmd_clr_adv,            "Clear advertising instances"   },
>         { "appearance",         "<appearance>",
>                 cmd_appearance,         "Set appearance"                },
> -       { "phy",                "[1MTX] [1MRX] [2MTX] [2MRX] [CODEDTX] "
> -                               "[CODEDRX] [BR1M1SLOT] [BR1M3SLOT] [BR1M5SLOT]"
> +       { "phy",                "[LE1MTX] [LE1MRX] [LE2MTX] [LE2MRX] "
> +                               "[LECODEDTX] [LECODEDRX] "
> +                               "[BR1M1SLOT] [BR1M3SLOT] [BR1M5SLOT]"
>                                 "[EDR2M1SLOT] [EDR2M3SLOT] [EDR2M5SLOT]"
>                                 "[EDR3M1SLOT] [EDR3M3SLOT] [EDR3M5SLOT]",
>                 cmd_phy,                "Get/Set PHY Configuration"     },
> --

Ping.

Thanks,
Jaganath
