Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <0E311DCB642C421AA676D962192631BB@iMe>
References: <ee63ef30709161045u6e91123fj39996e9797c8f039@mail.gmail.com>
	<0E311DCB642C421AA676D962192631BB@iMe>
Date: Tue, 18 Sep 2007 06:59:06 +0200
Message-Id: <1190091546.5525.111.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Urgent: HCI and LMP are missing!
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

Hi,

> I would like to know where can I find the HCI and LMP implementation in 
> BlueZ!
> I tried to look in the source code for BlueZ, and only higher levels are 
> present. I couldn't find any packet headers/playload, LMP messages (like 
> Host_Connection_Req) or other low level Bluetooth implementation codes in 
> there.
> I think it's part of the kernel.. but I couldn't find any .. can u help me 
> please..?

the LMP is part of the Bluetooth chip. We don't have to implement that
inside the kernel.

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
