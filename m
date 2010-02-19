Return-Path: <cyrus@holtmann.org>
References: <588634.45024.qm@web52606.mail.re2.yahoo.com>
Message-Id: <47D1FE13-804A-48AC-9976-2B3A1C012D29@gmail.com>
From: lorenzo.brito@gmail.com
To: Ed Tsang <netdesign_98@yahoo.com>
In-Reply-To: <588634.45024.qm@web52606.mail.re2.yahoo.com>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPod Mail 7D11)
Subject: Re: obex-client: how to select a dongle from muliple dongles to send-files
Date: Fri, 19 Feb 2010 16:14:44 -0600
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Im implementing something similar. Obexftp library gives you a free  
conecxion so what im doing is to call the method by diferent threats.

Sent from my iPod

On 19/02/2010, at 13:47, Ed Tsang <netdesign_98@yahoo.com> wrote:

> Hi,
>   Need some hint from the expert.
>   I am using  test/send-files to send files. But when I have  
> multiple dongles, I would like in run time to select which dongle to  
> send out the file either using hci0/1 or the actual dongle address  
> or other means. I tried trace it down but got lost. Anyone could  
> provide some hint.
>
> Ed
>
>
>
>       
> __________________________________________________________________
> Looking for the perfect gift? Give the gift of Flickr!
>
> http://www.flickr.com/gift/
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
