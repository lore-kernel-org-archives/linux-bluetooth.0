Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm question 2-AT command
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050128141322.96979.qmail@web60904.mail.yahoo.com>
References: <20050128141322.96979.qmail@web60904.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1106940245.10580.2.camel@pegasus>
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
Date: Fri, 28 Jan 2005 20:24:05 +0100

Hi Michael,

> I have written a program that the menu can be sent to T610 by AT
> command. However, I face a problem. When I send one menu to the
> mobile, there is 4-5 seconds delay. The syntax of my program is:
> sprintf(command, "AT*EASM=\"Bt-IrConverter\",1,1,%d", item_brand+1);
>   ret_code=put_command (command, answer, sizeof (answer), 5, 0);
>   for (j=0; j<item_brand; j++)
>   {
>    sprintf(command, ",\"%s\"", device[j]);
>    ret_code=put_command (command, answer, sizeof (answer), 5, 0);
>    }
>   sprintf(command, ",\"quit\",\r");
> where the variable device[j] stores the string extracted from MySQL
> db. So, why is that? And how can I reduce the delay?

check with hcidump if there is really a delay or if the phone simply
needs that long to execute that command.

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
