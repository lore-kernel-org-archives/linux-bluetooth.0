Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] USING PAN: PANU(desktop1)
	->NAP(desktop2)->internet
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050203155324.4189.qmail@web26406.mail.ukl.yahoo.com>
References: <20050203155324.4189.qmail@web26406.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1107448986.11944.87.camel@pegasus>
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
Date: Thu, 03 Feb 2005 17:43:06 +0100

Hi,

> I want to develope a Gatway in linux OS (kernel 2.6) I
> have the bluez stack and it work very well.
> 
> I want to use thes PAN profile with a NAP role for my
> GW and PANU for other end users.
> 
> End users want to access to internet via the Gatway
> (AP).
> my acces point is now just a PC with a BT-dongle. This
> PC is connected to internet via a LAN.
> 
> and my end user is another PC with a BT-dongle.
> 
> I tried yesterday to connect themselves via IP with a
> client server connection using aGN role for one and
> PANU for the other. It works funny. 
> 
> So cans you give me the lines of code I have to write
> in each PC.
> if someone had already do that can you give me your
> code on each side.

the PAN howto is quite helpful and the rest is about masquerading and
NAT. There are enough howtos on the internet. The BlueZ PAN provides you
with a virtual network card and it works the same as any network card in
your machine.

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
