Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050204153155.44842.qmail@web26406.mail.ukl.yahoo.com>
From: benbouzid imad <imad_benb@yahoo.fr>
Subject: Re: [Bluez-users] installing bluez in an access point
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1107529254.6921.38.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Fri, 4 Feb 2005 16:31:55 +0100 (CET)

 --- Marcel Holtmann <marcel@holtmann.org> a écrit : 
> Hi,
> 
> > how can I install bluez in a new kernel.
> > i want to build this application in my linux
> kernel in
> > a dsl chip. the kenel of the chip is 2.6.
> > 
> > Is bluez a module of the kernel or just an
> application
> > in the user space? 
> 
> the protocol part of BlueZ are mostly done as kernel
> modules. Also the
> host transport drivers are kernel drivers. The
> profiles are implemented
> as applications (library + utils).
> 
> Use a 2.6.10 kernel with the -mh3 patch and you have
> a very good kernel
> with the latest Bluetooth subsystem. Install
> bluez-{libs|utils}-2.15.

okay I will try that, (the -mh3 patch is a kernel?) .
Is there a probleme with 2035 broadcom chip? when I
use it with bluez I can't see it with a remote device
when I do an inquery or a scan.


> > and if someone can help me I had a small problem
> with
> > DNS.
> > How can I set a DNS IP-adress with a bash command
> for
> > my bnep0 interface??
> 
> You must use a DNS or DNS-Proxy server for that.

ther is a DNS server in the network and I had it IP
adress. but how can I tell this adresse to my bnep0
interface. a PANU is connected to a NAP and when I
ping a google with his IP adresse it works well. but
when I ping www.google.fr  it dosen't work because he
hasn't the adress of my DNS how can I tell it to
bnep0? is there a bash command like 
>>>>>>>#ifconfig bnep0 dns 10.10.10.1


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
