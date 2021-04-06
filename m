Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7939C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Apr 2021 15:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F64B613C4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Apr 2021 15:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345452AbhDFPGD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Apr 2021 11:06:03 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56711 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345382AbhDFPGC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Apr 2021 11:06:02 -0400
Received: from marcel-macbook.holtmann.net (p4ff9f418.dip0.t-ipconnect.de [79.249.244.24])
        by mail.holtmann.org (Postfix) with ESMTPSA id 88963CEC82;
        Tue,  6 Apr 2021 17:13:35 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH 2/2] Bluetooth: LL privacy allow RPA
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5698706.lOV4Wx5bFT@ix>
Date:   Tue, 6 Apr 2021 17:05:52 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Sathish Narasimman <sathish.narasimman@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        ravishankar.srivatsa@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <95439D79-1AED-4AA3-A55E-8BCA9C822F01@holtmann.org>
References: <20210405143041.16168-1-sathish.narasimman@intel.com>
 <5698706.lOV4Wx5bFT@ix>
To:     Szymon Janc <szymon.janc@codecoup.pl>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

>> allow RPA to add bd address to whitelist
>> 
>> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
>> ---
>> net/bluetooth/hci_request.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>> 
>> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
>> index 0d78122342d5..560b74d421a8 100644
>> --- a/net/bluetooth/hci_request.c
>> +++ b/net/bluetooth/hci_request.c
>> @@ -847,6 +847,10 @@ static u8 update_white_list(struct hci_request *req)
>> 	 */
>> 	bool allow_rpa = hdev->suspended;
>> 
>> +	if (use_ll_privacy(hdev) &&
>> +	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
>> +		allow_rpa = true;
>> +
>> 	/* Go through the current white list programmed into the
>> 	 * controller one by one and check if that address is still
>> 	 * in the list of pending connections or list of devices to
> 
> I'm bit confused by this patch. Why add RPA to whitelist if LL privacy is in 
> use?

if link layer privacy is enabled and the IRK programmed into the resolving list, we are now allowed to add the device to the white list.

Regards

Marcel

