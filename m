Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C195C55181
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 21:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20852078C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 21:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuzOCJhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgDTVF2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725897AbgDTVF2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 17:05:28 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A111C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 14:05:27 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 8so10132973oiy.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LsK1wbtlNu6xEYcZi8/gnr/MAqwU3/mJ7ZfKr2g6zm4=;
        b=tuzOCJhV7d+A/N6DnBKSg86zGObjDTy1nZtUxlbjR7V+a8nUWlULBpOLRTVS0Jjugs
         HhCuROWNr4w0rD9Kp2MNt08+cmqahuDqIczj8aDUcTABZWuHtCWzYX5E5kBhabXSllzl
         nUpi9c8AUZWm0Hr0xPhfZ7SlwLuShxrOsL6Ik3m1a7iTCT8cENXZw0GsRVjhLhX/Wxh/
         ueKY2MKIDGYExlPwKEpwNfG/0ATsazbFDWzZncNWNEx5S3EY9Fw6c/2jCpUe201DjosX
         IVwtCWptJQ9UpwtAro4NgkuY+FHFxD1WUo4uhQLZUX3DN6ilbAA5+S8wWn/hXZePIWNx
         2BaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LsK1wbtlNu6xEYcZi8/gnr/MAqwU3/mJ7ZfKr2g6zm4=;
        b=PrPTRLSzAGlG+Isfaw3v3Uts3zViARluYvUEz7qS5AGPTc4JWXRAa/pnaDFuDIzqAq
         thkcu1RGmzb9JfRRv7cOSjhXO5teJhWXpK911xCYSTkfkXJwy7ycR+CGoLHLikEhHQco
         gwzy2oURE+rqrPkynfnqP7lj/2eMAp2XIWisJ9+9DHgXVDGDW8q3c9O2tF6zHjG0na8w
         +hHEfAXR8Sy5JU/ksWSH8afZuBW8GUvGEgfjIP2vHdCTqqToEjO0Rswn5FODuwOt84f0
         LuHQkva+oeC+j2Xhn6Qq6GUu4bEPG3H8uCfc3GOlwQ3zZTYcwwYHGijciN0wlawwnBEb
         Ts8A==
X-Gm-Message-State: AGi0PuYYtETTXedcytob3fcllZJ7iLN/Uor/hQp7HNJZKCHix1Vyzo53
        wOrFQxVFHNS8YbzhhkuwBAsgCQofJkadoLUtOlabMWg7Lh4=
X-Google-Smtp-Source: APiQypIuB9Qcj7s340cXrOoh8GTrySRmnulveltuw6nit44hnsGPyDSpqf9hok5G5blYALvFBRqTxjX5TSQVEOte5B8=
X-Received: by 2002:aca:f584:: with SMTP id t126mr1016073oih.108.1587416726497;
 Mon, 20 Apr 2020 14:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200420135112.6749-1-scerveau@collabora.com> <20200420135112.6749-2-scerveau@collabora.com>
 <CABBYNZJGFLEQoNqu=Z6pOxTzQ=jUpX1qxYu+rMZo4PyDW51QHQ@mail.gmail.com> <ff94c0ef-5778-8f96-3e91-b4e6ddb66d29@collabora.com>
In-Reply-To: <ff94c0ef-5778-8f96-3e91-b4e6ddb66d29@collabora.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 20 Apr 2020 14:05:15 -0700
Message-ID: <CABBYNZKVTJf8tyn0JbEeR9s2K7TGyaUZRVYof5H0mJOMxQF_fw@mail.gmail.com>
Subject: Re: [PATCH 1/1] add hog ref before adding to instances
To:     scerveau <scerveau@collabora.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Scerveau,

