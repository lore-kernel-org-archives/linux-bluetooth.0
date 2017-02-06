Return-Path: <dario.teixeira@nleyten.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 06 Feb 2017 14:13:23 +0000
From: Dario Teixeira <dario.teixeira@nleyten.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Exchanging data over Bluetooth Classic
In-Reply-To: <59C74349-5707-4268-AB5A-8F3C5B6E03B3@holtmann.org>
References: <f0f88082abcb4aa700ca2e7898fc75b9@nleyten.com>
 <59C74349-5707-4268-AB5A-8F3C5B6E03B3@holtmann.org>
Message-ID: <e41fcfe1c481dfc6ff174af849f1bd4c@nleyten.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> you can use L2CAP or RFCOMM sockets to transfer data. Or you can use
> OBEX as provided by obexd if it is more file related transfer you are
> after.

Thanks for the reply. What is the most convenient way to programatically
use L2CAP or RFCOMM? There is one guide [1], but I reckon it's out of 
date
since Bluez made the transition to DBUS.  I heard it's possible to 
create
a character device for RFCOMM sockets; using them programatically them
reduces to the usual open/read/write/close of a file descriptor. Is this
still possible? (Mind you, Bluez docs are laconic in the extreme!)

Best regards,
Dario Teixeira

[1] https://people.csail.mit.edu/albert/bluez-intro/
