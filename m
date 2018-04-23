Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 23 Apr 2018 16:09:54 +0530
From: bgodavar@codeaurora.org
To: Thierry Escande <thierry.escande@linaro.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Enable Bluetooth functionality for WCN3990
In-Reply-To: <c10d8c4d-f484-5dbb-23c2-891a4ae3e8b5@linaro.org>
References: <1524144898-4645-1-git-send-email-bgodavar@codeaurora.org>
 <c10d8c4d-f484-5dbb-23c2-891a4ae3e8b5@linaro.org>
Message-ID: <1138604c1910a719ac02c9f88dfc8515@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thierry,

On 2018-04-20 21:40, Thierry Escande wrote:
> Hi Balakrishna,
> 
> On 19/04/2018 15:34, Balakrishna Godavarthi wrote:
>> Add support for wcn3990:
>> 
>> 	These changes are aligned as per serdev frame work.
>>   	We implemented these changes on top of 
>> https://patchwork.kernel.org/patch/10316093/
>> 	As this patch enable serdev for one of the Qualcomm BT chip.
>> 
>> 	The changes in the patch include.
>> 	- Adding support to voting up/down regulators for WCN3990.
>>    	- Bluetooth firmware download for wcn3990.
>>   Add device tree bindings for Atheros chips:
>> 
>> 	These changes are on top of 
>> https://patchwork.kernel.org/patch/10316097/.
>> 	- Description of device tree bindings.
>> 
>> Balakrishna Godavarthi (2):
>>    Bluetooth: Add device tree bindings for Atheros chips
>>    Bluetooth: Add support for wcn3990 soc.
>> 
>>   .../devicetree/bindings/net/qualcomm-bluetooth.txt |  11 +
>>   drivers/bluetooth/btqca.c                          | 393 
>> ++++++++++++----
>>   drivers/bluetooth/btqca.h                          |  49 +-
>>   drivers/bluetooth/hci_qca.c                        | 501 
>> ++++++++++++++++++---
>>   include/net/bluetooth/hci_core.h                   |   3 +-
>>   net/bluetooth/hci_core.c                           |   2 +-
>>   net/bluetooth/hci_request.c                        |  23 +
>>   net/bluetooth/hci_request.h                        |   2 +
>>   8 files changed, 823 insertions(+), 161 deletions(-)
>> 
> 
> This patchset doesn't apply on mainline on top of the hci_qca serdev
> support patchset you mentioned. Please rebase it.
> 
> Regards,
> Thierry


My bad, All these changes are on kernel v4.14, will rebase to latest 
linux tree.

Regards
Balakrishna.
