Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <C6216C494F7BD443AA39D93B9BB9CF29018F78E7@esebe107.NOE.Nokia.com>
References: <C6216C494F7BD443AA39D93B9BB9CF29018F78D0@esebe107.NOE.Nokia.com>
	<1193823612.32459.14.camel@violet>
	<C6216C494F7BD443AA39D93B9BB9CF29018F78E7@esebe107.NOE.Nokia.com>
Date: Wed, 31 Oct 2007 10:48:24 +0100
Message-Id: <1193824104.32459.17.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] DUN
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

Hi Dmitry,

> Yep, I saw that. Probably it register SPP SDP record?
> Is it fully functional? Does it register proper SDP record for DUN?

you can give it a UUID and it will create the proper service record for
it. If not, then that is a bug and needs fixing.

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
