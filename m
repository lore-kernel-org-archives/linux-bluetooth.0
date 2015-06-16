Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Frederic Danis <frederic.danis@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] BlueZ line discipline baud rate setting update
Date: Tue, 16 Jun 2015 12:19:49 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E942627D7@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1434387007-3666-1-git-send-email-ifaenson@broadcom.com>
 <1434387007-3666-2-git-send-email-ifaenson@broadcom.com>
 <5A718AB3-958E-415A-B60E-4BC4827DB583@holtmann.org>,<557FE1C9.6020001@linux.intel.com>
In-Reply-To: <557FE1C9.6020001@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

________________________________________
From: Frederic Danis [frederic.danis@linux.intel.com]
Sent: Tuesday, June 16, 2015 4:43 AM
To: Marcel Holtmann; Ilya Faenson
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] BlueZ line discipline baud rate setting update

Hello Marcel and Ilya,

On 15/06/2015 19:35, Marcel Holtmann wrote:
> Hi Ilya,
>
>> Bring the tty into a known 8 bits, 1 start bit, 1 stop bit,
>> hardware flow control state with a given baud rate.
>>
>> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
>> ---
>> drivers/bluetooth/hci_ldisc.c | 9 ++++++++-
>> 1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>> index ac87346..606cc5a 100644
>> --- a/drivers/bluetooth/hci_ldisc.c
>> +++ b/drivers/bluetooth/hci_ldisc.c
>> @@ -271,9 +271,16 @@ void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
>>      struct tty_struct *tty = hu->tty;
>>      struct ktermios ktermios;
>>
>> +    /* Bring the UART into a known state with a given baud rate */
>>      ktermios = tty->termios;
>>      ktermios.c_cflag &= ~CBAUD;
>> -    ktermios.c_cflag |= BOTHER;
>> +    ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR |
>> +                        IGNCR | ICRNL | IXON);
>
> I think this one needs to align like this:
>
>                       &= ~(IGNBRK | .. |
>                            IGNCR | ..);
>
> However I can fix that one easily inline. So no worries.
>
> Fred, can you test this patch so I can add a Tested-by line.

OK, I will test it.

Btw, I thought that this function should only change the UART speed.
For other UART parameters, I thought they should be set by btattach,
ACPI or DT part.

IF: UART parameters should be fully configured in kernel space in my opinion. I don't set any UART parameters from user space in my testing. As far as the DT/ACPI are concerned, none of the current ACPI DSL BT nodes configure UART parameters yet. I've introduced the oper-speed parameter for DT and that's the only UART parameter there for now. If we decide to add more, we'll have to change the line discipline configuration accordingly. Not sure it is needed though as all the BT UART-connected devices I've ever worked with in the last 10 years or so (including test devices connected via the FTDI-based USB boards) always worked fine with 8 bits, 1 start bit, 1 stop bit, no parity, hardware flow control.

Regards

Fred