Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: warmreset breaks communication with CSR8811
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <c20e33c4-ff97-00de-9fb2-e70b0d3b983a@biertrinken.rocks>
Date: Tue, 22 May 2018 17:19:10 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <09F3DFD3-62AE-4DB8-BAC0-E124F55908E6@holtmann.org>
References: <c20e33c4-ff97-00de-9fb2-e70b0d3b983a@biertrinken.rocks>
To: tobi <tobi@biertrinken.rocks>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tobi,

> i have problem connecting bluez (currently im using 5.49 from debian:unstable and linux-4.14) to my CSR8811 (connected via 2 wire UART).
> hciattach works and i can use some bccmd commands but when i do a warmreset (to activate my pskey changes) bluez seems unable to get a valid
> reply from the chip :-(
> 
> here my commands:
> 
> root@BLOKS ~# hciattach -s 38400 /dev/ttyS1 bcsp 38400 noflow
> Device setup complete
> root@BLOKS ~# hciconfig
> hci0:    Type: Primary  Bus: UART
>     BD Address: 00:02:5B:00:A5:A5  ACL MTU: 310:10  SCO MTU: 64:8
>     UP RUNNING
>     RX bytes:1314 acl:0 sco:0 events:41 errors:0
>     TX bytes:2583 acl:0 sco:0 commands:40 errors:0
> 
> root@BLOKS ~# bccmd -t HCI buildname
> Build name: gem_5hci_rom_bt4.1_gemA12_1407301204_dspm_encr128 2014-07-30
> root@BLOKS ~# bccmd -t HCI psload -s 0 /data/8811.psr
> Loading PSKEY_BDADDR ... done
> Loading PSKEY_ANA_FREQ ... done
> root@BLOKS ~# bccmd -t HCI warmreset
> root@BLOKS ~# hciconfig
> hci0:    Type: Primary  Bus: UART
>     BD Address: 00:02:5B:00:A5:A5  ACL MTU: 310:10  SCO MTU: 64:8
>     UP RUNNING
>     RX bytes:1639 acl:0 sco:0 events:47 errors:0
>     TX bytes:3587 acl:0 sco:0 commands:76 errors:0
> 
> root@BLOKS ~# bccmd -t HCI buildname
> Can't read version info for hci0: Connection timed out (110)
> root@BLOKS ~# bccmd -t HCI psload -s 0 /data/8811.psr
> Can't read version info for hci0: Connection timed out (110)
> root@BLOKS ~#

I am not surprised this fails since hciattach and BCSP is not really working well when you have to restart the controller. Have you tried to use the bcsp transport of bccmd tool? And only when that finished run hciattach.

Otherwise the BCSP support really needs to be convert into something that would work with btattach. I have not seen many using BCSP these days. Most switched to 3-Wire UART instead.

Regards

Marcel

