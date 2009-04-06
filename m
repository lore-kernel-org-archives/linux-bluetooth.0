Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090405130856.w9g2f6pa804kg84g@webmail.unina.it>
References: <20090405130856.w9g2f6pa804kg84g@webmail.unina.it>
Date: Mon, 6 Apr 2009 11:38:41 -0300
Message-ID: <2d5a2c100904060738n1e1e450bnf63aab1b52960c15@mail.gmail.com>
Subject: Re: Status of serial proxy
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: ranaldo@unina.it
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nicola,

On Sun, Apr 5, 2009 at 8:08 AM,  <ranaldo@unina.it> wrote:
> Hi!
> I cannot find dbus api documentation for the serial proxy manager, and I'd
> like to know the current status of this part of bluez.
> I guessed the parameters looking at the sources and was able to create and
> enable a tcp proxy. I'm able to see it from another box with sdptool, but
> rfcomm does not connect. I'm not sure why, however the profile show a
> channel 0, is this normal?
>
>    Nicola Ranaldo

I've fixed the problem of channel 0 some time ago, so either wait for
4.35 release or use the current HEAD.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
