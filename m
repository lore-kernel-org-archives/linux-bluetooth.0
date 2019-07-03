Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90032C5B578
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 06:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6E921880
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 06:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHdErk+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfGCGMU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 02:12:20 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:42833 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfGCGMU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 02:12:20 -0400
Received: by mail-io1-f48.google.com with SMTP id u19so2006240ior.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2019 23:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UWFvNgR+rq4CdSnEDtqn/+zRH9Vy+fco6A/AUVkujhY=;
        b=nHdErk+13ZFu0x3nT1zgJXI/kQOoxXjGqm8vuVPH9kHAO+nf3gbNkh7Z4eqwYAlqM1
         sUXWysACcFCgtehztBBTqJlOzmkB3Fdo4fPk2p2R/hR1RZIqzVv6MBQwr9YZN0PPbi77
         OQuXwU3ROQPwhz93pYKiHxTJlWtmZ7x7Vc/kCS15jZHTnM7DY1AEh1uslBFkSLJIoFEx
         KpVkw40zIgAcEyTTr+a8L6+ASC5194sfXXRe9NbSXF+npzEUP+TJT1Go8UMdnsf1bglF
         cK8qNCXgTDAMr8Pi9V+6FfKajC3/jJHPMLOHs+0W8nhUpat1pYZZHCqvHuK9sCIy4H+9
         OWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UWFvNgR+rq4CdSnEDtqn/+zRH9Vy+fco6A/AUVkujhY=;
        b=IzhwpsOOhbINdJ3LWsISfyTV4u6PA2wvF89mdPk1TaVhU5kXo21lgwMfa8Z1PJBUc3
         zirHqEoOMe9UH13VrJG4VtSH/gc6FmegovuEH42ONr8IAdn+jiI+k+41ndUTXHghTOwk
         p3bils4CA9jgf1c7VQ48BymS1/uzzSkQ9k0B1WXg+JlKGh5KNy/UrWYZw2NRZNrrAqAk
         NHL/gjso7hUvTeyfh2hSdm5ltHxnWXScw+fxAceVSffHfBk+v7a+b5FNB6B433WeMaAd
         5qLHIu1YiOs/CX085PEP39OaQnm/btr6Gi1FATUy4tXZd9YL3o1bnBu4j3SOQYIEb06U
         7Fow==
X-Gm-Message-State: APjAAAWGLHDDe0My6f7xboVy1RzeEAZL9Ns0hHJR4kY8y9LJMwMkV6Fd
        ToiQAXeWHVVGC1XXi4+6nStsKDJ0IasmvCe+60nJlW4d
X-Google-Smtp-Source: APXvYqyQl2iy2YL3DKwo0IdxM3DiI0rpbf6huaI2tF7QZLq5GK1N2VLzrooLtOGAYUycCD6QTcyToPBijKl19pCHEzc=
X-Received: by 2002:a6b:cb07:: with SMTP id b7mr36101727iog.7.1562134339792;
 Tue, 02 Jul 2019 23:12:19 -0700 (PDT)
MIME-Version: 1.0
From:   Arunkumar V <aruner92@gmail.com>
Date:   Wed, 3 Jul 2019 11:42:08 +0530
Message-ID: <CALCW+OmWrt-8PfNYLES2_hwGQqmo=QJbKEPC=MG2gaSWntAD9w@mail.gmail.com>
Subject: Bluez communication with iPhone
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Team,
I am using BlueZ 5.49. I am trying to run test/example -
example-advertisement.py with gatt profile.
How to set the advertising flag which property/data field to set? Any
example on setting flags as general discovery, with LE only.
I am facing issue with the iPhone connectivity =E2=80=93 connection not
happing (with android working well).
Thanks in advice.
Regards,
Arunkumar.V
