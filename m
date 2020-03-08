Return-Path: <SRS0=rf5u=4Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B852CC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Mar 2020 15:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BCC20848
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Mar 2020 15:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgCHP7S convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Mar 2020 11:59:18 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43024 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgCHP7S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Mar 2020 11:59:18 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 97431CED1C;
        Sun,  8 Mar 2020 17:08:44 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: avoid cross-transport key derivation
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAB+bgRanN9W4oH00rATmgarRnk4NXPXOdT2K+ZYDLMM1pYmtuQ@mail.gmail.com>
Date:   Sun, 8 Mar 2020 16:59:16 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7FCF5282-5F2B-42C5-BC85-D3D5B828519A@holtmann.org>
References: <CAB+bgRanN9W4oH00rATmgarRnk4NXPXOdT2K+ZYDLMM1pYmtuQ@mail.gmail.com>
To:     Ordit Gross <ordit.gross@orcam.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ordit,

> our application connects both to mobile (ble) and speakers (br/edr)
> using bluez stack.
> our controller is configured as follows:
> current settings: powered connectable bondable ssp br/edr le secure-conn
> 
> ever since IOS started supporting CTKD (cross-transport key
> derivation) at IOS13, pairing to mobile causes also link key
> distribution and brief br/edr connection follows the ble connection.
> I would like to avoid the link key distribution at the pairing stage.
> the only way I was able to achieve that is by disabling either
> secure-conn or ssp which is undesirable as disabling either of them
> block other functionality.
> what is the recommended approach?
> 
> ** when br/edr is turned off we do not experience disconnections from
> mobile app running with IOS13. and vis versa.
> looking on HCI dump from mobile side the disconnections is initiated
> from mobile side, however the application is not the one initiating
> the disconnections.
> any advice is greatly appreciated

you would have to show the btmon trace for this. The extra connection is not needed for cross-transport pairing and seems to be iOS specific to check that the connection actually works.

From our side it is by design that if both transports use the same identity address, that both sides are being paired. So this is pretty much intentional. If you disable BR/EDR, then of course pairing will stick to just pair LE only.

Regards

Marcel

