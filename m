Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A9DC1975A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 14:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41E0208CA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 14:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgCYOw1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:52:27 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44948 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCYOw1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 10:52:27 -0400
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 29F18CECCF;
        Wed, 25 Mar 2020 16:01:56 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v4] bluetooth: don't assume key size is 16 when the
 command fails.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200325144834.207572-1-alainm@chromium.org>
Date:   Wed, 25 Mar 2020 15:52:24 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <53AACEE6-56A0-4D14-AF46-D9AFFF984B2E@holtmann.org>
References: <20200325144834.207572-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> With this change, the encryption key size is not assumed to be 16 if the
> read_encryption_key_size command fails for any reason.  This ensures
> that if the controller fails the command for any reason that the
> encryption key size isn't implicitely set to 16 and instead take a more
> concervative posture to assume it is 0.
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> 
> ---
> 
> net/bluetooth/hci_event.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

