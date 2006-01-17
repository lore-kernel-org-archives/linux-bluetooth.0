Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] linkkeys on jffs2
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <38907.62.33.148.3.1137487338.squirrel@62.33.148.3>
References: <38907.62.33.148.3.1137487338.squirrel@62.33.148.3>
Content-Type: text/plain
Message-Id: <1137495220.5688.7.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 17 Jan 2006 11:53:40 +0100

Hi Andrey,

> Got a problem with hcid storing link keys on jffs2 file system.
> Hcid is able to store only one link key, all subsequent keys doesn't
> appear in linkkeys file.
> After looking into sources I find out in common/textfile.c call of mmap()
> with MAP_SHARED flag which is not suported on jffs2.
> As mmap is used only for seeking keys in maped memory not for storing into
> file seems it's good idea to use MAP_PRIVATE flag. In this case there are
> no error on jffs2

if you inline the patch, make sure your mail client doesn't do line
breaks in that area. Otherwise attach it.

However the patch is in the CVS now. Thanks.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
