Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1296799318-5517-1-git-send-email-padovan@profusion.mobi>
References: <1296799318-5517-1-git-send-email-padovan@profusion.mobi>
Date: Fri, 4 Feb 2011 14:38:13 +0200
Message-ID: <AANLkTi=P8dnzL9O-SatX_-zddHKndOLxA1vm3V1K+oji@mail.gmail.com>
Subject: Re: [bluetooth-next 00/16] l2cap.c split
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Feb 4, 2011 at 8:01 AM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Here is the first real split of l2cap.c file. That file was getting so big that
> we really need to split it in two or more. By now we have two file:
> l2cap_sock.c and l2cap_core.c. In l2cap_sock.c we have all functions that deals
> with sockets, in l2cap_core.c the rest.
>
> Side efects are that I had to move the declaration of many functions to l2cap.h
> along the l2cap socket list.
>
> There are more steps on this, but this is surely a big one.

What about creating a l2cap directory like rfcomm? Or that would cause
too much hassle with building system?

-- 
Luiz Augusto von Dentz
Computer Engineer
