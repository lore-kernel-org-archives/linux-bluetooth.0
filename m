Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLn=tZ_cmaOO7_9wmW2YU7Ych3JqYoTEATBfq+e+QR4iQ@mail.gmail.com>
References: <CALO1QdHwejgjOQdyN0Dx97Ziuf3sAsvJLaGJi10OZYSWw2Sn6w@mail.gmail.com>
 <CABBYNZLn=tZ_cmaOO7_9wmW2YU7Ych3JqYoTEATBfq+e+QR4iQ@mail.gmail.com>
From: Islam Amer <pharon@gmail.com>
Date: Mon, 16 Jan 2012 00:21:11 +0200
Message-ID: <CALO1QdHW12yagbdrQcE0OBv8wprk3yzhFTwoqgLAhBT4ckDfkg@mail.gmail.com>
Subject: Re: obex-client fails with Connection refused (111) most of the time
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Jan 15, 2012 at 11:32 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Sun, Jan 15, 2012 at 9:17 PM, Islam Amer <pharon@gmail.com> wrote:
>> Hello,
>>
>> Using obex-client and the send-files test app on my thinkpad to send
>> a single file to two different Nokia phones I get this error 90% of the time:
>>
>> Connection refused (111)
>
> You are probably hitting a kernel regression, there is a fix already
> just search for [PATCH] Bluetooth: Fix l2cap conn failures for ssp
> devices, you can also try to disable ssp by doing: sudo hciconfig hci0
> sspmode 0

The hciconfig command fixes the issue. Thanks!
The patch you mention has been around for some time, so the
regression must have been around for even longer (which shows when searching
for the issue). Yet the patch is not applied in 3.2.1 upstream.

Does it need testing against a recent kernel ?

Thanks again!
