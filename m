Return-Path: <SRS0=UcDi=S3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6186C43219
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 19:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C152077C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 19:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=marco.betschart.name header.i=@marco.betschart.name header.b="MIljEECV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfDYTRI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:17:08 -0400
Received: from forward101p.mail.yandex.net ([77.88.28.101]:42442 "EHLO
        forward101p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726086AbfDYTRH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Apr 2019 15:17:07 -0400
Received: from mxback5o.mail.yandex.net (mxback5o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1f])
        by forward101p.mail.yandex.net (Yandex) with ESMTP id 89D3F3281372
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2019 22:17:05 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback5o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id X4RdyxHGBb-H5nGhjiE;
        Thu, 25 Apr 2019 22:17:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marco.betschart.name; s=mail;
        t=1556219825; bh=Ih12UpAwUE7eBEPit1LpqDW/ubbZ57cYKrI18gdQ3ik=;
        h=To:Subject:From:Date:Message-Id;
        b=MIljEECVhtVY5+fCXTP4W09fTBJlJ2WEoifRHkCdwVV7kwFEbPRAg/Hc0AsdD1GsZ
         RpE6cACJ8IUD2iEIXiSwaoEZoAsZdeGAR41hcjcQb1Y8+vY2X4tQ97rTg2/wNGlM8V
         m2a0kL7mVZ/021ONdW+fmoobEFLiPHN8wx+ubEjc=
Authentication-Results: mxback5o.mail.yandex.net; dkim=pass header.i=@marco.betschart.name
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id CcqgyC8pAW-H4nilCul;
        Thu, 25 Apr 2019 22:17:04 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Marco Betschart <email@marco.betschart.name>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: MacBook Bluetooth Support
Message-Id: <25802F6C-B285-4089-BB7D-CAD5B91A6B35@marco.betschart.name>
Date:   Thu, 25 Apr 2019 21:17:03 +0200
To:     linux-bluetooth@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Bluetooth Kernel Maintainers,

Not sure how to properly address this, therefore I simply start with the =
main question:
Whats missing to get MacBook Bluetooth support upstreamed?

Getting this done right would improve the situation for lots of people =
running Linux on MacBooks. Currently they patch the Kernel manually with =
something similar to this: =
https://github.com/marbetschar/Manjaro-Linux-on-MacBook-12/blob/master/pat=
ches/linux-4.19.32_drivers-bluetooth-hci_bcm.patch

While this works, I don=E2=80=99t expect this solution can be upstreamed =
as is - since it simply avoids "err =3D dev->set_device_wakeup(dev, =
powered);" to be called which may cause unwanted side effects I=E2=80=99m =
not aware of. However, avoiding this piece of code somehow magically =
allows Bluetooth to work properly on MacBooks. See this thread on GitHub =
for all the details: https://github.com/Dunedan/mbp-2016-linux/issues/29

Would love to help to get Bluetooth support for MacBooks upstreamed, =
although I have to admit I=E2=80=99m a complete newbie in Kernel =
development as well as in C programming.

Looking forward to any pointers into the right direction.

Best regards,
  Marco=
