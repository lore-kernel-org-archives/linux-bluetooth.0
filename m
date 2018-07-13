Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKW+C-=vF2S3g4zJ+eKFGRNOtiZEgY25pxfj2NQDyMwGw@mail.gmail.com>
References: <CAASrBQkaQopjNq1+MtSGFyaOCc1icUB0GTFm8_=7YDLypVoz3w@mail.gmail.com>
 <CABBYNZKW+C-=vF2S3g4zJ+eKFGRNOtiZEgY25pxfj2NQDyMwGw@mail.gmail.com>
From: Mark Rages <markrages@gmail.com>
Date: Thu, 12 Jul 2018 22:42:26 -0600
Message-ID: <CAASrBQm_yWKcRUrBuMP=LYsRsNmZN6fsL8_h1oPcP07GZtKUPg@mail.gmail.com>
Subject: Re: Sending "CCCD Improperly Configured" error with dbus API
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 12, 2018 at 8:07 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mark,
>
> You would get the StartNotify which you can use to determine if there
> is anyone subscribed, though we may need a D-Bus error to make the
> proper error return.

Hi Luiz,

So it is currently not possible to send GATT errors through the D-BUS API?

Regards,
Mark
markrages@gmail
