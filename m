Return-Path: <cyrus@holtmann.org>
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix uuid output in debugfs
In-Reply-To: <1356130624-29234-1-git-send-email-gustavo@padovan.org> (Gustavo
	Padovan's message of "Fri, 21 Dec 2012 20:57:04 -0200")
References: <1356130624-29234-1-git-send-email-gustavo@padovan.org>
Date: Wed, 02 Jan 2013 10:10:19 +0100
Message-ID: <87623g9chw.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 55cceee..05b78c7 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -461,19 +461,18 @@ static const struct file_operations blacklist_fops = {
>  
>  static void print_bt_uuid(struct seq_file *f, u8 *uuid)
>  {
> -	__be32 data0, data4;
> -	__be16 data1, data2, data3, data5;
> -
> -	memcpy(&data0, &uuid[0], 4);
> -	memcpy(&data1, &uuid[4], 2);
> -	memcpy(&data2, &uuid[6], 2);
> -	memcpy(&data3, &uuid[8], 2);
> -	memcpy(&data4, &uuid[10], 4);
> -	memcpy(&data5, &uuid[14], 2);
> -
> -	seq_printf(f, "%.8x-%.4x-%.4x-%.4x-%.8x%.4x\n",
> -		   ntohl(data0), ntohs(data1), ntohs(data2), ntohs(data3),
> -		   ntohl(data4), ntohs(data5));
> +	u32 data0, data5;
> +	u16 data1, data2, data3, data4;
> +
> +	data5 = le32_to_cpu(*(__le32 *)uuid);
> +	data4 = le16_to_cpu(*(__le16 *)(uuid + 4));
> +	data3 = le16_to_cpu(*(__le16 *)(uuid + 6));
> +	data2 = le16_to_cpu(*(__le16 *)(uuid + 8));
> +	data1 = le16_to_cpu(*(__le16 *)(uuid + 10));
> +	data0 = le32_to_cpu(*(__le32 *)(uuid + 12));
> +
> +	seq_printf(f, "%.8x-%.4x-%.4x-%.4x-%.4x%.8x\n",
> +		   data0, data1, data2, data3, data4, data5);
>  }
>  
>  static int uuids_show(struct seq_file *f, void *p)


Why can't all this be replaced with

static void print_bt_uuid(struct seq_file *f, u8 *uuid)
{
        seq_printf(f, "%pUl\n", uuid);
}

?


Bjørn
