Return-Path: <SRS0=F5zp=UL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7DBC31E46
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jun 2019 07:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB05F208C2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jun 2019 07:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b="Zeds5/JK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c8REl6Z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391217AbfFLHZu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:25:50 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52385 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731450AbfFLHZt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jun 2019 03:25:49 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D3FE3222E4
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2019 03:25:48 -0400 (EDT)
Received: from imap38 ([10.202.2.88])
  by compute3.internal (MEProxy); Wed, 12 Jun 2019 03:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        arunraghavan.net; h=mime-version:message-id:date:from:to:subject
        :content-type; s=mesmtp; bh=6fG35cOEvPl5k4WpXBi9x8nm4Hpw4MX40qMl
        JCZRPss=; b=Zeds5/JKSPHjzXLaCgTcrVNnf6XEsHSf6LiSvQFrjK9p/tbNVpvs
        orLt2ttSZxE2mO+VxBPp4z/ibbwd9HBLUgzchc/u/VPn4RKSXzuwul/W4POOyqGc
        Ed4wC8V5xmk8onXlmVo6Sps/LRYaM+l8eMdYqq7B2RvzyUFGuh0nTVI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=6fG35cOEvPl5k4WpXBi9x8nm4Hpw4
        MX40qMlJCZRPss=; b=c8REl6Z+AUuueOJszEmaIWMzTmajJFEduzMUBkUSYS6zN
        T1BNZ/BWubiAA1Z5kbVTP2RvdUmRZrx862E5BFUEycV6+wyvLQmlPsGy25nCEHE8
        Kz7j4RSAzKX6KJ45OtSEl9ImTLAOEtJ6SsaefyeUw3MzkImwWeyxd5Z5Zx5kIKX/
        YsJFmRyNAw2+ighJBUbren6cSryzujvu0IDXy1vyocosJy7Xn/EJc7Vg5r3AGrZ4
        NNKBA51Lad2CVbbY41ISKKCC3OusnfYw64GoQmJhQOQa/ckGPkiwKxdXpoAkwJIh
        uZcBoaDsiTd5uaYSkIV5GfN7UohS0z9srBFh+/yYg==
X-ME-Sender: <xms:_KgAXX9J00q-1adJFtXo5ocE3jF4rN7liEWNiiwCQDayhwsOGYEhxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudehiedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtre
    dtreertdenucfhrhhomhepfdetrhhunhcutfgrghhhrghvrghnfdcuoegrrhhunhesrghr
    uhhnrhgrghhhrghvrghnrdhnvghtqeenucfrrghrrghmpehmrghilhhfrhhomheprghruh
    hnsegrrhhunhhrrghghhgrvhgrnhdrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:_KgAXWbuLjpQlR1UZe9HTTvrD9iOyzeX7SlepF_zrXsEo5F0d-RN1A>
    <xmx:_KgAXQ0JV12cBXbMuSY5khwRET45li6oajXNdJYnLQ9wdgwzUNT3zw>
    <xmx:_KgAXZ6U8994wHmh_VnKKZRKMSgJJsJo8AxXNnq5-kq6aOrdaQw9og>
    <xmx:_KgAXTt4XZJ7UzT9ENQWAl-4hOXAlJxC9BlqtnKQNSSE5rDYVOjlnw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8110D4C000A4; Wed, 12 Jun 2019 03:25:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-663-gf46ad30-fmstable-20190607v1
Mime-Version: 1.0
Message-Id: <cf3918b9-37d1-4b5e-a13d-5f16942de35a@www.fastmail.com>
Date:   Wed, 12 Jun 2019 09:25:48 +0200
From:   "Arun Raghavan" <arun@arunraghavan.net>
To:     linux-bluetooth@vger.kernel.org
Subject: bluez: avrcp: Initial value of absolute volume
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,
I'm using BlueZ as A2DP Sink and AVRCP controller on my laptop, and had a question about how absolute volume should work when I connect a phone to my laptop.

I notice in btmon that at connection time, the phone sends a register notification for the absolute volume event, and BlueZ responds with a current absolute volume of 100%. In the code, this seems to be initialised at media_transport_init_sink() and the initial volume is hard-coded to 127.

What this means is that after my initial connection to the device, I set some volume, disconnect and reconnect, and the volume is now 100% and any changes on the phone cause the device to play at full volume.

I can, of course, set a volume as soon as the transport is created from the client side, but it seems wrong to me that we communicate an incorrect initial value.

Am I missing something? If not, perhaps we can allow an initial volume to be passed during SetConfiguration so that the transport is initialised with the correct volume?

Cheers,
Arun
