Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Le Pogam <olepogam@free.fr>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001001c84619$20f716d0$0200a8c0@jester>
References: <359782e70712230600n7077ee15hcab67216b9e7c8b4@mail.gmail.com>
	<1198437472.8050.305.camel@aeonflux>
	<001001c84619$20f716d0$0200a8c0@jester>
Date: Mon, 24 Dec 2007 11:44:06 +0100
Message-Id: <1198493046.8050.311.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Add 3 HCI commands
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Olivier,

> I'd like to add : Set_AFH_Host_Channel_Classification (OCF 0x003F), 
> Read_AFH_Channel_Assessment_Mode (OCF 0x0048) and 
> Write_AFH_Channel_Assessment_Mode (OCF 0x0049) to the supported HCI commands 
> (and yes, Marcel, I've read the bluetooth specs, but ... not sure at all 
> I've got everything ! ).
> As I'd like to do things properly, could someone please indicate me who is 
> the best contact for guidelines ? I suppose this should be added to the 
> kernel part (/net/bluetooth/) but I definitively need someone to guide me.

what do you wanna do with these commands? More important is, what do you
expect what is gonna happen if you use them?

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
