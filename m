Return-Path: <cyrus@holtmann.org>
Message-ID: <55707624.4070300@linux.intel.com>
Date: Thu, 04 Jun 2015 18:00:36 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Ilya Faenson <ifaenson@broadcom.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/5] Broadcom Bluetooth UART device driver
References: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Ilya,

On 03/06/2015 23:01, Ilya Faenson wrote:
> This is a merge of the Broadcom Bluetooth UART logic with
> the latest line discipline and protocol enhancements implemented
> by Frederic Danis of Intel.
>
> Ilya Faenson (5):
>    Broadcom Bluetooth UART Device Tree bindings
>    Intel based H4 line discipline enhancements
>    Broadcom Bluetooth UART Platform Driver
>    Broadcom Bluetooth protocol UART support
>    BlueZ Broadcom UART Protocol
>
>   .../devicetree/bindings/net/bluetooth/btbcm.txt    |  82 +++
>   drivers/bluetooth/Kconfig                          |   9 +
>   drivers/bluetooth/Makefile                         |   1 +
>   drivers/bluetooth/btbcm.c                          | 142 ++++-
>   drivers/bluetooth/btbcm.h                          |  21 +-
>   drivers/bluetooth/btbcm_uart.c                     | 673 +++++++++++++++++++++
>   drivers/bluetooth/btbcm_uart.h                     |  89 +++
>   drivers/bluetooth/hci_bcm.c                        | 481 ++++++++++++++-
>   drivers/bluetooth/hci_ldisc.c                      | 110 +++-
>   drivers/bluetooth/hci_uart.h                       |   6 +
>   10 files changed, 1565 insertions(+), 49 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
>   create mode 100755 drivers/bluetooth/btbcm_uart.c
>   create mode 100755 drivers/bluetooth/btbcm_uart.h
>

I applied your patches on top of mines and test them on a T100, it did 
not work as expected with following traces:

Jun  4 17:41:43 fdanis-T100TA kernel: [  125.409680] Bluetooth: HCI UART 
driver ver 2.3
Jun  4 17:41:43 fdanis-T100TA kernel: [  125.409688] Bluetooth: HCI UART 
protocol H4 registered
Jun  4 17:41:43 fdanis-T100TA kernel: [  125.409691] Bluetooth: HCI UART 
protocol BCSP registered
Jun  4 17:41:43 fdanis-T100TA kernel: [  125.409693] Bluetooth: HCI UART 
protocol LL registered
Jun  4 17:41:43 fdanis-T100TA kernel: [  125.409696] Bluetooth: HCI UART 
protocol ATH3K registered
Jun  4 17:41:43 fdanis-T100TA kernel: [  125.409698] Bluetooth: HCI UART 
protocol Three-wire (H5) registered
Jun  4 17:41:43 fdanis-T100TA kernel: [  125.409701] Bluetooth: HCI UART 
protocol BCM registered
Jun  4 17:42:00 fdanis-T100TA kernel: [  142.130205] NET: Registered 
protocol family 38
Jun  4 17:43:21 fdanis-T100TA kernel: [  223.397482] hci_uart_tty_open: 
tty ffff880074900000
Jun  4 17:43:21 fdanis-T100TA kernel: [  223.397551] hci_uart_tty_ioctl:
Jun  4 17:43:21 fdanis-T100TA kernel: [  223.397556] hci_uart_tty_ioctl:
Jun  4 17:43:21 fdanis-T100TA kernel: [  223.397560] bcm_open: bcm_open 
hu ffff880036683d80
Jun  4 17:43:21 fdanis-T100TA kernel: [  223.397567] btbcm_uart_control: 
btbcm_uart_control - configure callbacks
Jun  4 17:43:21 fdanis-T100TA kernel: [  223.397572] btbcm_uart_control: 
btbcm_uart_control - configure callbacks for ttyS4(ffff880036683d80)
Jun  4 17:43:21 fdanis-T100TA kernel: [  223.397575] btbcm_uart_control: 
btbcm_uart_control - no device!
Jun  4 17:43:21 fdanis-T100TA kernel: [  223.397579] bcm_open: bcm_open 
failed to set driver callbacks -2
Jun  4 17:43:21 fdanis-T100TA kernel: [  223.397801] hci_uart_tty_close: 
tty ffff880074900000

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation
