Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] installing bluez in an access point
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050204153155.44842.qmail@web26406.mail.ukl.yahoo.com>
References: <20050204153155.44842.qmail@web26406.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1107532179.6921.44.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 04 Feb 2005 16:49:39 +0100

Hi,

> > Use a 2.6.10 kernel with the -mh3 patch and you have
> > a very good kernel
> > with the latest Bluetooth subsystem. Install
> > bluez-{libs|utils}-2.15.
> 
> okay I will try that, (the -mh3 patch is a kernel?) .

it is a kernel patch against the vanilla 2.6.10 to add the latest
changes to the Bluetooth subsystem.

> Is there a probleme with 2035 broadcom chip? when I
> use it with bluez I can't see it with a remote device
> when I do an inquery or a scan.

What 2035 is this? USB or UART? If USB send in the content
of /proc/bus/usb/devices.

> > You must use a DNS or DNS-Proxy server for that.
> 
> ther is a DNS server in the network and I had it IP
> adress. but how can I tell this adresse to my bnep0
> interface. a PANU is connected to a NAP and when I
> ping a google with his IP adresse it works well. but
> when I ping www.google.fr  it dosen't work because he
> hasn't the adress of my DNS how can I tell it to
> bnep0? is there a bash command like 
> >>>>>>>#ifconfig bnep0 dns 10.10.10.1

Enter it in /etc/resolv.conf.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
