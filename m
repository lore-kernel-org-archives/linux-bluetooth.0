Return-Path: <cyrus@holtmann.org>
Message-ID: <55804B8B.1030907@linux.intel.com>
Date: Tue, 16 Jun 2015 18:15:07 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Ilya Faenson <ifaenson@broadcom.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] BlueZ line discipline baud rate setting update
References: <1434387007-3666-1-git-send-email-ifaenson@broadcom.com> <1434387007-3666-2-git-send-email-ifaenson@broadcom.com> <5A718AB3-958E-415A-B60E-4BC4827DB583@holtmann.org> <557FE1C9.6020001@linux.intel.com> <F66F136D-CF57-471B-8E5B-1050F16DCE4E@holtmann.org>
In-Reply-To: <F66F136D-CF57-471B-8E5B-1050F16DCE4E@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 16/06/2015 16:36, Marcel Holtmann wrote:
> Hi Fred,
>
> >>> Bring the tty into a known 8 bits, 1 start bit, 1 stop bit,
> >>> hardware flow control state with a given baud rate.
> >>>
> >>> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> >>> ---
> >>> drivers/bluetooth/hci_ldisc.c | 9 ++++++++-
> >>> 1 file changed, 8 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/bluetooth/hci_ldisc.c 
> b/drivers/bluetooth/hci_ldisc.c
> >>> index ac87346..606cc5a 100644
> >>> --- a/drivers/bluetooth/hci_ldisc.c
> >>> +++ b/drivers/bluetooth/hci_ldisc.c
> >>> @@ -271,9 +271,16 @@ void hci_uart_set_baudrate(struct hci_uart 
> *hu, unsigned int speed)
> >>>     struct tty_struct *tty = hu->tty;
> >>>     struct ktermios ktermios;
> >>>
> >>> +    /* Bring the UART into a known state with a given baud rate */
> >>>     ktermios = tty->termios;
> >>>     ktermios.c_cflag &= ~CBAUD;
> >>> -    ktermios.c_cflag |= BOTHER;
> >>> +    ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR |
> >>> +                IGNCR | ICRNL | IXON);
> >>
> >> I think this one needs to align like this:
> >>
> >>             &= ~(IGNBRK | .. |
> >>                  IGNCR | ..);
> >>
> >> However I can fix that one easily inline. So no worries.
> >>
> >> Fred, can you test this patch so I can add a Tested-by line.
> >
> > OK, I will test it.
> >
> > Btw, I thought that this function should only change the UART speed.
> > For other UART parameters, I thought they should be set by btattach, 
> ACPI or DT part.
>
> do you think we want this split out into one hci_uart_reset_termios or 
> something and one that actually changes the baud rate. That seems fair 
> to me as well so then the individual vendor code can pick and choose 
> what they want to do.

Yes.
Imo, the question is to know who will be responsible to open the serial 
port and configure it:
- from user space using btattach or bluetoothd (as you wrote in a 
previous mail), may be based on uevent giving those info,
- or from kernel space, which will imply to have all info from ACPI or DT

Regards

Fred
