Return-Path: <SRS0=j8AW=QY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAA1C43381
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Feb 2019 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879422186A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Feb 2019 18:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mykle.com header.i=@mykle.com header.b="IVaxqEX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfBQSkT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Feb 2019 13:40:19 -0500
Received: from remail.mykle.com ([18.233.80.45]:40271 "EHLO remail.mykle.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfBQSkT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Feb 2019 13:40:19 -0500
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Feb 2019 13:40:19 EST
Received: from k9.fritz.box (unknown [88.130.155.131])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by remail.mykle.com (Postfix) with ESMTPSA id 5DBF042A49
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Feb 2019 19:33:56 +0100 (CET)
Authentication-Results: remail.mykle.com; dmarc=none header.from=mykle.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mykle.com; s=mail;
        t=1550428436; bh=GoC8l7OGEggvIxZ0TyOoH+EMjfTC7n28+MsE2wCkz0E=;
        h=From:Subject:Date:To:From;
        b=IVaxqEX9v66itldxrsTuS+9Ab8kcTmzWkP2WmqJNjNV3Yy50glyoPmEXuENJSuHpx
         j6dqLJ20BidQP3W/T5eC07vERC+Ppk4CXp+sgxVRkAGocGFMWS7zmOLMcXhNEbt0dp
         4ayRMXLa3h+48bEOwEVOPZ8V4pQlJ8Wfe41QQO/9HDnUSQFm7s1Ijt1BmkeHQkSkHh
         /joWGTuDTuyeabgPIp4jLSVZCdsEaAIPheVECtlRYHgmDmXHuhmNweY1qn4WsRDyZy
         jNc9VPY9Y76QB2GqbBvDJr4FcoKfAfDaSP+PCIIZbU87mQcn1SmK0ExNCyevUBrRBn
         0F8dZVDpjCVIw==
From:   Mykle James Hansen <mykle@mykle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Backporting BLE+MIDI plugin to bluez 5.43 ?
Message-Id: <0A7939B9-5570-4EF2-B831-2B2608539970@mykle.com>
Date:   Sun, 17 Feb 2019 19:33:55 +0100
To:     linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,=20

I wonder if anyone here could advise me on a hack.  I=E2=80=99m trying
to set up a MIDI-over-BLE connection to a Bela-platform host,
which runs a specific linux distro that prefers bluez v5.43 .

However, it appears that MIDI-over-BLE was not added to bluez=20
until the very next point release, v5.44 .

For various reasons, it=E2=80=99s difficult for me to build bluez
from source for this host.  Upgrading the OS would introduce a lot
of work as well.

So, not knowing the bluez architecture at all, I wonder if it would
be feasible to somehow extract just the MIDI-plugin component
of the v5.44 release, and plug that into a 5.43 installation. =20

This would clearly be a hack, but if it=E2=80=99s feasible it would
save me a lot of time and work.  I just have no idea how to
do it.  I=E2=80=99ve heard that MIDI is implemented as a plugin in =
bluez;=20
that=E2=80=99s what makes me think this might not be totally =
implausible.

Thanks in advance for any advice on this,

-mykle-=
