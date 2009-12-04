Return-Path: <cyrus@holtmann.org>
Message-ID: <4B18CB27.1080506@gdatech.co.in>
Date: Fri, 04 Dec 2009 14:11:11 +0530
From: Sankar Raj <s.shankarraj@gdatech.co.in>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: BT Issue - WiFi/BT combo module WM-BG-MR-03
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,
We are working with the WiFi/BT combo module WM-BG-MR-03 of USI
Technologies.

We have interfaced the Bluetooth module through UART to the OMAP3530
Processor and wifi through SDIO interface. Currently we are facing an
issue with the bluetooth interface.

The device is  not  responding for BCSP/CSR protocol of bluez utility
(hciattach). When
we probe the Serial line between the processor and the BT module, we
observed
signal toggling in the tx line. Hence we feel that the initialisation
sequence is issued by the processor, but the BT module is not
responding to that.

running the below commands.

#hciattach ttyS1 bcsp 115200

Gives output "Initialisation timed out"and we can see  toggling data in tx
line


#hciattach ttyS1 any
output:dev0 is created and we couldnt see any  data in tx line when we
isssue the command hciconfig hci0 up.

"Please let me know have any one used this chip ?

has any one faced this problem?Please give ur suggestion.

Please also help us to debug.

regards
Shankar
