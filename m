Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH] hci_bcm.c: fix missing return value check of
 devm_clk_get()
To: Marcel Holtmann <marcel@holtmann.org>,
 Jiecheng Wu <jasonwood2031@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20180818020606.12052-1-jasonwood2031@gmail.com>
 <B67E0AC3-9761-4DF0-A382-AA5900C1577A@holtmann.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <0115b7d3-3c45-62dd-ffb4-33659e276335@redhat.com>
Date: Tue, 21 Aug 2018 16:49:13 +0200
MIME-Version: 1.0
In-Reply-To: <B67E0AC3-9761-4DF0-A382-AA5900C1577A@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 21-08-18 16:38, Marcel Holtmann wrote:
> Hi Jiecheng,
> 
>> Function bcm_get_resources() defined in drivers/bluetooth/hci_bcm.c calls devm_clk_get() that may return an error code. The return value of function bcm_get_resources() should be checked whether it is an error code.
>> ---
>> drivers/bluetooth/hci_bcm.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index ddbd8c6..f4089a2 100644
>> --- a/drivers/bluetooth/hci_bcm.c
>> +++ b/drivers/bluetooth/hci_bcm.c
>> @@ -906,6 +906,8 @@ static int bcm_get_resources(struct bcm_device *dev)
>> 		return 0;
>>
>> 	dev->clk = devm_clk_get(dev->dev, NULL);
>> +	if (IS_ERR(dev->clk))
>> +		return PTR_ERR(dev->clk);
> 
> is this really needed? I assume it all fails gracefully.

This is not necessary, this will actually break things on x86 since
we don't have a clk to get there, all future references
to dev->clk are protected like this:

         if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled) {

Notice the !IS_ERR(dev->clk), this is there exactly because
hci_bcm.c's use of the clk is optional, and this patch would break
that, so NACK.

Regards,

Hans
