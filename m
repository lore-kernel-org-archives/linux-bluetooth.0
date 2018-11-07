Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925F4C0044C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 11:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510FF2086B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 11:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfhxKHvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510FF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeKGVKz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:10:55 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39456 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeKGVKz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 16:10:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id g27so14461908oth.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Nov 2018 03:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bJaXKa/EsEQLHfHxqC4p19RPL03GJ2Pyw2E3PlzxgjA=;
        b=VfhxKHvuFGFSTpdLqjMYz2Kt3nwC6GOsxyH7tD3TFhJWI+K7o+qeWXk0ViF1/bVaKu
         +BAcwEmbC0t94iikFvCzN/Vsrz+w+DWPQTLsqH6cl94h/t6LnZwb78DSVg67JEU136xC
         9tjNsIh06UBuXIIUv3jOeiqsqTJilTOoHzJuuzyA2gUAVYwgGiMxyllUx/4Qgpcu8a7R
         ix6UdP4BKnTwGlq1ARS1UxGe7Q2NEE9kZ/tFQXeHRgXV3GVMvozmcZZhBxn3EHgtOP0R
         z5YwPU+rreLLq/KRhYVOuk3T7fLI2cz7byGxtP10ke7dEfDDtQENp75SYBz2DGpJzyLf
         UW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bJaXKa/EsEQLHfHxqC4p19RPL03GJ2Pyw2E3PlzxgjA=;
        b=cX5bvdziUUXWdYGhPU0TxnY37B6myLfqqm7aB/4NV1a6z8WLFyeX02XZb8djMvMOYQ
         UhR7LsiHfDz83y2La3DKcLUvHyLn5Eg6XV/LAxduzzRqSEx95X7UiMBBkjAVm4fbFI32
         b7OB63vtcHPzCZyYD6L+sg0TxBaMnb+P/oJMbN9Ba7bjaWdnRksIxVqwOJvl48i3/Mvc
         qdZiSCGjgYv764bj6hPOSMGUFHFKjT34ADGb0Sfw04fpqHtIvL2gmoWgRw8zgBP/jZNp
         T95fiKFzw8WSKqB03HlLtm2Achv0HZDPvjZYUvgJ3sJr2Dh86rq0X0YhESNCtcPWo6rh
         5NTA==
X-Gm-Message-State: AGRZ1gIjLClU8Hj18CXFTAuh+b+RMhAIHFdJwhbK/dKRhp/lAk/4Goyk
        Xg+3YYdMJ3pPlCFD2AzNRoG/fKVkCNSia81Qo18=
X-Google-Smtp-Source: AJdET5f28s3FxyK7u8GxVqbUqVQnyaOGsNcqpdLCJ/igBEYXLgMWJ+rjWT6U9EB/JAK8RXrwoYNh1mOXh6ouEnDvK1A=
X-Received: by 2002:a9d:3d0:: with SMTP id f74mr777840otf.52.1541590855272;
 Wed, 07 Nov 2018 03:40:55 -0800 (PST)
MIME-Version: 1.0
References: <1540456194-26031-1-git-send-email-jaganath.kanakkassery@intel.com>
 <CAJzH+brrSKy-oBLcpctz=oHg9a5Yb33ChBrgAWbgVeSuJgjCog@mail.gmail.com>
In-Reply-To: <CAJzH+brrSKy-oBLcpctz=oHg9a5Yb33ChBrgAWbgVeSuJgjCog@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 7 Nov 2018 13:40:43 +0200
Message-ID: <CABBYNZJR6tZVOShTyS-EoNsXxHpHxczc94GLmtgs6m+rrmFAmg@mail.gmail.com>
Subject: Re: [PATCH v1] btmgmt: Add BREDR PHYs in PHY Configuration commands
To:     Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jaganath,
On Tue, Nov 6, 2018 at 11:38 AM Jaganath K <jaganath.k.os@gmail.com> wrote:
>
> Hi,
> On Thu, Oct 25, 2018 at 2:06 PM Jaganath Kanakkassery
> <jaganath.k.os@gmail.com> wrote:
> >
> > This also adds LE prefix for LE phys to make it more
> > descriptive
> > ---
> >  lib/mgmt.h     | 32 ++++++++++++++++---------
> >  tools/btmgmt.c | 75 ++++++++++++++++++++++++++++++++++------------------------
> >  2 files changed, 65 insertions(+), 42 deletions(-)
> >
> > diff --git a/lib/mgmt.h b/lib/mgmt.h
> > index ec6a380..570dec9 100644
> > --- a/lib/mgmt.h
> > +++ b/lib/mgmt.h
> > @@ -552,16 +552,26 @@ struct mgmt_cp_set_appearance {
> >
> >  #define MGMT_OP_GET_PHY_CONFIGURATION  0x0044
> >  struct mgmt_rp_get_phy_confguration {
> > -       uint16_t        supported_phys;
> > -       uint16_t        selected_phys;
> > -} __packed;
> > -
> > -#define MGMT_PHY_LE_1M_TX              0x0001
> > -#define MGMT_PHY_LE_1M_RX              0x0002
> > -#define MGMT_PHY_LE_2M_TX              0x0004
> > -#define MGMT_PHY_LE_2M_RX              0x0008
> > -#define MGMT_PHY_LE_CODED_TX           0x0010
> > -#define MGMT_PHY_LE_CODED_RX           0x0020
> > +       uint32_t        supported_phys;
> > +       uint32_t        configurable_phys;
> > +       uint32_t        selected_phys;
> > +} __packed;

