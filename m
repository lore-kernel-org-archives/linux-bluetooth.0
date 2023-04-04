Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810F8C761A6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Apr 2023 18:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbjDDSIB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Apr 2023 14:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbjDDSIA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Apr 2023 14:08:00 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F8A5243
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Apr 2023 11:07:43 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x17so43474075lfu.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Apr 2023 11:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680631661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjjSq78+U9vIVi3TCaSznp5bSCog9l0PWaRMz2VHjAM=;
        b=gkxSkQfDgtvu5HSrPR1BEtS377tuux4JMgpRckZxIV5DxWLObrAVOssGYck7Zk5IkL
         q5b34SohXCoay4Vax9QVZp+wJnILT+EAKyQ5Zbe8LnFKRQC1MxS1uhSyTNskbMlz8MUR
         bIjg3uQuvm1ZZnWEF4xoTO9VYD6N+l7/D02Cow18oEtKOBCJ/9c3EcyiJBgmlZNElT9g
         G4bUN8qNwJvuf6cgWyIMLRoV6ZlnIz85J3Yw2XVEr6AzC0bxb1FmsAuNl8W9tVa7N2ep
         M3UpVM84nI6lqzbNioILa6JmHYXqbgmAYYm9umly/lsctEqDYIH1yMxbylfrdzQrMQVs
         v4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680631661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjjSq78+U9vIVi3TCaSznp5bSCog9l0PWaRMz2VHjAM=;
        b=3gbSs4+qk0M6PPOkRD5hwCZTWp5PaeG8M2hiWAmU3QziJTTFJNpmHsKIspT/a3V5SU
         VgBkNkqmKnt6z7rgrEpJplwzu8V1csb+dmlFV02GwAKA4XoFbkDm/yWUw3lxDspuo+ho
         DMqDIVdaasB4swVTGfW3Nkym0+0ACPFC/uunXnuAYmLgtQjc4PNCf4pUZDgAPIE9/s06
         F/b/wDeCnGccUAkpQgh9Rm3zJhoE7J2rD6MXQT5dLZwM0WBESNsraOhxTIkwjZo2L1zp
         e0Az5qbugUluUHiLSNNvRp4dcQhJI/JKUdjr36a81E1Q9GAsWFjyb6BVLYgIjz3oqYfQ
         0S7g==
X-Gm-Message-State: AAQBX9eaOH+etHYOxo2S+1ZL8K0VQqVrf/QpKLdmMjB1R8/8Ijf9BEMg
        ZTZLd6LZUNOIQcYsmi3vcq45lHsJpPicBlUNcrhtweDo
X-Google-Smtp-Source: AKy350Zdvp5nDqVRLKfWwo/EvqQcaYwTQg4mhLke5DeJ1O3twu+bvLrEqIjSjj/SDqGy4+3GXV5qIVOCZ9aQlp3Pj9w=
X-Received: by 2002:a19:a40a:0:b0:4ea:e5e3:7eb0 with SMTP id
 q10-20020a19a40a000000b004eae5e37eb0mr986738lfc.10.1680631661307; Tue, 04 Apr
 2023 11:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230404141853.4868-1-claudia.rosu@nxp.com> <20230404141853.4868-2-claudia.rosu@nxp.com>
In-Reply-To: <20230404141853.4868-2-claudia.rosu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 4 Apr 2023 11:07:30 -0700
Message-ID: <CABBYNZKAu18kKjM6G4z-NbSBtqLSWWgOiVFaSYioCMVrnmXQ1A@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: Set ISO Data Path on broadcast sink
To:     Claudia Draghicescu <claudia.rosu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Claudia,

On Tue, Apr 4, 2023 at 7:24=E2=80=AFAM Claudia Draghicescu <claudia.rosu@nx=
p.com> wrote:
>
> This patch enables ISO data rx on broadcast sink.
> Signed-off-by: Claudia Draghicescu <claudia.rosu@nxp.com>
> ---
>  net/bluetooth/hci_event.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 6cf9ae5b14d3..6ecd10069b6e 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6997,6 +6997,7 @@ static void hci_le_big_sync_established_evt(struct =
hci_dev *hdev, void *data,
>                 bis->iso_qos.bcast.in.latency =3D le16_to_cpu(ev->interva=
l) * 125 / 100;
>                 bis->iso_qos.bcast.in.sdu =3D le16_to_cpu(ev->max_pdu);
>
> +               hci_iso_setup_path(bis);
>                 hci_connect_cfm(bis, ev->status);

While the use of hci_iso_setup_path seems correct here we probably
need to remove hci_connect_cfm since we need to wait the result of
Data Path before signal to the socket the controller is ready to
receive data.

>         }
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
