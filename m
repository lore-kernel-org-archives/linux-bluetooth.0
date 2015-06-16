Return-Path: <cyrus@holtmann.org>
Message-ID: <55802603.9080501@linux.intel.com>
Date: Tue, 16 Jun 2015 15:34:59 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Ilya Faenson <ifaenson@broadcom.com>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] BlueZ line discipline baud rate setting update
References: <1434387007-3666-1-git-send-email-ifaenson@broadcom.com> <1434387007-3666-2-git-send-email-ifaenson@broadcom.com> <5A718AB3-958E-415A-B60E-4BC4827DB583@holtmann.org> <557FE1C9.6020001@linux.intel.com>
In-Reply-To: <557FE1C9.6020001@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 16/06/2015 10:43, Frederic Danis wrote:
> Hello Marcel and Ilya,
>
> On 15/06/2015 19:35, Marcel Holtmann wrote:
>> Hi Ilya,
>>
>>> Bring the tty into a known 8 bits, 1 start bit, 1 stop bit,
>>> hardware flow control state with a given baud rate.
>>>
>>> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
>>> ---
>>> drivers/bluetooth/hci_ldisc.c | 9 ++++++++-
>>> 1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/bluetooth/hci_ldisc.c 
>>> b/drivers/bluetooth/hci_ldisc.c
>>> index ac87346..606cc5a 100644
>>> --- a/drivers/bluetooth/hci_ldisc.c
>>> +++ b/drivers/bluetooth/hci_ldisc.c
>>> @@ -271,9 +271,16 @@ void hci_uart_set_baudrate(struct hci_uart *hu, 
>>> unsigned int speed)
>>>     struct tty_struct *tty = hu->tty;
>>>     struct ktermios ktermios;
>>>
>>> +    /* Bring the UART into a known state with a given baud rate */
>>>     ktermios = tty->termios;
>>>     ktermios.c_cflag &= ~CBAUD;
>>> -    ktermios.c_cflag |= BOTHER;
>>> +    ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR |
>>> +                IGNCR | ICRNL | IXON);
>>
>> I think this one needs to align like this:
>>
>>             &= ~(IGNBRK | .. |
>>                  IGNCR | ..);
>>
>> However I can fix that one easily inline. So no worries.
>>
>> Fred, can you test this patch so I can add a Tested-by line.
>
> OK, I will test it.

Device setup works correctly.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation
