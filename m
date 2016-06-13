Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <575A749A.1090409@intel.com>
References: <CAPcThSGPMaqJ9zr5fPWM38YH+2DE5M7a5oBNM4pUa3g1Xdba1w@mail.gmail.com>
 <575A749A.1090409@intel.com>
From: Qingtao Cao <qingtao.cao.au@gmail.com>
Date: Mon, 13 Jun 2016 14:53:40 +1000
Message-ID: <CAPcThSGtgY=KyAvgtMd2HPTin7uKqNXbTc-4-9ME4ZYGutK1Lg@mail.gmail.com>
Subject: Re: How to initialise bcm4354A2 with 3.10 kernel?
To: lpoulain <loic.poulain@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

Many thanks for your suggestion!

I hadn't used hciattach on BCM4354A2 hardware before, so I tried it
out today and found that it couldn't yield better result than
brcm_patchram_plus program. As a matter of fact, after the firmware
patchfile is downloaded the HCI_Reset command needs very likely to be
re-sent again otherwise it simply blocks on reading relevant HCI_Event
packet until times out in the default 10 seconds. Once I resent this
command by capturing the SIGALRM in 4 seconds, the hci0 can be
enabled.

However, I still found logs that an extra 0x00 byte was skipped over
(by my workaround patch) for some HCI_Event packet (otherwise lots of
HCI commands would time out because this extra 0x00 byte would fail
hci_reassembly()) and start discovery also failed by 0x0C error code
(command disallowed).

I am using hciattach bcm43xx in the way of:

  { "bcm43xx",    0x0000, 0x0000, HCI_UART_H4,   115200, 4000000,
              FLOW_CTL, DISABLE_PM, "40:40:a7:a6:a5:c1", bcm43xx, NULL },


/ # ./hciattach -n /dev/ttyHS0 bcm43xx
bcm43xx_init
Set Controller clock (1)
Set Controller UART speed to 4000000 bit/s
Flashed firmware /etc/firmware/BCM4354A2.hcd
Not received hci event for reset command, reset again   (printed by
SIGALRM handler to send hci reset command in 4 sec)
Set BDADDR UART: 40:40:a7:a6:a5:c1
Set Controller clock (1)
Set Controller UART speed to 4000000 bit/s
Device setup complete

Cheers,
Harry

On Fri, Jun 10, 2016 at 6:04 PM, lpoulain <loic.poulain@intel.com> wrote:
> Hi Harry,
>
>> Dear community,
>> r
>> I am trying to use the brcm_patchram_plus program to initialise
>> broadcom bcm4354A2 on my target with 3.10 Linux kernel. Currently the
>> hci0 can be found UP, however, it doesn't seem to function properly.
>
>
> Did you try to init the chip with hciattach (bcm43xx) ?
> If yes, do you reproduce the same issue ?
>
> Regards,
> Loic
