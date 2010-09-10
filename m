Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100910143813.4af0a3ce@lxorguk.ukuu.org.uk>
References: <AANLkTikTBdr4U1bPtfXWhgLgdvWDMPJrFjBCktPL40dg@mail.gmail.com>
	<20100910143813.4af0a3ce@lxorguk.ukuu.org.uk>
Date: Fri, 10 Sep 2010 14:07:11 -0500
Message-ID: <AANLkTikXFmaZs+XzrOWjWoLPhyUy0CEXfOQMqP=Xp1cO@mail.gmail.com>
Subject: Re: Request for input regarding new driver in MFD for
 GPS_Bluetooth_FM controller CG2900
From: Pavan Savoy <pavan_savoy@sify.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: pghatwork@gmail.com, par-gunnar.p.hjalmdahl@stericsson.com,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linus.walleij@stericsson.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Can you directly make use of the ti-st driver which is currently staged?
It has _EXACTLY_ the same thing.... which is REALLY REALLY surprising !!!

On Fri, Sep 10, 2010 at 8:38 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>  - Is it OK to dynamically use the channels either from Kernel or User space?
>
> Quite a few devices do this. In most cases it makes no sense to burden
> the user with channel management so its only natural that opening the tty
> or direct interfaces should "just work"
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
