Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAC0C3DA7D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Jan 2023 00:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbjADAZA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Jan 2023 19:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbjADAYz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Jan 2023 19:24:55 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8AD1705F
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jan 2023 16:24:48 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id p2so18316976ljn.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Jan 2023 16:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ohpZ5h2kO5PlGZlhv57eJdlTHKhGiVbzbeWfXNYjnmw=;
        b=ejh1GrcPnGIMsBPdI8+T4w8skMlS0JEXFEIey3nxh6cfQkCNnYWo+IHgYfYXdzvr6G
         MfmXsU7ql9urjkupLIaoK5GdxNeI3aFELa7Hjna8E0sbTaIf9/hF6vUPpBavFGbHVJR8
         LpN/QDw+AJQ/L31UTGDD6i5+a8R5hv+jB54rcLswz+7E3gMMoealOPIMrVq64SXIZtEi
         MuHDCYF7OQXqjake2j9fysPiJroj4A4EyNfhD71Y5Hao7cJ22tO33RLZXV16fa68vbH7
         O/wSBhdDfDyPU/WBxPa0TVe5ZV0HpGI2sGGrh1AuEcvxVlm3pNZ8bcAdeV0Wc367mcv8
         0xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohpZ5h2kO5PlGZlhv57eJdlTHKhGiVbzbeWfXNYjnmw=;
        b=KlgWuwqY5QzNzHrFTsOILuYSI8KblvPxCEYIPOg8fgnlKMmuW2Nkezq0FiIklIr7ID
         FqNH49iMgswOwasuWRkSEYQneFMgJVFlsT1IANocH1Mn5NEJIWX95FDz8V3OIL044LPP
         z1/IsSxeCb27NpZsOf6tTK4i6JrySkvuvrZJlfMAvLLoC8QsU4R7LJJpXp+/0c+6lWTL
         xG/Shh2MHJ5CTo5AC7X95tb8vzoTaVoG4dRqCkNnY6E8/Rf9d2NUSp+TrZGjtSBvapk5
         xTTrcPxKOMIzddQwvx5myd3R3r0Q3Pgl9evlOMkIaHSCHIyxm/yt2v9/O+SzrH82FlbQ
         wMVA==
X-Gm-Message-State: AFqh2kotq1nwcmKQ/OPd6gve2xaaVrcTNcv4msRMhFDbv8b5aBKqed76
        P8VtLGNPJkQYxx1qiV9EKhiFj0yP5RwdZp6cWJ8=
X-Google-Smtp-Source: AMrXdXtk3ZlTg4OUySIKvsDf9UiV/DVK8Zm2WztPsIaro8xrYQ3hRzdKA7+AZbsa8rONUPjVRbqzv/LaZjw5bov2uac=
X-Received: by 2002:a2e:a167:0:b0:27f:b449:11e with SMTP id
 u7-20020a2ea167000000b0027fb449011emr1527650ljl.305.1672791887010; Tue, 03
 Jan 2023 16:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20221229155257.341327-1-abhay.maheshbhai.maheta@intel.com> <20221229155257.341327-3-abhay.maheshbhai.maheta@intel.com>
In-Reply-To: <20221229155257.341327-3-abhay.maheshbhai.maheta@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 3 Jan 2023 16:24:35 -0800
Message-ID: <CABBYNZKmxUeY+S4bkmoWhb2wqWSG88ncOLO2jA8HJbxZ6Pdi2A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 2/6] shared/bap: Add support to set stream metadata
To:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, Abhay Maheta <mabhay125@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhay,

On Thu, Dec 29, 2022 at 7:57 AM Abhay Maheta
<abhay.maheshbhai.maheta@intel.com> wrote:
>
> This adds new API to set stream metadata.
> ---
>  src/shared/bap.c | 30 +++++++++++++++++++++++-------
>  src/shared/bap.h |  2 ++
>  2 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 0cafb75e6..b3c65283e 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -344,8 +344,10 @@ static void pac_foreach(void *data, void *user_data)
>
>         p = util_iov_push(iov, sizeof(*p));
>         p->codec.id = pac->codec.id;
> -       p->codec.cid = pac->codec.cid;
> -       p->codec.vid = pac->codec.vid;
> +       if (p->codec.id == 0xff) {
> +               p->codec.cid = cpu_to_le16(pac->codec.cid);
> +               p->codec.vid = cpu_to_le16(pac->codec.vid);
> +       }
>
>         if (pac->data) {
>                 p->cc_len = pac->data->iov_len;
> @@ -2773,7 +2775,7 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
>                 struct bt_pac *p;
>                 struct bt_ltv *cc;
>                 struct bt_pac_metadata *meta;
> -               struct iovec data, metadata;
> +               struct iovec data, *metadata = NULL;
>
>                 p = util_iov_pull_mem(&iov, sizeof(*p));
>                 if (!p) {
> @@ -2802,8 +2804,11 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
>                 data.iov_len = p->cc_len;
>                 data.iov_base = cc;
>
> -               metadata.iov_len = meta->len;
> -               metadata.iov_base = meta->data;
> +               if (meta->len) {
> +                       metadata = new0(struct iovec, 1);
> +                       metadata->iov_len = meta->len;
> +                       metadata->iov_base = meta->data;
> +               }
>
>                 util_iov_pull_mem(&iov, meta->len);
>
> @@ -2813,12 +2818,14 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
>                 /* Check if there is already a PAC record for the codec */
>                 pac = bap_pac_find(bap->rdb, type, &p->codec);
>                 if (pac) {
> -                       bap_pac_merge(pac, &data, &metadata);
> +                       bap_pac_merge(pac, &data, metadata);
> +                       free(metadata);
>                         continue;
>                 }
>
>                 pac = bap_pac_new(bap->rdb, NULL, type, &p->codec, NULL, &data,
> -                                                               &metadata);
> +                                                               metadata);
> +               free(metadata);
>                 if (!pac)
>                         continue;
>
> @@ -4591,6 +4598,15 @@ struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_bap_stream *stream)
>         return &stream->qos;
>  }
>
> +void bt_bap_stream_set_metadata(struct bt_bap_stream *stream,
> +                               struct iovec *meta)
> +{
> +       if (!stream)
> +               return;
> +
> +       stream_metadata(stream, meta, NULL);
> +}
> +
>  struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream)
>  {
>         if (!stream)
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index 47a15636c..bcf830ceb 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -248,6 +248,8 @@ uint8_t bt_bap_stream_get_dir(struct bt_bap_stream *stream);
>  uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream);
>  struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream);
>  struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_bap_stream *stream);
> +void bt_bap_stream_set_metadata(struct bt_bap_stream *stream,
> +                                       struct iovec *meta);

There is already bt_bap_steam_metadata so Im not sure why you want to
add another one that just set it locally?

>  struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream);
>
>  struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream);
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
