Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] how to obtain address for rfcomm connection
From: Erwin Authried <eauth@softsys.co.at>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1106154308.8190.128.camel@pegasus>
References: <1106148402.12428.21.camel@justakiss>
	 <1106154308.8190.128.camel@pegasus>
Content-Type: text/plain
Message-Id: <1106164863.12437.44.camel@justakiss>
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
Date: Wed, 19 Jan 2005 21:01:03 +0100

Am Mit, den 19.01.2005 schrieb Marcel Holtmann um 18:05:
> Hi Erwin,
> 
> > I want to establish a rfcomm connection to a mobile phone. I don't know
> > the phone's address or name a-priori. The pairing is initated from the
> > phone before the rfcomm connection is initiated. Is there an easy way to
> > get the phone's address from the preceding link key exchange (from
> > /etc/bluetooth/link_key?). Browsing/scanning for devices might give more
> > than one canditate for communication, but I want to use only the one
> > that has already paired.
> 
> you will find any paired device in the link_key file. However if the
> phone was connected then you can use normal technics to get the device
> address at the that time. To what service did the phone connect?
> 
> Regards
> 
> Marcel

Hi Marcel,
the phone (ericsson t630) didn't connect to a specific service, there's
a menu entry for discovering new devices. After a few seconds, the names
of the discovered devices show up. When one of them is selected, the
phone shows a prompt for entering the pincode, and the link key is saved
on the Linux system. The purpose of the system is a tcp/ip transmission
from the Linux system via GSM/GPRS. On the Linux system, no selection or
entry should be necessary, the ppp over rfcomm connection should come up
automatically or by pressing a button.

Regards,
Erwin




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
