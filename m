Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE16C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Nov 2022 08:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiKUIdi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 03:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiKUIdh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 03:33:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A009C1C9
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 00:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669019560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mUjxyZm4bf6OXy+M0eYpXbYeaYwNkkTkGVWURuKWwFs=;
        b=fkLXg5k1MZUCK4DreBD6jIGetoQY62Mn7Imkv4H1YbH6xwFw+uPQfEt6qZQ0EsS5sBVoBy
        lXKY4YUa2fSxztKX+BtRY2IKWND7xjUCBIB6LussMKFGxdnP6MP0IFueWcI6i6J4s3c/XP
        YlKc2HEhJBt6H5BJeSTYt6uzzvHlbaw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-222-du0cLd5BPPKouvsnOoZLbA-1; Mon, 21 Nov 2022 03:32:39 -0500
X-MC-Unique: du0cLd5BPPKouvsnOoZLbA-1
Received: by mail-pg1-f197.google.com with SMTP id h185-20020a636cc2000000b0046fc6e0065dso6511617pgc.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 00:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUjxyZm4bf6OXy+M0eYpXbYeaYwNkkTkGVWURuKWwFs=;
        b=bHF0sR6qmv+ZsB1soytVlveTFcDbibIRvHURwazSwbghCVZTqBEviZ8/0FrMCP+eB9
         s588zkkLT2u/Ce6AqqDcClMGzeUlBB0Bp2XBk2786CnkX25seZKm0ZR+eThZy4U/Deqo
         bKHF9M1Tty/aZumxM75ThlEsDFgXGM0N2FvDldp7wuEdkpv6pb7+VllpdslnDPhxEnK+
         8NKj+t4fwH7k/Wk5fyuFLx7eo394tNUOjs8p/0/XEbr6M+WKu6ioz9HZ2hj1+8j9dj/X
         +om0MpX9Y5a/cJSAOH9R+WwigYZe8XxW3QWgE0IPFNcj8V11Ur7MQPgcZAUY6eJWuKza
         onVQ==
X-Gm-Message-State: ANoB5pk66sUmY6LGhQql9DJNiW8M1sfSNgRwPSlbihwbIDZA+UtREou5
        jJX9E5PBUoXFrFUcjyqclfLj+iFk/L/HeLtiuIC0ccnxkYRWtZekMBReoPKD7PFSqnIZewmLQIF
        fHzVWY3nrkEpTEeKf3fUPIJMXQh+Tbe61nnDdM+KbHQL2
X-Received: by 2002:a62:1d05:0:b0:56b:a0f4:decc with SMTP id d5-20020a621d05000000b0056ba0f4deccmr3700389pfd.33.1669019558562;
        Mon, 21 Nov 2022 00:32:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Y0MdiZQcjiiIrvjhe9UwkMeOFVr4gZrJVlsD14N+QNlAq3C/YmTnSYeUbtXOR72xXUr2Mm52oSXY2tM28rN8=
X-Received: by 2002:a62:1d05:0:b0:56b:a0f4:decc with SMTP id
 d5-20020a621d05000000b0056ba0f4deccmr3700372pfd.33.1669019558251; Mon, 21 Nov
 2022 00:32:38 -0800 (PST)
MIME-Version: 1.0
References: <CACT4oucG2z14214jWGJj9XZ5cYMnQpw9CACHvPZ09cbL7m9z_g@mail.gmail.com>
 <100b06a944de88a4b80119c5a2024e0e59cf5243.camel@sipsolutions.net>
 <CACT4oufKgUG5n6Ocgi6r-Z=+Nt9vNVK1e5dJDccogmd8h7xM8Q@mail.gmail.com> <5c47143aea07c34dbe95fdb2cab677f2a7a753fb.camel@sipsolutions.net>
In-Reply-To: <5c47143aea07c34dbe95fdb2cab677f2a7a753fb.camel@sipsolutions.net>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Mon, 21 Nov 2022 09:32:26 +0100
Message-ID: <CACT4ouduybj2Xn_=cgZynf7kF_7tx4cjydkWoTrCAg2=ujR2Tg@mail.gmail.com>
Subject: Re: iwlwifi: AC9560 firmware crash with iwlwifi-QuZ-a0-jf-b0 versions
 above 55
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     gregory.greenman@intel.com, golan.ben.ami@intel.com,
        jonathan.sade@intel.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        Laura Trivelloni <ltrivell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Oct 5, 2022 at 12:07 PM Johannes Berg <johannes@sipsolutions.net> w=
rote:
>
> On Wed, 2022-10-05 at 11:50 +0200, =C3=8D=C3=B1igo Huguet wrote:
> > On Wed, Oct 5, 2022 at 11:35 AM Johannes Berg <johannes@sipsolutions.ne=
t> wrote:
> > >
> > > On Fri, 2022-09-09 at 12:41 +0200, =C3=8D=C3=B1igo Huguet wrote:
> > > > With an AC9560 installed on a system with Quasar (11th gen processo=
r,
> > > > in my case) we're getting a firmware crash as soon as you try to do
> > > > something with the card. The problem doesn't happen with the card
> > > > installed in older platforms (8th / 9th gen), and it neither happen=
s
> > > > with firmware iwlwifi-QuZ-a0-jf-b0-55 version, but yes with any oth=
er
> > > > newer version.
> > > >
> > > > I've tried different versions of kernel and firmware, including the
> > > > latest kernel and linux-firmware available today, and all of them f=
ail
> > > > unless I remove all fw files above version 55.
> > > >
> > >
> > > I believe this is a duplicate of
> > >
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D214343
> > >
> > > which was supposed to be fixed in firmware, but evidently that fix wa=
s
> > > never backported to older images.
> > >
> > > Internally, FW commit d8887278 fixed this, so FW version 69 should be
> > > OK?
> >
> > I don't think so, we've reproduced it with iwlwifi-QuZ-a0-jf-b0-71.ucod=
e
> >
>
> Indeed, my git-fu was bad. Looks like 74 only fixes it (or will, since
> it hasn't been released, apparently).
>
> We could do some awful workaround like this I guess:
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/w=
ireless/intel/iwlwifi/fw/acpi.c
> index 009a4074d062..0c0a28d748f2 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> @@ -1119,6 +1119,11 @@ int iwl_read_ppag_table(struct iwl_fw_runtime *fwr=
t, union iwl_ppag_table_cmd *c
>          int i, j, num_sub_bands;
>          s8 *gain;
>
> +       /* many firmware images for JF lie about this */
> +       if (CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id) =3D=3D
> +           CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_JF))
> +               return -EOPNOTSUPP;
> +
>          if (!fw_has_capa(&fwrt->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_P=
PAG)) {
>                  IWL_DEBUG_RADIO(fwrt,
>                                  "PPAG capability not supported by FW, co=
mmand not sent.\n");
>
>
> johannes
>

Sorry for the delay with this, I had some issues with the hardware.

Using this workaround it doesn't show any errors and I can connect.

However, using iwlwifi-QuZ-a0-jf-b0-74 from linux-firmware I get lots
of errors, both with this patch applied and without it. Maybe the
driver needs some changes?
I get stack traces, fw dumps and message `iwlwifi 0000:00:14.3: Failed
to send MAC context (action:1): -5`

What would you recommend to do? It seems you didn't like this solution
very much (and, as I say, it doesn't work with fw 74)
--
=C3=8D=C3=B1igo Huguet

