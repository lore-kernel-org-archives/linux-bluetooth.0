Return-Path: <cyrus@holtmann.org>
Message-ID: <527737C7.40208@canonical.com>
Date: Mon, 04 Nov 2013 13:59:35 +0800
From: Hui Wang <hui.wang@canonical.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Tedd An <tedd.an@intel.com>, Johan Hedberg <johan.hedberg@intel.com>,
 xiong.y.zhang@intel.com,
 "Gustavo F. Padovan" <gustavo.padovan@collabora.co.uk>,
 "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>,
 Kun Yang <kun.yang@canonical.com>,
 Anthony Wong <anthony.wong@canonical.com>
Subject: Re: Intel 7260 bluetooth malfunction when it is connected to EHCI
 bus
References: <526F8804.9060906@canonical.com> <A07820C9-C272-4AD4-AE16-49F81956C2D7@holtmann.org> <52707428.9070908@canonical.com> <6091DDC7-7B00-4457-82A0-F8CC9B4EE9DD@holtmann.org> <5271EAA2.1030705@canonical.com> <D0B840E3-36C4-4751-A757-1ADDAC0707B9@holtmann.org> <5273147E.4040004@canonical.com> <C3BBD7E9-6D91-430E-96DF-2D4885F89DCC@holtmann.org> <527371D4.1010305@canonical.com> <9DFD9618-158E-41C4-8183-134A3FC4E61F@holtmann.org>
In-Reply-To: <9DFD9618-158E-41C4-8183-134A3FC4E61F@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 11/03/2013 03:05 AM, Marcel Holtmann wrote:
> Hi Hui,
>
<snip>
>>
>> The attachment lenovo-k4450-btmon-v1.log is the log of intel 7260 init procedure + scan headset + connect headset + play sound.
> I looked through the logs and the controller init is just fine. So in theory this should route the SCO audio frames over HCI. For some reason it does not and I have no idea why not.
>
> That it makes a different between EHCI and XHCI is strange. I can not explain this. Maybe Tedd can help you since I have no further insights in our chips at this moment.

Thanks Marcel for your kind help and analysis.

Tedd, did you reproduce this issue on the machines with intel 7260 BT 
module connected to the EHCI bus? Did you have any idea on this issue?

Thanks,
Hui.

>
> Regards
>
> Marcel
>
>
