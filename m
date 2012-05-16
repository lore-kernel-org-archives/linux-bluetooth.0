Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 May 2012 10:44:05 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: "Min Jun,Xi" <xi.minjun@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, anderson.lizardo@openbossa.org
Subject: Re: Anyone knows the chip model for IOGEAR Bluetooth 4.0 USB Micro
 Adapter (GBU521) ?
Message-ID: <20120516134405.GA4652@echo>
References: <CAB0Wyvkwq0+0zo=Fy-5Fe5hxENq5S284DS0ARZEbhkWfYno6zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB0Wyvkwq0+0zo=Fy-5Fe5hxENq5S284DS0ARZEbhkWfYno6zQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 10:27 Wed 16 May, Min Jun,Xi wrote:
> Hello All,
> 
> Anderson (in CC list) suggests BlueZ only support the dual-mode USB
> dongle, so I am trying to find one avaliable dual-mode Bluetooth 4.0
> USB dongle, which can be driven by BlueZ under Linux.
> Finally, I found IOGEAR Bluetooth 4.0 USB Micro Adapter (GBU521),
> which is said to be dual-mode. Here my question is: does anyone know
> which chip is used by this adapter? Can it be driven by BlueZ?

I don't know for sure which chip it uses. But probably it will work with
BlueZ, and if it doesn't, it would just need a 2-line patch to make it work.

> 
> Thank you very much!
> --
> Best regards,
> Xi Minjun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
