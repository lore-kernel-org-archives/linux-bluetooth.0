Return-Path: <SRS0=76SB=XE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE78C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Sep 2019 10:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32CC2086D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Sep 2019 10:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfdEVRsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfIIKca (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:32:30 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:36008 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbfIIKca (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Sep 2019 06:32:30 -0400
Received: by mail-vs1-f51.google.com with SMTP id v19so3249215vsv.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Sep 2019 03:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=158c9Ewqi1HxDcDA4IUWZg/zthD4XuhN1FAcK1eUjY4=;
        b=ZfdEVRsyLKykHvHmgG4QvbdaHY4zhzSvrwVrzVCAS9Q6lfCgasie8Crqg8wCPPXr/9
         tSiBU6qIO8w6D5M9chx7zLlsIAm/1W2hf3Vpzq82u4HJ2liNGgKjGSYpfN1jXtrALOz+
         oq1g31MJ864nyvpafvHgPwBtDF7RcnqVaf1v5N4ZOlx2b672rUbbNLlaWU1XO0RKyAyh
         oWZmVbYLtuYuKlLi0wePRqWwrGtApBfEeR/ZpSLBefXMhebwecbVLciGevg5onz88os0
         Kon6jQI0cndiglOzzCmKfjTSWq+dUIQxXKBdtXZ9UjIF/1rgZiAn9o8p/dcal4eSCc+V
         sVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=158c9Ewqi1HxDcDA4IUWZg/zthD4XuhN1FAcK1eUjY4=;
        b=gFhh0VoxErV65dRM6eXZjcmLmLbEc2cEYhGWo1O04K4ZZopB6/FwALCgem3gi3elzy
         xFR1ONDFuYgDnJkA07Rryi7qRJ+L9VTy9DEXozIG0EYr8BT0VfEnLED6ciOQ3KPVHLzR
         Tlq9myExvl+qwfFgFkD3+0DfbRi6RK3XrXjNaDcFjCwZE/i95GhFwlfoTfCv2m3iid9o
         g+PBENvvEi7GdrM6lSmxo4j+BoThTOlVj4MWQdMnBEfvQU87wOAJPQ3i5RAjF9I5XuWG
         w0TnCuc4Fqrp/BSE/N4c7xV40DlRCW6cQlaujrJBQC0a8w0fnyZiYSujZqVP+psRJMUm
         6kEQ==
X-Gm-Message-State: APjAAAVfYwLWwu+YYMeUxDkWrxlKCETta56GmoY6Hb96XSk5OHUylsKN
        +Req+h5Ph+TvL0ZyS1znxG2Ew+HT1GMU/k/Vq9liGGXMTLY=
X-Google-Smtp-Source: APXvYqw1J1LTWgpdtCN2pnlXHZxj8YJbrDcA7DZe8ghJIpoYiT2GIYJtjkFF68eucVDQ6e2yVcwpBXp+IgNxE07IvXA=
X-Received: by 2002:a67:2981:: with SMTP id p123mr449985vsp.121.1568025147333;
 Mon, 09 Sep 2019 03:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAP1EGUKNdCnaFZLy4rut2zOP0sjmVS+6ZEeQ3vz1M8MQJTDKVQ@mail.gmail.com>
 <CACXRGxxjN4OwjzFmeV3tRJrFQkGJwj1NDzh7exQjsgZP3gWjuw@mail.gmail.com>
In-Reply-To: <CACXRGxxjN4OwjzFmeV3tRJrFQkGJwj1NDzh7exQjsgZP3gWjuw@mail.gmail.com>
From:   anurag biradar <anuragbiradar@gmail.com>
Date:   Mon, 9 Sep 2019 16:02:14 +0530
Message-ID: <CAP1EGU+SSTXrCm64yh8TG9HP13NSFNsLmu_zbKQtGqYjYc-xMQ@mail.gmail.com>
Subject: Re: [Mesh] Query regarding Configuration Client Model
To:     =?UTF-8?Q?Micha=C5=82_Lowas=2DRzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Sep 9, 2019 at 3:39 PM Micha=C5=82 Lowas-Rzechonek
<michal.lowas-rzechonek@silvair.com> wrote:
>
>
> On Mon, 9 Sep 2019, 11:49 anurag biradar, <anuragbiradar@gmail.com> wrote=
:
>>
>> I couldn't see any interface exposed by bluez to do this, is it
>> something like bluez is expecting application to implement
>> Configuration Client Model using "DevKeySend" and
>> "DevKeyMessageReceive" method calls and store all required binding and
>> appkey details in application
>
> Yes.
>
> At the momemt we don't plan to implement Config Client Model inside the d=
aemon, only the Server.
Thank you for the clarification.

If application stores the required provisioned data. So is it like
bluez will expose an interface through which application
can set required model to appkey binding for particular node. Because
as for my understanding bluez should be knowing which appkey should
picked when it receives app related data.
