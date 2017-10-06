Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Correct context of IRQ polarity
 message
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2600bbf4-e5fb-312f-0e29-5b17746844b5@gmail.com>
Date: Fri, 6 Oct 2017 20:26:33 +0200
Cc: Ian W MORRISON <ianwmorrison@gmail.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "bluez mailin list (linux-bluetooth@vger.kernel.org)"
        <linux-bluetooth@vger.kernel.org>, hdegoede@redhat.com
Message-Id: <FDC710E6-4D82-487C-98AE-230DFD1F4032@holtmann.org>
References: <d9ad3bdc-2f94-b3b1-1ec1-786999c1e529@gmail.com>
 <2600bbf4-e5fb-312f-0e29-5b17746844b5@gmail.com>
To: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

>> As the overwriting of IRQ polarity to active low occurs during the driver
>> probe using 'bt_dev_warn' to display the warning results in '(null)'
>> being displayed for the device. This patch uses the underlying 'BT_INFO'
>> to directly display the warning instead.
>> 
>> Signed-off-by: ianwmorrison <ianwmorrison@gmail.com>
>> ---
>>  drivers/bluetooth/hci_bcm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index 77326eeb6146..17c036599407 100644
>> --- a/drivers/bluetooth/hci_bcm.c
>> +++ b/drivers/bluetooth/hci_bcm.c
>> @@ -839,7 +839,7 @@ static int bcm_acpi_probe(struct bcm_device *dev)
>>    	dmi_id = dmi_first_match(bcm_active_low_irq_dmi_table);
>>  	if (dmi_id) {
>> -		bt_dev_warn(dev, "%s: Overwriting IRQ polarity to active low",
>> +		BT_INFO("%s: Overwriting IRQ polarity to active low",
>>  			    dmi_id->ident);
>>  		dev->irq_active_low = true;
>>  	}
> 
> We can also set the device name before calling bcm_acpi_probe(), i.e. moving "dev->name = dev_name(dev->dev);" from bcm_get_resources() to bcm_probe() and bcm_serdev_probe().

frankly I have no idea on how this works at all. We are using bt_dev_warn on a bcm_device struct. It is meant to be used on a hci_dev struct. So by pure luck bcm_device->name actually exists.

This should have been a dev_warn(dev->dev, ..) call actually.

Regards

Marcel

