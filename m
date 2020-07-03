Return-Path: <SRS0=5fpF=AO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D533AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jul 2020 13:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B534E2070A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jul 2020 13:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgGCNDD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:03:03 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:32797 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgGCNDD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jul 2020 09:03:03 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 28816CED26;
        Fri,  3 Jul 2020 15:12:57 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] Bluetooth: le_supported_roles experimental feature
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2CCCE793-1489-4162-AD02-A5737718B956@holtmann.org>
Date:   Fri, 3 Jul 2020 15:03:01 +0200
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <A86FD76A-EA51-4A55-9F7B-D5675A3943E2@holtmann.org>
References: <20200701220853.421445-1-alainm@chromium.org>
 <427B6E1C-178C-405D-88F8-899EC48AC8A9@holtmann.org>
 <CALWDO_XT=O4NiqMur+_u1z4o0868ZzBr4gpUikgmgw2U4zqMzw@mail.gmail.com>
 <2CCCE793-1489-4162-AD02-A5737718B956@holtmann.org>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>>> This patch adds an le_supported_roles features which allows a
>>> clients to determine if the controller is able to support peripheral and
>>> central connections separately and at the same time.
>>> 
>>> Signed-off-by: Alain Michaud <alainm@chromium.org>
>>> ---
>>> 
>>> Changes in v2:
>>> - Slight change of design based on offline feedback
>>> 
>>> net/bluetooth/mgmt.c | 36 +++++++++++++++++++++++++++++++++++-
>>> 1 file changed, 35 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>>> index 5e9b9728eeac..c13fcc21745f 100644
>>> --- a/net/bluetooth/mgmt.c
>>> +++ b/net/bluetooth/mgmt.c
>>> @@ -3753,10 +3753,36 @@ static const u8 debug_uuid[16] = {
>>> };
>>> #endif
>>> 
>>> +/* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
>>> +static const u8 le_supported_roles[16] = {
>>> +     0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
>>> +     0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
>>> +};
>>> +
>>> +static u32 get_le_roles_flags(struct hci_dev *hdev)
>>> +{
>>> +     u32 flags = 0;
>>> +
>>> +     /* Central connections supported */
>>> +     if (hdev->le_states[4] & 0x08)
>>> +             flags |= BIT(0);
>>> +
>>> +     /* Peripheral connections supported */
>>> +     if (hdev->le_states[4] & 0x40)
>>> +             flags |= BIT(1);
>>> +
>>> +     /* Simult central and peripheral connections supported */
>>> +     if (test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) &&
>>> +         (hdev->le_states[3] & 0x10))
>>> +             flags |= BIT(2);
>>> +
>>> +     return flags;
>>> +}
>> 
>> this is not what we can do here. The flags are defined like this.
>> 
>>        The following bits are defined for the Flags parameter:
>> 
>>                0       Feature active
>>                1       Causes change in supported settings
>> 
>> And I want these flags for generic handling of experimental features. Individual features can not overwrite it.
>> 
>> So if you only want to support a the “read" functionality, then something like this please.
>> 
>>        if ((hdev->le_states[4] & 0x08) &&      /* Central */
>>            (hdev->le_states[4] & 0x40) &&      /* Peripheral */
>>            (hdev->le_states[3] & 0x10) &&      /* Simultaneous */
>>            test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks))
>>                flags |= BIT(0);
>> 
>> OK, Since the userspace Api we discussed reports individual states, would you suggest if LE is supported that the Central and Peripheral roles are supported and just use this to query the simultaneous support?
> 
> you get the Central state support from the LE setting and Peripheral from the Advertising setting. So I think the only extra information you would need is the support for both at the same time.
> 
> That said, I have been discussing with Daniel if we could extend (and with that rename) the Read Security Information command and allow it to report static information about the controller support. Maybe it fits better there. However for now, I would just export this via a simple experimental feature.

so something like this and then we can extend it.

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index ca0d38469e56..84a26183029d 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3110,20 +3110,20 @@ Set Wideband Speech Command
                                Invalid Index
 
 
-Read Security Information Command
-=================================
+Read System Information Command
+===============================
 
        Command Code:           0x0048
        Controller Index:       <controller id>
        Command Parameters:
-       Return Parameters:      Security_Data_Length (2 Octets)
-                               Security_Data (0-65535 Octets)
+       Return Parameters:      System_Data_Length (2 Octets)
+                               System_Data (0-65535 Octets)
 
-       This command is used to retrieve the supported security features
-       by the controller or the host stack.
+       This command is used to retrieve the supported system and security
+       features by the controller or the host stack.
 
-       The Security_Data_Length and Security_Data parameters provide
-       a list of security settings, features and information. It uses
+       The System_Data_Length and System_Data parameters provide a list
+       of system and security settings, features and information. It uses
        the same format as EIR_Data, but with the namespace defined here.
 
                Data Type       Name
@@ -3131,6 +3131,8 @@ Read Security Information Command
                0x01            Flags
                0x02            Max Encryption Key Size (BR/EDR)
                0x03            Max Encryption Key Size (LE)
+               0x04            Transmit Power (BR/EDR)
+               0x05            Transmit Power (LE)
 
        Flags (data type 0x01)
 
@@ -3146,6 +3148,11 @@ Read Security Information Command
                present, then it is unknown what the max encryption key
                size of the controller or host is in use.
 
+       Transmit Power (data types 0x04 and 0x05)
+
+               When this field is present, then it provides 4 Octets
+               indicating min and max transmit power values.
+
        This command generates a Command Complete event on success or
        a Command Status event on failure.
 

Regards

Marcel

