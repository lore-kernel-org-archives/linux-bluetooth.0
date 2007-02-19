Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <c17fe92b0702191021q51d727b4ga2bd7d7e0abffa4b@mail.gmail.com>
References: <c17fe92b0702191021q51d727b4ga2bd7d7e0abffa4b@mail.gmail.com>
Date: Mon, 19 Feb 2007 19:36:12 +0100
Message-Id: <1171910172.26567.48.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] HCI_MAX_DEV modification
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi Suman,

> Was just going through hci.h to see what are the maximum number of
> bluetooth adapters bluez supported and saw that 
> 
> HCI_MAX_DEV was 16
> 
> can i change this number (increase it) and would i have to rebuild the
> bluez kernel module for the changes to take effect. 

the kernel is not affected by this. It is only a userspace limitation
and the actually the kernel will support as many adapters as you have
memory for.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
