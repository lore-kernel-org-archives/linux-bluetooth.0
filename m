Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Dec 2014 14:36:13 +0100
From: Veseli Veseljko <veseljko75@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: ShanWan Sixaxis PS3 controller
Message-ID: <20141217133613.GA18280@ubuntu.localnet>
References: <20141216172421.GA12748@ubuntu.localnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141216172421.GA12748@ubuntu.localnet>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday, 2014-12-16, at 18:24:21 +0100, Veseli Veseljko wrote:
> I have a Sony PS3 Sixaxis compatible controller made by ShanWan. Is it
> possible to make it work with bluez sixaxis plugin? I tried it on
> Ubuntu 14.10 running Linux kernel 3.16 and bluez 5.20, compiled with
> sixaxis option.

I added some DBGs into "/profiles/input/server.c" code and I found
out that when dev_is_sixaxis is run, both vendor ID and product ID for
this controller are 0x0000.

Any ideas?

Best regards,

Veseljko