On Mon, Apr 20, 2020 at 11:37 AM scerveau <scerveau@collabora.com> wrote:
>
> Dear Luiz,
>
> Thanks but see my comment below.
>
> On 20/4/20 19:21, Luiz Augusto von Dentz wrote:
> > Hi St=C3=A9phane,
> >
> > On Mon, Apr 20, 2020 at 9:39 AM St=C3=A9phane Cerveau <scerveau@collabo=
ra.com> wrote:
> >>
> >> To avoid a double hog free, need to add a ref
> >> when adding the hog to the slist.
> >>
> >> This bug has been reproduced with gamepad-8718
> >> which was connecting/disconnecting frantically.
> >>
> >> Fix also a typo in the method hog_attach_instance
> >> ---
> >>   profiles/input/hog-lib.c | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> >> index 9c5c814a7..b9b5d565c 100644
> >> --- a/profiles/input/hog-lib.c
> >> +++ b/profiles/input/hog-lib.c
> >> @@ -1357,7 +1357,7 @@ static struct bt_hog *hog_new(int fd, const char=
 *name, uint16_t vendor,
> >>          return hog;
> >>   }
> >>
> >> -static void hog_attach_instace(struct bt_hog *hog,
> >> +static void hog_attach_instance(struct bt_hog *hog,
> >>                                  struct gatt_db_attribute *attr)
> >>   {
> >>          struct bt_hog *instance;
> >> @@ -1373,14 +1373,14 @@ static void hog_attach_instace(struct bt_hog *=
hog,
> >>          if (!instance)
> >>                  return;
> >>
> >> -       hog->instances =3D g_slist_append(hog->instances, instance);
> >> +       hog->instances =3D g_slist_append(hog->instances, bt_hog_ref(i=
nstance));
> >
> > That sounds like like a double ref since bt_hog_new already does add a
>
> Yes but in `hog_attach_instance`, `hog_new` is used and not `bt_hog_new`
> which is indeed reffing. So I dont think there is double ref in this meth=
od.

Yep, you are rigth it is not adding a reference, but that seems on
purpose since on it doesn't use bt_hog_unref:

g_slist_free_full(hog->instances, hog_free);

> Unfortunately when I was preparing the patch, I noticed that another
> instance was added to slist and here you are totally right there is a
> double reference. I will remove this from the initial patch.

Right, I see now that is really missing the ref because
destroy_gatt_req does actually unref its own reference but since we
use hog_new that would destroy the instance so adding the ref should
be the right way to fix this.

>
>
> > reference, so chances are that you may be fixing the the symptom not
> > the real problem which seems that we cannot unref the instances
> > because they are not removed from the parent as it they should, in
> > fact we might need to redesign it a little bit since bt_hog might
> > actually be inefficient when there are multiple instances as it does
> > allocate a new uhid instance of each of then so we might do something
> > like:
> >
> > struct bt_hog_instance {
> >      struct bt_hog *parent;
> >      struct gatt_db_attribute *attr;
> >      struct gatt_primary *primary;
> >      GAttrib *attrib;
> >      GSList *reports;
> >      gboolean has_report_id;
> >      uint16_t bcdhid;
> >      uint8_t bcountrycode;
> >      uint16_t proto_mode_handle;
> >      uint16_t ctrlpt_handle;
> >      uint8_t flags;
> >      unsigned int getrep_att;
> >      uint16_t getrep_id;
> >      unsigned int setrep_att;
> >      uint16_t setrep_id;
> > }
> >
> > That way the instances are indenpendent of the bt_hog which should be
> > 1:1 to a device, while we can have multple instances of
> > bt_hog_instance, if you don't have time to do the rework then lets
> > just add a parent pointer added to bt_hog so we can can remove child
> > instances and resolve the double free.
> >
> >>   }
> >>
> >>   static void foreach_hog_service(struct gatt_db_attribute *attr, void=
 *user_data)
> >>   {
> >>          struct bt_hog *hog =3D user_data;
> >>
> >> -       hog_attach_instace(hog, attr);
> >> +       hog_attach_instance(hog, attr);
> >>   }
> >>
> >>   static void dis_notify(uint8_t source, uint16_t vendor, uint16_t pro=
duct,
> >> @@ -1528,7 +1528,7 @@ static void hog_attach_hog(struct bt_hog *hog, s=
truct gatt_primary *primary)
> >>                          primary->range.end, find_included_cb, instanc=
e);
> >>
> >>          bt_hog_attach(instance, hog->attrib);
> >> -       hog->instances =3D g_slist_append(hog->instances, instance);
> >> +       hog->instances =3D g_slist_append(hog->instances, bt_hog_ref(i=
nstance));
> >>   }
> >>
> >>   static void primary_cb(uint8_t status, GSList *services, void *user_=
data)
> >> --
> >> 2.17.1
> >>
> >
> >



--=20
Luiz Augusto von Dentz
