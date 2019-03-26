Return-Path: <SRS0=6DA+=R5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AB6C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Mar 2019 16:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350DF2075C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Mar 2019 16:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="WLp6jYoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfCZQu1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:50:27 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:40584 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfCZQu1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Mar 2019 12:50:27 -0400
Date:   Tue, 26 Mar 2019 16:50:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1553619025;
        bh=sEMx6k5xTzWMebg0rnZPHDmSNkQxqATb0p0NEmqGO1w=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=WLp6jYojZleq3k0EPlcZXwNiDU4z09I0PRrE72IYAXOfy9x2hPzVXEJwuTDM0VkRC
         yFpPBS/qbtmZc/8XAgo7ur3cFGyNjnGMaFa10hOF9ZMgrhHrn3jLfrfHgTdeWJ+NJ8
         aTNnTrFm/qaXDojeExZHPmXexg6qfmY0oHqXm9AY=
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From:   Jacob Cantele <jacobcantele@protonmail.com>
Reply-To: Jacob Cantele <jacobcantele@protonmail.com>
Subject: long outstanding bluetooth kernel issue
Message-ID: <a7tLSU70fzIb4tc6850YUqzNzXlrYwolWRpcf65aM0r6Yf231RjtNO6JT4442oFp-ntTm7WPxQNkRyjMqllE5EAwPLWuwMw0rzS2CWOmHMc=@protonmail.com>
Feedback-ID: C7WR8v6ckImX6k6N2_rDGQOdt_FxYh0G4J_F78YheDVIL6M8LOiWtsg753ODyRTc5D7Fj1nRkCjq_cbBV3UEPA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kernel Bluetooth team,

I was wondering if there is anything I can do to get people's attention on =
this=C2=A0issue. It has been open for two months, but has not received any =
comment or attention at all:

https://bugzilla.kernel.org/show_bug.cgi?id=3D202465
