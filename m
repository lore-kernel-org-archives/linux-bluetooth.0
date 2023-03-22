Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFAAC6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Mar 2023 17:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCVRiy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCVRix (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 13:38:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E744FCDB
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 10:38:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id x20so1440027ljq.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 10:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679506715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zF22gaqOiwaiBrVa1+XuQraAQD/2K5LwX/OhSuEjGM0=;
        b=XwZnDMSg2wcKCRHoRnO5+kqesbzVKIDXWLpgPdeKq1v2+3I3GYF3aOK1jo5KzyMnRX
         nV8m6pOPdX4ZZI6M2EJcGF/LywuDjebXjqEYBbNkAtQ6WRGE0Jo5AYc60EGG0eI79OvB
         iwyb1+zxXed+iJBksO9zXruaklgGDJHnVSBhfjhIACKM4gdeZYb2kwLILXjKSlwpG24q
         zNc+IkKvPCUqbApzW8A9s4g+222IZKV07RQaux5dp2+YEUB4ZXl/YJMmqcANKBDMLDfk
         lWnErncKOjNwu6aHkm9eexPH4EATUy+imikZBA4OpNcSGFS0tz9XoMz4QNc7smZbAgbn
         iTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zF22gaqOiwaiBrVa1+XuQraAQD/2K5LwX/OhSuEjGM0=;
        b=39EgaTjEXUkdazH6/jNGUMUQg3lfQwtWwW995VUSAdgbz3jmSfs4CVCoKE3q/hl0mj
         BY5kd3mVjvUtET3U69GtYbA+GCjbGKfpEBwERys1cKCWXQdaKb/sLqrXoszdAyrI+f3O
         ShgeQ4SmnxCPaABzA3IJHdc/7KMAwEXf3Enk4SUDBy25q4s7njw4wlkYiq4Q025uRNAR
         QIC37t15wq0zMmIkT/aIrAnMpbGYXiZuU7smzPB2MWLZsdhuOPMbkEx77xuQLOBrmnBh
         aJsvEMRZoWAd8R5ZJnTTEwCaVw5ZUKz4asWR/6EgtxSZaVt/bH1vg5YFlQcfGAzWBtHz
         FIKA==
X-Gm-Message-State: AO0yUKUpvbCykHhxj9bO7hnaad18T9mRZh8ja73wW5l3WvuR8RRQGuNL
        zJC/CaOi0tDOSIaQjXfTJziEr7PDdwM5xBfkThWaYzmpNX4=
X-Google-Smtp-Source: AK7set/bZ/pLuxQRZUEiGtTmWdr6hHUiXcZmYXQZb+ZZmBiOSDOR+wCSxmkS9Bay0Xb0/iUTrJwMmJexL7C+X1yNw1w=
X-Received: by 2002:a2e:95d5:0:b0:299:ac68:480b with SMTP id
 y21-20020a2e95d5000000b00299ac68480bmr2332140ljh.0.1679506715434; Wed, 22 Mar
 2023 10:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZJTvEFAESfLqebuUrq6mUAw1ZcQbSMqpfgbMLkGbH_k8A@mail.gmail.com>
 <20230322152347.42109-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230322152347.42109-1-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 22 Mar 2023 10:38:24 -0700
Message-ID: <CABBYNZJfkdbXyJUfg-i88Uorj5rp97ZpbXcRZ2oGt8PmW4tgRw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: Split bt_iso_qos into dedicated structures
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Wed, Mar 22, 2023 at 8:24=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> Hi Luiz,
>
> I have investigated some possible ways to update my patch using your
> suggestions.
>
> I think the most convenient method would be to implement the structure
> as an union of dedicated parameters and to add an additional parameter
> that would indicate the type of QoS the structure is holding.
>
> It would be something like this:
>
> struct bt_iso_bcast_qos {
>     union {
>         struct bt_iso_bcast_src_qos bsrc;
>         struct bt_iso_bcast_snk_qos bsnk;
>     };
> };
>
> enum {
>     BT_ISO_UCAST_QOS,
>     BT_ISO_BCAST_SRC_QOS,
>     BT_ISO_BCAST_SNK_QOS,
> };

We don't really need a type like that because the socket can already
tell what type it is based on the address:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/tree/net/bluetooth/iso.c#n853

> struct bt_iso_qos {
>     int qos_type;
>     union {
>         struct bt_iso_ucast_qos ucast;
>         struct bt_iso_bcast_qos bcast;
>     };
> };
>
> The flow would be something like this:
>
> At socket creation, some default unicast QoS parameters are loaded
> in the qos field of the socket structure.
>
> When the "setsockopt" function is called on an ISO socket from user
> space, the user will provide a bt_iso_qos structure as defined above,
> containing the type of QoS to set and the desired parameters.
> The kernel will validate the parameters depending on their type, and
> it will overwrite the unicast defaults if the check is succesful.
>
> When the user calls other ISO socket APIs, like connect or listen,
> and the procedures to execute are broadcast related, the kernel will
> either use the QoS options that had been previously set by the user,
> or, if the user did not set any options, the unicast defaults will
> be replaced with broadcast defaults, and the procedures will start
> this way.

In case of iso_sock_alloc being called from parent you might be able
to allocate it with proper defaults since you know what address was
used in the parent thus can detect if it is a unicast or broadcast,
also you may need to detect if BT_ISO_QOS is used before bind we can
either reject it or just copy as is but then check_qos shall be run on
bind/connect since only at that point we know the destination address.

> Do you think this is a good design? Please let me know if I should
> proceed with this implementation.

Yep, apart from the comments above.

> Regards,
> Iulia
>


--=20
Luiz Augusto von Dentz
