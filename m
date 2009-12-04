Return-Path: <cyrus@holtmann.org>
Message-ID: <4B18D58A.3070602@gdatech.co.in>
Date: Fri, 04 Dec 2009 14:55:30 +0530
From: Sankar Raj <s.shankarraj@gdatech.co.in>
MIME-Version: 1.0
To: venu <vjosyula@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: BT Issue - WiFi/BT combo module WM-BG-MR-03
References: <4B18CB27.1080506@gdatech.co.in> <53ea87da0912040103o7cf23785i94e76b6bfe55e69e@mail.gmail.com>
In-Reply-To: <53ea87da0912040103o7cf23785i94e76b6bfe55e69e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi Venu,
1 . When we issue command
#hciattach ttyS1 bcsp 115200
we are able to see the tx line toggling from the processor .

2. But when we issue command
#hciattach ttyS1 any
hci0 device is created.
But no toggling in tx line when we issue command "hciconfig hci0 up"

we dont have any debug interface.
-Regards,
Shankar
>
>
> Have seen what happening over the air, when this happens... I mean ask 
> from UART via HCI, is even reaching Link manager/baseband ?
>
> Do u have interface such JTAG to debug...
>
> Cheers,
> Venu
>
> On Fri, Dec 4, 2009 at 2:11 PM, Sankar Raj <s.shankarraj@gdatech.co.in 
> <mailto:s.shankarraj@gdatech.co.in>> wrote:
>
>     Hi all,
>     We are working with the WiFi/BT combo module WM-BG-MR-03 of USI
>     Technologies.
>
>     We have interfaced the Bluetooth module through UART to the OMAP3530
>     Processor and wifi through SDIO interface. Currently we are facing an
>     issue with the bluetooth interface.
>
>     The device is  not  responding for BCSP/CSR protocol of bluez utility
>     (hciattach). When
>     we probe the Serial line between the processor and the BT module, we
>     observed
>     signal toggling in the tx line. Hence we feel that the initialisation
>     sequence is issued by the processor, but the BT module is not
>     responding to that.
>
>     running the below commands.
>
>     #hciattach ttyS1 bcsp 115200
>
>     Gives output "Initialisation timed out"and we can see  toggling
>     data in tx
>     line
>
>
>     #hciattach ttyS1 any
>     output:dev0 is created and we couldnt see any  data in tx line when we
>     isssue the command hciconfig hci0 up.
>
>     "Please let me know have any one used this chip ?
>
>     has any one faced this problem?Please give ur suggestion.
>
>     Please also help us to debug.
>
>     regards
>     Shankar
>     --
>     To unsubscribe from this list: send the line "unsubscribe
>     linux-bluetooth" in
>     the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>
> -- 
> - J. Venumadhav


