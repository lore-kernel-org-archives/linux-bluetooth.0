Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm question 1
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050128140602.29279.qmail@web60907.mail.yahoo.com>
References: <20050128140602.29279.qmail@web60907.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1106933775.9644.0.camel@pegasus>
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
Date: Fri, 28 Jan 2005 18:36:15 +0100

Hi Michael,

> I'm doing a project using bluetooth. But I have something to ask.
> Now, I make the connection between Linux PC and Sony Ericsson T610 by
> typing "rfcomm connect 0 <adress>", and it was success. Then, I wish
> to make the connection in this way: let T610 be the client and PC be
> the server. When T610 searched the PC, I wish to connect them by
> selecting the PC in the mobile. But when I entered the PIN, the mobile
> always showed "PIN not match". Why is that? And how can I do so that
> the connection can be created by mobile phone?

do you have hcid running? What does "hcidump -x" as root shows when you
connect from the mobile phone?

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
