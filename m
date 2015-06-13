Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Arend Van Spriel" <arend@broadcom.com>
Subject: RE: [PATCH v2 3/5] Broadcom Bluetooth UART Platform Driver
Date: Sat, 13 Jun 2015 14:12:30 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E94261E91@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com>
 <1433966720-17482-4-git-send-email-ifaenson@broadcom.com>
 <187EFB2B-BD56-46BB-A022-6507A8F8AE66@holtmann.org>
 <E0D3336E15B58B4294723AC879BA5E942615DC@IRVEXCHMB15.corp.ad.broadcom.com>
 <AAF7B29B-7BE0-49D9-BA84-4DA4DBC3E784@holtmann.org>
In-Reply-To: <AAF7B29B-7BE0-49D9-BA84-4DA4DBC3E784@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@v=
ger.kernel.org] On Behalf Of Marcel Holtmann
Sent: Saturday, June 13, 2015 4:04 AM
To: Ilya Faenson
Cc: linux-bluetooth@vger.kernel.org; Arend Van Spriel
Subject: Re: [PATCH v2 3/5] Broadcom Bluetooth UART Platform Driver

Hi Ilya,

>> Introduce the device tree enumerated Broadcom Bluetooth UART driver.
>>=20
>> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
>> ---
>> drivers/bluetooth/Kconfig      |   9 +
>> drivers/bluetooth/Makefile     |   1 +
>> drivers/bluetooth/btbcm_uart.c | 673 +++++++++++++++++++++++++++++++++++=
++++++
>> drivers/bluetooth/btbcm_uart.h |  89 ++++++
>> 4 files changed, 772 insertions(+)
>> create mode 100644 drivers/bluetooth/btbcm_uart.c
>> create mode 100644 drivers/bluetooth/btbcm_uart.h
>>=20
>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>> index 2e77707..5eee3ed 100644
>> --- a/drivers/bluetooth/Kconfig
>> +++ b/drivers/bluetooth/Kconfig
>> @@ -143,6 +143,7 @@ config BT_HCIUART_BCM
>> 	bool "Broadcom protocol support"
>> 	depends on BT_HCIUART
>> 	select BT_HCIUART_H4
>> +	select BT_UART_BCM
>> 	select BT_BCM
>> 	help
>> 	  The Broadcom protocol support enables Bluetooth HCI over serial
>> @@ -150,6 +151,14 @@ config BT_HCIUART_BCM
>>=20
>> 	  Say Y here to compile support for Broadcom protocol.
>>=20
>> +config BT_UART_BCM
>=20
> if we follow our new naming that we have pushed since a few years now for=
 new modules, then this should be BT_BCM_UART actually.
>=20
> IF: Okay, will change.
>=20
>> +	tristate "Broadcom BT UART driver"
>> +	depends on BT_HCIUART_H4 && TTY
>=20
> So I am thinking that we do not even make this an user visible option. Th=
is should be just automatically selected from BT_HCIUART_BCM and that is it=
.
>=20
> Meaning this is will be enough in the end:
>=20
> 	config BT_BCM_UART
> 		tristate
>=20
> And I would just put it directly under the BT_BCM entry we already have.
>=20
> IF: As per today's Loic's comment, the platform driver should be optional=
. I agree. I think it should be configured separately as well.

I am fine with that in the long run. However to not over-engineer it from t=
he start, lets do it simple with not exposing the menu item for selection. =
We can always change that later and give the option. I prefer that we get t=
hings merged and then go on refining them. Turning this back into a user se=
lectable option is pretty easy.

If we go this way, then for me I do not have to think about it too much at =
the moment. Even the side where the Broadcom device is exposed via ACPI wil=
l need something and that something is still not there. And I am also expec=
ting that UART slaves will come around eventually and we have to start thin=
king about some details as well.

IF: Okay, I will remove the separate platform device configuration.

>> +	help
>> +	  This driver supports the HCI_UART_BT protocol.
>> +
>> +	  It manages Bluetooth UART device properties and GPIOs.
>> +
>=20
> This is something we have to figure out from a design point of view. Do w=
e want to keep this as a separate module or not. My initial thinking here i=
s that the platform driver should be just registered from bcm_init in hci_b=
cm.c.
>=20
> I mean wouldn't it be a lot simpler if we can match up the BT HCI UART bc=
m_proto driver to the platform driver? I have no objection to make this a s=
eparate module, but I want to make sure that we looked at these two options=
.
>=20
> If we ever get to UART slave drivers, then this would be essentially the =
UART slave driver, correct?
>=20
> IF: The platform and ACPI (in the future) are logically separate drivers.=
 I would not want to see them both within a BlueZ protocol. Sharing a modul=
e will not make mapping a protocol instance into a driver instance any easi=
er. They would still need to exchange the identifying info. They are logica=
lly two completely different entities in my opinion. UART slave driver, to =
the best of my limited current understanding, will just introduce one more =
layer into the already fairly complicated picture. The platform and ACPI dr=
ivers may still be needed to manage GPIOs and wakeup interrupts. Also, Blue=
Z protocol resides above the tty line discipline while UART slave is below =
so having them in a single module would be very confusing in my opinion.

We could do it as a compile time option where either one or both are compil=
ed into the driver. That is how hci_uart driver actually does it today. So =
there are many options in this area. Lets keep them separated for now. I ha=
ve no problem with that. We are not set in stone here anyway. This can easi=
ly change later.

IF: Understood, thanks.

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
