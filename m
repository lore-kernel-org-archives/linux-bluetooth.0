Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jiri Kosina <jikos@jikos.cz>
In-Reply-To: <Pine.LNX.4.64.0710232004260.18815@twin.jikos.cz>
References: <200710231950.31313.alon.barlev@gmail.com>
	<1193162106.6184.208.camel@violet>
	<Pine.LNX.4.64.0710232004260.18815@twin.jikos.cz>
Date: Tue, 23 Oct 2007 20:25:05 +0200
Message-Id: <1193163905.6184.214.camel@violet>
Mime-Version: 1.0
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, bluez-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
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

Hi Jiri,

> > Second, can you try without uswsusp or suspend2. Both of them are not 
> > upstream and I can't tell how much these would effect this kind of 
> > behavior.
> 
> Hi Marcel,
> 
> actually uswsusp has been upstream for quite some time already. See 
> Documentation/power/userland-swsusp.txt

nice. I've never used it. Currently I am using what comes with Ubuntu
7.10 and that seems to work.

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
