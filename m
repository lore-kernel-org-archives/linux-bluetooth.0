Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] installing bluez in an access point
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050204145618.61753.qmail@web26402.mail.ukl.yahoo.com>
References: <20050204145618.61753.qmail@web26402.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1107529254.6921.38.camel@pegasus>
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
Date: Fri, 04 Feb 2005 16:00:54 +0100

Hi,

> how can I install bluez in a new kernel.
> i want to build this application in my linux kernel in
> a dsl chip. the kenel of the chip is 2.6.
> 
> Is bluez a module of the kernel or just an application
> in the user space? 

the protocol part of BlueZ are mostly done as kernel modules. Also the
host transport drivers are kernel drivers. The profiles are implemented
as applications (library + utils).

Use a 2.6.10 kernel with the -mh3 patch and you have a very good kernel
with the latest Bluetooth subsystem. Install bluez-{libs|utils}-2.15.

> and if someone can help me I had a small problem with
> DNS.
> How can I set a DNS IP-adress with a bash command for
> my bnep0 interface??

You must use a DNS or DNS-Proxy server for that.

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
