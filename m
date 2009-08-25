Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Aug 2009 14:41:26 +0100 (BST)
To: Mateus Interciso <mateus@ouvi.com.br>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Question on simple RFCOMM server
In-Reply-To: <4A93D887.8060007@ouvi.com.br>
References: <4A93D887.8060007@ouvi.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1251207686.259635.1938.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 25 Aug 2009, Mateus Interciso wrote:

> Hello, I have a very simple RFCOMM server that I adapted from an extremely
> simple TCP echo server I've made for learning TCP, it's a simple fork()
> server, and while the TCP server works perfeclty, the RFCOMM works only with 2
> connected clients at the same time, and I'm failling to see the problem, can
> someone help me?

You didn't post what the 'failure' was but for RFCOMM you can only have
one connection on a server channel (each RFCOMM channel corresponds to
an emulated serial port).

since a TCP connection is defined by the address and port at each end, the
Bluetooth equivalent is more likely to be a a L2CAP connection to a given
PSM which can support up to ~64k channels (though as the Peter Wippich
notes, the number of devices the radio can maintain connections with is
limited)

iain


