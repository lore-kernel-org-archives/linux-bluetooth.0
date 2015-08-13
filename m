Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluetooth: hciuart: Add support QCA chipset for UART
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20150813205655.GA30361@mwanda>
CC: <linux-bluetooth@vger.kernel.org>
From: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Message-ID: <55CD1158.10508@qca.qualcomm.com>
Date: Thu, 13 Aug 2015 14:51:20 -0700
MIME-Version: 1.0
In-Reply-To: <20150813205655.GA30361@mwanda>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

On 08/13/15 13:59, Dan Carpenter wrote:
> Hello Ben Young Tae Kim,
>
> The patch 0ff252c1976d: "Bluetooth: hciuart: Add support QCA chipset
> for UART" from Aug 10, 2015, leads to the following static checker
> warning:
>
> 	drivers/bluetooth/hci_qca.c:485 qca_debugfs_init()
> 	warn: passing casted pointer '&qca->tx_vote' to 'debugfs_create_bool()' 1 vs 32.
>
> drivers/bluetooth/hci_qca.c
>     482                             &qca->ibs_recv_wakes);
>     483          debugfs_create_u64("ibs_recv_wake_acks", mode, ibs_dir,
>     484                             &qca->ibs_recv_wacks);
>     485          debugfs_create_bool("tx_vote", mode, ibs_dir, (u32 *)&qca->tx_vote);
>
> debugfs_create_bool() is stupid, because the name says bool but it
> writes a u32.  I am not sure why this is.  Maybe because the sizeof
> _Bool is not defined in C?  Anyway, this will not work and will also
> corrupt memory.

I agree with you. The reason why I do the cast as u32 type pointer is 
debugfs_create_bool() function is required to put value as u32 *. But it 
will cause memory corruption to read that because it is actual 1 byte. 
Thanks for your report. I'll submit the patch to address it soon.

>
>     486          debugfs_create_u64("tx_votes_on", mode, ibs_dir, &qca->tx_votes_on);
>     487          debugfs_create_u64("tx_votes_off", mode, ibs_dir, &qca->tx_votes_off);
>     488          debugfs_create_bool("rx_vote", mode, ibs_dir, (u32 *)&qca->rx_vote);
>                                 ^^^^
> Same.
>
>     489          debugfs_create_u64("rx_votes_on", mode, ibs_dir, &qca->rx_votes_on);
>     490          debugfs_create_u64("rx_votes_off", mode, ibs_dir, &qca->rx_votes_off);
>
>
>
> regards,
> dan carpenter

Thanks
-- Ben Kim
