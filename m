Return-Path: <SRS0=gY20=5B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A40C1975A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Mar 2020 07:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5423320663
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Mar 2020 07:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgCPH7G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Mar 2020 03:59:06 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59909 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbgCPH7G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Mar 2020 03:59:06 -0400
Received: from [192.168.1.91] (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id A7475CECD0;
        Mon, 16 Mar 2020 09:08:34 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v4] Bluetooth: print fw build version in power-on boot
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200316060718.30948-1-amit.k.bag@intel.com>
Date:   Mon, 16 Mar 2020 08:58:34 +0100
List-Id: <linux-firmware.lore.kernel.org>
Cc:     linux-firmware@kernel.org, linux-bluetooth@vger.kernel.org,
        ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Sukumar Ghorai <sukumar.ghorai@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <28F3C98E-99A3-483F-A261-C87D5665BF45@holtmann.org>
References: <20200316060718.30948-1-amit.k.bag@intel.com>
To:     Amit K Bag <amit.k.bag@intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Amit,

> To determine the build version of Bluetooth firmware to ensure reported
> issue related to a particular release. This is very helpful for every fw
> downloaded to BT controller and issue reported from field test.
> 
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
> ---
> drivers/bluetooth/btusb.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

