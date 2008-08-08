Return-Path: <cyrus@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200807311452.24166.oliver@neukum.org>
References: <200807311452.24166.oliver@neukum.org>
Content-Type: text/plain
Date: Fri, 08 Aug 2008 23:14:30 +0200
Message-Id: <1218230070.25524.7.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> here's my current version of btusb with SCO support. This is preliminary.
> I am still looking at a way to delay using the higher altsettings until SCO
> is actually used, but the timeouts seem to be too long to do the obvious.

the module parameter and blacklist/quirks stuff has been merged upstream
with Linus now. Feel free to update your SCO support patch and then lets
get this merged.

Regards

Marcel


