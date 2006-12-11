Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 11 Dec 2006 16:53:36 +0800
From: amateur <ztl.post@gmail.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20061211085336.GA6065@163.com>
References: <op.tkcfqvl6ciev1l@localhost>
MIME-Version: 1.0
In-Reply-To: <op.tkcfqvl6ciev1l@localhost>
Subject: Re: [Bluez-devel] pand: permission denied(13) ?
Reply-To: amateur <ztl.post@gmail.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Sun, Dec 10, 2006 at 03:31:33PM +0300, Exe wrote:
> Hello, peoples, have a nice day.
> 
> After one boot to the windoze I didn't able to connect my laptop to the  
> router via pand.
> 
> This messages was appeared in log:
> 
>   Dec 10 14:51:30 exelap hcid[19256]: Bluetooth HCI daemon
> Dec 10 14:51:30 exelap hcid[19256]: Starting security manager 0
> Dec 10 14:51:52 exelap pand[19263]: Bluetooth PAN daemon version 2.25
> Dec 10 14:51:52 exelap pand[19263]: Connecting to 00:10:60:A3:CA:6F
> Dec 10 14:51:55 exelap hci_acldata_packet: hci0 ACL packet for unknown  
> connection handle 11
> Dec 10 14:51:56 exelap hci_acldata_packet: hci0 ACL packet for unknown  
> connection handle 11
> Dec 10 14:51:56 exelap hci_acldata_packet: hci0 ACL packet for unknown  
> connection handle 11
> Dec 10 14:51:56 exelap hcid[19256]: link_key_request  
> (sba=00:16:CE:DF:1F:54, dba=00:10:60:A3:CA:6F)
> Dec 10 14:51:56 exelap pand[19263]: Connect to 00:10:60:A3:CA:6F failed.  
> Permission denied(13)
> 
> strace said that connect() returns ENOACCESS.
> 
> Google said nothing appropriate.
> 
> The problem was solved by deletion of /var/lib/bluetooth/00:16:CE:DF:1F:54
> 
> I don't understand what's went wrong, please explain me.
Would you please give us the output of 
	hcidump -X -V
when you commit those actions ?
That may could help.

-- 
Your motives for doing whatever good deed you may have in mind will be
misinterpreted by somebody.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
