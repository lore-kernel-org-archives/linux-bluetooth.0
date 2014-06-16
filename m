Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Vikrampal <vikram.pal@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
Subject: Re: BlueZ make error
Date: Mon, 16 Jun 2014 13:14:44 +0200
Message-ID: <2956882.SkGP9SSC5Z@uw000953>
In-Reply-To: <009101cf7f2f$5810a4f0$0831eed0$@samsung.com>
References: <009101cf7f2f$5810a4f0$0831eed0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikrampal,

On Tuesday 03 of June 2014 18:55:33 Vikrampal wrote:
> Hi,
> 
> While building the latest BlueZ, I'm getting below error:
> 
> krampal-ubuntu:~/bluez$ sudo make

Why building as superuser?

> make --no-print-directory all-am
>   CC       client/main.o
> client/main.c: In function 'cmd_version':
> client/main.c:1098:28: error: 'VERSION' undeclared (first use in this
> function)
>   rl_printf("Version %s\n", VERSION);
>                             ^
> client/main.c:1098:28: note: each undeclared identifier is reported only
> once for each function it appears in
> client/main.c: In function 'main':
> client/main.c:1489:18: error: 'VERSION' undeclared (first use in this
> function)
>    printf("%s\n", VERSION);
>                   ^
> make[1]: *** [client/main.o] Error 
> make: *** [all] Error 2
> 
> Please help me. Thanks!

That could happen if you tempered with either Makefile or config.h files
(both are auto generated).

I suggest running configure (or bootstrap-configure if this is for development)
again.

-- 
Best regards, 
Szymon Janc
