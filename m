Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4C2644C5-D946-4CB6-AEF5-3948DC241BA6@holtmann.org>
References: <1380427749-14427-1-git-send-email-marcel@holtmann.org>
	<CAJdJm_Ova_rzJy8pnO2VJRki7N=L=PEk=r=D5Zk1oPDkA=2mOA@mail.gmail.com>
	<4C2644C5-D946-4CB6-AEF5-3948DC241BA6@holtmann.org>
Date: Mon, 30 Sep 2013 07:31:25 -0400
Message-ID: <CAJdJm_N=sFA8Zz3XBcY2wnp9h4u2k1gWRaU=+cH023pTSdNkhg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Use only 2 bits for controller type information
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Sep 30, 2013 at 12:01 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>>> -       di.type     = (hdev->bus & 0x0f) | (hdev->dev_type << 4);
>>> +       di.type     = (hdev->bus & 0x0f) | ((hdev->dev_type & 0x30) << 4);
>>
>> Shouldn't it be (hdev->dev_type & 0x03) here?
>
> yes, this it should be 0x03 here. My mistake.

Just a reminder that userspace needs fixing as well.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
