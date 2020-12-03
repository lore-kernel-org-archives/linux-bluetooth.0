Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394CAC64E7B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 09:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33B1206A5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 09:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgLCJ5W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 04:57:22 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50723 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgLCJ5W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 04:57:22 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8B706CECF7;
        Thu,  3 Dec 2020 11:03:54 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] Bluetooth: Cancel Inquiry before Create Connection
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAO271m=geLEUjtPhFETfqsYTsxDQoe+=c3WeYPbDuNjwc+4idA@mail.gmail.com>
Date:   Thu, 3 Dec 2020 10:56:39 +0100
Cc:     BlueZ development <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <A99DBCD9-10F5-4594-B639-5A1D9D674764@holtmann.org>
References: <20201124010906.340433-1-sonnysasaka@chromium.org>
 <92C0EFAB-EDF1-4EDB-ADE7-FF734928C8AE@holtmann.org>
 <CAO271m=geLEUjtPhFETfqsYTsxDQoe+=c3WeYPbDuNjwc+4idA@mail.gmail.com>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

>>> Many controllers do not allow HCI Create Connection while it is doing
>>> Inquiry. This patch adds Inquiry Cancel before Create Connection in this
>>> case to allow the controller to do Create Connection. User space will be
>>> aware of this Inquiry cancellation and they may issue another discovery
>>> request afterwards.
>>> 
>>> Sample Command Disallowed response of HCI Create Connection:
>>> < HCI Command: Inquiry (0x01|0x0001) plen 5
>>>       Access code: 0x9e8b33 (General Inquiry)
>>>       Length: 10.24s (0x08)
>>>       Num responses: 0
>>>> HCI Event: Command Status (0x0f) plen 4
>>>     Inquiry (0x01|0x0001) ncmd 2
>>>       Status: Success (0x00)
>>> < HCI Command: Create Connection (0x01|0x0005) plen 13
>>>       Address: XX:XX:XX:XX:XX:XX
>>>       Packet type: 0xcc18
>>>       Page scan repetition mode: R2 (0x02)
>>>       Page scan mode: Mandatory (0x00)
>>>       Clock offset: 0x0000
>>>       Role switch: Allow slave (0x01)
>>>> HCI Event: Command Status (0x0f) plen 4
>>>     Create Connection (0x01|0x0005) ncmd 1
>>>       Status: Success (0x00)
>>>> HCI Event: Connect Complete (0x03) plen 11
>>>       Status: Command Disallowed (0x0c)
>>>       Handle: 65535
>>>       Address: XX:XX:XX:XX:XX:XX
>>>       Link type: ACL (0x01)
>>>       Encryption: Disabled (0x00)
>>> 
>>> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>>> Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>
>>> 
>>> ---
>>> net/bluetooth/hci_conn.c | 11 +++++++++++
>>> 1 file changed, 11 insertions(+)
>>> 
>>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>>> index 4f1cd8063e720..b41ad08f8d411 100644
>>> --- a/net/bluetooth/hci_conn.c
>>> +++ b/net/bluetooth/hci_conn.c
>>> @@ -233,6 +233,17 @@ static void hci_acl_create_connection(struct hci_conn *conn)
>>>      else
>>>              cp.role_switch = 0x00;
>>> 
>>> +     /* Many controllers disallow HCI Create Connection while it is doing
>>> +      * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
>>> +      * Connection. This may cause the MGMT discovering state to become false
>>> +      * without user space's request but it is okay since the MGMT Discovery
>>> +      * APIs do not promise that discovery should be done forever. Instead,
>>> +      * the user space monitors the status of MGMT discovering and it may
>>> +      * request for discovery again when this flag becomes false.
>>> +      */
>>> +     if (test_bit(HCI_INQUIRY, &hdev->flags))
>>> +             hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
>>> +
>> 
>> while this seems acceptable, what happens when we have interleaved discovery where we toggle between BR/EDR inquiry and LE scanning. Are you sure we not better cancel the mgmt discovery completely.
> Only Inquiry is preventing Create Connection, so we don't need to
> overcomplicate it by stopping the mgmt discovery completely. In the
> case of interleaved discovery, the LE discovery will linger for a
> little bit before eventually being disabled and the situation restarts
> at a good state. Not perfect but simple, clean, and fixes the issue.

can we get a mgmt-tester test case for this that also checks the various combinations of this.

And coming to think about it, should we mark controllers as “good” if they allow create connection and inquiry at the same time? So we do this conditionally based on what controller we have.

Eventually we have to get to the level to create a proper state machine for BR/EDR and LE so that we serialize all of these commands accordingly. That way we can easily continue where we left off. This should also come in handy for any kind of suspend / resume handling. Since at the end of the day it is all the same problem. We need to pause some radio activity and continue afterwards.

In case this wasn’t clear, I am not in favor of just sending a command and hope for the best. That got us in trouble with BlueZ 3.x and to large extend also with BlueZ 4.x since weird corner cases will bring us out of sync.

Regards

Marcel

