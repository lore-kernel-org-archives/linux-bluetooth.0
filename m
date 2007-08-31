Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46D84FBD.60203@gmail.com>
References: <46D84FBD.60203@gmail.com>
Date: Fri, 31 Aug 2007 20:45:20 +0200
Message-Id: <1188585920.13373.105.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] SDP lib memory leak
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

Hi Manuel,

> I have made an application that makes use of the sdp lib. By 
> running the app with valgrind [1] I found a memory leak.
> There's an static variable called bluetooth_base_uuid that's being 
> initializated once but then never freed.
> I had added a method that should be called, only when the thread is 
> about to end that frees that variable.
> Attached you can see the patch.

thanks for the patch, but I put a different patch in the CVS that avoids
any memory allocation at all.

Can you extract me a test program from your application, so I can double
check that it is doing the right thing on little and big endian systems
and we don't have any memory leaks at all anymore.

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
