Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E08AB77C-CFED-4C47-ACE2-5BF773B2BC2F@openbossa.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1312984325.3373.119.camel@aeonflux>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH v2 15/16] Bluetooth: Support LE-Only discovery procedure
Date: Thu, 11 Aug 2011 17:08:58 -0300
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org> <1311623405-31108-16-git-send-email-andre.guedes@openbossa.org> <1312984325.3373.119.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Aug 10, 2011, at 10:52 AM, Marcel Holtmann wrote:

> Hi Andre,
>
>> This patch adds support for LE-Only discovery procedure through
>> management interface.
>>
>> A new flag (HCI_LE_SCAN) was created to inform if the controller is
>> performing LE scan. The HCI_LE_SCAN flag is set/cleared when the
>> controller starts/stops scanning.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/hci.h |    2 ++
>> net/bluetooth/hci_event.c   |   39 +++++++++++++++++++++++++++++++++ 
>> +++---
>> net/bluetooth/mgmt.c        |    5 +++++
>> 3 files changed, 43 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/ 
>> hci.h
>> index fb40388..c4fdeeb 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -86,6 +86,8 @@ enum {
>> 	HCI_DEBUG_KEYS,
>>
>> 	HCI_RESET,
>> +
>> +	HCI_LE_SCAN,
>> };
>
> I am really against adding any new flags here. This is a public API  
> and
> a horrible one actually.
>
> We need to have these states internal and stop adding more flags to  
> this
> public API.

The HCI_LE_SCAN flag is really device/controller related as well as
HCI_INQURY flag is. They both have similar meaning and using. Besides,
the userspace (hciconfig) might be interested in checking this flag to
know if the controller is carrying out the LE scan (just like it does
with HCI_INQUIRY flag).

So, may you consider we keep this flag here?

Thanks,

Andre.
