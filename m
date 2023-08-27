Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A77C83F01
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Aug 2023 21:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjH0VHz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Aug 2023 17:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjH0VHl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Aug 2023 17:07:41 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E0FC1
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Aug 2023 14:07:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b962c226ceso38643051fa.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Aug 2023 14:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693170455; x=1693775255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dNN775pjBsmgQViKDUVndjwBvvds/dteBMfLodcMtM=;
        b=bUWMxjbct1t53caJgO/diQHh1ywjMLzfsIBpiQ4pEQ4IAIKhC9MuKF47O9A9GAk2vI
         +AToCSLdZT8PRIfg2AdH8XsIEtSUBOUO9j6GjOMKlcwc7JEIvZIVCJ41zMBk6VnHOGL+
         PPB4iquh6UmbDMp3RGhSrwwScXqAcboqWCUiaziricd887r5I878TYaUpsbVCugJx+70
         JDb3v4peh4t0maOf8B5RSEXj1BZs6roBBC9ar8JP9YiFgIRTrDsJLsR2LfwLbELzQGv5
         a382nw1yInSotFLv0/9/ZjJLcpGveqiiTVjHuypMJDC/0d3QnLVrYOpQY5hbN27wUFFR
         7vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693170455; x=1693775255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dNN775pjBsmgQViKDUVndjwBvvds/dteBMfLodcMtM=;
        b=D7SCNYpvOug6oEbvhmmvhogDkUo53KOqJr7d4bx59ExxRS1CXbL+xp4TE6AfufwZ2g
         Rf3F3AfHpLMo+zeotF6tA11XSkow+9EUXEDobQEI6b9Sr62luBj0TzutLnA6zTXVuZ0R
         rbsnJC+Y44+NV1K0gQFhV6PgE0XvzckOLNoiPDmRLruZ+DZXi3jkwHrRY80JKyOj7hd4
         o9e/NYBSxK8TLfIgd3mKaqRRQ96t8wUVV3S4FAGCcEUzOAGUODBe/u1Wdo+3G1MwrbbG
         PsxtpKfguJsP876rd7gXbMJmPtrO9LPX5ZmejqEAhiM+4kMx4lZLqK1jRFzWDIPfxTPm
         0Tuw==
X-Gm-Message-State: AOJu0YwE0JlHxAaytNZzz5x2qywWG7aD1MYEcceGlIaaRoTzD+x31Lmo
        D0a4Xdr/b6lAhtVEqed7pG7w9GwNoHfe1aOppHYU5Qy3
X-Google-Smtp-Source: AGHT+IFcB3oXZKrHsE2fztPDZ1CdDtJNtQJgo3OZNpD/4q3t5v2oIRHBaO3+7n1OV9QqTtpXN0/yj/vJgGAyfxFuoDE=
X-Received: by 2002:a2e:b0d8:0:b0:2bc:f5a0:cc25 with SMTP id
 g24-20020a2eb0d8000000b002bcf5a0cc25mr4995271ljl.2.1693170455033; Sun, 27 Aug
 2023 14:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230826192421.7032-1-dev.git@javispedro.com>
In-Reply-To: <20230826192421.7032-1-dev.git@javispedro.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 27 Aug 2023 14:07:22 -0700
Message-ID: <CABBYNZ+jDu9diWc4nB5Z=OTUM2G8=NCVo+t93sa0UUVGq1PUeA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/gatt-client: always send ATT confirmations
To:     Javier de San Pedro <dev.git@javispedro.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Javier,

On Sat, Aug 26, 2023 at 1:08=E2=80=AFPM Javier de San Pedro
<dev.git@javispedro.com> wrote:
>
> I noticed after upgrading 5.66->5.68 that Bluez was no longer sending
> confirmations (ATT opcode 0x1E) in response to indication opcodes (0x1D).
>
> Commit fde32ff9c9c0 ("shared/gatt-client: Allow registering with NULL
> callback") added an early return to the notify_cb function when the
> current client's notify_list is empty. However, in this case, we will
> also not send the confirmation back. This breaks protocol.
>
> The devices I have generally respond to this by stopping
> any new indications until ~15sec timeout or disconnection.
>
> As far as I can see, when using D-Bus API all notify handlers are always
> added on client clones, never on the 'root' client itself (the one
> with !client->parent), so for the root client the notify_list is always
> empty, making this issue very easy to trigger using D-Bus GATT API.
>
> Ensure that we always send the confirmation, even if notify_list is empty=
.
>
> Fixes: fde32ff9c9c0 ("shared/gatt-client: Allow registering with NULL cal=
lback")
> ---
>  src/shared/gatt-client.c | 57 ++++++++++++++++++++--------------------
>  1 file changed, 29 insertions(+), 28 deletions(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index efc013a20..56ecc6a8f 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -2230,45 +2230,46 @@ static void notify_cb(struct bt_att_chan *chan, u=
int8_t opcode,
>                                         void *user_data)
>  {
>         struct bt_gatt_client *client =3D user_data;
> -       struct value_data data;
> -
> -       if (queue_isempty(client->notify_list))
> -               return;

Instead reversing the if logic here you could just use goto to where
we handle the confirmation.

>
>         bt_gatt_client_ref(client);
>
> -       memset(&data, 0, sizeof(data));
> +       if (!queue_isempty(client->notify_list)) {
> +               struct value_data data;
>
> -       if (opcode =3D=3D BT_ATT_OP_HANDLE_NFY_MULT) {
> -               while (length >=3D 4) {
> -                       data.handle =3D get_le16(pdu);
> -                       length -=3D 2;
> -                       pdu +=3D 2;
> +               memset(&data, 0, sizeof(data));
>
> -                       data.len =3D get_le16(pdu);
> -                       length -=3D 2;
> -                       pdu +=3D 2;
> +               if (opcode =3D=3D BT_ATT_OP_HANDLE_NFY_MULT) {
> +                       while (length >=3D 4) {
> +                               data.handle =3D get_le16(pdu);
> +                               length -=3D 2;
> +                               pdu +=3D 2;
>
> -                       if (data.len > length)
> -                               data.len =3D length;
> +                               data.len =3D get_le16(pdu);
> +                               length -=3D 2;
> +                               pdu +=3D 2;
>
> -                       data.data =3D pdu;
> +                               if (data.len > length)
> +                                       data.len =3D length;
>
> -                       queue_foreach(client->notify_list, notify_handler=
,
> -                                                               &data);
> +                               data.data =3D pdu;
>
> -                       length -=3D data.len;
> -                       pdu +=3D data.len;
> -               }
> -       } else {
> -               data.handle =3D get_le16(pdu);
> -               length -=3D 2;
> -               pdu +=3D 2;
> +                               queue_foreach(client->notify_list,
> +                                             notify_handler, &data);
>
> -               data.len =3D length;
> -               data.data =3D pdu;
> +                               length -=3D data.len;
> +                               pdu +=3D data.len;
> +                       }
> +               } else {
> +                       data.handle =3D get_le16(pdu);
> +                       length -=3D 2;
> +                       pdu +=3D 2;
> +
> +                       data.len =3D length;
> +                       data.data =3D pdu;
>
> -               queue_foreach(client->notify_list, notify_handler, &data)=
;
> +                       queue_foreach(client->notify_list,
> +                                     notify_handler, &data);
> +               }
>         }
>
>         if (opcode =3D=3D BT_ATT_OP_HANDLE_IND && !client->parent)
> --
> 2.41.0
>


--=20
Luiz Augusto von Dentz
