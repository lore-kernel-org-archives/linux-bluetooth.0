Return-Path: <SRS0=a08L=MJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8629BC43382
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 10:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361E721580
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 10:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361E721580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeI0Q5Q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:57:16 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44381 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbeI0Q5P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Sep 2018 12:57:15 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id BF40BCF16A;
        Thu, 27 Sep 2018 12:46:52 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v2] Bluetooth: Add definitions and track LE resolve list
 modification
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1534471159-26476-1-git-send-email-ankit.p.navik@intel.com>
Date:   Thu, 27 Sep 2018 12:39:36 +0200
Cc:     linux-bluetooth@vger.kernel.org, bharat.b.panda@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <BE0802AD-FD3A-4639-8962-8807A9E56299@holtmann.org>
References: <1534471159-26476-1-git-send-email-ankit.p.navik@intel.com>
To:     Ankit Navik <ankit.p.navik@intel.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ankit,

> Add the definitions for adding entries to the LE resolve list and
> removing entries from the LE resolve list. When the LE resolve list
> gets changed via HCI commands make sure that the internal storage of
> the resolve list entries gets updated.
> 
> Signed-off-by: Ankit Navik <ankit.p.navik@intel.com>
> ---
> include/net/bluetooth/hci.h      | 14 +++++++++
> include/net/bluetooth/hci_core.h | 15 ++++++++++
> net/bluetooth/hci_core.c         | 63 ++++++++++++++++++++++++++++++++++++++++
> net/bluetooth/hci_event.c        | 47 ++++++++++++++++++++++++++++++
> 4 files changed, 139 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

