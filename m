Return-Path: <SRS0=OJUr=VD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94473C0650E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 13:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753AD20989
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 13:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfGFNbO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Jul 2019 09:31:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42100 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfGFNbO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Jul 2019 09:31:14 -0400
Received: from [192.168.0.171] (188.146.228.97.nat.umts.dynamic.t-mobile.pl [188.146.228.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 37FD9CF12E;
        Sat,  6 Jul 2019 15:39:45 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] v7 Add support for LE ping feature
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1561108916-9521-1-git-send-email-spoorthix.k@intel.com>
Date:   Sat, 6 Jul 2019 15:31:12 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2DC554C7-7E4C-4977-865F-228302B9292E@holtmann.org>
References: <1561108916-9521-1-git-send-email-spoorthix.k@intel.com>
To:     SpoorthiX K <spoorthix.k@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Spoorthi,

> Changes made to add HCI Write Authenticated Payload timeout
> command for LE Ping feature.
> As per the Core Specification 5.0 Volume 2 Part E Section 7.3.94,
> the following code changes implements
> HCI Write Authenticated Payload timeout command for LE Ping feature.
> 
> Signed-off-by: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>
> ---
> include/net/bluetooth/hci.h      | 20 +++++++++++
> include/net/bluetooth/hci_core.h |  4 +++
> net/bluetooth/hci_conn.c         |  3 ++
> net/bluetooth/hci_core.c         |  1 +
> net/bluetooth/hci_debugfs.c      | 31 +++++++++++++++++
> net/bluetooth/hci_event.c        | 72 ++++++++++++++++++++++++++++++++++++++++
> 6 files changed, 131 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

