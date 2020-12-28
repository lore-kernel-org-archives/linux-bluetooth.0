Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1056C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 18:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7096221F8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 18:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgL1Sis (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 13:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgL1Sis (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 13:38:48 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30533C0613D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 10:38:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c5so12169153wrp.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 10:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orcam.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3SynhhnpSfmZBc4EjehxAuE/lNkCoBvJ+M+15VOl/g=;
        b=D33B9I4eDTTaO3Lkxs499Dl8C2JkhHhCIaJtWpXERQiPzsZX09zc46px3xb/ClbfpH
         qeze7TOcQze/dMJPx1AvQryAdgokMuKhmc3QjNymJb7BvROemvaJ7nf0ZjtxGVCltNls
         qVVIX+Id0dlqpmcqwXeqr1vceHpQZPZbiFSRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3SynhhnpSfmZBc4EjehxAuE/lNkCoBvJ+M+15VOl/g=;
        b=FEs8ckvAqlNE5hjDesGmTGXgtn1qpEM8ZV0i/iaRfZ74sO/ciGxhlYGU0U61A3sW7X
         vNIkawPI6+WKnEFhmyoBK/sHurQJMhgSQ5SciT8d24LGnQ2dIpbNdJBA2XJuTWODdJZv
         NDbjqP6nbBLnp4/OMcfm76zS8MZtkfleQe4cpAfTnmBRCUFkW40AHb8xdcOCYT6+MN+l
         8tp53NMrxzOFPp++3ZBlkfSdhgk2JwvlxnyiBuhfsKRICOR/gWxBR0vnsRJFcSmUz5om
         iTP2v2rVKP+g7tUrhD7nzjU8cqPuRLk/A7fD4w0W+ujrdQsmlxAfj/7xawUN6CcfSjOV
         Vkag==
X-Gm-Message-State: AOAM532UApCyaFctUejMZtDUJnPauU9qsVsnISwxbnj9AbgcnlRWK6cx
        BYpFL9RI/VgkidTXnRTtv7LWFUJxkjXTeem4Wf1eWD0P9l7ccNRB
X-Google-Smtp-Source: ABdhPJzAp9rAfwZbJ4lDSuYG8PuCzmce8yKw079SxuZQEhHbToJSlfcGyn0xQVfWVomUtSCLGYpn/KdaIGKqadYEcAY=
X-Received: by 2002:adf:9525:: with SMTP id 34mr53471419wrs.389.1609180686946;
 Mon, 28 Dec 2020 10:38:06 -0800 (PST)
MIME-Version: 1.0
References: <CAB+bgRb6vh4Pv9nZjYGoNXimTGoW1jYjxHk8ouvf6cBb8PcOXQ@mail.gmail.com>
 <DB427788-0164-494A-9262-4AA6A2A0F6F4@holtmann.org> <CAB+bgRbsfGedvrQe-BjecUmhOA4-VpLyXEJ44_ninC_hw+YgrQ@mail.gmail.com>
In-Reply-To: <CAB+bgRbsfGedvrQe-BjecUmhOA4-VpLyXEJ44_ninC_hw+YgrQ@mail.gmail.com>
From:   Ordit Gross <ordit.gross@orcam.com>
Date:   Mon, 28 Dec 2020 20:37:56 +0200
Message-ID: <CAB+bgRaOhuFfrOLO5mqvyoEEF7+DNN-EzkqAUM+EM89XtrsrZA@mail.gmail.com>
Subject: Re: getting address type from scan result
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hi Marcel, appreciate your answer, I am using code sample
btgatt-client.c which uses function:
static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t
dst_type, int sec)
is there a way to implement connect without stating the dst_type?
thanks again


> On Mon, Dec 28, 2020 at 2:33 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>>
>> Hi Ordit,
>>
>> > Up till now the peripheral device we worked against was configured
>> > with public address,
>> > now it might also be random (both BDADDR_LE_RANDOM, BDADDR_LE_PUBLIC).
>> > The type of address is needed to connect correctly to the device
>> > (using l2cap_connect).
>> >
>> > How can I get the address type from the scan report?
>> > I'm currently using bluetoothctl, which seems not to expose this
>> > information in Device1 interface.
>> > thanks in advance! and happy holidays
>>
>> it is in the Device1 interface for the Identity Address. Why are you going to connect an L2CAP socket in the first place for a LE device.
>>
>> Regards
>>
>> Marcel
>>
>
>
> --
>


--
