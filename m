Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] setup pairing?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41F5C90D.90401@coriand.com>
References: <41F5C90D.90401@coriand.com>
Content-Type: text/plain
Message-Id: <1106660253.8242.7.camel@pegasus>
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
Date: Tue, 25 Jan 2005 14:37:33 +0100

Hi Franz,

> I'm new in this area and I've a problem with setting up a simple key
> pairing mechanism for bluetooth with BlueZ.
> 
> I'd like to setup a bluetooth connection with tcp/ip between a
> Linux-Watch (kernel 2.4.18) and a Windows XP SP2.
> My problem is, I can access the Windows host only with the help of a key
> pairing, because with  my current windows bluetooth driver it's not
> possible to establish a "unsecure connection" without a keypairs.
> 
> With the Linux-Watch and the Windows computer I can search for devices
> and they find earch other, but the key pairing doesn't work.

show us the output of "hcidump -x" as root while you are trying to
connect.

What kind of Windows driver is this. The Windows XP SP2 Bluetooth stack
allows unpaired connection as long as both devices are not in security
mode 3. What does "hciconfig -a" show you?

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
