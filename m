Return-Path: <SRS0=9KbV=OH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12A7C43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 08:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0902081C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 08:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiJ9tnsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0902081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeK1TUh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:20:37 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37534 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeK1TUg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 14:20:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id z16so24901471qtq.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Nov 2018 00:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXkO0I4W5JowfLqTdAwy/aQ5O783pOltBrAOPSfP0Fg=;
        b=LiJ9tnskCsxGjvsrrhzwB12gUymT6E6nQVQLnq2vySB/WCVgX/ekOjG2ZUK4LybGbE
         ITT0k1+8XyeW2lbiSDrAhp48arS5aJ9KIvc6438bcRIUqKgwOK9teGVpWj+pEOsExS9p
         Sx/pbwce7QTsm9yblJ0jBbz+eZPc+uaMIVPlx4fsuGJihNuOsIQUheB0MahfrOzaNFp5
         ZlqcPtaTbH63V8lpD4yPZ6SeQtyrWe5OJzTJrUPkgfu3tq6MaaO8p6JG4n6mnSL0kChs
         MdhGqbWrVd9/m99os+XPyXV3cJrMvOndxyu9KuZcOxv/SzvRG/4GScGYQyx4StzJitDA
         SXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXkO0I4W5JowfLqTdAwy/aQ5O783pOltBrAOPSfP0Fg=;
        b=PiHymCVECQo8maoXVyvRBP5suudfyy5qYqFLMq7u06X8AnugCE2LQUv/jkmEAO/grH
         lPesJqEVVa46DC87au6sKUDe1/bRv9eCPn4yonN5aA+zkoDyY9MyvJ67QFIJaWYiwqyY
         54wJ5dnFPMsarOwBlB52bMlVSdASFYrM+oUs6sFwQMWPmDqhYTYJy30tvm4Ril4KXon0
         Mkskpz4Mycy6jwPg7P4Ry3v36fBvWpg/CzrA89s7UfRae2VXACDFPrzTHAnp/jesPdGB
         fWLPYc8/TI0IEx1/UxjlGU+sR9mChB+q+IX9c/joOjlCcR/6wN0Fj+ccdJl4rWyt0AU2
         7RlQ==
X-Gm-Message-State: AA+aEWZ0ra6yQc6H2jaFejqTgymoEvbiMN27tXFTDTN3ulLCIegRGxRz
        qKoXyCl/LREsC3Rl9VXZrcFjqHCLbqgHRnOWKu7Q+Q==
X-Google-Smtp-Source: AJdET5ecObrbPDD0jp3Ea+MX3rhEpITa8Y4zeXqOEzWqphfHOd+HFpOGPJIi4TL/o6kaDF3LPauKzKk5b4JL2xlgS+A=
X-Received: by 2002:aed:2314:: with SMTP id h20mr34019936qtc.286.1543393188445;
 Wed, 28 Nov 2018 00:19:48 -0800 (PST)
MIME-Version: 1.0
References: <1541745429-13105-1-git-send-email-jaganath.kanakkassery@intel.com>
 <CAJzH+botVyUqym5menn+rC2VYOYQ_3Y5-HrrijToBZ0VP4EO0g@mail.gmail.com>
In-Reply-To: <CAJzH+botVyUqym5menn+rC2VYOYQ_3Y5-HrrijToBZ0VP4EO0g@mail.gmail.com>
From:   Jaganath K <jaganath.k.os@gmail.com>
Date:   Wed, 28 Nov 2018 13:49:36 +0530
Message-ID: <CAJzH+brson8CbCkqat49n1aHW_ScJ2FOSzZf--ibGTyWdsCNaw@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ] btmgmt: Add BREDR PHYs in PHY Configuration commands
To:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Cc:     Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Nov 20, 2018 at 5:15 PM Jaganath K <jaganath.k.os@gmail.com> wrote:
>
> Hi,
>
> On Fri, Nov 9, 2018 at 12:13 PM Jaganath Kanakkassery
> <jaganath.k.os@gmail.com> wrote:
> >
> > This basically adds BREDR packet types also in the PHY confiuration
> > commands & events and makes the PHYs 32 bit so that it can be
> > extended in future. This also add configurable PHYs in the GetPhy
> > command wherein only those can be selected or deselected in SetPhy.
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
> > +
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
Any update on this patch plz?.

Thanks,
Jaganath
