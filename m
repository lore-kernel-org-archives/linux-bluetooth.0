Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Chris Spencer <gmane.20.evilspam@spamgourmet.com>
Date: Thu, 21 Sep 2006 21:15:26 -0400
Message-ID: <eevdff$gco$1@sea.gmane.org>
References: <451334F6.2010707@gmail.com>
Mime-Version: 1.0
In-Reply-To: <451334F6.2010707@gmail.com>
Subject: Re: [Bluez-users] Keyboard Device Pairing
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

Chris Spencer wrote:
> I recently bought a Bluetooth keyboard, and the manual says it requires 
> a passkey and pairing in order to be used. I'm a bit new to Bluez, and 
> Bluetooth in general, so how do I pair the keyboard with my PC, set the 
> passkey, and configure X to auto-detect and automatically use it as a 
> keyboard?

I tried hidd, but wasn't able to connect. Is there anything else I can do?

[root@localhost]# hidd --connect 00:0D:3C:40:68:7C
<window popped up asking for a passkey>
Can't get device information: Too many levels of symbolic links
[root@localhost]# hidd --connect 00:0D:3C:40:68:7C
Can't get device information: Function not implemented


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
