Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Young <hidave.darkstar@gmail.com>
In-Reply-To: <20071106060028.GA3176@darkstar.te-china.tietoenator.com>
References: <20071106060028.GA3176@darkstar.te-china.tietoenator.com>
Date: Tue, 06 Nov 2007 14:33:50 +0100
Message-Id: <1194356030.4763.18.camel@aeonflux>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] [PATCH]bluetooth rfcomm_dev refcount bug fix
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

Hi Dave,

> I'm afraid to be considered as spam ;)
> 
> (Due to timezone offset, I have to mail again and cann't wait for your
> reply, sorry for the annoying)

I am in a different timezone every other week. So nevermind ;)

> I think the rfcomm_dev_put could be seperated from the rfcomm_dev_put,
> it will be more straitforward then.
> 
> please consider below patch, tested on my side. thanks.

That one looks totally wrong to me. Without even testing it, it will
have side effects that you haven't run into yet. Unless the TTY core
changed so much, this comments are there for a really good reason and
the code is tested a lot.

Also if you have to do two rfcomm_dev_put() in a row, then we are doing
something really wrong and this tries to hide a real bug somewhere.

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
