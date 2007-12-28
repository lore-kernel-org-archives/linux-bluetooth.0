Return-Path: <cyrus@holtmann.org>
Message-ID: <001001c8498c$bc3491b0$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <359782e70712230600n7077ee15hcab67216b9e7c8b4@mail.gmail.com>
	<1198437472.8050.305.camel@aeonflux>
	<001001c84619$20f716d0$0200a8c0@jester>
	<1198493046.8050.311.camel@aeonflux>
	<000601c84639$c8ef8640$0200a8c0@jester>
	<1198556761.8050.329.camel@aeonflux>
	<003c01c84945$64d21600$0200a8c0@jester>
	<1198869661.4455.21.camel@aeonflux>
Date: Fri, 28 Dec 2007 21:03:37 +0100
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Add 3 HCI commands / concurrent connection setup
	question
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi Marcel,

> the design of AFH is to help _other_ 2.4 GHz radios to survive while
> Bluetooth is active in the same area. It is not meant to protect it
> against its own technology. The basics behind AFH is too play nice with
> WiFi networks in the same area. That's it.

I have found an interesting article about this (for people who find this 
interesting as well !) :

http://www.us.design-reuse.com/articles/5715/adaptive-frequency-hopping-for-reduced-interference-between-bluetooth-and-wireless-lan.html

Sorry to carry on theorically speaking, but in my opinion it's always good 
to understand the underlying techniques ... do you know how AFH is 
implemented by chips ? Is the channel blacklisting "manually" up to the 
developper (software), or is there a built-in blacklisting algorithm 
(hardware) ?

Regards,
Oli 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
