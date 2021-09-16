Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E88C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 21:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC146120C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 21:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbhIPVrg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:47:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:38014 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234847AbhIPVrf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 17:47:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="202826894"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="202826894"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 14:46:14 -0700
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="699151007"
Received: from cjoseph-mobl.amr.corp.intel.com ([10.252.131.10])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 14:46:13 -0700
Message-ID: <ae7804e8a9877f94a7c798ac4c787a7f7f7f21af.camel@linux.intel.com>
Subject: Re: Intel bt broken on linux-next?
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Jakub Kicinski <kuba@kernel.org>, linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 16 Sep 2021 14:46:13 -0700
In-Reply-To: <20210916132747.218fb12f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210916132747.218fb12f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jakub

On Thu, 2021-09-16 at 13:27 -0700, Jakub Kicinski wrote:
> Hi,
> 
> looks like my Bluetooth stopped working after upgrade to linux-next 
> as of yesterday (next-20210915). Is this a known problem?
> 
> [   19.594522] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 2015
> [   19.595515] Bluetooth: hci0: Device revision is 2
> [   19.595517] Bluetooth: hci0: Secure boot is enabled
> [   19.595517] Bluetooth: hci0: OTP lock is enabled
> [   19.595518] Bluetooth: hci0: API lock is enabled
> [   19.595519] Bluetooth: hci0: Debug lock is disabled
> [   19.595520] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [   19.661829] Bluetooth: hci0: Found device firmware: intel/ibt-17-16-1.sfi
> [   19.661924] Bluetooth: hci0: Boot Address: 0x40800
> [   19.661925] Bluetooth: hci0: Firmware Version: 6-12.21
> [   21.971023] Bluetooth: hci0: command 0xfc09 tx timeout
> [   29.970995] Bluetooth: hci0: Failed to send firmware data (-110)
> [   29.971108] Bluetooth: hci0: sending frame failed (-19)
> [   29.971119] Bluetooth: hci0: Intel reset sent to retry FW download
> [   30.123040] Bluetooth: hci0: sending frame failed (-19)
> [   32.097392] Bluetooth: hci0: command 0xfc1e tx timeout
> [   32.097408] Bluetooth: hci0: Failed to read MSFT supported features (-110)
> 
> I think it's part of:
> 
> 00:14.3 Network controller: Intel Corporation Cannon Point-LP CNVi [Wireless-AC] (rev 30)

I don't think it was known issue to me. 
What was your previous kernel before switching to next-20210915?
Also, do you still have a problem after cold reboot the system? (completely shutdown and wait some
seconds before start).

From the log above, the command (0xfc09) is failing which the device may in the weird state.



Regards,
Tedd

