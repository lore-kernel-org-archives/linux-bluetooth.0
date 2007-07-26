Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46A8A7C1.1050200@idlum.be>
References: <20070709093602.A2C6B58D565@mailflip16.edt02.net>
	<46935C56.5060108@idlum.be>
	<2EB6297382462046A9427D7324788A4801FD0E6C@MCLNEXVS06.resource.ds.bah.com>
	<4694A485.40904@idlum.be>  <46A8A7C1.1050200@idlum.be>
Date: Thu, 26 Jul 2007 16:30:54 +0200
Message-Id: <1185460255.7111.140.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Kernel Oops while transmitting data on
	several	RFCOMMlinks
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

Hi Pierre-Yves,

> After upgrading to kernel 2.6.21-2 (in fact, the 
> linux-image-2.6.21-2-486_2.6.21-5_i386.deb package from debian 
> unstable), I performed some new tests, and it happened again.
> 
> Please find attached what I got in the logs. What's wrong here? I will 
> gladly perform any test or action which you may ask to help track the 
> problem down. Just ask.

that is not the latest upstream kernel. Try 2.6.23-rc1.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
