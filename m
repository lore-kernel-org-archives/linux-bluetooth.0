Return-Path: <cyrus@holtmann.org>
Message-ID: <4CAEE1DB.1070202@Atheros.com>
Date: Fri, 8 Oct 2010 14:48:19 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Peculiar stuff in hci_ath3k/badness in hci_uart
References: <20101007214134.6bcd2e8f@lxorguk.ukuu.org.uk>
In-Reply-To: <20101007214134.6bcd2e8f@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alan,

On 10/8/2010 2:11 AM, Alan Cox wrote:
> Noticed this while looking at Savoy's stuff
>
>
> ath_wakeup_ar3k:
>
>         int status = tty->driver->ops->tiocmget(tty, NULL);
>
I agree, it will be a problem if the underlying driver try to access the 
"struct file". Is there any other way I can get the MCR status here 
without providing user space pointer?

>
> Fortunately I looked further and the further I looked the more fun it gets
>
> in hci_uart we have
>
>                  len = tty->ops->write(tty, skb->data, skb->len);
>
Regards
Suraj
