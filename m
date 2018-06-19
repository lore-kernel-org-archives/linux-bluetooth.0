Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 19 Jun 2018 12:36:39 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, robh@kernel.org,
 thierry.escande@linaro.org, linux-bluetooth@vger.kernel.org,
 rtatiya@codeaurora.org, hemantg@codeaurora.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 3/8] Bluetooth: btqca: Rename ROME related functions to
 Generic functions
In-Reply-To: <20180618195938.GS88063@google.com>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
 <20180616062718.29844-4-bgodavar@codeaurora.org>
 <20180618195938.GS88063@google.com>
Message-ID: <bdce6bde36a04e3a0f555a3ca3fe58de@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Matthias,

On 2018-06-19 01:29, Matthias Kaehlcke wrote:
> On Sat, Jun 16, 2018 at 11:57:13AM +0530, Balakrishna Godavarthi wrote:
>> Some of the QCA BTSoC ROME functions, are used for different versions
>> or different make of BTSoC's. Instead of duplicating the same 
>> functions
>> for new chip, updating names of the functions that are used for both
>> chip's to keep this generic and would help in future when we would 
>> have
>> new BT SoC.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> 
>> Changes in v7:
>> 	* updated the all the functions of ROME to generic.
>> 
>> Changes in v6:
>> 	* initial patch
>> 	* updated names of functions that are used for both the chips to
>> 	  keep this generic and would help in future when we would have
>> 	  new BT SoC.
>> 
>> ---
> 
> As per my comment on "[2/8] Bluetooth: btqca: Rename string ROME to
> QCA in logs.", it would probably make sense to squash these two
> patches.
> 

[Bala]: will squash [2/8] and [3/8] patches into one.

>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>> index 13d77fd873b6..d0ee96540636 100644
>> --- a/drivers/bluetooth/btqca.h
>> +++ b/drivers/bluetooth/btqca.h
>> @@ -37,7 +37,7 @@
>>  #define EDL_TAG_ID_HCI			(17)
>>  #define EDL_TAG_ID_DEEP_SLEEP		(27)
>> 
>> -enum qca_bardrate {
>> +enum qca_baudrate {
>>  	QCA_BAUDRATE_115200 	= 0,
>>  	QCA_BAUDRATE_57600,
>>  	QCA_BAUDRATE_38400,
> 
> This is a bit sneaky, it is not related with the change nor mentioned
> in the commit message.
> 
> It is certainly a welcome change, but should be done in a separate
> patch (not necessarily in this series).
> 
> The fact that only the enum declaration needs to be fixed indicates
> that the enum isn't used for variables/paramters/return values of this
> type. Also beyond the scope of this series, but using the enum type
> instead of int types would be another possible future improvement.

[Bala]: while reviewing the code, i found this. will leave it for now.
         once this series of patches are done. will send this change in 
different series.

-- 
Regards
Balakrishna.
