Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <fd87b6160602092350p53053bc1gfaad58d0bf6a9a4@mail.gmail.com>
From: John McCabe-Dansted <gmatht@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] CVS not allowing anonymous authentication for checkout
In-Reply-To: <20060210021621.GA16348@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <87hd7agci8.fsf@gismo.pca.it> <43EA22A5.5000105@hasborg.com>
	 <20060210021621.GA16348@163.com>
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
Date: Fri, 10 Feb 2006 20:50:13 +1300

> > $ cvs -d:pserver:anonymous@cvs.bluez.org:/cvsroot/bluez login
> > Logging in to :pserver:anonymous@cvs.bluez.org:2401/cvsroot/bluez
> > CVS password: <CR>
> > cvs login: authorization failed: server cvs.bluez.org rejected access t=
o
> > /cvsroot/bluez for user anonymous
> I tried 'cvs -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa
> co btsco' a few days ago, and it worked.

I noticed that it had stopped working a few days ago, however it seems
to be back up now.

--
John C. McCabe-Dansted
Master's Student


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
