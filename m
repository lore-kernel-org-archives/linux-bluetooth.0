Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50367C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 09:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjCPJz2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 05:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjCPJzZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 05:55:25 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E234196B4
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 02:54:54 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v2-20020a056830090200b0069c6952f4d3so624382ott.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 02:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678960489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyPonuJpZPidvHoqyiiruN24ythJvcvhCRR+oFRBUQo=;
        b=WyWOmRYmWcARaQCKIPx+a6QDZPLHID9oiKEAMY+tiT94N8XaE2hCNwpz6cthuoqsIC
         ZAktAfvp1rs4auNQ3CUVx1jJm4azn+SV6VKXrpqxM0kO/Xm/msc058zKrLNtBeuB8Sme
         fkhw0vzc3NE3W/dene1RTv5OEQgLg0EV9JiPBCNC2pNg9Klwf2bDAdeCWeSraWx8dJ23
         cSjTxL7kDc4N80/SrzIuSVD48LcyzpRDkGvOUNCm2/Uul7QVm3K+G4LkVBn7K7uo23ay
         f6Rrf/77JRtZ/vH2zoQRyr4Fm9wYGEqByxWv8Ux+L80WogoaxMQ2cuwGSLsWw0lIZoYF
         BF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678960489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyPonuJpZPidvHoqyiiruN24ythJvcvhCRR+oFRBUQo=;
        b=Xzy9WjyRUjEwFHJTxXfv2iS9g/imkOmD6xvRmyHF9ELYGvwDGnbBh6mLO5k7t2Qo6s
         xflHed2CbAjQzB+Ol5u0w75z6pVvme+cgP8iYAbr5EWl43RJxiCIIqe6/t+snnqboNir
         s7m7Cib0NHqhFNoRd3F6vLemYuzN2SqVQlw+6Md5lGOb4EDNTnFUL/mvDkCsZ3dyJgoJ
         tAn1b3+H7mOI6lLeROGHWV9LVuu2o6ZE2FkCR+j3UtbRxX0gCGp1AvD06o1JozqdXyWG
         YmfaDvMC7FhvbRUTEV/dai8IiBvV0SsjhQSaeahETO5pjh/MEFcKioYf5dZsmKx+ZMzM
         x1nQ==
X-Gm-Message-State: AO0yUKXYsE6B3EP9yo5X8D2J2vTYtHDF+r4QDhXO0tCxri1bHQvIApkT
        cYXgasCzSr2SrFKgU50MrKNW0Aei1BgcbBpon3SMkQ==
X-Google-Smtp-Source: AK7set8ESZuKFscSM5ferhiXnh130+wa+CzR5SXyFtwgeeEzFZ+4AkmMqxD1bMJYgiKOMVTt9xBpvcWhDnsBF8JYhpU=
X-Received: by 2002:a9d:12e9:0:b0:698:f988:7c37 with SMTP id
 g96-20020a9d12e9000000b00698f9887c37mr2280261otg.3.1678960488957; Thu, 16 Mar
 2023 02:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230316151018.v1.1.I9113bb4f444afc2c5cb19d1e96569e01ddbd8939@changeid>
 <116b1db5-bf75-9fbf-c37b-2fe1028ddaeb@molgen.mpg.de>
In-Reply-To: <116b1db5-bf75-9fbf-c37b-2fe1028ddaeb@molgen.mpg.de>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Thu, 16 Mar 2023 17:54:37 +0800
Message-ID: <CAPHZWUffEUY_OpW+zzpGWe7L5GfOgfgpOqHrJ8Ov2jhBum9ceg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: mgmt: Fix MGMT add advmon with RSSI command
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Archie Pusaka <apusaka@chromium.org>,
        Brian Gix <brian.gix@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for the reply!
A new patch has been sent.
Please take a look when available.

Thanks,
Howard


On Thu, Mar 16, 2023 at 5:47=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Howard,
>
>
> Thank you for your patch.
>
> Am 16.03.23 um 08:10 schrieb Howard Chung:
> > From: howardchung <howardchung@google.com>
>
> Please configure your full name:
>
>      git config --global user.name "Howard Chung"
>      git commit -s --amend --author=3D"Howard Chung <howardchung@google.c=
om>"
>
> > The MGMT command: MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI uses variable
> > length argumenent. This patch adds right the field.
>
> argument
>
> Were you seeing actual problems? If so, please describe the test setup.
>
> > Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> > Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
> > Signed-off-by: howardchung <howardchung@google.com>
> > ---
> >
> >   net/bluetooth/mgmt.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 39589f864ea7..249dc6777fb4 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -9357,7 +9357,8 @@ static const struct hci_mgmt_handler mgmt_handler=
s[] =3D {
> >       { add_ext_adv_data,        MGMT_ADD_EXT_ADV_DATA_SIZE,
> >                                               HCI_MGMT_VAR_LEN },
> >       { add_adv_patterns_monitor_rssi,
> > -                                MGMT_ADD_ADV_PATTERNS_MONITOR_RSSI_SIZ=
E },
> > +                                MGMT_ADD_ADV_PATTERNS_MONITOR_RSSI_SIZ=
E,
> > +                                             HCI_MGMT_VAR_LEN },
> >       { set_mesh,                MGMT_SET_MESH_RECEIVER_SIZE,
> >                                               HCI_MGMT_VAR_LEN },
> >       { mesh_features,           MGMT_MESH_READ_FEATURES_SIZE },
>
> Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul
