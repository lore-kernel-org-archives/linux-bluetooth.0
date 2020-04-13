Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13083C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 16:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E111D20735
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 16:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsHFFh9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbgDMQo3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731652AbgDMQo2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 12:44:28 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B175C0A3BDC
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 09:44:27 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id i22so275943otp.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h3FT70sCl7qVAuXCc7EIwt54a7Fye9UfOG20K32SiTI=;
        b=SsHFFh9KXlLe6PIIIW/OwCu6WgR9yN0md/6P9LknbsUeiuWJtPdwrMA94/2oBGiqTT
         wdYgfnyrlvYR4K1K3eb+ufGhcZbEJFUdkw4LRpiZT+7C3yhxAAliCO4KtG+MA5snVCCC
         2WWdGUit4UEku0dKpuPVQrjyHgXs7HxNl0eStrY5Dd2kDQJpAopucvxK2E3CZxgq3QIw
         zCmduiMmKFdmSWacbm8ULrn46y/jJoehZM9EHoeSAUGhk+/xGoy8BavXagPEYrfXnonR
         SDor7ttPdBByihTUaL6C8Dvtig7ih/OdMWYcX6zUSJ1IGdEslDK15QXfdouygBMYUZX3
         0I3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h3FT70sCl7qVAuXCc7EIwt54a7Fye9UfOG20K32SiTI=;
        b=rWiXrV9J5lxDgBXdNlDirElrpLKf4x6x/6xiKmCzbb6sVJnHXQyIg+AZePZFLJQcnE
         Z5c1yZiczg7SBOmxA7smROb3/LEjHmTv2yI/dDbLMRYBeTfOegoAEp9IvJl9ga1eUq7A
         okX3ESBp9T6YvBxQFV4YChxum4DowYYe3/xd6ks//Q5oTBgggl+x4GbGJmPr8tWnrTfL
         ulOcyTqglW6H4kyRxHnalxjiC5p/JWJATAzxMEeYqaPmtSJaQeHhqTbi6yA1QU6gRgYW
         N1rCjgusA37NXnMdKgTR+IUX+qraPO0dA+ALpKNqKPQDRkvOhtHx0obVDhgPvB3WVkme
         LQzQ==
X-Gm-Message-State: AGi0PuY4iV5Ic0LmufvADpRw2H+ecOSdMAjwx8VAFANRx86uylNreV0f
        JlSWpZDW4EFPPZBSdo185/5j+Foh/BPmF28lABtIhTEj
X-Google-Smtp-Source: APiQypI8CJkhHdrtIlMSuF7hrz66aLK1GO4JJf8PjotTthoM9ZYKTddtmnJWPB2BUcoPPQiyWO571jRVJzyqEUdA5V4=
X-Received: by 2002:a05:6830:1d4:: with SMTP id r20mr6657851ota.11.1586796266230;
 Mon, 13 Apr 2020 09:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200321195404.fvyku5hmcuqxt7sg@pali> <20200413162513.2221-1-pali@kernel.org>
 <20200413162513.2221-2-pali@kernel.org>
