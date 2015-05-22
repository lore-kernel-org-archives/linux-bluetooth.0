Return-Path: <cyrus@holtmann.org>
Message-ID: <555F25F8.4080408@linux.intel.com>
Date: Fri, 22 May 2015 14:50:00 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Arend van Spriel <arend@broadcom.com>,
 Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org, Ilya Faenson <ifaenson@broadcom.com>
Subject: Re: [PATCH v6 4/5] Bluetooth: hci_uart: Update Broadcom UART setup
References: <1432136770-13328-1-git-send-email-frederic.danis@linux.intel.com> <1432136770-13328-5-git-send-email-frederic.danis@linux.intel.com> <555DE2BE.8000109@broadcom.com>
In-Reply-To: <555DE2BE.8000109@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Arend,

On 21/05/2015 15:50, Arend van Spriel wrote:
> On 05/20/15 17:46, Frederic Danis wrote:
>> Use btbcm helpers to perform controller setup.
>> Perform host UART reset to init speed between btbcm_patchram() and
>> btbcm_finalize(). This may be need because firmware loading may have
>> reseted controller UART to init speed.
>>
>> Signed-off-by: Frederic Danis<frederic.danis@linux.intel.com>
>> ---
>>   drivers/bluetooth/hci_bcm.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index 1ec0b4a..cede445 100644
>> --- a/drivers/bluetooth/hci_bcm.c
>> +++ b/drivers/bluetooth/hci_bcm.c
>> @@ -79,11 +79,28 @@ static int bcm_flush(struct hci_uart *hu)
>>
>>   static int bcm_setup(struct hci_uart *hu)
>>   {
>> +    char fw_name[64];
>> +    int err;
>> +
>>       BT_DBG("hu %p", hu);
>>
>>       hu->hdev->set_bdaddr = btbcm_set_bdaddr;
>>
>> -    return btbcm_setup_patchram(hu->hdev);
>> +    err = btbcm_initialize(hu->hdev, fw_name, sizeof(fw_name));
>> +    if (err)
>> +        return err;
>> +
>> +    err = btbcm_patchram(hu->hdev, fw_name);
>> +    /* If there is no firmware (-ENOENT), discard the error and
>> continue */
>
> I guess -ENOENT means no firmware is required and not a
> request_firmware() failure. Not sure what is meant here.
>
> Regards,
> Arend
>
>> +    if (err == -ENOENT)
>> +        return 0;
>> +
>> +    if (hu->proto->init_speed)
>> +        hci_uart_set_baudrate(hu, hu->proto->init_speed);
>> +
>> +    err = btbcm_finalize(hu->hdev);
>> +
>> +    return err;
>>   }
>>
>>   static const struct h4_recv_pkt bcm_recv_pkts[] = {

You're right, btbcm_patchram() return test does not work as I expected.

I can change this by performing uart speed change only if it returns no 
error.

     err = btbcm_patchram(hu->hdev, fw_name);
     if (!err) {
	/* Firmware loading may have reseted controller UART to init speed */
         if (hu->proto->init_speed)
             hci_uart_set_baudrate(hu, hu->proto->init_speed);
     }

     err = btbcm_finalize(hu->hdev);


Or I can move request_firmware() out of btbcm_patchram() and test it 
before calling btbcm_patchram(). This will imply to change 
btbcm_patchram() to accept a firmware instead of firmware name.

     err = request_firmware(&fw, fw_name, &hu->hdev->dev);
     if (err < 0) {
         BT_INFO("%s: BCM: patch %s not found", hu->hdev->name, fw_name);
         return 0;
     }

     err = btbcm_patchram(hu->hdev, fw);
     if (!err) {
	/* Firmware loading may have reseted controller UART to init speed */
         if (hu->proto->init_speed)
             hci_uart_set_baudrate(hu, hu->proto->init_speed);
     }

     err = btbcm_finalize(hu->hdev);

Arend, Marcel, any advice regarding this ?

Regard

Fred
