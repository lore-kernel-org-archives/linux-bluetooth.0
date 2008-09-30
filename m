Return-Path: <cyrus@holtmann.org>
Subject: Re: BIP Basic Image profile support in bluez stack
From: Bastien Nocera <hadess@hadess.net>
To: Ram kumar <ramkumar.research@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <6306c640809300146l62e6aaebt9e86daf82efa8d9e@mail.gmail.com>
References: <6306c640809300146l62e6aaebt9e86daf82efa8d9e@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 30 Sep 2008 09:52:23 +0100
Message-Id: <1222764743.3311.109.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2008-09-30 at 14:16 +0530, Ram kumar wrote:
> hi,
>       Did bluez support BIP profile.I am using linux 2.6.25.I am not
> able to find any info regarding this on the bluez website.
> 
> If Bluez supports BIP profile.How to enable that file through sdptool ???

obex-data-server SVN trunk supports BIP. I don't know of any front-ends
that actually use it yet though.

