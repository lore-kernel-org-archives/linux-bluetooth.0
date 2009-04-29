Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Apr 2009 20:42:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Stuart Pook <linux-bluetooth4@pook.es>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothd 4.37 -> Segmentation fault
Message-ID: <20090429174229.GA29760@jh-x301>
References: <49F8638C.5070205@pook.es> <20090429160430.GA25611@jh-x301> <49F87CFF.4090804@pook.es> <20090429163255.GA27251@jh-x301> <49F88DC2.60703@pook.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49F88DC2.60703@pook.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stuart,

On Wed, Apr 29, 2009, Stuart Pook wrote:
> > The easiest way to try git and avoid messing with your current system is 
> > to build using ./bootstrap-configure && make and run bluetoothd directly 
> > from the source tree. bootstrap-configure uses the 
> > --enable-maintainer-mode configure switch which makes bluetoothd load the 
> > plugins right out of the source tree, so you don't need to worry about 
> > version conflicts with your existing system.
> 
> yes but I'm talking about mixing different plugins between bluetoothd
> and the clients (aplay and twinkle in my case). The clients use plugins
> from /usr/lib.

Ah, yes. Sorry about the misunderstanding. I thought you were referring to
plugins loaded by bluetoothd.

> Do bluetoothd and the clients have to use exactly the same plugins? How
> often does the protocol between the clients and bluetoothd change?

The protocol doesn't change very often. Last time it changed was between
4.33 and 4.34. So it should be fine to use latest git with 4.37 plugins.

Johan
