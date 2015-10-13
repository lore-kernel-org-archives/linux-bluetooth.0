Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: randconfig build error with next-20151012, in drivers/bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+r1Zhjhu4LLHFtNK2=4bYO2tctd-QVt7ruWMCJMCQr85_2GMw@mail.gmail.com>
Date: Tue, 13 Oct 2015 09:18:00 +0200
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next <linux-next@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <98BA8F10-69E5-4933-B0F6-8988B1CB6C90@holtmann.org>
References: <CA+r1Zhjhu4LLHFtNK2=4bYO2tctd-QVt7ruWMCJMCQr85_2GMw@mail.gmail.com>
To: Jim Davis <jim.epost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jim,

> Building with the attached random configuration file,
> 
> warning: (BT_HCIBPA10X) selects BT_HCIUART which has unmet direct
> dependencies (NET && BT && TTY)
> 
> ERROR: "tty_unthrottle" [drivers/bluetooth/hci_uart.ko] undefined!
> ERROR: "tty_termios_encode_baud_rate" [drivers/bluetooth/hci_uart.ko] undefined!
> ERROR: "tty_unregister_ldisc" [drivers/bluetooth/hci_uart.ko] undefined!
> ERROR: "tty_ldisc_flush" [drivers/bluetooth/hci_uart.ko] undefined!
> ERROR: "n_tty_ioctl_helper" [drivers/bluetooth/hci_uart.ko] undefined!
> ERROR: "tty_driver_flush_buffer" [drivers/bluetooth/hci_uart.ko] undefined!
> ERROR: "tty_register_ldisc" [drivers/bluetooth/hci_uart.ko] undefined!
> ERROR: "tty_set_termios" [drivers/bluetooth/hci_uart.ko] undefined!

thanks for the report. We already fixed it in bluetooth-next and it should be with that in linux-next as well.

Regards

Marcel

