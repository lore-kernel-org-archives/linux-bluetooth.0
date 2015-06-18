Return-Path: <cyrus@holtmann.org>
Message-ID: <5582935B.1030100@linux.intel.com>
Date: Thu, 18 Jun 2015 11:46:03 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Ilya Faenson <ifaenson@broadcom.com>,
 Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>,
 Arend Van Spriel <arend@broadcom.com>
Subject: Re: [PATCH v4 2/4] hci_uart: line discipline enhancements
References: <1434576658-20730-1-git-send-email-ifaenson@broadcom.com> <1434576658-20730-3-git-send-email-ifaenson@broadcom.com> <EC2420F4-9F0F-47DB-A5E5-713E763E3E26@holtmann.org> <E0D3336E15B58B4294723AC879BA5E94263438@IRVEXCHMB15.corp.ad.broadcom.com>
In-Reply-To: <E0D3336E15B58B4294723AC879BA5E94263438@IRVEXCHMB15.corp.ad.broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel and Ilya,

On 17/06/2015 23:53, Ilya Faenson wrote:
> Thanks a lot, Marcel.
>
> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Wednesday, June 17, 2015 5:51 PM
> To: Ilya Faenson
> Cc: BlueZ development; Arend Van Spriel
> Subject: Re: [PATCH v4 2/4] hci_uart: line discipline enhancements
>
> Hi Ilya,

<snip>
>> @@ -287,15 +366,28 @@ static int hci_uart_setup(struct hci_dev *hdev)
>> 	struct hci_uart *hu = hci_get_drvdata(hdev);
>> 	struct hci_rp_read_local_version *ver;
>> 	struct sk_buff *skb;
>> +	unsigned int speed;
>> 	int err;
>>
>> +	/* Init speed if any */
>> +	speed = 0;
>> 	if (hu->proto->init_speed)
>> -		hci_uart_set_baudrate(hu, hu->proto->init_speed);
>> -
>> -	if (hu->proto->set_baudrate && hu->proto->oper_speed) {
>> -		err = hu->proto->set_baudrate(hu, hu->proto->oper_speed);
>> +		speed = hu->proto->init_speed;
>> +	else if (hu->init_speed)
>> +		speed = hu->init_speed;
>
> I added the speed assignment as else statement
>
> 	else
> 		speed = 0;

Afaiu, with this change hu->proto->*speed will always be used for all 
bcm device.
I think hu->*speed should be used if exist or hu->proto->*speed, so the 
test should be swapped.

The equivalent change is needed in bcm_setup() of hci_bcm.c.

Ilya, do you want to do it or should I send a patch ?

Regards

Fred
