Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] tools: Fix memory leaks
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1234149329-4536-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1234149329-4536-1-git-send-email-gustavo@las.ic.unicamp.br>
Content-Type: text/plain
Date: Mon, 09 Feb 2009 13:31:21 +0100
Message-Id: <1234182681.4705.7.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Some printfs was using as parameter functions that return dinamic
> allocated memory. Now, we free them!
> 
> Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>

BlueZ doesn't use Signed-off-by for commit messages. That is kernel
stuff.

> @@ -1586,10 +1592,13 @@ static void print_dev_hdr(struct hci_dev_info *di)
>  static void print_dev_info(int ctl, struct hci_dev_info *di)
>  {
>  	struct hci_dev_stats *st = &di->stat;
> +	char * str;

This needs to be "char *str;"

Please fix it and re-sent the patch.

Regards

Marcel


