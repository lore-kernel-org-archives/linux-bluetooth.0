Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37638ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 21:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiJaVNr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 17:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiJaVNq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 17:13:46 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCB5CD8
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 14:13:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g12so21183335lfh.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 14:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aIHprNu6ukh+i8/vzyfKlhhnqNUtNTwmn/HNYIpthK0=;
        b=UFT4WEtDdxnNBGl9d8rpArGQaJg9iEuQoWOjRFWT43mTYM0ZZITaq5AY3BqGrMtBBq
         zAI337xBHFkPFPDL/HvSgmDSI7lKwlc4+QsIiZQKnUP7PpeGzgzdfdVwo1Ju4dDqTVMX
         flq/cNlOxh52sViunEPqCGIZsJAdYqTsO+opAmbIRhMprrEU/cxgzmLo/bEYLp9f2Raj
         iukAVnubWaYeav3nL2RMrvQ+dK5UNMWtqpCeeyDyXS16j4si/rWSGPjuO8ePe3e7Rc8M
         8q/HHE+OfOSqYn+OI5o5ghoOsPCfVUvg46LqKh+ATQhSkqryC0+1Q5bnzWenJO3xOuc+
         6tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIHprNu6ukh+i8/vzyfKlhhnqNUtNTwmn/HNYIpthK0=;
        b=SRCsuqsd2HI3rjq7kpBycWnaZ1JbhM0e/ObJVrSiGb1vUBCFLkqMaBwBm9tn+zLCnS
         gK0N11k7d8K2L3WPXxCOyHscMltBX3O/a/Q7PWOA6XF1j5s4O5pOkVug380tzpDzxWj3
         +GMdZZaStcGwtinLFyxoVAyMmMnuWlhVt887O/i7DeRIMLN5agijlPCgAeX2dIguWQxz
         +bNxuK/Da7wGk+SLH72P0IoGjUIwh7q8vOaZdPYD+aCqGiGc4XH2SqD4ODTIHTInVAiV
         WfbOlVFU3NYH+OFdnFSqToDKSoPoSKkLu093h4LRuSXBwqALKFJUUW52eXfdKFOuOEj1
         hAdQ==
X-Gm-Message-State: ACrzQf2DBiBB1cjqme5aRktN52wk7OuB2AXFM306/o2ryA13Z+qdak0G
        xdrSmXYnO3OhPvsPCnZWyF6tIYo0bwmgoq/shjw=
X-Google-Smtp-Source: AMsMyM7t3YaRwMswbLsdTkevMhwBl92I82iGDof/4PCXSgOyVr+/APsi2yXFYCHmGxEcsQtrRs+YPZzr0PdTx6hPFdM=
X-Received: by 2002:a05:6512:483:b0:4a2:6905:dfae with SMTP id
 v3-20020a056512048300b004a26905dfaemr6417694lfq.57.1667250822389; Mon, 31 Oct
 2022 14:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221029170408.175533-1-abhay.maheshbhai.maheta@intel.com> <20221029170408.175533-3-abhay.maheshbhai.maheta@intel.com>
In-Reply-To: <20221029170408.175533-3-abhay.maheshbhai.maheta@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 31 Oct 2022 14:13:30 -0700
Message-ID: <CABBYNZKK-Wu++X8dOwprTS4n+Ws_JXLJrhOLs5DKnu2NCRLNnQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/5] shared/bap: Add support to set stream metadata
To:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhay,

On Sat, Oct 29, 2022 at 9:54 AM Abhay Maheta
<abhay.maheshbhai.maheta@intel.com> wrote:
>
> From: "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>
>
> This adds new API to set stream metadata.
> ---
>  src/shared/bap.c | 20 ++++++++++++++++----
>  src/shared/bap.h |  2 ++
>  2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 0ae0eba33..cc89d65a3 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -2787,7 +2787,7 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
>                 struct bt_pac *p;
>                 struct bt_ltv *cc;
>                 struct bt_pac_metadata *meta;
> -               struct iovec data, metadata;
> +               struct iovec data, *metadata = NULL;
>
>                 p = iov_pull_mem(&iov, sizeof(*p));
>                 if (!p) {
> @@ -2816,13 +2816,16 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
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

Not quite sure why we need to allocate memory on the heap here?
bap_pac_new does iov_dup so it would end up having the same result,
besides I think metadata is liked now since I don't see any free.

>                 iov_pull_mem(&iov, meta->len);
>
>                 pac = bap_pac_new(bap->rdb, NULL, type, &p->codec, NULL, &data,
> -                                                               &metadata);
> +                                                               metadata);
>                 if (!pac)
>                         continue;
>
> @@ -4567,6 +4570,15 @@ struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_bap_stream *stream)
>         return &stream->qos;
>  }
>
> +void bt_bap_stream_set_metadata(struct bt_bap_stream *stream,
> +                               struct iovec *meta)
> +{
> +       if (!stream)
> +               return;
> +
> +       stream->meta = meta;

Were we probably need to use iov_dup as well, in fact we do have
stream_metada that should handle this properly so perhaps you want to
update bt_bap_stream_metadata and check if the has _not_ been enabled
yet just call stream_medata with rsp=NULL so this would store the
contents of meta into stream->meta locally instead of attempt to use
BT_ASCS_METADATA to update it in the server.

> +}
> +
>  struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream)
>  {
>         if (!stream)
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index 923669f32..0c83726da 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -249,6 +249,8 @@ uint8_t bt_bap_stream_get_dir(struct bt_bap_stream *stream);
>  uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream);
>  struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream);
>  struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_bap_stream *stream);
> +void bt_bap_stream_set_metadata(struct bt_bap_stream *stream,
> +                                       struct iovec *meta);
>  struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream);
>
>  struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream);
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
