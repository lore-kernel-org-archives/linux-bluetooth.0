Return-Path: <SRS0=ITs3=3R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912C9C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 11:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7B624681
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 11:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="2Ql1gmZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgA1L04 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jan 2020 06:26:56 -0500
Received: from mail-vs1-f44.google.com ([209.85.217.44]:44089 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgA1L0z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jan 2020 06:26:55 -0500
Received: by mail-vs1-f44.google.com with SMTP id p6so7787812vsj.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2020 03:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=arNb1j3i4GvNRlcn37kgR9usAhnBUODhruewU4zCDlA=;
        b=2Ql1gmZ8RviEtZ7yzqWOEntCsZwCoCWzTO0KKvirjPnb9RsrqT7ovAd7tx4XAkJXPg
         SD/ap43u4ygRJSUQ7xmPaiQifylGMAT5wrFm8qotllkCtWJ1FDEdypM9Dcaop4CJqJpP
         giqFJPZMoIRZVQGG8MF1SjTTB3GPVDcn8fwmsxCNum9ps4zEaWQiSYY+tToFeXejLh3t
         mf6X6bclOoEd9AdievmlYPd6nRhfjIk+zOxWtU9WuxuchIQ5WSJWgXkhSkVKR03AY6X5
         GHu85nYjAE0IoMyUqggo7WfuxQKzGto3WokLg/2h9shmx31fpi3flnr0j6e8yhHDowRn
         J8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=arNb1j3i4GvNRlcn37kgR9usAhnBUODhruewU4zCDlA=;
        b=tbHslvS6z4isGcR2dZ0s2r5/24n4AoftSzTZqfhR+J6L8J1h6bgTl3ERRgAXa0/2VW
         FRLTkbaf3X3/llVeRjkemND5oQwhd+DItszLgXAWnZwOJxAVjoZ1zpJzw86ZCJd6AhsI
         xPFZr1Oe0CoKVnLfuHWl0a3Ulivpdl1T0529y79VJ0c0YtWMJbDGKGC3R1P8Bhp0eszt
         QR1GsgCxq0FOS6Rbs/j6swj7badeQXVC9w8soJeEMtSGdRibLCNFVAM4YYhIW6yQCWvC
         z+GXhInRAhrYzKypohg4ZBcYWUcBtBRo//zlKKKHOsRaQZ6V6M23p9a4xSFG69mIrNiv
         eBzQ==
X-Gm-Message-State: APjAAAW+nvXyYBjFm1zqC4CJZnvNQXwW4jrfObv0KvwAI1IeqMD9DBsd
        I/bFLXyTzj33LNJJOMD2tQh5hUatAzoME7BpX0hM14nhUEQ=
X-Google-Smtp-Source: APXvYqzwmtVKYAC3v4nZRicDa6cfEG1E4EAisrOKaEkrWX6ql6CUTWPSF5WzwJFY0yYoOWk0anWkRvbtdNKslpEm0rY=
X-Received: by 2002:a67:d703:: with SMTP id p3mr15028396vsj.185.1580210814693;
 Tue, 28 Jan 2020 03:26:54 -0800 (PST)
MIME-Version: 1.0
References: <20200125004350.4640-1-brian.gix@intel.com> <CAFcXi1x4skUJuCgQLDswFQm20Hqo8XdAwmGv8qTg+ywKyjPGxg@mail.gmail.com>
In-Reply-To: <CAFcXi1x4skUJuCgQLDswFQm20Hqo8XdAwmGv8qTg+ywKyjPGxg@mail.gmail.com>
From:   =?UTF-8?B?UmFmYcWCIEdhamRh?= <rafal.gajda@silvair.com>
Date:   Tue, 28 Jan 2020 12:26:43 +0100
Message-ID: <CAFcXi1w3=MgG1e57B_e-yyg6zfHRFL--crCZ-8aGfBvxTNVGfw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/5] mesh: Add NVM storage of Replay Protection List
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

pon., 27 sty 2020 o 22:27 Rafa=C5=82 Gajda <rafal.gajda@silvair.com> napisa=
=C5=82(a):
>
> It looks like sequence number is correctly incremented when calling
> DevKeySend but it isn't incremented at all when ConfigModel sends the
> reply back.

I think the culprit is in mesh/net.c in mesh_net_app_send() line 3160:

> /* First enqueue to any Friends and internal models */
>     result =3D msg_rxed(net, false, iv_index, ttl,
>     seq + seg_max,
>     net_idx,
>     src, dst,
>     key_aid,szmic, seq & SEQ_ZERO_MASK,
>     msg, msg_len);
>
> /* If addressed to a unicast address and successfully enqueued,
> * or delivered to one of our Unicast addresses we are done
> */
> if ((result && IS_UNICAST(dst)) || src =3D=3D dst ||
>     (dst >=3D net->src_addr && dst <=3D net->last_addr)) {
>     /* Adjust our seq_num for "virtual" delivery */
>     net->seq_num +=3D seg_max;
>     return true;
> }

When sending the message we first deliver it to internal models and
only after that we increment the msg sequence number.
If we do "net->seq_num +=3D seg_max" before calling msg_rxed() then
messages are delivered correctly.

--=20

Rafa=C5=82 Gajda
Silvair Sp. z o.o.
