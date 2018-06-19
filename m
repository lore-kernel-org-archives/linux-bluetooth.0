Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 19 Jun 2018 12:19:41 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, robh@kernel.org,
 thierry.escande@linaro.org, linux-bluetooth@vger.kernel.org,
 rtatiya@codeaurora.org, hemantg@codeaurora.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 2/8] Bluetooth: btqca: Rename string ROME to QCA in
 logs.
In-Reply-To: <20180618194237.GR88063@google.com>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
 <20180616062718.29844-3-bgodavar@codeaurora.org>
 <20180618194237.GR88063@google.com>
Message-ID: <6fe9d7c8a22f284e8ebc47652f7c480e@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthias,

Please find my comments inline.

On 2018-06-19 01:12, Matthias Kaehlcke wrote:
> On Sat, Jun 16, 2018 at 11:57:12AM +0530, Balakrishna Godavarthi wrote:
>> To have generic text in bt_dev_info, bt_dev_err and bt_dev_dbg
>> updated from ROME to QCA where ever possible. This avoids
>> confusion to user, when using the future Qualcomm Bluetooth SoC's.
>> Updated BT_DBG, BT_ERR and BT_INFO with bt_dev_dbg, bt_dev_err and
>> bt_dev_info where ever applicable.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> Changes in v7:
>> 	* initial patch.
>> 	* Updated the logs to generic.
>> 
>> ---
>>  drivers/bluetooth/btqca.c | 56 
>> +++++++++++++++++++--------------------
>>  1 file changed, 27 insertions(+), 29 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 8219816c54a0..a36fae1f3c2c 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -35,36 +35,35 @@ static int rome_patch_ver_req(struct hci_dev 
>> *hdev, u32 *rome_version)
>>  	char cmd;
>>  	int err = 0;
>> 
>> -	BT_DBG("%s: ROME Patch Version Request", hdev->name);
>> +	bt_dev_dbg(hdev, "QCA Version Request");
>> 
>>  	cmd = EDL_PATCH_VER_REQ_CMD;
>>  	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, 
>> EDL_PATCH_CMD_LEN,
>>  				&cmd, HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
>>  	if (IS_ERR(skb)) {
>>  		err = PTR_ERR(skb);
>> -		BT_ERR("%s: Failed to read version of ROME (%d)", hdev->name,
>> -		       err);
>> +		bt_dev_err(hdev, "Reading QCA version information failed (%d)",
>> +			   err);
> 
> [Not really the scope of this patch/series, but an idea for a future
> improvement:
> 
> Some error messages put the error code inside parentheses, others put
> it after a colon. Would be good to unify this (my preference would be
> after the colon).]
> 

[Bala]: will update.

> Shouldn't this patch be squashed with "[3/8] Bluetooth: btqca: Rename
> ROME related functions to Generic functions"? It's a bit odd to do the
> renaming of the functions and log entries in two steps, even though
> the end result is the same.
> 
> What would make sense is to have a separate patch for BT_XYZ() to
> bt_dev_xyz(), though it's probably ok to do it in the patch that
> changes the log strings.

[Bala]: to make review easy, i have segregated into two patches. will 
squash this into [3/8] patch.


-- 
Regards
Balakrishna.
