Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH 2/2] Bluetooth: hciuart: Add to support QCA ROME configuration
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55BBA3DC.20305@qca.qualcomm.com>
Date: Fri, 31 Jul 2015 18:53:45 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <606C7E32-7D26-4BDF-B43C-1EAAD6018733@holtmann.org>
References: <55B97ECE.7020307@qca.qualcomm.com> <DD3468DA-08F6-429B-AF85-9D7FC5BD3876@holtmann.org> <55BA9FBE.8080300@qca.qualcomm.com> <C202B61F-0E39-47AB-942A-52A6E58336EF@holtmann.org> <55BBA3DC.20305@qca.qualcomm.com>
To: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ben,

>>>> +
>>>> +#ifdef CONFIG_SERIAL_MSM_HS
>>>> +#include <linux/platform_data/msm_serial_hs.h>
>>>> +#endif
>>>> I do not like platform data. Why can't this be done with device tree?
>>> This is specific code for MSM UART HighSpeed code which is not upstreamed yet. The MSM device tree has already defined this config_serial_msm_hs. I'd like to move this part to btqca.c module since it is for vendor specific implementation.
>> if the MSM UART HS code is not upstream yet, then please do not try to add hooks into the Bluetooth code. Submit patches without this and add the support later when the other code makes it upstream.
>> 
>> I am not taking dead code. None of the kernel maintainers does.
> 
> Okay, I'll remove this code and come back after code is completely upstreamed from MSM UART HS part. Without this part, it perfectly works on x86 environment.
> 
>>>>> +static int rome_set_baudrate(struct hci_dev *hdev, unsigned int speed)
>>>>> +{
>>>>> +    struct sk_buff *skb;
>>>>> +    uint8_t baudrate;
>>>>> +
>>>>> +    if (speed > 3000000)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    BT_INFO("%s: Set controller UART speed to %d", hdev->name, speed);
>>>>> +
>>>>> +    baudrate = rome_get_baudrate(speed);
>>>>> +    skb = __hci_cmd_sync(hdev, EDL_PATCH_BAUDRATE, 1, &baudrate,
>>>>> +                 msecs_to_jiffies(100));
>>>> Introduce proper constant defines for timeout or use HCI_INIT_TIMEOUT.
>>>> 
>>>>> +    if (IS_ERR(skb)) {
>>>>> +        if (PTR_ERR(skb) == -ETIMEDOUT)
>>>>> +            return 0;
>>>> Why return success when it times out?
>>>> 
>>> QCA ROME doesn't return cc event after recieving baudrate command changed because it triggers HCI_RESET right away and set to new baudrate to communicate with host. Hence timeout can be handled as succeed case. If something goes wrong after changing baudrate, commands follow-ed won't be delivered to controller.
>> I think what we actually want simple hci_cmd_send that allows us to just send the command and not bother with command status or command complete. It seems that has come up a bit more often lately. We have something like this, but I do not think it is exposed via EXPORT_SYMBOL correct. So this should be done first.
> 
> Yes, that's what I want. The changing baudrate command(VS) does not emit any command status or command complete event from controller after it is addressed. But all HCI APIs exposed have to wait for cc event to go to the next commands. That's why I'm using __hci_cmd_sync() with timeout value to go to the next steps.
> 
>> I however do not understand the HCI_Reset. Who triggers that. The UART baud rate change command in the background. So you are waiting for some event or UART line change to indicate the controller is back up?
> 
> Controller triggers HCI_RESET internally and sets up the proper baudrate after system resets. Hence host doesn't wait for any event from controller. Just wait for some time by having some delay and would try to communicate with controller with proper baudrate with next HCI commands

I really dislike this some time statements. I mean the controller could just send an event that says, I reboot. We could just wait for it then and then continue.

Then again, this is your hardware and if you want to work udelay and similar techniques, this is fine by me.

Regards

Marcel

