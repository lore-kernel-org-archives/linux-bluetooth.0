Return-Path: <cyrus@holtmann.org>
Message-ID: <1384169302.1898.1.camel@nuvo>
Subject: Re: [PATCH 2/3] all: Use G_SOURCE_REMOVE/G_SOURCE_CONTINUE macros
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development"
	 <linux-bluetooth@vger.kernel.org>
Date: Mon, 11 Nov 2013 12:28:22 +0100
In-Reply-To: <BCD6D340-765E-45BB-AC3E-7A0C98348773@holtmann.org>
References: <1384016586.3880.37.camel@nuvo>
	 <BCD6D340-765E-45BB-AC3E-7A0C98348773@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2013-11-11 at 17:04 +0900, Marcel Holtmann wrote:
<snip>
> problem is that we currently only require GLib 2.28 and this got introduced in GLib 2.32.

You'd take that with an if GLIB_VERSION() #define G_SOURCE_... compat
helper?
