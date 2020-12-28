Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50BEC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 12:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92939208B3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 12:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgL1MYy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 07:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbgL1MYy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 07:24:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D714DC061794
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 04:24:13 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id c5so11174956wrp.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 04:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orcam.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Bux0fKYVircx26loAie6xLJ1PXjbaWFXzAdYLDEUatA=;
        b=cm/+Q87+IGzzqubO4krXHtoujIzTGNseUTKVRNllXwKi0F6Y3Vg2W/eAImbHVZh7ef
         G0y96C3+mdZUrAe0ufQaA4g5OuzwkBbkZzl2/tPzwUfRnCVnpJy+DwrKWpgSowFv5foF
         hTK7UbQ1im5C4+225mRRNCRO8V58th9KFOuZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Bux0fKYVircx26loAie6xLJ1PXjbaWFXzAdYLDEUatA=;
        b=KOeQGNrB7buNFjYjCWnD71W9HWGG4DM9ONRt4M4uktffaYuwy7YzZS7oKyNqhLZKVx
         eyt1NmtGMYQxpn0LrQGHxo7BQ9ygy5jf7DEvDp2k9zrfuAmzSnpGmF2jUVHK7onl233/
         UGuSjAMV05WD7HHu+qNw2Ro+2KWPgeLP3KLIkVVzF0L9PTaTBK3XO6w7kVUWoTyy3A6z
         9NIrcnCEjiw3fIX9K6miPV7vS/IWtkmoW/ZuCsCWkgT4hY30E9D/NDn5qrEj+TBlvx8d
         SEWxBrt/dMj60bxF/2dYHDlmrmGT2v6RbE+SrthyCEmKLg26X6uMp20wGKWBMS4g/SCc
         ujMA==
X-Gm-Message-State: AOAM532eWAijy0UYLA4lM2R3zdOOo1iBeXaiTWLU6KrtDHnreGJPhGID
        Rwx1doOEUnm1j4tJHTA5vydQlM8ZuvYVDdKH95txZCCYI7T9u6W1
X-Google-Smtp-Source: ABdhPJyogLfYbhTde2Duo8BohT8bdwjIk1kBkeSoGTt8Og8G2TRR+BfwCIgyuwGNNBhBSb4gu+3D/ZOVSTc4QgdDeO4=
X-Received: by 2002:adf:fdcb:: with SMTP id i11mr51741133wrs.349.1609158252412;
 Mon, 28 Dec 2020 04:24:12 -0800 (PST)
MIME-Version: 1.0
References: <CAB+bgRb6vh4Pv9nZjYGoNXimTGoW1jYjxHk8ouvf6cBb8PcOXQ@mail.gmail.com>
In-Reply-To: <CAB+bgRb6vh4Pv9nZjYGoNXimTGoW1jYjxHk8ouvf6cBb8PcOXQ@mail.gmail.com>
From:   Ordit Gross <ordit.gross@orcam.com>
Date:   Mon, 28 Dec 2020 14:24:01 +0200
Message-ID: <CAB+bgRZrJn3m0_q5LRxEi9AYHNmiqozO61wYfX5pSwqXrho+vw@mail.gmail.com>
Subject: Re: getting address type from scan result
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

just to clarify, the needed information is:
> HCI Event: LE Meta Event (0x3e) plen 37                                                                                                                       #324 [hci0] 1064.855314
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: 5B:6C:86:BE:2C:40 (Resolvable)

the only way I could think of is by opening an hci socket.. is there
any other way?
thanks for your help!


On Fri, Dec 25, 2020 at 6:28 AM Ordit Gross <ordit.gross@orcam.com> wrote:
>
> hi,
>
> Up till now the peripheral device we worked against was configured
> with public address,
> now it might also be random (both BDADDR_LE_RANDOM, BDADDR_LE_PUBLIC).
> The type of address is needed to connect correctly to the device
> (using l2cap_connect).
>
> How can I get the address type from the scan report?
> I'm currently using bluetoothctl, which seems not to expose this
> information in Device1 interface.
> thanks in advance! and happy holidays
>
> --



--
