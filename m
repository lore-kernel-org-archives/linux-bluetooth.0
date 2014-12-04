Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [RFC 1/6] Bluetooth: Add HCI_RSSI_INVALID for unknown RSSI value
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2879632.J5o8eFvCrV@uw000953>
Date: Thu, 4 Dec 2014 11:13:08 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <82B4FEE0-A5A7-4E7B-B526-F278C316DA76@holtmann.org>
References: <1417684441-103825-1-git-send-email-marcel@holtmann.org> <2879632.J5o8eFvCrV@uw000953>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>> The Bluetooth core specification defines the value 127 as invalid for
>> RSSI values. So instead of hard coding it, lets add a constant for it.
>> 
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> include/net/bluetooth/hci.h | 1 +
>> 1 file changed, 1 insertion(+)
>> 
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 569c077778b6..b6f7be1eb919 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -412,6 +412,7 @@ enum {
>> 
>> /* The core spec defines 127 as the "not available" value */
>> #define HCI_TX_POWER_INVALID	127
>> +#define HCI_RSSI_INVALID	127
> 
> Isn't that value depending on command, event, link and controller type?

we use it for the mgmt side of things and there it is whatever we want it to be.

Regards

Marcel

