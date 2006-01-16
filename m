Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Problems with smart phones when using
	a"silent"kernel
From: Bastien Nocera <hadess@hadess.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1137428510.6324.58.camel@localhost.localdomain>
References: <C70061B183DE09419568AB2060C52A950177D435@arion.intra.local>
	 <1137428510.6324.58.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1137432461.7949.0.camel@wyatt.hadess.net>
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
Date: Mon, 16 Jan 2006 17:27:41 +0000

On Mon, 2006-01-16 at 17:21 +0100, Marcel Holtmann wrote:
> Hi Victor,
> 
> > This fixes the problem with console redirected to /dev/null.
> 
> I applied your patch to the CVS, but is this the best way to redirect
> stdin, stdout and stderr to /dev/null?

As Dimitry mentioned, daemon(3) should help:
       Unless  the  argument noclose is non-zero, daemon() will redirect
stan-
       dard input, standard output and standard error to /dev/null.


---
Bastien Nocera <hadess@hadess.net> 




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
