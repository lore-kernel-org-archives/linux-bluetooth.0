Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <E1GwSh8-0003Te-Sf@mail.sourceforge.net>
References: <E1GwSh8-0003Te-Sf@mail.sourceforge.net>
Date: Tue, 19 Dec 2006 10:41:12 +0100
Message-Id: <1166521272.29972.6.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Wireless devices
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

Hi,

> I am using a wireless bluetooth mouse and keyboard. I have to use the command
> & hidd --connect xx.xx.xx.xx
> 
> To get each to connect and work. Once connected they work great. The issue is when they are idle for more then 30 minutes or so. They go to sleep to save the batteries and loose the connection. And I have to issue the command above again. Is this just a confgiure error for them not to be auto connected or is it that they are not peiring correctly? I'm lost with what todo.

they should try to reconnect once you press a key or move the mouse.
Check with "hcidump -X -V" what's happening in that case. However to
make Linux accept this incoming connection "hidd --server" must be
running first.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
