Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F703C11F64
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 17:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7071761C67
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 17:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhF1Rhe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jun 2021 13:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhF1Rhe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jun 2021 13:37:34 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7128C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 10:35:06 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id s129so19804336ybf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=740a8kCzPIT3mewVULe7dcCE48/gc7fgeTG4RKOGsbo=;
        b=kEzd5YvPpVKwdQM4hLFZ+nf5ywrIoVD8IH3D//xEfrBzcI3K34AZ2PGP6n4ziwDmZk
         djLx1zYfBZQ/HRPha8TvYaaidJYOFdtTH6P2fkYPsJ64UxB2jeQhapFqf0zliX0z1DHt
         EvmmbEERZNhJw0NAHIbHUHSUJbS52T+UQI6ELHuiCs3sSvIA2f50Mt3Fj6Lt6yEsIStv
         9gfSAx1bm6XuOsPXNWw+Hhj3t6YAYhJvtJ4oi9ez+Yihepdht5S7ybszf/G1kWrOzzqV
         ProdLUn3AME55ZZmwKVbVp4rFPDNdiOhD9B04fIrG2V7PtheIRLKZNGK320g5gH64RQW
         1FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=740a8kCzPIT3mewVULe7dcCE48/gc7fgeTG4RKOGsbo=;
        b=g8+ez1wRyFI5h5Vg0SmKGOm2augl5HCMaFZ+xx94Vvh248SHTzF3InHMrvdNH4FDHt
         ynOl23qXORWdNxLq9EtjqrQfAGrjLPZoUWtH8J6hIsRywpUQfCadVPXi12Ort0sNEVG3
         9Y/mWI5GKSJJTxxdPRo4IChN8d+tiTKW0LeAeM6qEqmYBPuheAtrmPPZe3sUFUyVfvNl
         qPUh+us4Lpj4urws2VKuYrMbbAZzIuDCZ+BylxKy5IeUINR7aBFh0PvQRTFcxWR3f5jF
         yI8UVfNxrdJ8IGzxg12RXKV7zwH5FhP+1Wa3Ofy2ahvN972QecRcCPBxOLKErsnd7L/k
         F15Q==
X-Gm-Message-State: AOAM533RJ4m1sZcqcv2hJ5ZBbwKUAz4/5CvtlfAHzzuD5wQoY/3N590m
        KGc6fYNcDxJJnoT3NSDKxSLYb2VLnzwPFN+7krs=
X-Google-Smtp-Source: ABdhPJysFZpTf+ZMD7KpCFvw/Xs0Yd84EED8lckyUmYSmn2Vch1U3oxUInETLcNURf1osNAa+s/QHJJkJxqlbLtRwNs=
X-Received: by 2002:a25:be02:: with SMTP id h2mr33518859ybk.91.1624901706042;
 Mon, 28 Jun 2021 10:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201228142224.Bluez.v1.1.I89c3c683e3dec6439f3b0d2c00da86a2107019af@changeid>
 <CAPHZWUcgjK+NSTj_GozH8jv5AHOfEOxu7mM95VgCq0Zr02Dyhg@mail.gmail.com>
In-Reply-To: <CAPHZWUcgjK+NSTj_GozH8jv5AHOfEOxu7mM95VgCq0Zr02Dyhg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 28 Jun 2021 10:34:55 -0700
Message-ID: <CABBYNZLcE7oKUPQCJhDqV1iwjD7mH_NcuOunUXoMCRnQWeepRg@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] shared/gatt-client: Fix GATT client attribute
 read with offset
To:     Yun-hao Chung <howardchung@google.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Mon, Jun 28, 2021 at 4:57 AM Yun-hao Chung <howardchung@google.com> wrote:
>
> Hi,
>
> Can we get a reply on this patch?
>
> Thanks,
> Howard
>
> On Mon, Dec 28, 2020 at 2:22 PM Howard Chung <howardchung@google.com> wrote:
>>
>> bluez always replies the whole value despite a user specify the offset.
>> This patch fixes the issue.
>>
>> Reviewed-by: sonnysasaka@chromium.org
>> ---
>>
>>  src/gatt-client.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/gatt-client.c b/src/gatt-client.c
>> index 0cf5324ffa46..bec6e1ec049e 100644
>> --- a/src/gatt-client.c
>> +++ b/src/gatt-client.c
>> @@ -368,7 +368,8 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
>>         }
>>
>>         /* Read the stored data from db */
>> -       if (!gatt_db_attribute_read(desc->attr, 0, 0, NULL, read_op_cb, op)) {
>> +       if (!gatt_db_attribute_read(desc->attr, op->offset, 0, NULL, read_op_cb,
>> +                                                                       op)) {
>>                 error("Failed to read database");
>>                 att_ecode = BT_ATT_ERROR_UNLIKELY;
>>                 goto fail;
>> @@ -906,7 +907,8 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
>>         }
>>
>>         /* Read the stored data from db */
>> -       if (!gatt_db_attribute_read(chrc->attr, 0, 0, NULL, read_op_cb, op)) {
>> +       if (!gatt_db_attribute_read(chrc->attr, op->offset, 0, NULL, read_op_cb,
>> +                                                                       op)) {
>>                 error("Failed to read database");
>>                 att_ecode = BT_ATT_ERROR_UNLIKELY;
>>                 goto fail;
>> --
>> 2.29.2.729.g45daf8777d-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
