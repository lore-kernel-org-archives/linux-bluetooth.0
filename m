Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple bluetooth keyboard fun...
From: Marcel Holtmann <marcel@holtmann.org>
To: patbert@patbert.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41165ACF.10802@patbert.com>
References: <4115A5E3.8000107@patbert.com> <1091959881.2773.6.camel@pegasus>
	 <411649EB.9020407@patbert.com> <1091980492.2773.33.camel@pegasus>
	 <41165ACF.10802@patbert.com>
Content-Type: text/plain
Message-Id: <1091985064.2773.36.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 08 Aug 2004 19:11:04 +0200

Hi Patrick,

> I have been typing in "0000 enter" and "1234 enter" to see if I can get 
> anything to work but no dice. I didn't have to do this on my old machine 
> though, or is it something you have to do just once and I've since 
> forgotten having to do it?
> 
> I uninstalled 2.7 before installing 2.9. I did save the init script 
> though and I am still using it... you can view it here:
> 
> http://www.gentoo.org/cgi-bin/viewcvs.cgi/*checkout*/net-wireless/bluez-utils/files/bluetooth.rc?rev=HEAD&content-type=text/plain
> 
> Anyhow...when I start the script and then do hidd --connect 
> 00:0A:95:3A:63:E4 I just get the connection timed out error after a few 
> moments. hcidump says:
> 
> HCIDump - HCI packet analyzer ver 1.10
> device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
>  > HCI Event: Connect Complete (0x03) plen 11
>    10 29 00 E4 63 3A 95 0A 00 01 00
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>    E4 63 3A 95 0A 00 18 CC 02 00 00 00 01
>  > HCI Event: Command Status (0x0f) plen 4
>    00 01 05 04
>  > HCI Event: Link Key Request (0x17) plen 6
>    E4 63 3A 95 0A 00
>  > HCI Event: Connect Complete (0x03) plen 11
>    10 29 00 E4 63 3A 95 0A 00 01 00

this actually means that hcid is not running. Check your logfiles.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
