Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BB0C3DA78
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Jan 2023 20:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjAMUmc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Jan 2023 15:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjAMUma (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Jan 2023 15:42:30 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCB38793C
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jan 2023 12:42:28 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id y19so2353206ljq.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jan 2023 12:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SrgzAQowrS3UwmksIPIBQcj8wLvZ/KEDNoTak6lFfyI=;
        b=RYZAzuA3QkDWefRdzmNWK0fjSeUJOIFLydI2XDNH2jrTJIj18mshkj5vU33Ol4WFMi
         Ryd0+oiGQHTW1sFjh9YPllKc9LvNp3MYLzicfwXR0XjmsTwJZwfL9XjDtT4LFeemuo+O
         wtJIKQBicd67wwiP4SNOHSD4IOdVlXsX7WKbYg3RLf+sXOZt16Pkj5rs74HMJOurp0Zb
         ew/T5lVIILa6Eei/4+GWM+1MvjztG7fRatBgLHk/xewIn/3bdqza+5GUyH5UThMNtncB
         qd5cqHP2OW/PqC4hCCTq9qZ5sMl1CWB8zhKKY/UIf9mfuNXIo/7CKopevFDtRBmF/Nrb
         h1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrgzAQowrS3UwmksIPIBQcj8wLvZ/KEDNoTak6lFfyI=;
        b=c6SKMCBWSWEjNTk4FGWEyMwOgwY03Qp2EWhEmbk3dU4lAall862div/JZzJ4cA3rUW
         ce6a4XKE3aGNjfiuCV2d/qSf3Pp6awsog+6Bxk3PiQ9CX4916Ek+9M0pLvdbbkcwIILC
         yHeZDNMPOuREn7omDz5OiDDUewAmSbzP5LmhbVhXGbOZT6DLio9XcY2x4GbTbUmKyOpo
         ja/kREFdqvxx9qwtKFjWZYxnJFJiFDeRhdmsspDoiDy/KUakTeSWE02Mv+cAj3t14bTD
         bsUTTaRu1Xsl8cWnpkUO0xN3W6T8BiwoLAzKfv8q7p+7Xy+L56FLEw1OVzLE5Vqj0Qom
         89/Q==
X-Gm-Message-State: AFqh2kpGIMFpSOx+424EuN7pYLj4dfu0nP5BmQ8pYsfiwzmbszzivp64
        vSZudMbtzZ4YmFUy1o2cRmUUxfo+6idmSBqi3Ww=
X-Google-Smtp-Source: AMrXdXsHfGWOiNGYZfrf84r/3PgyDXqe8/r4E0H6JLFbTayJESUpTMIvvw+rjFoHnxqj4HlrDG4GhJaIYQ+jnpB7gaw=
X-Received: by 2002:a2e:8750:0:b0:28b:63dc:4c7 with SMTP id
 q16-20020a2e8750000000b0028b63dc04c7mr241229ljj.423.1673642546766; Fri, 13
 Jan 2023 12:42:26 -0800 (PST)
MIME-Version: 1.0
References: <20230113050604.71398-1-abhay.maheshbhai.maheta@intel.com>
In-Reply-To: <20230113050604.71398-1-abhay.maheshbhai.maheta@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 13 Jan 2023 12:42:15 -0800
Message-ID: <CABBYNZ+_zBr_RcMUcXPyHzroakz4zRb3OvqaY6b+7mmA9+2ypA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3] shared/bap: Fixing Company ID, Vendor ID and
 Metadata handling
To:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, Abhay Maheta <mabhay125@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhay,

On Thu, Jan 12, 2023 at 9:11 PM Abhay Maheta
<abhay.maheshbhai.maheta@intel.com> wrote:
>
> This fixes Company ID, Vendor Codec ID and metadata storing
> PAC record.
> ---
>  src/shared/bap.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 0cafb75e6..463cdb7a6 100644
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

I'm trying to understand why you have done an extra copy of the
metadata if later it will be copied by the likes of util_iov_dup
inside bap_pac_new?

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
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
