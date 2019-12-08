Return-Path: <SRS0=rPQ+=Z6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B5DC43603
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Dec 2019 08:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3622A20706
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Dec 2019 08:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfLHIbp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Dec 2019 03:31:45 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46390 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfLHIbp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Dec 2019 03:31:45 -0500
Received: from marcel-macbook.holtmann.net (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 001E1CED09;
        Sun,  8 Dec 2019 09:40:53 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] Fixing checkpatch noise.  No functional changes.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191205182009.154769-1-alainm@chromium.org>
Date:   Sun, 8 Dec 2019 09:31:42 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <62BE0838-4EF4-41EE-B3D5-90FDE9871D39@holtmann.org>
References: <20191205182009.154769-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> ---
> include/net/bluetooth/hci_core.h | 31 +++++++------
> include/net/bluetooth/mgmt.h     |  6 +--
> net/bluetooth/hci_core.c         | 45 +++++++++---------
> net/bluetooth/mgmt.c             | 49 ++++++++++++--------
> net/bluetooth/smp.c              | 78 ++++++++++++++++----------------
> 5 files changed, 114 insertions(+), 95 deletions(-)

can you please break these down into some logical chunks and include the checkpatch complaint in the commit message. None of these look like fundamental style violation. I am happy to take these kind of patches, but sometimes we do ignore checkpatch since the code itself is perfectly fine a human to read.

Regards

Marcel

