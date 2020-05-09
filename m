Return-Path: <SRS0=Rej4=6X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88389C28CBC
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 May 2020 07:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6D820CC7
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 May 2020 07:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpBBx2Zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgEIHyu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 May 2020 03:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgEIHyt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 May 2020 03:54:49 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2358AC061A0C
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 May 2020 00:54:48 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id o14so3022325ljp.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 May 2020 00:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=A1m1Hbn2P4f0s4gRLaUkIzkvRuBtfJcIHgYKKXalQe8=;
        b=KpBBx2Zphah6o/tdZICYwfmWaxqjPvoJtELoWA3zvufwvmkgc4Xr5EMV5R/Gw1BKSW
         q2/ObWZrC/ILuigTHjpRoyKs+qGo5K47XiSMOZeea25/13gI38endwb2I8i6Fso3qezA
         clMFpVLqrg9+9K4fb0Ml2GSouNYxQDbgmuMWSAbiZj89pdOtkAeh3jXUGvVp4YnRnhVd
         x0CdH8HWlYZ5BxYhJDO4ZqOaYRc5aPkZ136m2n6mepJR+miB5FhxsSBjaLQwgejrZdQl
         RFQHiOksayM7kY54qxF1gkbuxm7LDL/UMtV0RKcdswvayLEoGIGTUjmRLd6v/DxmYakM
         UEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=A1m1Hbn2P4f0s4gRLaUkIzkvRuBtfJcIHgYKKXalQe8=;
        b=qw7T+ED9rmH3o6eYJo5V7JXPzk9UZJ3xj4ilXBsKXxwzHreL1kYysCx8o4kKcIEcA2
         56PGX+oUIEzk3u86H5e02dhxh5IgQpQ2d69DPl/vQGqY4U0jVlPp59Z4cc/R+OThDlDz
         IyOIwSVagp1eF520ef9nS2RFwuQTgwAeH6reCppikv0afkKgWmiGuEQPKYSD3fzglCyd
         cHZ2Ga+RgOBvruRzi7Voo9HgHEdxHVUfh/iWjJ2RVhAhje/RC/STuDJMhWxSro76L1SR
         n1gj+ELTGjJ1LMclAHGVG/blB5vCL3T3oUOAlmhOujKRjOT87LYz7AcRg67UivKeX/rD
         ZH2w==
X-Gm-Message-State: AOAM532cOgPV9v5v7MG4YNkOr0xzuSNzKVqIf2HmZgSRr+Y0XiIuPrHv
        rdG/C1WngCNKdiATbIuW6WZrTRI0TI17ErkzNHwtzKhKd1Y=
X-Google-Smtp-Source: ABdhPJzuXR0PgRzcpSRTQUXXhZSdFcKtDxGhEc2fjAWJ+QLQpKj7IaTyz2Cg6Nlaa8RDax96iKqpILEtHr1awX2W9jg=
X-Received: by 2002:a05:651c:385:: with SMTP id e5mr4095041ljp.208.1589010886621;
 Sat, 09 May 2020 00:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWtcQOVcb4-a6aCztjszh4gmk_QVXgHsn9FLOeb-zpLpg@mail.gmail.com>
In-Reply-To: <CA+icZUWtcQOVcb4-a6aCztjszh4gmk_QVXgHsn9FLOeb-zpLpg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 9 May 2020 09:54:35 +0200
Message-ID: <CA+icZUVjOwgymYRAgoMix9siDB-_HfUPuWBdReDoWFeFHGKY+A@mail.gmail.com>
Subject: Re: [btintel][ID 8086:0189 Intel Corp.] unexpected event for opcode
 0x0000 / SCO packet for unknown connection handle
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, May 8, 2020 at 9:37 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:

> In my first tryouts sending to the smartphone worked without any
> problems but *not* receiving from it.
> I am using version 2.35.1-2 of rfkill from util-linux (stolen from
> Debian/unstable).
> KIO-Client says: No connection to the MAC of my smartphone (Motorola Moto=
-Z).
>

When I see above kio-client message:

root# journalctl -f

Mai 09 09:13:14 iniza obexd[1673]: Unable to find service record
Mai 09 09:13:14 iniza obexd[1673]: Unable to find service record

root@iniza:~# systemctl --global is-enabled obex.service
enabled

user$ systemctl --user status obex.service
=E2=97=8F obex.service - Bluetooth OBEX service
     Loaded: loaded (/usr/lib/systemd/user/obex.service; enabled;
vendor preset: enabled)
     Active: active (running) since Sat 2020-05-09 09:51:51 CEST; 1min 0s a=
go
   Main PID: 4750 (obexd)
     CGroup: /user.slice/user-1000.slice/user@1000.service/obex.service
             =E2=94=94=E2=94=804750 /usr/lib/bluetooth/obexd

Mai 09 09:51:51 iniza systemd[1295]: Stopping Bluetooth OBEX service...
Mai 09 09:51:51 iniza obexd[4750]: OBEX daemon 5.50
Mai 09 09:51:51 iniza systemd[1295]: obex.service: Succeeded.
Mai 09 09:51:51 iniza systemd[1295]: Stopped Bluetooth OBEX service.
Mai 09 09:51:51 iniza systemd[1295]: Starting Bluetooth OBEX service...
Mai 09 09:51:51 iniza systemd[1295]: Started Bluetooth OBEX service.
Mai 09 09:52:04 iniza obexd[4750]: Unable to find service record
Mai 09 09:52:04 iniza obexd[4750]: Unable to find service record

- Sedat -
