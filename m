Return-Path: <cyrus@holtmann.org>
Message-ID: <1331147816.3392.182.camel@aeonflux>
Subject: Re: [PATCH obexd] build: Fix libbluetooth dependency
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 07 Mar 2012 11:16:56 -0800
In-Reply-To: <1331118699-10591-1-git-send-email-luiz.dentz@gmail.com>
References: <1331118699-10591-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Building with libbluetooth prior to 4.99 cause an error:
> 
> btio/btio.c: In function 'get_key_size':
> btio/btio.c:522:14: error: 'struct bt_security' has no member named 'key_size
> 
> Thanks to Bastien Nocera for reporting it.
> ---
>  configure.ac |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

I rather not have this patch included since it makes things complicated
for people to build this. Copying over just the header is good enough to
fix this.

Regards

Marcel


