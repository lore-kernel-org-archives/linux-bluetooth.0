Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v6 4/5] Bluetooth: hci_uart: Update Broadcom UART setup
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <E0D3336E15B58B4294723AC879BA5E9425ADE4@IRVEXCHMB15.corp.ad.broadcom.com>
Date: Sat, 6 Jun 2015 08:18:15 +0200
Cc: Frederic Danis <frederic.danis@linux.intel.com>,
	Arend Van Spriel <arend@broadcom.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <D5EDC898-B451-4978-A13A-7BEBC9D093EB@holtmann.org>
References: <1432136770-13328-1-git-send-email-frederic.danis@linux.intel.com> <1432136770-13328-5-git-send-email-frederic.danis@linux.intel.com> <555DE2BE.8000109@broadcom.com> <555F25F8.4080408@linux.intel.com> <555F2EB5.1080103@broadcom.com> <555F33E8.8010703@linux.intel.com> <E0D3336E15B58B4294723AC879BA5E9425A61F@IRVEXCHMB15.corp.ad.broadcom.com> <55646A17.10501@linux.intel.com> <E0D3336E15B58B4294723AC879BA5E9425ADE4@IRVEXCHMB15.corp.ad.broadcom.com>
To: Ilya Faenson <ifaenson@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,

>>>>>> Use btbcm helpers to perform controller setup.
>>>>>> Perform host UART reset to init speed between btbcm_patchram() and
>>>>>> btbcm_finalize(). This may be need because firmware loading may have
>>>>>> reseted controller UART to init speed.
>>>>>> 
>>>>>> Signed-off-by: Frederic Danis<frederic.danis@linux.intel.com>
>>>>>> ---
>>>>>> drivers/bluetooth/hci_bcm.c | 19 ++++++++++++++++++-
>>>>>> 1 file changed, 18 insertions(+), 1 deletion(-)
>>>>>> 
>>>>>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>>>>>> index 1ec0b4a..cede445 100644
>>>>>> --- a/drivers/bluetooth/hci_bcm.c
>>>>>> +++ b/drivers/bluetooth/hci_bcm.c
>>>>>> @@ -79,11 +79,28 @@ static int bcm_flush(struct hci_uart *hu)
>>>>>> 
>>>>>> static int bcm_setup(struct hci_uart *hu)
>>>>>> {
>>>>>> + char fw_name[64];
>>>>>> + int err;
>>>>>> +
>>>>>> BT_DBG("hu %p", hu);
>>>>>> 
>>>>>> hu->hdev->set_bdaddr = btbcm_set_bdaddr;
>>>>>> 
>>>>>> - return btbcm_setup_patchram(hu->hdev);
>>>>>> + err = btbcm_initialize(hu->hdev, fw_name, sizeof(fw_name));
>>>>>> + if (err)
>>>>>> + return err;
>>>>>> +
>>>>>> + err = btbcm_patchram(hu->hdev, fw_name);
>>>>>> + /* If there is no firmware (-ENOENT), discard the error and
>>>>>> continue */
>>>>> 
>>>>> I guess -ENOENT means no firmware is required and not a
>>>>> request_firmware() failure. Not sure what is meant here.
>>>>> 
>>>>> Regards,
>>>>> Arend
>>>>> 
>>>>>> + if (err == -ENOENT)
>>>>>> + return 0;
>>>>>> +
>>>>>> + if (hu->proto->init_speed)
>>>>>> + hci_uart_set_baudrate(hu, hu->proto->init_speed);
>>>>>> +
>>>>>> + err = btbcm_finalize(hu->hdev);
>>>>>> +
>>>>>> + return err;
>>>>>> }
>>>>>> 
>>>>>> static const struct h4_recv_pkt bcm_recv_pkts[] = {
>>>> 
>>>> You're right, btbcm_patchram() return test does not work as I expected.
>>>> 
>>>> I can change this by performing uart speed change only if it returns no
>>>> error.
>>>> 
>>>> err = btbcm_patchram(hu->hdev, fw_name);
>>>> if (!err) {
>>>> /* Firmware loading may have reseted controller UART to init speed */
>>>> if (hu->proto->init_speed)
>>>> hci_uart_set_baudrate(hu, hu->proto->init_speed);
>>>> }
>>>> 
>>>> err = btbcm_finalize(hu->hdev);
>>>> 
>>>> 
>>>> Or I can move request_firmware() out of btbcm_patchram() and test it
>>>> before calling btbcm_patchram(). This will imply to change
>>>> btbcm_patchram() to accept a firmware instead of firmware name.
>>>> 
>>>> err = request_firmware(&fw, fw_name, &hu->hdev->dev);
>>>> if (err < 0) {
>>>> BT_INFO("%s: BCM: patch %s not found", hu->hdev->name, fw_name);
>>>> return 0;
>>>> }
>>>> 
>>>> err = btbcm_patchram(hu->hdev, fw);
>>>> if (!err) {
>>>> /* Firmware loading may have reseted controller UART to init speed */
>>>> if (hu->proto->init_speed)
>>>> hci_uart_set_baudrate(hu, hu->proto->init_speed);
>>>> }
>>>> 
>>>> err = btbcm_finalize(hu->hdev);
>>>> 
>>>> Arend, Marcel, any advice regarding this ?
>>> 
>>> Well, functionally it does not make a difference as the request_firmware
>>> is the first call done in btbcm_patchram(). So if it solves your problem
>>> I would go for option 2. Other question: is there a reason why the error
>>> code from request_firmware is not returned?
>> 
>> If an error is returned it will stop Bluetooth setup.
>> So, when request_firmware() returns an error, the Bluetooth controller
>> will be used with current firmware and 0 is returned as bcm_setup is
>> completed.
>> 
>> IF: There is generally no "current firmware" if the firmware download fails or not attempted. The device would run out of the ROM then which is not terribly useful if Bluetooth functionality is needed. Thanks, -Ilya
> 
> The BCM4324B3 embedded in T100 is able to operate without firmware 
> loading, at least performing Bluetooth discovery.
> I think it is better to run without firmware loading than not allowing 
> to use Bluetooth controller at all.
> 
> IF: Broadcom software elsewhere generally fails device start in this case as every Bluetooth feature may or may not work afterwards, with no guarantees whatsoever. The decision here is obviously up to BlueZ maintainers.

I am fine with actually doing exactly that once we have a bit better infrastructure in place. However this also requires a commitment from Broadcom to actually publish the firmware files in linux-firmware tree and maintain the manifest document I have been talking about.

Regards

Marcel