In-Reply-To: <20200413162513.2221-2-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Apr 2020 09:44:14 -0700
Message-ID: <CABBYNZKneybjWDEddrCXxtzJdGZSY__D7qtPuw25QMLDE9hg4Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] src/profile: Distinguish between zero-set HFP AG
 features and unset HFP AG features
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Mon, Apr 13, 2020 at 9:25 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> When HFP AG features are not set then according to HFP 1.7.2 specificatio=
n
> it has value 0b001001. But when HFP AG features were explicitly set to
> zero, bluez did not propagated this value via NewConnection() DBus call, =
so
> callee used default value 0b001001 (according to HFP 1.7.2 specification)
> as bluez did not provided explicit zero value.
>
> To fix this problem add a new boolean variable have_features which
> indicates if SDP features were provided (with possible zero value) or not
> (when default value needs to be used). Code for generating SDP XML record=
s
> were also updated to handle this fact.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  src/profile.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/src/profile.c b/src/profile.c
> index 192fd0245..884440408 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -647,6 +647,7 @@ struct ext_profile {
>
>         uint16_t version;
>         uint16_t features;
> +       bool have_features;
>
>         GSList *records;
>         GSList *servers;
> @@ -669,6 +670,7 @@ struct ext_io {
>
>         uint16_t version;
>         uint16_t features;
> +       bool have_features;
>
>         uint16_t psm;
>         uint8_t chan;
> @@ -920,14 +922,18 @@ static void append_prop(gpointer a, gpointer b)
>         dbus_message_iter_close_container(dict, &entry);
>  }
>
> -static uint16_t get_supported_features(const sdp_record_t *rec)
> +static uint16_t get_supported_features(const sdp_record_t *rec,
> +                                       bool *have_features)
>  {
>         sdp_data_t *data;
>
>         data =3D sdp_data_get(rec, SDP_ATTR_SUPPORTED_FEATURES);
> -       if (!data || data->dtd !=3D SDP_UINT16)
> +       if (!data || data->dtd !=3D SDP_UINT16) {
> +               *have_features =3D false;
>                 return 0;
> +       }
>
> +       *have_features =3D true;
>         return data->val.uint16;
>  }
>
> @@ -972,7 +978,8 @@ static bool send_new_connection(struct ext_profile *e=
xt, struct ext_io *conn)
>         if (remote_uuid) {
>                 rec =3D btd_device_get_record(conn->device, remote_uuid);
>                 if (rec) {
> -                       conn->features =3D get_supported_features(rec);
> +                       conn->features =3D get_supported_features(rec,
> +                                                       &conn->have_featu=
res);
>                         conn->version =3D get_profile_version(rec);
>                 }
>         }
> @@ -991,7 +998,7 @@ static bool send_new_connection(struct ext_profile *e=
xt, struct ext_io *conn)
>                 dict_append_entry(&dict, "Version", DBUS_TYPE_UINT16,
>                                                         &conn->version);
>
> -       if (conn->features)
> +       if (conn->have_features)
>                 dict_append_entry(&dict, "Features", DBUS_TYPE_UINT16,
>                                                         &conn->features);
>
> @@ -1589,7 +1596,8 @@ static void record_cb(sdp_list_t *recs, int err, gp=
ointer user_data)
>                 if (conn->psm =3D=3D 0 && sdp_get_proto_desc(protos, OBEX=
_UUID))
>                         conn->psm =3D get_goep_l2cap_psm(rec);
>
> -               conn->features =3D get_supported_features(rec);
> +               conn->features =3D get_supported_features(rec,
> +                                                       &conn->have_featu=
res);
>                 conn->version =3D get_profile_version(rec);
>
>                 sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free,
> @@ -1750,15 +1758,19 @@ static int ext_disconnect_dev(struct btd_service =
*service)
>  static char *get_hfp_hf_record(struct ext_profile *ext, struct ext_io *l=
2cap,
>                                                         struct ext_io *rf=
comm)
>  {
> +       /* HFP 1.7.2: By default features bitfield is 0b000000 */
>         return g_strdup_printf(HFP_HF_RECORD, rfcomm->chan, ext->version,
> -                                               ext->name, ext->features)=
;
> +                               ext->name,
> +                               ext->have_features ? ext->features : 0x0)=
;
>  }
>
>  static char *get_hfp_ag_record(struct ext_profile *ext, struct ext_io *l=
2cap,
>                                                         struct ext_io *rf=
comm)
>  {
> +       /* HFP 1.7.2: By default features bitfield is 0b001001 */
>         return g_strdup_printf(HFP_AG_RECORD, rfcomm->chan, ext->version,
> -                                               ext->name, ext->features)=
;
> +                               ext->name,
> +                               ext->have_features ? ext->features : 0x9)=
;

I wonder why you didn't just initialize the features wiht 0x9 instead
of adding a flag to track it, btw add a define with value 0x09 like
HFP_DEFAULT_FEATURES that way it is clearer why we are doing this.

>  }
>
>  static char *get_hsp_ag_record(struct ext_profile *ext, struct ext_io *l=
2cap,
> @@ -1948,6 +1960,7 @@ static struct default_settings {
>                                         struct ext_io *rfcomm);
>         uint16_t        version;
>         uint16_t        features;
> +       bool            have_features;
>  } defaults[] =3D {
>         {
>                 .uuid           =3D SPP_UUID,
> @@ -2107,8 +2120,10 @@ static void ext_set_defaults(struct ext_profile *e=
xt)
>                 if (settings->version)
>                         ext->version =3D settings->version;
>
> -               if (settings->features)
> +               if (settings->have_features) {
>                         ext->features =3D settings->features;
> +                       ext->have_features =3D true;
> +               }
>
>                 if (settings->name)
>                         ext->name =3D g_strdup(settings->name);
> @@ -2198,6 +2213,7 @@ static int parse_ext_opt(struct ext_profile *ext, c=
onst char *key,
>
>                 dbus_message_iter_get_basic(value, &feat);
>                 ext->features =3D feat;
> +               ext->have_features =3D true;
>         } else if (strcasecmp(key, "Service") =3D=3D 0) {
>                 if (type !=3D DBUS_TYPE_STRING)
>                         return -EINVAL;
> --
> 2.20.1
>


--=20
Luiz Augusto von Dentz
