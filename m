Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bnep/Broadcast
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41FFAE36.4070400@student.ethz.ch>
References: <41FF8E7E.9000509@student.ethz.ch>
	 <1107267619.9652.31.camel@pegasus>  <41FFA828.9050109@student.ethz.ch>
	 <1107274227.9652.52.camel@pegasus>  <41FFAE36.4070400@student.ethz.ch>
Content-Type: text/plain
Message-Id: <1107275618.9652.59.camel@pegasus>
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
Date: Tue, 01 Feb 2005 17:33:38 +0100

Hi Patrick,

> ...thank you for the answer marce. The reason I ask all this stuff is 
> because I heard in Bluetooth is there is some pico-wide broadcast 
> mechanism called ASB or Active Slave Broadcast and I wondered how this 
> is mapped to Bnep.

there is no mapping. BNEP is point-to-point and then you use TCP/IP on
top of it.

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
