Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5683FF9E.6080404@gmail.com>
References: <5683FF9E.6080404@gmail.com>
Date: Mon, 4 Jan 2016 12:09:04 -0200
Message-ID: <CABBYNZLdu2h3Sj1AC_A2Ez_-Ro0+GbfA7cMQ1O=+vhMbkMOyqw@mail.gmail.com>
Subject: Re: Configure two MAS instance for MAP in bluez
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Biman Paul <biman.innovative@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paul,

On Wed, Dec 30, 2015 at 2:00 PM, Biman Paul <biman.innovative@gmail.com> wrote:
> I need to configure two MAS instance:
> 1. MAS-0: For SMS
> 2. MAS-1: For Email

Currently this is no supported by the server implementation, we
actually have been discussing to change the way we exchange the data
with the system so instead of having built-in backends implementing
the message.h header (build time dependency) we would like to have
D-Bus agent concept (run time dependency), that way it wold be much
simpler to implement multiple instances.

> Please let me know if this is currently supported in bluez.
>
> If supported then please guide the steps to configure.
> If not supported then please advise on implementation.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
