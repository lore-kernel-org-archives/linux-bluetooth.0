Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Jan 2010 17:32:47 +0000 (GMT)
To: Ed Tsang <netdesign_98@yahoo.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Subject: Re: hcitool cc ....    connected and drop
In-Reply-To: <91686.99772.qm@web52606.mail.re2.yahoo.com>
References: <615585.7801.qm@web52606.mail.re2.yahoo.com> <1264624890.117914.1293.nullmailer@galant.ukfsn.org> <91686.99772.qm@web52606.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1264699968.366595.545.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 28 Jan 2010, Ed Tsang wrote:

> >the Linux kernel does that for all completed connections
>
> I am still very "green" to bluez and linux. Is there a place where I can
> look into the bluetooth related kernel codes?

I don't think there is any API documentation, but the kernel sources can
be seen at many places on the internet, such as

  http://lxr.linux.no/#linux+v2.6.32/net/bluetooth/

> Is the disconnect command came from the kernel code too?

most likely

iain
