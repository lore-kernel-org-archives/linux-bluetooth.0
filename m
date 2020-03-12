Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5160C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 07:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C2C206F7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 07:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbgCLHYz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 03:24:55 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50170 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbgCLHYz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 03:24:55 -0400
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9CF5ACECF5;
        Thu, 12 Mar 2020 08:34:22 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2 2/2] input: Add LEAudioSecurity setting to input.conf
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200311185937.9032-2-luiz.dentz@gmail.com>
Date:   Thu, 12 Mar 2020 08:24:53 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B5E587C9-4EC9-4559-856E-BDCFD27CFDC1@holtmann.org>
References: <20200311185937.9032-1-luiz.dentz@gmail.com>
 <20200311185937.9032-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> LEAudioSecurity can be used to enable/disable automatic upgrades of
> security for LE devices, by default it is enabled so existing devices
> that did not require security and were not bonded will automatically
> upgrade the security.

LEAudioSecurity?

Regards

Marcel

