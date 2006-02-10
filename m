Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] CVS not allowing anonymous authentication for checkout
Message-ID: <20060210021621.GA16348@163.com>
References: <87hd7agci8.fsf@gismo.pca.it> <43EA22A5.5000105@hasborg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43EA22A5.5000105@hasborg.com>
From: Amateur <ztl.post@gmail.com>
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
Date: Fri, 10 Feb 2006 10:19:31 +0800

On Wed, Feb 08, 2006 at 11:56:05AM -0500, Joshua Wright wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> It appears that the BlueZ CVS repository is not allowing anonymous
> access any longer:
> 
> $ cvs -d:pserver:anonymous@cvs.bluez.org:/cvsroot/bluez login
> Logging in to :pserver:anonymous@cvs.bluez.org:2401/cvsroot/bluez
> CVS password: <CR>
> cvs login: authorization failed: server cvs.bluez.org rejected access to
> /cvsroot/bluez for user anonymous
I tried 'cvs -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa
co btsco' a few days ago, and it worked.

> 
> Also, the web interface to the CVS repository is returning a 502 Proxy
> Error.
> 
> Other sf.net projects are not exhibiting these same errors.  Has the CVS
> repository for BlueZ been marked private?
> 
> Thanks,
> 
> - -Josh
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> 
> iD8DBQFD6iKlTS8i9jZYpL8RAsGPAKC1SvmX3HWPDw0XWJStGA8/NBoTSACfY5ww
> 8DIBXOIrFIKe1eSk42NmPXY=
> =6dE5
> -----END PGP SIGNATURE-----
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
-------------------------

-- 
You will be audited by the Internal Revenue Service.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
