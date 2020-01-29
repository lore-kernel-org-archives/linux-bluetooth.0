Return-Path: <SRS0=JIrD=3S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C132DC33CB2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 03:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4F421739
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 03:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgA2D4S convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jan 2020 22:56:18 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:54240 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgA2D4S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jan 2020 22:56:18 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 22F57CECE7;
        Wed, 29 Jan 2020 05:05:37 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: bluetooth: If unknown option in L2CAP Configuration Request is a
 hint, Bluetooth stack responds with "Command Reject" instead of
 "Configuration Response"
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <3020b8d0c7d39428aec573153b3c3414213be7ce.camel@peiker-cee.de>
Date:   Wed, 29 Jan 2020 04:56:16 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <89F234DA-089E-4F45-9D32-7A09CC52E8CD@holtmann.org>
References: <3020b8d0c7d39428aec573153b3c3414213be7ce.camel@peiker-cee.de>
To:     Konstantin Forostyan <konstantin.forostyan@peiker-cee.de>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Konstantin,

> It seems that there's a bug in Bluetooth stack of 4.20 kernel. I
> discovered it during Bluetooth qualification tests. L2CAP/COS/CFD/BV-
> 12-C [Unknown Option Response] test fails because instead of
> "Configuration Response" with error code 0x0003 "unknown option" the
> Bluetooth stack generates "Command Reject".
> 
> I think, this happens because the tester (Bluetooth SIG PTS) uses hints
> as unknown options, and the Bluetooth stack has special handling for
> hints. 
> 
> I made a small patch in order to overcome this problem. Please confirm,
> that the patch is feasible. If not, please suggest how to fix the
> "Command Reject" problem.

is the limited to 4.20 kernel or does it also happen with the latest 5.5 kernel?

Regards

Marcel

