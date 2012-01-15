Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CALO1QdHwejgjOQdyN0Dx97Ziuf3sAsvJLaGJi10OZYSWw2Sn6w@mail.gmail.com>
References: <CALO1QdHwejgjOQdyN0Dx97Ziuf3sAsvJLaGJi10OZYSWw2Sn6w@mail.gmail.com>
Date: Sun, 15 Jan 2012 23:32:58 +0200
Message-ID: <CABBYNZLn=tZ_cmaOO7_9wmW2YU7Ych3JqYoTEATBfq+e+QR4iQ@mail.gmail.com>
Subject: Re: obex-client fails with Connection refused (111) most of the time
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Islam Amer <pharon@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Jan 15, 2012 at 9:17 PM, Islam Amer <pharon@gmail.com> wrote:
> Hello,
>
> Using obex-client and the send-files test app on my thinkpad to send
> a single file to two different Nokia phones I get this error 90% of the time:
>
> Connection refused (111)

You are probably hitting a kernel regression, there is a fix already
just search for [PATCH] Bluetooth: Fix l2cap conn failures for ssp
devices, you can also try to disable ssp by doing: sudo hciconfig hci0
sspmode 0
