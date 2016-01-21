Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [BUG] Btattach, ioctl fails to set flags from 32-bit user space to 64-bit
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAA+NYvTV6WybKuO71Gehm6L2-vjsqVhmu5VjEQCfqFaWi1TU6Q@mail.gmail.com>
Date: Thu, 21 Jan 2016 12:12:46 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C72941BE-7F8A-4CD7-900E-5E8E6E42FD63@holtmann.org>
References: <CAA+NYvTV6WybKuO71Gehm6L2-vjsqVhmu5VjEQCfqFaWi1TU6Q@mail.gmail.com>
To: Jaap Jan Meijer <jjmeijer88@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaap,

> WIth Btattach, ioctl fails to set flags from 32-bit user space to 64-bit
> kernel. ioctl fails with ENOTTY.
> 
> static int attach_proto(const char *path, unsigned int proto,
> unsigned int flags)
> {
> int fd, dev_id;
> 
> fd = open_serial(path);
> if (fd < 0)
> return -1;
> 
> if (ioctl(fd, HCIUARTSETFLAGS, flags) < 0) {
> perror("Failed to set flags");
> close(fd);
> return -1;
> }
> .....

I am a little bit lost on how you get ENOTTY. The only way I can see this happening if the kernel falls through towards n_tty_ioctl_helper and that means that cmd is messed up.

If you go into drivers/bluetooth/hci_ldisc.c and add this line

	hci_uart_ldisc.compat_ioctl = hci_uart_tty_ioctl;

it might fix it. It is a guess right now until you figure out where the ENOTTY is coming from.

Regards

Marcel

