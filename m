Return-Path: <SRS0=iDKf=PH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A94C43612
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Dec 2018 10:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9082A2184A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Dec 2018 10:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbeL3KZi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Dec 2018 05:25:38 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36543 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeL3KZi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Dec 2018 05:25:38 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0535DCEE81;
        Sun, 30 Dec 2018 11:33:18 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] bluetooth: realtek: devicetree: Add device tree
 description to bluetooth rtl drivers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
Date:   Sun, 30 Dec 2018 11:25:35 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Content-Transfer-Encoding: 8BIT
Message-Id: <1EC00C22-98BA-4FC2-BE1B-04EB8F983615@holtmann.org>
References: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
To:     David Summers <beagleboard@davidjohnsummers.uk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

> This patch add the relevent device tree handles to the bluetooth driver
> for serial realtek devices.
> 
> Specifically it takes all devices listed in btrtk.c identifes from the
> realtek web site which are serial devices (this invariably means
> devices that end with and "s" in the device name).
> 
> Most of these devices are dual wifi and bluetooth, with wifi on and
> sdio connection, and bluetooth on a serial uart. As these two
> interfaces will need independent listings in the device tree, the
> nodes here have "-bluetooth" added. The only exception is the
> rtl8761atv device, which is bluetooth only - and only has a uart
> interface.
> 
> Can devicetree people revive the naming scheme used here, and confirm
> it is acceptable.
> 
> Marcel, if the device tree people are happy can you apply to the
> bluetooth tree.

where is the email from the DT people acking this and more important also documented it.

Regards

Marcel

