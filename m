Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1191513767.10698.148.camel@violet>
References: <1191511655.3479.13.camel@cookie.hadess.net>
	<1191513767.10698.148.camel@violet>
Date: Thu, 04 Oct 2007 17:09:57 +0100
Message-Id: <1191514197.3479.16.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Possible infinite loop in inotify code
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

On Thu, 2007-10-04 at 18:02 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > Uli mentioned a possible infinite loop in some circumstances:
> > https://bugzilla.redhat.com/show_bug.cgi?id=235307
> > 
> > Although I wasn't able to reproduce the bug, the attached patch looks
> > technically correct.
> 
> I reworked the patch a little bit and applied it. The G_IO_STATUS_AGAIN
> and G_IO_ERROR_AGAIN are not guaranteed to be the same.

My mistake, I made the first patch using g_io_channel_read_chars instead
of the deprecated g_io_channel_read and changed the code accordingly
(including possible retvals), but then remembered eglib. I guess I
didn't completely revert those changes.

Cheers

-- 
Bastien Nocera <hadess@hadess.net> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
