Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] how to obtain address for rfcomm connection
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1106164863.12437.44.camel@justakiss>
References: <1106148402.12428.21.camel@justakiss>
	 <1106154308.8190.128.camel@pegasus>  <1106164863.12437.44.camel@justakiss>
Content-Type: text/plain
Message-Id: <1106167013.8190.131.camel@pegasus>
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
Date: Wed, 19 Jan 2005 21:36:53 +0100

Hi Erwin,

> the phone (ericsson t630) didn't connect to a specific service, there's
> a menu entry for discovering new devices. After a few seconds, the names
> of the discovered devices show up. When one of them is selected, the
> phone shows a prompt for entering the pincode, and the link key is saved
> on the Linux system. The purpose of the system is a tcp/ip transmission
> from the Linux system via GSM/GPRS. On the Linux system, no selection or
> entry should be necessary, the ppp over rfcomm connection should come up
> automatically or by pressing a button.

establish a OBEX push service on your device and after you send a vCard
from your phone you get the BD_ADDR.

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
