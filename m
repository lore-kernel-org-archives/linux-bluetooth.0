Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <690118.53390.qm@web32905.mail.mud.yahoo.com>
References: <690118.53390.qm@web32905.mail.mud.yahoo.com>
Date: Tue, 11 Sep 2007 01:42:11 +0200
Message-Id: <1189467731.7893.10.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] BlueZ API documentation
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
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

Hi Brown,

> Not problem. I think I should get used to the src code. 
>  
> One quick question though (just to get around what I'm currently stuck
> with)
>  
> I want to programatically control the disovery status of my local BT
> device.
> Meaning - my program should be able to set the BT device status so
> that other device cannot "see" it.
>  
> I noticed these in hci.h
>  
> #define OCF_WRITE_SCAN_ENABLE       0x001A
>     #define SCAN_DISABLED       0x00
>     #define SCAN_INQUIRY        0x01
>     #define SCAN_PAGE       0x02
> 
>  
> But I am not sure what API's should be used and how.

if you wanna mess around with the HCI directly then you are on your own.
Why don't you use the nice D-Bus API we have. I gives you everything you
need and takes care of all the minor details you don't even wanna know
about.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
