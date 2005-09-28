Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzus@bedatec.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problem with bluetooth sound... working but not working
Message-ID: <20050928222115.GA5135@uni-duesseldorf.de>
References: <433AD61D.1050307@cyberserver.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <433AD61D.1050307@cyberserver.dk>
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
Date: Thu, 29 Sep 2005 00:21:15 +0200

Preben Holm <preben@cyberserver.dk> wrote:
> Output from  hciconfig hci0 revision
> -------------
> laptop preben # hciconfig hci0 revision
> hci0:   Type: USB
>        BD Address: 00:0E:A1:33:94:FE ACL MTU: 377:10 SCO MTU: 16:0
>        Firmware 263.3 / 9
> Similar configurations (headset+dongle) works on windows-computers, but 
> why isn't there a SCO: HCI/PCM in the hciconfig hci0 revision output.

Because this chip is not supported for SCO under linux. 

> I would really like this to work...

Get a CSR based chip. Did that here, too.


CU, Andy


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
