Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] Bluetooth: btusb: Release RF resource on BT shutdown
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <EFE6F46E14A5F445949D76A8CAC2240058312CE6@PGSMSX105.gar.corp.intel.com>
Date: Thu, 2 Aug 2018 18:21:30 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Message-Id: <1367E628-2E75-417A-9F55-B395DA9DB379@holtmann.org>
References: <EFE6F46E14A5F445949D76A8CAC2240058312B34@PGSMSX105.gar.corp.intel.com>
 <E73127F5-D0B0-41C8-8025-0F2D3E836D3E@holtmann.org>
 <EFE6F46E14A5F445949D76A8CAC2240058312CE6@PGSMSX105.gar.corp.intel.com>
To: "Bag, Amit K" <amit.k.bag@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amit,

>>>>> In case of BT turn off from UI it is safe to add HCI reset command 
>>>>> which will maintain the controller state.
>>>> 
>>>> this needs to be a bit more details since hdev->shutdown handling is really only for the older Intel controllers.
>>> 
>>>> Also I am failing to see why HCI Reset helps or what it does here. It is going to be called again on hdev->open the next time the controller is activated.
>>>> 
>>>>> 
>>>>> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
>>>>> ---
>>>>> drivers/bluetooth/btusb.c | 12 ++++++++++++
>>>>> 1 file changed, 12 insertions(+)
>>>>> 
>>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c 
>>>>> index 572fd75fbcf6..599ec9b12d3f 100644
>>>>> --- a/drivers/bluetooth/btusb.c
>>>>> +++ b/drivers/bluetooth/btusb.c
>>>>> @@ -2369,6 +2369,18 @@ static int btusb_shutdown_intel(struct hci_dev *hdev)
>>>>> 	struct sk_buff *skb;
>>>>> 	long ret;
>>>>> 
>>>>> +	/* In case of BT off from UI it is safe to do HCI reset.
>>>>> +	 * This will maintain the controller state.
>>>>> +	 */
>>>> 
>>>> I do not care what the UI does here. This is power down operation and so it needs to be explained properly. And with a lot more details since I am failing to understand what state is maintained on HCI Reset. As per specification it will reset all Bluetooth >> > states back to the defaults.
>>>> 
>>>>> +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
>>>>> +        if (IS_ERR(skb)) {
>>>>> +		ret = PTR_ERR(skb);
>>>>> +		BT_ERR("%s: BT controller  HCI reset failed (%ld)",
>>>>> +		       hdev->name, ret);
>>>>> +		return ret;
>>>>> +	}
>>>>> +	kfree_skb(skb);
>>>>> +
>>>> 
>>>>> There is whitespace damage here. And if this hasnât been done yet, please first start using bt_dev_err instead of BT_ERR for the Intel parts.
>>>> 
>>>>> 	/* Some platforms have an issue with BT LED when the interface is
>>>>> 	 * down or BT radio is turned off, which takes 5 seconds to BT LED
>>>>> 	 * goes off. This command turns off the BT LED immediately.
>>>> 
>>>> Regards
>>>> 
>>>> Marcel
>>> 
>>> 
>>> I have updated the patch as per your comments. Please find the patch as below.
>>> 
>>> Issue description: Intel 2765 shares the same RF with Wifi and BT.
>> 
>> 7265 ?
>> 
>>> In the shutdown scenario turn off BT, followed by turn WiFi off and on 
>>> causing error in RF calibration in WiFi Module
>>> 
>>> Solution: before shutdown BT ensure any RF activity to clear by HCI 
>>> reset command.
>>> 
>>> Reference Logs:
>>> ERR kernel: [ 386.193284] iwlwifi 0000:01:00.0: Failed to run INIT 
>>> calibrations: -5 ERR kernel: [ 386.193298] iwlwifi 0000:01:00.0: 
>>> Failed to run INIT ucode: -5 ERR kernel: [ 386.193309] iwlwifi 
>>> 0000:01:00.0: Failed to start RT ucode: -5
>>> 
>>> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
>>> ---
>>> drivers/bluetooth/btusb.c | 15 +++++++++++++++
>>> 1 file changed, 15 insertions(+)
>>> 
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c 
>>> index 572fd75fbcf6..4a3b6a7dc86f 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -2369,6 +2369,21 @@ static int btusb_shutdown_intel(struct hci_dev *hdev)
>>>       struct sk_buff *skb;
>>>       long ret;
>>> 
>>> +       /* ISSUE: In shutdown sequence where BT turn off and followed
>> 
>> Scrap the word ISSUE: since that is not needed. Just describe why we are doing this.
>> 
>>> +        * by WiFi turn off, and if Wifi is turn on back, Wifi is unable
>>> +        * to do the RF calibration.(observe this on INTEL 7265)
>> 
>> No need for the text in ()
>> 
>>> +        *
>>> +        * Solution: before shutdown BT ensure any RF activity to clear
>>> +        * by send this command.
>>> +        */
>> 
>> Scrap the Solution: and bring this in as proper sentence.
>> 
>>> +       skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
>>> +       if (IS_ERR(skb)) {
>>> +               ret = PTR_ERR(skb);
>>> +               bt_dev_err(hdev, "%s: HCI reset failed\n", __func__);
>> 
>> Scrap the __func__ usage. We are not doing this. Also no \n with the bt_dev_err. If you want this clear then "HCI reset on shutdown failed”.
>> 
>>> +               return ret;
>>> +       }
>>> +       kfree_skb(skb);
>>> +
>>>       /* Some platforms have an issue with BT LED when the interface is
>>>        * down or BT radio is turned off, which takes 5 seconds to BT LED
>>>        * goes off. This command turns off the BT LED immediately.
> 
> I have updated the patch as per your comments. Please find the patch as below.
> 
> Issue description: Intel 7265 shares the same RF with Wifi and BT.
> In the shutdown scenario turn off BT, followed by turn WiFi off
> and on causing error in RF calibration in WiFi Module
> 
> Solution: HCI reset command should clear any RF activity  before shutdown BT.
> 
> Reference Logs:
> ERR kernel: [ 386.193284] iwlwifi 0000:01:00.0: Failed to run INIT calibrations: -5
> ERR kernel: [ 386.193298] iwlwifi 0000:01:00.0: Failed to run INIT ucode: -5
> ERR kernel: [ 386.193309] iwlwifi 0000:01:00.0: Failed to start RT ucode: -5
> 
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
> drivers/bluetooth/btusb.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 572fd75fbcf6..5a59dd91062d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2369,6 +2369,20 @@ static int btusb_shutdown_intel(struct hci_dev *hdev)
>        struct sk_buff *skb;
>        long ret;
> 
> +       /* In shutdown sequence where BT turn off and followed
> +        * by WiFi turn off, and if Wifi is turn on back, Wifi is unable
> +        * to do the RF calibration.
> +        *
> +        * This command should clear any RF activity  before shutdown BT.
> +        */

	/* In the shutdown sequence where Bluetooth is turned off followed
	 * by WiFi being turned off, turning WiFi back on causes issue with
	 * the RF calibration.
	 *
	 * To ensure that any RF activity has been stopped, issue HCI Reset
	 * command to clear all ongoing activity including advertising,
	 * scanning etc.
	 */

> +       skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               ret = PTR_ERR(skb);
> +               bt_dev_err(hdev, "HCI reset on shutdown failed");
> +               return ret;
> +       }
> +       kfree_skb(skb);
> +
>        /* Some platforms have an issue with BT LED when the interface is
>         * down or BT radio is turned off, which takes 5 seconds to BT LED
>         * goes off. This command turns off the BT LED immediately.

And then send a proper v2 of the patch.

Regards

Marcel

