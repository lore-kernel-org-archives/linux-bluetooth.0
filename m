Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43D615A8.1010102@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] (no subject)
References: <20060124112008.99F041F76A6@mrelay2.st2.lyceu.net>
In-Reply-To: <20060124112008.99F041F76A6@mrelay2.st2.lyceu.net>
Content-Type: text/plain; charset=windows-1252
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 24 Jan 2006 11:55:20 +0000

Esther L=F3pez Casariego wrote:
> Is there any way to know the Golden Range defined for a Bluetooth devic=
e??
> (I have search the list of HCI commands and haven=92t found it)

There's no easy and portable way.

The spec tells you where it's allowed to be, but finding out exactly
where it is for a given device is tricky. You'll need some vendor
specific commands and probably a pile of documentation.

	- Steven
--=20


To access the latest news from CSR copy this link into a web browser:  ht=
tp://www.csr.com/email_sig.html


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
