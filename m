Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A51C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 04:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D596C60F13
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 04:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhIGEh0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Sep 2021 00:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhIGEh0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Sep 2021 00:37:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344C5C061575
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Sep 2021 21:36:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q26so11500007wrc.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Sep 2021 21:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=itZLQ6oF/gcbMJAEmenGWzjj/QKGH50amy1hHm2ATw0=;
        b=bLoEYLuqe5Uk7qE7dZcq4TmpabUaYgKN51IrGzEvzrDkf8jlJStwr90RQIuCo3tv5w
         qR92/W+bCsm0MbSR+0MWuLH8EyDWR3MECyeODj79lgZ8hR/h1rWO0pPIyN1pgwL6GH9D
         01onzZZLatwrhn2CdV1cbkXdmBYIhac9MoOuyD3XRAICMwrUMQ9Io49xEtvFV1ALGZeb
         gEDp7sjQoy4xdAkuozE+3iMjaOCLm+FpQkQU2g3uodatt7hxvzhXVYUezZ1QBcohzwIN
         rEv3E338gG0WOi7Wpj6aBoQEgMkecmHHSOhy3GrUUr0Wcm/ivvcJy/0cK9Kzgzka6mGE
         Ya8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=itZLQ6oF/gcbMJAEmenGWzjj/QKGH50amy1hHm2ATw0=;
        b=jICPzXQaqgMozw6gRBlwMXLfXFS3rmW1sQyBzlWKF4K8jXl1bOtHrZjHMyKusuxGId
         NdhDAfoahgH76Pvgt0cWWklDe0e3wYDu0pI7FrZrSo4u+vlNqj2WKbXlavvjGoBGD/9e
         3hb2JeeTSflug336bvJLPM0eElyEr9xaBB2K/bpq+cuSbRFaOqRjcVIA1WM7j5mOX92U
         1f+9focaaSvAenIaKlRnZtYLHs1OiIT/9Dvm4hC8ZtNl/+K/TItP/BIwZMfQjD8t8FxC
         bAXFHm+kOxZAScZGoTNwdsZWi1yhSROk+Y3ivLUvGgM6IHC4Ej6nJ6UMSziVnR/Uf7AT
         eYYw==
X-Gm-Message-State: AOAM530okeCJLNnISoS2D0SLVH2E5AE4G1AYYWeQO1BkvOSKNt+qxH7/
        ymQGmGNX2BkA+10Ji4hvm70/FWgqY7ZjyMA7J0OWJA==
X-Google-Smtp-Source: ABdhPJxvqYxUXvYAiyCBZzBm7z7um4p4SyFwFneLrDFqcXTBmAl3xb9wSpriETkOvjV1MJMqidpOwjcGv1BI/XhvgRE=
X-Received: by 2002:a5d:6085:: with SMTP id w5mr16405907wrt.104.1630989378178;
 Mon, 06 Sep 2021 21:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210906080450.1771211-1-apusaka@google.com> <20210906160340.Bluez.v4.1.I2169032b03520f33b73ca4dc7f2ae7ab0a901da3@changeid>
 <35AC05A9-E7F9-461C-9EAA-1FBB4898B699@holtmann.org>
