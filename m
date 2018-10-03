Return-Path: <SRS0=yBkr=MP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04DCC00449
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Oct 2018 06:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818E620835
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Oct 2018 06:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818E620835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeJCNnS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:43:18 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47431 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeJCNnS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Oct 2018 09:43:18 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id BB09CCF353;
        Wed,  3 Oct 2018 09:03:33 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] Bluetooth : Errata Service Release 8, Erratum 3253
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <70C091497DE2844DBD9E143B2282ABDA9C2A9C@BGSMSX105.gar.corp.intel.com>
Date:   Wed, 3 Oct 2018 08:56:15 +0200
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <029627CE-BD94-4E2D-AC71-A5EC004F0B03@holtmann.org>
References: <1537780600-4098-1-git-send-email-mallikarjun.phulari@intel.com>
 <6855B2F4-544E-4CE7-A3C9-6324877E25F9@holtmann.org>
 <70C091497DE2844DBD9E143B2282ABDA9C2A9C@BGSMSX105.gar.corp.intel.com>
To:     "Phulari, Mallikarjun" <mallikarjun.phulari@intel.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Malikarjun,

>>> L2CAP: New result values
>>> 	0x0006 - Connection refused – Invalid Source CID
>>> 	0x0007 - Connection refused – Source CID already allocated
>>> 
>>> As per the ESR08_V1.0.0, 1.11.2 Erratum 3253, Page No. 54, "Remote CID
>>> invalid Issue".
>>> Applies to Core Specification versions: V5.0, V4.2, v4.1, v4.0, and
>>> v3.0 + HS Vol 3, Part A, Section 4.2, 4.3, 4.14, 4.15.
>>> 
>>> Core Specification Version 5.0, Page No.1753, Table 4.6 and Page No.
>>> 1767, Table 4.14
>>> 
>>> New result values are added to l2cap connect/create channel response
>>> as
>>> 0x0006 - Connection refused – Invalid Source CID
>>> 0x0007 - Connection refused – Source CID already allocated
>>> 
>>> Signed-off-by: Mallikarjun Phulari <mallikarjun.phulari@intel.com>
>>> ---
>>> include/net/bluetooth/l2cap.h |  6 ++++++
>>> net/bluetooth/l2cap_core.c    | 17 ++++++++++++++++-
>>> 2 files changed, 22 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/include/net/bluetooth/l2cap.h
>>> b/include/net/bluetooth/l2cap.h index 0697fd4..c7f97cc 100644
>>> --- a/include/net/bluetooth/l2cap.h
>>> +++ b/include/net/bluetooth/l2cap.h
>>> @@ -284,6 +284,12 @@ struct l2cap_conn_rsp {
>>> #define L2CAP_CR_INVALID_SCID	0x0009
>>> #define L2CAP_CR_SCID_IN_USE	0x000A
>>> 
>>> +/* connect/create channel results
>>> + * New result codesAs per ESR08_V1.0.0, Erratum 3253  */
>>> +#define L2CAP_CR_BREDR_INVALID_SCID	0x0006
>>> +#define L2CAP_CR_BREDR_SCID_IN_USE	0x0007
>>> +
>> 
>> I am confused here. We currently have this list:
>> 
>> /* connect/create channel results */
>> #define L2CAP_CR_SUCCESS        0x0000
>> #define L2CAP_CR_PEND           0x0001
>> #define L2CAP_CR_BAD_PSM        0x0002
>> #define L2CAP_CR_SEC_BLOCK      0x0003
>> #define L2CAP_CR_NO_MEM         0x0004
>> #define L2CAP_CR_BAD_AMP        0x0005
>> #define L2CAP_CR_AUTHENTICATION 0x0005
>> #define L2CAP_CR_AUTHORIZATION  0x0006
>> #define L2CAP_CR_BAD_KEY_SIZE   0x0007
>> #define L2CAP_CR_ENCRYPTION     0x0008
>> #define L2CAP_CR_INVALID_SCID   0x0009
>> #define L2CAP_CR_SCID_IN_USE    0x000A
>> 
>> Now here we have 0x0006 and 0x0007 taken. Have these been changed now.
>> The L2CAP_CR_AUTHORIZATION we actually do use in LE and if this table is not
>> treated with independent name spaces for BR/EDR vs LE, then we need to split
>> this one first and get the LE only ones proper names and fix their usage.
>> 
> The current name spaces that you have mentioned above, have the combined result values for LE Credit base Connection (VOL 3, Part A, 4.23, Table 4.20) and for L2CAP Create/Connect (VOL3, Part A, 4.3 /4.15, Table 4.6/4.14).
> To create separate name spaces for each set of error codes for L2CAP channel request, L2CAP create Connection and LE credit based create connection will add more rework to replace the error codes where these are being used.
> 
> Therefore, to avoid the rework , I had used the result values as:
> 
> #define L2CAP_CR_BREDR_INVALID_SCID	0x0006
> #define L2CAP_CR_BREDR_SCID_IN_USE	0x0007
> 
> If you suggest to separate the name spaces for LE and BREDR result values, I shall re-send the v3 patch with the changes.

if the currently 0x0006-0x000A are LE only, then we should change their names to L2CAP_CR_LE_* and convert their usages. And then add the new BR/EDR only 0x0006-0x0007 into the list (without _BREDR in the name).

Regards

Marcel

