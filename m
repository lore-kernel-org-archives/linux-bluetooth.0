Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D876DECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 20:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiJaUsh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 16:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiJaUsf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 16:48:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BCDB10
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 13:48:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p8so21019195lfu.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gmNRX3SLmYrMa7wB4FZHHdqFWFeKVWAsVgygwrr2eeI=;
        b=DrUCDFWmKhCHxKoGC+sBenaqo8irbjP//1bnDoFVkavKo1JWdKYfVvIxM5V8M9MzNa
         iO62UQWQVtrqgRIgtaMjLDe/cKuiuTk8R9NjYx7Pvs/ETO5AGGb+lIFLCJgbclmrVob2
         O+KNV4QoCjzI0iH+kvwUgFRy3cOfCSLJcRRGl0vAgFafDjClhaj0RaXCdQeNskwsuDXO
         9Oar3RkA2p+NqLYSH3pXPuRegaorhtccooWHYm5tMQYdKB7Vo2HRMGv2PGi0IIB2ZZTi
         MuuEsG0lk7WWTJp5rhdtPm6i6oR3cWROISpA6DEShG1z0CO4x1hU442Y7IXshwVTU3Uz
         sZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmNRX3SLmYrMa7wB4FZHHdqFWFeKVWAsVgygwrr2eeI=;
        b=RWP3j2+/VCTn6IO7mrxh9uubSnd6MdyzeQD19Az4ijul7/TY+/AiI1o9LLx8LLtEqa
         FRtrXOz9nhPvQGTXXsxhexoXsg5Pkz9Brmg1ntIzVl64c9KRaeaAyueaDNmU/ikQzCQo
         +gxYKrt4QJNcfkJ5LCHBSmBxE2L4Uj5D4weji6D5/5rJdRfe7i4a4H3smj4h2dk24qPL
         U6CCtWSW3ZT6s4UaCLeh3nVsPedqiDEUir27r2K4VVx2uteTO6ZbGygbjLv7NsZC3Bpp
         JrvPm498HeJrE2K/0ksGPhSAzaZxB4hvHjGP0A68IC845AO309GiOkqQpb6C0VNJCfOp
         y+Tw==
X-Gm-Message-State: ACrzQf1FtYq3RxKz5++9M2JCFmmH7qTmrAUqSJ9GLJuCD59fm9c2SBo3
        sjezJ4eYeIsDoewpokFDB07u9G6CoiXhFqO1aMeFeKf9mAc=
X-Google-Smtp-Source: AMsMyM7ffMlTQFRL40Pg6JfpIl+OOgQ3HbX1JtNrVu/wT2XCVQ23d0KBzu9WyB8W/yrmF2jGYY8Xe574twyCwFMhdGc=
X-Received: by 2002:a05:6512:3f2a:b0:4ae:612b:f47b with SMTP id
 y42-20020a0565123f2a00b004ae612bf47bmr5805043lfa.106.1667249312271; Mon, 31
 Oct 2022 13:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221029170408.175533-1-abhay.maheshbhai.maheta@intel.com> <20221029170408.175533-2-abhay.maheshbhai.maheta@intel.com>
In-Reply-To: <20221029170408.175533-2-abhay.maheshbhai.maheta@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 31 Oct 2022 13:48:20 -0700
Message-ID: <CABBYNZ+VMZ6Fx-J7=VOO8zPtqG-2xksubhs=Ka3seVSQjfVFOg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] shared/bap: Fix handling for Company ID and
 Vendor Codec ID
To:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhay,

On Sat, Oct 29, 2022 at 9:53 AM Abhay Maheta
<abhay.maheshbhai.maheta@intel.com> wrote:
>
> This adds fixes for handing for Company ID and Vendor Codec ID
> while adding PAC record to database and responding to Attribute
> Read Request for Sink/Source PAC Characteristics.
> ---
>  src/shared/bap.c | 5 +++++
>  src/shared/bap.h | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index c3c0d596f..0ae0eba33 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -416,6 +416,8 @@ static void pac_foreach(void *data, void *user_data)
>
>         p = iov_add(iov, sizeof(*p));
>         p->codec.id = pac->codec.id;

Lets check if the codec.id is 0xff before attempting to assign these
values, btw since they are le16 we need to use cpu_to_le16 when
assigning.

> +       p->codec.cid = pac->codec.cid;
> +       p->codec.vid = pac->codec.vid;
>
>         if (pac->data) {
>                 p->cc_len = pac->data->iov_len;
> @@ -2415,6 +2417,9 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
>         if (!bdb)
>                 return NULL;
>
> +       if ((id != 0xff) && ((cid != 0U)  || (vid != 0U)))
> +               return NULL;
> +
>         codec.id = id;
>         codec.cid = cid;
>         codec.vid = vid;
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index 7b9f88c83..923669f32 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -39,8 +39,8 @@ struct bt_bap_stream;
>
>  struct bt_bap_codec {
>         uint8_t  id;
> -       uint16_t vid;
>         uint16_t cid;
> +       uint16_t vid;
>  } __packed;
>
>  struct bt_ltv {
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
