Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7394BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Nov 2022 11:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiKULPA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 06:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiKULOh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 06:14:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B54BEAFD
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 03:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669028900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+hS5Wzvy+tgi/lKBcaZFtWi/x76gJ+HRemIeEuqod0=;
        b=RVss9z+utQj6WcxIlXUbn9m/YTZCaTrSIGBJzlIOac8uc1e3FUQap3vDTL7YEbrjsd3kIw
        SRlRW9MTE3VCCfX20n39hLlOJgW7NYdc/uh57YLkeTwFC7JKMQn89TWtebrrYmBIFrbhXJ
        oicJcyBX9hVnmFkgOoAaM8CnuunVQeY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-558-sak_ll6CMF2P-_xMDOGtVQ-1; Mon, 21 Nov 2022 06:08:14 -0500
X-MC-Unique: sak_ll6CMF2P-_xMDOGtVQ-1
Received: by mail-pj1-f70.google.com with SMTP id pa16-20020a17090b265000b0020a71040b4cso5822028pjb.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 03:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+hS5Wzvy+tgi/lKBcaZFtWi/x76gJ+HRemIeEuqod0=;
        b=7G9hvjYUkVo05IaHflgQaOMuvpeV8Z68c4l9zsbwtTpAu9lMtbo4fM06zhA0Og3GYB
         6hmZGO7hxA30zywLND+4Gx6tNLryBAW0fJEUbCUyZ+tpNCveK8/v8xW68nyHW0gLt1jv
         S0E8QjUOXluV7Fblt9iB+8tSEBZ9U+uLM39g4LGDOwYx4abY+3ZXA0un76Is30LJjw9B
         883zgnlvtu8n6hDpdtaF0yVyeD+9aNzh1YH3G00Ro5J1f34A/q8eX5FSvGEaN6npsgPu
         tXBakPPPCkUHoVhr2EfznMPQzJ/TQLdM8viWw4ZFfvtJo4HRenoakKOgBs+zwIHWQyCF
         qo5Q==
X-Gm-Message-State: ANoB5pllTmwolQaDeeU6pfdKQwEA1Ic4Gg8otMgIcYquJCcKKZhZWfCd
        FDU0atn+af4J+wF+4qzvW+S5TGkQcmM2MHosxdfm64Fh5vrGop2U4UsifrOW+GsD7fDRrys5j81
        WhBaQ6bT9jdgdzDXEh5exH2f2+hIyVjgDOt1qEPEYjQGm
X-Received: by 2002:a17:902:ec01:b0:186:a27d:8e81 with SMTP id l1-20020a170902ec0100b00186a27d8e81mr11240128pld.133.1669028893052;
        Mon, 21 Nov 2022 03:08:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6wXoXKtXWP56fuwVrUAnaldXLeUzJ5VYY2hYxD6WCgQh5rXKJhcsrbgHQGM3Zev6E8w7fKzhJhei8cEHFBqUs=
X-Received: by 2002:a17:902:ec01:b0:186:a27d:8e81 with SMTP id
 l1-20020a170902ec0100b00186a27d8e81mr11240102pld.133.1669028892753; Mon, 21
 Nov 2022 03:08:12 -0800 (PST)
MIME-Version: 1.0
References: <CACT4oucG2z14214jWGJj9XZ5cYMnQpw9CACHvPZ09cbL7m9z_g@mail.gmail.com>
 <100b06a944de88a4b80119c5a2024e0e59cf5243.camel@sipsolutions.net>
 <CACT4oufKgUG5n6Ocgi6r-Z=+Nt9vNVK1e5dJDccogmd8h7xM8Q@mail.gmail.com>
 <5c47143aea07c34dbe95fdb2cab677f2a7a753fb.camel@sipsolutions.net>
 <CACT4ouduybj2Xn_=cgZynf7kF_7tx4cjydkWoTrCAg2=ujR2Tg@mail.gmail.com> <122752227576c059d2b1660934d57e991e7d33c8.camel@sipsolutions.net>
In-Reply-To: <122752227576c059d2b1660934d57e991e7d33c8.camel@sipsolutions.net>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Mon, 21 Nov 2022 12:08:01 +0100
Message-ID: <CACT4oufZpLToemYLHcnQ+hAa=SAbhJT0QxKYjs9fNWV8frsMtg@mail.gmail.com>
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

On Mon, Nov 21, 2022 at 11:42 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Mon, 2022-11-21 at 09:32 +0100, =C3=8D=C3=B1igo Huguet wrote:
> >
> > > --- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> > > +++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> > > @@ -1119,6 +1119,11 @@ int iwl_read_ppag_table(struct iwl_fw_runtime =
*fwrt, union iwl_ppag_table_cmd *c
> > >          int i, j, num_sub_bands;
> > >          s8 *gain;
> > >
> > > +       /* many firmware images for JF lie about this */
> > > +       if (CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id) =3D=3D
> > > +           CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_JF))
> > > +               return -EOPNOTSUPP;
> > > +
> > >          if (!fw_has_capa(&fwrt->fw->ucode_capa, IWL_UCODE_TLV_CAPA_S=
ET_PPAG)) {
> > >                  IWL_DEBUG_RADIO(fwrt,
> > >                                  "PPAG capability not supported by FW=
, command not sent.\n");
> > >
> > >
> > > johannes
> > >
> >
> > Sorry for the delay with this, I had some issues with the hardware.
> >
> > Using this workaround it doesn't show any errors and I can connect.
>
> OK.
>
> > However, using iwlwifi-QuZ-a0-jf-b0-74 from linux-firmware I get lots
> > of errors, both with this patch applied and without it. Maybe the
> > driver needs some changes?
> > I get stack traces, fw dumps and message `iwlwifi 0000:00:14.3: Failed
> > to send MAC context (action:1): -5`
>
> Probably some other error?
>
> > What would you recommend to do? It seems you didn't like this solution
> > very much (and, as I say, it doesn't work with fw 74)
>
>
> Well I think we still need this solution even if I didn't like it, and

Will you post the patch?

> the fw 74 seems to be a different issue - could you post more info about
> separately?

Sure, will do in a few hours, thanks!

>
> johannes
>


--=20
=C3=8D=C3=B1igo Huguet

