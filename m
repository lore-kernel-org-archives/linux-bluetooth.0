Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Permissions on Sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <6DD9FBCE-69DB-11D9-A39A-000D9348D4BE@magnifeye.com>
References: <41B8A67C.3060608@paytec.com> <1102627652.7962.4.camel@pegasus>
	 <8EEDF252-6988-11D9-A39A-000D9348D4BE@magnifeye.com>
	 <1106092579.8190.81.camel@pegasus>
	 <6DD9FBCE-69DB-11D9-A39A-000D9348D4BE@magnifeye.com>
Content-Type: text/plain
Message-Id: <1106167261.8190.138.camel@pegasus>
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
Date: Wed, 19 Jan 2005 21:41:01 +0100

Hi Jonathan,

> I am doing an inquiry of all devices, finding our device, connecting to 
> it and the reading bytes via a rawsocket.
> 
> The only issue I see so far is the writev command (I copied the code 
> from hci_send_cmd).
> 
> How do I assign root rights for this?

you need to change the HCI security filter inside the kernel or make
your application setuid root or adapt the capabilities of your program.

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
