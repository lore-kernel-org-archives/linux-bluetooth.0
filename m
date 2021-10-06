Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAED9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 08:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5E3611C0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 08:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhJFIzJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 04:55:09 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42017 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbhJFIzH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 04:55:07 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id C04F0CED39;
        Wed,  6 Oct 2021 10:53:10 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v1] Bluetooth: Read codec capabilities only if supported
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211005144556.22074-1-kiran.k@intel.com>
Date:   Wed, 6 Oct 2021 10:53:10 +0200
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Content-Transfer-Encoding: 7bit
Message-Id: <4BC6025F-F036-4AB2-B6E3-9FEC5271F9F1@holtmann.org>
References: <20211005144556.22074-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Read codec capabilities only if HCI_READ_LOCAL_CODEC_CAPABILITIES
> command is supported. If capablities are not supported, then
> cache codec data without caps.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> net/bluetooth/hci_codec.c | 18 ++++++++++++++++--
> 1 file changed, 16 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

