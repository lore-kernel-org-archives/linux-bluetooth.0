Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EC4C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244236506D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhCPOBn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:01:43 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41449 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhCPOBN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 10:01:13 -0400
Received: from marcel-macbook.holtmann.net (p4fefc126.dip0.t-ipconnect.de [79.239.193.38])
        by mail.holtmann.org (Postfix) with ESMTPSA id 50230CECFB;
        Tue, 16 Mar 2021 15:08:49 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v9 1/9] Bluetooth: btintel: Check firmware version before
 download
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <6644650bbd0e5748368a2468e1df9f181bdc413c.camel@gmail.com>
Date:   Tue, 16 Mar 2021 15:01:11 +0100
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <58062484-8891-4E66-9B6C-918273C31668@holtmann.org>
References: <20210315174002.1778447-1-luiz.dentz@gmail.com>
 <6644650bbd0e5748368a2468e1df9f181bdc413c.camel@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

>> This checks the firmware build number, week and year against the
>> repective loaded version. If details are a match, skip the download
>> process.
>> 
>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> ---
>> v2: Add patch that mover checks for operational mode after the version
>> checking.
>> v3: Fix not checking for operation mode before using btintel_read_boot_params
>> since some models depend on that to contruct the fw filename. Also attempt to
>> cleanup duplicated code.
>> v4: Fix forwarding -EALREADY when firmware has already been loaded.
>> v5: Fix not advancing fw_ptr.
>> v6: Fix btusb_setup_intel_new_get_fw_name error checking for ddc.
>> v7: Disable version checking for WsP/SfP.
>> v8: Really disables version checking for WsP/SfP.
>> v9: Reintroduce bootloader checks and add workaround for version checking when
>> operation and version cannot be read.
>> 
>> drivers/bluetooth/btintel.c   | 106 +++++++++++++++++++++++++++-------
>> drivers/bluetooth/btintel.h   |   5 +-
>> drivers/bluetooth/btusb.c     |  18 +++++-
>> drivers/bluetooth/hci_intel.c |   7 ++-
>> 4 files changed, 109 insertions(+), 27 deletions(-)
> 
> I ran a quick test the v9 with the devices what I have.
> 
> Test cases are:
> - cold boot - expect to downloading the firmware
> - reboot - expect to no firmware downloading
> - fw upgrade - expect to device reset and download new firmware
> 
> Devices tests:
> SfP, WsP, ThP, TyP
> 
> Results:
> ThP, TyP: All 3 test cases were passed.
> SfP, WsP: fw upgrade case(#3) didn't work but it was known issue
> 		- insufficient fw version information in the firmware file
> 
> Tested-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> Tested-by: Kiran K <kiran.k@intel.com>

so I should go ahead and apply these patches?

Regards

Marcel

