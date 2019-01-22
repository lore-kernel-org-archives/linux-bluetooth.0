Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3271AC282C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 12:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F137920855
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 12:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyKB/Ssu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfAVMyn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:54:43 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43561 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbfAVMyn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 07:54:43 -0500
Received: by mail-oi1-f194.google.com with SMTP id u18so17250962oie.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jan 2019 04:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jrgZjnjWzZ4C9jis5DFLJKqL0x4TUxuI2HTM/J2TPhQ=;
        b=QyKB/SsuTIeZNI/QxDBFPAW+9L6EWuoqlyPzpFVHhTRnunpkKXCyZxwmZ96fyxUi/4
         BhZxf1uYojXXiBG0Ez7bihLr2S9g6d95B62AMpwVt1RzemYhVol/OLw+w5tzJWHNfh8d
         87x3DaoNrz8HfPLecUTkT4EvR/v5XMMciix+vjDS2u0CgCJQ58rLO7kJIZsqHM0Xjjjz
         JyGu/src3ZjfvKcbhoBz9B2pU4DqljTz7zR8vk3VcQ9foyjPG+9GZkIGDwGSqfcmSuvh
         BtadE+FqsdK/1+V1dzY2ami3KgUNi74taWTf4xugnKorXNkmOLoDbQKRtKpI/If7atKC
         wLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jrgZjnjWzZ4C9jis5DFLJKqL0x4TUxuI2HTM/J2TPhQ=;
        b=dkHNRcHsYXKBoJL52IOFtPg1ryL3C9kP/zFP9Utk9dzLxhf+ASU5x+c4gc7DjHzp8O
         aiBaxNM4+yLKC7TyiPQla6JgFvatSeOFbeHF8Cr2fK2meDY56eCxnZNd4Oq+6p/iS4YG
         XfA1jJrCZMO0HvQcThuSMLEv6myAcj7vyJPhLIjvwwbDnjA/uOSgfZY4+T+4XkJAFGS1
         uRUYGdC+7j3grpzs7N+p4AutCHSikn0jWU8bZCNem4saGaHrMb/SDSkkWPBicVnokum4
         Ji2YfqPrEYuzHLGw0AQ8C3otELIwW1DUzHVjTXSYRtYG+WSV1UJBAx/6zoXArUOYESsm
         MuKA==
X-Gm-Message-State: AJcUukfV4UYzVSYA6iFgbzLV8qn9zYNjE2BMBON4J0KfZGyWkSA24KPY
        SxBpE5Li4YN49DfVLdKucUlJduJGfPjZvl6MSp0=
X-Google-Smtp-Source: ALg8bN6ldy7wbMcS0zBrvuGTKTSTNME9h4rgGTj7JKEatX03V8GsYyZtbvhwCqTw3COu7nxNJws5QkSFDXwjZ3LtRXI=
X-Received: by 2002:aca:d509:: with SMTP id m9mr8070327oig.82.1548161682440;
 Tue, 22 Jan 2019 04:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20190115141023.353-1-luiz.dentz@gmail.com> <CABBYNZLL7Usr=bS2rcJCCV6STVwi9ywq3Om6jkF8cfB8GC6mcA@mail.gmail.com>
 <20190121183016.jiqrtw3csllmqhif@pali> <CABBYNZKMPfkSvHqryeR7P8QitQVAv+-WVudSV=hpVaPjTOUu3A@mail.gmail.com>
 <20190122123812.hypezv5oypabeb27@pali>
In-Reply-To: <20190122123812.hypezv5oypabeb27@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 22 Jan 2019 14:54:30 +0200
Message-ID: <CABBYNZK-qBX8cQmAmb4w1H21_W_PGKvvDPnQaTJ0RBK1TPJwJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,
On Tue, Jan 22, 2019 at 2:38 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Tuesday 22 January 2019 14:35:42 Luiz Augusto von Dentz wrote:
> > I will send a v3 which does the reverse discovery, that should make it
> > work with existing paired devices that reconnect and configure since
> > otherwise there would not be any endpoints to associate with.
>
> Ok.
>
> > Note
> > though that in case of PA the endpoint object should be considered
> > optional no matter what since otherwise it won't be backward
> > compatible.
>
> Yes, patches are already backward compatible. When endpoints do not
> exist, pulseaudio just refuse to switch codec.

It refuses or there just no other profile/port to switch to? Btw, are
there anything special I need to do in order to test your patches? I
guess for apt-x I will need your lib right?

--=20
Luiz Augusto von Dentz
