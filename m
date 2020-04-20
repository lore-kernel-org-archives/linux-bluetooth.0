Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDC9C3815B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 17:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB01C21744
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 17:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq4u1SJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgDTRV5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTRV5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 13:21:57 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1ACC061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 10:21:57 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id i22so8788851otp.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/JMZgsOQj0TdBhE9VTKcNsArH+4yfXM/xRJ8Fbc/urk=;
        b=Tq4u1SJOOnHglkQHjWRaxhWEGdcSvb7Wh7vHR8kBnIclovmZ5JgIbSopk5118388qA
         fQY5pRTEUXXws8vEhBcwtcEMtlpjPlmiJP1nOLBqK4PRUbol2ykERlfHOBKjf91wVUpD
         fgWthbZHZTYzzuXKYhqcFNkwLFmWYqxS8XJTldeD7q+dY9ZYzjZ3Jy5N2sn+/mP76KH9
         gyC4NINOfy5OzJYpEc1YBhSnsbahjCyWZWYIGTQYLYX+4KBaSDbP53ziw8XyJsOsB9vo
         pckkwhkKQjWkuRAQsSaelOiiGWPCoGno+vvKIrtmoRoaRoDCBT7pnUxP6NPNJPPAwaSH
         rFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/JMZgsOQj0TdBhE9VTKcNsArH+4yfXM/xRJ8Fbc/urk=;
        b=aSDXIaidsrmFJFbF4OLy9/mp6JJDCYS1/PBf6Iq/ux2bsz2dRdJxXvbxvMd0DT44t0
         atZfQfIK0guw5gbBgKQMxhnjkKmBLpcBJXxB7Y3Cvndz0eAl6yqHbpdCWQ5K7wTdfebY
         QZ9eAKObI0gSqvEMIRdwG4VOa/xvdXuTg6JqYqMSYwXHFrp5L7f1Z0mqJhTsaqKh+qpw
         oBWbjK7PyngIkR5F2DixIN51G1dqURD5Bw6yKQ4/ws6X8Yrjak9vRRXybVpSZ+CKfhW6
         Hr//TgvnexPZCiLXH7ArmypaSAGr9Ji56qcomRordFenTyKKD7G1x3UKTNvsfey0Ldk6
         IETQ==
X-Gm-Message-State: AGi0PuaHqIKJ0wZyuio+XpjihfKT97CB4ueSNbP82Xxgw407TkHm2RlP
        EQxXoYdF55LWnCbwQk9A9ivp+jCWu3dB4JzmDVb5cFfsHTw=
X-Google-Smtp-Source: APiQypLwBOHsO9fRiW/PpIFwaQcAnPJ86ae9otpMdtqhk45rh/+NT+xOD58idvuY+ve5QLhJXIaFJuDYFgQvJupJZJg=
X-Received: by 2002:a9d:644:: with SMTP id 62mr9261711otn.177.1587403316228;
 Mon, 20 Apr 2020 10:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200420135112.6749-1-scerveau@collabora.com> <20200420135112.6749-2-scerveau@collabora.com>
In-Reply-To: <20200420135112.6749-2-scerveau@collabora.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 20 Apr 2020 10:21:44 -0700
Message-ID: <CABBYNZJGFLEQoNqu=Z6pOxTzQ=jUpX1qxYu+rMZo4PyDW51QHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] add hog ref before adding to instances
To:     =?UTF-8?Q?St=C3=A9phane_Cerveau?= <scerveau@collabora.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi St=C3=A9phane,

On Mon, Apr 20, 2020 at 9:39 AM St=C3=A9phane Cerveau <scerveau@collabora.c=
om> wrote:
>
> To avoid a double hog free, need to add a ref
> when adding the hog to the slist.
>
> This bug has been reproduced with gamepad-8718
> which was connecting/disconnecting frantically.
>
> Fix also a typo in the method hog_attach_instance
> ---
>  profiles/input/hog-lib.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index 9c5c814a7..b9b5d565c 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -1357,7 +1357,7 @@ static struct bt_hog *hog_new(int fd, const char *n=
ame, uint16_t vendor,
>         return hog;
>  }
>
> -static void hog_attach_instace(struct bt_hog *hog,
> +static void hog_attach_instance(struct bt_hog *hog,
>                                 struct gatt_db_attribute *attr)
>  {
>         struct bt_hog *instance;
> @@ -1373,14 +1373,14 @@ static void hog_attach_instace(struct bt_hog *hog=
,
>         if (!instance)
>                 return;
>
> -       hog->instances =3D g_slist_append(hog->instances, instance);
> +       hog->instances =3D g_slist_append(hog->instances, bt_hog_ref(inst=
ance));

That sounds like like a double ref since bt_hog_new already does add a
reference, so chances are that you may be fixing the the symptom not
the real problem which seems that we cannot unref the instances
because they are not removed from the parent as it they should, in
fact we might need to redesign it a little bit since bt_hog might
actually be inefficient when there are multiple instances as it does
allocate a new uhid instance of each of then so we might do something
like:

struct bt_hog_instance {
    struct bt_hog *parent;
    struct gatt_db_attribute *attr;
    struct gatt_primary *primary;
    GAttrib *attrib;
    GSList *reports;
    gboolean has_report_id;
    uint16_t bcdhid;
    uint8_t bcountrycode;
    uint16_t proto_mode_handle;
    uint16_t ctrlpt_handle;
    uint8_t flags;
    unsigned int getrep_att;
    uint16_t getrep_id;
    unsigned int setrep_att;
    uint16_t setrep_id;
}

That way the instances are indenpendent of the bt_hog which should be
1:1 to a device, while we can have multple instances of
bt_hog_instance, if you don't have time to do the rework then lets
just add a parent pointer added to bt_hog so we can can remove child
instances and resolve the double free.

>  }
>
>  static void foreach_hog_service(struct gatt_db_attribute *attr, void *us=
er_data)
>  {
>         struct bt_hog *hog =3D user_data;
>
> -       hog_attach_instace(hog, attr);
> +       hog_attach_instance(hog, attr);
>  }
>
>  static void dis_notify(uint8_t source, uint16_t vendor, uint16_t product=
,
> @@ -1528,7 +1528,7 @@ static void hog_attach_hog(struct bt_hog *hog, stru=
ct gatt_primary *primary)
>                         primary->range.end, find_included_cb, instance);
>
>         bt_hog_attach(instance, hog->attrib);
> -       hog->instances =3D g_slist_append(hog->instances, instance);
> +       hog->instances =3D g_slist_append(hog->instances, bt_hog_ref(inst=
ance));
>  }
>
>  static void primary_cb(uint8_t status, GSList *services, void *user_data=
)
> --
> 2.17.1
>


--=20
Luiz Augusto von Dentz
