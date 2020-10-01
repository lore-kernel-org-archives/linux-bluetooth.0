Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7453C4727E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 07:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7E021531
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 07:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgJAHAh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 03:00:37 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58532 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAHAh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 03:00:37 -0400
Received: from marcel-macbook.fritz.box (p4fefc7f4.dip0.t-ipconnect.de [79.239.199.244])
        by mail.holtmann.org (Postfix) with ESMTPSA id 174BBCECD2;
        Thu,  1 Oct 2020 09:07:36 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [Bluez PATCH v3 2/9] doc/mgmt-api: Add new MGMT interfaces to
 mgmt-api
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAP2xMbsAGZU8uKNqee6AM0+MSkscL-YRWbzQYETgwbjijThBHA@mail.gmail.com>
Date:   Thu, 1 Oct 2020 09:00:35 +0200
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <A291C964-6FA4-4C3D-9802-3F3F9279F2E2@holtmann.org>
References: <20200925011347.2478464-1-danielwinkler@google.com>
 <20200924180838.Bluez.v3.2.If15d3d09724ded2bcc7240d29f6888f2ad12e723@changeid>
 <311BC779-4869-4092-B715-5D041F163192@holtmann.org>
 <CAP2xMbsAGZU8uKNqee6AM0+MSkscL-YRWbzQYETgwbjijThBHA@mail.gmail.com>
To:     Daniel Winkler <danielwinkler@google.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

>>> This patch adds the following to mgmt-api:
>>> - Add Extended Advertising Parameters Command
>>> - Add Extended Advertising Data Command
>>> - Changes Read Security Info to Read Controller Capabilities CMD
>>> 
>>> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
>>> Reviewed-by: Alain Michaud <alainm@chromium.org>
>>> ---
>>> 
>>> Changes in v3:
>>> - Removed Tx Power Selected MGMT event
>>> - Changed Read Security Info cmd to  Read Controller Capabilities
>>> 
>>> Changes in v2:
>>> - Removed extra space in Add Extended Advertising Parameters API
>>> 
>>> doc/mgmt-api.txt | 229 +++++++++++++++++++++++++++++++++++++++++++++--
>>> 1 file changed, 223 insertions(+), 6 deletions(-)
>>> 
>>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>>> index ca0d38469..85aa8b797 100644
>>> --- a/doc/mgmt-api.txt
>>> +++ b/doc/mgmt-api.txt
>>> @@ -3110,19 +3110,19 @@ Set Wideband Speech Command
>>>                              Invalid Index
>>> 
>>> 
>>> -Read Security Information Command
>>> +Read Controller Capabilities Command
>>> =================================
>> 
>> I am fine with the name. Just extend the === to match the text above.
>> 
>>> 
>>>      Command Code:           0x0048
>>>      Controller Index:       <controller id>
>>>      Command Parameters:
>>> -     Return Parameters:      Security_Data_Length (2 Octets)
>>> -                             Security_Data (0-65535 Octets)
>>> +     Return Parameters:      Capabilities_Data_Length (2 Octets)
>>> +                             Capabilities_Data (0-65535 Octets)
>>> 
>>> -     This command is used to retrieve the supported security features
>>> +     This command is used to retrieve the supported capabilities
>>>      by the controller or the host stack.
>>> 
>>> -     The Security_Data_Length and Security_Data parameters provide
>>> +     The Capabilities_Data_Length and Capabilities_Data parameters provide
>>>      a list of security settings, features and information. It uses
>>>      the same format as EIR_Data, but with the namespace defined here.
>>> 
>>> @@ -3131,6 +3131,8 @@ Read Security Information Command
>>>              0x01            Flags
>>>              0x02            Max Encryption Key Size (BR/EDR)
>>>              0x03            Max Encryption Key Size (LE)
>>> +             0x04            Min Supported LE Tx Power (dBm)
>>> +             0x05            Max Supported LE Tx Power (dBm)
>> 
>> I would actually prefer if we put them into a 2 octet size value. So two times s8 fields. And then just call it "Supported Tx Power (LE)”.
>> 
>>> 
>>>      Flags (data type 0x01)
>>> 
>>> @@ -3146,6 +3148,15 @@ Read Security Information Command
>>>              present, then it is unknown what the max encryption key
>>>              size of the controller or host is in use.
>>> 
>>> +     Min/Max Supported LE Tx Power (data types 0x04 and 0x05)
>>> +
>>> +             These fields indicate the supported range of LE Tx Power in
>>> +             dBm across all supported PHYs. These values are populated
>>> +             by the return of the LE Read Transmit Power HCI command. If
>>> +             this HCI command is not available, the values default to
>>> +             0x7F, indicating HCI_TX_POWER_INVALID, as a valid range
>>> +             is not available.
>>> +
>> 
>> Actually no. If the command is not available or failed, then this field will not be present. Clearly indicate the absence. The should be a clear difference if the command is not available and the controller returning -127.
>> 
>> Can we split this change into a separate patch please.
>> 
>>>      This command generates a Command Complete event on success or
>>>      a Command Status event on failure.
>>> 
>>> @@ -3574,6 +3585,212 @@ Remove Advertisement Monitor Command
>>>                              Busy
>>> 
>>> 
>>> +Add Extended Advertising Parameters Command
>>> +===========================================
>>> +
>>> +     Command Code:           0x0054
>>> +     Controller Index:       <controller id>
>>> +     Command Parameters:     Instance (1 Octet)
>>> +                             Flags (4 Octets)
>>> +                             Params (2 Octets)
>>> +                             Duration (2 Octets)
>>> +                             Timeout (2 Octets)
>>> +                             MinInterval (4 Octets)
>>> +                             MaxInterval (4 Octets)
>>> +                             TxPower (1 Octet)
>>> +     Return Parameters:      Instance (1 Octet)
>>> +                             TxPower (1 Octet)
>> 
>> If we leave the Flags that tell what adv data and scan rsp data to add, then we should also return the leftover sizes of each fields so that the caller knows how much they can occupy. So that you don’t have to use Get Advertising Size Information command to get that information. We already know it at this point in time.
> 
> Hi Marcel, I am happy to add the remaining space available for
> advertising and scan response data to the response here. However,
> userspace already has a local function,
> advertising.c:calc_max_adv_len(), that computes the losses caused by
> these flags. I imagine that this feature will be useful for any other
> application not using userspace bluez so I will add it to the
> response, but at the moment userspace does not need it. Please let me
> know if you have any further thoughts on this point.

I prefer that userspace does not have to guess or we have to keep kernel implementation in sync with usersapce. So if we tell userspace just what space it has available, that is cleaner.

Regards

Marcel

