Return-Path: <SRS0=CqyX=RZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F85C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 11:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C5521934
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 11:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdxQ97Xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbfCVLmB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:42:01 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:37778 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731477AbfCVLmA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Mar 2019 07:42:00 -0400
Received: by mail-ot1-f48.google.com with SMTP id c16so1635545otn.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2019 04:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QhZWYGv065aQiR8Xie1Z2JYuF3Rp9xQ9+N8DIR34cak=;
        b=IdxQ97XdKNY/b5241HLBOukoGzCiowtQ94AZSKFZQpzVjRIQBznQEy7cOCT7XA424/
         4Pk/Imi3+KQOge1kBZ2SsIqL5imQjnBOqgAp/+r3uwcj2XYD9Yr+7LOfovyGGGDVkAIZ
         i7TVuM3XNtWEgKu1Cdd5V1ObQnxedhpUVrMwsE1c9NkEoeeLfXXv+XyT8OKPS7FzJBO0
         xVM/kiQ867TahRyyeDgNlGUqHTFqJi8Dbox1804kdGqEoqq1AI8wKEptB840boMOlqiL
         +f8Ku00TUponefYDvDwVeRXkoHRNAShnNTvdqFqaVJlFqP/aIQk/w8IC5ZpU8eM/QNWj
         Fagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=QhZWYGv065aQiR8Xie1Z2JYuF3Rp9xQ9+N8DIR34cak=;
        b=MYr7FCnXOpYFGlcR8KCZFsyJ9AMnrKW03jtSVvR0kjhpuzhErzN2UAOLuU0QLmVMXt
         TnG/mG8mWROAwHHKjwUwKI3e8xj2wEKjkJir7GuvNs6x04OKzONDyLnQQs8WSh9hEiKs
         9UndIiahEbdOXGUWifG7hb7QzJhitbh67Ph3re5XP+aSGaHUZ/D73dQREOIXn9Sf4cc+
         pvSACA1qGNf6glQTuUDA4zzsbpAnXyESWc/CnPAq24qjdI7BE+U3UnQ9vl6reFJEn9xP
         atcvz3a2QP1VUFeRw1/TSqRhh8+TMYdD3kCDizGBPM8+x1ifJWpcPmn4sgrAFbT3Lp8A
         lNZQ==
X-Gm-Message-State: APjAAAVR1FdVuZR34R1VSyFFdxPg3n1MUXSNyldtCPBn8btIdd9Bkrbe
        3fz6+AxLFwnw1MsYITZ9Sp19v4P0fZdp9+uku0XDrn0eIcM=
X-Google-Smtp-Source: APXvYqwBcfOuseXb3XYsOtkIoVyDA5OX9tIM77wVTzBUq6oVklQbpuGuVNpRPKoKqZ1ZAIti4D10r+/eS19AosQ4ttA=
X-Received: by 2002:a9d:644c:: with SMTP id m12mr6549992otl.59.1553254919233;
 Fri, 22 Mar 2019 04:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAGuyqoEUrwLa6nVGVKasn=3kTTmJV3oLvUO8-9AsnGn08cQGjQ@mail.gmail.com>
In-Reply-To: <CAGuyqoEUrwLa6nVGVKasn=3kTTmJV3oLvUO8-9AsnGn08cQGjQ@mail.gmail.com>
From:   Miguel Sancho <miguel.a.sancho@gmail.com>
Date:   Fri, 22 Mar 2019 12:41:47 +0100
Message-ID: <CAGuyqoF=X8SnequTg_LQAB1R4Eu8NuWHd98bMUjfvZBfSWzK7w@mail.gmail.com>
Subject: Re: BlueZ 5:50: First key sent from Ble device lost after initing bluetoothd
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I think, this behavior has to do with the fact that  Hog Report Map
needs to be requested and processed by bluetoothd in the fist
connection to the device after bluetoothd is restarted as stated here:
https://marc.info/?l=3Dlinux-bluetooth&m=3D144793894016748&w=3D2
Regards

El jue., 21 mar. 2019 a las 10:41, Miguel Sancho
(<miguel.a.sancho@gmail.com>) escribi=C3=B3:
>
> Hi,
> using BlueZ 5.50, I observe that if bluetoothd is re-initialized, the
> first key from a previously BLE paired device is not being processed.
> Looking into bluetoothd log, upon first key pressed in the device
> after bluetoothd re-init, bluetoothd connects to the device and
> creates the uHID device:
> bluetoothd[9023]: profiles/input/hog-lib.c:report_map_read_cb() HoG
> created uHID device
>
> In the second and further connections, key works fine, this is the
> only output related to HoG:
>     Line 401: bluetoothd[9023]: src/service.c:change_state() 0xd0b98:
> device profile input-hog state changed: disconnected -> connected (0)
>     Line 402: bluetoothd[9023]: plugins/policy.c:service_cb() Added
> input-hog reconnect 0
>
> Is this expected behavior? Can it be avoided? I wonder whether the
> uHID device can be created upon bluetoothd initialization instead of
> waiting to first connection.
>
> Thanks in advance
>
> Miguel
