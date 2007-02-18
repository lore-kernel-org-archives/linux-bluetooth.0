Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1171810891.14328.15.camel@armageddon>
References: <1171810891.14328.15.camel@armageddon>
Date: Sun, 18 Feb 2007 17:59:45 +0100
Message-Id: <1171817985.2488.8.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] pand + dev-up
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Torsten,

> im connecting my SE M600i using pand. The commands are:
> 
> pand -c bt_addr -r NAP -d PANU
> ifconfig bnep0 ip_for_bnep
> 
> That works so far.
> 
> Now i would like to automate the ifconfig. In the man page there are to
> possibilities to do that. First with the -u option, second by
> using /etc/bluetooth/pan/dev-up. Both seem not to work.
> 
> 1.) If I try the first possibility, with:
> pand -c bt_addr -r NAP -d PANU -u /path/script.sh
> ,nothing happens, but the bnep interface is shown by ifconfig -a. So I
> would have to type 
> ifconfig bnep0 ip_for_bnep 
> by hand. It seems the script has not been started, because if I write
> sth like 
> echo foo> tempDat.txt
> the file does not appear too.
> 
> 2.) If I dont use the -u option the same symptoms are showing.
> 
> My script does only contain one line:
> ifconfig bnep0 ip_for_bnep <or> ifconfig $1 ip_for_bnep

I actually never used this functionality of pand. All bnepX devices are
hotplug capable and you can use the network infrastructure of your
distribution to auto-setup them.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
