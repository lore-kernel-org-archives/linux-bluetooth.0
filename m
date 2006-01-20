Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] patch: custom devup script
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <op.s3lrneii2fbw7g@no-home>
References: <43C29249.3020008@fillibach.de>
	 <1136909256.7200.6.camel@localhost.localdomain>
	 <43CD92AE.20006@fillibach.de> <1137590415.27515.17.camel@localhost>
	 <e1effdeb0601180937q11f65498r18ea21be597fb587@mail.gmail.com>
	 <op.s3lhk3t7e8fkrv@auth.smtp.kundenserver.de>
	 <1137631888.14557.23.camel@localhost>  <op.s3lrneii2fbw7g@no-home>
Content-Type: text/plain
Message-Id: <1137721430.17336.147.camel@localhost>
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
Date: Fri, 20 Jan 2006 02:43:50 +0100

Hi Kosta,

> > I like the idea. However I prefer to remove any default devup script at
> > all and only call it when specified on the command line. Can you provide
> > me with a patch for that?
> 
> Sure :)

your patch never applied to the latest CVS and so I had to fix up
everything by hand. Next time make sure the patch is against the CVS and
not some old version you use.

The stuff is now in and you might wanna test it.

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
