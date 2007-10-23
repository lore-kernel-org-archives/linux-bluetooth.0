Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Pierre Savary" <pierre.savary@kerlink.fr>
To: <bluez-users@lists.sourceforge.net>,
        "BlueZ-Dev" <bluez-devel@lists.sourceforge.net>
Date: Tue, 23 Oct 2007 11:54:27 +0200
Message-ID: <005201c8155a$b4247ff0$1c6d7fd0$@savary@kerlink.fr>
MIME-Version: 1.0
Subject: [Bluez-users] ISCAN drop automically ...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net
List-ID: <bluez-devel.lists.sourceforge.net>

Hi all,

I have a problem with the hci configuration of my device. On hcid.conf I
have "iscan enable" but ISCAN flag drop automatically after some timeout
...??? Why? It is the same thing when I make " $ hciconfig hci0 iscan" on
the console.
I don't know if it's important but I use a CSR BC6 chip with 3.15 utils and
libs.

Thanks in advance,
Regards,

Pierre



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
