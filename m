Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC036C33CB3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 20:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2232081E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 20:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgAOUhh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:37:37 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:52887 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbgAOUhh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 15:37:37 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 85B43CECF2;
        Wed, 15 Jan 2020 21:46:53 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v5 2/2] Implementation of MGMT_OP_SET_BLOCKED_KEYS.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200107004317.152792-2-alainm@chromium.org>
Date:   Wed, 15 Jan 2020 21:37:35 +0100
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <B37E9643-C00C-4F8E-80CA-27D64D998F88@holtmann.org>
References: <20200107004317.152792-1-alainm@chromium.org>
 <20200107004317.152792-2-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> MGMT command is added to receive the list of blocked keys from
> user-space.
> 
> The list is used to:
> 1) Block keys from being distributed by the device during
>   the ke distribution phase of SMP.
> 2) Filter out any keys that were previously saved so
>   they are no longer used.
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> include/net/bluetooth/hci_core.h | 10 ++++
> include/net/bluetooth/mgmt.h     | 17 +++++++
> net/bluetooth/hci_core.c         | 85 +++++++++++++++++++++++++++++---
> net/bluetooth/hci_debugfs.c      | 17 +++++++
> net/bluetooth/mgmt.c             | 76 ++++++++++++++++++++++++++++
> net/bluetooth/smp.c              | 18 +++++++
> 6 files changed, 215 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

