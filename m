Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Michal Sojka x <wentasah@centrum.cz>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <200603110927.23055.wentasah@centrum.cz>
Content-Type: text/plain;
  charset="us-ascii"
Subject: [Bluez-devel] hci_for_each_dev() return value?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 11 Mar 2006 09:27:23 +0100

Hello all,

I'm writing a simple application that uses HCI layer for communication. I have 
a question on what is the meaning of return value of hci_for_each_dev()? It 
seems to me that there is a bug, because even when everything goes well, then 
the return value is -1 and errno is set to ENODEV.

Please CC me when replying. I'm not subscribed to the list.

Regards
Michal Sojka


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
