Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1769727890.20110105144834@gmail.com>
References: <1769727890.20110105144834@gmail.com>
Date: Wed, 5 Jan 2011 14:56:03 +0200
Message-ID: <AANLkTi=mncb6yoZECV8Rc3sXVvMcKkT=gGGyLN0nu+8k@mail.gmail.com>
Subject: Re: listening socket not notified when bluetoothd stops, but becomes unusable
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ilya Basin <basinilya@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jan 5, 2011 at 1:48 PM, Ilya Basin <basinilya@gmail.com> wrote:
> I use nonblocking sockets and select(). When I restart bluetoothd,
> select() doen't return, but the listening socket won't accept
> connections anymore. How to handle this correctly?

If you are using BDADDR_ANY than that is probably ok, now for specific
adapter this could be a bug but Im not sure about the powered state
before you restart and if RememberPowered is set, it could be that the
adapter is powered off after bluetoothd restart than you won't be able
to accept connections.

-- 
Luiz Augusto von Dentz
Computer Engineer
