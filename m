Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37648C49EA6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 20:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 153A960FE3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 20:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhFXUnT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Jun 2021 16:43:19 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45667 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhFXUnT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Jun 2021 16:43:19 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 355AECECF4;
        Thu, 24 Jun 2021 22:40:59 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: security@ email not working?
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <803e67877866eab5ac0a1944b7e6f4c1ac90635d.camel@hadess.net>
Date:   Thu, 24 Jun 2021 22:40:58 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1EECF4FF-A0AE-49EA-B780-2B41EBA2E165@holtmann.org>
References: <803e67877866eab5ac0a1944b7e6f4c1ac90635d.camel@hadess.net>
To:     Bastien Nocera <hadess@hadess.net>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

> I sent a mail to the security list on Friday, and got a "not delivered"
> message today. Can somebody check whether it works, and let me know
> where I can send my mail? Urgently...
> 
> <security@bluez.org>: host mail.bluez.org[212.227.132.17] said: 454 4.7.1
>    <security@bluez.org>: Relay access denied (in reply to RCPT TO command)
> 
> Cheers
> 

thanks for the info. Should be fixed now.

Regards

Marcel

