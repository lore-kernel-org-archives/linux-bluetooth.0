Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20071019073132.GA5678@havoc.gtf.org>
References: <20071019073132.GA5678@havoc.gtf.org>
Date: Sat, 20 Oct 2007 15:52:15 +0200
Message-Id: <1192888335.6184.115.camel@violet>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@linux-foundation.org>, bluez-devel@lists.sf.net,
        maxk@qualcomm.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bluez-devel] [PATCH] bluetooth: Eliminate checks
	for	impossible conditions in	irq handler
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

Hi Jeff,

>     [BLUETOOTH] Eliminate checks for impossible conditions in irq handler
>     
>     Our info structure and info->hdev is always passed to the irq handler,
>     so we don't have to worry about these checks in every interrupt.
>     
>     Leave a BUG_ON() just to help unwary programmers, but these could
>     probably be removed as well.

applied to my tree. Thanks.

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
