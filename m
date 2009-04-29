Return-Path: <cyrus@holtmann.org>
Message-ID: <49F88DC2.60703@pook.es>
Date: Wed, 29 Apr 2009 19:26:26 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothd 4.37 -> Segmentation fault
References: <49F8638C.5070205@pook.es> <20090429160430.GA25611@jh-x301> <49F87CFF.4090804@pook.es> <20090429163255.GA27251@jh-x301>
In-Reply-To: <20090429163255.GA27251@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi Johan

Johan Hedberg wrote:

> The easiest way to try git and avoid messing with your current system is 
> to build using ./bootstrap-configure && make and run bluetoothd directly 
> from the source tree. bootstrap-configure uses the 
> --enable-maintainer-mode configure switch which makes bluetoothd load the 
> plugins right out of the source tree, so you don't need to worry about 
> version conflicts with your existing system.

yes but I'm talking about mixing different plugins between bluetoothd and the clients (aplay and twinkle in my case). The clients use plugins from /usr/lib. Do bluetoothd and the clients have to use exactly the same plugins? How often does the protocol between the clients and bluetoothd change?

Stuart
