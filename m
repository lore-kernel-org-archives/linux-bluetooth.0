Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: bluez/android: Building Only BfA
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAKafyqpwc+H+XRVOF807gacpEvuPiD1wPYYWof=ycdSKaBxrnQ@mail.gmail.com>
Date: Fri, 19 Jun 2015 02:48:55 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8BA36FE3-8B14-4ABF-BA6C-DCF38525E51F@holtmann.org>
References: <CAKafyqpwc+H+XRVOF807gacpEvuPiD1wPYYWof=ycdSKaBxrnQ@mail.gmail.com>
To: Prabhu Chawandi <foss.chaws@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prabhu,

>  How can I build only BfA, currently when I  --enable-android,
> desktop bluez also gets built.
> 
> Anyway to build BfA alone?

we are building BfA on Linux platforms for extra testing purposes and not to actually run it as main daemon. That is why there is no option to just build BfA.

Regards

Marcel

