Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353C6C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 13:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2E920801
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 13:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgFLNqg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:46:36 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58595 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgFLNqg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jun 2020 09:46:36 -0400
Received: from marcel-macbook.fritz.box (ip-109-41-64-170.web.vodafone.de [109.41.64.170])
        by mail.holtmann.org (Postfix) with ESMTPSA id 68A8BCED04;
        Fri, 12 Jun 2020 15:56:24 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 2/3] bluetooth:centralize default value initialization.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200611020157.70230-3-alainm@chromium.org>
Date:   Fri, 12 Jun 2020 15:46:33 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Transfer-Encoding: 7bit
Message-Id: <48F02BEA-45E3-4045-8A46-80F1B5130E5A@holtmann.org>
References: <20200611020157.70230-1-alainm@chromium.org>
 <20200611020157.70230-3-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

please use Bluetooth: as subject prefix.

> This patch centralized the initialization of default parameters.  This
> is required to allow clients to more easily customize the default
> system parameters.
> 
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Alain Michaud <alainm@chromium.org>

Other way around please.

> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
> include/net/bluetooth/hci_core.h | 18 ++++++++++++++++++
> net/bluetooth/hci_conn.c         | 14 ++++----------
> net/bluetooth/hci_core.c         | 14 +++++++++++++-
> net/bluetooth/hci_request.c      | 15 +++++----------
> 4 files changed, 40 insertions(+), 21 deletions(-)

Patch has been applied to bluetooth-next tree.

Regards

Marcel

