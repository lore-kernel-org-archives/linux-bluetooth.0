Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: GATT plugin
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAAqhSf6mcSTrPyTrEu8KL7GFmnVGf9OjPNS+vNyARyhQZc=c6A@mail.gmail.com>
Date: Mon, 26 Jan 2015 22:11:04 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <01815345-0542-4F64-8535-9193F31D123E@holtmann.org>
References: <CAAqhSf6mcSTrPyTrEu8KL7GFmnVGf9OjPNS+vNyARyhQZc=c6A@mail.gmail.com>
To: Tyler Arnold <choosetylernol@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tyler,

> I am building a GATT service/plugin for the bluetooth daemon and have
> ported 5.27 bluez to my embedded ARM platform.
> 
> It seems like the GATT D-Bus API is not quite ready, so my options
> appear to be either building the plugin and linking it as a statically
> linked object or build it as a shared object library where the daemon
> will pick it up from /usr/local/lib/bluetooth/plugins
> Are both supported? I saw a message from about a year ago suggesting
> the shared object approach was not the best path.

actually I would prefer if we get the GATT D-Bus API ready so that you can use it. Have you tried it? I am actually curious to hear what would be missing.

Regards

Marcel

