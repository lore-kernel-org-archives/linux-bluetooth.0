Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Piconet problems
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <IAMHAF$6F3EDB7D5CA418646EBF9DB16603762A@libero.it>
References: <IAMHAF$6F3EDB7D5CA418646EBF9DB16603762A@libero.it>
Content-Type: text/plain
Message-Id: <1106268153.7955.43.camel@pegasus>
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
Date: Fri, 21 Jan 2005 01:42:33 +0100

Hi Jers,

> At the moment, my dongles seem to work better. I tried again 
> to create a piconet (1 master,2 slaves) but I got the same problem of the early stage, i.e.,
> I can only create the first connection and interface bnep.
> Unlike before, now hcidump works and we can see the packets.

you run into a page timeout (error code 0x04) with your second
connection. Why don't you use hcid? It will bring up your devices with
the correct settings. Make sure that the device with the newest firmware
is your desired master device.

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
