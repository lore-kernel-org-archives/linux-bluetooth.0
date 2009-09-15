Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Sep 2009 19:58:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Florian Philipp <lists@binarywings.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: PIN Helper
Message-ID: <20090915165854.GA6550@jh-x301>
References: <6887eb5d0909142301r52343cd3sbe64c106da2d7434@mail.gmail.com> <20090915061104.GA20323@jh-x301> <4AAFBFA6.70007@binarywings.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AAFBFA6.70007@binarywings.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 15, 2009, Florian Philipp wrote:
> Just out of curiosity: Why does Bluez no longer provide any kind of
> deamon as a pin helper any more?

Isn't that exactly what the two command line based agents are if you run
them in the background and modify them to always accept pairing requests?
Or am I misunderstanding your question? Note that we can't anymore have
interfaces which just deal with a simple PIN. Bluetooth 2.1 SSP brings
along it's own set of callbacks that need handling and any interface that
we define (be it a config file, D-Bus or something else) needs to take
that into account.

> I mean, it's not like Bluetooth itself is limited to interactive systems
> which rightly demand graphical interfaces nowadays. Stuff like NAP is a
> classic client-server situation in which you don't want to use Gnome or
> KDE apps on the server side and maybe not even on the client side.

The current agent interface design doesn't restrict you in any way to
interactive systems. It merely exports the pairing callbacks from
bluetoothd to an external process. bluetoothd doesn't care if that process
does some interactive stuff or not.

Johan
