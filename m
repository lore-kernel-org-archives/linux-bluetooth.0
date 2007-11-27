Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Young <hidave.darkstar@gmail.com>
In-Reply-To: <20071127103239.GA4477@darkstar.te-china.tietoenator.com>
References: <4746EC10.5080509@pracucci.com>
	<20071127103239.GA4477@darkstar.te-china.tietoenator.com>
Date: Tue, 27 Nov 2007 11:38:24 +0100
Message-Id: <1196159904.17196.33.camel@aeonflux>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Bluez-devel] 2.6.23.8: kernel panic
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

> This problem is caused by the workqueue in hci_sysfs.c, the del_conn is scheduled after the add_conn with same bluetooth address.
> 
> Please try this patch:
> ----------------------------
> 
> The bluetooth hci conn sysfs add/del executed in the default workqueue. If the conn del function is executed after the new conn add function with same bluetooth target address, the connection add will failed and warning about same kobject name.
> 
> Here add a btconn workqueue, and flush the workqueue in the add_conn function to avoid the above issue. 

the patch looks good to me (except some style cleanups). Let me push it
to one of my test machines and stress it a little bit. I give you
feedback after my testing.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
