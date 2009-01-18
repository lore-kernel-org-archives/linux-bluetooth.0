Return-Path: <cyrus@holtmann.org>
Subject: Re: Patching 2.6.24
From: Marcel Holtmann <marcel@holtmann.org>
To: Krishnan R <r_krish@email.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090115073034.99AEF1059C@ws1-3.us4.outblaze.com>
References: <20090115073034.99AEF1059C@ws1-3.us4.outblaze.com>
Content-Type: text/plain
Date: Sun, 18 Jan 2009 16:20:40 +0100
Message-Id: <1232292040.5095.18.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Krishnan,

> Is it possible to pull in just the Bluetooth changes in kernel 2.6.27 to 2.6.24? Does it have any other dependencies? I am trying to use 2.6.24 with BlueZ 4.17. 

I have 2.6.24 down as release in January 2008. In Linus years this is an
ancient kernel. Please just try to forward port any patches you have
with 2.6.24 to 2.6.28 and use just a recent kernel. In the long-term
this is the only way to keep you sane. Backporting changes to older
kernels are always tricky. Sure it can be done, but nobody with a sane
mind is doing it for free.

Regards

Marcel


