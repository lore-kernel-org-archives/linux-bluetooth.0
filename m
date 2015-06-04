Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Arend Van Spriel <arend@broadcom.com>
Subject: RE: [PATCH 0/5] Broadcom Bluetooth UART device driver
Date: Thu, 4 Jun 2015 23:46:11 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E9425F11D@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com>
 <55707624.4070300@linux.intel.com>
In-Reply-To: <55707624.4070300@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

Appreciate you giving this code a try.

This code includes a platform device. It needs to be instantiated. My customer's platform is ARM so I configure a Device Tree binding to instantiate a device (see the first patch on how it should be done). The binding must have the compatible id that the driver lists. That binding should also have all the relevant device parameters including the tty it is configured on ("ttyS4" in your case). The tty is used to map the BlueZ protocol instance into the platform device instance. We would not need it if multiple BT UART devices were not to be supported. It is Marcel's requirement to support multiple devices however. Now, your platform may be ACPI so you would then need to instantiate a device on the ACPI device node. I don't have Linux running on the ACPI hardware at the moment so I've not tried adapting this code to ACPI. Would be great if you could help us with that. :-) You do know all the parameters for the device: I've specified them to you on a separate thread.

Looking forward to further progress!
 -Ilya

-----Original Message-----
From: Frederic Danis [mailto:frederic.danis@linux.intel.com] 
Sent: Thursday, June 04, 2015 12:01 PM
To: Ilya Faenson
Cc: Marcel Holtmann; linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/5] Broadcom Bluetooth UART device driver

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

