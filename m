Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8116C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 21:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjCWVAb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjCWVAR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 17:00:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FFB2200F
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 13:59:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k37so16538767lfv.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 13:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679605194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36VvR1pl+EJtEq/MbBuyp7eI6y0yRCeU5D9Wbipqa2A=;
        b=A7wM5SyBAiYzo1aINBFO48zy7yTCaA1mRVwQblbyB/hAfuX0VRBticPoKIWjGnbufX
         iH/mS+S57PH9ZKd6eJvGlVZRQkIsnS18pVSFsixfRv4bU7WNfOdIF/XzBOYLAds0Timl
         aE+EujejYvx01H2NGmVlAFoSgj/+Ksqj/9bZzzYQbBgqiTbY/2Buba9c/2hTqWfW94HA
         aT8YKJhPMRCFANqMAFjfoa9eCioAMBnau9HJucbuDz/FyR/hR6padxqLqF/aBBTehsnx
         hwEdWKO33QDd4GOTx+CSz+9mb044lZlUfiLHCUQgTJnA9HKq7GhV32raIqIpjvKxK+mp
         uyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679605194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36VvR1pl+EJtEq/MbBuyp7eI6y0yRCeU5D9Wbipqa2A=;
        b=G1CGuOwHTdNW/YhDPvV9reM583U3ETqwjs38U0fFxMVJNpCLdq0QNBeXF3Msg1hE4q
         +Cyoyymv5GtfMo+9KutO7tockDDgQ0G912PsabteShO095aTnq95rKilPMJv8bRg5ROe
         xpw2AByloY2zCEbWchcuaVSiBdy8fVx+pmcRX/AysgPhqCNSsLTuIYkauxDWNXoUAY3/
         kGDcVEDflG8IZ7eunGeUzV7Q+MxhmUnfzhBr3QS5gYkLIqMzDDxiUESggli9uUYZmprS
         Z8ProdvaZQkE2HJJM+U5/ntGniK3NSVBUzNYkzxW59GXWvzUM+NLZ+xr/KhlyXbbgmMF
         xI9g==
X-Gm-Message-State: AAQBX9eXiC7MjLmEc2eYXN9luqRwsJIp+oukwypCHEOV9NkB0q1URxAB
        UDSpCbCjAjSDPfYZaj1tuHS0P515UBPqhHWSSnxvYmqe
X-Google-Smtp-Source: AKy350YPmsiwMQRtIbXal+65aY4JU4HX/CYYVjTyc+QxU0Aq46IoSS9Vua6ZYovu/j7KJ4Uo3BWm3h86UbETRKCLT0A=
X-Received: by 2002:ac2:51de:0:b0:4ea:e5e3:7eb0 with SMTP id
 u30-20020ac251de000000b004eae5e37eb0mr23159lfm.10.1679605193877; Thu, 23 Mar
 2023 13:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230323103835.571037-1-simon.mikuda@streamunlimited.com> <20230323103835.571037-2-simon.mikuda@streamunlimited.com>
In-Reply-To: <20230323103835.571037-2-simon.mikuda@streamunlimited.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 23 Mar 2023 13:59:42 -0700
Message-ID: <CABBYNZKMXnaPydz5pz2Uasg9MeMhBo5aUW5kRRr14gkte_Zvsw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/9] gatt-db: Fix crash during calculating hash from
 ATT handles
To:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Simon,

On Thu, Mar 23, 2023 at 3:44=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> It happens when next_handle is lower that discovered number of handles.
> Found by PTS test case: GATT/CL/GAD/BC-01-C

Can you add the backtrace of the crash?

> ---
>  src/shared/gatt-db.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index b696fe33d..c9ffbfeed 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -297,6 +297,7 @@ static void handle_notify(void *data, void *user_data=
)
>  struct hash_data {
>         struct iovec *iov;
>         uint16_t i;
> +       size_t size;
>  };
>
>  static void gen_hash_m(struct gatt_db_attribute *attr, void *user_data)
> @@ -327,7 +328,7 @@ static void gen_hash_m(struct gatt_db_attribute *attr=
, void *user_data)
>         case GATT_CHARAC_AGREG_FMT_UUID:
>                 /* Allocate space for handle + type  */
>                 len =3D 2 + 2;
> -               data =3D malloc(2 + 2 + attr->value_len);
> +               data =3D malloc(2 + 2);

This seems to be a different issue, looks like we are allocating more
than necessary.

>                 put_le16(attr->handle, data);
>                 bt_uuid_to_le(&attr->uuid, data + 2);
>                 break;
> @@ -335,6 +336,13 @@ static void gen_hash_m(struct gatt_db_attribute *att=
r, void *user_data)
>                 return;
>         }
>
> +       if (hash->i >=3D hash->size) {
> +               /* double the size of iov if we've run out of space */
> +               hash->iov =3D realloc(hash->iov, 2 * hash->size * sizeof(=
struct iovec));
> +               memset(hash->iov + hash->size, 0, hash->size * sizeof(str=
uct iovec));
> +               hash->size *=3D 2;

Not sure if we should double the size? I'd probably check why we are
not able to allocate the size properly, perhaps we have an off by one
of the next_handle happens to loop around? A better way would be to
just calculate the actual number of attributes instead of using its
handles since there could be spaces in between handles, we could just
iterate over the services since they should each contain the number of
attributes.

> +       }
> +
>         hash->iov[hash->i].iov_base =3D data;
>         hash->iov[hash->i].iov_len =3D len;
>
> @@ -361,9 +369,10 @@ static bool db_hash_update(void *user_data)
>
>         hash.iov =3D new0(struct iovec, db->next_handle);
>         hash.i =3D 0;
> +       hash.size =3D db->next_handle;
>
>         gatt_db_foreach_service(db, NULL, service_gen_hash_m, &hash);
> -       bt_crypto_gatt_hash(db->crypto, hash.iov, db->next_handle, db->ha=
sh);
> +       bt_crypto_gatt_hash(db->crypto, hash.iov, hash.i, db->hash);
>
>         for (i =3D 0; i < hash.i; i++)
>                 free(hash.iov[i].iov_base);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
