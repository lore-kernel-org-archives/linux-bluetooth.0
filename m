Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07061C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 18:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E266139D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 18:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhJSS2z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 14:28:55 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37080 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbhJSS2y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 14:28:54 -0400
Received: from smtpclient.apple (p54899aa7.dip0.t-ipconnect.de [84.137.154.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7A818CED07;
        Tue, 19 Oct 2021 20:26:40 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [1/2] bluetooth: use eth_hw_addr_set()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211019110533.5665cc90@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Date:   Tue, 19 Oct 2021 20:26:39 +0200
Cc:     bluez.test.bot@gmail.com,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <90247148-9F5A-4D25-9700-27070659C4C5@holtmann.org>
References: <20211019163346.1384785-1-kuba@kernel.org>
 <616f0064.1c69fb81.3a2d8.9416@mx.google.com>
 <20211019110533.5665cc90@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
To:     Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jakub,

>> Thank you for submitting the patches to the linux bluetooth mailing list.
>> This is a CI test results with your patch series:
>> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=566505
> 
> Eish, sorry, you need 40af35fdf79c ("netdevice: demote the type of some
> dev_addr_set() helpers") from net-next for this change to build cleanly.
> 
> What are your plans on sending a PR for net-next? Probably easiest if I
> resend this after such PR? Or apply directly to net-next.

we have one more pull request for you in the works, but I was not planning
to rebase bluetooth-next if not needed. So just go ahead and take the patch
directly into net-next.

Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

