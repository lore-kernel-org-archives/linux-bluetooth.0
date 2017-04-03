Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC V1 00/16] hci_ldisc hci_uart_tty_close() fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <ee49f939-1094-0ae0-0fa7-6c5cad112527@mentor.com>
Date: Mon, 3 Apr 2017 17:51:59 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <119BB9FC-C735-405B-9A77-E9F102393B7D@holtmann.org>
References: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
 <AA3DD0DD-5CAC-4ADD-9B0C-4E652C93E4D6@holtmann.org>
 <ee49f939-1094-0ae0-0fa7-6c5cad112527@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

>>> This is RFC patchset V1 which reorganises hci_uart_tty_close() to overcome a
>>> design flaw. I would like some comments on the changes.
>>> 
>>> Design Flaw
>>> ===========
>>> 
>>> An example callstack is as follows
>>> 
>>> Have Bluetooth running using a BCSP based UART Bluetooth Radio Module.
>>> 
>>> Now kill the userland hciattach program by doing
>>> killall hciattach
>> is there any chance we can convert BCSP support to run fully inside the kernel with the new parts we have put in. And with that then also use btattach. The split of some parts of BCSP in userspace seems never been a good idea.
> 
> I am not aware of "the new parts we [you] have put in" to the kernel because I am working with the older 3.14 kernel with userland components that are not Bluez based but the kernel issue is observable. Is there a web page where I can find out about your design changes for the new parts ?
> 
> My efforts are to improve the latest upstream kernel to eliminate this kernel design flaw in HCI UART LDISC (Note TTY LDISC is also broken but not fixed by my patchset).
> 
> I see that "btattach" is at https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/btattach.c, however, I am unable to identify whether Linux distributions such as Ubuntu have a bluez package that contains "btattach". Is "btattach" a replacement for "hciattach” ?

yes, we want to move towards btattach that just assigned the line discipline and selects the UART protocol. Everything else including firmware download, speed changes, recover etc. should be done inside the kernel.

And later with serdev, we would not even need btattach anymore. UART based Bluetooth devices would be enumerated via DT and the TTY not even exposed to userspace. We are slowly getting to that point.

The latest kernel has UART drivers like hci_intel.c and hci_bcm.c which do a lot of things in the kernel. And btattach is just the process that keeps the line discipline open.

>> I am a bit reluctant to change major hci_ldisc pieces because of just one broken protocol. Running BCSP fully in the kernel seems a better solution to deal with some of these issues.
> 
> The kernel BCSP software in the kernel is not broken although it is not fully implemented as you already highlighted. The issue is that HCI UART LDISC (and TTY LDISC) has a broken procedure for closing down the HCI UART device via hci_uart_tty_close().
> 
> This means that I don't see how your suggestion helps to resolve the kernel design flaw which is related to closing down any of the Bluetooth Data Link protocol layers such as H4, H5, and BCSP (I use BCSP). This flaw seems to me to be a long standing Bluetooth kernel Data Link protocol layer closedown issue and is unrelated to how the Data Link protocol layer is established (connected). Therefore, having BCSP partly in userland is irrelevant to this kernel design flaw. Even with BCSP fully in the kernel, the protocol closedown issue will remain present I think.

If you think there are issues, then lets fix them for all protocols. I assumed this was BCSP specific.

> I might try to build "btattach" and have a go to use it. If you look inside the source code of "btattach" and "hciattach" you can see the problem area in closing down an established Bluetooth Data Link protocol layer by the use of:
> 
>    if (ioctl(fd, TIOCSETD, &ldisc) < 0) {
>        perror("Failed set serial line discipline");
>        close(fd);
>        return -1;
>    }
> 
> This userland call is the problem area as this asynchronous ioctl TIOCSETD can cause hci_uart_tty_close() to run and I think it can cause trouble for ALL the Bluetooth Data Link protocol layers such as H4, H5 and BCSP.
> 
> The design flaw is exposed after the Data Link protocol layer has been established (connected) and ioctl TIOCSETD is used from userland. In my example, I killed "hciattach" which is an abnormal scenario but it still needs good handling. I think I have strace evidence of TIOCSETD being used due to SIGTERM.
> 
> The design flaw is because TIOCSETD can trigger the sending of a HCI RESET command during closedown of HCI UART LDISC, TTY LDISC and the Data Link protocol layer. I only have experience of BCSP but I suspect H4 and H5 have retransmission procedures similar to BCSP so would also be susceptible to this issue of trying to send a HCI RESET command whilst closing down the needed data path to the UART driver which causes sending of the HCI RESET command to be unsuccessful.
> 
> I think the callstack is:
> 
> Userland ioctl TIOCSETD executes causing =>
> Kernel ioctl system call which runs
> tty_ioctl()
> tiocsetd()
> tty_set_ldisc()
> tty_ldisc_close()
> hci_uart_tty_close()
> hci_unregister_dev()
> hci_dev_do_close()
> __hci_req_sync() which tries to send a HCI RESET command which depends on
> HCI_QUIRK_RESET_ON_CLOSE being enabled and that is the default condition
> 
> I believe It will affect the closure of any of the Bluetooth Data Link protocol layers.
> 
> Note that not enabling HCI_QUIRK_RESET_ON_CLOSE does not fully help because if Data Link protocol layer retransmissions are occurring when hci_uart_tty_close() runs then the various race conditions are still present in hci_uart_tty_close().
> 
> I suspect evidence of the design flaw can be observed by measuring the execution time of the userland ioctl TIOCSETD calls. I predict that sometimes it will take 2 seconds for TIOCSETD to complete due to being blocked waiting for the unsuccessful attempt at sending the HCI RESET command because the HCI command time-out expires. I believe this will be independent of the underlying Bluetooth Data Link protocol layer.
> 
> Do you have any suggestions for moving forward in accepting my proposed changes ? I will try to provide more observable evidence of the issue on kernel v.4.10 on a Linux PC.

If this is an issue in 4.10, then lets get this fixed / hardened.

Regards

Marcel