Is this a change in the protocol? It looks like the phys are now 32
bits, or is this an actual fix and that the way the kernel communicate
then? Either way this should probably be split from the changes to the
PHY strings.

> > +#define MGMT_PHY_BR_1M_1SLOT   0x00000001
> > +#define MGMT_PHY_BR_1M_3SLOT   0x00000002
> > +#define MGMT_PHY_BR_1M_5SLOT   0x00000004
> > +#define MGMT_PHY_EDR_2M_1SLOT  0x00000008
> > +#define MGMT_PHY_EDR_2M_3SLOT  0x00000010
> > +#define MGMT_PHY_EDR_2M_5SLOT  0x00000020
> > +#define MGMT_PHY_EDR_3M_1SLOT  0x00000040
> > +#define MGMT_PHY_EDR_3M_3SLOT  0x00000080
> > +#define MGMT_PHY_EDR_3M_5SLOT  0x00000100
> > +#define MGMT_PHY_LE_1M_TX              0x00000200
> > +#define MGMT_PHY_LE_1M_RX              0x00000400
> > +#define MGMT_PHY_LE_2M_TX              0x00000800
> > +#define MGMT_PHY_LE_2M_RX              0x00001000
> > +#define MGMT_PHY_LE_CODED_TX   0x00002000
> > +#define MGMT_PHY_LE_CODED_RX   0x00004000
> >
> >  #define MGMT_PHY_LE_TX_MASK (MGMT_PHY_LE_1M_TX | MGMT_PHY_LE_2M_TX | \
> >                              MGMT_PHY_LE_CODED_TX)
> > @@ -570,7 +580,7 @@ struct mgmt_rp_get_phy_confguration {
> >
> >  #define MGMT_OP_SET_PHY_CONFIGURATION  0x0045
> >  struct mgmt_cp_set_phy_confguration {
> > -       uint16_t        default_phys;
> > +       uint32_t        selected_phys;
> >  } __packed;
> >
> >
> > diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> > index 9e3a3ca..6922f3d 100644
> > --- a/tools/btmgmt.c
> > +++ b/tools/btmgmt.c
> > @@ -4181,15 +4181,24 @@ static void cmd_appearance(int argc, char **argv)
> >  }
> >
> >  static const char *phys_str[] = {
> > -       "1MTX",
> > -       "1MRX",
> > -       "2MTX",
> > -       "2MRX",
> > -       "CODEDTX",
> > -       "CODEDRX",
> > +       "BR1M1SLOT",
> > +       "BR1M3SLOT",
> > +       "BR1M5SLOT",
> > +       "EDR2M1SLOT",
> > +       "EDR2M3SLOT",
> > +       "EDR2M5SLOT",
> > +       "EDR3M1SLOT",
> > +       "EDR3M3SLOT",
> > +       "EDR3M5SLOT",
> > +       "LE1MTX",
> > +       "LE1MRX",
> > +       "LE2MTX",
> > +       "LE2MRX",
> > +       "LECODEDTX",
> > +       "LECODEDRX",
> >  };
> >
> > -static const char *phys2str(uint16_t phys)
> > +static const char *phys2str(uint32_t phys)
> >  {
> >         static char str[256];
> >         unsigned int i;
> > @@ -4207,11 +4216,25 @@ static const char *phys2str(uint16_t phys)
> >         return str;
> >  }
> >
> > +static bool str2phy(const char *phy_str, uint32_t *phy_val)
> > +{
> > +       unsigned int i;
> > +
> > +       for (i = 0; i < NELEM(phys_str); i++) {
> > +               if (strcasecmp(phys_str[i], phy_str) == 0) {
> > +                       *phy_val = (1 << i);
> > +                       return true;
> > +               }
> > +       }
> > +
> > +       return false;
> > +}
> > +
> >  static void get_phy_rsp(uint8_t status, uint16_t len, const void *param,
> >                                                         void *user_data)
> >  {
> >         const struct mgmt_rp_get_phy_confguration *rp = param;
> > -       uint16_t supported_flags, selected_phys;
> > +       uint32_t supported_phys, selected_phys, configurable_phys;
> >
> >         if (status != 0) {
> >                 error("Get PHY Configuration failed with status 0x%02x (%s)",
> > @@ -4224,10 +4247,12 @@ static void get_phy_rsp(uint8_t status, uint16_t len, const void *param,
> >                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
> >         }
> >
> > -       supported_flags = get_le16(&rp->supported_phys);
> > -       selected_phys = get_le16(&rp->selected_phys);
> > +       supported_phys = get_le32(&rp->supported_phys);
> > +       configurable_phys = get_le32(&rp->configurable_phys);
> > +       selected_phys = get_le32(&rp->selected_phys);
> >
> > -       print("Supported phys: %s", phys2str(supported_flags));
> > +       print("Supported phys: %s", phys2str(supported_phys));
> > +       print("Configurable phys: %s", phys2str(configurable_phys));
> >         print("Selected phys: %s", phys2str(selected_phys));
> >
> >         bt_shell_noninteractive_quit(EXIT_SUCCESS);
> > @@ -4266,33 +4291,20 @@ static void cmd_phy(int argc, char **argv)
> >  {
> >         struct mgmt_cp_set_phy_confguration cp;
> >         int i;
> > -       uint16_t phys = 0;
> > +       uint32_t phys = 0;
> >         uint16_t index;
> >
> >         if (argc < 2)
> >                 return get_phy();
> >
> >         for (i = 1; i < argc; i++) {
> > -               if (strcasecmp(argv[i], "1MTX") == 0)
> > -                       phys |= MGMT_PHY_LE_1M_TX;
> > -
> > -               if (strcasecmp(argv[i], "1MRX") == 0)
> > -                       phys |= MGMT_PHY_LE_1M_RX;
> > -
> > -               if (strcasecmp(argv[i], "2MTX") == 0)
> > -                       phys |= MGMT_PHY_LE_2M_TX;
> > -
> > -               if (strcasecmp(argv[i], "2MRX") == 0)
> > -                       phys |= MGMT_PHY_LE_2M_RX;
> > -
> > -               if (strcasecmp(argv[i], "CODEDTX") == 0)
> > -                       phys |= MGMT_PHY_LE_CODED_TX;
> > +               uint32_t phy_val;
> >
> > -               if (strcasecmp(argv[i], "CODEDRX") == 0)
> > -                       phys |= MGMT_PHY_LE_CODED_RX;
> > +               if (str2phy(argv[i], &phy_val))
> > +                       phys |= phy_val;
> >         }
> >
> > -       cp.default_phys = cpu_to_le16(phys);
> > +       cp.selected_phys = cpu_to_le32(phys);
> >
> >         index = mgmt_index;
> >         if (index == MGMT_INDEX_NONE)
> > @@ -4501,8 +4513,9 @@ static const struct bt_shell_menu main_menu = {
> >                 cmd_clr_adv,            "Clear advertising instances"   },
> >         { "appearance",         "<appearance>",
> >                 cmd_appearance,         "Set appearance"                },
> > -       { "phy",                "[1MTX] [1MRX] [2MTX] [2MRX] [CODEDTX] "
> > -                               "[CODEDRX] [BR1M1SLOT] [BR1M3SLOT] [BR1M5SLOT]"
> > +       { "phy",                "[LE1MTX] [LE1MRX] [LE2MTX] [LE2MRX] "
> > +                               "[LECODEDTX] [LECODEDRX] "
> > +                               "[BR1M1SLOT] [BR1M3SLOT] [BR1M5SLOT]"
> >                                 "[EDR2M1SLOT] [EDR2M3SLOT] [EDR2M5SLOT]"
> >                                 "[EDR3M1SLOT] [EDR3M3SLOT] [EDR3M5SLOT]",
> >                 cmd_phy,                "Get/Set PHY Configuration"     },
> > --
>
> Ping.
>
> Thanks,
> Jaganath



-- 
Luiz Augusto von Dentz
