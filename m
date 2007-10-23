Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Alon Bar-Lev <alon.barlev@gmail.com>
In-Reply-To: <9e0cf0bf0710231127o485a52e1sc7a06df7c8bc0189@mail.gmail.com>
References: <200710231950.31313.alon.barlev@gmail.com>
	<1193162106.6184.208.camel@violet>
	<Pine.LNX.4.64.0710232004260.18815@twin.jikos.cz>
	<1193163905.6184.214.camel@violet>
	<9e0cf0bf0710231127o485a52e1sc7a06df7c8bc0189@mail.gmail.com>
Date: Tue, 23 Oct 2007 20:30:10 +0200
Message-Id: <1193164210.6184.221.camel@violet>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@jikos.cz>
Subject: Re: [Bluez-devel] [BUG] rfcomm]
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Alon,

> > nice. I've never used it. Currently I am using what comes with Ubuntu
> > 7.10 and that seems to work.
> 
> Have you tried to suspend while pppd is using rfcomm?
> 
> The fact that it happens with suspend2 and uswsusp means that the
> issue is suspend blind.
> Do you need any more information in order to determine what is the problem?

the code in net/bluetooth/rfcomm/tty.c contains two calls to
device_move(). Please comment these out and try again. At least then we
know that it is in issue on how we use the driver model.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
