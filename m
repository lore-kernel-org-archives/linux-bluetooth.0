Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8589AC43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 20:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353526AbiFUUk0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 16:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352338AbiFUUkZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 16:40:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE13C1B7AD
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 13:40:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g4so11947042lfv.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tVVuLa+zaRcSghcEDTvfndqPskI8FPGli2Ph03OqvG0=;
        b=afKK/ohAKZLA+7HynYqlEM+FZ6W99ZCAHNLeNCQoycmHqQY0diHjVcxTf/yGBIQ9Nd
         4rY3s6MjgQnG/8Rsi8sMXPdINimen+fMVoJ2IjSfO5LUmqJRV6ZsC/O1Ewgv8LvTZYn4
         LHdXZRk+jj6s6fY+PzbVTQqsB9wuCHF/HpBNroPO4eg8PMaQgxUJGy3XfPpQXfZWRbEa
         jMnRdTwxq1WQvjxkbaH3yjGvjUj7BIg1wNo1To3BAZ3T7/JTqWamAjrwFun535Wa7OKr
         G5/z+3kO8gQabWSbJkrrlApSW6RizFm3JWc5mXD3z7b87jrX/DuvSzHwrzI3o3EYvUM7
         KIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tVVuLa+zaRcSghcEDTvfndqPskI8FPGli2Ph03OqvG0=;
        b=tZoghVsBFgzaz0qaMnf8OhWy76EA80r1kFBG0vUVEHr9QaNfSUIsk/gUyUC8TcmOKk
         X/hXyDpHed8TxNekXE4wdWIkI+hT19L7SQCrmL9Eogd450DfbU9HUncOiMm086Uu0kkf
         FxYTouS3FPuHoOs/NxwZaUwuC9Z3cFrqZO1MgvLOXCEIeVNH91p6x6ED4I5NVxohWtUV
         f9Ix5toQkmqU2gzUPtaoHZBm/eTcW6obkkoUFi0MQzo+Jgvmm4W6R+aZ+eyG5oklWHKI
         utC0UiV1iJoIaSHGnqefdmNAeRd74NjRNRuyu7UG360Pza9fPlNwJ8bo9H4L7DmbUR55
         +yHA==
X-Gm-Message-State: AJIora94t60i6wrbkXBxpk+4sKDykSUXfyy15r3o4ch+bYYpjsVeB92Z
        qWcBIgC9JLabDz5DPZqWa8D92XIP37erciqauGM=
X-Google-Smtp-Source: AGRyM1vJNU2fiLmckxw22gPljcCniJmruv09FhlelGmK8p6TF4CnQOC3ghWRW6WVwMstxfIWYoPAU0czGtTZsjFAXks=
X-Received: by 2002:a05:6512:3ca4:b0:47f:6e53:fb4 with SMTP id
 h36-20020a0565123ca400b0047f6e530fb4mr39178lfv.57.1655844022048; Tue, 21 Jun
 2022 13:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <BN7PR04MB52674E1CAADA5B0550C3F6959FB39@BN7PR04MB5267.namprd04.prod.outlook.com>
In-Reply-To: <BN7PR04MB52674E1CAADA5B0550C3F6959FB39@BN7PR04MB5267.namprd04.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Jun 2022 13:40:10 -0700
Message-ID: <CABBYNZLaPxBMvVXWx+yqQz-SyxptdMfEZ5TPQVP7q4otpcbErg@mail.gmail.com>
Subject: Re: third time
To:     Thomas Green <TGreen2@sorenson.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Thomas,

On Tue, Jun 21, 2022 at 1:29 PM Thomas Green <TGreen2@sorenson.com> wrote:
>
> I've twice before written about this issue I'm having, but never heard an=
ything back.  It regards a GATT device that connects and operates correctly=
.  The issue is when we call the Adapter1.RemoveDevice method for this devi=
ce.  Some times the device is removed completely, and everything works fine=
.  Some times it fails and bluetoothd becomes unusable.  Even when I shutdo=
wn and restart bluetoothd it doesn't operate correctly when restarting.  Th=
e difference is that when it works, at the end of the removal process, it r=
econnects the device, tries to recreate the device, then removes it.  All i=
nternally.  When things fail, those steps don't happen.  I've posted before=
 the salient part of the Bluetooth log.  The only thing that will make blue=
toothd function correctly is to shut it down, remove all of the similar GAT=
T devices, then restart bluetoothd.
>
> I have yet to hear if anyone has -any- idea regarding this, not even to t=
ell me it's not something that needs to be looked at.  It is something that=
 renders bluetoothd unusable, so I would think that it is something that mi=
ght be interesting to look into.
>
> If anyone has any ideas where to look, or what might be going on, I'd lov=
e to hear from you

Do you have any logs? Also what version is this happening, perhaps you
are missing some fixes like:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D5ebc2b5a3e4=
8dbe67a2d315979b096a1b4d1eb99

>
> Tom Green



--=20
Luiz Augusto von Dentz