In-Reply-To: <35AC05A9-E7F9-461C-9EAA-1FBB4898B699@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 7 Sep 2021 12:36:07 +0800
Message-ID: <CAJQfnxHNYjifnyKv4mBSqB-S5Xgo=S8cVJPY00cAw2o3ZL+4xQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v4 01/12] lib: Inclusive language changes
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, 7 Sept 2021 at 00:05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> > BT core spec 5.3 promotes the usage of inclusive languages.
> > This CL replaces some terms with the more appropriate counterparts,
> > such as "central", "peripheral", and "accept list".
> > ---
> >
> > (no changes since v3)
> >
> > Changes in v3:
> > * Not replacing some terms which belong to libluetooth API
> >
> > Changes in v2:
> > * Merging several patches from the same directory into one
> >
> > android/bluetooth.c |  4 ++--
> > lib/hci.c           | 22 +++++++++++-----------
> > lib/mgmt.h          |  2 +-
> > monitor/control.c   |  4 ++--
> > src/adapter.c       |  4 ++--
> > tools/oobtest.c     |  4 ++--
> > 6 files changed, 20 insertions(+), 20 deletions(-)
> >
> > diff --git a/android/bluetooth.c b/android/bluetooth.c
> > index c3ad503497..fe956b5d43 100644
> > --- a/android/bluetooth.c
> > +++ b/android/bluetooth.c
> > @@ -2276,7 +2276,7 @@ static void new_long_term_key_event(uint16_t index, uint16_t length,
> >               ediv = le16_to_cpu(key->ediv);
> >               rand = le64_to_cpu(key->rand);
> >
> > -             store_ltk(&key->addr.bdaddr, key->addr.type, key->master,
> > +             store_ltk(&key->addr.bdaddr, key->addr.type, key->central,
> >                               key->val, key->type, key->enc_size, ediv, rand);
> >       }
> >
> > @@ -3097,7 +3097,7 @@ static struct mgmt_ltk_info *get_ltk_info(GKeyFile *key_file, const char *peer,
> >       info->ediv = g_key_file_get_integer(key_file, peer, ediv_s, NULL);
> >       info->ediv = cpu_to_le16(info->ediv);
> >
> > -     info->master = master;
> > +     info->central = master;
> >
> > failed:
> >       g_free(key);
> > diff --git a/lib/hci.c b/lib/hci.c
> > index 53af0a1148..a2dd7a2ae6 100644
> > --- a/lib/hci.c
> > +++ b/lib/hci.c
> > @@ -288,7 +288,7 @@ int hci_strtolp(char *str, unsigned int *val)
> > static hci_map link_mode_map[] = {
> >       { "NONE",       0               },
> >       { "ACCEPT",     HCI_LM_ACCEPT   },
> > -     { "MASTER",     HCI_LM_MASTER   },
> > +     { "CENTRAL",    HCI_LM_MASTER   },
> >       { "AUTH",       HCI_LM_AUTH     },
> >       { "ENCRYPT",    HCI_LM_ENCRYPT  },
> >       { "TRUSTED",    HCI_LM_TRUSTED  },
>
> you can't do this since it actually maps to input of hciconfig tool. You really need to check where link_mode_map is used.

But I also changed the documentation of hciconfig on patch 05/12.
Are you concerned about that being not in the same patch as this
change, or we shouldn't change the input of any of the tools?
If it is the latter, then I also need to make changes to many of the
tools in patch 05/12.

>
> > @@ -305,7 +305,7 @@ char *hci_lmtostr(unsigned int lm)
> >
> >       *str = 0;
> >       if (!(lm & HCI_LM_MASTER))
> > -             strcpy(str, "SLAVE ");
> > +             strcpy(str, "PERIPHERAL ");
> >
> >       s = hci_bit2str(link_mode_map, lm);
> >       if (!s) {
> > @@ -345,7 +345,7 @@ static hci_map commands_map[] = {
> >
> >       { "Set Connection Encryption",                  16  },
> >       { "Change Connection Link Key",                 17  },
> > -     { "Master Link Key",                            18  },
> > +     { "Temporary Link Key",                         18  },
> >       { "Remote Name Request",                        19  },
> >       { "Cancel Remote Name Request",                 20  },
> >       { "Read Remote Supported Features",             21  },
> > @@ -565,11 +565,11 @@ static hci_map commands_map[] = {
> >       { "LE Set Scan Enable",                         211 },
> >       { "LE Create Connection",                       212 },
> >       { "LE Create Connection Cancel",                213 },
> > -     { "LE Read White List Size",                    214 },
> > -     { "LE Clear White List",                        215 },
> > +     { "LE Read Accept List Size",                   214 },
> > +     { "LE Clear Accept List",                       215 },
> >
> > -     { "LE Add Device To White List",                216 },
> > -     { "LE Remove Device From White List",           217 },
> > +     { "LE Add Device To Accept List",               216 },
> > +     { "LE Remove Device From Accept List",          217 },
> >       { "LE Connection Update",                       218 },
> >       { "LE Set Host Channel Classification",         219 },
> >       { "LE Read Channel Map",                        220 },
> > @@ -735,8 +735,8 @@ static hci_map lmp_features_map[8][9] = {
> >               { "<EV4 packets>",      LMP_EV4         },      /* Bit 0 */
> >               { "<EV5 packets>",      LMP_EV5         },      /* Bit 1 */
> >               { "<no. 34>",           0x04            },      /* Bit 2 */
> > -             { "<AFH cap. slave>",   LMP_AFH_CAP_SLV },      /* Bit 3 */
> > -             { "<AFH class. slave>", LMP_AFH_CLS_SLV },      /* Bit 4 */
> > +             { "<AFH cap. perip.>",  LMP_AFH_CAP_SLV },      /* Bit 3 */
> > +             { "<AFH cls. perip.>",  LMP_AFH_CLS_SLV },      /* Bit 4 */
> >               { "<BR/EDR not supp.>", LMP_NO_BREDR    },      /* Bit 5 */
> >               { "<LE support>",       LMP_LE          },      /* Bit 6 */
> >               { "<3-slot EDR ACL>",   LMP_EDR_3SLOT   },      /* Bit 7 */
> > @@ -746,8 +746,8 @@ static hci_map lmp_features_map[8][9] = {
> >               { "<5-slot EDR ACL>",   LMP_EDR_5SLOT   },      /* Bit 0 */
> >               { "<sniff subrating>",  LMP_SNIFF_SUBR  },      /* Bit 1 */
> >               { "<pause encryption>", LMP_PAUSE_ENC   },      /* Bit 2 */
> > -             { "<AFH cap. master>",  LMP_AFH_CAP_MST },      /* Bit 3 */
> > -             { "<AFH class. master>",LMP_AFH_CLS_MST },      /* Bit 4 */
> > +             { "<AFH cap. central>", LMP_AFH_CAP_MST },      /* Bit 3 */
> > +             { "<AFH cls. central>", LMP_AFH_CLS_MST },      /* Bit 4 */
> >               { "<EDR eSCO 2 Mbps>",  LMP_EDR_ESCO_2M },      /* Bit 5 */
> >               { "<EDR eSCO 3 Mbps>",  LMP_EDR_ESCO_3M },      /* Bit 6 */
> >               { "<3-slot EDR eSCO>",  LMP_EDR_3S_ESCO },      /* Bit 7 */
> > diff --git a/lib/mgmt.h b/lib/mgmt.h
> > index 0a6349321a..0d1678f01d 100644
> > --- a/lib/mgmt.h
> > +++ b/lib/mgmt.h
> > @@ -179,7 +179,7 @@ struct mgmt_cp_load_link_keys {
> > struct mgmt_ltk_info {
> >       struct mgmt_addr_info addr;
> >       uint8_t type;
> > -     uint8_t master;
> > +     uint8_t central;
> >       uint8_t enc_size;
> >       uint16_t ediv;
> >       uint64_t rand;
> > diff --git a/monitor/control.c b/monitor/control.c
> > index 266602a34c..dad23a0e62 100644
> > --- a/monitor/control.c
> > +++ b/monitor/control.c
> > @@ -308,13 +308,13 @@ static void mgmt_new_long_term_key(uint16_t len, const void *buf)
> >       /* LE SC keys are both for master and slave */
> >       switch (ev->key.type) {
> >       case 0x00:
> > -             if (ev->key.master)
> > +             if (ev->key.central)
> >                       type = "Master (Unauthenticated)";
> >               else
> >                       type = "Slave (Unauthenticated)";
> >               break;
> >       case 0x01:
> > -             if (ev->key.master)
> > +             if (ev->key.central)
> >                       type = "Master (Authenticated)";
> >               else
> >                       type = "Slave (Authenticated)";
> > diff --git a/src/adapter.c b/src/adapter.c
> > index ddd8967515..ac1e02af6c 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -4122,7 +4122,7 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
> >               key->rand = cpu_to_le64(info->rand);
> >               key->ediv = cpu_to_le16(info->ediv);
> >               key->type = info->authenticated;
> > -             key->master = info->master;
> > +             key->central = info->master;
> >               key->enc_size = info->enc_size;
> >       }
> >
> > @@ -8307,7 +8307,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
> >               rand = le64_to_cpu(key->rand);
> >
> >               store_longtermkey(adapter, &key->addr.bdaddr,
> > -                                     key->addr.type, key->val, key->master,
> > +                                     key->addr.type, key->val, key->central,
> >                                       key->type, key->enc_size, ediv, rand);
> >
> >               device_set_bonded(device, addr->type);
> > diff --git a/tools/oobtest.c b/tools/oobtest.c
> > index c095036fe7..0368bc3865 100644
> > --- a/tools/oobtest.c
> > +++ b/tools/oobtest.c
> > @@ -133,13 +133,13 @@ static void new_long_term_key_event(uint16_t index, uint16_t len,
> >
> >       switch (ev->key.type) {
> >       case 0x00:
> > -             if (ev->key.master)
> > +             if (ev->key.central)
> >                       type = "Unauthenticated, Master";
> >               else
> >                       type = "Unauthenticated, Slave";
> >               break;
> >       case 0x01:
> > -             if (ev->key.master)
> > +             if (ev->key.central)
> >                       type = "Authenticated, Master";
> >               else
> >                       type = "Authenticated, Slave";
>
> These strings you could have changed. It is just a test tool and not installed.

Actually, I changed them in patch 05/12.

So I tried to respect the "one directory - one patch" policy. However
sometimes changes need to be done cross-directory so no way we can
enforce that rule without having compile errors.
Therefore, I only make the minimum necessary changes in the other
directories so the code can still be compiled while respecting the
"one directory - one patch" policy as much as possible.

In this patch 01/12, the changes are inside the /lib directory, so
cross-directory changes, such as to /tools/oobtest.c, are unavoidable.
However I prefer to update the files inside tools in their own patch
(05/12), so only the necessary changes are made in patch 01/12.

Regards,
Archie
