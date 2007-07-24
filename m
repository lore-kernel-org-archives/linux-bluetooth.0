Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185291723.7111.58.camel@violet>
References: <1185233353.3641.82.camel@cookie.hadess.net>
	<1185291723.7111.58.camel@violet>
Date: Tue, 24 Jul 2007 17:23:33 +0100
Message-Id: <1185294213.3641.136.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] 2 more patches for bluez-gnome
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

On Tue, 2007-07-24 at 17:42 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > The descriptions of each patch are in the patches, thanks git.
> 
> most of your patches are in the CVS now. I dropped the thread stuff and
> removed the obexftp check since that is too ugly. Need to do some
> autoconf/automake magic first.

What other way do you think we should check for the availability of
nautilus and the obexftp gnome-vfs module?

It's quite ugly, but it mimicks what gnome-vfs does, without using
gnome-vfs directly. I could move it to a different helper file if that's
any help.

-- 
Bastien Nocera <hadess@hadess.net> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
