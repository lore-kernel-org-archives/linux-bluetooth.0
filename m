Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Bearcat@feline-soul.com, BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200608031855.50972.Bearcat@feline-soul.com>
References: <200608031855.50972.Bearcat@feline-soul.com>
Date: Fri, 04 Aug 2006 12:09:43 +0200
Message-Id: <1154686183.3905.84.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] error when starting bluetooth..any ideas?
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

Hi Bearcat,

> I'm still working on connecting this keyboard and headset. However i noticed 
> something in my logs that is probably pertainent:
> Aug  3 18:42:53 [sdpd] Bluetooth SDP daemon_
> Aug  3 18:43:59 [hcid] Bluetooth HCI daemon
> Aug  3 18:43:59 [hcid] Register path:/org/bluez fallback:1
> Aug  3 18:43:59 [hcid] Device hci0 has been added
> Aug  3 18:43:59 [hcid] Starting security manager 0
> Aug  3 18:43:59 [hcid] Can't write inquiry mode for hci0: Input/output error 
> (5)
> Aug  3 18:43:59 [hcid] Register path:/org/bluez/hci0 fallback:0
> Aug  3 18:44:38 [hidd] Bluetooth HID daemon
> 
> Note the [hcid} lines seem to have an error. I have looked all over google and 
> the bluetooth mailing lists and not found anything regarding it.

looks like some chips get confused when trying to set the inquiry mode
and they don't support this command. It has been fixed in the CVS now.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
