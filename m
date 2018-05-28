Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 28 May 2018 16:34:18 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
 hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 2/5] Bluetooth: btqca: Rename ROME related functions to
 Generic functions
In-Reply-To: <20180525215742.GA168650@google.com>
References: <20180524160051.29966-1-bgodavar@codeaurora.org>
 <20180524160051.29966-3-bgodavar@codeaurora.org>
 <20180525215742.GA168650@google.com>
Message-ID: <e400a945b4bd63910caaa83652f6eb3c@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthias,

On 2018-05-26 03:27, Matthias Kaehlcke wrote:
> On Thu, May 24, 2018 at 09:30:48PM +0530, Balakrishna Godavarthi wrote:
>> Some of the QCA BTSoC ROME functions, are used for different versions
>> or different make of BTSoC's. Instead of duplicating the same 
>> functions
>> for new chip, updating names of the functions that are used for both
>> chip's to keep this generic and would help in future when we would 
>> have
>> new BT SoC.
> 
> The commit message talks about 'functions', however only the name of
> one function (rome_patch_ver_req()) has changed. From the changes in
> log messages I assume you also intended to rename
> rome_reset() and rome_download_firmware().
> 
[Bala]: may be commit message is confusing, my initial intention in 
changing function names are restricted to functions which are exported 
to hci_qca.c and logs.
         But as per your suggestion i can also change the rome_reset() 
(qca_send_reset) and rome_download_firmware() (qca_download_firmware()) 
too.
         Will update the max possible function names in next incremental 
patch.
         But i will restrict my changes to only required function names. 
will not change the function names related to ROME (common to wnc3990) 
which are called in other files (some function are used in btusb.c)and 
also
         the structure defined with name rome_.*. Changing these name 
could break some functionalities of already available code.

>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> 
>> Changes in v6:
>> 	* initial patch
>> 	* updated names of functions that are used for both the chips to
>> 	  keep this generic and would help in future when we would have
>> 	  new BT SoC.
>> 
>> ---
>>  drivers/bluetooth/btqca.c | 14 +++++++-------
>>  drivers/bluetooth/btqca.h |  6 ++++++
>>  2 files changed, 13 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 8219816c54a0..5c3551239b12 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -27,7 +27,7 @@
>> 
>>  #define VERSION "0.1"
>> 
>> -static int rome_patch_ver_req(struct hci_dev *hdev, u32 
>> *rome_version)
>> +int qca_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
> 
> The different version names are confusing. The name of the function
> calls it 'patch version', the parameter 'rome_version' and the callers
> vary between 'soc_version' and 'rome_version'.
> 
> It would be unfair to ask you to 'fix the world' in this patch series,
> but please stick at least to a consistent naming scheme in the code
> you change. Obviously feel free to squeeze in another cleanup patch :)
> 

[Bala]: will update function and argument names.

>>  static int rome_reset(struct hci_dev *hdev)
>>  {
>>  	struct sk_buff *skb;
>>  	int err;
>> 
>> -	BT_DBG("%s: ROME HCI_RESET", hdev->name);
>> +	bt_dev_dbg(hdev, "QCA BTSoC HCI_RESET");
>> 
>>  	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
>>  	if (IS_ERR(skb)) {
>> @@ -267,7 +267,7 @@ static int rome_download_firmware(struct hci_dev 
>> *hdev,
>>  	const u8 *segment;
>>  	int ret, remain, i = 0;
>> 
>> -	bt_dev_info(hdev, "ROME Downloading %s", config->fwname);
>> +	bt_dev_info(hdev, "QCA BTSoC Downloading %s", config->fwname);
>> 
>>  	ret = request_firmware(&fw, config->fwname, &hdev->dev);
>>  	if (ret) {
>> @@ -339,7 +339,7 @@ int qca_uart_setup_rome(struct hci_dev *hdev, 
>> uint8_t baudrate)
>>  	config.user_baud_rate = baudrate;
>> 
>>  	/* Get ROME version information */
> 
> 'patch version'/'SoC version'/... , whatever the chosen consistent
> name is.
> 
>> -	err = rome_patch_ver_req(hdev, &rome_ver);
>> +	err = qca_patch_ver_req(hdev, &rome_ver);
> 
> rome_ver => ${consistent_name}_ver
> 
> Thanks
> 
> Matthias

Can you please review other patches too so that i can address review 
comments in next patch set.

-- 
Regards
Balakrishna.
