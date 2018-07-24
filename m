Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 24 Jul 2018 12:26:50 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
 rtatiya@codeaurora.org, hemantg@codeaurora.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 3/7] Bluetooth: btqca: Redefine qca_uart_setup() to
 generic function.
In-Reply-To: <20180723174018.GK129942@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-4-bgodavar@codeaurora.org>
 <20180723174018.GK129942@google.com>
Message-ID: <d5764fcd8becc0b04373bc1113d2049a@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthias,

On 2018-07-23 23:10, Matthias Kaehlcke wrote:
> On Fri, Jul 20, 2018 at 07:02:39PM +0530, Balakrishna Godavarthi wrote:
>> Redefinition of qca_uart_setup will help future Qualcomm Bluetooth
>> SoC, to use the same function instead of duplicating the function.
>> Added new arguments soc_type and soc_ver to the functions.
>> 
>> These arguments will help to decide type of firmware files
>> to be loaded into Bluetooth chip.
>> soc_type holds the Bluetooth chip connected to APPS processor.
>> soc_ver holds the Bluetooth chip version.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>>  drivers/bluetooth/btqca.c   | 20 +++++++-------------
>>  drivers/bluetooth/btqca.h   | 13 +++++++++++--
>>  drivers/bluetooth/hci_qca.c | 10 +++++++++-
>>  3 files changed, 27 insertions(+), 16 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index c5cf9cab438a..b556710ee1bd 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -85,6 +85,9 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 
>> *soc_version)
>>  out:
>>  	kfree_skb(skb);
>> 
>> +	if (err < 0 || *soc_version == 0)
>> +		bt_dev_err(hdev, "QCA Failed to get version (%d)", err);
> 
> You also have to set 'err' if soc_version is 0, so the caller can skip
> the check for soc_version == 0
> 
> I'd suggest:
> 
>   // directly after setting soc_version
>   if (*soc_version == 0)
>     err = -EILSEQ; // or should it be a different error code?
> 
>   ...
> 
>   if (err)
>     bt_dev_err(hdev, "QCA Failed to get version (%d)", err);
> 
> You could also limit the error log to the 'if (*soc_version == 0)'
> branch, for all other errors there will already be a more specific log
> entry.
> 

[Bala]: will update.

     if(!err && *soc_version == 0)
         err = -EINVAL; // as soc_version zero is invalid.

    if (err)
       bt_dev_err(hdev, "QCA Failed to get version (%d)", err);

>> +
>>  	return err;
>>  }
> 
> Cheers
> 
> Matthias
-- 
Regards
Balakrishna.
