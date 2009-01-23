Return-Path: <cyrus@holtmann.org>
Cc: Kernel Janitors <kernel-janitors@vger.kernel.org>,
	richard.genoud@gmail.com, linux-bluetooth@vger.kernel.org
Message-Id: <BEC94463-F21B-4B9A-BB4F-248ECF9D8329@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniele Venzano <venza@brownhat.org>
In-Reply-To: <20090123140946.GA31355@milesteg.arr>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] Fix unused variable warning in rfcomm
Date: Fri, 23 Jan 2009 15:22:09 +0100
References: <20090123140946.GA31355@milesteg.arr>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

> Sorry, shouldn't have missed that.
>
> The following patch fixes a warning generated when compiling rfcomm.c
> without CONFIG_BT_RFCOMM_DEBUG.
> The warning was:
> net/bluetooth/rfcomm/sock.c: In function 'rfcomm_sock_ioctl':
> net/bluetooth/rfcomm/sock.c:795: warning: unused variable 'sk'

this has been fixed upstream already. So why does this come up again?

Regards

Marcel

