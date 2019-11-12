Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85145C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 09:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD0E21925
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 09:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du5oK6PY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfKLJPt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:15:49 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:43595 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfKLJPt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 04:15:49 -0500
Received: by mail-io1-f41.google.com with SMTP id c11so17882762iom.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2019 01:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fNPuEg+DkoSNJcKB6RIxqtUfrM/WDkkK1wigAWABpZU=;
        b=Du5oK6PYxFVLdcseXqGLaS5hfXwIXSMMdNXNJSYkaOa//kWDTj0C1/tpc1bkntdJW1
         AfRktmC57XYpfFeawm02BNxuTwS5pstpwRmWtv2nzPoXjxRC1saW8jd2WBLwgl4iPpEu
         GmhomeOYMcXrWoqY0f7BfhlZrqyvRgPC5A672Ih1C0TM4dN0iUypdsPF5Dhc4wR/J/za
         +vbEW2/PFY5abmOI1AcrgdmhWojeTbv8kp8RRJYfWk0gb3PmVx54li3EawRVRYfPjB5p
         Me+g7t/dw97GqC77mGg/EmE+iF5hx+DD6KgLER0ur4py2CnvpsBRAjewspCS7llyKYw4
         8m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fNPuEg+DkoSNJcKB6RIxqtUfrM/WDkkK1wigAWABpZU=;
        b=fB/a0gWYYVZoeNzPmyocrPgAvjsLK70qhkJPfZCVQ7lCC/gPJjBVdhgQabwjlC2WDh
         NCMkaRylCTrkvsUBO/1X7UjYjKvXNJ1iWGucgVVP0IlIMqH36qGKwdS7tyvHpDnNChk1
         3txgbamWUD4jhdh42Fdnd7/ezUxbNlxIwPOZGZVsjtAlP5cilPxn5m3TzIbJgtyCmKJb
         uKlyixG/CMfOqXHTE6wzFGf4oTxQ6GCbUg6B111Pz2b4R+fH47HAJJu9u7QpV0I/BX4h
         //AXpaESzVXzC60A+Cf4VKMU7iqr0FQ4QO1/gnRmj2mnZvEIBaWW+wJ8qj+cLyiUUOND
         WM3g==
X-Gm-Message-State: APjAAAXcOHtgDrOyCabjddLY7pdj8QwfjePz99yuY/wP+YTXT2l4ds8w
        q9bWgr1AeT/ebEpB+LOHcAe6Vr8U7ZMR2xrwX8h45A==
X-Google-Smtp-Source: APXvYqzlzm9ahbv3/885da5eAkMsDGGCOQNEontdgwx3GZAM4JkI3zUhjITOp1mPUOaK5Yt6d+AccoMS/5VQZ4QvEtg=
X-Received: by 2002:a6b:d81a:: with SMTP id y26mr19213231iob.23.1573550148151;
 Tue, 12 Nov 2019 01:15:48 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?S3Jpc3TDs2YgSG9ydsOhdGg=?= 
        <horvath.kristof.attila@gmail.com>
Date:   Tue, 12 Nov 2019 10:15:38 +0100
Message-ID: <CAMGddftdorPGAzJbQzwLbaKNjfSrbayzGzKFb7iMBSwNQvsf7g@mail.gmail.com>
Subject: Simple SDP and RFCOMM example
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I started a project with Bluetooth, but most of the resources on the
internet use older versions of BlueZ (and often mention using
compatibility mode to hack the legacy code). I think the reason for
the hacking is that there is not any tutorial for BlueZ 5 (or it is in
some very hidden place). I browsed the page
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test for
examples, and I found some interesting codes, but I could not find
what I was searching for.

I would like to see a simple Python code that can register a service
via SDP and receive the incoming RFCOMM connections. Could you provide
an example like that?

Thank you for your help.

Regards,
Krist=C3=B3f Horv=C3=A1th
