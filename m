Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79089C2BA17
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 16:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4C524960
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 16:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgDFQeK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:34:10 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42636 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgDFQeK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 12:34:10 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0841FCECC8;
        Mon,  6 Apr 2020 18:43:43 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 0/7] LE LL Priavcy support enabled
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANFp7mUpEwwKCw6xsGWzRXH7q+ZPBJPJaG8n53UsSFd0yfnSzw@mail.gmail.com>
Date:   Mon, 6 Apr 2020 18:34:06 +0200
Cc:     Sathish Narasimman <nsathish41@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <CFD4F017-3572-49A7-8CB8-C5D557E7A43D@holtmann.org>
References: <20200312100754.3445-1-sathish.narasimman@intel.com>
 <CAOVXEJJK0WgeXvwPM=_7kUxrb7O13E5XcaNDpURC6acwrGgXWg@mail.gmail.com>
 <CANFp7mUpEwwKCw6xsGWzRXH7q+ZPBJPJaG8n53UsSFd0yfnSzw@mail.gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

> Looking through the patches in this series, it looks like you are
> adding the IRK for all connected devices and I'm not sure that's the
> best method.
> The resolv list seems to be useful in the same way as the le
> whitelist: to filter incoming advertisements for devices we care
> about.
> 
> Thus, to simplify your design, could we not do the same thing as the
> le whitelist:
> * Update the resolv list anytime passive/background scan is being enabled
> * Only keep entries in the resolv list that are part of the
> pend_le_conn or pend_le_report lists
> 
> Then, you would only need to update the resolv list in
> hci_req_add_le_passive_scan and any IRK changes would just disable
> passive scan, remove IRKs if existing and re-enable passive scan
> (which would add it back with the new one).

so I have been looking at this again and yes, we should just put IRKs in the resolving list for devices that we also put in the whitelist. And we only use the whitelist for background scanning.

This means I would only focus on enabling background scanning. For everything else, we can just let the host do the resolving.

	Enable passive scanning
		-> Enable resolving list if privacy device in whitelist
		-> Set Scan Parameters
		-> Set Scan Enable

	Disable passive scanning
		-> Set Scan Disable
		-> Disable resolving list if enabled

And when updating the whitelist, also add update the resolving list with needed entries for the whitelist. This means if the privacy enabled device goes into the whitelist, add the IRK to the resolving list. Remove all no longer needed IRKs.

Regards

Marcel

