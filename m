Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1d49725d0704140901v7f778dd5tbe1b4fdfaef44430@mail.gmail.com>
References: <1d49725d0704140901v7f778dd5tbe1b4fdfaef44430@mail.gmail.com>
Date: Thu, 19 Apr 2007 01:49:15 +0200
Message-Id: <1176940155.6741.44.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Error connecting after inquiry
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Donnie,

> Ok, the name is now only checked for devices that pass the class
> filter.
> Is there any way to ensure the baseband connection is closed?

I might have to fix that inside the kernel. A remote name complete event
should trigger a re-iteration of pending connect requests. This is not
simple. However you can call a remote name cancel command before
actually connecting to the device.

However the best for you is to use a high timeout for the name request
function. This will ensure that you catch the remote name complete
events and not abort before that. Use the values we use in hcitool,
because they are this long for a reason.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
