Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v4 2/2] Bluetooth: btmrvl add firmware dump support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1416825653-32530-2-git-send-email-akarwar@marvell.com>
Date: Wed, 3 Dec 2014 16:37:36 +0000
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Xinming Hu <huxm@marvell.com>, Cathy Luo <cluo@marvell.com>,
	Avinash Patil <patila@marvell.com>
Message-Id: <58436E3C-356C-4BE3-B99B-7AB42999E9DF@holtmann.org>
References: <1416825653-32530-1-git-send-email-akarwar@marvell.com> <1416825653-32530-2-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> This patch adds firmware dump support for marvell
> bluetooth chipset. Currently only SD8897 is supported.
> This is implemented based on dev_coredump, a new mechnism
> introduced in kernel 3.18rc3
> 
> Firmware dump can be trigger by
> echo 1 > /sys/kernel/debug/bluetooth/hci*/config/fw_dump
> and when the dump operation is completed, data can be read by
> cat /sys/class/devcoredump/devcd*/data
> 
> We have prepared following script to divide fw memory
> dump data into multiple files based on memory type.
> 
> [root]# cat btmrvl_split_dump_data.sh
> #!/bin/bash
> # usage: ./btmrvl_split_dump_data.sh dump_data
> 
> fw_dump_data=$1
> 
> mem_type="ITCM DTCM SQRAM APU CIU ICU MAC EXT7 EXT8 EXT9 EXT10 EXT11 EXT12 EXT13 EXTLAST"
> 
> for name in ${mem_type[@]}
> do
>         sed -n "/Start dump $name/,/End dump/p" $fw_dump_data  > tmp.$name.log
>         if [ ! -s tmp.$name.log ]
>                 then
>                         rm -rf tmp.$name.log
>                 else
>                         # Remove the describle info "Start dump" and "End dump"
>                         sed '1d' tmp.$name.log | sed '$d' > /data/$name.log
>                         if [ -s /data/$name.log ]
>                         then
>                                 echo "generate /data/$name.log"
>                         else
>                                 sed '1d' tmp.$name.log | sed '$d' > /var/$name.log
>                                 echo "generate /var/$name.log"
>                         fi
>                         rm -rf tmp.$name.log
>         fi
> done
> 
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Cathy Luo <cluo@marvell.com>
> Signed-off-by: Avinash Patil <patila@marvell.com>
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> v4: Change if/else check to improve readability
>    Move "#include <linux/devcoredump.h>" to btmrvl_sdio.c file.
>    Don't expose debugfs entry by showing an error when the callback is
>    not defined.
>    BT_ERR/BT_INFO already takes care of newline. Remove extra "\n" in
>    the message.
> v3: Change fw_dump debugfs file permissions to write only
>    Replace kstrtol with strtobool
> v2: Add "select WANT_DEV_COREDUMP" in Kconfig
>    Use write debugfs command instead of read to trigger dump operation.
> ---
> drivers/bluetooth/Kconfig          |   1 +
> drivers/bluetooth/btmrvl_debugfs.c |  31 ++++
> drivers/bluetooth/btmrvl_drv.h     |  20 +++
> drivers/bluetooth/btmrvl_main.c    |   7 +
> drivers/bluetooth/btmrvl_sdio.c    | 300 +++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btmrvl_sdio.h    |   5 +
> 6 files changed, 364 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

