Return-Path: <SRS0=msOO=M2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78064C71123
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Oct 2018 08:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E45204FD
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Oct 2018 08:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E45204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeJNQNx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Oct 2018 12:13:53 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47413 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeJNQNx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Oct 2018 12:13:53 -0400
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 64B3BCF352;
        Sun, 14 Oct 2018 10:40:58 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v2 2/2] Bluetooth : Errata Service Release 8, Erratum 3253
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1538731093-30347-2-git-send-email-mallikarjun.phulari@intel.com>
Date:   Sun, 14 Oct 2018 10:33:37 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <30AF7F06-F2C7-4642-89F2-03D8C3B24E96@holtmann.org>
References: <1538731093-30347-1-git-send-email-mallikarjun.phulari@intel.com>
 <1538731093-30347-2-git-send-email-mallikarjun.phulari@intel.com>
To:     Mallikarjun Phulari <mallikarjun.phulari@intel.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mallikarjun,

> L2CAP: New result values
> 	0x0006 - Connection refused – Invalid Source CID
> 	0x0007 - Connection refused – Source CID already allocated
> 
> As per the ESR08_V1.0.0, 1.11.2 Erratum 3253, Page No. 54,
> "Remote CID invalid Issue".
> Applies to Core Specification versions: V5.0, V4.2, v4.1, v4.0, and v3.0 + HS
> Vol 3, Part A, Section 4.2, 4.3, 4.14, 4.15.
> 
> Core Specification Version 5.0, Page No.1753, Table 4.6 and
> Page No. 1767, Table 4.14
> 
> New result values are added to l2cap connect/create channel response as
> 0x0006 - Connection refused – Invalid Source CID
> 0x0007 - Connection refused – Source CID already allocated
> 
> Signed-off-by: Mallikarjun Phulari <mallikarjun.phulari@intel.com>
> ---
> include/net/bluetooth/l2cap.h |  2 ++
> net/bluetooth/l2cap_core.c    | 10 +++++++++-
> 2 files changed, 11 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

